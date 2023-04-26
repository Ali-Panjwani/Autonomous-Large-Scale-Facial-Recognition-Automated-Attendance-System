from collections import OrderedDict


class Section:
    def __init__(self, sec_id, course, degree, semester, section, instructor):
        self.sec_id = sec_id
        self.course = course
        self.degree = degree
        self.semester = semester
        self.section = section
        self.instructor = instructor

    def get_dictionary(self):
        section_dictionary = OrderedDict([
            ("section_id", self.sec_id),
            ("course", self.course),
            ("degree", self.degree),
            ("semester", self.semester),
            ("section", self.section),
            ("instructor", self.instructor)
        ])

        return section_dictionary

    def get_sec_id(self):
        return self.sec_id

    def get_course(self):
        return self.course

    def get_degree(self):
        return self.degree

    def getSemester(self):
        return self.semester

    def getSection(self):
        return self.section
