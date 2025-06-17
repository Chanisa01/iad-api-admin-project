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
require __DIR__ . '/vendor/autoload.php'; // โหลด PhpSpreadsheet

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

header('Content-Type: application/json');
$action = $_GET['action'] ?? '';

if ($action === 'summary') {
    $today = $conn->query("SELECT COUNT(*) FROM visitor_logs WHERE DATE(visited_at) = CURDATE()")->fetch_row()[0];
    $yesterday = $conn->query("SELECT COUNT(*) FROM visitor_logs WHERE DATE(visited_at) = CURDATE() - INTERVAL 1 DAY")->fetch_row()[0];
    $month = $conn->query("SELECT COUNT(*) FROM visitor_logs WHERE MONTH(visited_at) = MONTH(CURDATE()) AND YEAR(visited_at) = YEAR(CURDATE())")->fetch_row()[0];
    $total = $conn->query("SELECT COUNT(*) FROM visitor_logs")->fetch_row()[0];

    $peakHourQuery = $conn->query("
        SELECT HOUR(visited_at) AS hour, COUNT(*) AS total
        FROM visitor_logs
        GROUP BY hour
        ORDER BY total DESC
        LIMIT 1
    ");
    $peakHour = $peakHourQuery->fetch_assoc();
    $peak = $peakHour ? "{$peakHour['hour']}:00 - {$peakHour['hour']}:59" : "ไม่มีข้อมูล";

    echo json_encode([
        'today' => $today,
        'yesterday' => $yesterday,
        'this_month' => $month,
        'total' => $total,
        'peak_time' => $peak
    ]);
    exit;
}

if ($action === 'visits_by_day') {
    $start = $_GET['start'] ?? date('Y-m-01');
    $end = $_GET['end'] ?? date('Y-m-d');

    $stmt = $conn->prepare("
        SELECT DATE(visited_at) AS visit_date, COUNT(*) AS total 
        FROM visitor_logs 
        WHERE DATE(visited_at) BETWEEN ? AND ?
        GROUP BY DATE(visited_at)
        ORDER BY visit_date
    ");
    $stmt->bind_param("ss", $start, $end);
    $stmt->execute();
    $result = $stmt->get_result();

    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    echo json_encode($data);
    exit;
}

if ($action === 'export_excel') {
    $start = $_GET['start'] ?? date('Y-m-01');
    $end = $_GET['end'] ?? date('Y-m-d');

    $stmt = $conn->prepare("
        SELECT DATE(visited_at) AS visit_date, COUNT(*) AS total 
        FROM visitor_logs 
        WHERE DATE(visited_at) BETWEEN ? AND ?
        GROUP BY DATE(visited_at)
        ORDER BY visit_date
    ");
    $stmt->bind_param("ss", $start, $end);
    $stmt->execute();
    $result = $stmt->get_result();

    // สร้าง spreadsheet
    $spreadsheet = new Spreadsheet();
    $sheet = $spreadsheet->getActiveSheet();
    $sheet->setTitle("Visitor Stats");

    // หัวตาราง
    $sheet->setCellValue('A1', 'วันที่');
    $sheet->setCellValue('B1', 'จำนวนผู้เข้าชม');

    $rowIndex = 2;
    while ($row = $result->fetch_assoc()) {
        $sheet->setCellValue("A{$rowIndex}", $row['visit_date']);
        $sheet->setCellValue("B{$rowIndex}", $row['total']);
        $rowIndex++;
    }

    // ส่งไฟล์ Excel กลับ
    header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    header('Content-Disposition: attachment;filename="visitor_report.xlsx"');
    header('Cache-Control: max-age=0');

    $writer = new Xlsx($spreadsheet);
    $writer->save('php://output');
    exit;
}

echo json_encode(['error' => 'Invalid action']);
exit;
