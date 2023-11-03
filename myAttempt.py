from typing import Any


class Bird:
    pass


class FlyingBird:
    pass


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
