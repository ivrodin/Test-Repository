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
        # raise NotImplementedError
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
                return '50 GBP for 1 USD'
            else:
                return '1.0 USD for 1 USD'
        if cls == Pound:
            if other_cls == Euro:
                return '0.01 EUR for 1 GBP'
            if other_cls == Dollar:
                return '0.5 USD for 1 GBP'
            else:
                return '1.0 USD for 1 GBP' #TODO: FIX POUND CURRENCY


    def to_currency(self, other_cls: Type[Currency]):
        if isinstance(self, Euro):
            rate = other_cls.rate_to_euro
        if isinstance(self, Dollar):
            rate = other_cls.rate_to_dollar
        if isinstance(self, Pound):
            rate = other_cls.rate_to_pound
        value = self.value * rate
        return other_cls(value)


class Euro(Currency):
    # rate_to_pound = 
    # rate_to_dollar = 
    def __init__(self, value: float):
        super().__init__(value)



class Dollar(Currency):
    # rate_to_pound = 
    # rate_to_euro = 
    def __init__(self, value: float):
        super().__init__(value)


class Pound(Currency):
    # rate_to_euro = 
    # rate_to_dollar = 
    def __init__(self, value: float):
        super().__init__(value)
