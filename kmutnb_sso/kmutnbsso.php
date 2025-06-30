<?php
class kmutnbsso
{
    private $clientId;
    private $clientSecret;
    private $redirectUri;
    private $authUrl;
    private $tokenUrl;
    private $resourceUrl;

    public function __construct()
    {
        // Initialize with OAuth2 provider details
        $this->clientId = 'm4F26kNf1gavGOtbdzdagO1FbZj0aR68';
        $this->clientSecret = 'RBqsfWeDJmCXnSSImZCAsrvHMUgUy6qP1hUlsjYh3vzCSHl5LK072fFp5IONHlIi';
        // $this->redirectUri = 'https://iau.op.kmutnb.ac.th/backend/API_iauop/kmutnb_sso/callback.php';
        $this->redirectUri = 'http://localhost/API_iauop/kmutnb_sso/callback.php';
        $this->authUrl = 'https://sso.kmutnb.ac.th/auth/authorize';
        $this->tokenUrl = 'https://sso.kmutnb.ac.th/auth/token';
        $this->resourceUrl = 'https://sso.kmutnb.ac.th/resources/userinfo';
    }

    // ✅ แก้ไข method เพื่อรองรับทั้งการ redirect และการ return URL
    public function getAuthorizationUrl($redirect = true)
    {
        // ✅ สร้าง state แบบสุ่มใหม่ทุกครั้ง
        $state = bin2hex(random_bytes(16));
        $_SESSION['oauth2state'] = $state;

        $authorizationUrl = $this->authUrl . '?' . http_build_query([
            'response_type' => 'code',
            'client_id' => $this->clientId,
            'redirect_uri' => $this->redirectUri,
            'state' => $state,
            'scope' => 'profile pid personnel_info'
        ]);

        if ($redirect) {
            header('Location: ' . $authorizationUrl);
            exit;
        }
        
        return $authorizationUrl;
    }

    public function handleCallback()
    {
        // ✅ ตรวจสอบ state ป้องกัน CSRF อย่างถูกต้อง
        if (empty($_GET['state']) || !isset($_SESSION['oauth2state']) || $_GET['state'] !== $_SESSION['oauth2state']) {
            unset($_SESSION['oauth2state']);
            throw new Exception('Invalid state parameter - CSRF protection');
        }

        // ✅ ล้าง state หลังจากตรวจสอบแล้ว
        unset($_SESSION['oauth2state']);

        if (isset($_GET['code'])) {
            $accessToken = $this->getAccessToken($_GET['code']);
            $userDetails = $this->getUserDetails($accessToken);
            
            // ✅ เก็บข้อมูลใน session ชั่วคราวเพื่อ debug
            $_SESSION['__userDetails'] = $userDetails;
            return $userDetails;
        } else {
            throw new Exception('Authorization code not provided');
        }
    }

    private function getAccessToken($authorizationCode)
    {
        if (!function_exists('curl_init')) {
            throw new Exception('cURL not enabled');
        }
        
        $postData = [
            'grant_type' => 'authorization_code',
            'code' => $authorizationCode,
            'redirect_uri' => $this->redirectUri,
        ];

        $headers = array(
            "Content-Type: application/x-www-form-urlencoded",
            "Authorization: Basic " . base64_encode($this->clientId . ":" . $this->clientSecret),
        );
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->tokenUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postData));
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        
        $response = curl_exec($ch);       
        
        if (curl_errno($ch)) {
            $error = 'cURL error: ' . curl_error($ch);
            curl_close($ch);
            throw new Exception($error);
        }
        curl_close($ch);
        
        $response = json_decode($response, true);
        
        if (isset($response['access_token'])) {
            return $response['access_token'];
        } else {
            // ✅ ปรับปรุงการจัดการ error
            $errorMsg = 'Failed to obtain access token';
            if (isset($response['error'])) {
                $errorMsg .= ': ' . $response['error'];
                if (isset($response['error_description'])) {
                    $errorMsg .= ' - ' . $response['error_description'];
                }
            }
            throw new Exception($errorMsg);
        }
    }

    private function getUserDetails($accessToken)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->resourceUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Authorization: Bearer ' . $accessToken
        ]);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);

        $response = curl_exec($ch);
        
        if (curl_errno($ch)) {
            $error = 'cURL error: ' . curl_error($ch);
            curl_close($ch);
            throw new Exception($error);
        }
        curl_close($ch);
        
        $userData = json_decode($response, true);
        
        if (!$userData) {
            throw new Exception('Failed to get user details from SSO');
        }
        
        return $userData;
    }

    public function showError($error, $error_description)
    {
        echo '<div style="color:red"><strong>Error:</strong> ' . $error . ': ' . $error_description . '</div>';
    }
}
?>