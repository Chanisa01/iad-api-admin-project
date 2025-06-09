-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 09, 2025 at 08:57 AM
-- Server version: 8.0.17
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iauop_kmutnb`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `cover` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `uploaded_at` date DEFAULT NULL COMMENT 'วันที่อัปโหลดไฟล์ (แก้ไขได้)',
  `is_active` int(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activities_files`
--

CREATE TABLE `activities_files` (
  `id` int(11) NOT NULL,
  `activities_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activities_images`
--

CREATE TABLE `activities_images` (
  `id` int(11) NOT NULL,
  `activities_id` int(11) NOT NULL,
  `image_name` varchar(255) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `id_article` int(4) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description_th` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `image_name` varchar(255) DEFAULT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`id_article`, `category_id`, `description_th`, `image_name`, `original_name`, `updated_at`, `updated_by`) VALUES
(1, 12, '<ol><li>เมื่อวันที่ 19 สิงหาคม 2519 รัฐบาลกำหนดให้ส่วนราชการมีผู้ตรวจสอบกายในมีสายการบังคับบัญชาขึ้นตรงต่อหัวหน้าส่วนราชการ ซึ่งแต่งตั้งจากนักวิชาการเงินและบัญชี การตรวจสอบจะมุ่งมั่นทางทางการเงินและบัญชี ในปี พ.ศ. 2539 มีงานตรวจสอบภายใน ทำหน้าที่ตรวจสอบกิจการทั้งปวงของมหาวิทยาลัย</li></ol><ul><li>ในปี พ.ศ. 2550 มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือมีฐานะเป็นหน่วยงานในกำกับของรัฐตามพระราชบัญญัติมหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ พ.ศ. 2550 โดยมีสภามหาวิทยาลัยทำหน้าที่ควบคุม ดูแล การดำเนินงานของมหาวิทยาลัย ซึ่งตามมาตรา 49 ให้มหาวิทยาลัยจัดให้มีระบบการตรวจสอบภายในเพื่อตรวจสอบการดำเนินการต่าง ๆ ของมหาวิทยาลัย</li><li>22 กุมภาพันธ์ 2555 สภามหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ มีมติอนุมัติจัดตั้งหน่วยตรวจสอบภายใน (Internal Audit Unit) เป็นหน่วยงานระดับกอง สังกัดสำนักงานอธิการบดี</li></ul>', NULL, NULL, '2025-06-04 15:38:07', 57),
(2, 13, '<ul><li>สร้างความเชื่อมั่นด้านการตรวจสอบ ด้วยแนวทางที่ทันสมัย ตามมาตรฐานสากล</li></ul>', NULL, NULL, '2025-05-06 08:23:12', 57),
(3, 14, '<ul><li>ประเมินระบบการควบคุมภายในและสอบทานการปฎิบัติงานเพื่อให้ผู้บริหารเกิดความเชื่อมั่นว่าการปฎิบัติงานเป็นไปตามวัตถุประสงค์ เป้าหมาย และสอดคล้องกับนโยบายของมหาวิทยาลัย</li></ul>', NULL, NULL, '2025-06-04 08:51:14', 57),
(4, 15, '<ul><li>ตรวจสอบด้วยกัลยาณมิตร เกิดผลสัมฤทธิ์ตามเป้าหมาย</li></ul>', NULL, NULL, '2025-06-04 08:51:11', 57),
(5, 16, '', 'structure_684158a76381f.png', 'OrgChart.png', '2025-06-05 15:43:19', 57),
(6, 11, '', NULL, NULL, '2025-05-06 11:19:11', 57);

-- --------------------------------------------------------

--
-- Table structure for table `audit_committee`
--

CREATE TABLE `audit_committee` (
  `id_committee` int(11) NOT NULL,
  `category_id` int(10) NOT NULL,
  `prename` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `image_committee_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `position1` int(11) DEFAULT '0',
  `position2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `certificate` int(2) DEFAULT '0',
  `group_year_start` int(5) DEFAULT NULL,
  `group_year_end` int(5) DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` int(2) DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `audit_committee`
--

INSERT INTO `audit_committee` (`id_committee`, `category_id`, `prename`, `name`, `surname`, `image_committee_name`, `position1`, `position2`, `certificate`, `group_year_start`, `group_year_end`, `email`, `phone`, `is_active`, `updated_at`, `updated_by`) VALUES
(30, 7, 'นาย', 'ทดสอบ', 'ทดสอบ', '', 1, 'ผู้ทรงคุณวุฒิภายนอก', 0, 2560, 2564, '', '', 1, '2025-06-09 03:29:59', 57),
(33, 7, 'นาง', 'ทดสอบ', 'ทดสอบ', '', 2, 'ผู้ทรงคุณวุฒิ', 0, 2560, 2564, '', '', 1, '2025-06-09 06:57:07', 57),
(34, 7, 'นางสาว', 'ทดสอบ', 'ทดสอบ', '', 3, '', 0, 2560, 2564, '', '', 1, '2025-06-09 06:57:35', 57),
(35, 7, 'นางสาว', 'ทดสอบ', 'ทดสอบ', '', 1, '', 0, 2565, 2566, '', '', 1, '2025-06-09 07:01:55', 57),
(36, 7, 'นาง', 'ทดสอบ', 'ทดสอบ', '', 2, '', 0, 2560, 2564, '', '', 0, '2025-06-09 07:50:18', 57),
(37, 7, 'นาง', 'ทดสอบ', 'ทดสอบ', '', 2, '', 0, 2560, 2564, '', '', 1, '2025-06-09 07:50:31', 57),
(38, 7, 'นาง', 'ทดสอบ', 'ทดสอบ', '', 2, '', 0, 2560, 2564, '', '', 1, '2025-06-09 07:50:43', 57),
(39, 7, 'นาง', 'ทดสอบ', 'ทดสอบ', '', 2, 'ผู้ทรงคุณวุฒิภายนอก', 0, 2560, 2564, '', '', 1, '2025-06-09 07:50:52', 57);

-- --------------------------------------------------------

--
-- Table structure for table `audit_committee_group`
--

CREATE TABLE `audit_committee_group` (
  `id` int(11) NOT NULL,
  `group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `display_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `audit_committee_group`
--

INSERT INTO `audit_committee_group` (`id`, `group_name`, `display_order`) VALUES
(1, 'ประธานคณะกรรมการตรวจสอบ', 1),
(2, 'กรรมการ', 2),
(3, 'เลขานุการ', 3);

-- --------------------------------------------------------

--
-- Table structure for table `banner`
--

CREATE TABLE `banner` (
  `id_banner` int(11) NOT NULL,
  `image_name` varchar(500) NOT NULL,
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `display_order` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `original_name` varchar(500) NOT NULL,
  `is_active` int(1) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `folder_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name`, `folder_path`, `created_at`) VALUES
(1, 'เกี่ยวกับหน่วยงาน', 'about_the_department/', '2025-03-20 05:12:20'),
(2, 'คณะกรรมการตรวจสอบ', 'committees/', '2025-03-20 05:12:20'),
(3, 'รายงานผลการดำเนินการ', 'reports/', '2025-03-20 05:12:20'),
(4, 'สารสนเทศ', 'information/', '2025-03-20 05:12:20'),
(5, 'เอกสารเผยแพร่', 'publications/', '2025-03-20 05:12:20'),
(6, 'บุคลากรหน่วยตรวจสอบภายใน', 'personal/', '2025-04-02 02:41:17'),
(7, 'องค์ประกอบคณะกรรมการตรวจสอบ', 'committee/', '2025-04-02 02:41:17'),
(8, 'กิจกรรมข่าว', 'information/activities/', '2025-04-06 11:40:38'),
(9, 'ดาวน์โหลด', 'information/download/', '2025-04-06 11:40:38'),
(10, 'คำถามที่พบบ่อย', 'information/faqs/', '2025-04-06 11:40:38'),
(11, 'องค์ประกอบคณะกรรมการตรวจสอบ', 'composition/', '2025-04-30 17:26:32'),
(12, 'ประวัติความเป็นมา', 'history/', '2025-05-02 03:30:37'),
(13, 'วิสัยทัศน์', 'vision/', '2025-05-02 03:30:37'),
(14, 'พันธกิจ', 'mission/', '2025-05-02 03:30:37'),
(15, 'อัตลักษณ์', 'identity/', '2025-05-02 03:30:37'),
(16, 'โครงสร้าง', 'structure/', '2025-05-02 03:30:37');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `complaint_type` enum('ร้องเรียน','ข้อเสนอแนะ') NOT NULL,
  `description` text NOT NULL,
  `acknowledgement` tinyint(1) NOT NULL,
  `status` enum('received','Investigating','pending_additional_info','in_progress','resolved','Cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'received',
  `submitted_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `full_name`, `email`, `phone_number`, `complaint_type`, `description`, `acknowledgement`, `status`, `submitted_at`, `updated_by`) VALUES
(34, 'นางสาวทดสอบ ขอไม่ระบุตัวตน', '', '', 'ข้อเสนอแนะ', 'อยากให้เพิ่มระบบการร้องเรียน', 1, 'Investigating', '2025-06-05 15:05:51', 57);

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  `uploaded_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED NOT NULL,
  `uploaded_at` date DEFAULT NULL COMMENT 'วันที่อัปโหลดไฟล์ (แก้ไขได้)',
  `is_active` int(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `document`
--

INSERT INTO `document` (`id`, `title`, `file_name`, `category_id`, `uploaded_by`, `updated_by`, `uploaded_at`, `is_active`) VALUES
(91, 'ทดสอบ', 'document_1749436799_6846497fa43f4.pdf', 3, 57, 57, '2025-06-10', 0);

-- --------------------------------------------------------

--
-- Table structure for table `document_composition`
--

CREATE TABLE `document_composition` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  `updated_by` int(10) UNSIGNED NOT NULL,
  `uploaded_at` date DEFAULT NULL COMMENT 'วันที่อัปโหลดไฟล์ (แก้ไขได้)',
  `is_active` int(1) NOT NULL DEFAULT '0',
  `group_year_start` int(5) DEFAULT NULL,
  `group_year_end` int(5) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `document_composition`
--

INSERT INTO `document_composition` (`id`, `title`, `file_name`, `category_id`, `updated_by`, `uploaded_at`, `is_active`, `group_year_start`, `group_year_end`) VALUES
(9, 'หนังสือวาระ ๒๕๖๐ ถึง ๒๕๖๔', 'document_1749452333_6846862d79e51.pdf', 11, 57, '2025-06-10', 1, 2560, 2564),
(10, 'หนังสือวาระ ๒๕๖๕ ถึง ๒๕๖๖', 'document_1749452444_6846869c16ce6.pdf', 11, 57, '2025-06-10', 1, 2565, 2566);

-- --------------------------------------------------------

--
-- Table structure for table `event_banner`
--

CREATE TABLE `event_banner` (
  `id_event` int(11) NOT NULL,
  `image_name` varchar(500) NOT NULL,
  `original_name` varchar(500) NOT NULL,
  `is_active` int(1) DEFAULT '0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `display_order` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'หัวข้อคำถาม',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'รายละเอียดคำถาม',
  `is_active` int(1) NOT NULL DEFAULT '0',
  `uploaded_at` date DEFAULT NULL COMMENT 'วันที่อัปโหลด',
  `updated_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'รหัสแอดมินที่แก้ไขข้อมูล'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_files`
--

CREATE TABLE `faq_files` (
  `id` int(11) NOT NULL,
  `faq_id` int(11) NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ชื่อไฟล์ในระบบ (ที่เก็บในโฟลเดอร์)',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ชื่อไฟล์ต้นฉบับที่อัปโหลด',
  `uploaded_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'วันที่อัปโหลดไฟล์'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal`
--

CREATE TABLE `personal` (
  `id_personal` int(11) NOT NULL,
  `category_id` int(10) NOT NULL,
  `prename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'คำนำหน้าชื่อ',
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `department` int(11) DEFAULT '0',
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `certificate` int(2) DEFAULT '0',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `extension` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'เลขภายใน',
  `image_personal_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` int(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `personal`
--

INSERT INTO `personal` (`id_personal`, `category_id`, `prename`, `name`, `surname`, `department`, `position`, `certificate`, `email`, `phone`, `extension`, `image_personal_name`, `is_active`, `created_at`, `updated_by`) VALUES
(194, 6, 'นาย', 'นิติกร', 'นิตยาชิต', 8, 'ผู้อำนวยการหน่วยตรวจสอบภายใน รักษาการแทนหัวหน้ากลุ่มงานตรวจสอบภายใน', 1, 'nitikom.n@op.kmutnb.ac.th', '0-2555-2166', '2166', NULL, 1, '2025-06-06 01:51:50', 57),
(195, 6, 'นาย', 'อรรถพล', 'สงฆรักษ์', 2, 'นักตรวจสอบภายใน ชำนาญการ', 1, 'arttapon.s@op.kmutnb.ac.th', '0-2555-2000', '1117', NULL, 1, '2025-06-06 01:53:52', 57),
(196, 6, 'นาย', 'ศราวุธ', 'ผาพญาเรือง', 2, 'นักตรวจสอบภายใน ปฏิบัติการ', 1, 'sarawut.p@op.kmutnb.ac.th', '0-2555-2000', '1117', NULL, 1, '2025-06-06 01:55:01', 57),
(197, 6, 'นางสาว', 'เรวดี', 'มากสุดใจ', 2, 'นักตรวจสอบภายใน ปฏิบัติการ', 0, 'rawadee.m@op.kmutnb.ac.th', '0-2555-2000', '1116', NULL, 1, '2025-06-06 01:57:04', 57),
(198, 6, 'นางสาว', 'มณฑิรา', 'สุดจิตร์', 2, 'นักตรวจสอบภายใน ปฏิบัติการ', 0, 'montira.s@op.kmutnb.ac.th', '0-2555-2000', '1117', NULL, 1, '2025-06-06 01:58:12', 57),
(199, 6, 'นางสาว', 'กัญชรส7', 'โรจนแสงชัย', 2, 'นักตรวจสอบภายในปฏิบัติการ', 0, 'kancharos.r@op.kmutnb.ac.th', '0-2555-2000', '1116', NULL, 1, '2025-06-06 02:00:29', 57),
(200, 6, 'นาง', 'เขมภัค', 'กมลเนตร', 3, 'หัวหน้ากลุ่มงานบริหารและพัฒนาคุณภาพ เจ้าหน้าที่บริหารงานทั่วไป ชำนาญการ', 1, 'kemapuk.k@op.kmutnb.ac.th', '0-2555-5200', '1115', NULL, 1, '2025-06-06 02:02:29', 57),
(201, 6, 'นาง', 'วชิราพร', 'นามวงศ์', 3, 'เจ้าหน้าที่บริหารงานทั่วไป ชำนาญการ', 1, 'wachirapom.n@op.kmutnb.ac.th', '0-2555-2000', '1115', NULL, 1, '2025-06-06 02:03:15', 57),
(202, 6, 'นางสาว', 'ทดสอบ', 'ทดสอบ', 8, 'ทดสอบ', 0, 'test@op.kmutnb.ac.th', '0-2000-0000', '1255', NULL, 0, '2025-06-06 08:10:59', 57);

-- --------------------------------------------------------

--
-- Table structure for table `personal_group`
--

CREATE TABLE `personal_group` (
  `id` int(11) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `display_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `personal_group`
--

INSERT INTO `personal_group` (`id`, `group_name`, `display_order`) VALUES
(2, 'กลุ่มงานตรวจสอบภายใน', 2),
(3, 'กลุ่มงานบริหารและพัฒนาคุณภาพ', 3),
(8, 'ผู้อำนวยการ', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `pid` varchar(13) NOT NULL COMMENT 'หมายเลขประจำตัวประชาชน',
  `name` varchar(100) NOT NULL COMMENT 'ชื่อ',
  `surname` varchar(100) NOT NULL COMMENT 'นามสกุล',
  `name_en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `surname_en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `prename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'คำนำหน้าชื่อ',
  `icit_username` varchar(100) NOT NULL,
  `user_group_id` tinyint(4) NOT NULL DEFAULT '3' COMMENT '1=admin,2=user,3=no authorize',
  `last_login` datetime DEFAULT NULL,
  `first_login` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `person_photo` varchar(255) DEFAULT NULL,
  `is_active` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `pid`, `name`, `surname`, `name_en`, `surname_en`, `prename`, `icit_username`, `user_group_id`, `last_login`, `first_login`, `person_photo`, `is_active`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(57, '1729900557095', 'ฌานิศา', 'อิ่มลิ้มทาน', 'Chanisa', 'Aimlimthan', '', 'chanisaa', 1, '2025-06-09 14:01:02', '2025-02-05 06:55:49', '', 1, NULL, NULL, '2025-05-05 01:15:42', 57),
(58, '1729900557094', 'ทดสอบ', 'ทดสอบ', NULL, NULL, '', 'pimpikaa', 2, NULL, '2025-02-26 07:09:56', NULL, 1, NULL, NULL, '2025-05-05 23:26:50', 57);

-- --------------------------------------------------------

--
-- Table structure for table `visitor_logs`
--

CREATE TABLE `visitor_logs` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `visited_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `visitor_logs`
--

INSERT INTO `visitor_logs` (`id`, `ip_address`, `visited_at`) VALUES
(839, '::1', '2025-06-05 15:41:55'),
(840, '::1', '2025-06-05 15:41:55'),
(841, '::1', '2025-06-05 15:42:51'),
(842, '::1', '2025-06-05 15:42:51'),
(843, '::1', '2025-06-05 15:42:52'),
(844, '::1', '2025-06-05 15:42:52'),
(845, '::1', '2025-06-05 15:43:32'),
(846, '::1', '2025-06-05 15:43:32'),
(847, '::1', '2025-06-06 08:11:30'),
(848, '::1', '2025-06-06 08:11:30'),
(849, '::1', '2025-06-06 15:31:58'),
(850, '::1', '2025-06-06 15:31:58'),
(851, '::1', '2025-06-06 15:33:35'),
(852, '::1', '2025-06-06 15:33:35'),
(853, '::1', '2025-06-06 15:36:30'),
(854, '::1', '2025-06-06 15:36:30'),
(855, '::1', '2025-06-06 16:00:18'),
(856, '::1', '2025-06-06 16:00:18'),
(857, '::1', '2025-06-09 08:19:30'),
(858, '::1', '2025-06-09 08:19:30'),
(859, '::1', '2025-06-09 08:59:22'),
(860, '::1', '2025-06-09 08:59:23'),
(861, '::1', '2025-06-09 09:05:44'),
(862, '::1', '2025-06-09 09:05:45'),
(863, '::1', '2025-06-09 09:20:50'),
(864, '::1', '2025-06-09 09:20:50'),
(865, '::1', '2025-06-09 09:23:02'),
(866, '::1', '2025-06-09 09:23:02'),
(867, '::1', '2025-06-09 09:40:10'),
(868, '::1', '2025-06-09 09:40:10'),
(869, '::1', '2025-06-09 09:40:26'),
(870, '::1', '2025-06-09 09:40:26'),
(871, '::1', '2025-06-09 09:44:14'),
(872, '::1', '2025-06-09 09:44:14'),
(873, '::1', '2025-06-09 09:44:31'),
(874, '::1', '2025-06-09 09:44:31'),
(875, '::1', '2025-06-09 09:44:44'),
(876, '::1', '2025-06-09 09:44:44'),
(877, '::1', '2025-06-09 09:45:02'),
(878, '::1', '2025-06-09 09:45:02'),
(879, '::1', '2025-06-09 09:45:28'),
(880, '::1', '2025-06-09 09:45:28'),
(881, '::1', '2025-06-09 09:47:09'),
(882, '::1', '2025-06-09 09:47:09'),
(883, '::1', '2025-06-09 09:49:31'),
(884, '::1', '2025-06-09 09:49:31'),
(885, '::1', '2025-06-09 09:49:49'),
(886, '::1', '2025-06-09 09:49:49'),
(887, '::1', '2025-06-09 09:54:59'),
(888, '::1', '2025-06-09 09:54:59'),
(889, '::1', '2025-06-09 09:55:00'),
(890, '::1', '2025-06-09 09:55:00'),
(891, '::1', '2025-06-09 09:55:00'),
(892, '::1', '2025-06-09 09:55:00'),
(893, '::1', '2025-06-09 09:55:04'),
(894, '::1', '2025-06-09 09:55:04'),
(895, '::1', '2025-06-09 09:55:05'),
(896, '::1', '2025-06-09 09:55:05'),
(897, '::1', '2025-06-09 09:55:39'),
(898, '::1', '2025-06-09 09:55:39'),
(899, '::1', '2025-06-09 11:12:24'),
(900, '::1', '2025-06-09 11:12:24'),
(901, '::1', '2025-06-09 13:04:54'),
(902, '::1', '2025-06-09 13:04:54'),
(903, '::1', '2025-06-09 14:00:48'),
(904, '::1', '2025-06-09 14:00:48'),
(905, '::1', '2025-06-09 14:02:00'),
(906, '::1', '2025-06-09 14:02:00'),
(907, '::1', '2025-06-09 14:12:57'),
(908, '::1', '2025-06-09 14:12:57'),
(909, '::1', '2025-06-09 14:21:05'),
(910, '::1', '2025-06-09 14:21:05'),
(911, '::1', '2025-06-09 14:21:06'),
(912, '::1', '2025-06-09 14:21:06'),
(913, '::1', '2025-06-09 14:22:42'),
(914, '::1', '2025-06-09 14:22:42'),
(915, '::1', '2025-06-09 14:22:43'),
(916, '::1', '2025-06-09 14:22:43'),
(917, '::1', '2025-06-09 14:23:11'),
(918, '::1', '2025-06-09 14:23:11'),
(919, '::1', '2025-06-09 14:23:30'),
(920, '::1', '2025-06-09 14:23:30'),
(921, '::1', '2025-06-09 14:23:44'),
(922, '::1', '2025-06-09 14:23:44'),
(923, '::1', '2025-06-09 14:32:40'),
(924, '::1', '2025-06-09 14:32:40'),
(925, '::1', '2025-06-09 14:32:44'),
(926, '::1', '2025-06-09 14:32:44'),
(927, '::1', '2025-06-09 14:32:54'),
(928, '::1', '2025-06-09 14:32:54'),
(929, '::1', '2025-06-09 14:33:05'),
(930, '::1', '2025-06-09 14:33:05'),
(931, '::1', '2025-06-09 14:39:00'),
(932, '::1', '2025-06-09 14:39:00'),
(933, '::1', '2025-06-09 14:44:24'),
(934, '::1', '2025-06-09 14:44:24'),
(935, '::1', '2025-06-09 14:47:44'),
(936, '::1', '2025-06-09 14:47:44'),
(937, '::1', '2025-06-09 14:47:56'),
(938, '::1', '2025-06-09 14:47:56'),
(939, '::1', '2025-06-09 14:48:01'),
(940, '::1', '2025-06-09 14:48:01'),
(941, '::1', '2025-06-09 14:51:55'),
(942, '::1', '2025-06-09 14:51:55'),
(943, '::1', '2025-06-09 14:52:25'),
(944, '::1', '2025-06-09 14:52:25');

-- --------------------------------------------------------

--
-- Table structure for table `websites`
--

CREATE TABLE `websites` (
  `id_websites` int(11) NOT NULL,
  `name_website` varchar(255) NOT NULL,
  `url` varchar(500) NOT NULL,
  `image_name` varchar(500) NOT NULL,
  `original_name` varchar(500) NOT NULL,
  `is_active` int(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(10) UNSIGNED NOT NULL,
  `show_footer` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `activities_files`
--
ALTER TABLE `activities_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_id` (`activities_id`);

--
-- Indexes for table `activities_images`
--
ALTER TABLE `activities_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_id` (`activities_id`);

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id_article`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `audit_committee`
--
ALTER TABLE `audit_committee`
  ADD PRIMARY KEY (`id_committee`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `position1` (`position1`);

--
-- Indexes for table `audit_committee_group`
--
ALTER TABLE `audit_committee_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banner`
--
ALTER TABLE `banner`
  ADD PRIMARY KEY (`id_banner`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indexes for table `document_composition`
--
ALTER TABLE `document_composition`
  ADD PRIMARY KEY (`id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `event_banner`
--
ALTER TABLE `event_banner`
  ADD PRIMARY KEY (`id_event`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `faq_files`
--
ALTER TABLE `faq_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faq_id` (`faq_id`);

--
-- Indexes for table `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`id_personal`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `department` (`department`);

--
-- Indexes for table `personal_group`
--
ALTER TABLE `personal_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `visited_at` (`visited_at`);

--
-- Indexes for table `websites`
--
ALTER TABLE `websites`
  ADD PRIMARY KEY (`id_websites`),
  ADD KEY `updated_by` (`updated_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `activities_files`
--
ALTER TABLE `activities_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `activities_images`
--
ALTER TABLE `activities_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `id_article` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `audit_committee`
--
ALTER TABLE `audit_committee`
  MODIFY `id_committee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `audit_committee_group`
--
ALTER TABLE `audit_committee_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `banner`
--
ALTER TABLE `banner`
  MODIFY `id_banner` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `document_composition`
--
ALTER TABLE `document_composition`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `event_banner`
--
ALTER TABLE `event_banner`
  MODIFY `id_event` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `faq_files`
--
ALTER TABLE `faq_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `personal`
--
ALTER TABLE `personal`
  MODIFY `id_personal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `personal_group`
--
ALTER TABLE `personal_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=945;

--
-- AUTO_INCREMENT for table `websites`
--
ALTER TABLE `websites`
  MODIFY `id_websites` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `activities_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `activities_files`
--
ALTER TABLE `activities_files`
  ADD CONSTRAINT `activities_files_ibfk_1` FOREIGN KEY (`activities_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `activities_images`
--
ALTER TABLE `activities_images`
  ADD CONSTRAINT `activities_images_ibfk_1` FOREIGN KEY (`activities_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `article_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `audit_committee`
--
ALTER TABLE `audit_committee`
  ADD CONSTRAINT `audit_committee_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `audit_committee_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `audit_committee_ibfk_3` FOREIGN KEY (`position1`) REFERENCES `audit_committee_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `banner`
--
ALTER TABLE `banner`
  ADD CONSTRAINT `banner_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `document_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `document_ibfk_3` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `document_composition`
--
ALTER TABLE `document_composition`
  ADD CONSTRAINT `document_composition_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `document_composition_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `event_banner`
--
ALTER TABLE `event_banner`
  ADD CONSTRAINT `event_banner_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `faq_files`
--
ALTER TABLE `faq_files`
  ADD CONSTRAINT `faq_files_ibfk_1` FOREIGN KEY (`faq_id`) REFERENCES `faqs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `personal_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `personal_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `personal_ibfk_3` FOREIGN KEY (`department`) REFERENCES `personal_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `websites`
--
ALTER TABLE `websites`
  ADD CONSTRAINT `websites_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
