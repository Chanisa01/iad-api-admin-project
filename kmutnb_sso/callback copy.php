<?php
session_start();
header("Content-Type: application/json");
require_once '../db_connect.php';
require_once 'SSOClient.php';

$sso = new SSOClient();

if (isset($_GET['error'])) {
    echo json_encode([
        "success" => false,
        "message" => $_GET['error'] . ': ' . ($_GET['error_description'] ?? 'ไม่ทราบสาเหตุ')
    ]);
    exit;
}

if (!isset($_GET['code']) || !isset($_GET['state'])) {
    echo json_encode([
        "success" => false,
        "message" => "Missing code or state"
    ]);
    exit;
}

try {
    $token = $sso->handleCallback($_GET['code'], $_GET['state']);
    $userInfo = $sso->getUserInfo();

    if (!$userInfo || !isset($userInfo['username'])) {
        echo json_encode([
            "success" => false,
            "message" => "ไม่พบข้อมูลผู้ใช้จาก SSO"
        ]);
        echo "<script>console.log(" . json_encode($userInfo, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . ");</script>";

        exit;
    }

    $username = $userInfo['username'];

    $stmt = $conn->prepare("SELECT * FROM users WHERE icit_username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if (!$user) {
        // เพิ่มผู้ใช้ใหม่ (ไม่มีสิทธิ์)
        $insert = $conn->prepare("INSERT INTO users (icit_username, name, surname, prename, department_name, faculty_name, person_photo, user_group_id, is_active)
                                  VALUES (?, ?, ?, ?, ?, ?, ?, 3, 1)");
        $insert->bind_param("sssssss",
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
        // อัปเดตข้อมูลผู้ใช้
        $user_id = $user['id'];
        $user_group_id = $user['user_group_id'];

        $update = $conn->prepare("UPDATE users SET name=?, surname=?, prename=?, department_name=?, faculty_name=?, person_photo=?, last_login=NOW() WHERE id=?");
        $update->bind_param("ssssssi",
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

    // ❌ ไม่มีสิทธิ์เข้าใช้งาน
    if ($user_group_id == 3) {
        header("Location: http://localhost:3000/login?unauthorized=1");
        exit;
    }

    // ✅ สร้าง session
    $_SESSION['sess_iauop_user_id'] = $user_id;
    $_SESSION['sess_iauop_name'] = $userInfo['name'];
    $_SESSION['sess_iauop_lastname'] = $userInfo['surname'];
    $_SESSION['sess_iauop_user_group_id'] = $user_group_id;
    $_SESSION['sess_iauop_user_photo'] = $userInfo['person_photo'];

    // ✅ redirect ไป React
    header("Location: http://localhost:3000/login-success");
    exit;

} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "message" => "เกิดข้อผิดพลาด: " . $e->getMessage()
    ]);
    exit;
}
