<?php
$config = include __DIR__ . '/config.php';
$allowedOrigins = [$config['FRONTEND_URL']];

if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowedOrigins)) {
    header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
}
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

session_name('PHPSESSID');
ini_set('session.cookie_path', '/');
ini_set('session.cookie_domain', 'localhost');
session_start();

$response = [];

if (isset($_SESSION['sess_iauop_user_id'])) {
    $response = [
        'success' => true,
        'user_id' => $_SESSION['sess_iauop_user_id'],
        'username' => $_SESSION['sess_iauop_username'] ?? '',
        'name' => $_SESSION['sess_iauop_name'] ?? '',
        'surname' => $_SESSION['sess_iauop_surname'] ?? '', // ✅ แก้ตรงนี้
        'user_group_id' => $_SESSION['sess_iauop_user_group_id'] ?? null,
        'photo' => $_SESSION['sess_iauop_person_photo'] ?? null,
        'faculty_name' => $_SESSION['sess_iauop_faculty_name'] ?? '',
        'department_name' => $_SESSION['sess_iauop_department_name'] ?? '',
    ];
} else {
    $response = [
        'success' => false,
        'message' => 'No active session',
    ];
}

echo json_encode($response);
?>
