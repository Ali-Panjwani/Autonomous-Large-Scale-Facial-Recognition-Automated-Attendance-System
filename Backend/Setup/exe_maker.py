import subprocess

# Set the path to your source file and directory
src_file = "E:/Repository/FYP/Backend/Setup/Setup.py"

# Set the path to the destination directory
dst_dir = "C:/Users/ALI/Desktop"

# Construct the PyInstaller command
pyinstaller_command = [
    "pyinstaller",
    "--name=dev_env",
    "--onefile",
    "--distpath=" + dst_dir,
    src_file
]

# Run the PyInstaller command using subprocess
subprocess.run(pyinstaller_command)
