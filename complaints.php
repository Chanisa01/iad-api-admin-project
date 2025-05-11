<?php
$allowedOrigins = ['http://localhost:3000'];
if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowedOrigins)) {
    header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
}
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

session_name('PHPSESSID');
session_start();
include 'db_connect.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $statusFilter = $_GET['status'] ?? null;
    $sql = "SELECT * FROM complaints";
    if ($statusFilter) {
        $sql .= " WHERE status = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $statusFilter);
    } else {
        $stmt = $conn->prepare($sql);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    echo json_encode($result->fetch_all(MYSQLI_ASSOC));

} elseif ($method === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $stmt = $conn->prepare("INSERT INTO complaints (name, email, phone, type, details) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $data['name'], $data['email'], $data['phone'], $data['type'], $data['details']);
    $stmt->execute();
    echo json_encode(["success" => true]);

} elseif ($method === 'PUT') {
    parse_str(file_get_contents("php://input"), $data);
    $stmt = $conn->prepare("UPDATE complaints SET status = ? WHERE id = ?");
    $stmt->bind_param("si", $data['status'], $data['id']);
    $stmt->execute();
    echo json_encode(["success" => true]);
}
?>
