from Backend.Endpoints import Student_app


def run_student_app():
    Student_app.run(port=5001)


def stop_student_app():
    Student_app.stop()


run_student_app()
