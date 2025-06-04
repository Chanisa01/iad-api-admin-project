<?php
include 'db_connect.php';


$sql = "
  SELECT
    COUNT(*) AS all_complaints,
    SUM(status = 'pending') AS pending,
    SUM(status = 'in_progress') AS in_progress,
    SUM(status = 'resolved') AS resolved,
    SUM(status = 'rejected') AS rejected
  FROM complaints
";

$res = mysqli_query($conn, $sql);
$data = mysqli_fetch_assoc($res);

echo json_encode([
  'all' => (int)$data['all_complaints'],
  'pending' => (int)$data['pending'],
  'in_progress' => (int)$data['in_progress'],
  'resolved' => (int)$data['resolved'],
  'rejected' => (int)$data['rejected'],
]);
