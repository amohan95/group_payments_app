<?php
require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/functions.php';

function getFacebookCookie() {
  $app_id = 'facebook_app_id';
  $application_secret = 'facebook_app_secret';
  if (isset($_COOKIE['fbsr_' . $app_id])) {
    list($encoded_sig, $payload) = explode('.', $_COOKIE['fbsr_' . $app_id], 2);
    $sig = base64_decode(strtr($encoded_sig, '-_', '+/'));
    $data = json_decode(base64_decode(strtr($payload, '-_', '+/')), true);
    if (strtoupper($data['algorithm']) !== 'HMAC-SHA256') {
      return null;
    }
    $expected_sig = hash_hmac('sha256', $payload, $application_secret,
      $raw = true);
    if ($sig !== $expected_sig) {
      return null;
    }
    $token_url = "https://graph.facebook.com/oauth/access_token?client_id="
      . $app_id . "&client_secret=" . $application_secret. "&redirect_uri="
      . "&code=" . $data['code'];
 
    $response = @file_get_contents($token_url);
    $params = null;
    parse_str($response, $params);
    $data['access_token'] = $params['access_token'];
    echo $params;
    return $data;
  } else{
    return null;
  }
}

$user = getUser(getFacebookCookie());

$app = new \Slim\Slim();

$app->post('/groups/', function() {
  json_decode($app->request);
  CreateGroup($app->request->id, $app->request->group_name, $app->request->group_members);
  return json_encode(array(
    'success' => true
  ));
});

$app->get('/groups/:id', function($id) {
  return json_encode(array(
    'groups' => GetGroups($id)->fetchArray()
  ));
});

$app->put('/groups/:id', function($id) {
  json_decode($app->request);
  AlterGroup($id, $group_id, $app->request->removals, $app->request->additions);
  return json_encode(array(
    'success' => true
  ));
});

$app->delete('/groups/:id', function($id) {
  return json_encode(array(
    'success' => true
  ))
});

$app->get('/groups/:id/transactions', function($id) {

});

$app->post('/transactions/', function() {
  return json_encode(array(
    'group_transaction' => createTransaction($user,
      $app->request->params('group_id'),
      $app->request->params('description'),
      json_decode($app->request->params('transaction_map')))
    ));
});

$app->put('/transactions/:id', function($id) {
  return json_encode(array(
    'group_transaction' => editTransaction($user, $id,
      $app->request->params('description'),
      json_decode($app->request->params('transaction_map')))
  ));
});

$app->delete('/transaction/:id', function($id) {
  return json_encode(array(
    'success' => deleteTransaction($user, $id)
  ));
});

$app->get('/users/:id/transactions', function($id) {
  return json_encode(array(
    'user_transactions' => getUserTransactionsWith($user, $id)
  ));
});

$app->run();
?>
