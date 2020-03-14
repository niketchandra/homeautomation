-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 14, 2020 at 08:32 PM
-- Server version: 5.7.29-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rpi`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`niket`@`localhost` PROCEDURE `devicestatus` ()  UPDATE `devicestatus` SET `status`= 0  WHERE devicestatus.time >= NOW() - INTERVAL 30 MINUTE$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `devicestatus`
--

CREATE TABLE `devicestatus` (
  `id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deviceid` int(8) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devicestatus`
--

INSERT INTO `devicestatus` (`id`, `time`, `deviceid`, `status`) VALUES
(6, '2020-03-14 17:44:51', 100, 0),
(12, '2020-03-14 17:49:29', 101, 0),
(13, '2020-03-14 12:03:52', 102, 0),
(14, '2020-03-14 12:09:23', 104, 0),
(15, '2020-03-14 15:07:07', 105, 0);

--
-- Triggers `devicestatus`
--
DELIMITER $$
CREATE TRIGGER `Insertlogs` AFTER INSERT ON `devicestatus` FOR EACH ROW INSERT INTO `logs`(`table_name`, `row_id`, `device_id`, `event`, `status`) VALUES ('devicestatus', NEW.id, NEW.deviceid, 'Inserted', NEW.status)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `addport1` AFTER INSERT ON `devicestatus` FOR EACH ROW INSERT INTO `portdata`(`deviceid`, `portno`) VALUES (NEW.deviceid, 001)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `addport2` AFTER INSERT ON `devicestatus` FOR EACH ROW INSERT INTO `portdata`(`deviceid`, `portno`) VALUES (NEW.deviceid, 002)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `addport3` AFTER INSERT ON `devicestatus` FOR EACH ROW INSERT INTO `portdata`(`deviceid`, `portno`) VALUES (NEW.deviceid, 003)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `addport4` AFTER INSERT ON `devicestatus` FOR EACH ROW INSERT INTO `portdata`(`deviceid`, `portno`) VALUES (NEW.deviceid, 004)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updatelogs` AFTER UPDATE ON `devicestatus` FOR EACH ROW INSERT INTO `logs`(`table_name`, `row_id`, `device_id`, `event`, `status`) VALUES ('devicestatus', NEW.id, NEW.deviceid, 'Update', NEW.status)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `table_name` varchar(50) DEFAULT NULL,
  `row_id` int(8) NOT NULL,
  `device_id` int(11) DEFAULT NULL,
  `event` varchar(15) DEFAULT NULL,
  `portno` varchar(10) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `time`, `table_name`, `row_id`, `device_id`, `event`, `portno`, `status`) VALUES
(6, '2020-03-14 11:31:55', 'devicestatus', 6, 100, 'Inserted', NULL, '1'),
(9, '2020-03-14 11:34:55', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(11, '2020-03-14 11:37:55', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(14, '2020-03-14 11:52:09', 'portdata', 12, 101, 'Inserted', '1', '0'),
(15, '2020-03-14 11:53:58', 'devicestatus', 12, 101, 'Inserted', NULL, '1'),
(16, '2020-03-14 11:53:58', 'portdata', 13, 101, 'Inserted', '1', '0'),
(17, '2020-03-14 11:56:58', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(18, '2020-03-14 11:59:22', 'devicestatus', 13, 102, 'Inserted', NULL, '0'),
(19, '2020-03-14 11:59:22', 'portdata', 14, 102, 'Inserted', '1', '0'),
(20, '2020-03-14 11:59:22', 'portdata', 15, 102, 'Inserted', '2', '0'),
(21, '2020-03-14 11:59:22', 'portdata', 16, 102, 'Inserted', '3', '0'),
(22, '2020-03-14 11:59:22', 'portdata', 17, 102, 'Inserted', '4', '0'),
(23, '2020-03-14 11:59:58', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(24, '2020-03-14 12:00:52', 'devicestatus', 13, 102, 'Update', NULL, '1'),
(25, '2020-03-14 12:00:55', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(26, '2020-03-14 12:03:52', 'devicestatus', 13, 102, 'Update', NULL, '0'),
(27, '2020-03-14 12:03:55', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(28, '2020-03-14 12:06:23', 'devicestatus', 14, 104, 'Inserted', NULL, '1'),
(29, '2020-03-14 12:06:23', 'portdata', 18, 104, 'Inserted', '1', '1'),
(30, '2020-03-14 12:06:23', 'portdata', 19, 104, 'Inserted', '2', '1'),
(31, '2020-03-14 12:06:23', 'portdata', 20, 104, 'Inserted', '3', '1'),
(32, '2020-03-14 12:06:23', 'portdata', 21, 104, 'Inserted', '4', '1'),
(33, '2020-03-14 12:06:52', 'devicestatus', 13, 102, 'Update', NULL, '0'),
(34, '2020-03-14 12:06:55', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(35, '2020-03-14 12:09:23', 'devicestatus', 14, 104, 'Update', NULL, '0'),
(36, '2020-03-14 12:09:23', 'portdata', 18, 104, 'Inserted', '1', '0'),
(37, '2020-03-14 12:09:23', 'portdata', 19, 104, 'Inserted', '2', '0'),
(38, '2020-03-14 12:09:23', 'portdata', 20, 104, 'Inserted', '3', '0'),
(39, '2020-03-14 12:09:23', 'portdata', 21, 104, 'Inserted', '4', '0'),
(40, '2020-03-14 12:12:23', 'devicestatus', 14, 104, 'Update', NULL, '0'),
(41, '2020-03-14 12:12:23', 'portdata', 18, 104, 'Update', '1', '0'),
(42, '2020-03-14 12:12:23', 'portdata', 19, 104, 'Update', '2', '0'),
(43, '2020-03-14 12:12:23', 'portdata', 20, 104, 'Update', '3', '0'),
(44, '2020-03-14 12:12:23', 'portdata', 21, 104, 'Update', '4', '0'),
(45, '2020-03-14 15:04:07', 'devicestatus', 15, 105, 'Inserted', NULL, '1'),
(46, '2020-03-14 15:04:07', 'portdata', 22, 105, 'Inserted', '1', '1'),
(47, '2020-03-14 15:04:07', 'portdata', 23, 105, 'Inserted', '2', '1'),
(48, '2020-03-14 15:04:07', 'portdata', 24, 105, 'Inserted', '3', '1'),
(49, '2020-03-14 15:04:07', 'portdata', 25, 105, 'Inserted', '4', '1'),
(50, '2020-03-14 15:07:07', 'devicestatus', 15, 105, 'Update', NULL, '0'),
(51, '2020-03-14 15:07:07', 'portdata', 22, 105, 'Update', '1', '0'),
(52, '2020-03-14 15:07:07', 'portdata', 23, 105, 'Update', '2', '0'),
(53, '2020-03-14 15:07:07', 'portdata', 24, 105, 'Update', '3', '0'),
(54, '2020-03-14 15:07:07', 'portdata', 25, 105, 'Update', '4', '0'),
(55, '2020-03-14 15:10:07', 'devicestatus', 15, 105, 'Update', NULL, '0'),
(56, '2020-03-14 15:10:07', 'portdata', 22, 105, 'Update', '1', '0'),
(57, '2020-03-14 15:10:07', 'portdata', 23, 105, 'Update', '2', '0'),
(58, '2020-03-14 15:10:07', 'portdata', 24, 105, 'Update', '3', '0'),
(59, '2020-03-14 15:10:07', 'portdata', 25, 105, 'Update', '4', '0'),
(60, '2020-03-14 16:00:03', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(61, '2020-03-14 16:03:03', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(62, '2020-03-14 16:06:03', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(63, '2020-03-14 16:44:48', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(64, '2020-03-14 16:44:58', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(65, '2020-03-14 16:45:08', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(66, '2020-03-14 16:45:18', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(67, '2020-03-14 16:45:28', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(68, '2020-03-14 16:45:38', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(69, '2020-03-14 16:45:48', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(70, '2020-03-14 16:45:59', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(71, '2020-03-14 16:46:09', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(72, '2020-03-14 16:46:19', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(73, '2020-03-14 16:46:29', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(74, '2020-03-14 16:46:39', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(75, '2020-03-14 16:46:49', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(76, '2020-03-14 16:46:59', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(77, '2020-03-14 16:47:09', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(78, '2020-03-14 16:47:20', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(79, '2020-03-14 16:47:30', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(80, '2020-03-14 16:47:40', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(81, '2020-03-14 16:47:48', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(82, '2020-03-14 16:47:50', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(83, '2020-03-14 16:48:00', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(84, '2020-03-14 16:48:10', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(85, '2020-03-14 16:48:20', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(86, '2020-03-14 16:48:31', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(87, '2020-03-14 16:48:41', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(88, '2020-03-14 16:48:51', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(89, '2020-03-14 16:49:01', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(90, '2020-03-14 16:49:11', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(91, '2020-03-14 16:49:21', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(92, '2020-03-14 16:49:31', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(93, '2020-03-14 16:49:42', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(94, '2020-03-14 16:49:52', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(95, '2020-03-14 16:50:02', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(96, '2020-03-14 16:50:12', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(97, '2020-03-14 16:50:22', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(98, '2020-03-14 16:50:32', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(99, '2020-03-14 16:50:42', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(100, '2020-03-14 16:50:50', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(101, '2020-03-14 16:50:53', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(102, '2020-03-14 16:51:03', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(103, '2020-03-14 16:51:13', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(104, '2020-03-14 16:51:23', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(105, '2020-03-14 16:51:33', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(106, '2020-03-14 16:51:43', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(107, '2020-03-14 16:51:53', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(108, '2020-03-14 16:52:04', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(109, '2020-03-14 16:52:14', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(110, '2020-03-14 16:52:24', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(111, '2020-03-14 16:52:34', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(112, '2020-03-14 16:52:44', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(113, '2020-03-14 16:52:54', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(114, '2020-03-14 16:53:04', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(115, '2020-03-14 16:53:14', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(116, '2020-03-14 16:53:24', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(117, '2020-03-14 16:53:35', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(118, '2020-03-14 16:53:45', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(119, '2020-03-14 16:53:53', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(120, '2020-03-14 16:53:55', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(121, '2020-03-14 16:54:05', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(122, '2020-03-14 16:54:15', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(123, '2020-03-14 16:54:25', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(124, '2020-03-14 16:54:35', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(125, '2020-03-14 16:54:46', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(126, '2020-03-14 16:54:56', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(127, '2020-03-14 16:55:06', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(128, '2020-03-14 16:55:16', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(129, '2020-03-14 16:55:26', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(130, '2020-03-14 16:56:55', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(131, '2020-03-14 16:56:55', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(132, '2020-03-14 16:57:05', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(133, '2020-03-14 16:57:15', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(134, '2020-03-14 16:57:25', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(135, '2020-03-14 16:57:35', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(136, '2020-03-14 16:57:45', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(137, '2020-03-14 16:57:55', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(138, '2020-03-14 16:58:05', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(139, '2020-03-14 16:58:16', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(140, '2020-03-14 16:58:26', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(141, '2020-03-14 16:58:36', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(142, '2020-03-14 16:58:46', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(143, '2020-03-14 16:58:56', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(144, '2020-03-14 16:59:06', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(145, '2020-03-14 16:59:16', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(146, '2020-03-14 16:59:27', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(147, '2020-03-14 16:59:37', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(148, '2020-03-14 16:59:47', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(149, '2020-03-14 16:59:55', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(150, '2020-03-14 16:59:55', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(151, '2020-03-14 16:59:57', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(152, '2020-03-14 17:00:07', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(153, '2020-03-14 17:00:17', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(154, '2020-03-14 17:00:27', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(155, '2020-03-14 17:00:37', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(156, '2020-03-14 17:00:48', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(157, '2020-03-14 17:00:58', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(158, '2020-03-14 17:01:08', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(159, '2020-03-14 17:01:18', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(160, '2020-03-14 17:01:28', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(161, '2020-03-14 17:01:38', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(162, '2020-03-14 17:01:48', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(163, '2020-03-14 17:01:59', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(164, '2020-03-14 17:02:09', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(165, '2020-03-14 17:02:19', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(166, '2020-03-14 17:02:42', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(167, '2020-03-14 17:02:53', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(168, '2020-03-14 17:02:57', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(169, '2020-03-14 17:03:03', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(170, '2020-03-14 17:03:13', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(171, '2020-03-14 17:03:23', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(172, '2020-03-14 17:03:44', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(173, '2020-03-14 17:04:45', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(174, '2020-03-14 17:05:45', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(175, '2020-03-14 17:06:03', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(176, '2020-03-14 17:06:45', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(177, '2020-03-14 17:07:00', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(178, '2020-03-14 17:09:45', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(179, '2020-03-14 17:12:45', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(180, '2020-03-14 17:41:51', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(181, '2020-03-14 17:43:29', 'devicestatus', 6, 100, 'Update', NULL, '1'),
(182, '2020-03-14 17:44:51', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(183, '2020-03-14 17:46:29', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(184, '2020-03-14 17:47:29', 'devicestatus', 12, 101, 'Update', NULL, '1'),
(185, '2020-03-14 17:47:51', 'devicestatus', 6, 100, 'Update', NULL, '0'),
(186, '2020-03-14 17:49:29', 'devicestatus', 12, 101, 'Update', NULL, '0'),
(187, '2020-03-14 17:52:29', 'devicestatus', 12, 101, 'Update', NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `portdata`
--

CREATE TABLE `portdata` (
  `id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deviceid` varchar(15) NOT NULL,
  `portno` int(5) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `portdata`
--

INSERT INTO `portdata` (`id`, `time`, `deviceid`, `portno`, `status`) VALUES
(10, '2020-03-14 11:48:11', '100', 1, 0),
(13, '2020-03-14 11:53:58', '101', 1, 0),
(14, '2020-03-14 11:59:22', '102', 1, 0),
(15, '2020-03-14 11:59:22', '102', 2, 0),
(16, '2020-03-14 11:59:22', '102', 3, 0),
(17, '2020-03-14 11:59:22', '102', 4, 0),
(18, '2020-03-14 12:09:23', '104', 1, 0),
(19, '2020-03-14 12:09:23', '104', 2, 0),
(20, '2020-03-14 12:09:23', '104', 3, 0),
(21, '2020-03-14 12:09:23', '104', 4, 0),
(22, '2020-03-14 15:07:07', '105', 1, 0),
(23, '2020-03-14 15:07:07', '105', 2, 0),
(24, '2020-03-14 15:07:07', '105', 3, 0),
(25, '2020-03-14 15:07:07', '105', 4, 0);

--
-- Triggers `portdata`
--
DELIMITER $$
CREATE TRIGGER `Updatelogs_portdata` AFTER UPDATE ON `portdata` FOR EACH ROW INSERT INTO `logs`(`table_name`, `row_id`, `device_id`, `event`, `portno`, `status`) VALUES ('portdata', NEW.id, NEW.deviceid, 'Update', NEW.portno, NEW.status)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertportlogs` AFTER INSERT ON `portdata` FOR EACH ROW INSERT INTO `logs`(`table_name`, `row_id`, `device_id`, `event`, `portno`, `status`) VALUES ('portdata', NEW.id, NEW.deviceid, 'Inserted', NEW.portno, NEW.status)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `port_type`
--

CREATE TABLE `port_type` (
  `id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(20) DEFAULT NULL,
  `values` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `port_type`
--

INSERT INTO `port_type` (`id`, `time`, `type`, `values`) VALUES
(3, '2020-03-14 12:44:48', 'switch', 0),
(4, '2020-03-14 12:44:48', 'fan', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `devicestatus`
--
ALTER TABLE `devicestatus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `portdata`
--
ALTER TABLE `portdata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `port_type`
--
ALTER TABLE `port_type`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `devicestatus`
--
ALTER TABLE `devicestatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=188;

--
-- AUTO_INCREMENT for table `portdata`
--
ALTER TABLE `portdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `port_type`
--
ALTER TABLE `port_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`niket`@`localhost` EVENT `Device_status` ON SCHEDULE EVERY 1 SECOND STARTS '2020-03-14 10:10:46' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE `devicestatus` SET `status`= 0  WHERE devicestatus.time = NOW() - INTERVAL 03 MINUTE$$

CREATE DEFINER=`niket`@`localhost` EVENT `port_status` ON SCHEDULE EVERY 1 SECOND STARTS '2020-03-14 12:05:09' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE `portdata` SET `status`= 0  WHERE portdata.time = NOW() - INTERVAL 03 MINUTE$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
