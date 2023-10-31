from typing import List


class Counter:
    def __init__(self, values: List[int]):
        self.values = values
    
    def __add__(self, value):
        res_values = []
        for item in self.values:
            res_values.append(f"{str(item)} {value}")
        return res_values

s = Counter([1, 2, 3]) + "mississippi"
print(s)