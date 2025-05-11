<?php
include 'kmutnbsso.php';
include __DIR__ . "/../db_connect.php";  // ← ถ้า db_connect.php อยู่ข้างนอกโฟลเดอร์ kmutnb_sso



ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// ✅ เริ่ม session
session_name('PHPSESSID');
ini_set('session.cookie_path', '/');
ini_set('session.cookie_domain', 'localhost');
session_start();

// ✅ เรียกใช้งาน SSO
$auth = new kmutnbsso();

// ✅ ตรวจสอบ code จาก SSO
if (!isset($_GET['code'])) {
    if (isset($_GET['error']) && $_GET['error'] === "access_denied") {
        header("Location: http://localhost:3000/login?action=notallow");
        http_response_code(302);
        exit;
    }
    header("Location: http://localhost:3000/login?error=missing_code");
    http_response_code(302);
    exit;
}

// ✅ ดึงข้อมูลจาก SSO
$userDetails = $auth->handleCallback();
file_put_contents('debug_userdetails.log', print_r($userDetails, true));

// ❌ ไม่ได้ข้อมูลที่จำเป็น
if (!$userDetails || !isset($userDetails['profile']['username'])) {
    header("Location: http://localhost:3000/login?error=userinfo_missing");
    http_response_code(302);
    exit;
}

// ✅ ดึงข้อมูลจาก profile
$username     = $userDetails['profile']['username'];
$displayName  = $userDetails['profile']['display_name'] ?? '';
$nameEnFull   = $userDetails['profile']['name_en'] ?? '';
$accountType  = $userDetails['profile']['account_type'] ?? '';

// ✅ แยกชื่อ-นามสกุลไทย
$splitName = explode(' ', trim($displayName));
$name = '';
$surname = '';

if (count($splitName) >= 2) {
    [$name, $surname] = $splitName;
} elseif (count($splitName) === 1) {
    $name = $splitName[0];
}

// ✅ แยกชื่อ-นามสกุลอังกฤษ
$splitNameEn = explode(' ', trim($nameEnFull));
$name_en = $splitNameEn[0] ?? '';
$surname_en = $splitNameEn[1] ?? '';

// ✅ ตรวจสอบผู้ใช้งานในระบบ
$sql = "SELECT * FROM users WHERE icit_username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();

    // ✅ เก็บ session
    $_SESSION['sess_iauop_user_id']         = $user["id"];
    $_SESSION['sess_iauop_username']        = $username;
    $_SESSION['sess_iauop_name']            = $name;
    $_SESSION['sess_iauop_surname']         = $surname;
    $_SESSION['sess_iauop_name_en']         = $name_en;
    $_SESSION['sess_iauop_surname_en']      = $surname_en;
    $_SESSION['sess_iauop_user_group_id']   = $user["user_group_id"];

    // ✅ อัปเดตข้อมูลล่าสุด (ไม่มี prename แล้ว)
    $update_sql = "UPDATE users SET 
        name = ?, surname = ?, name_en = ?, surname_en = ?, 
        icit_username = ?, last_login = NOW()
        WHERE id = ?";
    $update_stmt = $conn->prepare($update_sql);
    $update_stmt->bind_param(
        "sssssi",
        $name, $surname, $name_en, $surname_en,
        $username, $user["id"]
    );
    $update_stmt->execute();

    // ✅ ตรวจสอบสิทธิ์
    if ((int)$user["user_group_id"] === 3) {
        header("Location: http://localhost:3000/login?unauthorized=1");
        http_response_code(302);
        exit;
    }

    // ✅ เข้าสู่ระบบสำเร็จ
    header("Location: http://localhost:3000/login-success");
    http_response_code(302);
    exit;
} else {
    // ❌ ไม่พบผู้ใช้งานในระบบ
    header("Location: http://localhost:3000/login?unauthorized=1");
    http_response_code(302);
    exit;
}
?>