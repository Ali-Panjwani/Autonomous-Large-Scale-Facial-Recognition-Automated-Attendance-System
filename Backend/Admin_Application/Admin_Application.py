from Backend.Endpoints import Admin_app


def run_admin_app():
    Admin_app.run(port=5002)


def stop_admin_app():
    Admin_app.stop()


run_admin_app()
