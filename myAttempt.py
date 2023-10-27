class Pagination:
    def __init__(self, data, items_on_page):
        # self.data = data
        # self.items_on_page = items_on_page
        self.data_list = []
        temp_str = ''
        count = 1
        for item in data:
            if count == items_on_page or item == data[len(data)-1]:
                temp_str += item
                self.data_list.append(temp_str)
                temp_str = ''
                count = 1
            else:
                temp_str += item
                count += 1

    def page_count(self):
        for res, item in enumerate(self.data_list):
            pass
        return res + 1

    def count_items_on_page(self, page_number):
        for res, item in enumerate(self.data_list[page_number - 1]):
            pass
        return res + 1

    def find_page(self, data):
        found_pages = []
        for char_data in data:
            for pg_count, item in enumerate(self.data_list):
                for char_item in item:
                    if char_data == char_item:
                        pass
                


    
    def display_page(self, page_number):
        pass

a = Pagination('I wanna be your dog', 3)
print(a.data_list)
print(a.page_count())
print(a.count_items_on_page(2))