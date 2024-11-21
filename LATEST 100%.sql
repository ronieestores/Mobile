-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2024 at 08:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `online_voting_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile_number` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fingerprint` blob DEFAULT NULL,
  `role` enum('Admin') NOT NULL DEFAULT 'Admin',
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `photo`, `first_name`, `last_name`, `email`, `mobile_number`, `password`, `fingerprint`, `role`, `last_login`, `created_at`, `updated_at`) VALUES
(11, '../uploads/admin-photos/ronie_estores.jpg', 'Ronie', 'Estores', 'estoresronie89@gmail.com', '09319115776', '$2y$10$Mwi.sikTYzlvLwYckR7uCup8ZDHjGwzf8BvDYVSn5jMug4J9bS3Gq', 0x00f88101c82ae3735cc04138ac3e0f9342b0c676f7550fc765724e7feed5332e83bf8ff0170e8e167d6043a4ebdcea651975c813602e75471fe3eb1a2eefba4508108e18d3bcddc5b6f6e71371d342bd5c5f518092655afce3dab97761a39d5b306bce35a004aff907f9f0a9715d43cf5531c96902ff5e52781ba36b3eb573e2688ac14f8ca16bc2a6d4c3f3e732e328190c2f3dbcebac43b480a867046bbcd7dc151329a576cf4f534acfa9083f4f5b64742da9402af54eb2ff6fea2e01e607e74e0152cb650bf27dca57a7830065c0357ea078838cffdc8c3ce795bc06ac97368eae88466935d4501c6a71d7bf38d0ccdeb7aa01e7aad7c88e384a3da2636722312cce301dacc91e522019fee6a5bcdbbc0f723f602ac5414d80035eb8bb2b95b6683222bbd11f3c838ff8ae4906d628c0e0dfc22a8768d08205d3d3b4b052362d20f831b3c35215db450f4f38ac5b732286980fc9873c0e39cfa0d6b25f99af55af7cfc7ef2a6111d33de9bab158018f052571a4d16db6a89227d0aa6e58668705cee406f00f88001c82ae3735cc0413709ab7170451555926abaa45e2861af4d09cc88ff7a70426109a2762493f85b593ee023103e687db84148cf91d6bc9536850122d169bacd03790d19c33fb9d9b580771b62f239dcbfc58d2473369a118e9cbb48d262361eb6b0e25c93272b7aaf0fd1669ab9c774574a42a9913fa2af9a583c6656813a80f7b9ed3adeb6353420953b38734a32bcde46b243a77993e4e681facc2627f9a1e35cf29628c231a0b0e8cae0b57d85d7fc416831b8733d4268ac713605c5f1a71a50622163ccf3a8a3c2e36700843dda10bc88f5c842d436858cd0ba9b2cf482a0e0b748e5367de9968f0b499184e408e17b14f131e0ca6a51063f45ac02417d2987b8100bfebe8114dbd417af496d37713bccda7191fa7e13d592d2444c9d82b76163ae650f8d1279c2e8fbbbab4a7151a75805683e2d8ca0d8f09f9e758a5a4f3322178aaf70f59b2d43c2ea51f4b14be6f06721bff9ed360689f04a7a547a12e99b454ad38a9f734e33ea6b2f427d506d1a90a41f9a350f5eea1952a651ebd96f00f88101c82ae3735cc0413709ab7130461555926b11f90aeaa2a4b62064fff88aa897479496fee6ca4edcbda0ce6db9d2c782987342191c4af87f79333ba8e5f3816b574fb29a22f9e9428ac6d430d59541b4be5369ecddc5bc8d1073bcf23c3ad5fd3627acee3a3d72ad4386be10f596e535db704463efc743173c4d7a88a4b3b59896af8d45031105dede842aa112a33df0eb37a6d62ebc363e73f07aadcfa513513ece8fa08bed9123635eb208be19761ab669aa1a5135328f74d9d50648f73e1aea98ef3d21d55432490d2fa4455b818156d4ef8dda1c3ef61db242fd23bdece6aee56e7099195642e2659e43ce01fa85348bd122f5104c2ee5ee85dee1a8abbf1faa0f350ebee10764eb23ff58985cf68e8ecbeed427531b1d4f81c9877090ad1a1ee3c723f23b850c009a202c436baaddab1f91926cb9d3d145bd50b7983d0b8c34ee64310f4da5f9e55c77798aab4e144a9672cd74e57bb37d2369b4b6bbb5733d7a76bc8e2e7d8c286d0e19d33177892ff12922bfed6a30d7aed41c7d9f2a9bd96f00e87e01c82ae3735cc0413709ab7170b414559260aa74dec6544586da21a8ca0423cb056d936bce50731009dc566bdbc8fdad56f47440987a655ca90be6516abbe2952b8c1e49b6b75230fcd2c36858523c27a6432b0a046d30721cd980d909c3cfc5bdd0861e17e3c23b301d44ddc90eec9b28179d5e82c08563ef2b20dc05c2b4e88e0e35c776fb767c52ec9a0fef95e3bf1881ff5cfc6545ce21a3ef4e09d8f53b26544bf1b094a44d4d4fa8d61ec3e916cdf1d2049af7a265d465d3ee24f6cb2c995b332dcb53aaf9da5ae9bc9fc5aecb6e0b4f58bee84120894a77d5940489fb7cdf29d5c5705f94f784994d0b2798364845f82b5be849b25b7de3accbf9ff95e995054dc6891085a4895079e49b8d90e66e536a46330b5c2b665730ec8080f18bf0212fc077011ec1030da7bc35549d6ffb61ce1e534658ed108f570fba4458231cf4b07c44f0305d5deceed928feb37143547a86d5be3b74451b3d4a227f5ee6ec503de5ca375ecee885719fc51466c1f2b218a16ae24c63ffe4a07a9f636ffb7f0000982ab944fb7f0000a82ab944fb7f0000a82ab944fb7f00007832b944fb7f00007832b944fb7f0000c032b944fb7f0000c032b944fb7f0000d832b944fb7f0000d832b944fb7f0000, 'Admin', '2024-11-21 06:58:16', '2024-10-29 17:11:13', '2024-11-21 06:58:16'),
(16, '../uploads/admin-photos/rayshele_felix.jpg', 'Rayshele', 'Felix', 'rayshelefelix@gmail.com', '09319115776', '$2y$10$CywubOI4GXzR0fYjz6b8wOCDgZvSrtoLVUp9/reBHpOVN4415tR0q', 0x00f88001c82ae3735cc0413709ab71b054155592c6a21a77c6e58c90cfae616be0bb76c79a96d4da48252a174c217ae8dbb90846377e6057b236f08f6d20783efdd2d2e11a9becd05a3880eb20163322fd770608562a9eb8c3024072a720d9c99dc7b492d91122ab8bf756e92cd7826be03006a71c1ae4c640c6640557fceda827e773de1b3cbdbcab3ca4bb3b8370f7f3c2635ca005d3960b24b517e4fe66da6e7ec58c0e80acdf16374f78bb1ee3f77a5cf60752cac0accc97ddf54a206148d2e21981bf63bc74babf191e933ba93cd467d046a833eba902ad25fd2d29956f7bdb53161593e6f4913a717e24feb350d2cdf57045908ad5de9845e249a8c3251768e873251fa569fd53194e89b2f2094ef2925c18fad0f98bc3f83f7ce36e48b8bcada22c03ad830e33447df34920ec8d556f36da2669c199e51ccb90911f82db95dec49dedefe9cf3eff7884c59bee4abb4d0620f0bbc020f5c3cd8f8e994f27e1781183623f85ffa1a36e6b16c300c757aa639ba427e536bdd2fc464ff461432ba6586f00f88001c82ae3735cc0413709ab71f05e1555920e4ced1b02ad2765a8ca7d75f5efd35ceece1b91629b1eb32da438bfea19dbbf12985481cdb7ae177170eaec3dc6e56d90a9986bf572328e9ff8a2854f93670885c27deccfef0296d75b00d64f45f1fb646afe95fb1696dfaa1b6aa8694bf074c3a08c1e2914cb36f8b6f9e44cb0a258713342445fb7dc001fc1acb5bc405aff748a3b856c82e52584fb8eb2139dc2eb47940973ff9320c42c4ae6e2581bc3c5ddc314b6e6a4d091af9d22291627b14987f59d36d80e6b270ee0ef1a079c5d963823fb52be933a48bec69cfb6430fda90c004944ff03752f5345f68afb16d73adc8a5afe83375472e69a9258145719981b6ab37e01246528c1abd2a66f32342969af2137459d6309fc8ee202bcec4e0f2d7e336bff9c56ae62b472bbaf8b19cb37b9c9f56bbecf33b25b7c90945289e589fc61edf1914849c939f32fd324460e6918b80d414ec3d7492373ce9c4c69fe977b843b755350c90e4dcb6d3c4195fe22d5af6a3e670360df4a1b6cccbb9b176f00f87f01c82ae3735cc0413709ab71305b155592fdfd183c16f1ed211d8eae9074df20ccafa3e6a8fdd6d25aa05761df2d8aa59dc7fbd37c49a8a6d595dd27068f230cff25a2cc278febbdc0efdfa86e83ca98ef1aeff567aa5e439f495129877f5f7050019da5cd774cae1c8318daefe76101463be4197d10d440603b486588d54bbcd57b50253b0c562ddae2e12fd060f690730389b33bc00f911defb6fea298f9d7c7b69621cbef416ff6cd657a94a2b21eb881c6ebcc4266b3f58884f57e88f27fb06130f90118b5eaf211f8aba2a9d45107db8b747e87948e2bbc14bf1d93760c5dd12989b910e70e7b7cb7255f4e3950238fcf8218c0f9833efea7a429579efbfbf18b6608a794cf017a29e5a75299de77d7c0e36b9e6a7bdbe9721164fa069580dcab93557badccc43ef0c2ff51da36a3ea84199c1c4f9d146c192190cb3e74c07cb043c84f31264bf8678ce271a32a640e030e7dbb6a29ce701d22e75445edc49557fa4f3ccda0330a711fd8d583c7e08a1c307b9eef3afc9840585aaea1e66f00e88001c82ae3735cc0413709ab717056155592f784ed84562a0f3bcef327436a48ca26e762e200f10d401948ee7948d5b918ef2b028cafe2d702e4b986743409af09b55853b3e3a595162251632b9104b3ee210af95d5124d829e83f2fbcc5f897782595bbc8fad46142df5430bc865e5c16c47e8a45410de97796dff08f954f54c2ce9829e4da2ed47b611e6701a8b77bc04186154f5ae9cf2f8f34ded2f7a673e5672e41f81c7d50b84f27ee754caca6ecfd9d9e0246330419d1594bbcac988d22d98d050e73742b6f974a600250e40c23a748a153645775d7fd6f813816497a826486a4938b7ba39302749b1a8d10397b9249a5e25ab8c5ed308770dc7c57e90670d141e6fe77414956b1d6ffb57ed03a0ff71cf57211cc668957f90bf09af0c8cc852687937086bec294d47305838dd411f3efe2c25df2e87ab309fbf2b296029ab5670a5cccba96645f3189cd4e870e2dda7d93fa2136f831a605d13dedd875913d2a848008dea46f52dbd0588d9c057db0b4a321f47a3126f47f7ca263dfb6db6f44fb7f0000982ab944fb7f0000a82ab944fb7f0000a82ab944fb7f00007832b944fb7f00007832b944fb7f0000c032b944fb7f0000c032b944fb7f0000d832b944fb7f0000d832b944fb7f0000, 'Admin', '2024-11-07 12:20:04', '2024-11-07 12:10:37', '2024-11-07 12:20:04');

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `announcement_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `event_date` datetime NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`announcement_id`, `admin_id`, `category`, `title`, `description`, `location`, `event_date`, `image`, `created_at`) VALUES
(1, 16, 'Event', 'Fiesta', 'HAHAHAHA', 'Sa Bahay', '2024-11-19 15:46:11', NULL, '2024-11-18 07:47:57');

-- --------------------------------------------------------

--
-- Table structure for table `authorizations`
--

CREATE TABLE `authorizations` (
  `auth_id` int(11) NOT NULL,
  `authorized_by` int(11) NOT NULL,
  `authorized_to` int(11) NOT NULL,
  `auth_type` enum('Vote','Candidate') NOT NULL,
  `consent_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authorizations`
--

INSERT INTO `authorizations` (`auth_id`, `authorized_by`, `authorized_to`, `auth_type`, `consent_url`) VALUES
(45, 104, 105, 'Vote', '../uploads/consent_photos/REQUIREMENTS.jpg');

--
-- Triggers `authorizations`
--
DELIMITER $$
CREATE TRIGGER `after_authorization_insert` AFTER INSERT ON `authorizations` FOR EACH ROW BEGIN
    DECLARE votes_to_transfer INT DEFAULT 0;

    -- Check if the authorized_by user has votes to transfer
    IF EXISTS (SELECT 1 FROM vote_tokens WHERE user_id = NEW.authorized_by) THEN
        -- Get the available votes of the authorized_by user
        SELECT available_votes INTO votes_to_transfer
        FROM vote_tokens
        WHERE user_id = NEW.authorized_by;

        -- Check if the authorized_to user already has an entry in vote_tokens
        IF EXISTS (SELECT 1 FROM vote_tokens WHERE user_id = NEW.authorized_to) THEN
            -- Transfer votes to the authorized_to user
            UPDATE vote_tokens
            SET available_votes = available_votes + votes_to_transfer
            WHERE user_id = NEW.authorized_to;
        ELSE
            -- Insert a new entry for the authorized_to user if it doesn't exist
            INSERT INTO vote_tokens (user_id, vote_token, available_votes)
            VALUES (
                NEW.authorized_to,
                UUID(),
                votes_to_transfer
            );
        END IF;

        -- Set available_votes to 0 for the authorized_by user
        UPDATE vote_tokens
        SET available_votes = 0
        WHERE user_id = NEW.authorized_by;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `borrowed_items`
--

CREATE TABLE `borrowed_items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_photo` varchar(255) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_photo` varchar(255) NOT NULL,
  `borrowed_date` date NOT NULL,
  `return_date` date NOT NULL,
  `item_returned` enum('Yes','No') NOT NULL DEFAULT 'No',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowed_items`
--

INSERT INTO `borrowed_items` (`id`, `user_id`, `user_photo`, `item_name`, `item_photo`, `borrowed_date`, `return_date`, `item_returned`, `created_at`, `updated_at`) VALUES
(1, 102, '', 'KUPAL KA BA BOSS?', '../uploads/borrowed_items/1731773049_WIN_20241108_14_46_03_Pro.jpg', '2024-11-16', '2024-11-20', 'Yes', '2024-11-16 15:38:57', '2024-11-16 17:00:13'),
(2, 102, '', 'UPUAN', '../uploads/borrowed_items/1731777711_50daa341-f4ac-4c3c-81e5-99be16808eba.jpg', '2024-11-18', '2024-11-20', 'Yes', '2024-11-16 15:41:20', '2024-11-16 17:21:51'),
(3, 107, '', 'HAHAAH', '../uploads/borrowed_items/1731771788_WIN_20241108_14_34_07_Pro.jpg', '2024-11-21', '2024-11-21', 'No', '2024-11-16 15:43:08', '2024-11-16 15:43:08'),
(4, 109, '', 'SAGING', '../uploads/borrowed_items/1731771878_WIN_20241016_15_55_44_Pro.jpg', '2024-11-28', '2024-11-29', 'No', '2024-11-16 15:44:38', '2024-11-16 15:44:38'),
(9, 110, '', 'TENT', '../uploads/borrowed_items/1731832463_bd521fa1-1dff-49dc-971f-9c90385ca03a.jpg', '2024-11-19', '2024-11-20', 'Yes', '2024-11-17 08:34:23', '2024-11-17 08:34:41');

-- --------------------------------------------------------

--
-- Table structure for table `candidates`
--

CREATE TABLE `candidates` (
  `candidate_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `platform_photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `candidates`
--

INSERT INTO `candidates` (`candidate_id`, `user_id`, `position_id`, `platform_photo`, `created_at`) VALUES
(169, 102, 1, 'platform2.jpg', '2024-11-13 07:20:28'),
(170, 107, 2, 'platform2.jpg', '2024-11-13 07:21:07'),
(171, 104, 3, 'platform2.jpg', '2024-11-13 07:21:42'),
(172, 105, 4, 'platform2.jpg', '2024-11-13 07:21:55'),
(173, 106, 5, 'platform2.jpg', '2024-11-13 07:22:13'),
(174, 108, 6, 'platform2.jpg', '2024-11-13 07:22:27'),
(175, 109, 7, 'platform2.jpg', '2024-11-13 07:22:45'),
(176, 110, 8, 'platform2.jpg', '2024-11-13 07:22:58'),
(177, 115, 9, 'platform2.jpg', '2024-11-13 07:23:21'),
(178, 111, 10, 'platform2.jpg', '2024-11-13 07:23:37'),
(179, 114, 11, 'platform2.jpg', '2024-11-13 07:23:56'),
(180, 113, 12, 'platform2.jpg', '2024-11-13 07:24:09'),
(181, 112, 13, 'platform2.jpg', '2024-11-13 07:24:30'),
(182, 120, 1, 'platform2.jpg', '2024-11-13 07:36:51'),
(183, 117, 2, 'platform2.jpg', '2024-11-13 07:37:37'),
(184, 119, 4, 'platform2.jpg', '2024-11-13 07:37:55'),
(185, 118, 4, 'platform2.jpg', '2024-11-13 07:38:51');

-- --------------------------------------------------------

--
-- Table structure for table `elections`
--

CREATE TABLE `elections` (
  `election_id` int(11) NOT NULL,
  `election_name` varchar(255) NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `registration_start_date` datetime NOT NULL,
  `registration_end_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `issue_reports`
--

CREATE TABLE `issue_reports` (
  `id` int(11) NOT NULL,
  `reported_by` int(11) NOT NULL,
  `issue_title` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `status` enum('Open','In Progress','Resolved') DEFAULT 'Open',
  `reported_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `issue_reports`
--

INSERT INTO `issue_reports` (`id`, `reported_by`, `issue_title`, `category`, `description`, `status`, `reported_at`) VALUES
(1, 102, 'sadasdasd', '', 'sadadasd', 'Resolved', '2024-11-17 18:43:26'),
(2, 102, 'HAHAHAHA', 'Security', 'INGAY MO', 'Open', '2024-11-17 18:51:16'),
(3, 102, 'adadasd', 'Security', 'sadasdasd', 'Open', '2024-11-17 18:52:07'),
(4, 102, 'TAE NG ASO', 'Noise Complaint', 'ASDDADASD', 'Open', '2024-11-17 18:53:53'),
(5, 102, 'aaaaaaaaaaaaaa', 'Other', 'aaaaaaaa', 'Open', '2024-11-17 18:54:21'),
(6, 102, 'ETO NA', 'Noise Complaint', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.', 'Open', '2024-11-17 18:56:47'),
(7, 102, 'kkkkk', 'Maintenance', 'ppppp', 'Open', '2024-11-17 19:01:22'),
(8, 102, '1515151', 'Security', 'SDADASD', 'Open', '2024-11-17 19:03:49'),
(9, 102, 'INGAY', 'Noise Complaint', 'INGAY NG KATABI KO', 'Open', '2024-11-18 05:53:38'),
(10, 102, 'Ang Ingay ng Aso', 'Noise Complaint', 'HAHAHAHA', 'Open', '2024-11-18 07:49:39'),
(11, 102, 'Iihshhs', 'Security', 'bzbbz', 'In Progress', '2024-11-19 16:26:14');

-- --------------------------------------------------------

--
-- Table structure for table `lots`
--

CREATE TABLE `lots` (
  `lot_id` int(11) NOT NULL,
  `lot_number` varchar(50) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lots`
--

INSERT INTO `lots` (`lot_id`, `lot_number`, `owner_id`, `created_at`) VALUES
(135, 'Lot 9', 105, '2024-11-13 08:41:45');

--
-- Triggers `lots`
--
DELIMITER $$
CREATE TRIGGER `after_lot_insert` AFTER INSERT ON `lots` FOR EACH ROW BEGIN
    DECLARE lot_count INT;

    -- Count the total number of lots owned by the user
    SELECT COUNT(*) INTO lot_count
    FROM lots
    WHERE owner_id = NEW.owner_id;

    -- Update available_votes in vote_tokens based on the number of lots
    UPDATE vote_tokens
    SET available_votes = CASE 
                             WHEN lot_count >= 3 THEN lot_count
                             ELSE 1
                          END
    WHERE user_id = NEW.owner_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_available_votes_after_delete` AFTER DELETE ON `lots` FOR EACH ROW BEGIN
    DECLARE lot_count INT;

    -- Count the remaining lots for the deleted lot's owner
    SELECT COUNT(*) INTO lot_count
    FROM lots
    WHERE owner_id = OLD.owner_id;

    -- Update available votes in vote_tokens based on the number of lots owned
    UPDATE vote_tokens
    SET available_votes = CASE
        WHEN lot_count < 3 THEN 1    -- Set to 1 if the remaining lots are less than 3
        ELSE lot_count                -- Otherwise, set to the remaining lot count
    END
    WHERE user_id = OLD.owner_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `otp_records`
--

CREATE TABLE `otp_records` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `otp_code` varchar(6) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  `is_used` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `otp_records`
--

INSERT INTO `otp_records` (`id`, `email`, `otp_code`, `created_at`, `expires_at`, `is_used`) VALUES
(1, 'estoresronie89@gmail.com', '791753', '2024-11-18 07:43:16', '2024-11-18 15:53:16', 1);

-- --------------------------------------------------------

--
-- Table structure for table `positions`
--

CREATE TABLE `positions` (
  `position_id` int(11) NOT NULL,
  `position_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `positions`
--

INSERT INTO `positions` (`position_id`, `position_name`) VALUES
(1, 'President'),
(2, 'Vice President'),
(3, 'Secretary'),
(4, 'Treasurer'),
(5, 'Auditor'),
(6, 'Chairman of the Board'),
(7, 'Grievance Committee'),
(8, 'Sports Committee'),
(9, 'Peace and Order and Security Committee'),
(10, 'Sanitation and Maintenance Committee'),
(11, 'Social Welfare Disaster and Livelihood Committee'),
(12, 'Education and Membership Committee'),
(13, 'Financial Management Committee');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservation_id` int(11) NOT NULL,
  `facility_name` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reservation_date` date NOT NULL,
  `time_slot` varchar(50) NOT NULL,
  `hours_reserved` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservation_id`, `facility_name`, `user_id`, `reservation_date`, `time_slot`, `hours_reserved`, `created_at`) VALUES
(11, 'Basketball Court', 104, '2024-11-21', '23:05 - 12:05', 1, '2024-11-16 12:05:43');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Homeowner','Renter','Caretaker') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `photo`, `first_name`, `last_name`, `gender`, `email`, `phone_number`, `address`, `password`, `role`, `created_at`) VALUES
(102, '../uploads/voters-photo/ronie_estores.jpg', 'Ronie', 'Estores', 'Male', 'estoresronie89@gmail.com', '09319115776', 'sadasdasdsad', '$2y$10$qkFFHpBpdIO3IN/HJ/dpU.kMnuA6rM4OtTR.7S4W.ySkyBIEQWTPu', 'Homeowner', '2024-11-13 06:55:37'),
(104, '../uploads/voters-photo/673619dab73f2.jpg', 'Jeralee', 'Macaraig', 'Female', 'Jeralee@gmail.com', '09319115776', 'asdasdsad', '$2y$10$SzZOMNIZXoaZtxHA3IPMO.yHRuxYRPI2uKLFCSftWdAL.dn4gPTZ2', 'Homeowner', '2024-11-13 06:57:31'),
(105, '../uploads/voters-photo/terrie_harina.jpg', 'Terrie', 'Harina', 'Female', 'teriemik@gmail.com', '09319115776', 'asdasdasd', '$2y$10$oPVsywZe5.e8KqNTget23ePDyw/hOK4m0S1nZ2gPo7RSWgLBKIUt.', 'Homeowner', '2024-11-13 06:58:20'),
(106, '../uploads/voters-photo/czaryst_ansaldo.jpg', 'Czaryst', 'Ansaldo', 'Female', 'Czaryst@gmail.com', '09319115776', 'sadsadsad', '$2y$10$qqqMGaMEMRz0xDVYmO0kq.9jPmYSnFaQXCAhDuEinGl4BHNZ6jaxG', 'Renter', '2024-11-13 06:59:04'),
(107, '../uploads/voters-photo/67344ea9099d6.jpg', 'Rayshele', 'Felix', 'Female', 'felix.rayshele.oct.11.1999@gmail.com', '09319115776', 'sdsadasd', '$2y$10$Qs9jIwMBf3jgR0f72WXoheWTwUyvfLvzMqZMPF3b8XwWc4.e6djpq', 'Homeowner', '2024-11-13 07:00:20'),
(108, '../uploads/voters-photo/donna_galicia.jpg', 'Donna', 'Galicia', 'Female', 'Donna@gmail.com', '09319115776', 'asdasdasd', '$2y$10$xIC6.TyUG9571ThkdhB2SuoS4DDUE0p1gvjkLocW0zmVNs.U/enf6', 'Homeowner', '2024-11-13 07:01:38'),
(109, '../uploads/voters-photo/alvin_cusit.jpg', 'Alvin', 'Cusit', 'Male', 'alvincarpio@gmail.com', '09319115776', 'asdasd', '$2y$10$S7mv0370YwiQiAZOZ18BMuaNIySSkOTttgwp0a2jgb3YUz6Iwqx56', 'Caretaker', '2024-11-13 07:02:56'),
(110, '../uploads/voters-photo/jordan_jimenez.jpg', 'Jordan', 'Jimenez', 'Male', 'Jordan@gmail.com', '09319115776', 'asdasd', '$2y$10$FxsdSH9jgackxLv47N3J4u6PLel/nLljS24W2L5jk1JRbJFHDU.om', 'Caretaker', '2024-11-13 07:03:46'),
(111, '../uploads/voters-photo/james_reid.jpg', 'James', 'Reid', 'Male', 'James@gmail.com', '09319115776', 'asdasds', '$2y$10$kA0VRUhSPlhxbeBuzVWt6OY/qTYQcUR2A6eQ7hwlb.y4cw49iulcq', 'Renter', '2024-11-13 07:05:15'),
(112, '../uploads/voters-photo/daniel_padilla.jpg', 'Daniel', 'Padilla', 'Male', 'Daniel@gmail.com', '09319115776', 'asdasd', '$2y$10$1MhZRyTAHEv6n7SOmaBhYuwVP5ErDQvADpYvs/Fy2t/F0SjF8Cmiq', 'Homeowner', '2024-11-13 07:06:08'),
(113, '../uploads/voters-photo/alden_fullcharge.jpg', 'Alden', 'Fullcharge', 'Male', 'Alden@gmail.com', '09319115776', 'asdasd', '$2y$10$Saa5/WN1NQJxzpanffY/FONOIi61sdp12/90B.F4qSrGHLQoAee86', 'Homeowner', '2024-11-13 07:07:05'),
(114, '../uploads/voters-photo/ken_chan.jpg', 'Ken', 'Chan', 'Male', 'Ken@gmail.com', '09319115776', 'asdasdasd', '$2y$10$AKEoDOS5IP9Oz7PJLlLmh.VOJvJD7Lhdy2aHJIiIFWLsBgxph1x.C', 'Homeowner', '2024-11-13 07:07:44'),
(115, '../uploads/voters-photo/jemar_colas.jpg', 'Jemar', 'Colas', 'Male', 'Jemar@gmail.com', '09319115776', 'asdasd', '$2y$10$xoz.qSivHw8PmiflCWhn0.nYrZIe/jpG86EizIgfZi3JDRmovIPzG', 'Homeowner', '2024-11-13 07:08:17'),
(116, '../uploads/voters-photo/juan_tamad.jpg', 'Juan', 'Tamad', 'Other', 'Juan@gmail.com', '09319115776', 'asdasdasd', '$2y$10$P20NM5y8il3ftrknGVuYsuGKFWzcB.3sxrX/cBh8v1rFGs5M03SGu', 'Renter', '2024-11-13 07:25:43'),
(117, '../uploads/voters-photo/eman_dominggo.jpg', 'Eman', 'Dominggo', 'Male', 'Eman@gmail.com', '09319115776', 'asdasdasd', '$2y$10$/5xIJ7uvIJoAtad/TgtumuNNfgdP4CfVnCnO2hKrXW5w6ydEGRKIi', 'Renter', '2024-11-13 07:26:57'),
(118, '../uploads/voters-photo/ryza_mae_dizon.jpg', 'Ryza Mae', 'Dizon', 'Female', 'Dizon@gmail.com', '09319115776', 'asdsadsad', '$2y$10$rOMUKawYbQeEjYWHunh8Du85mxG6kcG17rpfMQNg9hRoKiFWF6l..', 'Homeowner', '2024-11-13 07:32:39'),
(119, '../uploads/voters-photo/alfred_vargas.jpg', 'Alfred', 'Vargas', 'Male', 'Alfred@gmail.com', '09319115776', 'sadsad', '$2y$10$6elPE6m6Jf3/r.4G.Jl1Ye5heqHidKgFkPq8ZkpUK8O3mmds8e5ly', 'Homeowner', '2024-11-13 07:33:32'),
(120, '../uploads/voters-photo/bianca_binene.jpg', 'Bianca', 'Binene', 'Female', 'Bianca@gmail.com', '09319115776', 'asdasdasd', '$2y$10$zL9JFSK0q2WYkC5bgJnU2OOYHiR746RYYrtpxEW8d37ChGzOu1Jyq', 'Renter', '2024-11-13 07:34:06');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `after_user_delete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    -- Delete the user's entry from the vote_tokens table
    DELETE FROM vote_tokens
    WHERE user_id = OLD.user_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_user_insert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    -- Insert a default entry in vote_tokens with 1 available vote for each new user
    INSERT INTO vote_tokens (user_id, vote_token, available_votes)
    VALUES (
        NEW.user_id,  -- Assuming user_id is the primary key in users
        UUID(),       -- Generates a unique token for each user
        1             -- Default 1 vote for new users
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_lots_after_user_delete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    DELETE FROM lots
    WHERE owner_id = OLD.user_id; -- Change this to the correct primary key column
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `vote_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vote_tokens`
--

CREATE TABLE `vote_tokens` (
  `token_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vote_token` varchar(255) NOT NULL,
  `available_votes` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vote_tokens`
--

INSERT INTO `vote_tokens` (`token_id`, `user_id`, `vote_token`, `available_votes`, `created_at`) VALUES
(71, 102, '4b085d02-a18c-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 06:55:37'),
(73, 104, '8e717f2d-a18c-11ef-9397-e4a8dff61e7d', 0, '2024-11-13 06:57:31'),
(74, 105, 'abb5fdb5-a18c-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 06:58:20'),
(75, 106, 'c65543c3-a18c-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 06:59:04'),
(76, 107, 'f391d92e-a18c-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:00:20'),
(77, 108, '21a6aabf-a18d-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:01:38'),
(78, 109, '502369c7-a18d-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:02:56'),
(79, 110, '6de9f476-a18d-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:03:46'),
(80, 111, 'a31d9543-a18d-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:05:15'),
(81, 112, 'c2bc3b86-a18d-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:06:08'),
(82, 113, 'e4e9906c-a18d-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:07:05'),
(83, 114, 'fc205a8d-a18d-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:07:44'),
(84, 115, '0f8355eb-a18e-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:08:17'),
(85, 116, '7f4dad9e-a190-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:25:43'),
(86, 117, 'ab125f64-a190-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:26:57'),
(87, 118, '7714a670-a191-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:32:39'),
(88, 119, '965da23e-a191-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:33:32'),
(89, 120, 'aabed0f1-a191-11ef-9397-e4a8dff61e7d', 1, '2024-11-13 07:34:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`announcement_id`),
  ADD KEY `fk_announcements_admin_id` (`admin_id`);

--
-- Indexes for table `authorizations`
--
ALTER TABLE `authorizations`
  ADD PRIMARY KEY (`auth_id`),
  ADD KEY `authorized_by` (`authorized_by`),
  ADD KEY `authorized_to` (`authorized_to`);

--
-- Indexes for table `borrowed_items`
--
ALTER TABLE `borrowed_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`candidate_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `elections`
--
ALTER TABLE `elections`
  ADD PRIMARY KEY (`election_id`),
  ADD KEY `fk_elections_created_by` (`created_by`);

--
-- Indexes for table `issue_reports`
--
ALTER TABLE `issue_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reported_by_user` (`reported_by`);

--
-- Indexes for table `lots`
--
ALTER TABLE `lots`
  ADD PRIMARY KEY (`lot_id`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Indexes for table `otp_records`
--
ALTER TABLE `otp_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_otp_records_email` (`email`);

--
-- Indexes for table `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`position_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`vote_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `candidate_id` (`candidate_id`),
  ADD KEY `position_id` (`position_id`);

--
-- Indexes for table `vote_tokens`
--
ALTER TABLE `vote_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `vote_tokens_ibfk_1` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `authorizations`
--
ALTER TABLE `authorizations`
  MODIFY `auth_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `borrowed_items`
--
ALTER TABLE `borrowed_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `candidates`
--
ALTER TABLE `candidates`
  MODIFY `candidate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `elections`
--
ALTER TABLE `elections`
  MODIFY `election_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `issue_reports`
--
ALTER TABLE `issue_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `lots`
--
ALTER TABLE `lots`
  MODIFY `lot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `otp_records`
--
ALTER TABLE `otp_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `vote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=945;

--
-- AUTO_INCREMENT for table `vote_tokens`
--
ALTER TABLE `vote_tokens`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `fk_announcements_admin_id` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`) ON DELETE CASCADE;

--
-- Constraints for table `authorizations`
--
ALTER TABLE `authorizations`
  ADD CONSTRAINT `authorizations_ibfk_1` FOREIGN KEY (`authorized_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `authorizations_ibfk_2` FOREIGN KEY (`authorized_to`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `borrowed_items`
--
ALTER TABLE `borrowed_items`
  ADD CONSTRAINT `borrowed_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `candidates`
--
ALTER TABLE `candidates`
  ADD CONSTRAINT `candidates_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `elections`
--
ALTER TABLE `elections`
  ADD CONSTRAINT `fk_elections_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`admin_id`) ON DELETE CASCADE;

--
-- Constraints for table `issue_reports`
--
ALTER TABLE `issue_reports`
  ADD CONSTRAINT `fk_reported_by_user` FOREIGN KEY (`reported_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `lots`
--
ALTER TABLE `lots`
  ADD CONSTRAINT `lots_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `otp_records`
--
ALTER TABLE `otp_records`
  ADD CONSTRAINT `fk_otp_records_email` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`),
  ADD CONSTRAINT `votes_ibfk_3` FOREIGN KEY (`position_id`) REFERENCES `positions` (`position_id`);

--
-- Constraints for table `vote_tokens`
--
ALTER TABLE `vote_tokens`
  ADD CONSTRAINT `vote_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
