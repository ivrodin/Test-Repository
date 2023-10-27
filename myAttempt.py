class Pagination:
    def __init__(self, data, items_on_page):
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
        return len(self.data_list)

    def count_items_on_page(self, page_number):
        return len(self.data_list[page_number - 1])

    def find_page(self, data):
        result_pages = set()
        temp_str = ''
        temp_pages = set()
        i = 1
        for pg_count, item in enumerate(self.data_list):
            for char_item in item:
                temp_str += char_item
                if temp_str[0:i] == data[0:i]:
                    if temp_str != data:
                        i += 1
                        if char_item == item[len(item)-1]:
                            temp_pages.add(pg_count + 1)
                        continue
                    else:
                        if temp_pages != 0:
                            for page in temp_pages:
                                result_pages.add(page)
                            temp_pages.clear()
                        result_pages.add(pg_count + 1)
                        temp_str = ''
                else:
                    temp_str = char_item
                    i = 2
        return list(result_pages)
            

                    
                


    
    def display_page(self, page_number):
        pass

# a = Pagination('I wanna be your dog', 3)
# print(a.data_list)
# print(a.page_count())
# print(a.count_items_on_page(7))
# print(a.find_page('wanna'))

a = Pagination('wanna anna nana panar', 3)
print(a.data_list)
print(a.page_count())
print(a.count_items_on_page(7))
print(a.find_page('an'))