import pandas as pd
import re
import os
import Backend.dbconnector as dbc
from datetime import datetime, time
from Backend.Classes import Section

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


# def getSectionByDetails(formatted_slots)
