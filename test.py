import subprocess

# Path to xampp_start.exe
xampp_start_path = "E:/UtilitySoftwares/xampp/xampp_start.exe"

# Arguments to start Apache and MySQL services
args = ['startapache', 'startmysql']

# Execute xampp_start.exe with arguments
subprocess.run([xampp_start_path] + args)
