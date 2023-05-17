import TimetableFunctions as tf
from datetime import datetime, timedelta, date
import time


test = 1
timetable = tf.getTodayTimetable()
print(timetable)

end_date_str = '2023-07-01'
end_date = datetime.strptime(end_date_str, '%Y-%m-%d').date()

while date.today() != end_date:

    start_time = tf.todayStartTime()
    print(start_time)

    end_time = tf.todayEndTime()
    print(end_time)

    venues = tf.getVenues()
    print(venues)

    tf.setVenues()
    slots = tf.getSlots()
    print(slots)

    time_difference = datetime.combine(datetime.today(), start_time) - datetime.combine(datetime.today(), datetime.now().time())

    if test == 0:
        if time_difference > timedelta(seconds=0):
            time.sleep(time_difference.total_seconds() + 300)

    for  slot in tf.getSlots():
        class_time_difference = datetime.combine(datetime.today(), tf.getSlotStartTime(slot)) - datetime.combine(datetime.today(), datetime.now().time())
        print(class_time_difference)

        if class_time_difference > timedelta(seconds=0) and test == 0:
            time.sleep(class_time_difference.total_seconds() + 300)

        print(tf.getSlotStartTime(slot))
        section_details_list = tf.getSectionsOfSlot(slot)
        print(section_details_list)

        section_list = tf.getSectionByDetails(section_details_list)
        print(section_list)

        all_students_list = []
        attendance_list = []

        venues = [['A-1', 'EE']]
        section_list = ['4']

        for i in range(2):
            # attendance_list, all_students_list = tf.markAttendance(venues, section_list)
            attendance_list_tmp, all_students_list, duration_list = tf.markAttendance(venues, section_list)
            print(attendance_list)
            print(all_students_list)
            print(duration_list)

            attendance_list = tf.concatenate_lists(attendance_list, attendance_list_tmp)

            intermediate_time_difference = datetime.combine(datetime.today(), tf.getSlotEndTime(slot)) - datetime.combine(datetime.today(), datetime.now().time())
            if intermediate_time_difference > timedelta(seconds=0) and test == 0:
                time.sleep(intermediate_time_difference.total_seconds() + 300)


        attendance_to_db = tf.setAttendanceToDb(['4'], attendance_list, all_students_list)
        print(attendance_to_db)

        break


