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

    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        http_response_code(204);
        exit;
    }

    session_name('PHPSESSID');
    session_start();

    include 'db_connect.php';

    if (strpos($_SERVER['CONTENT_TYPE'] ?? '', 'application/json') !== false) {
        $_POST = json_decode(file_get_contents('php://input'), true) ?? [];
    }
    $method = $_SERVER['REQUEST_METHOD'];

    if ($method === 'GET') {
        $stmt = $conn->prepare("SELECT * FROM audit_committee_group ORDER BY display_order ASC");
        // $stmt->bind_param("i", $category_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $audit_committee_group = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(["success" => true, "groupData" => $audit_committee_group ?: []]);
        exit;
    }

    $action = $_POST['action'] ?? '';

    if ($method === 'POST') {
        $action = $_POST['action'] ?? '';
        if ($action === 'insert') {
            $group_name = trim($_POST['group_name'] ?? '');

            if ($group_name === '') {
                echo json_encode(['success' => false, 'message' => 'ชื่อกลุ่มงานต้องไม่ว่าง']);
                exit;
            }

            // ตรวจสอบว่ามีชื่อซ้ำหรือไม่
            $stmt = $conn->prepare("SELECT COUNT(*) FROM audit_committee_group WHERE TRIM(group_name) = ?");
            $stmt->bind_param("s", $group_name);
            $stmt->execute();
            $stmt->bind_result($count);
            $stmt->fetch();
            $stmt->close();

            if ($count > 0) {
                echo json_encode(['success' => false, 'message' => 'ตำแหน่งนี้มีอยู่แล้ว']);
                exit;
            }

            // หาค่า display_order สูงสุด
            $result = $conn->query("SELECT IFNULL(MAX(display_order), 0) + 1 AS next_order FROM audit_committee_group");
            $row = $result->fetch_assoc();
            $next_order = $row['next_order'];

            // เพิ่มกลุ่มงาน
            $stmt = $conn->prepare("INSERT INTO audit_committee_group (group_name, display_order) VALUES (?, ?)");
            $stmt->bind_param("si", $group_name, $next_order);
            $success = $stmt->execute();
            $stmt->close();

            echo json_encode(['success' => $success]);
            exit;
        }

        if ($action === 'update_order') {
            $orderData = $_POST['orderData'] ?? [];

            foreach ($orderData as $item) {
                $id = intval($item['id']);
                $order = intval($item['display_order']);

                $stmt = $conn->prepare("UPDATE audit_committee_group SET display_order = ? WHERE id = ?");
                $stmt->bind_param("ii", $order, $id);
                $stmt->execute();
                $stmt->close();
            }

            echo json_encode(['success' => true]);
            exit;
        }


        if ($action === 'delete') {
            $id = intval($_POST['id'] ?? 0);

            // เช็คว่ามีการใช้งานอยู่ใน audit_committee หรือไม่
            $stmt = $conn->prepare("SELECT COUNT(*) FROM audit_committee WHERE position1 = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $stmt->bind_result($usage_count);
            $stmt->fetch();
            $stmt->close();

            if ($usage_count > 0) {
                echo json_encode([
                    'success' => false,
                    'message' => 'ไม่สามารถลบได้: ตำแหน่งนี้ถูกใช้งานอยู่ในข้อมูลคณะกรรมการ',
                ]);
                exit;
            }

            // ลบกลุ่มงาน
            $stmt = $conn->prepare("DELETE FROM audit_committee_group WHERE id = ?");
            $stmt->bind_param("i", $id);
            $success = $stmt->execute();
            $stmt->close();

            echo json_encode(['success' => $success]);
            exit;
        }
        echo json_encode(['success' => false, 'message' => 'Invalid action']);
    }
?>
