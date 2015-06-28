<?php
require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/functions.php';

$app = new \Slim\Slim();

$app->post('/groups/', function() {
  
});

$app->get('/groups/:id', function($id) {
  return json_encode(array(GetGroups($id)));
});

$app->put('/groups/:id', function($id) {
});

$app->delete('/groups/:id', function($id) {
});

$app->get('/groups/:id/transactions', function($id) {
});

$app->post('/transactions/', function() {
});

$app->put('/transactions/:id', function($id) {
});

$app->delete('/transaction/:id', function($id) {
});

$app->get('/users/:id/transactions', function($id) {
});

$app->run();
?>
