from collections import OrderedDict


class Student:
    def __init__(self, roll_number, name, address, cnic, phone_number, dob, gender, password, dept):
        self.roll_number = roll_number
        self.name = name
        self.address = address
        self.cnic = cnic
        self.phone_number = phone_number
        self.dob = dob
        self.gender = gender
        self.password = password
        self.dept = dept

    def get_dictionary(self):
        student_dictionary = OrderedDict([
            ("roll_number", self.roll_number),
            ("name", self.name),
            ("address", self.address),
            ("cnic", self.cnic),
            ("phone_number", self.phone_number),
            ("dob", self.dob),
            ("gender", self.gender),
            ("password", self.password),
            ("dept", self.dept)
        ])

        return student_dictionary

    def get_roll_number(self):
        return self.roll_number

    def get_name(self):
        return self.name

    def get_address(self):
        return self.address

    def get_cnic(self):
        return self.cnic

    def get_phone_number(self):
        return self.phone_number

    def get_dob(self):
        return self.dob

    def get_gender(self):
        return self.gender

    def get_password(self):
        return self.password

    def get_dept(self):
        return self.dept
