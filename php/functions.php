<?php
function GetGroups($id) {
  $db = new SQLite3('development.sqlite3');
  $stmt = $db->prepare('SELECT * FROM (SELECT * FROM
    groups JOIN user_transactions ON groups.id = user_transactions.group_transaction_id) AS tmp
    WHERE tmp.id=:id');
  $stmt->bindValue(':id', $id, SQLITE3_TEXT);
  return $stmt->execute();
}






function createTransaction($user, $group_id, $purpose, $transaction_map) {
  $db = new SQLite3('development.sqlite3');
  $stmt = $db->prepare('INSERT INTO group_transactions (user_id, group_id,
    purpose) VALUES (:user_id, :group_id, :purpose);');
  $stmt->bindValue('user_id', $user['id'], SQLITE3_INTEGER);
  $stmt->bindValue('group_id', $group_id, SQLITE3_INTEGER);
  $stmt->bindValue('purpose', $purpose, SQLITE3_TEXT);
  $result = $stmt->execute();
  if ($result) {
    $group_transaction_id = $db->lastInsertRowID();
    foreach ($transaction_map as $user_id => $amount) {
      $stmt = $db->prepare('INSERT INTO user_transactions (user_id,
        other_user_id, group_transaction_id, amount VALUES (:user_id,
        :other_user_id, :group_transaction_id, :amount);');
      $stmt->bindValue('user_id', $user['id'], SQLITE3_INTEGER);
      $stmt->bindValue('other_user_id', $user_id, SQLITE3_INTEGER);
      $stmt->bindValue('group_transaction_id', $group_transaction_id,
        SQLITE3_INTEGER);
      $stmt->bindValue('amount', $amount, SQLITE3_INTEGER);
      $result = $stmt->execute();
      if (!$result) {
        return null;
      }
    }
    return array(
      'user_id' => $user['id'],
      'group_id' => $group_id,
      'purpose' => $purpose
    );
  } else {
    return null;
  }
}

function editTransaction($user, $transaction_id, $transaction_id) {
}

function deleteTransaction($user, $transaction_id) {
}

function getUserTransactionsWith($user, $other_user_id) {
  $query = $other_user_id ? 
    'SELECT * FROM user_transactions WHERE user_id = :user_id AND
      other_user_id = :other_user_id OR user_id = :other_user_id
      AND other_user_id = :user_id' :
    'SELECT * FROM user_transactions WHERE user_id = :user_id OR
      other_user_id = :user_id';
  $db = new SQLite3('development.sqlite3');
  $stmt = $db->prepare($query);
  $stmt->bindValue('user_id', $user['id'], SQLITE3_INTEGER);
  if ($other_user_id) {
    $stmt->bindValue('other_user_id', $other_user_id, SQLITE3_INTEGER);
  }
  $result = $stmt->execute();
  if ($result) {
    $res_arr = array();
    while ($row = $result->fetchArray()) {
      array_push($resarr, $row);
    }
    return $res_arr;
  } else {
    return null;
  }

}

function getUser($facebook_hash) {
  $db = new SQLite3('development.sqlite3');
  $stmt = $db->prepare('SELECT * FROM users WHERE fb_user_id = :fb_id;');
  $stmt->bindValue('
}
?>
