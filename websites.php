<?php
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

$targetDir = "img/websites/";
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $sql = "SELECT w.*, u.prename, u.name, u.surname
            FROM websites w
            JOIN users u ON u.id = w.updated_by";
    $result = $conn->query($sql);

    if ($result) {
        $rows = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(["success" => true, "documentData" => $rows ?: []]);
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
    // $updated_by = 58;

    // ✅ INSERT
    if ($action === 'insert') {
        $name_website = $_POST['name_website'];
        $url = $_POST['url'];
        $is_active = $_POST['is_active'];
        $show_footer = $_POST['show_footer'];

        $newFileName = '';
        $original_name = '';

        if (isset($_FILES['image']) && $_FILES['image']['error'] === 0) {
            $file = $_FILES['image'];
            $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
            $newFileName = 'web_' . time() . '.' . $ext;
            move_uploaded_file($file['tmp_name'], $targetDir . $newFileName);
            $original_name = $file['name'];
        }

        $stmt = $conn->prepare("INSERT INTO websites (name_website, url, image_name, original_name, is_active, show_footer, updated_by) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssiii", $name_website, $url, $newFileName, $original_name, $is_active, $show_footer, $updated_by);


        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "เพิ่มเว็บไซต์สำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "เพิ่มข้อมูลไม่สำเร็จ"]);
        }
    }

    // ✅ UPDATE
    // if ($action === 'update') {
    //     $id = $_POST['id_websites'];
    //     $name_website = $_POST['name_website'];
    //     $url = $_POST['url'];
    //     $is_active = $_POST['is_active'];
    //     $show_footer = $_POST['show_footer'];
    
    //     $newFileName = '';
    //     $original_name = '';
    
    //     if (isset($_FILES['image']) && $_FILES['image']['error'] === 0) {
    //         $res = $conn->query("SELECT image_name FROM websites WHERE id_websites = $id");
    //         $old = $res->fetch_assoc();
    //         if ($old && $old['image_name']) {
    //             @unlink($targetDir . $old['image_name']);
    //         }
    
    //         $file = $_FILES['image'];
    //         $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
    //         $newFileName = 'web_' . time() . '.' . $ext;
    //         move_uploaded_file($file['tmp_name'], $targetDir . $newFileName);
    //         $original_name = $file['name'];
    
    //         $stmt = $conn->prepare("UPDATE websites SET name_website=?, url=?, image_name=?, original_name=?, is_active=?, show_footer=?, updated_by=? WHERE id_websites=?");
    //         $stmt->bind_param("ssssiiii", $name_website, $url, $newFileName, $original_name, $is_active, $show_footer, $updated_by, $id);
    //     } else {
    //         $stmt = $conn->prepare("UPDATE websites SET name_website=?, url=?, is_active=?, show_footer=?, updated_by=? WHERE id_websites=?");
    //         $stmt->bind_param("ssiiii", $name_website, $url, $is_active, $show_footer, $updated_by, $id);
    //     }
    
    //     if ($stmt->execute()) {
    //         echo json_encode(["success" => true, "message" => "อัปเดตสำเร็จ"]);
    //     } else {
    //         echo json_encode(["success" => false, "message" => "อัปเดตไม่สำเร็จ", "error" => $stmt->error]);
    //     }
    // }
    if ($action === 'update') {
        $id = $_POST['id_websites'];
        $name_website = $_POST['name_website'];
        $url = $_POST['url'];
        $is_active = $_POST['is_active'];
        $show_footer = $_POST['show_footer'];

        $newFileName = '';
        $original_name = '';

        if (isset($_FILES['image']) && $_FILES['image']['error'] === 0) {
            // ดึงภาพเดิมมาเพื่อลบ
            $res = $conn->query("SELECT image_name FROM websites WHERE id_websites = $id");
            $old = $res->fetch_assoc();
            if ($old && $old['image_name']) {
                @unlink($targetDir . $old['image_name']);
            }

            // จัดการอัปโหลดใหม่
            $file = $_FILES['image'];
            $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
            $newFileName = 'web_' . time() . '.' . $ext;
            move_uploaded_file($file['tmp_name'], $targetDir . $newFileName);
            $original_name = $file['name'];

            // อัปเดตพร้อมข้อมูลภาพ
            $stmt = $conn->prepare("UPDATE websites SET name_website=?, url=?, image_name=?, original_name=?, is_active=?, show_footer=?, updated_by=? WHERE id_websites=?");
            $stmt->bind_param("ssssiiii", $name_website, $url, $newFileName, $original_name, $is_active, $show_footer, $updated_by, $id);
        } else {
            // อัปเดตโดยไม่เปลี่ยนภาพ
            $stmt = $conn->prepare("UPDATE websites SET name_website=?, url=?, is_active=?, show_footer=?, updated_by=? WHERE id_websites=?");
            $stmt->bind_param("ssiiii", $name_website, $url, $is_active, $show_footer, $updated_by, $id);
        }

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "อัปเดตสำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "อัปเดตไม่สำเร็จ", "error" => $stmt->error]);
        }
    }


    // ✅ DELETE
    if ($action === 'delete') {
        $id = $_POST['id_websites'];

        // ลบภาพเก่า
        $res = $conn->query("SELECT image_name FROM websites WHERE id_websites = $id");
        $row = $res->fetch_assoc();
        if ($row && $row['image_name']) {
            @unlink($targetDir . $row['image_name']);
        }

        $stmt = $conn->prepare("DELETE FROM websites WHERE id_websites = ?");
        $stmt->bind_param("i", $id);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "ลบสำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "ลบไม่สำเร็จ"]);
        }
    }
}
?>