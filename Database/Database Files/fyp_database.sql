-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2023 at 03:07 PM
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
  `roll_Number` varchar(8) NOT NULL,
  `SEC_ID` int(11) NOT NULL,
  `is_present` enum('P','A') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `date`, `roll_Number`, `SEC_ID`, `is_present`) VALUES
(1, '2023-04-17', '19K-0365', 4, 'P'),
(2, '2023-04-17', '19K-0365', 4, 'A'),
(3, '2023-04-19', '19K-0365', 4, 'P'),
(4, '2023-04-24', '19K-0365', 4, 'P'),
(5, '2023-04-24', '19K-0365', 4, 'P'),
(6, '2023-04-19', '19K-1289', 4, 'P'),
(7, '2023-04-19', '19K-1289', 4, 'P'),
(8, '2023-04-17', '19K-1289', 4, 'A'),
(9, '2023-04-14', '19K-1289', 4, 'P'),
(10, '2023-04-14', '19K-1289', 4, 'P'),
(11, '2023-04-17', '19K-1251', 4, 'P'),
(12, '2023-04-17', '19K-1251', 4, 'P'),
(13, '2023-04-19', '19K-1251', 4, 'P'),
(14, '2023-04-14', '19K-1251', 4, 'A'),
(15, '2023-04-14', '19K-1251', 4, 'P');

-- --------------------------------------------------------

--
-- Table structure for table `course_detail`
--

CREATE TABLE `course_detail` (
  `id` int(11) NOT NULL,
  `C_Name` char(5) NOT NULL,
  `D_Name` char(5) NOT NULL,
  `Semester` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_detail`
--

INSERT INTO `course_detail` (`id`, `C_Name`, `D_Name`, `Semester`) VALUES
(2, 'AP', 'CS', 1),
(4, 'ECC', 'CS', 1),
(3, 'OOP', 'CS', 2),
(1, 'PF', 'CS', 1);

-- --------------------------------------------------------

--
-- Table structure for table `course_info`
--

CREATE TABLE `course_info` (
  `C_ID` varchar(6) NOT NULL,
  `C_Name` char(5) NOT NULL,
  `Desc` text NOT NULL,
  `Credits` int(2) NOT NULL,
  `Hours` decimal(3,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_info`
--

INSERT INTO `course_info` (`C_ID`, `C_Name`, `Desc`, `Credits`, `Hours`) VALUES
('CL118', 'PF-L', 'Programming Fundamentals Lab', 1, '3.0'),
('CS118', 'PF', 'Programming Fundamentals', 3, '3.0'),
('CS217', 'OOP', 'Object Oriented Programming', 3, '3.0'),
('EE117', 'AP', 'Applied Physics', 3, '3.0'),
('SS150', 'ECC', 'English Composition and Comprehension', 3, '3.0');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `D_ID` int(3) NOT NULL,
  `D_Name` char(5) NOT NULL,
  `Desc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`D_ID`, `D_Name`, `Desc`) VALUES
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
(1, 2),
(3, 4),
(4, 5);

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
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `F_ID` int(5) NOT NULL,
  `Name` char(30) NOT NULL,
  `Address` text NOT NULL,
  `CNIC` char(15) NOT NULL,
  `phone_No` char(11) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` enum('M','F','O') NOT NULL,
  `Email` text NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`F_ID`, `Name`, `Address`, `CNIC`, `phone_No`, `DOB`, `Gender`, `Email`, `Password`) VALUES
(1, 'Farooque Hassan Kumbhar', 'Shaheen Complex', '42519-1290341-2', '03332209457', '1983-03-23', 'M', 'farooque.hassan@nu.edu.pk', 'qweqwe1234'),
(2, 'Zulfiqar Ali Memon', 'Bahadurabad', '42101-1212121-2', '1212233223', '1982-07-15', 'M', 'zulfiqar.memon@nu.edu.pk', 'qwejkl1256'),
(3, 'Muhammad Farrukh Shahid', 'Clifton', '42101-1211121-2', '1212983223', '1995-04-13', 'M', 'mfarrukh.shahid@nu.edu.pk', 'qweasd1704'),
(4, 'Muhammad Rafi', 'Karimabad', '42101-1974621-2', '1212209457', '1980-03-19', 'M', 'muhammad.rafi@nu.edu.pk', 'mnbpoi6834'),
(5, 'Fahad Samad', 'Korangi', '42192-1909451-2', '121226764', '1984-05-15', 'M', 'fahad.samad@nu.edu.pk', 'ytrlkj0854'),
(6, 'Shoaib Raza', 'Gulshan-e-Iqbal', '42192-7843451-2', '333220364', '1984-09-05', 'M', 'shoaib.raza@nu.edu.pk', 'cxzhgf3497'),
(7, 'Muhammad Shahzad', 'Bahadurabad', '42929-1029311-2', '03332592305', '1987-07-05', 'M', 'm.shahzad@nu.edu.pk', 'qweqwe1209');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `SEC_ID` int(3) NOT NULL,
  `C_Name` char(30) NOT NULL,
  `D_Name` char(30) NOT NULL,
  `Semester` int(2) NOT NULL,
  `section_identifier` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`SEC_ID`, `C_Name`, `D_Name`, `Semester`, `section_identifier`) VALUES
(1, 'AP', 'CS', 1, 'A'),
(2, 'AP', 'CS', 1, 'B'),
(3, 'AP', 'CS', 1, 'C'),
(4, 'PF', 'CS', 1, 'A'),
(5, 'PF', 'CS', 1, 'B'),
(6, 'PF', 'CS', 1, 'C'),
(7, 'OOP', 'CS', 2, 'A'),
(8, 'OOP', 'CS', 2, 'B'),
(9, 'OOP', 'CS', 2, 'C');

-- --------------------------------------------------------

--
-- Table structure for table `section_teacher`
--

CREATE TABLE `section_teacher` (
  `SEC_ID` int(11) NOT NULL,
  `F_ID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section_teacher`
--

INSERT INTO `section_teacher` (`SEC_ID`, `F_ID`) VALUES
(4, 1),
(5, 7);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `roll_Number` varchar(8) NOT NULL,
  `Name` char(30) NOT NULL,
  `Address` text NOT NULL,
  `CNIC` char(15) NOT NULL,
  `phone_No` varchar(20) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` enum('M','F','O') NOT NULL,
  `Password` varchar(50) NOT NULL,
  `D_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`roll_Number`, `Name`, `Address`, `CNIC`, `phone_No`, `DOB`, `Gender`, `Password`, `D_ID`) VALUES
('19K-0365', 'Ali Panjwani', 'Aisha Manzil', '42101-1212111-2', '01212233220', '2001-05-18', 'M', 'abcabc1234', 1),
('19K-0367', 'Shayan Jiwani', 'Bahadurabad', '42101-1212121-1', '01212233223', '1982-06-15', 'M', '1234abcabc', 1),
('19K-1251', 'Huzaifa Jiwani', 'Bahadurabad', '42186-5690542-1', '03332258661', '2000-07-14', 'M', 'abcabc2345', 1),
('19K-1289', 'Ahmed Ghani', 'Bahadurabad', '42781-1243751-2', '0333257042', '2000-03-22', 'M', 'abcabc1256', 1);

-- --------------------------------------------------------

--
-- Table structure for table `student_course`
--

CREATE TABLE `student_course` (
  `id` int(11) NOT NULL,
  `roll_Number` varchar(8) NOT NULL,
  `SEC_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_course`
--

INSERT INTO `student_course` (`id`, `roll_Number`, `SEC_ID`) VALUES
(4, '19K-0365', 1),
(1, '19K-0365', 4),
(5, '19K-1251', 1),
(2, '19K-1251', 4),
(6, '19K-1289', 1),
(3, '19K-1289', 4);

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
  ADD KEY `attendance_ibfk_3` (`roll_Number`,`SEC_ID`);

--
-- Indexes for table `course_detail`
--
ALTER TABLE `course_detail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `C_Name` (`C_Name`,`D_Name`,`Semester`),
  ADD KEY `course_detail_ibfk_2` (`D_Name`);

--
-- Indexes for table `course_info`
--
ALTER TABLE `course_info`
  ADD PRIMARY KEY (`C_ID`),
  ADD UNIQUE KEY `Name` (`C_Name`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`D_ID`),
  ADD UNIQUE KEY `D_Name` (`D_Name`);

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
  ADD KEY `sections_ibfk_1` (`C_Name`,`D_Name`,`Semester`) USING BTREE;

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
  ADD UNIQUE KEY `CNIC` (`CNIC`),
  ADD KEY `D_ID` (`D_ID`);

--
-- Indexes for table `student_course`
--
ALTER TABLE `student_course`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roll_Number` (`roll_Number`,`SEC_ID`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `course_detail`
--
ALTER TABLE `course_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `SEC_ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `student_course`
--
ALTER TABLE `student_course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `wrong_attendance`
--
ALTER TABLE `wrong_attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `course_detail`
--
ALTER TABLE `course_detail`
  ADD CONSTRAINT `course_detail_ibfk_1` FOREIGN KEY (`C_Name`) REFERENCES `course_info` (`C_Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_detail_ibfk_2` FOREIGN KEY (`D_Name`) REFERENCES `department` (`D_Name`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_ibfk_2` FOREIGN KEY (`C_Name`,`D_Name`,`Semester`) REFERENCES `course_detail` (`C_Name`, `D_Name`, `Semester`) ON DELETE CASCADE ON UPDATE CASCADE;

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
