import pandas as pd
import re
import os
import Backend.dbconnector as dbc
from datetime import datetime, time, date
import AttendanceMarker as am
import Backend.reasonCodeAndMessages as rcm

test = 1


def getToday():
    if test == 1:
        return 'MONDAY'

    return datetime.now().strftime("%A").upper()


def getTodayTimetable():
    today = getToday()
    timetable = "../Timetable/FAST School of Computing.xlsx"
    return pd.read_excel(timetable, sheet_name=today)


def todayStartTime():
    timetable = getTodayTimetable()

    result = timetable.where(timetable == 'Venues/time').stack()
    rows, cols = result.index[0]
    start_hour = timetable.iloc[rows, 1].split("-")
    start_hour = start_hour[0]
    return time(hour=int(start_hour))


def todayEndTime():
    timetable = getTodayTimetable()

    result = timetable.where(timetable == 'Venues/time').stack()
    rows, cols = result.index[0]
    if getToday() == "FRIDAY":
        end_hour = timetable.iloc[rows, -1].split(":")
        end_hour = int(end_hour[0]) + 13
        return time(hour=end_hour)
    else:
        end_hour = timetable.iloc[rows, -1].split("-")
        end_hour = int(end_hour[0]) + 13
        return time(hour=end_hour)


def getVenues():
    timetable = getTodayTimetable()

    unformatted_venues = timetable["Slots"].tolist()
    extra_word_to_remove_list = ["Venues/time", "CLASSROOMS", "LABS"]

    for value in extra_word_to_remove_list:
        unformatted_venues.remove(value)

    formatted_venues = []
    for value in unformatted_venues:
        temporary_list = ["", ""]
        venue = re.sub(r'\([^)]*\)', '', value).split(" ")[:2]

        if "EE" in venue or "CS" in venue:
            if venue[0] == "EE" or venue[0] == "CS":
                temporary_list[0] = venue[1]
                temporary_list[1] = venue[0]
                formatted_venues.append(temporary_list)
            else:
                temporary_list[0] = venue[0]
                temporary_list[1] = venue[1]
                formatted_venues.append(temporary_list)

        else:
            temporary_list[0] = venue[0]
            temporary_list[1] = "None"
            formatted_venues.append(temporary_list)

    return formatted_venues

def getSlots():
    timetable = getTodayTimetable()

    slots = timetable.loc[timetable['Slots'] == 'Slots']

    # Extract all numeric values from the row and store them in a list
    slots = slots.columns.tolist()

    # Removing Slots word from the list
    del slots[0:1]

    return slots


def setVenues():

    class_cams_location = './Class_Cams'
    if not os.path.exists(class_cams_location):
        os.mkdir(class_cams_location)


    for venue in getVenues():
        class_location = '/' + venue[0] + '_' + venue[1]
        if not os.path.exists(class_cams_location + class_location):
            os.mkdir(class_cams_location + class_location)


def changeDegreeName(name):
    if name == "BCS":
        name = "CS"
    elif name == "BSE":
        name = "SE"
    elif name == "BCY":
        name = "CYS"
    elif name == "BAI":
        name = "AI"
    elif name == "BSR":
        name = "R"

    return name



def extractSemesterAndSection(string):
    pattern = r'\([^()]*\)'
    string = re.sub(pattern, '', string)

    # Remove any remaining brackets
    string = string.replace('(', '').replace(')', '')
    if len(string) > 2:
        string = string[:2]

    semester = ''
    section = ''
    for char in string:
        if char.isdigit():
            semester += char
        else:
            section += char
    return semester, section


def getSectionsOfSlot(slot):
    timetable = getTodayTimetable()

    unformatted_slots = timetable[slot].tolist()
    del unformatted_slots[0:2]

    extra_word_to_remove_list = ["Venues/time", "CLASSROOMS", "LABS", "RESERVED FOR EE"]

    for value in extra_word_to_remove_list:
        if value in unformatted_slots:
            unformatted_slots.remove(value)

    formatted_slots = []
    # Removing NaN from the list
    for slot in unformatted_slots:
        temp_list = []
        if isinstance(slot, float):
            formatted_slots.append(slot)
        else:
            if 'Lab' not in slot:
                slot = slot.split('\n')
                instructor = slot[1]
                slot[0] = slot[0].split(' ')
                course_name = slot[0][0]
                slot[0][1] = slot[0][1].split('-')
                degree_name = changeDegreeName(slot[0][1][0])

                semester, section = extractSemesterAndSection(slot[0][1][1])
                temp_list = [course_name, degree_name, semester, section]

            else:
                slot = slot.split('\n')
                instructor = slot[1]
                slot[0] = slot[0].split(' ')
                course_name = slot[0][0] + '-L'
                slot[0][2] = slot[0][2].split('-')
                degree_name = changeDegreeName(slot[0][2][0])

                semester, section = extractSemesterAndSection(slot[0][2][1])
                temp_list = [course_name, degree_name, semester, section]

            formatted_slots.append(temp_list)

    return formatted_slots


def setCourseDetailsAndSections(formatted_slots):
    conn = dbc.connect_db()
    cursor = conn.cursor()

    formatted_slots = set(tuple(x) for x in formatted_slots if isinstance(x, list))

    for value in formatted_slots :
        if not isinstance(value, float):

            query = "INSERT INTO course_detail (`id`, `C_Name`, `D_Name`, `Semester`) " \
                    "SELECT '' as id, '{course_name}' as C_Name, '{degree_name}' as D_Name, '{semester}' as Semester " \
                    "FROM DUAL " \
                    "WHERE NOT EXISTS ( " \
                    "SELECT 1 " \
                    "FROM course_detail " \
                    "WHERE C_Name = '{course_name}' " \
                    "AND D_Name = '{degree_name}' " \
                    "AND Semester = '{semester}' )"


            formatted_query = query.format(course_name= value[0], degree_name=value[1], semester=value[2])
            cursor.execute(formatted_query)

            query = "INSERT INTO `sections`(`SEC_ID`, `C_Name`, `D_Name`, `Semester`, `section_identifier`) " \
                    "SELECT '' as SEC_ID, '{course_name}' as C_Name, '{degree_name}' as D_Name, '{semester}' as Semester, '{section}' as section_identifier " \
                    "FROM DUAL " \
                    "WHERE NOT EXISTS (" \
                    "SELECT 1 " \
                    "FROM `sections` " \
                    "WHERE `C_Name` = '{course_name}' AND " \
                    "`D_Name` = '{degree_name}' AND " \
                    "`Semester` = '{semester}' AND " \
                    "`section_identifier` = '{section}' )"



            formatted_query = query.format(course_name=value[0], degree_name=value[1], semester=value[2], section=value[3])
            cursor.execute(formatted_query)

    conn.commit()
    conn.close()


def getSectionByDetails(formatted_slots):
    conn = dbc.connect_db()
    cursor = conn.cursor()
    section_list = []

    occurred_values = set()

    for value in formatted_slots:
        if not isinstance(value, float):

            value_tuple = tuple(value)  # Convert list to tuple

            if value_tuple in occurred_values:
                index = formatted_slots.index(value)
                section_list.append(section_list[index])

            else:
                query = "SELECT SEC_ID " \
                        "FROM sections " \
                        "WHERE `C_Name` = '{course_name}' AND `D_Name` = '{degree_name}' AND `Semester` = '{semester}' AND `section_identifier` = '{section}'"

                formatted_query = query.format(course_name=value[0], degree_name=value[1], semester=value[2],
                                               section=value[3])
                cursor.execute(formatted_query)
                section = cursor.fetchone()
                section_list.append(section)

            occurred_values.add(value_tuple)  # Add the tuple to the set

        else:
            section_list.append(value)



    conn.close()

    section_list = [str(item) for item in section_list]
    section_list = [section.replace('(', '').replace(')', '').replace(',', '') for section in section_list]

    return section_list


def setAttendanceToDb(section_list, attendance_list, all_students_list):

    conn = dbc.connect_db()
    cursor = conn.cursor()

    today_date = date.today()

    for section in section_list:
        for student_list in all_students_list:
            for student in student_list:
                if section != 'nan':

                    if any(student in sublist for sublist in attendance_list) :
                        is_present = 'P'
                    else:
                        is_present = 'A'


                    query = "INSERT INTO attendance (`id`, `date`, `roll_Number`, `SEC_ID`, `is_present`) " \
                            "VALUES ('','{today_date}','{roll_number}','{section_id}','{is_present}')"

                    formatted_query = query.format(today_date= today_date, roll_number=student, section_id= section, is_present=is_present)
                    cursor.execute(formatted_query)

    conn.commit()
    conn.close()

    return 1


def markAttendance(venues, section_list):
    attendance_list = []
    roll_numbers_list = []
    duration_list = []
    for section in section_list:
        if section != 'nan':
            conn = dbc.connect_db()
            cursor = conn.cursor()

            query = "SELECT roll_Number " \
                    "FROM student_course " \
                    "WHERE SEC_ID = {Sec_id}"

            formatted_query = query.format(Sec_id=section)
            cursor.execute(formatted_query)
            roll_numbers = cursor.fetchall()

            conn.close()

            venue = venues[section_list.index(section)]
            venue = venue[0] + '_' + venue[1]

            if len(roll_numbers) != 0 :
                roll_numbers = [str(rn).strip("(),'") for rn in roll_numbers]

                attendance, duration = am.markClassAttendance(venue, roll_numbers)
                attendance_list.append(attendance)
                roll_numbers_list.append(roll_numbers)
                duration_list.append(duration)


            else:
                attendance_list.append(rcm.no_student_in_section_message)
                roll_numbers_list.append(rcm.no_student_in_section_message)
                duration_list.append('nan')

        else:
            attendance_list.append(section)
            roll_numbers_list.append(section)
            duration_list.append(section)

    return attendance_list, roll_numbers_list, duration_list


def getSlotStartTime(slot):
    timetable = getTodayTimetable()

    class_time = timetable[slot].tolist()[0]
    class_time = class_time.split("-")
    class_time = class_time[0]

    if ':' in class_time:
        time_format = "%H:%M"
    else:
        time_format = "%H"

    # Append current date to the time string
    datetime_string = datetime.now().strftime("%Y-%m-%d") + " " + class_time

    # Parse the datetime string
    datetime_obj = datetime.strptime(datetime_string, "%Y-%m-%d " + time_format)

    # Extract the time component
    converted_start_time = datetime_obj.time()

    return converted_start_time

def getSlotEndTime(slot):
    timetable = getTodayTimetable()

    class_time = timetable[slot].tolist()[0]
    class_time = class_time.split("-")
    class_time = class_time[1]

    if ':' in class_time:
        time_format = "%H:%M"
    else:
        time_format = "%H"

    # Append current date to the time string
    datetime_string = datetime.now().strftime("%Y-%m-%d") + " " + class_time

    # Parse the datetime string
    datetime_obj = datetime.strptime(datetime_string, "%Y-%m-%d " + time_format)

    # Extract the time component
    converted_end_time = datetime_obj.time()

    return converted_end_time


def concatenate_lists(*args):
    new_list = []
    index = 0

    while True:
        sublist_s = [lst[index] for lst in args if index < len(lst)]

        if not sublist_s:
            break

        unique_values = list(set(sum(sublist_s, [])))
        new_list.append(unique_values)

        index += 1

    return new_list
