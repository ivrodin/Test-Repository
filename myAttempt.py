import os


class Cd:
    
    def __init__(self, init_path) -> None:
        self.init_path = init_path
        self.location = os.getcwd()

    def __enter__(self):
        try:
            os.chdir(self.init_path)
        except:
            raise ValueError ('No such directory')
        
    def __exit__(self, exc_type, exc_value, exc_traceback):
        os.chdir(self.location)


# with Cd(r"C:\Users\ivanr\OneDrive\Рабочий стол\Other's"):
#     with open('testDoc.txt', 'r') as f:
#         print(f.read())

with Cd(r"C:\Users\ivanr\OneDriv\Рабочий стол\Other's"):
    with open('testDoc.txt', 'r') as f:
        print(f.read())