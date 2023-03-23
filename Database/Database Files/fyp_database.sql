-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2023 at 12:03 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fyp_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `S_ID` int(11) NOT NULL,
  `is_present` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `C_ID` int(5) NOT NULL,
  `Name` char(30) NOT NULL,
  `Desc` text NOT NULL,
  `Credits` int(2) NOT NULL,
  `Hours` decimal(3,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_info`
--

CREATE TABLE `course_info` (
  `C_ID` varchar(5) NOT NULL,
  `D_ID` int(3) NOT NULL,
  `Semester` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `D_ID` int(3) NOT NULL,
  `Name` char(30) NOT NULL,
  `Desc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`D_ID`, `Name`, `Desc`) VALUES
(1, 'CS', 'Computer Science'),
(2, 'SE', 'Software Engineering'),
(3, 'AI', 'Artificial intelligence'),
(4, 'CYS', 'Cyber Security');

-- --------------------------------------------------------

--
-- Table structure for table `department_incharge`
--

CREATE TABLE `department_incharge` (
  `D_ID` int(3) NOT NULL,
  `F_ID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department_incharge`
--

INSERT INTO `department_incharge` (`D_ID`, `F_ID`) VALUES
(1, 1),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE `email` (
  `id` int(11) NOT NULL,
  `sender` varchar(7) NOT NULL,
  `recipient` int(5) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `date_sent` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `encodings`
--

CREATE TABLE `encodings` (
  `id` int(11) NOT NULL,
  `roll_number` varchar(7) NOT NULL,
  `encoding` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `F_ID` int(5) NOT NULL,
  `Name` char(30) NOT NULL,
  `Address` text NOT NULL,
  `CNIC` char(15) NOT NULL,
  `phone_No` int(11) NOT NULL,
  `Gender` enum('M','F','O') NOT NULL,
  `DOB` date NOT NULL,
  `email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`F_ID`, `Name`, `Address`, `CNIC`, `phone_No`, `Gender`, `DOB`, `email`) VALUES
(1, 'Zulfiqar Ali Memon', 'Bahadurabad', '42101-1212121-2', 1212233223, 'M', '1982-07-15', 'zulfiqar.memon@nu.edu.pk'),
(2, 'Muhammad Farrukh Shahid', 'Clifton', '42101-1211121-2', 1212983223, 'M', '1995-04-13', 'mfarrukh.shahid@nu.edu.pk'),
(3, 'Muhammad Rafi', 'Karimabad', '42101-1974621-2', 1212209457, 'M', '1980-03-19', 'muhammad.rafi@nu.edu.pk'),
(4, 'Fahad Samad', 'Korangi', '42192-1909451-2', 121226764, 'M', '1984-05-15', 'fahad.samad@nu.edu.pk'),
(5, 'Shoaib Raza', 'Gulshan-e-Iqbal', '42192-7843451-2', 333220364, 'M', '1984-09-05', 'shoaib.raza@nu.edu.pk');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `SEC_ID` int(11) NOT NULL,
  `C_ID` varchar(5) NOT NULL,
  `D_ID` int(3) NOT NULL,
  `Semester` int(1) NOT NULL,
  `section_identifier` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section_teacher`
--

CREATE TABLE `section_teacher` (
  `SEC_ID` int(11) NOT NULL,
  `F_ID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `roll_Number` varchar(7) NOT NULL,
  `Name` char(30) NOT NULL,
  `Address` text NOT NULL,
  `CNIC` int(13) NOT NULL,
  `phone_No` varchar(20) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` enum('M','F','O') NOT NULL,
  `password` varchar(50) NOT NULL,
  `D_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_course`
--

CREATE TABLE `student_course` (
  `id` int(11) NOT NULL,
  `roll_Number` varchar(7) NOT NULL,
  `SEC_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wrong_attendance`
--

CREATE TABLE `wrong_attendance` (
  `id` int(11) NOT NULL,
  `S_ID` varchar(7) NOT NULL,
  `SEC_ID` int(11) NOT NULL,
  `date` date NOT NULL,
  `requested_date` date NOT NULL,
  `reason` text NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `S_ID` (`S_ID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`C_ID`);

--
-- Indexes for table `course_info`
--
ALTER TABLE `course_info`
  ADD PRIMARY KEY (`C_ID`,`D_ID`,`Semester`),
  ADD KEY `D_ID` (`D_ID`),
  ADD KEY `Semester` (`Semester`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`D_ID`);

--
-- Indexes for table `department_incharge`
--
ALTER TABLE `department_incharge`
  ADD PRIMARY KEY (`D_ID`,`F_ID`),
  ADD KEY `F_ID` (`F_ID`);

--
-- Indexes for table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`),
  ADD KEY `recipient` (`recipient`);

--
-- Indexes for table `encodings`
--
ALTER TABLE `encodings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roll_number` (`roll_number`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`F_ID`),
  ADD UNIQUE KEY `CNIC` (`CNIC`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`SEC_ID`),
  ADD KEY `C_ID` (`C_ID`,`D_ID`,`Semester`);

--
-- Indexes for table `section_teacher`
--
ALTER TABLE `section_teacher`
  ADD PRIMARY KEY (`SEC_ID`,`F_ID`),
  ADD KEY `F_ID` (`F_ID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`roll_Number`),
  ADD KEY `D_ID` (`D_ID`);

--
-- Indexes for table `student_course`
--
ALTER TABLE `student_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_course_student` (`roll_Number`),
  ADD KEY `fk_student_course_section` (`SEC_ID`);

--
-- Indexes for table `wrong_attendance`
--
ALTER TABLE `wrong_attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `S_ID` (`S_ID`),
  ADD KEY `SEC_ID` (`SEC_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `C_ID` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `D_ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `email`
--
ALTER TABLE `email`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `encodings`
--
ALTER TABLE `encodings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `SEC_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_course`
--
ALTER TABLE `student_course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wrong_attendance`
--
ALTER TABLE `wrong_attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`S_ID`) REFERENCES `student_course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_info`
--
ALTER TABLE `course_info`
  ADD CONSTRAINT `course_info_ibfk_1` FOREIGN KEY (`C_ID`) REFERENCES `course` (`C_ID`),
  ADD CONSTRAINT `course_info_ibfk_2` FOREIGN KEY (`D_ID`) REFERENCES `department` (`D_ID`),
  ADD CONSTRAINT `course_info_ibfk_3` FOREIGN KEY (`Semester`) REFERENCES `semester` (`Semester`);

--
-- Constraints for table `department_incharge`
--
ALTER TABLE `department_incharge`
  ADD CONSTRAINT `department_incharge_ibfk_1` FOREIGN KEY (`D_ID`) REFERENCES `department` (`D_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `department_incharge_ibfk_2` FOREIGN KEY (`F_ID`) REFERENCES `faculty` (`F_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `email`
--
ALTER TABLE `email`
  ADD CONSTRAINT `email_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `student` (`roll_Number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `email_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `faculty` (`F_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `encodings`
--
ALTER TABLE `encodings`
  ADD CONSTRAINT `encodings_ibfk_1` FOREIGN KEY (`roll_number`) REFERENCES `student` (`roll_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`C_ID`,`D_ID`,`Semester`) REFERENCES `course_info` (`C_ID`, `D_ID`, `Semester`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `section_teacher`
--
ALTER TABLE `section_teacher`
  ADD CONSTRAINT `section_teacher_ibfk_1` FOREIGN KEY (`SEC_ID`) REFERENCES `sections` (`SEC_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `section_teacher_ibfk_2` FOREIGN KEY (`F_ID`) REFERENCES `faculty` (`F_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`D_ID`) REFERENCES `department` (`D_ID`);

--
-- Constraints for table `student_course`
--
ALTER TABLE `student_course`
  ADD CONSTRAINT `fk_student_course_section` FOREIGN KEY (`SEC_ID`) REFERENCES `sections` (`SEC_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_course_student` FOREIGN KEY (`roll_Number`) REFERENCES `student` (`roll_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wrong_attendance`
--
ALTER TABLE `wrong_attendance`
  ADD CONSTRAINT `wrong_attendance_ibfk_1` FOREIGN KEY (`S_ID`) REFERENCES `student` (`roll_Number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wrong_attendance_ibfk_2` FOREIGN KEY (`SEC_ID`) REFERENCES `sections` (`SEC_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
