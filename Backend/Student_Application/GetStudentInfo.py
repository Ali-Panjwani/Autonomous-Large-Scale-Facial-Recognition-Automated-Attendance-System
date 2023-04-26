from Backend.dbconnector import connect_db
from Backend.Classes import Student, Department, Faculty, Section, CourseInfo, Attendance
from collections import OrderedDict
import Backend.reasonCodeAndMessages as rcm

final_response = ""


def getStudentInfoFunction(roll_number, password):
    complete_student_info = OrderedDict()
    student_record = getStudent(roll_number, password)

    if final_response == rcm.student_not_exists_code:
        complete_student_info["Student"] = student_record
    else:
        dept_record = getDepartment(student_record.get("dept"))
        course_record = getStudentCourses(roll_number)
        attendance_record = getStudentAttendance(roll_number)

        complete_student_info["Student"] = student_record
        complete_student_info["Department"] = dept_record
        complete_student_info["Courses"] = course_record
        complete_student_info["Attendance"] = attendance_record

    return complete_student_info


def getStudent(roll_number, password):
    global final_response
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT * " \
            "FROM student " \
            "WHERE roll_Number = '{roll_number}' AND password = '{password}'"

    formatted_query = query.format(roll_number=roll_number, password=password)
    cursor.execute(formatted_query)
    student_record = cursor.fetchone()
    conn.close()

    if student_record is not None:
        student_record = [str(item) for item in student_record]
        student_record = Student.Student(*student_record).get_dictionary()
        final_response = rcm.success_code

    else:
        final_response = rcm.student_not_exists_code
        student_record = rcm.getReasonCodeAndMessage(final_response, rcm.student_not_exists_message)
    return student_record


def getDepartment(dept_id):
    global final_response
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT * " \
            "FROM department " \
            "WHERE D_ID = '{dept_id}'"

    formatted_query = query.format(dept_id=dept_id)
    cursor.execute(formatted_query)
    dept_record = cursor.fetchone()

    if dept_record is not None:
        dept_record = [str(item) for item in dept_record]

        query = "SELECT F_ID " \
                "FROM department_incharge " \
                "WHERE D_ID = '{dept_id}'"
        formatted_query = query.format(dept_id=dept_id)
        cursor.execute(formatted_query)
        faculty_id = cursor.fetchone()
        conn.close()

        if faculty_id is not None:
            dept_incharge = getFaculty(faculty_id)

            if final_response == rcm.faculty_id_not_exists_code:
                dept_incharge = str(None)
            else:
                dept_incharge = dept_incharge.get("name")

            dept_record.append(dept_incharge)
            dept_record = Department.Department(*dept_record).get_dictionary()

        else:
            dept_record.append(str(None))
            dept_record = Department.Department(*dept_record).get_dictionary()
        final_response = rcm.success_code

    else:
        final_response = rcm.dept_id_not_exists_code
        dept_record = rcm.getReasonCodeAndMessage(final_response, rcm.dept_id_not_exists_message)
    return dept_record


def getFaculty(faculty_id):
    global final_response
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT * " \
            "FROM faculty " \
            "WHERE f_id = '{faculty_id}'"

    formatted_query = query.format(faculty_id=faculty_id)
    cursor.execute(formatted_query)
    faculty_record = cursor.fetchone()
    conn.close()

    if faculty_record is not None:
        faculty_record = [str(item) for item in faculty_record]
        faculty_record = Faculty.Faculty(*faculty_record).get_dictionary()
        final_response = rcm.success_code

    else:
        final_response = rcm.faculty_id_not_exists_code
        faculty_record = rcm.getReasonCodeAndMessage(final_response, rcm.faculty_id_not_exists_message)

    return faculty_record


def getStudentCourses(roll_number):
    global final_response
    section_list = getSectionList(roll_number)

    if section_list is not None:
        course_record = []
        for section in section_list:
            section_info = getSection(section)
            course_info = getCourseInfo(section_info.get("course"))
            section_info.update({"courseInfo": course_info})
            course_record.append(section_info)

    else:
        final_response = rcm.student_course_not_exists_code
        course_record = rcm.getReasonCodeAndMessage(final_response, rcm.student_course_not_exists_message)

    return course_record


def getSectionList(roll_number):
    global final_response
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT SEC_ID " \
            "FROM student_course " \
            "WHERE roll_Number = '{roll_number}'"

    formatted_query = query.format(roll_number=roll_number)
    cursor.execute(formatted_query)
    section_list = cursor.fetchall()
    conn.close()

    if section_list is not None:
        section_list = [tup[0] for tup in section_list]
        section_list = [str(item) for item in section_list]
        final_response = rcm.success_code

    else:
        final_response = rcm.student_section_list_not_exists_code
        section_list = rcm.getReasonCodeAndMessage(final_response, rcm.student_section_list_not_exists_message)

    return section_list


def getSection(sec_id):
    global final_response
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT * " \
            "FROM sections " \
            "WHERE SEC_ID = '{sec_id}'"

    formatted_query = query.format(sec_id=sec_id)
    cursor.execute(formatted_query)
    section_record = cursor.fetchone()

    if section_record is not None:
        section_record = [str(item) for item in section_record]

        query = "SELECT F_ID " \
                "FROM section_teacher " \
                "WHERE SEC_ID = '{sec_id}'"
        formatted_query = query.format(sec_id=sec_id)
        cursor.execute(formatted_query)
        faculty = cursor.fetchone()
        conn.close()

        if faculty is None:
            faculty = getFaculty(str(0))
        else:
            faculty = getFaculty(faculty[0])

        if faculty is not None:
            if final_response == rcm.faculty_id_not_exists_code:
                faculty = str(None)
            else:
                faculty = faculty.get("name")
            section_record.append(faculty)
            section_record = Section.Section(*section_record).get_dictionary()

        else:
            section_record.append(str(None))
            section_record = Section.Section(*section_record).get_dictionary()
        final_response = rcm.success_code

    else:
        final_response = rcm.section_id_not_exists_code
        section_record = rcm.getReasonCodeAndMessage(final_response, rcm.section_id_not_exists_message)
    return section_record


def getCourseInfo(course_name):
    global final_response
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT * " \
            "FROM course_info " \
            "WHERE C_Name = '{c_name}'"

    formatted_query = query.format(c_name=course_name)
    cursor.execute(formatted_query)
    course_info = cursor.fetchone()
    conn.close()

    if course_info is not None:
        course_info = [str(item) for item in course_info]
        course_info = CourseInfo.CourseInfo(*course_info).get_dictionary()
        final_response = rcm.success_code

    else:
        final_response = rcm.course_not_exists_code
        course_info = rcm.getReasonCodeAndMessage(final_response, rcm.course_not_exists_message)

    return course_info


def getStudentAttendance(roll_number):
    global final_response
    section_list = getSectionList(roll_number)
    conn = connect_db()
    cursor = conn.cursor()

    if final_response is not rcm.student_section_list_not_exists_code:
        attendance_record = OrderedDict()
        for section in section_list:
            section_info = getSection(section)

            if final_response is not rcm.section_id_not_exists_code:
                course_name = section_info.get("course")

                query = "SELECT * " \
                        "FROM attendance " \
                        "WHERE roll_number = '{roll_number}' AND SEC_ID = '{section}'"

                formatted_query = query.format(roll_number=roll_number, section=section)
                cursor.execute(formatted_query)
                attendance_list = cursor.fetchall()

                course_attendance = []
                if len(attendance_list) != 0:
                    attendance_list = [[str(elem) for elem in inner] for inner in attendance_list]

                    for attendance in attendance_list:
                        attendance = Attendance.Attendance(*attendance)
                        attendance = attendance.get_dictionary()
                        course_attendance.append(attendance)

                    attendance_record.update({course_name: course_attendance})

                else:
                    final_response = rcm.attendance_not_exists_code
                    course_attendance = rcm.getReasonCodeAndMessage(final_response, rcm.attendance_not_exists_message)
                    attendance_record.update({course_name: course_attendance})

            else:
                attendance_record.update({"section": section_info})

    else:
        attendance_record = rcm.getReasonCodeAndMessage(final_response, rcm.student_section_list_not_exists_message)

    conn.close()
    return attendance_record
