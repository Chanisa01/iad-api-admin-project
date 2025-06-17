<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
$config = include __DIR__ . '/config_cors.php';
$allowedOrigins = $config['ALLOWED_ORIGINS'];

$origin = $_SERVER['HTTP_ORIGIN'] ?? '';

if (in_array(rtrim($origin, '/'), $allowedOrigins)) {
    header("Access-Control-Allow-Origin: $origin");
}

header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

// ✔️ ตอบ OPTIONS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// ✔️ Start session หลัง preflight
session_name('PHPSESSID');
session_start();

include 'db_connect.php';

$targetDir = "img/banner/";
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $sql = "SELECT * FROM users";
    $result = $conn->query($sql);

    if ($result) {
        $rows = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(["success" => true, "usersData" => $rows ?: []]);
    } else {
        echo json_encode(["success" => false, "message" => "เกิดข้อผิดพลาดในการดึงข้อมูล", "error" => $conn->error]);
    }
}

if ($method === 'POST') {
    $action = $_POST['action'] ?? '';
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }
    $updated_by = $_SESSION['sess_iauop_user_id'];

    if ($action === 'update_user_group') {
        $id = $_POST['id'] ?? null;
        $user_group_id = $_POST['user_group_id'] ?? null;
        $updated_by = $_SESSION['sess_iauop_user_id'] ?? null;

        if ($id && $user_group_id && $updated_by) {
            $stmt = $conn->prepare("UPDATE users SET user_group_id = ?, updated_at = NOW(), updated_by = ? WHERE id = ?");
            $stmt->bind_param("iii", $user_group_id, $updated_by, $id);
            if ($stmt->execute()) {
                echo json_encode(["success" => true]);
            } else {
                echo json_encode(["success" => false, "message" => "อัปเดตไม่สำเร็จ"]);
            }
        } else {
            echo json_encode(["success" => false, "message" => "Missing data"]);
        }
        exit;
    }

    if ($action === 'insert') {
        $icit_username = $_POST['icit_username'] ?? null;
        $name = $_POST['name'] ?? null;
        $surname = $_POST['surname'] ?? null;
        $user_group_id = $_POST['user_group_id'] ?? 3; // default = no authorize
        $created_by = $_SESSION['sess_iauop_user_id'] ?? null;
        $created_at = date('Y-m-d H:i:s');

        if (!$icit_username || !$name || !$surname || !$user_group_id || !$created_by) {
            echo json_encode(["success" => false, "message" => "ข้อมูลไม่ครบถ้วน"]);
            exit;
        }

        // ตรวจสอบซ้ำว่ามีผู้ใช้งานนี้อยู่แล้วหรือไม่
        $stmtCheck = $conn->prepare("SELECT id FROM users WHERE icit_username = ?");
        $stmtCheck->bind_param("s", $icit_username);
        $stmtCheck->execute();
        $stmtCheck->store_result();

        if ($stmtCheck->num_rows > 0) {
            echo json_encode([
                "success" => false,
                "message" => "ชื่อผู้ใช้งานนี้มีอยู่แล้วในระบบ",
                "code" => "duplicate_username"
            ]);
            exit;
        }

        $stmt = $conn->prepare("INSERT INTO users 
            (icit_username, name, surname, user_group_id, created_at, created_by)
            VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssisi", $icit_username, $name, $surname, $user_group_id, $created_at, $created_by);

        if ($stmt->execute()) {
            echo json_encode(["success" => true]);
        } else {
            echo json_encode(["success" => false, "message" => "บันทึกข้อมูลไม่สำเร็จ"]);
        }
        exit;
    }

    if ($action === 'delete') {
        $id = $_POST['id'];

        $stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
        $stmt->bind_param("i", $id);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "ลบสำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "ลบไม่สำเร็จ"]);
        }
    }
}
?>