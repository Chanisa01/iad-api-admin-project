<?php

function getAccessToken($code, $client_id, $client_secret) {
    $url = "https://sso.kmutnb.ac.th/api/v1/token";
    $params = http_build_query([
        'client_id' => $client_id,
        'client_secret' => $client_secret,
        'code' => $code,
    ]);

    $response = @file_get_contents("$url?$params");
    if (!$response) return null;

    $data = json_decode($response, true);
    return $data['access_token'] ?? null;
}

function getUserInfo($access_token) {
    $url = "https://sso.kmutnb.ac.th/api/v1/me?access_token=" . urlencode($access_token);
    $response = @file_get_contents($url);
    return $response ? json_decode($response, true) : null;
}
