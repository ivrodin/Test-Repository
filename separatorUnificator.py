from typing import List
import string

def separatorCreator(data: str):
    """
    Returns separator not contained in input string (data)
    """
    all_ascii = string.printable
    for item in all_ascii:
        if item not in data:
            return item

def separatorUnificator(data: str, sep: str, maxsplit: int):
    """
    Unificates n-symbolic separator to 1 symbol
    Returns list[data with unified separator, unified separator]
    """
    data_unif = ''
    temp_str = ''
    flags = []
    res = []
    add_data_unif = True
    i = 0
    counter = 0
    split_counter = 0
    sep_unif = separatorCreator(data)
    for item in data:
        if split_counter == maxsplit: # Если split_counter = maxsplit, то просто возвращаем исходную data
            return data
        if flags == []: # Флаги (True), которые добавляются в лист flags для отслеживания был ли предыдущий элемент тоже сепаратором
            add_data_unif = True # Если flags пустые, ставится подфлаг add_data_unif = True для
        if True in flags and i != len(sep): #
            i+=1
            if item == sep[i]:
                flags.append(True)
                temp_str += item
                if len(flags) == len(sep):
                    data_unif += sep_unif
                    temp_str = ''
                    flags = []
                    i = 0
                    counter += 1
                    split_counter += 1
                    continue
            elif item == sep[0]:
                i = 0
                data_unif += temp_str
                temp_str = ''
            else:
                flags = []
                data_unif += temp_str + item
                temp_str = ''
                i = 0         
        if item == sep[0] and flags == []:
            flags.append(True)
            temp_str += item
            add_data_unif = False
        if add_data_unif == True or counter == len(data) - 1:
            data_unif += item
        counter += 1
    res.append(data_unif)
    res.append(sep_unif)
    return res

print(separatorUnificator('123o3oo4oo3o1oo', 'oo', 3))