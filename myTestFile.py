import os
import shutil
import random

class TempDir:

    location = os.getcwd()
    temp_directory = 'temporaryDirectory' + str(random.randint(1, 99999))
    path = os.path.join(location, temp_directory)

    def __enter__(self):
        os.mkdir(self.path)
        os.chdir(self.temp_directory)
        return self.temp_directory


    def __exit__(self, exc_type, exc_value, exc_traceback):
        os.chdir(self.location)
        shutil.rmtree(self.path)


new_dir = 'TestInTest'
new_path = os.path.join(os.getcwd(),new_dir)
with TempDir() as f:
    os.mkdir(new_path)






# location = os.getcwd()
# temp_directory = 'temporaryDirectory' + str(random.randint(1, 99999))
# path = os.path.join(location, temp_directory)
# os.mkdir(path)
# os.chdir(temp_directory)
# os.chdir(location)
# shutil.rmtree(path)

