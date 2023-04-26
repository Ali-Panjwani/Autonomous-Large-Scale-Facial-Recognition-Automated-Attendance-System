from collections import OrderedDict


class Faculty:
    def __init__(self, f_id, name, address, cnic, phone_number, dob, gender, email, password):
        self.f_id = f_id
        self.name = name
        self.address = address
        self.cnic = cnic
        self.phone_number = phone_number
        self.dob = dob
        self.gender = gender
        self.email = email
        self.password = password

    def get_dictionary(self):
        faculty_dictionary = OrderedDict([
            ("f_id", self.f_id),
            ("name", self.name),
            ("address", self.address),
            ("cnic", self.cnic),
            ("phone_number", self.phone_number),
            ("dob", self.dob),
            ("gender", self.gender),
            ("email", self.email),
            ("password", self.password)
        ])

        return faculty_dictionary

    def get_f_id(self):
        return self.f_id

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

    def get_email(self):
        return self.email

    def get_password(self):
        return self.password
