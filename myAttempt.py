from typing import Any


class Bird:
    def __init__(self, name) -> None:
        self.name = name
    
    def __str__(self) -> str:
        return f'{self.name} can walk and fly'

    def fly(self):
        return f'{self.name} can fly'

    def walk(self):
        return f'{self.name} can walk'




class FlyingBird(Bird):
    def __init__(self, name, ration = 'grains') -> None:
        super().__init__(name)
        self.ration = ration

    def eat(self):
        return f"{self.name} eats mostly {self.ration}"




class NonFlyingBird(Bird):

    def __init__(self, name, ration = 'grains') -> None:
        super().__init__(name)
        self.ration = ration

    def __str__(self) -> str:
        return f'{self.name} can walk and swim'
    
    def swim(self):
        return f'{self.name} can swim'
    
    def fly(self):
        raise AttributeError (f"{self.name} object has no attribute 'fly'")

    def eat(self):
        return f"{self.name} eats mostly {self.ration}"




class SuperBird(FlyingBird, NonFlyingBird):
    
    def __init__(self, name, ration='grains') -> None:
        super().__init__(name, ration)
    
    def __str__(self) -> str:
        return f'{self.name} can walk, swim and fly'
    

b = Bird('Any')
print(b.walk())
print(str(b))

p = NonFlyingBird('Penguin', 'fish')
print(p.swim())
# print(p.fly()) #AttributeError
print(p.eat())

c = FlyingBird('Cannary')
print(str(c))
print(c.eat())

s = SuperBird('Gull')
print(str(s))
print(s.eat())