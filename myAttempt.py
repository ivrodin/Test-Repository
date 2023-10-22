from collections import deque

class HistoryDict:
    def __init__(self , dict) -> None:
        self.list_of_dict = []
        self.list_history = deque([])
        self.list_of_dict.append(dict)
    
    def set_value(self, key, value):
        self.list_of_dict.append({key:value})
        deq_len = len(self.list_history)
        if deq_len <= 4:
            self.list_history.append(key)
        else:
            self.list_history.popleft()
            self.list_history.append(key)
    
    def get_history(self):
        print(list(self.list_history))
        return(list(self.list_history))

a = HistoryDict({'foo':30})

a.set_value('№1', 35)
a.set_value('№2', 11)
a.set_value('№3', 12)
a.set_value('№4', 65)
a.set_value('№5', 43)
a.set_value('№6', 40)
a.set_value('№7', 40)
a.get_history()

print(a.list_history)