<?php

use Dotenv\Dotenv;

require_once __DIR__ . '/vendor/autoload.php';

// โหลด .env ถ้ายังไม่ได้โหลด
if (!isset($_ENV['VITE_BACKEND_URL'])) {
    $dotenv = Dotenv::createImmutable(__DIR__);
    $dotenv->load();
}

// เตรียมรายการ Origin ที่อนุญาต
return [
    'ALLOWED_ORIGINS' => array_filter([
        rtrim($_ENV['VITE_BACKEND_URL'] ?? '', '/'),       // จาก .env
        'http://localhost:3000',                            // fallback เผื่อ dev
        'http://127.0.0.1:3000',                            // fallback เพิ่ม
    ]),
];
