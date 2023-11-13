import os
import shutil
import random

class TempDir:

    location = os.getcwd()
    temp_directory = 'temporary_directory_' + str(random.randint(0, 9))
    path = os.path.join(location, temp_directory)

    def __enter__(self):
        print('Entering __enter__')
        os.mkdir(self.path)
        os.chdir(self.path)
        return self.path


    def __exit__(self, exc_type, exc_value, exc_traceback):
        os.chdir(self.location)
        shutil.rmtree(self.path)


new_dir = 'TestInTest'

with TempDir() as f:
    os.mkdir(new_dir)






# location = os.getcwd()
# temp_directory = 'temporaryDirectory' + str(random.randint(1, 99999))
# path = os.path.join(location, temp_directory)
# os.mkdir(path)
# os.chdir(temp_directory)
# os.chdir(location)
# shutil.rmtree(path)

