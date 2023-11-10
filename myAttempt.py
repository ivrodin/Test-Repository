from __future__ import annotations
from typing import Type


class Currency:
    rate_to_dollar = 1
    rate_to_pound = 1
    rate_to_euro = 1
    """
    1 EUR = 2 USD = 100 GBP

    1 EUR = 2 USD    ;  1 EUR = 100 GBP
    1 USD = 0.5 EUR  ;  1 USD = 50 GBP
    1 GBP = 0.02 USD ;  1 GBP = 0.01 EUR
    """

    def __init__(self, value: float):
        self.value = value

    @classmethod
    def course(cls, other_cls: Type[Currency]) -> str:
        if cls == Euro:
            if other_cls == Dollar:
                return '2.0 USD for 1 EUR'
            if other_cls == Pound:
                return '100.0 GBP for 1 EUR'
            else:
                return '1.0 EUR for 1 EUR'
        if cls == Dollar:
            if other_cls == Euro:
                return '0.5 EUR for 1 USD'
            if other_cls == Pound:
                return '50.0 GBP for 1 USD'
            else:
                return '1.0 USD for 1 USD'
        if cls == Pound:
            if other_cls == Euro:
                return '0.01 EUR for 1 GBP'
            if other_cls == Dollar:
                return '0.02 USD for 1 GBP'
            else:
                return '1.0 USD for 1 GBP'


    def to_currency(self, other_cls: Type[Currency]):
        if isinstance(self, Euro):
            rate = other_cls.rate_to_euro
        if isinstance(self, Dollar):
            rate = other_cls.rate_to_dollar
        if isinstance(self, Pound):
            rate = other_cls.rate_to_pound
        value = float(self.value / rate)
        return other_cls(value)
    
    def __add__(self, other_cls: Type[Currency]):
        if isinstance(self, Euro):
            converted_other_class = other_cls.to_currency(Euro)
        if isinstance(self, Dollar):
            converted_other_class = other_cls.to_currency(Dollar)
        if isinstance(self, Pound):
            converted_other_class = other_cls.to_currency(Pound)
        value = self.value + converted_other_class.value
        return self(value)




class Euro(Currency):
    rate_to_pound = 100
    rate_to_dollar = 50
    def __init__(self, value: float):
        super().__init__(value)
    
    def __repr__(self):
        return f"{self.value} EUR"




class Dollar(Currency):
    rate_to_pound = 50
    rate_to_euro = 0.5
    def __init__(self, value: float):
        super().__init__(value)

    def __repr__(self):
        return f"{self.value} USD"


class Pound(Currency):
    rate_to_euro = 0.01
    rate_to_dollar = 0.02
    def __init__(self, value: float):
        super().__init__(value)

    def __repr__(self):
        return f"{self.value} GBP"




e = Euro(100)
r = Pound(100)
d = Dollar(200)

print(
      f"Euro.course(Pound)   ==> {Euro.course(Pound)}\n"
      f"Dollar.course(Pound) ==> {Dollar.course(Pound)}\n"
      f"Pound.course(Euro)   ==> {Pound.course(Euro)}\n"
  )

print(
      f"e = {e}\n"
      f"e.to_currency(Dollar) = {e.to_currency(Dollar)}\n"
      f"e.to_currency(Pound) = {e.to_currency(Pound)}\n"
      f"e.to_currency(Euro)   = {e.to_currency(Euro)}\n"
  )
print(
      f"r = {r}\n"
      f"r.to_currency(Dollar) = {r.to_currency(Dollar)}\n"
      f"r.to_currency(Euro)   = {r.to_currency(Euro)}\n"
      f"r.to_currency(Pound) = {r.to_currency(Pound)}\n"
  )

print(
      f"e + r  =>  {e + r}\n"
      f"r + d  =>  {r + d}\n"
      f"d + e  =>  {d + e}\n"
  )
