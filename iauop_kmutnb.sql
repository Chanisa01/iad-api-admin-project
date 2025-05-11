-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 11, 2025 at 04:39 AM
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

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`id`, `category_id`, `title`, `cover`, `description`, `uploaded_at`, `is_active`, `updated_at`, `updated_by`) VALUES
(21, 8, 'SCI Week', 'cover_681997558e7cb.png', '<h2><strong>กิจกรรมวิทยาศาสตร์สำหรับเยาวชน</strong></h2><p>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong></p><blockquote><ol><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/1.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%82%E0%B9%88%E0%B8%87%E0%B8%82%E0%B8%B1%E0%B8%99%E0%B8%A7%E0%B8%B2%E0%B8%94%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%8C%E0%B8%95%E0%B8%B9%E0%B8%99%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%A7%E0%B8%B2%E0%B8%94%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B8%88%E0%B8%B4%E0%B8%99%E0%B8%95%E0%B8%99%E0%B8%B2%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%97%E0%B8%B2%E0%B8%87%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C_2567%20.pdf\">การแข่งขันวาดภาพการ์ตูนและวาดภาพจินตนาการทางวิทยาศาสตร์</a></li><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/2.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%82%E0%B9%88%E0%B8%87%E0%B8%82%E0%B8%B1%E0%B8%99%E0%B8%95%E0%B8%AD%E0%B8%9A%E0%B8%9B%E0%B8%B1%E0%B8%8D%E0%B8%AB%E0%B8%B2%E0%B8%97%E0%B8%B2%E0%B8%87%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C_2567.pdf\">การแข่งขันตอบปัญหาทางวิทยาศาสตร์</a></li><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/3.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%82%E0%B9%88%E0%B8%87%E0%B8%82%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B8%9A%E0%B8%A7%E0%B8%99%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%81%E0%B9%89%E0%B8%9B%E0%B8%B1%E0%B8%8D%E0%B8%AB%E0%B8%B2%E0%B8%97%E0%B8%B2%E0%B8%87%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C_2567.pdf\">การแข่งขันกระบวนการแก้ปัญหาทางวิทยาศาสตร์</a></li><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/4.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%81%E0%B8%A7%E0%B8%94%E0%B8%AA%E0%B8%B4%E0%B9%88%E0%B8%87%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%94%E0%B8%B4%E0%B8%A9%E0%B8%90%E0%B9%8C%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%99%E0%B8%A7%E0%B8%B1%E0%B8%95%E0%B8%81%E0%B8%A3%E0%B8%A3%E0%B8%A1%E0%B8%99%E0%B8%B1%E0%B8%81%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C%E0%B8%99%E0%B9%89%E0%B8%AD%E0%B8%A2_2567.pdf\">การประกวดสิ่งประดิษฐ์และนวัตกรรมนักวิทยาศาสตร์น้อย</a></li><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/5.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%81%E0%B8%A7%E0%B8%94%E0%B9%82%E0%B8%84%E0%B8%A3%E0%B8%87%E0%B8%87%E0%B8%B2%E0%B8%99%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C%E0%B8%A3%E0%B8%B0%E0%B8%94%E0%B8%B1%E0%B8%9A%E0%B8%A1%E0%B8%B1%E0%B8%98%E0%B8%A2%E0%B8%A1%E0%B8%A8%E0%B8%B6%E0%B8%81%E0%B8%A9%E0%B8%B2_2567.pdf\">การประกวดโครงงานวิทยาศาสตร์ระดับมัธยมศึกษา - สมาคมวิทยาศาสตร์ฯ - อพวช.</a></li></ol></blockquote>', '2025-05-05', 1, '2025-05-06 05:00:05', 57),
(22, 8, 'ทดสอบกิจกรรม', 'cover_6819b279ce928.png', '<blockquote><p>ทดสอบ</p></blockquote>', '2025-05-05', 0, '2025-05-06 06:55:53', 57);

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

--
-- Dumping data for table `activities_files`
--

INSERT INTO `activities_files` (`id`, `activities_id`, `file_name`, `original_name`, `uploaded_at`) VALUES
(78, 21, 'file_681997559b01b.pdf', 'ทดสอบ.pdf', '2025-05-06 05:00:05');

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

--
-- Dumping data for table `activities_images`
--

INSERT INTO `activities_images` (`id`, `activities_id`, `image_name`, `original_name`, `uploaded_at`) VALUES
(91, 21, 'img_68199755943fb.jpg', 'istockphoto-1402906380-2048x2048.jpg', '2025-05-06 05:00:05'),
(92, 21, 'img_681997559934e.jpg', 'istockphoto-1779283335-2048x2048.jpg', '2025-05-06 05:00:05'),
(94, 22, 'img_6819b2be9f87c.jpg', 'istockphoto-516449022-2048x2048.jpg', '2025-05-06 06:57:02'),
(95, 22, 'img_6819b2bea13cb.jpg', 'istockphoto-610864024-2048x2048.jpg', '2025-05-06 06:57:02');

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
(1, 12, '<ol><li>เมื่อวันที่ 19 สิงหาคม 2519 รัฐบาลกำหนดให้ส่วนราชการมีผู้ตรวจสอบกายในมีสายการบังคับบัญชาขึ้นตรงต่อหัวหน้าส่วนราชการ ซึ่งแต่งตั้งจากนักวิชาการเงินและบัญชี การตรวจสอบจะมุ่งมั่นทางทางการเงินและบัญชี ในปี พ.ศ. 2539 มีงานตรวจสอบภายใน ทำหน้าที่ตรวจสอบกิจการทั้งปวงของมหาวิทยาลัย</li></ol><ul><li>ในปี พ.ศ. 2550 มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือมีฐานะเป็นหน่วยงานในกำกับของรัฐตามพระราชบัญญัติมหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ พ.ศ. 2550 โดยมีสภามหาวิทยาลัยทำหน้าที่ควบคุม ดูแล การดำเนินงานของมหาวิทยาลัย ซึ่งตามมาตรา 49 ให้มหาวิทยาลัยจัดให้มีระบบการตรวจสอบภายในเพื่อตรวจสอบการดำเนินการต่าง ๆ ของมหาวิทยาลัย</li><li>22 กุมภาพันธ์ 2555 สภามหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ มีมติอนุมัติจัดตั้งหน่วยตรวจสอบภายใน (Internal Audit Unit) เป็นหน่วยงานระดับกอง สังกัดสำนักงานอธิการบดี</li></ul><blockquote><figure class=\"media\"><oembed url=\"https://www.youtube.com/watch?v=qCwipEvgEyg\"></oembed></figure></blockquote>', NULL, NULL, '2025-05-08 09:25:06', 57),
(2, 13, '<ul><li>สร้างความเชื่อมั่นด้านการตรวจสอบ ด้วยแนวทางที่ทันสมัย ตามมาตรฐานสากล</li></ul>', NULL, NULL, '2025-05-06 08:23:12', 57),
(3, 14, 'ประเมินระบบการควบคุมภายในและสอบทานการปฎิบัติงานเพื่อให้ผู้บริหารเกิดความเชื่อมั่นว่าการปฎิบัติงานเป็นไปตามวัตถุประสงค์ เป้าหมาย และสอดคล้องกับนโยบายของมหาวิทยาลัยxxxx', NULL, NULL, '2025-02-24 21:32:52', 58),
(4, 15, '<p><i><strong>ตรวจสอบด้วยกัลยาณมิตร เกิดผลสัมฤทธิ์ตามเป้าหมาย</strong></i></p>', NULL, NULL, '2025-05-06 08:25:01', 57),
(5, 16, '', 'structure_681af6f22dfc5.png', 'ChatGPT Image Apr 1, 2025, 01_00_55 PM.png', '2025-05-07 13:00:18', 57),
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
  `position1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
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
(18, 7, 'นางสาว', 'พิมพ์จันทร์', 'บัณฑรพงศ์', '68199164d3b64.jpg', 'เลขานุการ', 'หัวหน้าหน่วยตรวจสอบภายใน', 1, 2558, 2560, 'test@gmail.com', '095-000-0000', 1, '2025-05-06 04:48:18', 57),
(19, 7, 'นาย', 'วิทรัส', 'สวัสดิ์-ชูโต', '', 'กรรมการ', 'ผู้ทรงคุณวุฒิภายนอก', 1, 2558, 2560, 'test@gmail.com', '098-000-0000', 0, '2025-05-06 04:48:11', 57),
(20, 7, 'นางสาว', 'เฟื่องฟ้า', 'เทียนประภาสิทธิ์', '68199474352c3.jpg', 'กรรมการ', 'ผู้ทรงคุณวุฒิภายนอก', 0, 2560, 2562, 'test@gmail.com', '095-000-0001', 1, '2025-05-06 04:47:48', 57),
(21, 7, 'ศาสตราจารย์ ดร.', 'ธีรวุฒิ', 'ชอบผล', '', 'กรรมการ', 'ผู้ทรงคุณวุฒิภายนอก', 0, 2558, 2560, 'test@gmail.com', '096-666-6666', 0, '2025-05-06 04:30:18', 57),
(23, 7, 'ศาสตราจารย์', 'มักกอนนา', 'เกา', '', '', '', 0, 0, 0, '', '', 1, '2025-05-08 09:16:50', 57),
(24, 7, 'test1', 'ะ', 'ะ', '', '', '', 0, 2530, NULL, '', '', 1, '2025-05-08 09:40:06', 57),
(25, 7, 's', 's', 's', '', '', '', 0, 0, 2544, '', '', 1, '2025-05-08 09:41:46', 57),
(26, 7, '55', '55', '55', '', '', '', 0, 2500, 3333, 'eoo@hit.vom', '044-442-2222', 1, '2025-05-09 04:00:21', 57),
(27, 7, '5', '5', '5', '', '', '', 0, 0, 0, '', '', 0, '2025-05-09 04:00:27', 57),
(28, 7, 'r', 'r', 'r', '', '', '', 0, 2555, NULL, '', '', 1, '2025-05-09 08:14:04', 57),
(29, 7, 'r', 'r', 'rrrr', '', '', '', 0, 2555, NULL, '', '', 1, '2025-05-09 08:15:04', 57);

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

--
-- Dumping data for table `banner`
--

INSERT INTO `banner` (`id_banner`, `image_name`, `url`, `display_order`, `original_name`, `is_active`, `updated_at`, `updated_by`) VALUES
(23, 'banner_681998912ff4c.png', 'www.kmutnb.ac.th', 3, '3.png', 1, '2025-05-06 05:05:21', 57),
(24, 'banner_681998b873f8c.png', 'www.kmutnb.ac.th', 1, 'Open House ป้าย แบนเนอร์.png', 0, '2025-05-06 05:06:00', 57),
(25, 'banner_6819b514ef4a0.png', '', 2, '3.png', 1, '2025-05-06 07:07:00', 57),
(26, 'banner_681e306f3edcf.png', 'www.kmutnb.ac.th', 4, 'logo_iau_kmutnb.png', 0, '2025-05-09 16:42:23', 57),
(27, 'banner_681e324cc50f1.png', '', 5, 'A_logo_represents_the_Internal_Audit_Unit_(IAU)_of.png', 0, '2025-05-09 16:50:20', 57),
(28, 'banner_681e3638505a8.png', NULL, 6, 'logo_iau_kmutnb.png', 0, '2025-05-09 17:07:04', 57),
(29, 'banner_681e370300581.png', 'undefined', 7, 'A_logo_represents_the_Internal_Audit_Unit_(IAU)_of-Photoroom.png', 0, '2025-05-09 17:10:27', 57),
(30, 'banner_681e38143f5f9.png', '', 8, 'ChatGPT Image May 6, 2025, 12_30_09 AM.png', 0, '2025-05-09 17:15:00', 57),
(31, 'banner_681e3875138c9.png', 'หหหห', 9, 'A_logo_represents_the_Internal_Audit_Unit_(IAU)_of-Photoroom.png', 0, '2025-05-09 17:16:37', 57);

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
(10, 'คำถามที่พบบ่อย', 'information/faq/', '2025-04-06 11:40:38'),
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
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `type` enum('ร้องเรียน','ข้อเสนอแนะ') NOT NULL,
  `details` text NOT NULL,
  `status` enum('ใหม่','กำลังดำเนินการ','เสร็จสิ้น') DEFAULT 'ใหม่',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `name`, `email`, `phone`, `type`, `details`, `status`, `created_at`) VALUES
(1, 'สมชาย ใจดี', 'somchai@example.com', '0812345678', 'ร้องเรียน', 'พบว่าระบบลงทะเบียนล่มบ่อยครั้ง', 'ใหม่', '2025-05-01 09:30:00'),
(2, 'สุพัตรา แก้วใส', 'supattra.k@example.com', '0899998888', 'ข้อเสนอแนะ', 'อยากให้เพิ่มระบบแจ้งเตือนก่อนวันหมดเขตส่งเอกสาร', 'กำลังดำเนินการ', '2025-05-02 11:45:00'),
(3, 'John Doe', 'john.doe@example.com', '0822223333', 'ร้องเรียน', 'เจ้าหน้าที่ตอบกลับล่าช้ามาก', 'เสร็จสิ้น', '2025-04-28 14:00:00'),
(4, 'กิตติชัย มั่งมี', 'kitti.m@example.com', '0831234567', 'ข้อเสนอแนะ', 'ควรมีคู่มือการใช้งานระบบแบบ PDF ให้ดาวน์โหลด', 'ใหม่', '2025-05-03 08:10:00'),
(5, 'อรณิชา วิไลวรรณ', 'ornnicha.v@example.com', '0866543210', 'ร้องเรียน', 'หน้าเว็บโหลดช้าและไม่รองรับมือถือ', 'ใหม่', '2025-05-05 13:25:00');

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
(5, 'กฎบัตรการตรวจสอบภายใน', 'document_5_681978fd34221.pdf', 1, 57, 57, '2025-04-11', 1),
(6, 'ระเบียบว่าด้วยการตรวจสอบภายใน', 'document_6_681979098a406.pdf', 1, 57, 57, '2025-04-19', 1),
(7, 'มาตรฐานการตรวจสอบ', 'document_7_681c0b266b7e3.pdf', 1, 57, 57, '2025-04-07', 0),
(56, 'เอกสารวาระตำแหน่งปี 2564', 'document_1746034583_68125f97e618e.pdf', 11, 57, 57, '2025-05-08', 1),
(78, 'กฎบัตรคณะกรรมการตรวจสอบ', 'document_1746505080_68198d784a702.pdf', 2, 57, 57, '2025-05-01', 1),
(79, 'รายงานผลการดำเนินงานของคตส.', 'document_1746506954_681994ca1a0a5.pdf', 3, 57, 57, '2025-05-05', 1),
(80, 'รายงานผลการดำเนินงานหน่วยตรวจสอบภายใน', 'document_1746506988_681994ec6a4b6.pdf', 3, 57, 57, '2025-05-04', 1),
(81, 'รายงานผลการประกันและปรับปรุงคุณภาพ', 'document_1746507035_6819951b75089.pdf', 3, 57, 57, '2025-05-05', 0),
(82, 'Excel', 'document_1746507667_681997935c2a2.xlsx', 9, NULL, 57, '2025-05-05', 1),
(83, 'PDF', 'document_1746507693_681997ad06e5c.pdf', 9, NULL, 57, '2025-05-05', 0),
(84, 'แผนการตรวจสอบภายใน', 'document_1746507869_6819985df2be0.pdf', 5, 57, 57, '2025-05-05', 0),
(85, 'แผนการพัฒนาบุคลากร', 'document_1746507889_681998713855b.pdf', 5, 57, 57, '2025-05-05', 0),
(86, 'แผนยุทธศาสตร์', 'document_1746507903_6819987f1dcf5.pdf', 5, 57, 57, '2025-05-05', 0);

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id_documents` tinyint(4) NOT NULL,
  `topic_th` text NOT NULL,
  `filename` varchar(500) NOT NULL,
  `description_th` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `updated_at` datetime NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id_documents`, `topic_th`, `filename`, `description_th`, `updated_at`, `updated_by`) VALUES
(1, 'cccปปป', 'AuditStandards.pdf', '', '2025-02-27 14:17:05', 57),
(2, 'testt', 'InternalAuditRegulations.pdf', 'j', '2025-03-06 09:05:49', 57),
(3, 'glasses', 'oo.pdf', 'jj', '0000-00-00 00:00:00', 58);

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
(5, 'วาระที่ 2558 ถึง 2559', 'document_1746505340_68198e7c7b424.pdf', 11, 57, '2025-04-30', 1, 2558, 2564),
(6, 'วาระที่ 2560 ถึง 2562', 'document_1746505385_68198ea94428f.pdf', 11, 57, '2025-05-01', 1, 2560, 2562),
(8, 'i', 'document_1746775677_681dae7de55b0.pdf', 11, 57, '2025-05-08', 1, 2555, 2555);

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

--
-- Dumping data for table `event_banner`
--

INSERT INTO `event_banner` (`id_event`, `image_name`, `original_name`, `is_active`, `updated_at`, `updated_by`) VALUES
(10, 'event_681999348f7a9.png', 'event_banner1.png', 0, '2025-05-06 05:08:12', 57),
(11, 'event_681999424aff3.png', 'event_banner2.png', 0, '2025-05-06 05:08:18', 57),
(12, 'event_6819b53f77c98.png', 'event_banner2.png', 1, '2025-05-06 07:07:58', 57);

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `title` text COLLATE utf8mb4_general_ci NOT NULL COMMENT 'หัวข้อคำถาม',
  `description` text COLLATE utf8mb4_general_ci NOT NULL COMMENT 'รายละเอียดคำถาม',
  `is_active` int(1) NOT NULL DEFAULT '0',
  `uploaded_at` date DEFAULT NULL COMMENT 'วันที่อัปโหลด',
  `updated_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'รหัสแอดมินที่แก้ไขข้อมูล'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `title`, `description`, `is_active`, `uploaded_at`, `updated_by`) VALUES
(16, 'วิธีดึงข้อความจากรูปใน LINE OCR', '<p><i>ทดสอบ</i></p>', 1, '2025-05-05', 57);

-- --------------------------------------------------------

--
-- Table structure for table `faq_files`
--

CREATE TABLE `faq_files` (
  `id` int(11) NOT NULL,
  `faq_id` int(11) NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ชื่อไฟล์ในระบบ (ที่เก็บในโฟลเดอร์)',
  `original_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ชื่อไฟล์ต้นฉบับที่อัปโหลด',
  `uploaded_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'วันที่อัปโหลดไฟล์'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faq_files`
--

INSERT INTO `faq_files` (`id`, `faq_id`, `file_name`, `original_name`, `uploaded_at`) VALUES
(33, 16, '6819980858346_________________-_Copy.pdf', 'ทดสอบ - Copy.pdf', '2025-05-06 12:03:04'),
(34, 16, '681998085bc7a________________.pdf', 'ทดสอบ.pdf', '2025-05-06 12:03:04');

-- --------------------------------------------------------

--
-- Table structure for table `information`
--

CREATE TABLE `information` (
  `id_information` tinyint(4) NOT NULL,
  `description_th` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `information`
--

INSERT INTO `information` (`id_information`, `description_th`, `updated_at`, `updated_by`) VALUES
(1, 'ทดสอบss', '2025-05-01 16:02:16', 57),
(2, 'ส895ccc', '2025-02-26 13:53:33', 57),
(3, 'ประเมินระบบการควบคุมภายในและสอบทานการปฎิบัติงานเพื่อให้ผู้บริหารเกิดความเชื่อมั่นว่าการปฎิบัติงานเป็นไปตามวัตถุประสงค์ เป้าหมาย และสอดคล้องกับนโยบายของมหาวิทยาลัยxxxx', '2025-02-24 21:32:52', 58),
(4, '55555', '2025-02-28 15:15:45', 57),
(5, 'คณะกรรมการตรวจสอบ\nคำสั่งสภามหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ ที่ 065/2565 สั่ง ณ วันที่ 3 ตุลาคม 2565\nวาระตำแหน่ง 2 ปี ตั้งแต่วันที่ 1 ตุลาคม 2565 ถึงวันที่ 30 กันยายน 2565', '2025-03-25 15:11:41', 57);

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
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
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
(184, 6, 'นางสาว', 'ใจดี', 'ใจเบิกบาน', 'หน่วยตรวจสอบภายใน', 'นักวิชาการ', 1, 'test@op.kmutnb.ac.th', '0-2555-2000', '1116', 'Personel_184_1746504716.jpg', 1, '2025-05-06 04:11:56', 57),
(185, 6, 'นาย', 'จิตใจดี', 'ใจเบิกบาน', 'หน่วยตรวจสอบภายใน', 'นักวิชาการ', 1, 'test@op.kmutnb.ac.th', '0-2555-2000', '1117', 'Personel_185_1746504779.jpg', 1, '2025-05-06 04:12:59', 57),
(186, 6, 'นาง', 'สมหญิง', 'เป็นมิตร', 'หน่วยงานตรวจสอบภายใน', 'นักวิชาการ', 1, 'test@op.kmutnb.ac.th', '0-2555-2000', '1118', 'Personel_186_1746504843.jpg', 0, '2025-05-06 04:14:03', 57),
(187, 6, 'นาย', 'นิวตัน', 'ใจดี', 'หน่วยตรวจสอบภายใน', 'นักวิชาการ', 0, 'test@op.kmutnb.ac.th', '0-2555-2000', '1120', 'Personel_187_1746504904.jpg', 1, '2025-05-06 04:15:04', 57),
(189, 6, 'นาง', 'ฌานิศา', 'อิ่มลิ้มทาน', '', '', 1, '', '', '', 'Personel_189_1746673549.png', 1, '2025-05-08 03:03:30', 57),
(193, 6, 'g', 'g', 'g', '', '', 0, '', '', '', NULL, 1, '2025-05-09 17:09:14', 57);

-- --------------------------------------------------------

--
-- Table structure for table `structure`
--

CREATE TABLE `structure` (
  `id_structure` tinyint(4) NOT NULL,
  `image_name` varchar(255) NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `structure`
--

INSERT INTO `structure` (`id_structure`, `image_name`, `updated_at`, `updated_by`) VALUES
(1, 'structure_28-02-2025.png', '2025-02-28 15:15:34', 57);

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
(57, '1729900557095', 'ฌานิศา', 'อิ่มลิ้มทาน', 'Chanisa', 'Aimlimthan', '', 'chanisaa', 1, '2025-05-10 23:07:02', '2025-02-05 06:55:49', '', 1, NULL, NULL, '2025-05-05 01:15:42', 57),
(58, '1729900557094', 'ทดสอบ', 'ทดสอบ', NULL, NULL, '', 'pimpikaa', 2, NULL, '2025-02-26 07:09:56', NULL, 1, NULL, NULL, '2025-05-05 23:26:50', 57);

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
-- Dumping data for table `websites`
--

INSERT INTO `websites` (`id_websites`, `name_website`, `url`, `image_name`, `original_name`, `is_active`, `updated_at`, `updated_by`, `show_footer`) VALUES
(15, 'สำนักงานคณะกรรมการป้องกันและปราบปรามการทุจริตแห่งชาติ', 'https://www.nacc.go.th/', 'web_1746502318.png', 'Emblem_of_the_National_Anti-Corruption_Commission_Thailand.png', 1, '2025-05-06 03:31:58', 57, 0),
(16, 'กรมบัญชีกลาง', 'https://www.cgd.go.th/', 'web_1746502460.png', '541_739_______________.png', 1, '2025-05-06 03:34:20', 57, 0),
(17, 'สภาวิชาชีพบัญชี', 'https://www.tfac.or.th/', 'web_1746502631.png', 'logo สภาฯ-01.png', 1, '2025-05-06 03:37:11', 57, 0),
(18, 'ISACA Bangkok Chapter ', 'https://www.isaca-bangkok.org/', 'web_1746502830.jpg', '308411627_454971329991729_7279520091625163665_n.jpg', 1, '2025-05-06 03:40:30', 57, 0),
(19, 'Institute Of Internal Auditors Thailand', 'https://www.theiiat.or.th/', 'web_1746503042.png', 'IIT.png', 1, '2025-05-06 03:44:02', 57, 0),
(20, 'รัฐบาลไทย', 'https://www.thaigov.go.th/main/contents', 'web_1746503240.png', 'Seal_of_the_Office_of_the_Prime_Minister_of_Thailand.png', 1, '2025-05-06 03:47:20', 57, 0),
(21, 'สำนักงานการตรวจเงินแผ่นดิน', 'https://www.audit.go.th/th/home', 'web_1746503307.png', 'Emblem_of_the_State_Audit_Office_of_the_Kingdom_of_Thailand.png', 1, '2025-05-06 03:48:27', 57, 0),
(22, 'กองคลัง', 'https://finance.op.kmutnb.ac.th/home.php', 'web_1746503413.png', 'logo_of_KMUTNB.png', 1, '2025-05-06 03:50:13', 57, 1),
(24, 'ทดสอบ', 'www.test.com', 'web_1746515133.png', 'logo_of_KMUTNB.png', 1, '2025-05-06 07:05:33', 57, 0);

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
  ADD KEY `category_id` (`category_id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id_documents`),
  ADD KEY `id` (`updated_by`);

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
-- Indexes for table `information`
--
ALTER TABLE `information`
  ADD PRIMARY KEY (`id_information`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`id_personal`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `structure`
--
ALTER TABLE `structure`
  ADD PRIMARY KEY (`id_structure`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `activities_files`
--
ALTER TABLE `activities_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `activities_images`
--
ALTER TABLE `activities_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `id_article` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `audit_committee`
--
ALTER TABLE `audit_committee`
  MODIFY `id_committee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `banner`
--
ALTER TABLE `banner`
  MODIFY `id_banner` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `document_composition`
--
ALTER TABLE `document_composition`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `event_banner`
--
ALTER TABLE `event_banner`
  MODIFY `id_event` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `faq_files`
--
ALTER TABLE `faq_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `personal`
--
ALTER TABLE `personal`
  MODIFY `id_personal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `websites`
--
ALTER TABLE `websites`
  MODIFY `id_websites` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
  ADD CONSTRAINT `audit_committee_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `banner`
--
ALTER TABLE `banner`
  ADD CONSTRAINT `banner_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `document_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `document_ibfk_3` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

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
-- Constraints for table `information`
--
ALTER TABLE `information`
  ADD CONSTRAINT `information_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `personal_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `personal_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `structure`
--
ALTER TABLE `structure`
  ADD CONSTRAINT `structure_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `websites`
--
ALTER TABLE `websites`
  ADD CONSTRAINT `websites_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
