import TimetableFunctions as tf
from datetime import datetime, timedelta
import time

test = 1
timetable = tf.getTodayTimetable()
start_time = tf.todayStartTime()
end_time = tf.todayEndTime()
venues = tf.getVenues()
tf.setVenues()
slots = tf.getSlots()
time_difference = datetime.combine(datetime.today(), start_time) - datetime.combine(datetime.today(), datetime.now().time())

if test == 0:
    if time_difference > timedelta(seconds=0):
        time.sleep(time_difference.total_seconds() + 120)

slot = 1
tf.setCourseDetailsAndSections(tf.getSectionsOfSlot(1))
