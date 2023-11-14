import os
import shutil
import random

class TempDir:

    location = os.getcwd()
    temp_directory = 'temporary_directory_' + str(random.randint(0, 9))
    path = os.path.join(location, temp_directory)

    def __enter__(self):
        os.mkdir(self.path)
        os.chdir(self.path)
        return self.path


    def __exit__(self, exc_type, exc_value, exc_traceback):
        os.chdir(self.location)
        shutil.rmtree(self.path)