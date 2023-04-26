from collections import OrderedDict

backend_path = "E:/Repository/FYP/Backend/"

reason_code = "reasonCode"
reason_message = "reasonMessage"

status = "Status"
running = "Application Running"

app = "Application"
student_app = "Student Application"
admin_app = "Admin Application"
att_app = "Attendance Application"

success_code = "00"
success_message = "Execution Successful"

student_not_exists_code = "01"
student_not_exists_message = "Invalid Roll Number or Password"

faculty_id_not_exists_code = "02"
faculty_id_not_exists_message = "No Faculty Member Found"

dept_id_not_exists_code = "03"
dept_id_not_exists_message = "No Department Found"

student_course_not_exists_code = "04"
student_course_not_exists_message = "Student is not registered in any course"

section_id_not_exists_code = "05"
section_id_not_exists_message = "No Section Found"

student_section_list_not_exists_code = "06"
student_section_list_not_exists_message = "Student is not registered in any section"

course_not_exists_code = "07"
course_not_exists_message = "No Course Found"

attendance_not_exists_code = "08"
attendance_not_exists_message = "No Attendance Found"


def getReasonCodeAndMessage(code, message):
    return OrderedDict([(reason_code, code), (reason_message, message)])
