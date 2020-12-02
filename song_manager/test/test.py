import os
import shutil


def copy(from_dir, end_dir):
    end_dir_file = os.listdir(end_dir)
    for file in os.listdir(from_dir):
        file_path = os.path.join(from_dir, file)
        if file not in end_dir_file:
            shutil.copyfile(file_path, os.path.join(end_dir, file))

copy("/home/duy/py_prac", "/home/duy/abc")
