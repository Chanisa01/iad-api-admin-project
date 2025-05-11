<?php
session_start();
require_once 'SSOClient.php';
$sso = new SSOClient();
header("Location: " . $sso->getLoginUrl());
exit;
