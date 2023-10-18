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
        if split_counter == maxsplit:
            data_unif += item
            continue
        if flags == []:
            add_data_unif = True
        if True in flags and i != len(sep):
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

def startSpaceCutter(data: str):
    """
    Cuts spaces in the beginning of the string
    """
    # if data[0] != ' ':   # errors on the empty string (assert 1 split('')) IndexError: string index out of range
    #     return data
    if data == '' or data[0] != ' ':
        return data
    cutted_string = ''
    notSpace_flag = False
    for item in data:
        if data[0] == ' ' and notSpace_flag == False:
            if item != ' ':
                notSpace_flag = True
                cutted_string += item
        else:
            cutted_string += item
    return cutted_string

def data_res_Appender(input: str, output: str, iter_item: str, iter_item_index: int, temp_items_string: str ):
    """
    Adds temporary string to output list and returns empty temporary string
    """
    if iter_item_index < len(input) - 1:
        temp_items_string += iter_item
    else:
        temp_items_string += iter_item
        output.append(startSpaceCutter(temp_items_string))
        temp_items_string = ''
    return temp_items_string

def split(data: str, sep=None, maxsplit=-1):
    data_res = []
    temp_str = ''
    split_counter = 0
    item_index = -1
    data = startSpaceCutter(data)
    flag_unif = False
    if sep == None:
        sep = ' '
    if len(sep) != 1 and maxsplit != 0:
        data_sep_unif = separatorUnificator(data, sep, maxsplit)
        data = data_sep_unif[0]
        sep = data_sep_unif[1]
        flag_unif = True
    for item in data:
        item_index += 1
        if split_counter == maxsplit:
            temp_str = data_res_Appender(data, data_res, item, item_index, temp_str)
        if split_counter != maxsplit:
            if item == sep:
                if data[item_index - 1] == item and item_index != 0 and flag_unif == False:
                    pass
                else:
                    data_res.append(temp_str)
                    split_counter += 1
                    temp_str = ''
                    if item_index == len(data) - 1:
                        data_res.append(temp_str)
            else:
                temp_str = data_res_Appender(data, data_res, item, item_index, temp_str)
    return data_res




if __name__ == '__main__':
    assert split('') == []
    assert split(',123,', sep=',') == ['', '123', '']
    assert split('test') == ['test']
    assert split('Python    2     3', maxsplit=1) == ['Python', '2     3']
    assert split('    test     6    7', maxsplit=1) == ['test', '6    7']
    assert split('    Hi     8    9', maxsplit=0) == ['Hi     8    9']
    assert split('    set   3     4') == ['set', '3', '4']
    assert split('set;:23', sep=';:', maxsplit=0) == ['set;:23']
    assert split('set;:;:23', sep=';:', maxsplit=2) == ['set', '', '23']

# print(f"{split('Python    2     3', maxsplit=1)} == ['Python', '2     3']")
# print(split(''))
