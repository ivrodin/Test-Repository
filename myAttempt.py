class PriceControl:
    """
    Descriptor which don't allow to set price
    less than 0 and more than 100 included.
    """
    def __init__(self) -> None:
        self.price = None

    def __set__(self, price):
        if 0 <= price >= 100:
            self.price = price
        else:
            raise ValueError('Price must be between 0 and 100')
    def __get__(self):
        return self.price
    def __delete__(self):
        del self.price

class NameControl:
    """
    Descriptor which don't allow to change field value after initialization.
    """
    def __init__(self) -> None:
        self.__name = None  
    def __set__(self, name: str):
        self.__name = name
    def __get__(self):
        return self.__name
    def __delete__(self):
        del self.__name


class Book:
    author = NameControl()
    name = NameControl()
    price = PriceControl()

    def __init__(self, author, name, price) -> None:
        self.author = author
        self.name = name
        self.price = price



b = Book("William Faulkner", "The Sound and the Fury", 12)
print(f"Author='{b.author}', Name='{b.name}', Price='{b.price}'")