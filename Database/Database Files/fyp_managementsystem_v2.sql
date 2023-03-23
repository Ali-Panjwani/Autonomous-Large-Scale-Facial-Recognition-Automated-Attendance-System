
-- Table Names
-- Attendance 
-- course +
-- student_course +
-- Department +
-- Encodings +
-- Sections +
-- Student +
-- Faculty +


-- New Tables Added
-- course_info (Course,Department,Semester)
-- section_teacher (teacher of each section)
-- department_incharge (HOD)



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
  `password` varchar(50) NOT NULL,
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
  PRIMARY KEY (`D_ID`)
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

-- Table structure for table `course_info`

CREATE TABLE `course_info` (
  `C_ID` varchar(5) NOT NULL,
  `D_ID` int(3) NOT NULL,
  `Semester` int(1) NOT NULL,
  PRIMARY KEY (`C_ID`, `D_ID`, `Semester`),
  FOREIGN KEY (`C_ID`) REFERENCES `course` (`C_ID`),
  FOREIGN KEY (`D_ID`) REFERENCES `department` (`D_ID`),
  FOREIGN KEY (`Semester`) REFERENCES `semester` (`Semester`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `student_course`

CREATE TABLE `student_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roll_Number` varchar(7) NOT NULL,
  `SEC_ID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_course_student` (`roll_Number`),
  KEY `fk_student_course_section` (`SEC_ID`),
  CONSTRAINT `fk_student_course_section` FOREIGN KEY (`SEC_ID`) REFERENCES `sections` (`SEC_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
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
  `email` text NOT NULL,
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `sections`

CREATE TABLE `sections` (
  `SEC_ID` int(11) NOT NULL AUTO_INCREMENT,
  `C_ID` varchar(5) NOT NULL,
  `D_ID` int(3) NOT NULL,
  `Semester` int(1) NOT NULL,
  `section_identifier` char(1) NOT NULL,
  PRIMARY KEY (`SEC_ID`),
  FOREIGN KEY (`C_ID`, `D_ID`, `Semester`) REFERENCES `course_info`(`C_ID`, `D_ID`, `Semester`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

-- Table structure for table `section_teacher`

CREATE TABLE `section_teacher` (
  `SEC_ID` int(11) NOT NULL,
  `F_ID` int(5) NOT NULL,
  PRIMARY KEY (`SEC_ID`, `F_ID`),
  FOREIGN KEY (`SEC_ID`) REFERENCES `sections`(`SEC_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`F_ID`) REFERENCES `faculty`(`F_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `encodings`

CREATE TABLE `encodings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roll_number` varchar(7) NOT NULL,
  `encoding` varbinary NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`roll_number`) REFERENCES `student` (`roll_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `department_incharge`

CREATE TABLE `department_incharge` (
  `D_ID` int(3) NOT NULL,
  `F_ID` int(5) NOT NULL,
  PRIMARY KEY (`D_ID`, `F_ID`),
  FOREIGN KEY (`D_ID`) REFERENCES `department` (`D_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`F_ID`) REFERENCES `faculty` (`F_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

-- Table structure for table `attendance`

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `S_ID` int(11) NOT NULL,
  `is_present` boolean NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`S_ID`) REFERENCES `student_course`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `wrong_attendance`

CREATE TABLE `wrong_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `S_ID` int(11) NOT NULL,
  `SEC_ID` int(11) NOT NULL,
  `date` date NOT NULL,
  `requested_date` date NOT NULL,
  `reason` text NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`S_ID`) REFERENCES `student`(`S_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`SEC_ID`) REFERENCES `sections`(`SEC_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `email`

CREATE TABLE `email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(7) NOT NULL,
  `recipient` int(5) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `date_sent` datetime NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`sender`) REFERENCES `student`(`roll_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`recipient`) REFERENCES `faculty`(`F_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
