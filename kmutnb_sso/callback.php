<?php
if (session_status() === PHP_SESSION_NONE) {
    session_name('PHPSESSID');
    ini_set('session.cookie_path', '/');
    ini_set('session.cookie_domain', 'iau.op.kmutnb.ac.th');
    session_start();
}

// เปิด error reporting
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include 'kmutnbsso.php';
include __DIR__ . "/../db_connect.php";
$config = include __DIR__ . '/config.php';

// ✅ กำหนด frontend redirect URL ที่ถูกต้อง
$frontend_redirect = $config['FRONTEND_URL'] . '/login-success';

try {
    // ✅ ตรวจสอบ error จาก SSO ก่อน
    if (isset($_GET['error'])) {
        $error = $_GET['error'];
        $error_description = $_GET['error_description'] ?? '';
        
        if ($error === "access_denied") {
            header("Location: {$frontend_redirect}?action=notallow");
            exit;
        } else {
            header("Location: {$frontend_redirect}?error=" . urlencode($error));
            exit;
        }
    }

    // ✅ ตรวจสอบ code
    if (!isset($_GET['code'])) {
        header("Location: {$frontend_redirect}?error=missing_code");
        exit;
    }

    // ✅ เรียกใช้งาน SSO
    $auth = new kmutnbsso();
    $userDetails = $auth->handleCallback();

    // ✅ บันทึก log เพื่อ debug
    file_put_contents(__DIR__ . '/debug_userdetails.log', date('Y-m-d H:i:s') . " - " . print_r($userDetails, true) . "\n", FILE_APPEND);

    // ✅ ตรวจสอบข้อมูลที่จำเป็น
    if (!$userDetails || !isset($userDetails['profile']['username'])) {
        header("Location: {$frontend_redirect}?error=userinfo_missing");
        exit;
    }

    // ✅ ดึงข้อมูลจาก profile
    $username = $userDetails['profile']['username'];
    $displayName = $userDetails['profile']['display_name'] ?? '';
    $nameEnFull = $userDetails['profile']['name_en'] ?? '';
    $accountType = $userDetails['profile']['account_type'] ?? '';

    // ✅ แยกชื่อ-นามสกุลไทย
    $splitName = explode(' ', trim($displayName));
    $name = $splitName[0] ?? '';
    $surname = isset($splitName[1]) ? implode(' ', array_slice($splitName, 1)) : '';

    // ✅ แยกชื่อ-นามสกุลอังกฤษ
    $splitNameEn = explode(' ', trim($nameEnFull));
    $name_en = $splitNameEn[0] ?? '';
    $surname_en = isset($splitNameEn[1]) ? implode(' ', array_slice($splitNameEn, 1)) : '';

    // ✅ ตรวจสอบผู้ใช้งานในระบบ
    $sql = "SELECT * FROM users WHERE icit_username = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();

        // ✅ ตรวจสอบสิทธิ์ก่อนเก็บ session
        if ((int)$user["user_group_id"] === 3) {
            header("Location: {$frontend_redirect}?unauthorized=1");
            exit;
        }

        // ✅ เก็บ session
        $_SESSION['sess_iauop_user_id'] = $user["id"];
        $_SESSION['sess_iauop_username'] = $username;
        $_SESSION['sess_iauop_name'] = $name;
        $_SESSION['sess_iauop_surname'] = $surname;
        $_SESSION['sess_iauop_name_en'] = $name_en;
        $_SESSION['sess_iauop_surname_en'] = $surname_en;
        $_SESSION['sess_iauop_user_group_id'] = $user["user_group_id"];

        // ✅ อัปเดตข้อมูลล่าสุด
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

        // ✅ เข้าสู่ระบบสำเร็จ
        $token = session_id();
        $_SESSION['sso_token'] = $token;
        header("Location: {$frontend_redirect}?token=" . urlencode($token));
        exit;
    } else {
        // ❌ ไม่พบผู้ใช้งานในระบบ
        header("Location: {$frontend_redirect}?unauthorized=2");
        exit;
    }

} catch (Exception $e) {
    // ✅ จัดการ error อย่างเหมาะสม
    error_log("SSO Callback Error: " . $e->getMessage());
    header("Location: {$frontend_redirect}?error=" . urlencode($e->getMessage()));
    exit;
}
?>