-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 27, 2024 at 02:23 AM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u703454372_school`
--

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` int(11) NOT NULL,
  `className` varchar(255) NOT NULL,
  `createdAt` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `className`, `createdAt`) VALUES
(1, 'الصف الاول', '2024-12-14 02:37:00'),
(3, 'الصف الثالث', '2024-12-14 02:48:07'),
(4, 'الصف الرابع', '2024-12-14 02:48:12'),
(6, 'الصف الثاني', '2024-12-14 03:19:30'),
(9, 'الصف الثاني١', '2024-12-14 03:24:13');

-- --------------------------------------------------------

--
-- Table structure for table `parent_student`
--

CREATE TABLE `parent_student` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parent_student`
--

INSERT INTO `parent_student` (`id`, `parent_id`, `student_id`, `created_at`) VALUES
(3, 41, 31, '2024-12-16 01:34:35'),
(4, 44, 36, '2024-12-18 01:20:27'),
(5, 45, 31, '2024-12-18 01:23:13'),
(6, 43, 35, '2024-12-18 03:53:58');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `assessment` enum('ممتاز','جيد','متوسط','ضعيف') NOT NULL,
  `note` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `audio_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_class`
--

CREATE TABLE `student_class` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_class`
--

INSERT INTO `student_class` (`id`, `student_id`, `class_id`, `created_at`) VALUES
(7, 35, 3, '2024-12-16 05:50:59'),
(8, 36, 4, '2024-12-16 05:51:04'),
(9, 33, 6, '2024-12-17 22:39:26'),
(11, 31, 1, '2024-12-18 00:01:44'),
(12, 36, 6, '2024-12-18 02:17:43'),
(13, 31, 4, '2024-12-18 03:47:21'),
(14, 33, 3, '2024-12-18 23:59:08'),
(15, 36, 1, '2024-12-18 23:59:39'),
(16, 38, 1, '2024-12-26 13:48:05');

-- --------------------------------------------------------

--
-- Table structure for table `student_daily_reports`
--

CREATE TABLE `student_daily_reports` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `date` date NOT NULL DEFAULT curdate(),
  `assessment` enum('ممتاز','جيد','متوسط','ضعيف') NOT NULL,
  `note` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `audio_note_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_daily_reports`
--

INSERT INTO `student_daily_reports` (`id`, `student_id`, `teacher_id`, `class_id`, `date`, `assessment`, `note`, `file_path`, `audio_note_path`, `created_at`) VALUES
(1, 31, 15, 1, '2024-12-22', 'ممتاز', 'غاا', NULL, NULL, '2024-12-22 05:15:34'),
(2, 36, 15, 1, '2024-12-22', 'متوسط', 'ااات', NULL, NULL, '2024-12-22 05:16:31'),
(3, 31, 15, 1, '2024-12-22', 'ضعيف', 'تتنن', NULL, NULL, '2024-12-22 05:17:23'),
(4, 33, 15, 3, '2024-12-22', 'ضعيف', 'وتت', NULL, NULL, '2024-12-22 05:17:39'),
(5, 31, 15, 1, '2024-12-22', 'ممتاز', 'صورة', NULL, NULL, '2024-12-22 05:18:14'),
(6, 33, 15, 3, '2024-12-22', 'ممتاز', 'غ', NULL, NULL, '2024-12-22 05:22:19'),
(7, 33, 15, 3, '2024-12-22', 'جيد', 'ااا', NULL, NULL, '2024-12-22 05:22:41'),
(8, 33, 15, 3, '2024-12-22', 'متوسط', 'ههه', NULL, NULL, '2024-12-22 05:22:52'),
(9, 33, 15, 3, '2024-12-22', 'متوسط', 'نتن', NULL, NULL, '2024-12-22 05:23:51'),
(10, 36, 15, 1, '2024-12-22', 'ضعيف', '٧هه', NULL, NULL, '2024-12-22 05:24:43'),
(11, 31, 15, 1, '2024-12-22', 'ممتاز', 'غغغ', NULL, NULL, '2024-12-22 05:25:28'),
(12, 35, 15, 3, '2024-12-26', 'ممتاز', 'كسلان', NULL, NULL, '2024-12-26 13:50:56');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_class`
--

CREATE TABLE `teacher_class` (
  `id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_class`
--

INSERT INTO `teacher_class` (`id`, `teacher_id`, `class_id`, `created_at`) VALUES
(3, 16, 3, '2024-12-16 05:54:33'),
(4, 17, 1, '2024-12-17 23:19:52'),
(6, 19, 4, '2024-12-17 23:26:00'),
(8, 19, 9, '2024-12-18 03:42:33'),
(9, 15, 3, '2024-12-18 23:57:38'),
(10, 15, 1, '2024-12-18 23:58:22'),
(11, 25, 4, '2024-12-21 18:59:06'),
(12, 20, 3, '2024-12-26 13:47:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` int(14) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` enum('teacher','student','admin','father') NOT NULL,
  `status` enum('pending','accepted','blocked') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone_number`, `address`, `role`, `status`) VALUES
(1, 'عادل السميطي', 'a@gmail.com', '$2y$10$xOR86ScyiVAo0fVPcgkLA.KcKQfN3EIiAXnXqnlfNtxe24vkxDk5e', 0, '', 'admin', 'accepted'),
(3, 'عادا', 'aa@gmail.com', '$2y$10$dlrqFnSWdKVHyFG1m1OqdOY/vcAd1SKeU80PXM4zfpuumDM7S8lCK', 12345, '', 'student', 'accepted'),
(4, 'ase', 'aaa@gmail.com', '$2y$10$xxQRa6m5.WgGdoZjR/jLe.qJTd59hK25oj7qNg/qlMeAyYkQAm01S', 77777667, 'agh', 'student', 'accepted'),
(11, 'عادل', 'aaaa@gmail.com', '$2y$10$4G0PsZHZw5WypcUiabMp3efvtAH4xEwcld9ESCFqzg0cmI3pSZfCO', 731234567, 'aden', 'father', 'blocked'),
(12, 'مدير', 'aaaaa@gmail.com', '$2y$10$oU4r0pM.u5HWnAa3yNGBhuEv2.Ys2sJtEcIQCSeywYAVTjb2fadX2', 77712345, 'عدن', 'admin', 'pending'),
(13, 'yyy', 'aaa111@gmail.com', '$2y$10$P5qGexeupwlt.ys5pjkUXuABcU5.iJ0HGcEa64Nul4YDmaGZmgIqu', 77771234, 'aden', 'student', 'accepted'),
(14, '0', 'adel@gmail.com', '$2y$10$08kR26R87C4DmF271NKKQOX/mfApM7Wayyzju5gUXhA7ZDcxHWNy2', 777777777, 'عدن', 'teacher', 'accepted'),
(15, 'المعلم احمد', 't@gmail.com', '$2y$10$mgxq40pQnoC.17crj8TW.ORhbl6KOE69FIpRvQ3vQ8Px.uVXmpNaq', 77112233, 'عدن', 'teacher', 'accepted'),
(16, 'المعلم محمد', 't1@gmail.com', '$2y$10$18RXklzbydcc8loc0sxaRuY7dSFLqayjxD8bVwN3AX7xXJvUze5zu', 77221122, 'عدن', 'teacher', 'pending'),
(17, 'المعلم علي', 't2@gmail.com', '$2y$10$KNzSsJWMVDn/UekUVPnJ1erV5JNrF3EpuoIrPgfeV9t1mtHZhMvZG', 77112211, 'عدن', 'teacher', 'pending'),
(18, 'المعلم سالم', 't3@gmail.com', '$2y$10$Dw/HuWwEeljx.f0o3TJV/O5NfaZZGzRcUSWSlPQ02VZCYfsWY9z6.', 77331122, 'عدن', 'teacher', 'pending'),
(19, 'المعلم قاسم', 't4@gmail.com', '$2y$10$xshYI56DeZKM7dREtcYRDOkkzN4Bnir9fZXuoxW.bEAYHtPqii8xG', 77441122, 'عدن', 'teacher', 'pending'),
(20, 'المعلم سلمان', 't5@gmail.com', '$2y$10$796uP9Q10QG9ECkC1Qx3Ne1alc/H0wMNkZAbo/F6F7hswB/mdpqDu', 77441111, 'عدن', 'teacher', 'pending'),
(23, 'المعلم سليمان', 't6@gmail.com', '$2y$10$wyNQDs5fgIoPOI3pGL2Ku.WRcZl.p0bnw6o.Wtli.C03lXDkJ0YeK', 77441121, 'عدن', 'teacher', 'pending'),
(25, 'المعلم سام', 't7@gmail.com', '$2y$10$AvBN4LpIZLb.MizKviNCx.3SGMiE8jE8SZE8.x13JO5b5nI2PcB2y', 77441131, 'عدن', 'teacher', 'pending'),
(28, 'المعلم عبدالرحمن', 't8@gmail.com', '$2y$10$W9maVZpl9dKUvu/siRQ/veQjUmBcN4YrM5c1TJLGsrJJMhlEEhYlS', 2147483647, 'عدن', 'teacher', 'pending'),
(30, 'المعلم سعيد', 't9@gmail.com', '$2y$10$neWebqSOef4Q19gc3U468udYbeeD293iYMXNlg11mjwY5dLI1XZyS', 77224433, 'عدن', 'teacher', 'pending'),
(31, 'الطالب الاول', 's1@gmail.com', '$2y$10$KqD2D3N8iYnA7TPaHI7IFO0L3kveuBq3UF6o2S20cxe/M/kDb6Wx6', 73112233, 'عدن', 'student', 'pending'),
(33, 'الطالب الثاني', 's2@gmail.com', '$2y$10$UPe9rZG9lWPWA/yjZfGeleUU8eV.2Xr.WrW3jp3nHutUO1yuba6iq', 73112244, 'عدن', 'student', 'pending'),
(35, 'الطالب الثالث', 's3@gmail.com', '$2y$10$jVcPq2kWsiWc7N0LrEuNxedV61Q2tGbrPfK/2vuMhcXTuNgmOZKK6', 73112255, 'عدن', 'student', 'pending'),
(36, 'الطالب الرابع', 's4@gmail.com', '$2y$10$1jdX6Ih3vC01FmCW4BaNqe/QdQ.jhh/A.fcGrkdAEt5QT3ngMlgF.', 73221133, 'عدن', 'student', 'pending'),
(38, 'الطالب الخامس', 's5@gmail.com', '$2y$10$piSpWukZSJ.rmZ.Zut51GOrE8cNpDWbawyh0OglYHhgpCP8WBpFbC', 73221144, 'عدن', 'student', 'pending'),
(39, 'الطالب السادس', 's6@gmail.com', '$2y$10$D9aJ1nOxbChBwmSDTlYQvenbgKe58058vwFzuK3BS/o5CoFmm3/Tq', 73221144, 'عدن', 'student', 'pending'),
(40, 'الطالب السابع', 's7@gmail.com', '$2y$10$YB.tc3eX.JbwVy7Xnp8FhOBNg55zYy.HKFZzdXiAQYdHProSSFsOq', 73001122, 'عدن', 'student', 'pending'),
(41, 'الاب الاول', 'f1@gmail.com', '$2y$10$onajITcSCjWHxF0vmOLfq.t3Fdqv5ZAPrPguvfXCzSVUAa5ZOTFfm', 77223141, 'عدن', 'father', 'pending'),
(42, 'الاب الثاني', 'f2@gmail.com', '$2y$10$A/lP2dk3efXntbw/tygLbe2ZCmnLNP6Bt9R.unfY2MlTfODj/1VX.', 71223344, 'عدن', 'father', 'pending'),
(43, 'الاب الثالث', 'f3@gmail.com', '$2y$10$VTokBwtR3Tw.IWLe9QyAK.qmgwx6OWuCcIIbtg6u2tHTz2IIJQOFi', 71223341, 'عدن', 'father', 'pending'),
(44, 'الاب الرابع', 'f4@gmail.com', '$2y$10$QPxl9MqKPapUMoey7OeavuyXTUDKmKw0CUyXQeF5A8UbWAS0lbClu', 71223342, 'عدن', 'father', 'pending'),
(45, 'الاب الخامس', 'f5@gmail.com', '$2y$10$yXHsunJmKSspsaKELL4e5eH.bXXFEKAA7j34.uvogatzMfvDlYDAK', 71223343, 'عدن', 'father', 'pending'),
(46, 'الاب السادس', 'f6@gmail.com', '$2y$10$Br2PBvuvpKmtxM5Hld59/uh2nMtw9UlWosSu0vTDr5JMSDnjLpCpK', 71223344, 'عدن', 'father', 'pending'),
(48, 'الاب السابع', 'f7@gmail.com', '$2y$10$OjbJJtHnD6ZGbtDG7tRovOo03ZthLijMPG0wQjts50ohWP/yuSIhC', 71223344, 'عدن', 'father', 'pending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `className` (`className`);

--
-- Indexes for table `parent_student`
--
ALTER TABLE `parent_student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `student_class`
--
ALTER TABLE `student_class`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `student_daily_reports`
--
ALTER TABLE `student_daily_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `teacher_class`
--
ALTER TABLE `teacher_class`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `name_2` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `parent_student`
--
ALTER TABLE `parent_student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_class`
--
ALTER TABLE `student_class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `student_daily_reports`
--
ALTER TABLE `student_daily_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `teacher_class`
--
ALTER TABLE `teacher_class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `parent_student`
--
ALTER TABLE `parent_student`
  ADD CONSTRAINT `parent_student_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `parent_student_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `student_class`
--
ALTER TABLE `student_class`
  ADD CONSTRAINT `student_class_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `student_class_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- Constraints for table `student_daily_reports`
--
ALTER TABLE `student_daily_reports`
  ADD CONSTRAINT `student_daily_reports_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `student_daily_reports_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `student_daily_reports_ibfk_3` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- Constraints for table `teacher_class`
--
ALTER TABLE `teacher_class`
  ADD CONSTRAINT `teacher_class_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `teacher_class_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
