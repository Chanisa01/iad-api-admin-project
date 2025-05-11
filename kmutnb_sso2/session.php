<?php
// ✅ รองรับการเรียกจาก React ที่รันอยู่บน localhost:3000
$allowedOrigins = ['http://localhost:3000'];

if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowedOrigins)) {
    header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
}

header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

// ✅ หากเป็น OPTIONS request (preflight จาก browser) — จบที่นี่
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

session_name('PHPSESSID'); // ✅ เพิ่มก่อน session_start()
ini_set('session.cookie_path', '/');
ini_set('session.cookie_domain', 'localhost');
session_start();
file_put_contents('debug_from_sessionphp.log', "SESSION ID: " . session_id() . "\n" . print_r($_SESSION, true));
// $_SESSION['sess_iauop_user_id'] = 9999;
// $_SESSION['sess_iauop_name'] = 'Test';

$response = [];

if (isset($_SESSION['sess_iauop_user_id'])) {
    $response = [
        'success' => true,
        'user_id' => $_SESSION['sess_iauop_user_id'],
        'username' => $_SESSION['sess_iauop_username'] ?? '',
        'name' => $_SESSION['sess_iauop_name'] ?? '',
        'surname' => $_SESSION['sess_iauop_lastname'] ?? '',
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

// ✅ optional: log สำหรับ debug
file_put_contents('debug_session.log', print_r($_SESSION, true));
file_put_contents('debug_cookie.log', print_r($_COOKIE, true));

echo json_encode($response);
