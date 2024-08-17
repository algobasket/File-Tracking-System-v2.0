-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2024 at 07:59 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `oefhz`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add correspondence', 7, 'add_correspondence'),
(26, 'Can change correspondence', 7, 'change_correspondence'),
(27, 'Can delete correspondence', 7, 'delete_correspondence'),
(28, 'Can view correspondence', 7, 'view_correspondence'),
(29, 'Can add department', 8, 'add_department'),
(30, 'Can change department', 8, 'change_department'),
(31, 'Can delete department', 8, 'delete_department'),
(32, 'Can view department', 8, 'view_department'),
(33, 'Can add role', 9, 'add_role'),
(34, 'Can change role', 9, 'change_role'),
(35, 'Can delete role', 9, 'delete_role'),
(36, 'Can view role', 9, 'view_role'),
(37, 'Can add sub department', 10, 'add_subdepartment'),
(38, 'Can change sub department', 10, 'change_subdepartment'),
(39, 'Can delete sub department', 10, 'delete_subdepartment'),
(40, 'Can view sub department', 10, 'view_subdepartment'),
(41, 'Can add user', 11, 'add_user'),
(42, 'Can change user', 11, 'change_user'),
(43, 'Can delete user', 11, 'delete_user'),
(44, 'Can view user', 11, 'view_user'),
(45, 'Can add user role map', 12, 'add_userrolemap'),
(46, 'Can change user role map', 12, 'change_userrolemap'),
(47, 'Can delete user role map', 12, 'delete_userrolemap'),
(48, 'Can view user role map', 12, 'view_userrolemap'),
(49, 'Can add user detail', 13, 'add_userdetail'),
(50, 'Can change user detail', 13, 'change_userdetail'),
(51, 'Can delete user detail', 13, 'delete_userdetail'),
(52, 'Can view user detail', 13, 'view_userdetail'),
(53, 'Can add store document', 14, 'add_storedocument'),
(54, 'Can change store document', 14, 'change_storedocument'),
(55, 'Can delete store document', 14, 'delete_storedocument'),
(56, 'Can view store document', 14, 'view_storedocument'),
(57, 'Can add message', 15, 'add_message'),
(58, 'Can change message', 15, 'change_message'),
(59, 'Can delete message', 15, 'delete_message'),
(60, 'Can view message', 15, 'view_message'),
(61, 'Can add department role map', 16, 'add_departmentrolemap'),
(62, 'Can change department role map', 16, 'change_departmentrolemap'),
(63, 'Can delete department role map', 16, 'delete_departmentrolemap'),
(64, 'Can view department role map', 16, 'view_departmentrolemap'),
(65, 'Can add correspondence user map', 17, 'add_correspondenceusermap'),
(66, 'Can change correspondence user map', 17, 'change_correspondenceusermap'),
(67, 'Can delete correspondence user map', 17, 'delete_correspondenceusermap'),
(68, 'Can view correspondence user map', 17, 'view_correspondenceusermap'),
(69, 'Can add noting', 18, 'add_noting'),
(70, 'Can change noting', 18, 'change_noting'),
(71, 'Can delete noting', 18, 'delete_noting'),
(72, 'Can view noting', 18, 'view_noting'),
(73, 'Can add noting user map', 19, 'add_notingusermap'),
(74, 'Can change noting user map', 19, 'change_notingusermap'),
(75, 'Can delete noting user map', 19, 'delete_notingusermap'),
(76, 'Can view noting user map', 19, 'view_notingusermap');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'fts_app', 'correspondence'),
(17, 'fts_app', 'correspondenceusermap'),
(8, 'fts_app', 'department'),
(16, 'fts_app', 'departmentrolemap'),
(15, 'fts_app', 'message'),
(18, 'fts_app', 'noting'),
(19, 'fts_app', 'notingusermap'),
(9, 'fts_app', 'role'),
(14, 'fts_app', 'storedocument'),
(10, 'fts_app', 'subdepartment'),
(11, 'fts_app', 'user'),
(13, 'fts_app', 'userdetail'),
(12, 'fts_app', 'userrolemap'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-05-08 12:22:59.471009'),
(2, 'auth', '0001_initial', '2024-05-08 12:22:59.832074'),
(3, 'admin', '0001_initial', '2024-05-08 12:22:59.974278'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-05-08 12:22:59.979500'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-05-08 12:22:59.985257'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-05-08 12:23:00.020760'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-05-08 12:23:00.124453'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-05-08 12:23:00.132966'),
(9, 'auth', '0004_alter_user_username_opts', '2024-05-08 12:23:00.138475'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-05-08 12:23:00.163019'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-05-08 12:23:00.164523'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-05-08 12:23:00.169532'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-05-08 12:23:00.176550'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-05-08 12:23:00.185572'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-05-08 12:23:00.193080'),
(16, 'auth', '0011_update_proxy_permissions', '2024-05-08 12:23:00.196589'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-05-08 12:23:00.203101'),
(18, 'fts_app', '0001_initial', '2024-05-08 12:23:01.297638'),
(19, 'sessions', '0001_initial', '2024-05-08 12:23:01.319777'),
(20, 'fts_app', '0002_alter_userdetail_user_alter_userrolemap_user', '2024-05-08 16:43:40.581962'),
(21, 'fts_app', '0003_correspondenceusermap_is_forwarded_and_more', '2024-05-12 00:44:51.788170'),
(22, 'fts_app', '0004_remove_correspondence_department_and_more', '2024-05-21 00:03:23.203489'),
(23, 'fts_app', '0005_message_is_forwarded_message_is_opened_and_more', '2024-05-21 17:00:02.614093'),
(24, 'fts_app', '0006_userdetail_phone', '2024-05-22 10:18:25.581472'),
(25, 'fts_app', '0007_alter_userdetail_full_name', '2024-05-22 10:19:43.635173'),
(26, 'fts_app', '0008_alter_userdetail_phone', '2024-05-22 10:24:01.653980'),
(27, 'fts_app', '0009_correspondenceusermap_message', '2024-05-23 03:49:20.129782'),
(28, 'fts_app', '0010_alter_correspondenceusermap_message', '2024-05-23 06:45:22.120659'),
(29, 'fts_app', '0011_alter_message_document', '2024-06-01 00:14:20.980245'),
(30, 'fts_app', '0012_noting_notingusermap', '2024-08-08 00:07:02.750487'),
(31, 'fts_app', '0013_noting_comment_noting_digital_signature', '2024-08-08 00:38:20.016834'),
(32, 'fts_app', '0014_noting_selected_user', '2024-08-08 01:36:53.404850'),
(33, 'fts_app', '0015_notingusermap_digital_signature', '2024-08-08 22:23:13.501064'),
(34, 'fts_app', '0016_notingusermap_signature_image', '2024-08-13 05:11:47.897353'),
(35, 'fts_app', '0017_noting_signature_image', '2024-08-13 05:47:34.903780'),
(36, 'fts_app', '0018_alter_noting_filename_dak_doc', '2024-08-13 08:15:34.211208');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('1mdxsvjqj58qa3qq5f3717fxiwz8dz5g', '.eJyrViotTi2Kz0xRsjI10AFz8hJzU5WslBxTcjPzlHSUivJzUsHyhhA2UCoRKpWRn5saX1qUAxRKSSzOSMpPLErRhUjWAgAZKR2H:1sdwQ8:pDsE59OUl8U0COLn17A6YtXK26EFfQtHHOOssO4yct0', '2024-08-27 18:39:00.070064'),
('38vjjqh6t88avt9ni1rcee57598no3pd', '.eJyrViotTi2Kz0xRsjI11gFz8hJzU5WslDzyiw2NjJV0lIryc1LBCkwgbKBcRn4xUCIjPzc1vrQoByiQklickZSfWJSim5JakFhUkpuaV6JUCwB2ih7Q:1sfNSm:4BLOOsTbxtZz_lDeVdovtG1rzVv03sQ4QTHp90NqDl8', '2024-08-31 17:43:40.401087'),
('4a6znlk10aj0ysdcpkk021bm6esjeie2', '.eJyrViotTi2Kz0xRsjI10AFz8hJzU5WslBJTcjPzlHSUivJzUsHyhhA2klRGfm5qfGlRDlAoJbE4Iyk_sShFFyJZCwAhCR2n:1sFllk:9RY1Y5x0aK3pd7cxCfk0eIo1cAmc6cVPGq1u1bVSk7E', '2024-06-22 02:25:24.888135'),
('9nyffdci65akoejyd65kht3zcnby8zjv', '.eJyrViotTi2Kz0xRsjLWAbPzEnNTlayU0nOLlXSUivJzUsGSRhA2XCIjPzc1vrQoByiQklickZSfWJSiC5KqBQBbuhsw:1sAXfR:Y9_yK0lvBElRKaC5oKFZ7RuV8tnjBSoWW7Lrg1BeWV0', '2024-06-07 16:21:17.782901'),
('c6o0dkb53fvhbspms63ej9k7edzsucms', '.eJyrViotTi2Kz0xRsjLWAbPzEnNTlayU0nOLlXSUivJzUsGSRhA2VKIWAP2qEcs:1s5BOE:7opskUeh6Yl_1GDUNEmpzeRkF2E0fxD3TXs_v3WfSO8', '2024-05-23 21:33:22.829224'),
('gf28qfa8zkt2pl60ojggzot9z247l1pp', 'e30:1sYZBM:og6QkBepPH-eJTy1c0wFmMZB8d_llh7Z4tPEr1C1kMQ', '2024-08-12 22:49:32.161001'),
('i5fkrr1r48v2fvzv9r0z81pgsmcd5fmz', 'e30:1sAZWg:dATyjH2viWcmVIivth_H7T-Cayy4NDC2oUAx95Wbo7I', '2024-06-07 18:20:22.662057'),
('ku8l3smrwa8gwpsdgvat00tjnjrf7xhp', '.eJyrViotTi2Kz0xRsjI10AFz8hJzU5WslBJTcjPzlHSUivJzUsHyhhA2klRGfm5qfGlRDlAoJbE4Iyk_sShFFyJZCwAhCR2n:1sFmeg:Wf0hPHwMlzbZBMex7go0-YyTGYsEQuP3PDvDR8GIDwI', '2024-06-22 03:22:10.988077'),
('w6jl23d7hpvao0zhd0fkx5gyo3hkqo4z', '.eJyrViotTi2Kz0xRsjLUAbPzEnNTlayUElNyM_OUdJSK8nNSYdIgNpJURn5uanxpUQ5QKCWxOCMpP7EoRRciWQsADUsdcw:1sDDST:9LBQaRKoJyFHqerRb66XsLUt4ni3_FYjqcCX8pnRbaY', '2024-06-15 01:22:57.560977'),
('zz0e21xlbuz9nmtr7xgxdomuhn7sbsyf', '.eJyrViotTi2Kz0xRsrLUAbPzEnNTlazATFMlHaWi_JxUsLQJhA2UysgvVqoFACWaEoM:1s5wcK:azfOnsNR2I84UhvrQSqP0_P3p1RuWsZxBt0G-_tp0js', '2024-05-25 23:59:04.989179');

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_correspondence`
--

CREATE TABLE `fts_app_correspondence` (
  `id` bigint(20) NOT NULL,
  `corr_no` varchar(255) NOT NULL,
  `priority` varchar(10) NOT NULL,
  `int_ext` varchar(10) NOT NULL,
  `name_of_designation` varchar(255) NOT NULL,
  `email_id` varchar(254) NOT NULL,
  `type_of_doc` varchar(255) NOT NULL,
  `do_received_from` varchar(255) NOT NULL,
  `reference_number` varchar(100) NOT NULL,
  `reference_date` date NOT NULL,
  `subject` varchar(255) NOT NULL,
  `action_marked` varchar(255) NOT NULL,
  `date_of_forwarding` date NOT NULL,
  `documents` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_correspondence`
--

INSERT INTO `fts_app_correspondence` (`id`, `corr_no`, `priority`, `int_ext`, `name_of_designation`, `email_id`, `type_of_doc`, `do_received_from`, `reference_number`, `reference_date`, `subject`, `action_marked`, `date_of_forwarding`, `documents`, `status`, `role_id`, `user_id`) VALUES
(51, 'CO-080624062133', 'high', 'internal', 'Algobasket', '', 'algobasket@gmail.com', 'Kunal', '123456', '2024-06-08', 'Subject Test', 'Yes', '2024-06-08', '29', 1, 8, 51),
(52, 'CO-080624062934', 'high', 'internal', 'Algobasket 2', '', 'PDF file', 'Lavit', '123456', '2024-06-09', 'Subject Test 2', 'Yes', '2024-06-09', '29', 1, 8, 51);

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_correspondenceusermap`
--

CREATE TABLE `fts_app_correspondenceusermap` (
  `id` bigint(20) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` int(11) NOT NULL,
  `correspondence_id` bigint(20) NOT NULL,
  `from_user_id` bigint(20) NOT NULL,
  `to_user_id` bigint(20) NOT NULL,
  `is_forwarded` int(11) NOT NULL,
  `is_opened` int(11) NOT NULL,
  `message` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_correspondenceusermap`
--

INSERT INTO `fts_app_correspondenceusermap` (`id`, `created`, `updated`, `status`, `correspondence_id`, `from_user_id`, `to_user_id`, `is_forwarded`, `is_opened`, `message`) VALUES
(49, '2024-06-08 00:51:33.277218', '2024-06-08 00:51:33.277218', 1, 51, 51, 57, 0, 0, NULL),
(50, '2024-06-08 00:59:34.703907', '2024-06-08 00:59:34.703907', 1, 52, 51, 57, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_department`
--

CREATE TABLE `fts_app_department` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug_name` varchar(255) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_departmentrolemap`
--

CREATE TABLE `fts_app_departmentrolemap` (
  `id` bigint(20) NOT NULL,
  `department_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `sub_department_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_message`
--

CREATE TABLE `fts_app_message` (
  `id` bigint(20) NOT NULL,
  `from_email` varchar(254) DEFAULT NULL,
  `to_email` varchar(254) DEFAULT NULL,
  `message` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` int(11) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `from_user_id` bigint(20) NOT NULL,
  `to_user_id` bigint(20) NOT NULL,
  `is_forwarded` int(11) NOT NULL,
  `is_opened` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_message`
--

INSERT INTO `fts_app_message` (`id`, `from_email`, `to_email`, `message`, `created`, `updated`, `status`, `document_id`, `from_user_id`, `to_user_id`, `is_forwarded`, `is_opened`) VALUES
(46, 'dakghar@oefhz.com', 'admin@oefhz.com', 'test', '2024-06-07 23:37:15.294186', '2024-06-07 23:37:15.294186', 1, 28, 52, 50, 0, 0),
(47, 'dakghar@oefhz.com', 'gms@oefhz.com', 'test', '2024-06-07 23:37:15.295184', '2024-06-08 01:08:45.227126', 1, 28, 52, 51, 0, 1),
(48, 'dakghar@oefhz.com', 'gm@oefhz.com', 'test', '2024-06-07 23:37:15.296688', '2024-06-07 23:37:15.296688', 1, 28, 52, 57, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_noting`
--

CREATE TABLE `fts_app_noting` (
  `id` bigint(20) NOT NULL,
  `noting_no` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `filename_doc` varchar(255) NOT NULL,
  `filename_dak_doc` varchar(255) DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` smallint(5) UNSIGNED NOT NULL CHECK (`status` >= 0),
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `comment` longtext DEFAULT NULL,
  `digital_signature` longtext DEFAULT NULL,
  `selected_user_id` bigint(20) NOT NULL,
  `signature_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_noting`
--

INSERT INTO `fts_app_noting` (`id`, `noting_no`, `title`, `filename_doc`, `filename_dak_doc`, `created`, `updated`, `status`, `role_id`, `user_id`, `comment`, `digital_signature`, `selected_user_id`, `signature_image`) VALUES
(11, 'N-217235', 'Demo Noting 1', '20240813143526.jpg', NULL, '2024-08-13 14:35:26.364096', '2024-08-13 14:35:26.364096', 1, 6, 53, NULL, 'HOS Signature', 55, NULL),
(12, 'N-587523', 'Demo Noting 2', '20240813143628.jpg', NULL, '2024-08-13 14:36:28.280211', '2024-08-13 14:36:28.280211', 1, 8, 53, NULL, 'HOS Signature', 57, '20240813143628_signature.png');

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_notingusermap`
--

CREATE TABLE `fts_app_notingusermap` (
  `id` bigint(20) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` int(11) NOT NULL,
  `is_opened` int(11) NOT NULL,
  `is_forwarded` int(11) NOT NULL,
  `message` longtext DEFAULT NULL,
  `from_user_id` bigint(20) NOT NULL,
  `noting_id` bigint(20) NOT NULL,
  `to_user_id` bigint(20) NOT NULL,
  `digital_signature` longtext DEFAULT NULL,
  `signature_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_notingusermap`
--

INSERT INTO `fts_app_notingusermap` (`id`, `created`, `updated`, `status`, `is_opened`, `is_forwarded`, `message`, `from_user_id`, `noting_id`, `to_user_id`, `digital_signature`, `signature_image`) VALUES
(15, '2024-08-13 14:35:26.365587', '2024-08-13 14:35:26.365587', 1, 1, 1, NULL, 53, 11, 55, 'HOS  Signature', NULL),
(16, '2024-08-13 14:36:28.281210', '2024-08-13 14:36:28.281210', 1, 0, 0, NULL, 53, 12, 57, 'HOS Signature', '20240813143628_signature.png'),
(17, '2024-08-13 14:40:03.652168', '2024-08-13 14:40:03.652168', 1, 0, 0, 'CO Comment', 55, 11, 55, 'CO Signature', NULL),
(18, '2024-08-13 14:53:49.065604', '2024-08-13 14:53:49.065604', 1, 0, 0, 'CO Comments', 55, 11, 56, 'Co Signature', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_role`
--

CREATE TABLE `fts_app_role` (
  `id` bigint(20) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_role`
--

INSERT INTO `fts_app_role` (`id`, `role_name`, `description`, `status`) VALUES
(1, 'ADMIN', 'admin', 1),
(2, 'GMS', 'gms', 1),
(3, 'DAKGHAR', 'dak', 1),
(4, 'HOS', 'hos', 1),
(5, 'GO', 'go', 1),
(6, 'CO', 'co', 1),
(7, 'DO', 'do', 1),
(8, 'GM', 'gm', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_storedocument`
--

CREATE TABLE `fts_app_storedocument` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` smallint(5) UNSIGNED NOT NULL CHECK (`status` >= 0),
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_storedocument`
--

INSERT INTO `fts_app_storedocument` (`id`, `title`, `filename`, `created`, `updated`, `status`, `user_id`) VALUES
(28, 'Parachute Parts', '20240607233652.pdf', '2024-06-07 23:36:52.782945', '2024-06-07 23:36:52.782945', 2, 52);

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_subdepartment`
--

CREATE TABLE `fts_app_subdepartment` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug_name` varchar(255) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_user_id` bigint(20) NOT NULL,
  `department_id_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_user`
--

CREATE TABLE `fts_app_user` (
  `id` bigint(20) NOT NULL,
  `username` varchar(150) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `password` varchar(128) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_user`
--

INSERT INTO `fts_app_user` (`id`, `username`, `email`, `password`, `created`, `updated`, `status`) VALUES
(50, 'Admin', 'admin@oefhz.com', 'pbkdf2_sha256$600000$NWGYCRBP35J8szo27kZP46$4p1lNwO27YRmk5j79BLgu180DYYOa9h4Z1wClNVqRDg=', '2024-06-05 00:26:06.981712', '2024-06-05 00:26:06.982709', 1),
(51, 'Gms123', 'gms@oefhz.com', 'pbkdf2_sha256$600000$lBCszB4hz8FQ6IWi4SWz1R$YeyNCxsVaRFS6GHUqdH8s0AjMAIdM/lx/F/l6V11d5c=', '2024-06-05 00:26:07.152011', '2024-06-05 00:26:07.152011', 1),
(52, 'Dakghar123', 'dakghar@oefhz.com', 'pbkdf2_sha256$600000$o3w0s1HFJr3bq38T0dOi5o$cCyVe2ppsQ6WedAmi67Po2Jn5JQSzsgDr2cQaG7tnh8=', '2024-06-05 00:26:07.321139', '2024-06-05 00:26:07.321139', 1),
(53, 'Hos123', 'hos@oefhz.com', 'pbkdf2_sha256$600000$iSn4ZcZ6MRmL8emsqHdi3D$CfI9fJlXl9eLi0olCL0+gdF1rIso5CWXhdhpbVbTMUI=', '2024-06-05 00:26:07.491629', '2024-06-05 00:26:07.491629', 1),
(54, 'Go123', 'go@oefhz.com', 'pbkdf2_sha256$600000$G3NmCcsR9EaqjcAr5ftbAU$IQNIi3+/nxOHI5vSo7jvyIyngPqpEVqfUHgkUFWsQ54=', '2024-06-05 00:26:07.659087', '2024-06-07 23:12:17.547869', 1),
(55, 'Co123', 'co@oefhz.com', 'pbkdf2_sha256$600000$9Xsdx9X0xsraw0WwnsSby2$m1JvUJgAcgKYM6GXbvfVViGGwT5Uiafe8pmJypbBvMQ=', '2024-06-05 00:26:07.828628', '2024-06-07 23:11:34.979231', 1),
(56, 'Do123', 'do@oefhz.com', 'pbkdf2_sha256$600000$hkD4ps9xPH8yF3Ld7s7Vmf$TyQmHShoAJ8jqtzd/UUAHoQohQU5ZEZfquyCU2Admis=', '2024-06-05 00:26:08.000616', '2024-06-05 00:26:08.000616', 1),
(57, 'Gm123', 'gm@oefhz.com', 'pbkdf2_sha256$600000$8d5rIToaB3BaRmp5HHcHUC$wMMnxfr1i4xPIs1ozm6C67jB9gQD+5ydG+zPatNoWZ0=', '2024-06-05 00:26:08.169568', '2024-06-05 00:26:08.169568', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_userdetail`
--

CREATE TABLE `fts_app_userdetail` (
  `id` bigint(20) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `phone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_userdetail`
--

INSERT INTO `fts_app_userdetail` (`id`, `email`, `full_name`, `created`, `updated`, `status`, `user_id`, `phone`) VALUES
(47, 'admin@oefhz.com', 'Ankit Admin', '2024-06-05 00:26:06.984216', '2024-06-05 00:26:06.984216', 1, 50, '1111111111'),
(48, 'gms@oefhz.com', 'Sunil', '2024-06-05 00:26:07.153013', '2024-06-05 00:26:07.153013', 1, 51, '1111111111'),
(49, 'dakghar@oefhz.com', 'Rahul', '2024-06-05 00:26:07.323138', '2024-06-05 00:26:07.323138', 1, 52, '1111111111'),
(50, 'hos@oefhz.com', 'Amit', '2024-06-05 00:26:07.492629', '2024-06-05 00:26:07.492629', 1, 53, '1111111111'),
(51, 'go@oefhz.com', 'Rakesh', '2024-06-05 00:26:07.661089', '2024-06-05 00:26:07.661089', 1, 54, '1111111111'),
(52, 'co@oefhz.com', 'Mohit', '2024-06-05 00:26:07.830634', '2024-06-05 00:26:07.830634', 1, 55, '1111111111'),
(53, 'do@oefhz.com', 'Lavit', '2024-06-05 00:26:08.001615', '2024-06-05 00:26:08.001615', 1, 56, '1111111111'),
(54, 'gm@oefhz.com', 'Ravi', '2024-06-05 00:26:08.170569', '2024-06-05 00:26:08.170569', 1, 57, '1111111111');

-- --------------------------------------------------------

--
-- Table structure for table `fts_app_userrolemap`
--

CREATE TABLE `fts_app_userrolemap` (
  `id` bigint(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fts_app_userrolemap`
--

INSERT INTO `fts_app_userrolemap` (`id`, `status`, `role_id`, `user_id`) VALUES
(47, 1, 1, 50),
(48, 1, 2, 51),
(49, 1, 3, 52),
(50, 1, 4, 53),
(51, 1, 5, 54),
(52, 1, 6, 55),
(53, 1, 7, 56),
(54, 1, 8, 57);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `fts_app_correspondence`
--
ALTER TABLE `fts_app_correspondence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_correspondence_role_id_8969377c_fk_fts_app_role_id` (`role_id`),
  ADD KEY `fts_app_correspondence_user_id_1ef11dc3_fk_fts_app_user_id` (`user_id`);

--
-- Indexes for table `fts_app_correspondenceusermap`
--
ALTER TABLE `fts_app_correspondenceusermap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_corresponden_correspondence_id_0f4afb97_fk_fts_app_c` (`correspondence_id`),
  ADD KEY `fts_app_corresponden_from_user_id_c97fa0c3_fk_fts_app_u` (`from_user_id`),
  ADD KEY `fts_app_corresponden_to_user_id_94d958d5_fk_fts_app_u` (`to_user_id`);

--
-- Indexes for table `fts_app_department`
--
ALTER TABLE `fts_app_department`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_department_created_user_id_422dafff_fk_fts_app_user_id` (`created_user_id`);

--
-- Indexes for table `fts_app_departmentrolemap`
--
ALTER TABLE `fts_app_departmentrolemap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_departmentro_department_id_9e89673e_fk_fts_app_d` (`department_id`),
  ADD KEY `fts_app_departmentrolemap_role_id_019d7d13_fk_fts_app_role_id` (`role_id`),
  ADD KEY `fts_app_departmentro_sub_department_id_f978b2b9_fk_fts_app_s` (`sub_department_id`);

--
-- Indexes for table `fts_app_message`
--
ALTER TABLE `fts_app_message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_message_document_id_2d37c15a_fk_fts_app_storedocument_id` (`document_id`),
  ADD KEY `fts_app_message_from_user_id_20b3e48a_fk_fts_app_user_id` (`from_user_id`),
  ADD KEY `fts_app_message_to_user_id_bf6a71fa_fk_fts_app_user_id` (`to_user_id`);

--
-- Indexes for table `fts_app_noting`
--
ALTER TABLE `fts_app_noting`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_noting_role_id_c87c563e_fk_fts_app_role_id` (`role_id`),
  ADD KEY `fts_app_noting_user_id_9284b015_fk_fts_app_user_id` (`user_id`),
  ADD KEY `fts_app_noting_selected_user_id_c997efa9_fk_fts_app_user_id` (`selected_user_id`);

--
-- Indexes for table `fts_app_notingusermap`
--
ALTER TABLE `fts_app_notingusermap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_notingusermap_from_user_id_581e0a95_fk_fts_app_user_id` (`from_user_id`),
  ADD KEY `fts_app_notingusermap_noting_id_389cfed9_fk_fts_app_noting_id` (`noting_id`),
  ADD KEY `fts_app_notingusermap_to_user_id_24061f86_fk_fts_app_user_id` (`to_user_id`);

--
-- Indexes for table `fts_app_role`
--
ALTER TABLE `fts_app_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fts_app_storedocument`
--
ALTER TABLE `fts_app_storedocument`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_storedocument_user_id_fd7456db_fk_fts_app_user_id` (`user_id`);

--
-- Indexes for table `fts_app_subdepartment`
--
ALTER TABLE `fts_app_subdepartment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_subdepartmen_created_user_id_c445b5a7_fk_fts_app_u` (`created_user_id`),
  ADD KEY `fts_app_subdepartmen_department_id_id_55f5124b_fk_fts_app_d` (`department_id_id`);

--
-- Indexes for table `fts_app_user`
--
ALTER TABLE `fts_app_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `fts_app_userdetail`
--
ALTER TABLE `fts_app_userdetail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fts_app_userdetail_user_id_9ffc4649_fk_fts_app_user_id` (`user_id`);

--
-- Indexes for table `fts_app_userrolemap`
--
ALTER TABLE `fts_app_userrolemap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fts_app_userrolemap_role_id_1dffc6d3_fk_fts_app_role_id` (`role_id`),
  ADD KEY `fts_app_userrolemap_user_id_83aeac7f_fk_fts_app_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `fts_app_correspondence`
--
ALTER TABLE `fts_app_correspondence`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `fts_app_correspondenceusermap`
--
ALTER TABLE `fts_app_correspondenceusermap`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `fts_app_department`
--
ALTER TABLE `fts_app_department`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `fts_app_departmentrolemap`
--
ALTER TABLE `fts_app_departmentrolemap`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `fts_app_message`
--
ALTER TABLE `fts_app_message`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `fts_app_noting`
--
ALTER TABLE `fts_app_noting`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `fts_app_notingusermap`
--
ALTER TABLE `fts_app_notingusermap`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `fts_app_role`
--
ALTER TABLE `fts_app_role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `fts_app_storedocument`
--
ALTER TABLE `fts_app_storedocument`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `fts_app_subdepartment`
--
ALTER TABLE `fts_app_subdepartment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `fts_app_user`
--
ALTER TABLE `fts_app_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `fts_app_userdetail`
--
ALTER TABLE `fts_app_userdetail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `fts_app_userrolemap`
--
ALTER TABLE `fts_app_userrolemap`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `fts_app_correspondence`
--
ALTER TABLE `fts_app_correspondence`
  ADD CONSTRAINT `fts_app_correspondence_role_id_8969377c_fk_fts_app_role_id` FOREIGN KEY (`role_id`) REFERENCES `fts_app_role` (`id`),
  ADD CONSTRAINT `fts_app_correspondence_user_id_1ef11dc3_fk_fts_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `fts_app_user` (`id`);

--
-- Constraints for table `fts_app_correspondenceusermap`
--
ALTER TABLE `fts_app_correspondenceusermap`
  ADD CONSTRAINT `fts_app_corresponden_correspondence_id_0f4afb97_fk_fts_app_c` FOREIGN KEY (`correspondence_id`) REFERENCES `fts_app_correspondence` (`id`),
  ADD CONSTRAINT `fts_app_corresponden_from_user_id_c97fa0c3_fk_fts_app_u` FOREIGN KEY (`from_user_id`) REFERENCES `fts_app_user` (`id`),
  ADD CONSTRAINT `fts_app_corresponden_to_user_id_94d958d5_fk_fts_app_u` FOREIGN KEY (`to_user_id`) REFERENCES `fts_app_user` (`id`);

--
-- Constraints for table `fts_app_department`
--
ALTER TABLE `fts_app_department`
  ADD CONSTRAINT `fts_app_department_created_user_id_422dafff_fk_fts_app_user_id` FOREIGN KEY (`created_user_id`) REFERENCES `fts_app_user` (`id`);

--
-- Constraints for table `fts_app_departmentrolemap`
--
ALTER TABLE `fts_app_departmentrolemap`
  ADD CONSTRAINT `fts_app_departmentro_department_id_9e89673e_fk_fts_app_d` FOREIGN KEY (`department_id`) REFERENCES `fts_app_department` (`id`),
  ADD CONSTRAINT `fts_app_departmentro_sub_department_id_f978b2b9_fk_fts_app_s` FOREIGN KEY (`sub_department_id`) REFERENCES `fts_app_subdepartment` (`id`),
  ADD CONSTRAINT `fts_app_departmentrolemap_role_id_019d7d13_fk_fts_app_role_id` FOREIGN KEY (`role_id`) REFERENCES `fts_app_role` (`id`);

--
-- Constraints for table `fts_app_message`
--
ALTER TABLE `fts_app_message`
  ADD CONSTRAINT `fts_app_message_from_user_id_20b3e48a_fk_fts_app_user_id` FOREIGN KEY (`from_user_id`) REFERENCES `fts_app_user` (`id`),
  ADD CONSTRAINT `fts_app_message_to_user_id_bf6a71fa_fk_fts_app_user_id` FOREIGN KEY (`to_user_id`) REFERENCES `fts_app_user` (`id`);

--
-- Constraints for table `fts_app_noting`
--
ALTER TABLE `fts_app_noting`
  ADD CONSTRAINT `fts_app_noting_role_id_c87c563e_fk_fts_app_role_id` FOREIGN KEY (`role_id`) REFERENCES `fts_app_role` (`id`),
  ADD CONSTRAINT `fts_app_noting_selected_user_id_c997efa9_fk_fts_app_user_id` FOREIGN KEY (`selected_user_id`) REFERENCES `fts_app_user` (`id`),
  ADD CONSTRAINT `fts_app_noting_user_id_9284b015_fk_fts_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `fts_app_user` (`id`);

--
-- Constraints for table `fts_app_notingusermap`
--
ALTER TABLE `fts_app_notingusermap`
  ADD CONSTRAINT `fts_app_notingusermap_from_user_id_581e0a95_fk_fts_app_user_id` FOREIGN KEY (`from_user_id`) REFERENCES `fts_app_user` (`id`),
  ADD CONSTRAINT `fts_app_notingusermap_noting_id_389cfed9_fk_fts_app_noting_id` FOREIGN KEY (`noting_id`) REFERENCES `fts_app_noting` (`id`),
  ADD CONSTRAINT `fts_app_notingusermap_to_user_id_24061f86_fk_fts_app_user_id` FOREIGN KEY (`to_user_id`) REFERENCES `fts_app_user` (`id`);

--
-- Constraints for table `fts_app_storedocument`
--
ALTER TABLE `fts_app_storedocument`
  ADD CONSTRAINT `fts_app_storedocument_user_id_fd7456db_fk_fts_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `fts_app_user` (`id`);

--
-- Constraints for table `fts_app_subdepartment`
--
ALTER TABLE `fts_app_subdepartment`
  ADD CONSTRAINT `fts_app_subdepartmen_created_user_id_c445b5a7_fk_fts_app_u` FOREIGN KEY (`created_user_id`) REFERENCES `fts_app_user` (`id`),
  ADD CONSTRAINT `fts_app_subdepartmen_department_id_id_55f5124b_fk_fts_app_d` FOREIGN KEY (`department_id_id`) REFERENCES `fts_app_department` (`id`);

--
-- Constraints for table `fts_app_userdetail`
--
ALTER TABLE `fts_app_userdetail`
  ADD CONSTRAINT `fts_app_userdetail_user_id_9ffc4649_fk_fts_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `fts_app_user` (`id`);

--
-- Constraints for table `fts_app_userrolemap`
--
ALTER TABLE `fts_app_userrolemap`
  ADD CONSTRAINT `fts_app_userrolemap_role_id_1dffc6d3_fk_fts_app_role_id` FOREIGN KEY (`role_id`) REFERENCES `fts_app_role` (`id`),
  ADD CONSTRAINT `fts_app_userrolemap_user_id_83aeac7f_fk_fts_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `fts_app_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
