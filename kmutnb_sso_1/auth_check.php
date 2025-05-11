<?php
session_start();
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

if (!isset($_SESSION['sess_iauop_user_id'])) {
    echo json_encode(["success" => false, "message" => "Not logged in"]);
    exit;
}

echo json_encode([
    "success" => true,
    "user" => [
        "id" => $_SESSION['sess_iauop_user_id'],
        "name" => $_SESSION['sess_iauop_name'],
        "surname" => $_SESSION['sess_iauop_lastname'],
        "group" => $_SESSION['sess_iauop_user_group_id'],
        "photo" => $_SESSION['sess_iauop_user_photo'] ?? null,
    ]
]);
?>