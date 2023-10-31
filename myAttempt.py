from typing import Union


def divide(str_with_ints: str) -> Union[float, str]:
    try:
        temp_str = ''
        int_string = '1234567890'
        list_of_ints = []
        for item in str_with_ints:
            if item != ' ':
                if item not in int_string:
                    raise ValueError
                temp_str += item
            if temp_str and item == ' ':    
                list_of_ints.append(int(temp_str))
                temp_str = ''
        if temp_str:
            list_of_ints.append(int(temp_str))    
        
        if len(list_of_ints) > 2:
            raise IndexError

        return int(list_of_ints[0]) / int(list_of_ints[1])
    
    except ValueError:
        print(f"Error: invalid literal for int() with base 10: '{item}'")
    except ZeroDivisionError:
        print('Error code: division by zero')
    except IndexError:
        print('Error code: list index out of range')
    
s = '30  2 '

print(divide(s))