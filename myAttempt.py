class Pagination:
    def __init__(self, data, items_on_page):
        self.data_list = []
        temp_str = ''
        count = 1
        for item in data:
            if count == items_on_page:
                temp_str += item
                self.data_list.append(temp_str)
                temp_str = ''
                count = 1
            else:
                temp_str += item
                count += 1
        if temp_str:
            self.data_list.append(temp_str)

    def page_count(self):
        print(len(self.data_list) - 1)
        return len(self.data_list) - 1

    def count_items_on_page(self, page_number):
        try:
            print(len(self.data_list[page_number - 1]))
            return len(self.data_list[page_number - 1])
        except:
            print('Exception: Invalid index. Page is missing.')


    def find_page(self, data):
        result_pages = set()
        temp_str = ''
        temp_pages = set()
        i = 1
        try:
            for pg_count, item in enumerate(self.data_list):
                for index, char_item in enumerate(item):
                    temp_str += char_item
                    if temp_str[0:i] == data[0:i]:
                        if temp_str != data:
                            i += 1
                            if index + 1 == len(item):
                                temp_pages.add(pg_count)
                            continue
                        else:
                            if temp_pages:
                                for page in temp_pages:
                                    result_pages.add(page)
                                temp_pages.clear()
                            result_pages.add(pg_count)
                            temp_str = ''
                    else:
                        temp_str = char_item
                        if char_item == data[0]:
                            temp_pages.add(pg_count)
                            continue
                        i = 2
                        temp_pages.clear()
            if result_pages:
                print(list(result_pages))
                return list(result_pages)
            else:
                raise Exception
        except:
            print(f'Exception: {data} is missing on the pages')

    
    def display_page(self, page_number):
        try:
            print(self.data_list[page_number])
            return self.data_list[page_number]
        except:
            print('Exception: Invalid index. Page is missing.')


# a = Pagination('I wanna be your dog', 3)
# print(a.data_list)
# print(a.page_count())
# print(a.count_items_on_page(7))
# print(a.find_page('wanna'))

a = Pagination('wanna anna nana pana', 3)
print(a.data_list)
a.page_count()
a.count_items_on_page(10)
a.find_page('nnapa')
a.display_page(10)