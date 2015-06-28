<?php
function GetGroups($id) {
  $db = new SQLite3('development.sqlite3');
  $stmt = $db->prepare('SELECT * FROM (SELECT * FROM
    groups JOIN user_transactions ON groups.id = user_transactions.group_transaction_id) AS tmp
    WHERE tmp.id=:id');
  $stmt->bindValue(':id', $id, SQLITE3_TEXT);
  return $stmt->execute();
}
?>