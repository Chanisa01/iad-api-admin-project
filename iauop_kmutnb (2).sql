-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 04, 2025 at 04:07 AM
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
(21, 8, 'SCI Week', 'cover_681997558e7cb.png', '<h2><strong>กิจกรรมวิทยาศาสตร์สำหรับเยาวชน</strong></h2><h3><strong>กิจกรรมวิทยาศาสตร์สำหรับเยาวชน</strong></h3><h4><strong>กิจกรรมวิทยาศาสตร์สำหรับเยาวชน</strong></h4><ul><li><i>เนื่องในสัปดาห์<strong>วิทยาศาสตร์</strong>แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong> </strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong>เนื่องในสัปดาห์วิทยาศาสตร์แห่งชาติ ปี 2568 &nbsp;รายละเอียดและกติกาการแข่งขันของแต่ละกิจกรรม<strong>&nbsp;</strong></i></li></ul><figure class=\"table\"><table><tbody><tr><td>ลำดับ</td><td>ตัวแปร</td></tr><tr><td>1</td><td>คาบอนไดออกไซด์</td></tr></tbody></table></figure><p><strong>ทดสอบ</strong></p><figure class=\"media\"><oembed url=\"https://www.youtube.com/watch?v=59elf3_11dA\"></oembed></figure><blockquote><ol><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/1.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%82%E0%B9%88%E0%B8%87%E0%B8%82%E0%B8%B1%E0%B8%99%E0%B8%A7%E0%B8%B2%E0%B8%94%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%8C%E0%B8%95%E0%B8%B9%E0%B8%99%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%A7%E0%B8%B2%E0%B8%94%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B8%88%E0%B8%B4%E0%B8%99%E0%B8%95%E0%B8%99%E0%B8%B2%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%97%E0%B8%B2%E0%B8%87%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C_2567%20.pdf\">การแข่งขันวาดภาพการ์ตูนและวาดภาพจินตนาการทางวิทยาศาสตร์</a></li><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/2.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%82%E0%B9%88%E0%B8%87%E0%B8%82%E0%B8%B1%E0%B8%99%E0%B8%95%E0%B8%AD%E0%B8%9A%E0%B8%9B%E0%B8%B1%E0%B8%8D%E0%B8%AB%E0%B8%B2%E0%B8%97%E0%B8%B2%E0%B8%87%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C_2567.pdf\">การแข่งขันตอบปัญหาทางวิทยาศาสตร์</a></li><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/3.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%82%E0%B9%88%E0%B8%87%E0%B8%82%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B8%9A%E0%B8%A7%E0%B8%99%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%81%E0%B9%89%E0%B8%9B%E0%B8%B1%E0%B8%8D%E0%B8%AB%E0%B8%B2%E0%B8%97%E0%B8%B2%E0%B8%87%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C_2567.pdf\">การแข่งขันกระบวนการแก้ปัญหาทางวิทยาศาสตร์</a></li><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/4.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%81%E0%B8%A7%E0%B8%94%E0%B8%AA%E0%B8%B4%E0%B9%88%E0%B8%87%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%94%E0%B8%B4%E0%B8%A9%E0%B8%90%E0%B9%8C%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%99%E0%B8%A7%E0%B8%B1%E0%B8%95%E0%B8%81%E0%B8%A3%E0%B8%A3%E0%B8%A1%E0%B8%99%E0%B8%B1%E0%B8%81%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C%E0%B8%99%E0%B9%89%E0%B8%AD%E0%B8%A2_2567.pdf\">การประกวดสิ่งประดิษฐ์และนวัตกรรมนักวิทยาศาสตร์น้อย</a></li><li>&nbsp; &nbsp; &nbsp;<a href=\"https://www.scisoc.or.th/image/%E0%B8%AA%E0%B8%B1%E0%B8%9B%E0%B8%94%E0%B8%B2%E0%B8%AB%E0%B9%8C%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C/67/5.%20%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%81%E0%B8%A7%E0%B8%94%E0%B9%82%E0%B8%84%E0%B8%A3%E0%B8%87%E0%B8%87%E0%B8%B2%E0%B8%99%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%A8%E0%B8%B2%E0%B8%AA%E0%B8%95%E0%B8%A3%E0%B9%8C%E0%B8%A3%E0%B8%B0%E0%B8%94%E0%B8%B1%E0%B8%9A%E0%B8%A1%E0%B8%B1%E0%B8%98%E0%B8%A2%E0%B8%A1%E0%B8%A8%E0%B8%B6%E0%B8%81%E0%B8%A9%E0%B8%B2_2567.pdf\">การประกวดโครงงานวิทยาศาสตร์ระดับมัธยมศึกษา - สมาคมวิทยาศาสตร์ฯ - อพวช.</a></li></ol></blockquote>', '2025-05-05', 1, '2025-05-06 05:00:05', 57),
(22, 8, 'Summer Active', 'cover_6819b279ce928.png', '<h3>มหัศจรรย์แห่งท้องทะเล</h3><p><strong>ความงามที่ซ่อนอยู่ในผืนฟ้าสีน้ำเงิน</strong></p><ul><li>ทะเล คือหนึ่งในทรัพยากรธรรมชาติที่ยิ่งใหญ่และงดงามที่สุดของโลก ผืนน้ำสีฟ้าที่ทอดยาวสุดลูกหูลูกตา ไม่เพียงเป็นแหล่งอาหารและที่อยู่อาศัยของสัตว์น้ำนานาชนิด แต่ยังเป็นสถานที่พักผ่อนหย่อนใจของผู้คนทั่วโลก</li><li>คลื่นที่กระทบฝั่งอย่างสม่ำเสมอ เปรียบเสมือนจังหวะชีวิตของธรรมชาติ เสียงคลื่นให้ความรู้สึกสงบ ผ่อนคลาย และช่วยเยียวยาจิตใจจากความวุ่นวายของเมืองใหญ่ นอกจากนี้ ทะเลยังมีระบบนิเวศที่หลากหลาย ตั้งแต่แนวปะการังสีสันสดใส ป่าโกงกางที่อุดมสมบูรณ์ ไปจนถึงท้องทะเลลึกที่ยังมีความลับอีกมากมายให้ค้นหา</li></ul><p><strong>ทะเลยังมีบทบาทสำคัญต่อมนุษย์</strong><br>มันควบคุมอุณหภูมิโลก ผลักดันวงจรน้ำฝน และเป็นเส้นทางขนส่งทางเศรษฐกิจที่สำคัญ แต่ในขณะเดียวกัน ทะเลก็เปราะบางต่อการเปลี่ยนแปลงจากน้ำมือมนุษย์ ไม่ว่าจะเป็นขยะพลาสติก น้ำเสีย หรือการทำลายระบบนิเวศทางทะเลอย่างไม่รู้ตัว</p><p><strong>การอนุรักษ์ทะเลจึงเป็นเรื่องสำคัญที่ทุกคนมีส่วนร่วมได้</strong><br>เริ่มง่ายๆ จากการลดการใช้พลาสติก เลือกซื้ออาหารทะเลอย่างยั่งยืน หรือสนับสนุนโครงการฟื้นฟูทะเลในท้องถิ่น เพราะทุกการกระทำเล็กๆ ล้วนส่งผลต่อมหาสมุทรอันกว้างใหญ่ที่เราเรียกว่าทะเล</p>', '2025-05-29', 1, '2025-05-06 06:55:53', 57),
(26, 8, 'แจ้งเตือนเรื่องข้อผิดพลาด', 'cover_68352e1b1dad7.png', '<ul><li>ทดสอบ</li></ul>', '2025-05-16', 1, '2025-05-27 03:14:35', 57),
(27, 8, 'วันแม่แห่งชาติ 2567', 'cover_6836caf626313.png', '<h3>วันแม่แห่งชาติ</h3><p><strong>วันสำคัญเพื่อระลึกถึงพระคุณของแม่</strong></p><p>ในประเทศไทย วันที่ <strong>12 สิงหาคมของทุกปี</strong> ถูกกำหนดให้เป็น <strong>วันแม่แห่งชาติ</strong> ซึ่งตรงกับวันคล้ายวันพระราชสมภพของ <strong>สมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถ พระบรมราชชนนีพันปีหลวง</strong> นอกจากจะเป็นวันสำคัญระดับชาติแล้ว ยังเป็นวันที่ลูกๆ ทั่วประเทศได้แสดงความรักและความกตัญญูต่อแม่ผู้ให้กำเนิดและเลี้ยงดูเรามาด้วยความเสียสละ</p><p><strong>ความหมายของแม่</strong> ไม่ได้มีเพียงแค่คำว่า “ผู้ให้กำเนิด” เท่านั้น แต่แม่คือครูคนแรกของชีวิต เป็นคนที่อดทน ฝ่าฟันอุปสรรคต่างๆ เพื่อให้ลูกมีชีวิตที่ดี ทั้งทางร่างกาย จิตใจ และจริยธรรม การสั่งสอนและความห่วงใยของแม่จึงเปรียบเสมือนรากฐานที่มั่นคงของครอบครัว</p><p>ในวันแม่ ผู้คนมักแสดงความรักต่อแม่ด้วยหลากหลายวิธี เช่น</p><ul><li>มอบพวงมาลัยดอกมะลิ ซึ่งเป็นสัญลักษณ์ของความบริสุทธิ์และรักแท้</li><li>เขียนการ์ด หรือพูดคำว่ารักที่อาจไม่ได้พูดบ่อยๆ</li><li>ใช้เวลาอยู่ร่วมกันภายในครอบครัว</li><li>พาแม่ไปทำกิจกรรมหรือรับประทานอาหารร่วมกัน</li></ul><p>แม้ว่าเราจะเฉลิมฉลองวันแม่เพียงปีละครั้ง แต่ <strong>ความรักและความกตัญญูต่อแม่ควรมีในทุกวัน</strong> เพราะไม่มีสิ่งใดทดแทนความรักของแม่ได้</p>', '2025-05-28', 1, '2025-05-28 08:36:06', 57),
(28, 8, 'ทำบุญประจำปี ณ มจพ.', 'cover_6836cb057ee72.png', '<h3>ขอเรียนเชิญร่วมงานทำบุญประจำปี มจพ.</h3><p><strong>สืบสานประเพณี ส่งเสริมสิริมงคล</strong></p><p>มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ (มจพ.)<br>ขอเรียนเชิญ คณาจารย์ บุคลากร นักศึกษา ศิษย์เก่า ตลอดจนประชาชนทั่วไป<br><strong>ร่วมงานทำบุญประจำปี พ.ศ. [ระบุปี]</strong><br>เพื่อความเป็นสิริมงคลแก่ชีวิตและองค์กร รวมถึงการสืบสานวัฒนธรรมอันดีงามของไทย</p><p>🗓 <strong>วันจัดงาน</strong>: [ระบุวัน เดือน ปี]<br>📍 <strong>สถานที่</strong>: ณ บริเวณ [ระบุสถานที่ เช่น ลานพระบรมราชานุสาวรีย์ รัชกาลที่ 5 หรือ อาคาร... มจพ.]</p><p>ภายในงานจะมีกิจกรรมที่เปี่ยมไปด้วยความศรัทธา อาทิ</p><ul><li>พิธีทำบุญตักบาตรพระสงฆ์</li><li>พิธีเจริญพระพุทธมนต์</li><li>พิธีถวายภัตตาหารเพล</li><li>การแสดงทางวัฒนธรรม</li><li>นิทรรศการส่งเสริมจิตสำนึกและคุณธรรม</li></ul><p>การร่วมทำบุญในครั้งนี้ไม่เพียงแต่เพื่อเสริมสิริมงคลให้แก่ตนเองและครอบครัว<br>แต่ยังเป็นการแสดงออกถึงความสามัคคีในหมู่คณะ และส่งเสริมวัฒนธรรมไทยให้คงอยู่</p><p>🙏 จึงขอเรียนเชิญทุกท่านมาร่วมกันสั่งสมบุญ และร่วมสร้างบรรยากาศแห่งความสุข ความสงบ และความเป็นมงคล<br>ในโอกาสพิเศษนี้ด้วยกัน</p>', '2025-05-20', 1, '2025-05-28 08:36:21', 57),
(29, 8, 'วันแมวโลก', 'cover_6836cb1f43782.jpg', '<p>สุขสันต์วันแมวโลก</p>', '2025-05-13', 1, '2025-05-28 08:36:47', 57);

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
(78, 21, 'file_681997559b01b.pdf', 'ทดสอบ.pdf', '2025-05-06 05:00:05'),
(79, 21, 'file_68355fa3320d6.pdf', 'fake_data.pdf', '2025-05-27 06:45:55'),
(80, 21, 'file_68355fa3356de.pdf', 'test.pdf', '2025-05-27 06:45:55');

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
(95, 22, 'img_6819b2bea13cb.jpg', 'istockphoto-610864024-2048x2048.jpg', '2025-05-06 06:57:02'),
(101, 21, 'img_68357f7978727.png', 'social-media.png', '2025-05-27 09:01:45'),
(102, 21, 'img_68357f797ea89.png', '${ADMIN_API_BASE_URL}.png', '2025-05-27 09:01:45'),
(103, 21, 'img_68357f7981852.png', 'Screenshot 2025-05-15 083320.png', '2025-05-27 09:01:45'),
(104, 21, 'img_68357f7985319.png', 'globe.png', '2025-05-27 09:01:45'),
(105, 22, 'img_6835d1e0190d7.png', 'event_banner1.png', '2025-05-27 14:53:20');

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
(1, 12, '<ol><li>เมื่อวันที่ 19 สิงหาคม 2519 รัฐบาลกำหนดให้ส่วนราชการมีผู้ตรวจสอบกายในมีสายการบังคับบัญชาขึ้นตรงต่อหัวหน้าส่วนราชการ ซึ่งแต่งตั้งจากนักวิชาการเงินและบัญชี การตรวจสอบจะมุ่งมั่นทางทางการเงินและบัญชี ในปี พ.ศ. 2539 มีงานตรวจสอบภายใน ทำหน้าที่ตรวจสอบกิจการทั้งปวงของมหาวิทยาลัย</li></ol><ul><li>ในปี พ.ศ. 2550 มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือมีฐานะเป็นหน่วยงานในกำกับของรัฐตามพระราชบัญญัติมหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ พ.ศ. 2550 โดยมีสภามหาวิทยาลัยทำหน้าที่ควบคุม ดูแล การดำเนินงานของมหาวิทยาลัย ซึ่งตามมาตรา 49 ให้มหาวิทยาลัยจัดให้มีระบบการตรวจสอบภายในเพื่อตรวจสอบการดำเนินการต่าง ๆ ของมหาวิทยาลัย</li><li>22 กุมภาพันธ์ 2555 สภามหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ มีมติอนุมัติจัดตั้งหน่วยตรวจสอบภายใน (Internal Audit Unit) เป็นหน่วยงานระดับกอง สังกัดสำนักงานอธิการบดี</li></ul>', NULL, NULL, '2025-06-04 08:50:21', 57),
(2, 13, '<ul><li>สร้างความเชื่อมั่นด้านการตรวจสอบ ด้วยแนวทางที่ทันสมัย ตามมาตรฐานสากล</li></ul>', NULL, NULL, '2025-05-06 08:23:12', 57),
(3, 14, '<ul><li>ประเมินระบบการควบคุมภายในและสอบทานการปฎิบัติงานเพื่อให้ผู้บริหารเกิดความเชื่อมั่นว่าการปฎิบัติงานเป็นไปตามวัตถุประสงค์ เป้าหมาย และสอดคล้องกับนโยบายของมหาวิทยาลัย</li></ul>', NULL, NULL, '2025-06-04 08:51:14', 57),
(4, 15, '<ul><li>ตรวจสอบด้วยกัลยาณมิตร เกิดผลสัมฤทธิ์ตามเป้าหมาย</li></ul>', NULL, NULL, '2025-06-04 08:51:11', 57),
(5, 16, '', 'structure_683fa6ccd1278.png', 'OrgChart.png', '2025-06-04 08:52:12', 57),
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
(19, 7, 'นาย', 'วิทรัส', 'สวัสดิ์-ชูโต', '', 'กรรมการ', 'ผู้ทรงคุณวุฒิภายนอก', 1, 2558, 2560, 'test@gmail.com', '098-000-0000', 1, '2025-05-06 04:48:11', 57),
(20, 7, 'นางสาว', 'เฟื่องฟ้า', 'เทียนประภาสิทธิ์', '68199474352c3.jpg', 'กรรมการ', 'ผู้ทรงคุณวุฒิภายนอก', 0, 2558, 2560, 'test@gmail.com', '095-000-0001', 1, '2025-05-06 04:47:48', 57),
(21, 7, 'ศาสตราจารย์ ดร.', 'ธีรวุฒิ', 'ชอบผล', '', 'กรรมการ', 'ผู้ทรงคุณวุฒิภายนอก', 0, 2560, 2561, 'test@gmail.com', '096-666-6666', 1, '2025-05-06 04:30:18', 57);

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
(25, 'banner_6819b514ef4a0.png', '', 2, '3.png', 0, '2025-05-06 07:07:00', 57),
(26, 'banner_681e306f3edcf.png', 'www.kmutnb.ac.th', 4, 'logo_iau_kmutnb.png', 0, '2025-05-09 16:42:23', 57),
(27, 'banner_681e324cc50f1.png', '', 5, 'A_logo_represents_the_Internal_Audit_Unit_(IAU)_of.png', 0, '2025-05-09 16:50:20', 57),
(28, 'banner_681e3638505a8.png', NULL, 6, 'logo_iau_kmutnb.png', 0, '2025-05-09 17:07:04', 57),
(30, 'banner_681e38143f5f9.png', '', 8, 'ChatGPT Image May 6, 2025, 12_30_09 AM.png', 0, '2025-05-09 17:15:00', 57),
(31, 'banner_681e3875138c9.png', 'หหหห', 7, 'A_logo_represents_the_Internal_Audit_Unit_(IAU)_of-Photoroom.png', 0, '2025-05-09 17:16:37', 57),
(32, 'banner_6835b19394b1f.png', '', 9, 'สีฟ้า สีขาว เป็นทางการ วันแม่แห่งชาติ แบนเนอร์.png', 0, '2025-05-27 12:35:31', 58),
(33, 'banner_6835b1a516f84.png', '', 10, 'event_banner3.png', 1, '2025-05-27 12:35:49', 57),
(34, 'banner_683d7bda31a31.png', '', 11, 'สีฟ้า สีขาว เป็นทางการ วันแม่แห่งชาติ แบนเนอร์.png', 1, '2025-06-02 10:24:26', 58),
(35, 'banner_683fb1e2dc10d.png', '', 12, 'event_banner2.png', 1, '2025-06-04 02:39:30', 57);

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
(1, 'สมชาย ใจดี', 'somchai@example.com', '0812345678', 'ร้องเรียน', 'เจ้าหน้าที่ไม่ให้ข้อมูลครบถ้วน', 1, 'pending_additional_info', '2025-05-21 09:54:04', 57),
(2, 'ศิริพร พรหมสุข', NULL, NULL, 'ข้อเสนอแนะ', 'อยากให้เพิ่มช่องทางติดต่อทาง LINE', 1, 'received', '2025-05-21 09:54:04', 57),
(3, NULL, NULL, NULL, 'ร้องเรียน', 'ระบบเว็บไซต์ล่มช่วงเช้า', 1, 'resolved', '2025-05-21 09:54:04', 57),
(4, 'John Doe', 'john@example.com', '0898765432', 'ข้อเสนอแนะ', 'ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ควรมีแบบฟอร์มแยกสำหรับนักศึกษา ', 1, 'in_progress', '2025-05-21 09:54:04', 57),
(5, 'Anon', NULL, NULL, 'ร้องเรียน', 'ไม่ระบุชื่อแต่มีปัญหากับการตอบกลับล่าช้า', 1, 'resolved', '2025-05-21 09:54:04', 57),
(6, 'สมชาย สุขใจ', 'somchai@example.com', '0812345678', 'ร้องเรียน', 'เจ้าหน้าที่ให้บริการล่าช้า', 1, 'pending_additional_info', '2025-05-21 23:52:56', 57),
(7, 'กนกวรรณ ใจดี', 'kanokwan@example.com', '0823456789', 'ข้อเสนอแนะ', 'ควรเพิ่มช่องทางร้องเรียนออนไลน์ให้มากขึ้น', 1, 'Investigating', '2025-05-21 23:52:56', 57),
(8, NULL, NULL, NULL, 'ร้องเรียน', 'ระบบล่มช่วงลงทะเบียน', 1, 'resolved', '2025-05-21 23:52:56', 58),
(9, 'John Doe', 'john@example.com', '0898765432', 'ข้อเสนอแนะ', 'อยากให้มีแบบฟอร์มภาษาอังกฤษ', 1, 'received', '2025-05-21 23:52:56', 57),
(10, 'ไม่ระบุชื่อ', NULL, NULL, 'ร้องเรียน', 'ไม่สะดวกเปิดเผยข้อมูลส่วนตัวแต่มีปัญหาเรื่องบริการตอบกลับช้า', 1, 'Investigating', '2025-05-21 23:52:56', 57),
(11, 'สมชาย สุขใจ', 'somchai@example.com', '0812345678', 'ร้องเรียน', 'เจ้าหน้าที่ให้บริการล่าช้า', 1, 'in_progress', '2025-05-21 23:53:13', 57),
(12, 'กนกวรรณ ใจดี', 'kanokwan@example.com', '0823456789', 'ข้อเสนอแนะ', 'ควรเพิ่มช่องทางร้องเรียนออนไลน์ให้มากขึ้น', 1, 'in_progress', '2025-05-21 23:53:13', 57),
(13, NULL, NULL, NULL, 'ร้องเรียน', 'ระบบล่มช่วงลงทะเบียน', 1, 'resolved', '2025-05-21 23:53:13', 58),
(14, 'John Doe', 'john@example.com', '0898765432', 'ข้อเสนอแนะ', 'อยากให้มีแบบฟอร์มภาษาอังกฤษ', 1, 'received', '2025-05-21 23:53:13', 57),
(15, 'ไม่ระบุชื่อ', NULL, NULL, 'ร้องเรียน', 'ไม่สะดวกเปิดเผยข้อมูลส่วนตัวแต่มีปัญหาเรื่องบริการตอบกลับช้า', 1, 'pending_additional_info', '2025-05-21 23:53:13', 57),
(16, '', '', '', '', 'test system', 1, 'received', '2025-05-26 12:38:52', NULL),
(17, '', '', '', '', 'test system', 1, 'received', '2025-05-26 12:41:01', NULL),
(18, '', '', '', '', 'ee', 1, 'received', '2025-05-26 12:46:32', NULL),
(19, '', '', '', '', 'ทดสอบ', 1, 'received', '2025-05-26 12:56:45', NULL),
(20, '', '', '', '', 'พพ', 1, 'received', '2025-05-26 12:57:07', NULL),
(21, '', '', '', '', 's', 1, 'received', '2025-05-26 13:14:01', NULL),
(22, '', '', '', '', 'กก', 1, 'received', '2025-05-26 13:16:48', NULL),
(23, '', '', '', '', 'sssssss', 1, 'received', '2025-05-26 13:17:04', NULL),
(24, '', '', '', '', 'ssss', 1, 'received', '2025-05-26 13:20:06', NULL),
(25, '', '', '', '', 'แแแ', 1, 'received', '2025-05-26 13:20:17', NULL),
(26, '', '', '', '', 'dd', 1, 'received', '2025-05-26 13:20:43', NULL),
(27, '', '', '', '', 'dddd', 1, 'received', '2025-05-26 13:20:55', NULL),
(28, '', '', '', '', 'ทดสอบ', 1, 'received', '2025-06-04 09:52:17', NULL),
(29, '', '', '', '', 'ทดสอบ', 1, 'Cancelled', '2025-06-04 09:52:33', 57);

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
(7, 'มาตรฐานการตรวจสอบ', 'document_7_681c0b266b7e3.pdf', 1, 57, 57, '2025-04-07', 1),
(56, 'เอกสารวาระตำแหน่งปี 2564', 'document_1746034583_68125f97e618e.pdf', 11, 57, 57, '2025-05-08', 1),
(78, 'กฎบัตรคณะกรรมการตรวจสอบ', 'document_1746505080_68198d784a702.pdf', 2, 57, 57, '2025-05-01', 1),
(79, 'รายงานผลการดำเนินงานของคตส.', 'document_1746506954_681994ca1a0a5.pdf', 3, 57, 57, '2025-05-05', 1),
(80, 'รายงานผลการดำเนินงานหน่วยตรวจสอบภายใน', 'document_1746506988_681994ec6a4b6.pdf', 3, 57, 57, '2025-05-04', 1),
(81, 'รายงานผลการประกันและปรับปรุงคุณภาพ', 'document_1746507035_6819951b75089.pdf', 3, 57, 57, '2025-05-05', 1),
(82, 'Excel', 'document_1746507667_681997935c2a2.xlsx', 9, NULL, 57, '2025-05-05', 1),
(83, 'PDF', 'document_1746507693_681997ad06e5c.pdf', 9, NULL, 57, '2025-05-05', 0),
(84, 'แผนการตรวจสอบภายใน', 'document_1746507869_6819985df2be0.pdf', 5, 57, 57, '2025-05-05', 1),
(85, 'แผนการพัฒนาบุคลากร', 'document_1746507889_681998713855b.pdf', 5, 57, 57, '2025-05-05', 1),
(86, 'แผนยุทธศาสตร์', 'document_1746507903_6819987f1dcf5.pdf', 5, 57, 57, '2025-05-05', 1),
(90, 'ทดสอบ', 'document_1749004527_683fb0efa7851.pdf', 5, 57, 57, '2025-06-05', 1);

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
(5, 'วาระที่ 2558 ถึง 2564', 'document_1746505340_68198e7c7b424.pdf', 11, 57, '2025-04-30', 1, 2558, 2560),
(6, 'วาระที่ 2560 ถึง 2561', 'document_1746505385_68198ea94428f.pdf', 11, 57, '2025-05-01', 1, 2560, 2561),
(8, 'วาระที่ 2562 ถึง 2564', 'document_1746775677_681dae7de55b0.pdf', 11, 57, '2025-05-08', 1, 2562, 2564);

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
(10, 'event_681999348f7a9.png', 'event_banner1.png', 0, '2025-05-22 08:11:05', 57),
(11, 'event_681999424aff3.png', 'event_banner2.png', 0, '2025-05-22 08:11:05', 57),
(12, 'event_6819b53f77c98.png', 'event_banner2.png', 0, '2025-05-22 08:11:05', 57);

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `display_order` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `title` text COLLATE utf8mb4_general_ci NOT NULL COMMENT 'หัวข้อคำถาม',
  `description` text COLLATE utf8mb4_general_ci NOT NULL COMMENT 'รายละเอียดคำถาม',
  `is_active` int(1) NOT NULL DEFAULT '0',
  `uploaded_at` date DEFAULT NULL COMMENT 'วันที่อัปโหลด',
  `updated_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'รหัสแอดมินที่แก้ไขข้อมูล'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `display_order`, `title`, `description`, `is_active`, `uploaded_at`, `updated_by`) VALUES
(16, 1, 'วิธีดึงข้อความจากรูปใน LINE OCR', '<ol><li><strong>เปิดแอป LINE </strong>ไปที่ห้องแชทที่มีภาพที่ต้องการดึงข้อความ</li><li><strong>แตะค้างที่รูปภาพ </strong>จะมีเมนูขึ้นมาหลายตัวเลือก เช่น “บันทึกรูปภาพ”, “ส่งต่อ” ฯลฯ</li><li><strong>เลือก \"ดูข้อความในภาพ\" หรือ \"Recognize Text\" </strong>ฟีเจอร์นี้จะปรากฏหาก LINE ตรวจจับว่าภาพมีข้อความ (หากไม่มีปุ่มนี้ อาจต้องใช้วิธีอื่น)</li><li><strong>รอให้ระบบประมวลผล </strong>LINE จะสแกนข้อความจากภาพ และแสดงผลเป็นข้อความที่คัดลอกได้</li><li><strong>คัดลอกข้อความได้ทันที </strong>จากนั้นสามารถกดคัดลอกไปใช้ในแอปอื่น เช่น โน้ต, Google Translate หรือพิมพ์ในแชท</li></ol>', 1, '2025-05-05', 57),
(17, 3, 'ทำไมท้องฟ้าจึงเป็นสีฟ้า?', '<p>ท้องฟ้าเป็นสีฟ้าเพราะแสงจากดวงอาทิตย์เมื่อผ่านชั้นบรรยากาศจะกระจายตัว (Rayleigh scattering) โดยแสงสีฟ้าจะกระจายได้มากกว่าสีอื่นๆ เนื่องจากมีความยาวคลื่นสั้น ทำให้เมื่อเรามองขึ้นไปยังท้องฟ้า เราจึงเห็นเป็นสีฟ้านั่นเอง</p>', 1, '2025-05-02', 57),
(18, 2, 'น้ำแข็งลอยน้ำได้เพราะอะไร?', '<p>เพราะน้ำแข็งมีความหนาแน่นน้อยกว่าน้ำในสถานะของเหลว จึงลอยอยู่บนผิวน้ำได้</p>', 1, '2025-05-16', 57),
(19, 4, 'ภาษาโปรแกรมใดเหมาะกับผู้เริ่มต้น?', '<p>Python เหมาะสำหรับผู้เริ่มต้น เพราะไวยากรณ์อ่านง่าย เข้าใจไม่ยาก และมีเอกสารช่วยเหลือจำนวนมาก</p>', 1, '2025-05-30', 57);

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
(36, 19, '68392039473f7_fake_data.pdf', 'fake_data.pdf', '2025-05-30 10:04:25');

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
(184, 6, 'นางสาว', 'ใจดี', 'ใจเบิกบาน', 'กลุ่มงานตรวจสอบภายใน', 'นักตรวจสอบภายใน ชำนาญการ', 1, 'test@op.kmutnb.ac.th', '0-2555-2000', '1116', 'Personel_184_1746504716.jpg', 1, '2025-05-06 04:11:56', 57),
(185, 6, 'นาย', 'จิตใจดี', 'ใจเบิกบาน', 'กลุ่มงานตรวจสอบภายใน', 'นักวิชาการ', 0, 'test@op.kmutnb.ac.th', '0-2555-2000', '1117', 'Personel_185_1746504779.jpg', 1, '2025-05-06 04:12:59', 57),
(186, 6, 'นาง', 'สมหญิง', 'เป็นมิตร', 'กลุ่มงานตรวจสอบภายใน', 'นักวิชาการ', 1, 'test@op.kmutnb.ac.th', '0-2555-2000', '1118', 'Personel_186_1746504843.jpg', 1, '2025-05-06 04:14:03', 57),
(187, 6, 'นาย', 'นิวตัน', 'ใจดี', 'กลุ่มงานตรวจสอบภายใน', 'นักวิชาการ', 0, 'test@op.kmutnb.ac.th', '0-2555-2000', '1120', 'Personel_187_1746504904.jpg', 1, '2025-05-06 04:15:04', 57),
(189, 6, 'นาง', 'ฌานิศา', 'อิ่มลิ้มทาน', '', '', 1, '', '', '', 'Personel_189_1746673549.png', 0, '2025-05-08 03:03:30', 57);

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
(57, '1729900557095', 'ฌานิศา', 'อิ่มลิ้มทาน', 'Chanisa', 'Aimlimthan', '', 'chanisaa', 1, '2025-06-04 10:15:51', '2025-02-05 06:55:49', '', 1, NULL, NULL, '2025-05-05 01:15:42', 57),
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
(1, '::1', '2025-05-23 13:57:55'),
(2, '::1', '2025-05-23 14:00:33'),
(3, '::1', '2025-05-23 14:00:33'),
(4, '::1', '2025-05-23 14:01:59'),
(5, '::1', '2025-05-23 14:01:59'),
(6, '::1', '2025-05-23 14:02:03'),
(7, '::1', '2025-05-23 14:02:03'),
(8, '::1', '2025-05-23 14:02:18'),
(9, '::1', '2025-05-23 14:02:18'),
(10, '::1', '2025-05-23 14:02:20'),
(11, '::1', '2025-05-23 14:02:20'),
(12, '::1', '2025-05-23 14:03:36'),
(13, '::1', '2025-05-23 14:03:36'),
(14, '::1', '2025-05-23 14:05:40'),
(15, '::1', '2025-05-23 14:05:40'),
(16, '::1', '2025-05-23 14:05:41'),
(17, '::1', '2025-05-23 14:05:41'),
(18, '::1', '2025-05-23 14:05:48'),
(19, '::1', '2025-05-23 14:05:48'),
(20, '::1', '2025-05-23 14:07:19'),
(21, '::1', '2025-05-23 14:07:21'),
(22, '::1', '2025-05-23 14:07:26'),
(23, '::1', '2025-05-23 14:07:26'),
(24, '::1', '2025-05-23 15:30:59'),
(25, '::1', '2025-05-23 15:30:59'),
(26, '::1', '2025-05-23 15:47:30'),
(27, '::1', '2025-05-23 15:47:30'),
(28, '::1', '2025-05-23 15:53:20'),
(29, '::1', '2025-05-23 15:53:20'),
(30, '::1', '2025-05-23 16:00:32'),
(31, '::1', '2025-05-23 16:00:32'),
(32, '::1', '2025-05-23 16:00:42'),
(33, '::1', '2025-05-23 16:00:42'),
(34, '::1', '2025-05-23 16:00:47'),
(35, '::1', '2025-05-23 16:00:47'),
(36, '::1', '2025-05-23 16:01:02'),
(37, '::1', '2025-05-23 16:01:02'),
(38, '::1', '2025-05-23 16:01:31'),
(39, '::1', '2025-05-23 16:01:31'),
(40, '::1', '2025-05-24 22:35:36'),
(41, '::1', '2025-05-24 22:35:36'),
(42, '::1', '2025-05-24 22:36:00'),
(43, '::1', '2025-05-24 22:36:00'),
(44, '::1', '2025-05-24 22:37:15'),
(45, '::1', '2025-05-24 22:37:15'),
(46, '::1', '2025-05-24 22:37:57'),
(47, '::1', '2025-05-24 22:37:57'),
(48, '::1', '2025-05-24 22:38:15'),
(49, '::1', '2025-05-24 22:38:15'),
(50, '::1', '2025-05-24 22:38:23'),
(51, '::1', '2025-05-24 22:38:23'),
(52, '::1', '2025-05-24 22:38:44'),
(53, '::1', '2025-05-24 22:38:44'),
(54, '::1', '2025-05-24 22:39:11'),
(55, '::1', '2025-05-24 22:39:11'),
(56, '::1', '2025-05-24 22:39:55'),
(57, '::1', '2025-05-24 22:39:55'),
(58, '::1', '2025-05-24 22:39:57'),
(59, '::1', '2025-05-24 22:39:57'),
(60, '::1', '2025-05-24 22:43:34'),
(61, '::1', '2025-05-24 22:43:34'),
(62, '::1', '2025-05-24 22:43:42'),
(63, '::1', '2025-05-24 22:43:42'),
(64, '::1', '2025-05-24 22:49:37'),
(65, '::1', '2025-05-24 22:49:37'),
(66, '::1', '2025-05-24 22:49:37'),
(67, '::1', '2025-05-24 22:49:37'),
(68, '::1', '2025-05-24 23:01:41'),
(69, '::1', '2025-05-24 23:01:41'),
(70, '::1', '2025-05-24 23:01:57'),
(71, '::1', '2025-05-24 23:01:57'),
(72, '::1', '2025-05-24 23:39:36'),
(73, '::1', '2025-05-24 23:39:36'),
(74, '::1', '2025-05-24 23:41:41'),
(75, '::1', '2025-05-24 23:41:41'),
(76, '::1', '2025-05-24 23:41:48'),
(77, '::1', '2025-05-24 23:41:48'),
(78, '::1', '2025-05-24 23:42:46'),
(79, '::1', '2025-05-24 23:42:46'),
(80, '::1', '2025-05-24 23:42:51'),
(81, '::1', '2025-05-24 23:42:51'),
(82, '::1', '2025-05-24 23:42:53'),
(83, '::1', '2025-05-24 23:42:53'),
(84, '::1', '2025-05-24 23:46:41'),
(85, '::1', '2025-05-24 23:46:41'),
(86, '::1', '2025-05-24 23:46:53'),
(87, '::1', '2025-05-24 23:46:53'),
(88, '::1', '2025-05-25 00:11:36'),
(89, '::1', '2025-05-25 00:11:36'),
(90, '::1', '2025-05-25 00:15:14'),
(91, '::1', '2025-05-25 00:15:14'),
(92, '::1', '2025-05-25 00:15:24'),
(93, '::1', '2025-05-25 00:15:24'),
(94, '::1', '2025-05-25 00:15:42'),
(95, '::1', '2025-05-25 00:15:42'),
(96, '::1', '2025-05-25 00:16:06'),
(97, '::1', '2025-05-25 00:16:06'),
(98, '::1', '2025-05-25 00:16:07'),
(99, '::1', '2025-05-25 00:16:07'),
(100, '::1', '2025-05-25 00:16:21'),
(101, '::1', '2025-05-25 00:16:21'),
(102, '::1', '2025-05-25 00:16:32'),
(103, '::1', '2025-05-25 00:16:32'),
(104, '::1', '2025-05-25 00:16:35'),
(105, '::1', '2025-05-25 00:16:35'),
(106, '::1', '2025-05-25 00:17:42'),
(107, '::1', '2025-05-25 00:17:42'),
(108, '::1', '2025-05-25 00:18:04'),
(109, '::1', '2025-05-25 00:18:04'),
(110, '::1', '2025-05-25 00:19:42'),
(111, '::1', '2025-05-25 00:19:42'),
(112, '::1', '2025-05-25 00:19:46'),
(113, '::1', '2025-05-25 00:19:46'),
(114, '::1', '2025-05-25 00:20:17'),
(115, '::1', '2025-05-25 00:20:17'),
(116, '::1', '2025-05-25 00:21:23'),
(117, '::1', '2025-05-25 00:21:23'),
(118, '::1', '2025-05-25 00:21:43'),
(119, '::1', '2025-05-25 00:21:43'),
(120, '::1', '2025-05-25 00:22:07'),
(121, '::1', '2025-05-25 00:22:07'),
(122, '::1', '2025-05-25 00:22:16'),
(123, '::1', '2025-05-25 00:22:16'),
(124, '::1', '2025-05-25 00:22:28'),
(125, '::1', '2025-05-25 00:22:28'),
(126, '::1', '2025-05-25 00:22:40'),
(127, '::1', '2025-05-25 00:22:40'),
(128, '::1', '2025-05-25 00:26:12'),
(129, '::1', '2025-05-25 00:26:12'),
(130, '::1', '2025-05-25 00:26:40'),
(131, '::1', '2025-05-25 00:26:40'),
(132, '::1', '2025-05-25 00:26:49'),
(133, '::1', '2025-05-25 00:26:49'),
(134, '::1', '2025-05-25 00:26:49'),
(135, '::1', '2025-05-25 00:26:49'),
(136, '::1', '2025-05-25 00:36:00'),
(137, '::1', '2025-05-25 00:36:00'),
(138, '::1', '2025-05-25 00:37:57'),
(139, '::1', '2025-05-25 00:37:57'),
(140, '::1', '2025-05-25 00:39:22'),
(141, '::1', '2025-05-25 00:39:22'),
(142, '::1', '2025-05-25 00:52:33'),
(143, '::1', '2025-05-25 00:52:33'),
(144, '::1', '2025-05-25 01:08:42'),
(145, '::1', '2025-05-25 01:09:10'),
(146, '::1', '2025-05-25 01:09:10'),
(147, '::1', '2025-05-25 01:09:23'),
(148, '::1', '2025-05-25 01:09:23'),
(149, '::1', '2025-05-25 01:09:26'),
(150, '::1', '2025-05-25 01:09:26'),
(151, '::1', '2025-05-25 01:09:33'),
(152, '::1', '2025-05-25 01:09:33'),
(153, '::1', '2025-05-25 01:14:54'),
(154, '::1', '2025-05-25 01:14:54'),
(155, '::1', '2025-05-25 01:15:03'),
(156, '::1', '2025-05-25 01:15:03'),
(157, '::1', '2025-05-25 01:37:34'),
(158, '::1', '2025-05-25 01:37:34'),
(159, '::1', '2025-05-25 01:37:38'),
(160, '::1', '2025-05-25 01:37:38'),
(161, '::1', '2025-05-25 01:39:14'),
(162, '::1', '2025-05-25 01:39:14'),
(163, '::1', '2025-05-25 01:39:39'),
(164, '::1', '2025-05-25 01:39:39'),
(165, '::1', '2025-05-25 01:43:18'),
(166, '::1', '2025-05-25 01:43:18'),
(167, '::1', '2025-05-25 14:06:02'),
(168, '::1', '2025-05-25 14:06:02'),
(169, '::1', '2025-05-25 14:06:03'),
(170, '::1', '2025-05-25 14:06:03'),
(171, '::1', '2025-05-25 15:02:01'),
(172, '::1', '2025-05-25 15:02:01'),
(173, '::1', '2025-05-25 15:02:03'),
(174, '::1', '2025-05-25 15:02:03'),
(175, '::1', '2025-05-25 15:18:18'),
(176, '::1', '2025-05-25 15:18:18'),
(177, '::1', '2025-05-25 15:18:25'),
(178, '::1', '2025-05-25 15:18:25'),
(179, '::1', '2025-05-25 15:33:25'),
(180, '::1', '2025-05-25 15:33:25'),
(181, '::1', '2025-05-25 15:33:26'),
(182, '::1', '2025-05-25 15:33:26'),
(183, '::1', '2025-05-25 15:33:49'),
(184, '::1', '2025-05-25 15:33:49'),
(185, '::1', '2025-05-25 15:33:54'),
(186, '::1', '2025-05-25 15:33:54'),
(187, '::1', '2025-05-25 15:33:55'),
(188, '::1', '2025-05-25 15:33:55'),
(189, '::1', '2025-05-25 15:36:11'),
(190, '::1', '2025-05-25 15:36:11'),
(191, '::1', '2025-05-25 15:36:13'),
(192, '::1', '2025-05-25 15:36:13'),
(193, '::1', '2025-05-25 15:36:41'),
(194, '::1', '2025-05-25 15:36:41'),
(195, '::1', '2025-05-25 15:37:03'),
(196, '::1', '2025-05-25 15:37:03'),
(197, '::1', '2025-05-25 15:37:08'),
(198, '::1', '2025-05-25 15:37:08'),
(199, '::1', '2025-05-25 15:37:10'),
(200, '::1', '2025-05-25 15:37:10'),
(201, '::1', '2025-05-25 17:25:18'),
(202, '::1', '2025-05-25 17:25:18'),
(203, '::1', '2025-05-25 17:25:20'),
(204, '::1', '2025-05-25 17:25:20'),
(205, '::1', '2025-05-25 17:30:17'),
(206, '::1', '2025-05-25 17:30:17'),
(207, '::1', '2025-05-25 17:30:18'),
(208, '::1', '2025-05-25 17:30:18'),
(209, '::1', '2025-05-25 17:30:31'),
(210, '::1', '2025-05-25 17:30:31'),
(211, '::1', '2025-05-25 17:30:32'),
(212, '::1', '2025-05-25 17:30:32'),
(213, '::1', '2025-05-25 17:30:39'),
(214, '::1', '2025-05-25 17:30:39'),
(215, '::1', '2025-05-25 17:30:40'),
(216, '::1', '2025-05-25 17:30:40'),
(217, '::1', '2025-05-25 17:31:30'),
(218, '::1', '2025-05-25 17:31:30'),
(219, '::1', '2025-05-25 17:31:32'),
(220, '::1', '2025-05-25 17:31:32'),
(221, '::1', '2025-05-25 17:32:00'),
(222, '::1', '2025-05-25 17:32:00'),
(223, '::1', '2025-05-25 17:34:09'),
(224, '::1', '2025-05-25 17:34:09'),
(225, '::1', '2025-05-25 17:34:10'),
(226, '::1', '2025-05-25 17:34:10'),
(227, '::1', '2025-05-25 17:35:55'),
(228, '::1', '2025-05-25 17:35:55'),
(229, '::1', '2025-05-25 17:35:58'),
(230, '::1', '2025-05-25 17:35:58'),
(231, '::1', '2025-05-25 17:43:31'),
(232, '::1', '2025-05-25 17:43:31'),
(233, '::1', '2025-05-25 17:43:36'),
(234, '::1', '2025-05-25 17:43:36'),
(235, '::1', '2025-05-25 17:45:22'),
(236, '::1', '2025-05-25 17:45:22'),
(237, '::1', '2025-05-25 17:45:51'),
(238, '::1', '2025-05-25 17:45:51'),
(239, '::1', '2025-05-25 18:06:21'),
(240, '::1', '2025-05-25 18:06:21'),
(241, '::1', '2025-05-25 18:11:37'),
(242, '::1', '2025-05-25 18:11:37'),
(243, '::1', '2025-05-25 18:16:21'),
(244, '::1', '2025-05-25 18:16:21'),
(245, '::1', '2025-05-25 18:16:22'),
(246, '::1', '2025-05-25 18:16:22'),
(247, '::1', '2025-05-25 18:16:23'),
(248, '::1', '2025-05-25 18:16:23'),
(249, '::1', '2025-05-25 18:16:23'),
(250, '::1', '2025-05-25 18:16:23'),
(251, '::1', '2025-05-25 18:16:24'),
(252, '::1', '2025-05-25 18:16:24'),
(253, '::1', '2025-05-25 18:16:25'),
(254, '::1', '2025-05-25 18:16:25'),
(255, '::1', '2025-05-25 18:26:38'),
(256, '::1', '2025-05-25 18:26:38'),
(257, '::1', '2025-05-25 18:27:05'),
(258, '::1', '2025-05-25 18:27:05'),
(259, '::1', '2025-05-25 18:27:25'),
(260, '::1', '2025-05-25 18:27:25'),
(261, '::1', '2025-05-26 10:53:42'),
(262, '::1', '2025-05-26 10:53:42'),
(263, '::1', '2025-05-26 11:07:59'),
(264, '::1', '2025-05-26 11:07:59'),
(265, '::1', '2025-05-26 11:09:08'),
(266, '::1', '2025-05-26 11:09:08'),
(267, '::1', '2025-05-26 11:45:45'),
(268, '::1', '2025-05-26 11:45:45'),
(269, '::1', '2025-05-26 12:38:35'),
(270, '::1', '2025-05-26 12:38:35'),
(271, '::1', '2025-05-26 12:56:26'),
(272, '::1', '2025-05-26 12:56:26'),
(273, '::1', '2025-05-26 13:11:59'),
(274, '::1', '2025-05-26 13:11:59'),
(275, '::1', '2025-05-26 13:17:25'),
(276, '::1', '2025-05-26 13:17:25'),
(277, '::1', '2025-05-26 14:35:40'),
(278, '::1', '2025-05-26 14:35:40'),
(279, '::1', '2025-05-26 14:43:35'),
(280, '::1', '2025-05-26 14:43:35'),
(281, '::1', '2025-05-26 15:16:21'),
(282, '::1', '2025-05-26 15:16:21'),
(283, '::1', '2025-05-26 15:25:54'),
(284, '::1', '2025-05-26 15:25:54'),
(285, '::1', '2025-05-26 15:40:59'),
(286, '::1', '2025-05-26 15:40:59'),
(287, '::1', '2025-05-27 08:07:57'),
(288, '::1', '2025-05-27 08:07:57'),
(289, '::1', '2025-05-27 08:23:27'),
(290, '::1', '2025-05-27 08:23:27'),
(291, '::1', '2025-05-27 08:29:31'),
(292, '::1', '2025-05-27 08:29:31'),
(293, '::1', '2025-05-27 08:54:16'),
(294, '::1', '2025-05-27 08:54:16'),
(295, '::1', '2025-05-27 08:55:19'),
(296, '::1', '2025-05-27 08:55:19'),
(297, '::1', '2025-05-27 08:58:54'),
(298, '::1', '2025-05-27 08:58:54'),
(299, '::1', '2025-05-27 09:36:50'),
(300, '::1', '2025-05-27 09:36:50'),
(301, '::1', '2025-05-27 09:44:15'),
(302, '::1', '2025-05-27 09:44:15'),
(303, '::1', '2025-05-27 09:46:53'),
(304, '::1', '2025-05-27 09:46:53'),
(305, '::1', '2025-05-27 09:47:21'),
(306, '::1', '2025-05-27 09:47:21'),
(307, '::1', '2025-05-27 09:47:30'),
(308, '::1', '2025-05-27 09:47:30'),
(309, '::1', '2025-05-27 09:49:20'),
(310, '::1', '2025-05-27 09:49:20'),
(311, '::1', '2025-05-27 09:49:25'),
(312, '::1', '2025-05-27 09:49:25'),
(313, '::1', '2025-05-27 09:53:23'),
(314, '::1', '2025-05-27 09:53:23'),
(315, '::1', '2025-05-27 09:53:34'),
(316, '::1', '2025-05-27 09:53:34'),
(317, '::1', '2025-05-27 09:54:27'),
(318, '::1', '2025-05-27 09:54:27'),
(319, '::1', '2025-05-27 10:13:33'),
(320, '::1', '2025-05-27 10:13:33'),
(321, '::1', '2025-05-27 10:14:38'),
(322, '::1', '2025-05-27 10:14:38'),
(323, '::1', '2025-05-27 10:16:27'),
(324, '::1', '2025-05-27 10:16:27'),
(325, '::1', '2025-05-27 10:28:32'),
(326, '::1', '2025-05-27 10:28:32'),
(327, '::1', '2025-05-27 10:28:55'),
(328, '::1', '2025-05-27 10:28:55'),
(329, '::1', '2025-05-27 10:29:30'),
(330, '::1', '2025-05-27 10:29:30'),
(331, '::1', '2025-05-27 10:37:34'),
(332, '::1', '2025-05-27 10:37:34'),
(333, '::1', '2025-05-27 10:37:57'),
(334, '::1', '2025-05-27 10:37:57'),
(335, '::1', '2025-05-27 10:50:47'),
(336, '::1', '2025-05-27 10:50:47'),
(337, '::1', '2025-05-27 10:57:19'),
(338, '::1', '2025-05-27 10:57:19'),
(339, '::1', '2025-05-27 13:43:57'),
(340, '::1', '2025-05-27 13:43:57'),
(341, '::1', '2025-05-27 13:45:58'),
(342, '::1', '2025-05-27 13:45:58'),
(343, '::1', '2025-05-27 14:44:45'),
(344, '::1', '2025-05-27 14:44:45'),
(345, '::1', '2025-05-27 14:45:08'),
(346, '::1', '2025-05-27 14:45:08'),
(347, '::1', '2025-05-27 14:45:38'),
(348, '::1', '2025-05-27 14:45:38'),
(349, '::1', '2025-05-27 14:47:48'),
(350, '::1', '2025-05-27 14:47:48'),
(351, '::1', '2025-05-27 15:08:31'),
(352, '::1', '2025-05-27 15:08:31'),
(353, '::1', '2025-05-27 15:08:45'),
(354, '::1', '2025-05-27 15:08:45'),
(355, '::1', '2025-05-27 15:13:09'),
(356, '::1', '2025-05-27 15:13:09'),
(357, '::1', '2025-05-27 15:13:34'),
(358, '::1', '2025-05-27 15:13:34'),
(359, '::1', '2025-05-27 15:14:50'),
(360, '::1', '2025-05-27 15:14:50'),
(361, '::1', '2025-05-27 15:37:40'),
(362, '::1', '2025-05-27 15:37:40'),
(363, '::1', '2025-05-27 15:42:33'),
(364, '::1', '2025-05-27 15:42:33'),
(365, '::1', '2025-05-27 15:49:46'),
(366, '::1', '2025-05-27 15:49:46'),
(367, '::1', '2025-05-27 16:01:48'),
(368, '::1', '2025-05-27 16:01:48'),
(369, '::1', '2025-05-27 19:14:46'),
(370, '::1', '2025-05-27 19:14:46'),
(371, '::1', '2025-05-27 19:36:00'),
(372, '::1', '2025-05-27 19:36:00'),
(373, '::1', '2025-05-27 21:10:32'),
(374, '::1', '2025-05-27 21:10:32'),
(375, '::1', '2025-05-27 21:11:20'),
(376, '::1', '2025-05-27 21:11:20'),
(377, '::1', '2025-05-27 21:39:12'),
(378, '::1', '2025-05-27 21:39:12'),
(379, '::1', '2025-05-27 21:53:24'),
(380, '::1', '2025-05-27 21:53:24'),
(381, '::1', '2025-05-27 22:17:01'),
(382, '::1', '2025-05-27 22:17:01'),
(383, '::1', '2025-05-27 22:19:27'),
(384, '::1', '2025-05-27 22:19:27'),
(385, '::1', '2025-05-27 22:27:31'),
(386, '::1', '2025-05-27 22:27:31'),
(387, '::1', '2025-05-27 22:29:50'),
(388, '::1', '2025-05-27 22:29:50'),
(389, '::1', '2025-05-27 22:29:56'),
(390, '::1', '2025-05-27 22:29:56'),
(391, '::1', '2025-05-27 22:30:55'),
(392, '::1', '2025-05-27 22:30:55'),
(393, '::1', '2025-05-27 22:31:04'),
(394, '::1', '2025-05-27 22:31:04'),
(395, '::1', '2025-05-27 22:34:43'),
(396, '::1', '2025-05-27 22:34:43'),
(397, '::1', '2025-05-27 22:34:52'),
(398, '::1', '2025-05-27 22:34:52'),
(399, '::1', '2025-05-27 22:34:59'),
(400, '::1', '2025-05-27 22:34:59'),
(401, '::1', '2025-05-27 22:35:05'),
(402, '::1', '2025-05-27 22:35:05'),
(403, '::1', '2025-05-27 22:35:13'),
(404, '::1', '2025-05-27 22:35:13'),
(405, '::1', '2025-05-27 22:36:01'),
(406, '::1', '2025-05-27 22:36:01'),
(407, '::1', '2025-05-27 23:15:03'),
(408, '::1', '2025-05-27 23:15:03'),
(409, '::1', '2025-05-27 23:19:21'),
(410, '::1', '2025-05-27 23:19:21'),
(411, '::1', '2025-05-27 23:19:40'),
(412, '::1', '2025-05-27 23:19:40'),
(413, '::1', '2025-05-27 23:24:07'),
(414, '::1', '2025-05-27 23:24:07'),
(415, '::1', '2025-05-27 23:31:27'),
(416, '::1', '2025-05-27 23:31:27'),
(417, '::1', '2025-05-27 23:38:03'),
(418, '::1', '2025-05-27 23:38:03'),
(419, '::1', '2025-05-27 23:38:06'),
(420, '::1', '2025-05-27 23:38:06'),
(421, '::1', '2025-05-27 23:40:52'),
(422, '::1', '2025-05-27 23:40:52'),
(423, '::1', '2025-05-27 23:42:13'),
(424, '::1', '2025-05-27 23:42:13'),
(425, '::1', '2025-05-28 00:08:48'),
(426, '::1', '2025-05-28 00:08:48'),
(427, '::1', '2025-05-28 00:21:41'),
(428, '::1', '2025-05-28 00:21:41'),
(429, '::1', '2025-05-28 00:22:20'),
(430, '::1', '2025-05-28 00:22:20'),
(431, '::1', '2025-05-28 00:23:17'),
(432, '::1', '2025-05-28 00:23:17'),
(433, '::1', '2025-05-28 00:23:41'),
(434, '::1', '2025-05-28 00:23:41'),
(435, '::1', '2025-05-28 00:24:16'),
(436, '::1', '2025-05-28 00:24:16'),
(437, '::1', '2025-05-28 00:25:00'),
(438, '::1', '2025-05-28 00:25:00'),
(439, '::1', '2025-05-28 00:25:31'),
(440, '::1', '2025-05-28 00:25:31'),
(441, '::1', '2025-05-28 00:26:39'),
(442, '::1', '2025-05-28 00:26:39'),
(443, '::1', '2025-05-28 13:22:12'),
(444, '::1', '2025-05-28 13:22:12'),
(445, '::1', '2025-05-28 13:28:19'),
(446, '::1', '2025-05-28 13:28:19'),
(447, '::1', '2025-05-28 13:33:33'),
(448, '::1', '2025-05-28 13:33:33'),
(449, '::1', '2025-05-28 13:33:59'),
(450, '::1', '2025-05-28 13:33:59'),
(451, '::1', '2025-05-28 13:34:06'),
(452, '::1', '2025-05-28 13:34:06'),
(453, '::1', '2025-05-28 13:37:42'),
(454, '::1', '2025-05-28 13:37:42'),
(455, '::1', '2025-05-28 13:44:53'),
(456, '::1', '2025-05-28 13:44:53'),
(457, '::1', '2025-05-28 13:48:35'),
(458, '::1', '2025-05-28 13:48:35'),
(459, '::1', '2025-05-28 13:48:48'),
(460, '::1', '2025-05-28 13:48:48'),
(461, '::1', '2025-05-28 13:49:14'),
(462, '::1', '2025-05-28 13:49:14'),
(463, '::1', '2025-05-28 13:50:21'),
(464, '::1', '2025-05-28 13:50:21'),
(465, '::1', '2025-05-28 13:58:19'),
(466, '::1', '2025-05-28 13:58:19'),
(467, '::1', '2025-05-28 15:04:42'),
(468, '::1', '2025-05-28 15:04:42'),
(469, '::1', '2025-05-28 15:08:14'),
(470, '::1', '2025-05-28 15:08:14'),
(471, '::1', '2025-05-28 15:47:44'),
(472, '::1', '2025-05-28 15:47:44'),
(473, '::1', '2025-05-28 15:50:44'),
(474, '::1', '2025-05-28 15:50:44'),
(475, '::1', '2025-05-28 15:53:40'),
(476, '::1', '2025-05-28 15:53:40'),
(477, '::1', '2025-05-28 15:54:11'),
(478, '::1', '2025-05-28 15:54:11'),
(479, '::1', '2025-05-28 15:56:41'),
(480, '::1', '2025-05-28 15:56:41'),
(481, '::1', '2025-05-28 15:57:13'),
(482, '::1', '2025-05-28 15:57:13'),
(483, '::1', '2025-05-28 15:59:13'),
(484, '::1', '2025-05-28 15:59:13'),
(485, '::1', '2025-05-28 16:01:20'),
(486, '::1', '2025-05-28 16:01:20'),
(487, '::1', '2025-05-29 08:22:28'),
(488, '::1', '2025-05-29 08:22:28'),
(489, '::1', '2025-05-29 08:22:37'),
(490, '::1', '2025-05-29 08:22:37'),
(491, '::1', '2025-05-29 09:34:00'),
(492, '::1', '2025-05-29 09:34:00'),
(493, '::1', '2025-05-29 09:37:36'),
(494, '::1', '2025-05-29 09:37:36'),
(495, '::1', '2025-05-29 09:37:55'),
(496, '::1', '2025-05-29 09:37:55'),
(497, '::1', '2025-05-29 09:38:36'),
(498, '::1', '2025-05-29 09:38:36'),
(499, '::1', '2025-05-29 09:39:54'),
(500, '::1', '2025-05-29 09:39:54'),
(501, '::1', '2025-05-29 09:41:02'),
(502, '::1', '2025-05-29 09:41:02'),
(503, '::1', '2025-05-29 09:41:10'),
(504, '::1', '2025-05-29 09:41:10'),
(505, '::1', '2025-05-29 09:53:32'),
(506, '::1', '2025-05-29 09:53:32'),
(507, '::1', '2025-05-29 10:50:01'),
(508, '::1', '2025-05-29 10:50:01'),
(509, '::1', '2025-05-29 10:55:57'),
(510, '::1', '2025-05-29 10:55:57'),
(511, '::1', '2025-05-29 10:57:19'),
(512, '::1', '2025-05-29 10:57:19'),
(513, '::1', '2025-05-29 10:57:30'),
(514, '::1', '2025-05-29 10:57:30'),
(515, '::1', '2025-05-29 10:58:07'),
(516, '::1', '2025-05-29 10:58:07'),
(517, '::1', '2025-05-29 11:15:01'),
(518, '::1', '2025-05-29 11:15:01'),
(519, '::1', '2025-05-29 11:16:55'),
(520, '::1', '2025-05-29 11:16:55'),
(521, '::1', '2025-05-29 13:02:24'),
(522, '::1', '2025-05-29 13:02:24'),
(523, '::1', '2025-05-29 14:07:23'),
(524, '::1', '2025-05-29 14:07:23'),
(525, '::1', '2025-05-29 14:14:21'),
(526, '::1', '2025-05-29 14:14:21'),
(527, '::1', '2025-05-29 14:57:20'),
(528, '::1', '2025-05-29 14:57:20'),
(529, '::1', '2025-05-29 14:57:23'),
(530, '::1', '2025-05-29 14:57:23'),
(531, '::1', '2025-05-29 15:31:01'),
(532, '::1', '2025-05-29 15:31:01'),
(533, '::1', '2025-05-29 15:33:42'),
(534, '::1', '2025-05-29 15:33:42'),
(535, '::1', '2025-05-29 15:49:48'),
(536, '::1', '2025-05-29 15:49:48'),
(537, '::1', '2025-05-29 15:58:08'),
(538, '::1', '2025-05-29 15:58:08'),
(539, '::1', '2025-05-29 15:58:48'),
(540, '::1', '2025-05-29 15:58:48'),
(541, '::1', '2025-05-29 15:59:05'),
(542, '::1', '2025-05-29 15:59:05'),
(543, '::1', '2025-05-29 15:59:11'),
(544, '::1', '2025-05-29 15:59:11'),
(545, '::1', '2025-05-29 16:02:21'),
(546, '::1', '2025-05-29 16:02:21'),
(547, '::1', '2025-05-30 08:30:56'),
(548, '::1', '2025-05-30 08:30:56'),
(549, '::1', '2025-05-30 08:48:26'),
(550, '::1', '2025-05-30 08:48:26'),
(551, '::1', '2025-05-30 08:51:36'),
(552, '::1', '2025-05-30 08:51:36'),
(553, '::1', '2025-05-30 08:56:04'),
(554, '::1', '2025-05-30 08:56:04'),
(555, '::1', '2025-05-30 08:56:17'),
(556, '::1', '2025-05-30 08:56:17'),
(557, '::1', '2025-05-30 08:56:54'),
(558, '::1', '2025-05-30 08:56:54'),
(559, '::1', '2025-05-30 09:08:05'),
(560, '::1', '2025-05-30 09:08:05'),
(561, '::1', '2025-05-30 09:08:59'),
(562, '::1', '2025-05-30 09:08:59'),
(563, '::1', '2025-05-30 09:10:24'),
(564, '::1', '2025-05-30 09:10:24'),
(565, '::1', '2025-05-30 09:33:31'),
(566, '::1', '2025-05-30 09:33:31'),
(567, '::1', '2025-05-30 09:34:41'),
(568, '::1', '2025-05-30 09:34:41'),
(569, '::1', '2025-05-30 09:38:35'),
(570, '::1', '2025-05-30 09:38:35'),
(571, '::1', '2025-05-30 09:38:55'),
(572, '::1', '2025-05-30 09:38:55'),
(573, '::1', '2025-05-30 09:39:09'),
(574, '::1', '2025-05-30 09:39:09'),
(575, '::1', '2025-05-30 09:39:18'),
(576, '::1', '2025-05-30 09:39:18'),
(577, '::1', '2025-05-30 09:44:41'),
(578, '::1', '2025-05-30 09:44:41'),
(579, '::1', '2025-05-30 09:48:15'),
(580, '::1', '2025-05-30 09:48:15'),
(581, '::1', '2025-05-30 09:49:11'),
(582, '::1', '2025-05-30 09:49:11'),
(583, '::1', '2025-05-30 09:50:57'),
(584, '::1', '2025-05-30 09:50:57'),
(585, '::1', '2025-05-30 10:10:17'),
(586, '::1', '2025-05-30 10:10:17'),
(587, '::1', '2025-05-30 10:11:01'),
(588, '::1', '2025-05-30 10:11:01'),
(589, '::1', '2025-05-30 10:11:52'),
(590, '::1', '2025-05-30 10:11:52'),
(591, '::1', '2025-05-30 10:12:25'),
(592, '::1', '2025-05-30 10:12:25'),
(593, '::1', '2025-05-30 10:18:20'),
(594, '::1', '2025-05-30 10:18:20'),
(595, '::1', '2025-05-30 10:19:15'),
(596, '::1', '2025-05-30 10:19:15'),
(597, '::1', '2025-05-30 10:22:54'),
(598, '::1', '2025-05-30 10:22:54'),
(599, '::1', '2025-05-30 10:34:54'),
(600, '::1', '2025-05-30 10:34:54'),
(601, '::1', '2025-05-30 10:38:01'),
(602, '::1', '2025-05-30 10:38:01'),
(603, '::1', '2025-05-30 10:38:14'),
(604, '::1', '2025-05-30 10:38:14'),
(605, '::1', '2025-05-30 10:38:32'),
(606, '::1', '2025-05-30 10:38:32'),
(607, '::1', '2025-05-30 10:39:51'),
(608, '::1', '2025-05-30 10:39:51'),
(609, '::1', '2025-05-30 10:44:57'),
(610, '::1', '2025-05-30 10:44:57'),
(611, '::1', '2025-05-30 11:15:51'),
(612, '::1', '2025-05-30 11:15:51'),
(613, '::1', '2025-05-30 11:20:06'),
(614, '::1', '2025-05-30 11:20:07'),
(615, '::1', '2025-05-30 11:26:19'),
(616, '::1', '2025-05-30 11:26:19'),
(617, '::1', '2025-05-30 11:32:52'),
(618, '::1', '2025-05-30 11:32:52'),
(619, '::1', '2025-05-30 11:33:25'),
(620, '::1', '2025-05-30 11:33:25'),
(621, '::1', '2025-05-30 11:33:46'),
(622, '::1', '2025-05-30 11:33:46'),
(623, '::1', '2025-05-30 11:34:40'),
(624, '::1', '2025-05-30 11:34:40'),
(625, '::1', '2025-05-30 12:51:36'),
(626, '::1', '2025-05-30 12:51:36'),
(627, '::1', '2025-05-30 12:52:01'),
(628, '::1', '2025-05-30 12:52:01'),
(629, '::1', '2025-05-30 12:55:24'),
(630, '::1', '2025-05-30 12:55:24'),
(631, '::1', '2025-05-30 12:57:59'),
(632, '::1', '2025-05-30 12:57:59'),
(633, '::1', '2025-05-30 13:00:00'),
(634, '::1', '2025-05-30 13:00:00'),
(635, '::1', '2025-05-30 13:00:24'),
(636, '::1', '2025-05-30 13:00:24'),
(637, '::1', '2025-05-30 13:01:05'),
(638, '::1', '2025-05-30 13:01:05'),
(639, '::1', '2025-05-30 13:03:44'),
(640, '::1', '2025-05-30 13:03:44'),
(641, '::1', '2025-05-30 13:03:46'),
(642, '::1', '2025-05-30 13:03:46'),
(643, '::1', '2025-05-30 13:04:04'),
(644, '::1', '2025-05-30 13:04:04'),
(645, '::1', '2025-05-30 13:39:40'),
(646, '::1', '2025-05-30 13:39:40'),
(647, '::1', '2025-05-30 13:43:56'),
(648, '::1', '2025-05-30 13:43:56'),
(649, '::1', '2025-05-30 13:52:16'),
(650, '::1', '2025-05-30 13:52:16'),
(651, '::1', '2025-05-30 13:56:20'),
(652, '::1', '2025-05-30 13:56:20'),
(653, '::1', '2025-05-30 13:56:57'),
(654, '::1', '2025-05-30 13:56:57'),
(655, '::1', '2025-05-30 14:44:43'),
(656, '::1', '2025-05-30 14:44:43'),
(657, '::1', '2025-05-30 14:45:35'),
(658, '::1', '2025-05-30 14:45:35'),
(659, '::1', '2025-05-30 14:58:16'),
(660, '::1', '2025-05-30 14:58:16'),
(661, '::1', '2025-05-30 15:31:57'),
(662, '::1', '2025-05-30 15:31:57'),
(663, '::1', '2025-05-30 15:32:27'),
(664, '::1', '2025-05-30 15:32:27'),
(665, '::1', '2025-05-30 16:01:02'),
(666, '::1', '2025-05-30 16:01:02'),
(667, '::1', '2025-05-30 16:01:57'),
(668, '::1', '2025-05-30 16:01:57'),
(669, '::1', '2025-05-30 16:02:46'),
(670, '::1', '2025-05-30 16:02:46'),
(671, '::1', '2025-06-01 12:13:45'),
(672, '::1', '2025-06-01 12:13:45'),
(673, '::1', '2025-06-01 12:45:34'),
(674, '::1', '2025-06-01 12:45:34'),
(675, '::1', '2025-06-01 12:46:04'),
(676, '::1', '2025-06-01 12:46:04'),
(677, '::1', '2025-06-01 12:53:26'),
(678, '::1', '2025-06-01 12:53:26'),
(679, '::1', '2025-06-01 13:00:01'),
(680, '::1', '2025-06-01 13:00:01'),
(681, '::1', '2025-06-01 13:50:20'),
(682, '::1', '2025-06-01 13:50:20'),
(683, '::1', '2025-06-01 13:50:29'),
(684, '::1', '2025-06-01 13:50:29'),
(685, '::1', '2025-06-01 16:31:26'),
(686, '::1', '2025-06-01 16:31:26'),
(687, '::1', '2025-06-01 16:34:59'),
(688, '::1', '2025-06-01 16:34:59'),
(689, '::1', '2025-06-01 17:08:29'),
(690, '::1', '2025-06-01 17:08:29'),
(691, '::1', '2025-06-01 18:59:03'),
(692, '::1', '2025-06-01 18:59:03'),
(693, '::1', '2025-06-01 19:00:50'),
(694, '::1', '2025-06-01 19:00:50'),
(695, '::1', '2025-06-01 19:00:51'),
(696, '::1', '2025-06-01 19:00:51'),
(697, '::1', '2025-06-01 19:02:13'),
(698, '::1', '2025-06-01 19:02:13'),
(699, '::1', '2025-06-01 19:02:16'),
(700, '::1', '2025-06-01 19:02:16'),
(701, '::1', '2025-06-01 19:02:35'),
(702, '::1', '2025-06-01 19:02:35'),
(703, '::1', '2025-06-01 19:03:59'),
(704, '::1', '2025-06-01 19:03:59'),
(705, '::1', '2025-06-01 19:04:05'),
(706, '::1', '2025-06-01 19:04:05'),
(707, '::1', '2025-06-01 19:05:06'),
(708, '::1', '2025-06-01 19:05:06'),
(709, '::1', '2025-06-01 19:58:56'),
(710, '::1', '2025-06-01 19:58:56'),
(711, '::1', '2025-06-01 19:59:40'),
(712, '::1', '2025-06-01 19:59:40'),
(713, '::1', '2025-06-01 20:01:17'),
(714, '::1', '2025-06-01 20:01:17'),
(715, '::1', '2025-06-01 20:05:23'),
(716, '::1', '2025-06-01 20:05:23'),
(717, '::1', '2025-06-01 20:19:47'),
(718, '::1', '2025-06-01 20:19:47'),
(719, '::1', '2025-06-01 20:19:50'),
(720, '::1', '2025-06-01 20:19:50'),
(721, '::1', '2025-06-01 20:20:38'),
(722, '::1', '2025-06-01 20:20:38'),
(723, '::1', '2025-06-01 20:21:14'),
(724, '::1', '2025-06-01 20:21:14'),
(725, '::1', '2025-06-01 20:21:37'),
(726, '::1', '2025-06-01 20:21:37'),
(727, '::1', '2025-06-01 21:24:18'),
(728, '::1', '2025-06-01 21:24:18'),
(729, '::1', '2025-06-01 21:25:06'),
(730, '::1', '2025-06-01 21:25:07'),
(731, '::1', '2025-06-01 21:26:47'),
(732, '::1', '2025-06-01 21:26:47'),
(733, '::1', '2025-06-01 21:27:13'),
(734, '::1', '2025-06-01 21:27:13'),
(735, '::1', '2025-06-01 21:34:58'),
(736, '::1', '2025-06-01 21:34:58'),
(737, '::1', '2025-06-01 21:35:03'),
(738, '::1', '2025-06-01 21:35:03'),
(739, '::1', '2025-06-01 21:36:49'),
(740, '::1', '2025-06-01 21:36:49'),
(741, '::1', '2025-06-01 21:40:11'),
(742, '::1', '2025-06-01 21:40:11'),
(743, '::1', '2025-06-01 21:43:35'),
(744, '::1', '2025-06-01 21:43:35'),
(745, '::1', '2025-06-01 21:44:22'),
(746, '::1', '2025-06-01 21:44:22'),
(747, '::1', '2025-06-01 22:19:14'),
(748, '::1', '2025-06-01 22:19:14'),
(749, '::1', '2025-06-02 10:12:09'),
(750, '::1', '2025-06-02 10:12:09'),
(751, '::1', '2025-06-02 11:25:29'),
(752, '::1', '2025-06-02 11:25:29'),
(753, '::1', '2025-06-02 13:53:33'),
(754, '::1', '2025-06-02 13:53:33'),
(755, '::1', '2025-06-02 16:54:40'),
(756, '::1', '2025-06-02 16:54:40'),
(757, '::1', '2025-06-02 17:25:53'),
(758, '::1', '2025-06-02 17:25:53'),
(759, '::1', '2025-06-02 23:45:14'),
(760, '::1', '2025-06-02 23:45:15'),
(761, '::1', '2025-06-02 23:51:17'),
(762, '::1', '2025-06-02 23:51:17'),
(763, '::1', '2025-06-03 00:06:44'),
(764, '::1', '2025-06-03 00:06:44'),
(765, '::1', '2025-06-04 08:46:16'),
(766, '::1', '2025-06-04 08:46:16'),
(767, '::1', '2025-06-04 08:49:21'),
(768, '::1', '2025-06-04 08:49:21'),
(769, '::1', '2025-06-04 08:49:34'),
(770, '::1', '2025-06-04 08:49:34'),
(771, '::1', '2025-06-04 08:49:56'),
(772, '::1', '2025-06-04 08:49:56'),
(773, '::1', '2025-06-04 08:50:27'),
(774, '::1', '2025-06-04 08:50:27'),
(775, '::1', '2025-06-04 08:50:59'),
(776, '::1', '2025-06-04 08:50:59'),
(777, '::1', '2025-06-04 08:51:16'),
(778, '::1', '2025-06-04 08:51:16'),
(779, '::1', '2025-06-04 08:54:13'),
(780, '::1', '2025-06-04 08:54:13'),
(781, '::1', '2025-06-04 08:56:04'),
(782, '::1', '2025-06-04 08:56:04'),
(783, '::1', '2025-06-04 08:59:14'),
(784, '::1', '2025-06-04 08:59:14'),
(785, '::1', '2025-06-04 09:00:14'),
(786, '::1', '2025-06-04 09:00:14'),
(787, '::1', '2025-06-04 09:00:59'),
(788, '::1', '2025-06-04 09:00:59'),
(789, '::1', '2025-06-04 09:08:19'),
(790, '::1', '2025-06-04 09:08:19'),
(791, '::1', '2025-06-04 09:08:50'),
(792, '::1', '2025-06-04 09:08:50'),
(793, '::1', '2025-06-04 09:10:49'),
(794, '::1', '2025-06-04 09:10:49'),
(795, '::1', '2025-06-04 09:16:05'),
(796, '::1', '2025-06-04 09:16:05'),
(797, '::1', '2025-06-04 09:17:25'),
(798, '::1', '2025-06-04 09:17:25'),
(799, '::1', '2025-06-04 09:18:38'),
(800, '::1', '2025-06-04 09:18:38'),
(801, '::1', '2025-06-04 09:19:33'),
(802, '::1', '2025-06-04 09:19:34'),
(803, '::1', '2025-06-04 09:22:24'),
(804, '::1', '2025-06-04 09:22:24'),
(805, '::1', '2025-06-04 09:23:39'),
(806, '::1', '2025-06-04 09:23:39'),
(807, '::1', '2025-06-04 09:23:53'),
(808, '::1', '2025-06-04 09:23:53'),
(809, '::1', '2025-06-04 09:24:11'),
(810, '::1', '2025-06-04 09:24:11'),
(811, '::1', '2025-06-04 09:24:37'),
(812, '::1', '2025-06-04 09:24:38'),
(813, '::1', '2025-06-04 09:26:32'),
(814, '::1', '2025-06-04 09:26:32'),
(815, '::1', '2025-06-04 09:32:22'),
(816, '::1', '2025-06-04 09:32:22'),
(817, '::1', '2025-06-04 09:35:35'),
(818, '::1', '2025-06-04 09:35:35'),
(819, '::1', '2025-06-04 09:39:56'),
(820, '::1', '2025-06-04 09:39:56'),
(821, '::1', '2025-06-04 09:46:19'),
(822, '::1', '2025-06-04 09:46:19'),
(823, '::1', '2025-06-04 09:49:22'),
(824, '::1', '2025-06-04 09:49:22'),
(825, '::1', '2025-06-04 10:03:28'),
(826, '::1', '2025-06-04 10:03:28');

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
(15, 'สำนักงานคณะกรรมการป้องกันและปราบปรามการทุจริตแห่งชาติ', 'https://www.nacc.go.th/', 'web_1746502318.png', 'Emblem_of_the_National_Anti-Corruption_Commission_Thailand.png', 1, '2025-05-06 03:31:58', 57, 1),
(16, 'กรมบัญชีกลาง', 'https://www.cgd.go.th/', 'web_1746502460.png', '541_739_______________.png', 1, '2025-05-06 03:34:20', 57, 0),
(17, 'สภาวิชาชีพบัญชี', 'https://www.tfac.or.th/', 'web_1746502631.png', 'logo สภาฯ-01.png', 1, '2025-05-06 03:37:11', 57, 0),
(18, 'ISACA Bangkok Chapter ', 'https://www.isaca-bangkok.org/', 'web_1746502830.jpg', '308411627_454971329991729_7279520091625163665_n.jpg', 1, '2025-05-06 03:40:30', 57, 0),
(19, 'Institute Of Internal Auditors Thailand', 'https://www.theiiat.or.th/', 'web_1746503042.png', 'IIT.png', 1, '2025-05-06 03:44:02', 57, 0),
(20, 'รัฐบาลไทย', 'https://www.thaigov.go.th/main/contents', 'web_1746503240.png', 'Seal_of_the_Office_of_the_Prime_Minister_of_Thailand.png', 1, '2025-05-06 03:47:20', 57, 0),
(21, 'สำนักงานการตรวจเงินแผ่นดิน', 'https://www.audit.go.th/th/home', 'web_1746503307.png', 'Emblem_of_the_State_Audit_Office_of_the_Kingdom_of_Thailand.png', 1, '2025-05-06 03:48:27', 57, 1),
(22, 'กองคลัง', 'https://finance.op.kmutnb.ac.th/home.php', 'web_1746503413.png', 'logo_of_KMUTNB.png', 1, '2025-05-06 03:50:13', 57, 1),
(29, 'ทดสอบ', 'www.test.com', '', '', 1, '2025-06-04 02:47:08', 57, 1);

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
  MODIFY `id_committee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

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
  MODIFY `id_personal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=827;

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
  ADD CONSTRAINT `audit_committee_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

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
