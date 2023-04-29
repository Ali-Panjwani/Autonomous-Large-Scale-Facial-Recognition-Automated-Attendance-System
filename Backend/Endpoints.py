import json
from flask import Flask, request
from collections import OrderedDict
import Backend.reasonCodeAndMessages as rcm
from Backend.Attendance_Application.GetStudentsBySectionFile import getStudentsBySectionFunction
from Backend.Student_Application.GetStudentInfo import getStudentInfoFunction

Attendance_app = Flask(__name__)
Student_app = Flask(__name__)
Admin_app = Flask(__name__)


@Attendance_app.route("/")
def attendanceAppRunning():
    response = OrderedDict()
    response[rcm.reason_code] = rcm.success_code
    response[rcm.reason_message] = rcm.success_message
    response[rcm.app] = rcm.att_app
    response[rcm.status] = rcm.running
    response = json.dumps(response, sort_keys=False)
    return response, {"Content-Type": "application/json"}


@Student_app.route("/")
def studentAppRunning():
    response = OrderedDict()
    response[rcm.reason_code] = rcm.success_code
    response[rcm.reason_message] = rcm.success_message
    response[rcm.app] = rcm.student_app
    response[rcm.status] = rcm.running
    response = json.dumps(response, sort_keys=False)
    return response, {"Content-Type": "application/json"}


@Admin_app.route("/")
def adminAppRunning():
    response = OrderedDict()
    response[rcm.reason_code] = rcm.success_code
    response[rcm.reason_message] = rcm.success_message
    response[rcm.app] = rcm.admin_app
    response[rcm.status] = rcm.running
    response = json.dumps(response, sort_keys=False)
    return response, {"Content-Type": "application/json"}


@Attendance_app.route(
    '/getStudentsBySection',
    methods=['GET'])
def getStudentsBySection():
    course_arg = request.args.get('course')
    degree_arg = request.args.get('degree')
    semester_arg = request.args.get('semester')
    section_arg = request.args.get('section')
    return getStudentsBySectionFunction(course_arg, degree_arg, semester_arg, section_arg)


@Student_app.route(
    '/getStudentInfo',
    methods=['GET'])
def getStudentInfo():
    roll_number_args = request.args.get('rollNumber')
    password_args = request.args.get('password')
    return getStudentInfoFunction(roll_number_args, password_args), {"Content-Type": "application/json"}
