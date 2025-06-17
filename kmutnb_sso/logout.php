<?php
$config = include __DIR__ . '/config.php';
session_start();
session_unset();
session_destroy();
// header("Location: http://localhost:3000/login");
header("Location: " . $config['FRONTEND_URL'] . "/login");
exit;
