from collections import OrderedDict


class Attendance:

    def __init__(self, a_id, date, roll_number, sec_id, is_present):
        self.a_id = a_id
        self.date = date
        self.roll_number = roll_number
        self.sec_id = sec_id
        self.is_present = is_present

    def get_dictionary(self):
        attendance_dictionary = OrderedDict([
            ("a_id", self.a_id),
            ("date", self.date),
            ("roll_number", self.roll_number),
            ("sec_id", self.sec_id),
            ("is_present", self.is_present)
        ])

        return attendance_dictionary

    def get_a_id(self):
        return self.a_id

    def get_date(self):
        return self.date

    def get_roll_number(self):
        return self.roll_number

    def get_sec_id(self):
        return self.sec_id

    def get_is_present(self):
        return self.is_present
