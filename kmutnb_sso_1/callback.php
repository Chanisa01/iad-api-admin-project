<?php
session_start();
require_once '../db_connect.php';      // เชื่อมต่อฐานข้อมูล
require_once 'SSOClient.php';          // โหลดคลาส SSO

$sso = new SSOClient();

// กรณีเกิด error จากฝั่ง SSO
if (isset($_GET['error'])) {
    die($_GET['error'] . ': ' . ($_GET['error_description'] ?? 'ไม่ทราบสาเหตุ'));
}

// ตรวจสอบ code และ state
if (!isset($_GET['code']) || !isset($_GET['state'])) {
    die('Missing code or state');
}

// ตรวจสอบ state ว่าตรงกับ session หรือไม่ (ป้องกัน CSRF)
if (!isset($_SESSION['sso_state']) || $_GET['state'] !== $_SESSION['sso_state']) {
    die('Invalid state parameter');
}
unset($_SESSION['sso_state']); // ใช้แล้วลบทิ้งเพื่อความปลอดภัย

try {
    // ขอ token และ user info จาก SSO
    $token = $sso->handleCallback($_GET['code'], $_GET['state']);
    $userInfo = $sso->getUserInfo();

    if (!$userInfo) {
        die('ไม่สามารถดึงข้อมูลผู้ใช้จาก SSO ได้');
    }

    $username = $userInfo['username'] ?? null;

    if (!$username) {
        die('ไม่มี username ในข้อมูลผู้ใช้');
    }

    // ค้นหา user จากฐานข้อมูล
    $stmt = $conn->prepare("SELECT * FROM users WHERE icit_username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if (!$user) {
        // ยังไม่มีในระบบ → เพิ่มใหม่
        $insert = $conn->prepare("INSERT INTO users (icit_username, name, surname, prename, department_name, faculty_name, person_photo, user_group_id, is_active)
                                  VALUES (?, ?, ?, ?, ?, ?, ?, 3, 1)");
        $insert->bind_param(
            "sssssss",
            $userInfo['username'],
            $userInfo['name'],
            $userInfo['surname'],
            $userInfo['prename'],
            $userInfo['department_name'],
            $userInfo['faculty_name'],
            $userInfo['person_photo']
        );
        $insert->execute();
        $user_id = $insert->insert_id;
        $user_group_id = 3;
    } else {
        // อัปเดตข้อมูลจาก icit
        $user_id = $user['id'];
        $user_group_id = $user['user_group_id'];

        $update = $conn->prepare("UPDATE users SET name=?, surname=?, prename=?, department_name=?, faculty_name=?, person_photo=?, last_login=NOW() WHERE id=?");
        $update->bind_param(
            "ssssssi",
            $userInfo['name'],
            $userInfo['surname'],
            $userInfo['prename'],
            $userInfo['department_name'],
            $userInfo['faculty_name'],
            $userInfo['person_photo'],
            $user_id
        );
        $update->execute();
    }

    // ถ้าไม่มีสิทธิ์เข้า → redirect กลับ login พร้อม alert
    if ($user_group_id == 3) {
        header("Location: http://localhost:3000/login?unauthorized=1");
        exit;
    }

    // ✅ เก็บ session
    $_SESSION['sess_iauop_user_id'] = $user_id;
    $_SESSION['sess_iauop_name'] = $userInfo['name'];
    $_SESSION['sess_iauop_lastname'] = $userInfo['surname'];
    $_SESSION['sess_iauop_user_group_id'] = $user_group_id;
    $_SESSION['sess_iauop_user_photo'] = $userInfo['person_photo'];

    // ✅ redirect กลับ React
    header("Location: http://localhost:3000/login-success");
    exit;

} catch (Exception $e) {
    die("เกิดข้อผิดพลาดในการประมวลผล: " . $e->getMessage());
}
