import os
from pathlib import Path

class Cd:

    def __init__(self, init_path:str) -> None:
        self.init_path = Path(init_path)
        self.location = Path.cwd()
        self.path = Path(self.location).joinpath(self.init_path)

    def __enter__(self):
        print(self.path)
        if self.path.is_dir():
            os.chdir(str(self.path.absolute()))
        else:
            raise ValueError ('No such directory')
        
    def __exit__(self, exc_type, exc_value, exc_traceback):
        os.chdir(str(self.location.absolute()))


with Cd('/Users/ivanr/OneDrive/Рабочий стол/SW Courses/GitHub/Test-Repository/testDir'):
    with open('testDoc.txt', 'r') as f:
        print(f.read())

# with Cd(r"C:\Users\ivanr\OneDriv\Рабочий стол\Other's"):
#     with open('testDoc.txt', 'r') as f:
#         print(f.read())