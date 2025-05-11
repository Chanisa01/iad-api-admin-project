<?php
include 'kmutnbsso.php';
include "backend/config.php";
session_start();

$auth = new kmutnbsso();

if (!isset($_GET['code'])) { 
    if(isset($_GET['error'])){
        if ( $_GET['error'] == "access_denied") {
            echo "<script>window.location.href = 'http://localhost:3000/login?action=notallow';</script>";
        }
    }else{
        $userDetails = $auth->handleCallback();        
    }

} else {
    // Handle the callback and fetch user details
    $userDetails = $auth->handleCallback();
    // print_r($userDetails);
    // exit();
    if ($userDetails === false) {
        error_log("handleCallback failed: Could not retrieve user details");
        echo "ไม่สามารถดึงข้อมูลจากระบบยืนยันตัวตนได้ กรุณาลองใหม่อีกครั้ง.";
        exit();
    }
    if($userDetails != false){        
        $username = $userDetails["profile"]["username"];
        $name = $userDetails["profile"]["display_name"];
        $user_type = $userDetails["profile"]["account_type"];
        
        $pid = $userDetails["profile"]["pid"];
        $titlename = $userDetails['personnel_info']['full_prefix_name_th'];
        $name = $userDetails['personnel_info']['firstname_th'];
        $lastname = $userDetails['personnel_info']['lastname_th'];
        $faculty_code = $userDetails['personnel_info']['faculty_code'];
        $department_code = $userDetails['personnel_info']['department_code'];
        $faculty_name_th = $userDetails['personnel_info']['faculty_name'];
        $department_name_th = $userDetails['personnel_info']['department_name'];
        $person_photo = $userDetails['personnel_info']['photo'];
        $icit_account= $userDetails['profile']['username'];
        $name_en = $userDetails['personnel_info']['firstname_en'];
        $lastname_en = $userDetails['personnel_info']['lastname_en'];
        
        @session_start();
        ob_start();				
                            
        // ตรวจสอบข้อมูลในฐานข้อมูล
        $sql = "SELECT * FROM users WHERE pid = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $pid);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 1) {
            $objResult2 = $result->fetch_assoc();
            $_SESSION['sess_iauop_id'] = session_id();
            $_SESSION['sess_iauop_username'] = $username;
            $_SESSION['sess_iauop_titlename'] = $titlename;
            $_SESSION['sess_iauop_name'] = $name;
            $_SESSION['sess_iauop_lastname'] = $lastname;
            $_SESSION['sess_iauop_faculty_code'] = $faculty_code;
            $_SESSION['sess_iauop_department_code'] = $department_code;
            $_SESSION['sess_iauop_faculty_name'] = $faculty_name_th;
            $_SESSION['sess_iauop_department_name'] = $department_name_th;
            $_SESSION['sess_iauop_person_photo'] = $person_photo;
            $_SESSION['sess_iauop_auth_salary'] = $objResult2["is_auth_salary"];
            $_SESSION['sess_iauop_user_group_id'] = $objResult2["user_group_id"];
            $_SESSION['sess_iauop_user_id'] = $objResult2["id"];

            $update_sql = "UPDATE users SET 
                prename = ?, 
                name = ?, 
                surname = ?, 
                name_en = ?, 
                surname_en = ?, 
                faculty_code = ?, 
                faculty_name = ?, 
                department_code = ?, 
                department_name = ?, 
                icit_username = ?, 
                last_login = now(), 
                person_photo = ? 
                WHERE pid = ?";

                $update_stmt = $conn->prepare($update_sql);
                $update_stmt->bind_param(
                    "ssssssssssss", 
                    $titlename, $name, $lastname, $name_en, $lastname_en, 
                    $faculty_code, $faculty_name_th, $department_code, $department_name_th, 
                    $icit_account, $person_photo, $pid 
                );
                $update_stmt->execute();

        } else {
            echo "<script>window.location.href = 'home.php?action=noauthorize';</script>";
            exit();
        }

        setcookie("reg_username", $icit_account, 0, "/");
        header("Location: http://localhost:3000/login-success");
        exit;
        // echo "<script>window.location.href = 'backend/index.php';</script>";
    }
    else{
        echo "<script>window.location.href = 'home.php?action=warning';</script>";
        // print_r($userDetails);
    }
}
?>