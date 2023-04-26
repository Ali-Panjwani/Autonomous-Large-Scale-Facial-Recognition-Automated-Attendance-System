from collections import OrderedDict


class Department:
    def __init__(self, d_id, name, desc, incharge):
        self.d_id = d_id
        self.name = name
        self.desc = desc
        self.incharge = incharge

    def get_dictionary(self):
        department_dictionary = OrderedDict([
            ("d_id", self.d_id),
            ("name", self.name),
            ("desc", self.desc),
            ("incharge", self.incharge)
        ])

        return department_dictionary

    def set_incharge(self, incharge):
        self.incharge = incharge

    def get_d_id(self):
        return self.d_id

    def get_name(self):
        return self.name

    def get_desc(self):
        return self.desc

    def get_incharge(self):
        return self.incharge
    