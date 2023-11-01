class Bird:
    def __init__(self, name) -> None:
        self.name = name

    def fly(self):
        pass

    def walk(self):
        pass


class FlyingBird:
    def __init__(self, name, ration) -> None:
        self.name = name
        self.ration = ration
        


class NonFlyingBird:
    pass


class SuperBird:
    pass
