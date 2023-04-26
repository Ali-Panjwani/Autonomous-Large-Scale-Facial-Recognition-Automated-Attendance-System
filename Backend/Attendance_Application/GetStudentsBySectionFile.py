from Backend.dbconnector import connect_db


def getStudentsBySectionFunction(course, degree, semester, section):
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT SEC_ID " \
            "FROM sections " \
            "WHERE C_Name = '{course_name}' AND D_Name = '{degree_name}' AND " \
            "Semester = {semester} AND section_identifier = '{section_identifier}'"

    formatted_query = query.format(course_name=course, degree_name=degree, semester=semester,
                                   section_identifier=section)
    cursor.execute(formatted_query)
    section_id_result = cursor.fetchone()

    cursor.execute("SELECT roll_Number FROM student_course WHERE SEC_ID = %s", section_id_result)
    roll_numbers_by_section = cursor.fetchall()
    roll_numbers_by_section = [item for sublist in roll_numbers_by_section for item in sublist]

    return roll_numbers_by_section

    conn.close()
