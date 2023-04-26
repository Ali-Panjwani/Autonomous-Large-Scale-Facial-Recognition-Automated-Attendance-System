import subprocess
import time
import os
import msvcrt

os.chdir("E:/Repository/FYP/")


def start_xampp():
    print(" ")
    print("Starting xampp, apache, mysql")

    # Path to xampp_start.exe
    xampp_start_path = "E:/UtilitySoftwares/xampp/xampp_start.exe"

    # Arguments to start Apache and MySQL services
    xampp_start_args = ['startapache', 'startmysql']

    # Execute xampp_start.exe with arguments
    subprocess.run([xampp_start_path] + xampp_start_args)

    print("Started xampp, apache, mysql")
    print(" ")
    print("x----------x")


def start_postman():
    print(" ")
    print("Starting Postman")

    # Path to Postman.exe
    postman_path = "C:/Users/ALI/AppData/Local/Postman/Postman.exe"

    # Execute Postman.exe in the foreground
    postman_process = subprocess.Popen(postman_path)

    print("Started Postman")
    print(" ")
    print("x----------x")

    return postman_process.pid


def start_browser():
    print(" ")
    print("Starting Browser")
    # Path to Browser
    browser_path = "C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe"

    # Path to the localhost database
    database_link = "http://localhost/phpmyadmin/index.php?route=/database/structure&db=fyp_database"

    # Execute the link in Browser
    browser_process = subprocess.Popen([browser_path, database_link])

    print("Started Browser")
    print(" ")
    print("x----------x")

    return browser_process.pid


def start_stop_pycharm():
    print(" ")
    print("Starting PyCharm")

    # specify the path to the PyCharm executable
    pycharm_path = '"E:/JetBrains/PyCharm Community Edition 2022.3.3/bin/pycharm64.exe"'

    # specify the path to the folder to open
    folder_path = 'E:/Repository/FYP'

    # construct the command to open PyCharm to the folder
    command = '{} {}'.format(pycharm_path, folder_path)

    # run the command using subprocess
    pycharm_process = subprocess.Popen(command, shell=True)

    print("Started PyCharm")
    print(" ")
    print("x----------x")

    print(" ")
    print("Start Working")
    # loop until PyCharm is closed
    while True:
        # check if PyCharm is running
        if pycharm_process.poll() is not None:
            # PyCharm is not running, break out of the loop
            break
        # wait for a bit before checking again
        time.sleep(1)

    print("Ended Work")
    print(" ")
    print("x----------x")

    print(" ")
    print("Stopping PyCharm")
    print("Stopped PyCharm")
    print(" ")
    print("x----------x")


def kill_process(process_id):
    task_kill_path = "C:/Windows/System32/taskkill.exe"
    subprocess.call([task_kill_path, "/PID", str(process_id), "/T", "/F"])


def stop_browser(browser_pid):
    time.sleep(1)
    print(" ")
    print("Stopping Browser")

    # kill Brave process
    kill_process(browser_pid)

    print("Stopped Browser")
    print(" ")
    print("x----------x")
    time.sleep(1)


def stop_postman(postman_pid):
    time.sleep(1)
    print(" ")
    print("Stopping Postman")

    # kill Postman process
    kill_process(postman_pid)
    print("Stopped Postman")
    print(" ")
    print("x----------x")
    time.sleep(1)


def stop_xampp():
    time.sleep(1)
    print(" ")
    print("Stopping xampp, apache, mysql")

    # Path to xampp_stop.exe
    xampp_stop_path = "E:/UtilitySoftwares/xampp/xampp_stop.exe"

    # Arguments to start Apache and MySQL services
    xampp_stop_args = ['stopapache', 'stopmysql']

    # Execute xampp_start.exe with arguments
    subprocess.run([xampp_stop_path] + xampp_stop_args)

    print("Stopped xampp, apache, mysql")
    print(" ")
    print("x----------x")
    time.sleep(1)


def end():
    print("Exiting in 3 seconds .... ")
    time.sleep(3)


start_xampp()
browser = start_browser()
postman = start_postman()
start_stop_pycharm()
stop_postman(postman)
stop_browser(browser)
stop_xampp()
end()
