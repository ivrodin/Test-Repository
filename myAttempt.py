import os

class Cd:
    
    def __init__(self, init_path:str) -> None:
        self.init_path = init_path[1:]
        self.location = os.getcwd()
        self.path = os.path.join(self.location, self.init_path)

    def __enter__(self):
        print(self.path)
        print (os.path.isdir(self.path))
        if os.path.isdir(self.path):
            os.chdir(self.path)
        else:
            raise ValueError ('No such directory')
        
    def __exit__(self, exc_type, exc_value, exc_traceback):
        os.chdir(self.location)


with Cd('/testDir'):
    with open('testDoc.txt', 'r') as f:
        print(f.read())

# with Cd(r"C:\Users\ivanr\OneDriv\Рабочий стол\Other's"):
#     with open('testDoc.txt', 'r') as f:
#         print(f.read())