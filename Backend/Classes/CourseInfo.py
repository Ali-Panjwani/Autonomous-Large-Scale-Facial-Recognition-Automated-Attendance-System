from collections import OrderedDict


class CourseInfo:
    def __init__(self, c_id, name, desc, credit, hours):
        self.c_id = c_id
        self.name = name
        self.desc = desc
        self.credit = credit
        self.hours = hours

    def get_dictionary(self):
        course_dictionary = OrderedDict([
            ("c_id", self.c_id),
            ("name", self.name),
            ("desc", self.desc),
            ("credit", self.credit),
            ("hours", self.hours)
        ])

        return course_dictionary

    def set_credit(self, credit):
        self.credit = credit

    def set_hours(self, hours):
        self.hours = hours

    def get_c_id(self):
        return self.c_id

    def get_name(self):
        return self.name

    def get_desc(self):
        return self.desc

    def get_credit(self):
        return self.credit

    def get_hours(self):
        return self.hours
