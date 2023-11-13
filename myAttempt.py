class PriceControl:
    """
    Descriptor which don't allow to set price
    less than 0 and more than 100 included.
    """
    def __set_name__(self, owner, name):
        self.name = '_' + name

    def __set__(self, instance, value):
        if value >= 0 and value <= 100:
            setattr(instance, self.name, value)
        else:
            raise ValueError('Price must be between 0 and 100')
    
    def __get__(self, instance, owner):
        return getattr(instance, self.name)

class NameControl:
    """
    Descriptor which don't allow to change field value after initialization.
    """

    def __set_name__(self, owner, name):
        self.name = '_' + name

    def __get__(self, instance, owner = None):
        return getattr(instance, self.name)
    
    def __set__(self, instance, value):
        if instance.__dict__.get(self.name, None) is None:
            setattr(instance, self.name, value)



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