from typing import Any


class Bird:
    def __init__(self, name) -> None:
        self.name = name
    
    def __call__(self, *args: Any, **kwds: Any) -> Any:
        print(f'{self.name} can fly and walk')

    def fly(self):
        print(f'{self.name} can fly')

    def walk(self):
        print(f'{self.name} can walk')


class FlyingBird(Bird):
    def __init__(self, name, ration = 'grains') -> None:
        self.name = name
        self.ration = ration

    def eat(self):
        print(f"{self.name} eats mostly {self.ration}")


class NonFlyingBird:
    def __init__(self, name, ration = 'grains') -> None:
        self.name = name
        self.ration = ration

    def eat(self):
        print(f"{self.name} eats mostly {self.ration}")


class SuperBird:
    def __init__(self, name, ration = 'grains') -> None:
        self.name = name
        self.ration = ration

    def eat(self):
        print(f"{self.name} eats mostly {self.ration}")
