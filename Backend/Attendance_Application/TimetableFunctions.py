import pandas as pd
import re
from datetime import datetime, time


def getToday():
    return datetime.now().strftime("%A").upper()


def getTodayTimetable():
    today = getToday()
    timetable = "./Timetable/FAST School of Computing.xlsx"
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


def getSectionsOfSlot(slot):
    timetable = getTodayTimetable()

    unformatted_slots = timetable[slot].tolist()[:]

    print(unformatted_slots)
