
-- Table Names
-- Attendance 
-- course +
-- student_course +
-- Department +
-- Encodings 
-- Sections
-- Student +
-- Faculty


-- New Tables Added
-- course_semester
-- course_department



-- --------------------------------------------------------

-- Table structure for table `student`

CREATE TABLE `student` (
  `roll_Number` varchar(7) NOT NULL,
  `Name` char(30) NOT NULL,
  `Address` text NOT NULL,
  `CNIC` int(13) NOT NULL,
  `phone_No` varchar(20) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` enum('M','F','O') NOT NULL,
  `D_ID` int(3) NOT NULL,
  PRIMARY KEY (`roll_Number`),
  KEY `D_ID` (`D_ID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`D_ID`) REFERENCES `department` (`D_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `department`

CREATE TABLE `department` (
  `D_ID` int(3) NOT NULL,
  `Name` char(30) NOT NULL,
  `Desc` text NOT NULL,
  `Incharge` int(5) DEFAULT NULL,
  PRIMARY KEY (`D_ID`),
  KEY `Incharge` (`Incharge`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`Incharge`) REFERENCES `faculty` (`F_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

-- Table structure for table `course`

CREATE TABLE `course` (
  `C_ID` varchar(5) NOT NULL,
  `Name` char(30) NOT NULL,
  `Desc` text NOT NULL,
  `Credits` int(2) NOT NULL,
  `Hours` decimal(3,1) NOT NULL,
  PRIMARY KEY (`C_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `course_department`

CREATE TABLE `course_department` (
  `C_ID` varchar(5) NOT NULL,
  `D_ID` int(3) NOT NULL,
  PRIMARY KEY (`C_ID`, `D_ID`),
  FOREIGN KEY (`C_ID`) REFERENCES `course` (`C_ID`),
  FOREIGN KEY (`D_ID`) REFERENCES `department` (`D_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `course_semester`

CREATE TABLE `course_semester` (
  `C_ID` varchar(5) NOT NULL,
  `Semester` int(1) NOT NULL,
  PRIMARY KEY (`C_ID`, `Semester`),
  FOREIGN KEY (`C_ID`) REFERENCES `course` (`C_ID`),
  FOREIGN KEY (`Semester`) REFERENCES `semester` (`Semester`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `student_course`

CREATE TABLE `student_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roll_Number` varchar(7) NOT NULL,
  `C_ID` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_course_student` (`roll_Number`),
  KEY `fk_student_course_course` (`C_ID`),
  CONSTRAINT `fk_student_course_course` FOREIGN KEY (`C_ID`) REFERENCES `course` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_course_student` FOREIGN KEY (`roll_Number`) REFERENCES `student` (`roll_Number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

-- Table structure for table `faculty`

CREATE TABLE `faculty` (
  `F_ID` int(5) NOT NULL,
  `Name` char(30) NOT NULL,
  `Address` text NOT NULL,
  `CNIC` int(13) NOT NULL,
  `phone_No` int(11) NOT NULL,
  `Gender` char(1) NOT NULL,
  `DOB` date NOT NULL,
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `sections`

CREATE TABLE `sections` (
  `S_ID` int(11) NOT NULL AUTO_INCREMENT,
  `C_ID` varchar(5) NOT NULL,
  `D_ID` int(3) NOT NULL,
  `Semester` int(1) NOT NULL,
  `Section` char(1) NOT NULL,
  `F_ID` int(5) NOT NULL,
  PRIMARY KEY (`S_ID`),
  FOREIGN KEY (`C_ID`) REFERENCES `courses`(`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`D_ID`) REFERENCES `departments`(`D_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`F_ID`) REFERENCES `faculty`(`F_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

-- Notes (TO DO):
-- 1. Merge coursse_semester and coursse_department
-- 2. Add identifiers to sections
-- 3. Optimize sections table (C,D,Identifier)
-- 4. Search how to find which student belongs to which sections
