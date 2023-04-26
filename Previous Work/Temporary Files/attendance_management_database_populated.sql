-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 03, 2023 at 10:42 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendance_management_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `A_ID` varchar(5) NOT NULL,
  `C_ID` varchar(5) NOT NULL,
  `Day` date NOT NULL,
  `Time` time NOT NULL,
  `Count` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `C_ID` varchar(7) NOT NULL,
  `Name` char(30) NOT NULL,
  `Desc` text NOT NULL,
  `Credits` int(1) NOT NULL,
  `Hours` time NOT NULL,
  `Semester` int(1) NOT NULL,
  `Section` char(2) NOT NULL,
  `D_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`C_ID`, `Name`, `Desc`, `Credits`, `Hours`, `Semester`, `Section`, `D_ID`) VALUES
('CS3002', 'Information Security', 'The term \'information security\' means protecting information and information systems from unauthorized access, use, disclosure, disruption, modification, or destruction in order to provide integrity, confidentiality, and availability.', 3, '12:24:29', 7, 'B', 1),
('CS4001', 'Professional Practices in IT', 'Professional practice in Information Technology is a research paper that facilitate one\'s skills in information technology also targeted towards educating one\'s ignorance in searching for information anywhere. It contains information on job applications and how to treat information.', 3, '12:24:29', 7, 'B', 1),
('CS4037', 'Introduction to Cloud Computin', 'Cloud computing is a general term for anything that involves delivering hosted services over the internet. These services are divided into three main categories or types of cloud computing: infrastructure as a service (IaaS), platform as a service (PaaS) and software as a service (SaaS).', 3, '12:24:29', 7, 'B', 2),
('CS4042', 'Information Processing Techniq', 'Information processing refers to the manipulation of digitized information by computers and other digital electronic equipment, known collectively as information technology (IT). Information processing systems include business software, operating systems, computers, networks and mainframes', 3, '28:28:22', 7, 'B', 2),
('CS4091', 'Final Year Project – I', 'A Final Year Project (FYP) is a project or academic task that must be accomplished individually by every undergraduate student to obtain the attributions to graduate. Its aim is to demonstrate the skills and knowledge students have acquired in their studies.', 3, '24:28:22', 7, 'B', 1);

-- --------------------------------------------------------

--
-- Table structure for table `courses_of_student`
--

CREATE TABLE `courses_of_student` (
  `roll_Number` varchar(7) NOT NULL,
  `S_ID` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departmant`
--

CREATE TABLE `departmant` (
  `D_ID` int(3) NOT NULL,
  `Name` char(30) NOT NULL,
  `Desc` text NOT NULL,
  `Incharge` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departmant`
--

INSERT INTO `departmant` (`D_ID`, `Name`, `Desc`, `Incharge`) VALUES
(1, 'Computer Science', 'In computer science department we offer many destructive and market competitive cources with highly qualified industry teachers which help you grow  ', 2),
(2, 'Software Engineering', 'Software is a program or set of programs containing instructions that provide desired functionality. And Engineering is the process of designing and building something that serves a particular purpose and finds a cost-effective solution to problems. \r\n\r\nSoftware Engineering is mainly used for large projects based on software systems rather than single programs or applications. The main goal of software Engineering is to develop software application for improving the quality,  budget and time efficiency. Software Engineering ensures that the software that has to built should be consistent, correct, also on budget, on time and within the required requirements. There are Four main Attributes of Software Engineering:-\r\n\r\nEfficiency\r\nReliability\r\nRobustness', 3),
(3, 'Electrical Engineering', 'Electrical engineering (sometimes referred to as electrical and electronic engineering) is a professional engineering discipline that deals with the study and application of electricity, electronics and electromagnetism', 4);

-- --------------------------------------------------------

--
-- Table structure for table `encodings`
--

CREATE TABLE `encodings` (
  `roll_Number` varchar(7) NOT NULL,
  `Encoding1` mediumtext NOT NULL,
  `Encoding2` mediumtext NOT NULL,
  `Encoding3` mediumtext NOT NULL,
  `Encoding4` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `S_ID` varchar(5) NOT NULL,
  `C_ID` varchar(5) NOT NULL,
  `D_ID` int(3) NOT NULL,
  `Semester` int(1) NOT NULL,
  `Section` char(1) NOT NULL,
  `T_ID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `roll_Number` varchar(7) NOT NULL,
  `Name` char(30) NOT NULL,
  `Address` text NOT NULL,
  `CNIC` varchar(11) NOT NULL,
  `phone_No` varchar(11) NOT NULL,
  `Gender` char(1) NOT NULL,
  `DOB` date NOT NULL,
  `D_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`roll_Number`, `Name`, `Address`, `CNIC`, `phone_No`, `Gender`, `DOB`, `D_ID`) VALUES
('19K0365', 'Ali Panjwani', 'malik aga khan society street 2 plot 80 flat no 1 karachi', '42101600000', '03340286051', 'M', '2021-03-19', 1),
('19K1251', 'Muhammad Huzaifa', 'mehran terrace 80/3 2nd floor flat no 5 bahadurabad sharfabad karachi', '42101642033', '03102744660', 'M', '2013-01-23', 1),
('19K1258', 'Asad Hussain', 'gulshan e iqbal block N plot 80 karachi', '12101532033', '02222286051', 'M', '2017-07-07', 2),
('19K1289', 'Ahmed Ghani', 'chandni heights 2nd floor flat no 201 near chandni park', '33101631035', '03313333332', 'M', '2013-02-16', 1),
('19K1373', 'fatima', 'tower street 7 near fresco bakeri shakoori heights etc', '42101601000', '03111164711', 'F', '2023-06-15', 3);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `T_ID` int(5) NOT NULL,
  `Name` char(30) NOT NULL,
  `Address` text NOT NULL,
  `CNIC` varchar(13) NOT NULL,
  `phone_No` varchar(11) NOT NULL,
  `Gender` char(1) NOT NULL,
  `DOB` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`T_ID`, `Name`, `Address`, `CNIC`, `phone_No`, `Gender`, `DOB`) VALUES
(1, 'sir zain', 'flat no 2 mehran terrace 80/3 bahadurabad karachi', '4210163203303', '03310363792', 'M', '2013-02-14'),
(2, 'Sir Zulfiqar Ali Memon', 'Ranchorline street no 2 near to jubilee heights flat no 2 karachi', '4111163201303', '03324363792', 'M', '1992-04-01'),
(3, 'Sir Basit Ali', 'flat no 4 near masji e qubah sareen heights defence karachi ', '4210162202305', '03310363792', 'M', '1998-03-02'),
(4, 'Sir khan', 'Khan academy near dhmsher mandir india', '3210163103503', '03110364772', 'M', '2008-08-08'),
(5, 'Maam Nida Munawar', 'defense heights flat no 2 2nd floor near MacDonalds karachi', '1210153203303', '03340380772', 'F', '2014-01-22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`A_ID`),
  ADD KEY `attendance_course_fk_1` (`C_ID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`C_ID`),
  ADD UNIQUE KEY `name` (`Name`),
  ADD KEY `course_department_fk_1` (`D_ID`);

--
-- Indexes for table `courses_of_student`
--
ALTER TABLE `courses_of_student`
  ADD KEY `roll_Number` (`roll_Number`),
  ADD KEY `cof_sections_fk_2` (`S_ID`);

--
-- Indexes for table `departmant`
--
ALTER TABLE `departmant`
  ADD PRIMARY KEY (`D_ID`),
  ADD UNIQUE KEY `name` (`Name`),
  ADD KEY `Incharge` (`Incharge`) USING BTREE;

--
-- Indexes for table `encodings`
--
ALTER TABLE `encodings`
  ADD PRIMARY KEY (`roll_Number`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`S_ID`),
  ADD UNIQUE KEY `combination` (`D_ID`,`Semester`,`Section`),
  ADD KEY `T_ID` (`T_ID`),
  ADD KEY `section_course_fk_3` (`C_ID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`roll_Number`),
  ADD UNIQUE KEY `cnic` (`CNIC`),
  ADD KEY `student_department_fk_1` (`D_ID`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`T_ID`),
  ADD UNIQUE KEY `CNIC` (`CNIC`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_course_fk_1` FOREIGN KEY (`C_ID`) REFERENCES `course` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_department_fk_1` FOREIGN KEY (`D_ID`) REFERENCES `departmant` (`D_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_of_student`
--
ALTER TABLE `courses_of_student`
  ADD CONSTRAINT `cof_sections_fk_2` FOREIGN KEY (`S_ID`) REFERENCES `sections` (`S_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cof_students_fk_1` FOREIGN KEY (`roll_Number`) REFERENCES `student` (`roll_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `departmant`
--
ALTER TABLE `departmant`
  ADD CONSTRAINT `department_teacher_fk_1` FOREIGN KEY (`Incharge`) REFERENCES `teacher` (`T_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `encodings`
--
ALTER TABLE `encodings`
  ADD CONSTRAINT `encodings_students_fk_1` FOREIGN KEY (`roll_Number`) REFERENCES `student` (`roll_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `section_course_fk_3` FOREIGN KEY (`C_ID`) REFERENCES `course` (`C_ID`),
  ADD CONSTRAINT `sections_department_fk_2` FOREIGN KEY (`D_ID`) REFERENCES `departmant` (`D_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sections_teacher_fk_1` FOREIGN KEY (`T_ID`) REFERENCES `teacher` (`T_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_department_fk_1` FOREIGN KEY (`D_ID`) REFERENCES `departmant` (`D_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
