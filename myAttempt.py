from abc import ABC
# from abc import abstractmethod


class Vehicle(ABC):
    def __init__(
            self,
            brand_name: str,
            year_of_issue: int,
            base_price: int,
            mileage: int
    ):
        pass

    def wheels_num(self) -> int:
        return 0

    def vehicle_type(self) -> str:
        pass

    def is_motorcycle(self) -> bool:
        pass

    def purchase_price(self) -> float:
        pass


# Don't change class implementation
class Car(Vehicle):
    def wheels_num(self):
        return 4


# Don't change class implementation
class Motorcycle(Vehicle):
    def wheels_num(self):
        return 2


# Don't change class implementation
class Truck(Vehicle):
    def wheels_num(self):
        return 10


# Don't change class implementation
class Bus(Vehicle):
    def wheels_num(self):
        return 6
