def print_function_info(func): 
    count = 0 
    def wrapper_func(should_count=False):
        def wrapper(*args, **kwargs): 
            if should_count: 
                nonlocal count 
                count += 1 
                print(f'Function was called {count} times') 
            print(f'Calling function {func} with args: {args} and kwargs: {kwargs}') 
            return func(*args, **kwargs) 
        return wrapper 
    return wrapper_func 

@print_function_info()
def summ(a,b):
    return a + b


# def print_function_info(should_count=False): 
#     count = 0 
#     def wrapper_func(func):
#         def wrapper(*args, **kwargs): 
#             if should_count: 
#                 nonlocal count 
#                 count += 1 
#                 print(f'Function was called {count} times') 
#             print(f'Calling function {func} with args: {args} and kwargs: {kwargs}') 
#             return func(*args, **kwargs) 
#         return wrapper 
#     return wrapper_func

# @print_function_info
# def summ(a,b):
#     return a + b