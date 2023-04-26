from Backend.Endpoints import Attendance_app


def run_att_app():
    Attendance_app.run(port=5000)


def stop_att_app():
    Attendance_app.stop()


run_att_app()
