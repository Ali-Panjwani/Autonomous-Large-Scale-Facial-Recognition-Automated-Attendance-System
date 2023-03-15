Relationship Dictionary:

Attendance:
The attendance table stores attendance records for students in a course. It has columns for the attendance record's unique id, the date, the S_ID foreign key referencing the id of the corresponding record in the student_course table, and a boolean flag indicating whether the student was present or not. The foreign key is set up with cascade delete and update options.

course:
The course table contains information about the courses offered by the university, including the course ID, name, description, credits, and hours. The course_info table is related to the course table by the course ID. It contains additional information about each course, such as the department and semester in which it is offered. One course can have multiple course_info entries, each representing a different semester or department.

student_course:
The student_course table is a junction table that establishes a many-to-many relationship between the student and sections tables. It contains the primary key id, the foreign key roll_number referencing the student table, and the foreign key SEC_ID referencing the sections table.

Department:
The Department table stores information about the academic departments of the university. It contains the department ID, name, and description. The student and course_info tables are related to the Department table by the foreign key D_ID.

Encodings:
The Encodings table contains information about the facial recognition encodings of each student. It contains the primary key id, the foreign key roll_number referencing the student table, and the encoding value.

Sections:
The sections table stores information about the sections of each course offered in each semester. It contains the primary key SEC_ID, the foreign key course_info referencing the course_info table, and the section identifier.

Student:
The student table contains information about each student, including the roll number, name, address, CNIC, phone number, date of birth, gender, and department ID. The student_course and encodings tables are related to the student table by the foreign key roll_number.

Faculty:
The Faculty table contains information about the faculty members of the university. It contains the faculty ID, name, address, CNIC, phone number, gender, and date of birth. The sections, department_incharge, and section_teacher tables are related to the Faculty table by the foreign key F_ID.

course_info:
The course_info table is related to the course and Department tables by the course ID and Department ID, respectively. It contains additional information about each course, such as the department and semester in which it is offered.

section_teacher:
The section_teacher table establishes a many-to-many relationship between the faculty and sections tables. It contains the foreign keys SEC_ID and F_ID referencing the sections and Faculty tables, respectively.

department_incharge:
The department_incharge table establishes a one-to-one relationship between the Department and Faculty tables. It contains the foreign keys D_ID and F_ID referencing the Department and Faculty tables, respectively.
