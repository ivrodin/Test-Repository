class Pagination:
    def __init__(self, data, items_on_page):
        self.data_list = []
        self.data = data
        temp_str = ''
        count = 1
        for item in self.data:
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

    @property
    def page_count(self):
        print(len(self.data_list) - 1)
        return len(self.data_list) - 1

    @property
    def item_count(self):
        print(len(self.data))
        return len(self.data)
    
    def count_items_on_page(self, page_number):
        if page_number < len(self.data_list) - 1 and page_number > len(self.data_list) - 1:
            return len(self.data_list[page_number])
        else:
            raise Exception('Invalid index. Page is missing.')

    @staticmethod
    def one_char_srch(data_list, srched_item):
        result_pages = set()
        for pg_count, item in enumerate(data_list):
            for char_item in item:
                if srched_item == char_item:
                    result_pages.add(pg_count)
        return list(result_pages)
    
    @staticmethod
    def several_char_srch(data_list, srched_str):
        result_pages = set()
        temp_str = ''
        temp_pages = set()
        i = 1
        for pg_count, item in enumerate(data_list):
            for index, char_item in enumerate(item):
                temp_str += char_item
                if len(srched_str) == 1 or temp_str[0:i] == srched_str[0:i]:
                    if temp_str != srched_str:
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
                    if char_item == srched_str[0]:
                        temp_pages.add(pg_count)
                        continue
                    i = 2
                    temp_pages.clear()
        return list(result_pages)

    def find_page(self, data):
        if len(data) == 1:
            result_pages = self.one_char_srch(self.data_list, data)
        else:
            result_pages = self.several_char_srch(self.data_list, data)

        if result_pages:
            print(list(result_pages))
            return list(result_pages)
        else:
            raise Exception (f'{data} is missing on the pages')

    def display_page(self, page_number):
        if page_number < len(self.data_list) - 1 and page_number > len(self.data_list) - 1:
            print(self.data_list[page_number])
            return self.data_list[page_number]
        else:
            raise Exception ('Invalid index. Page is missing.')


# a = Pagination('I wanna be your dog', 3)
# print(a.data_list)
# print(a.page_count())
# print(a.count_items_on_page(7))
# print(a.find_page('wanna'))

pages = Pagination('Your beautiful text', 5)
pages.item_count
# print(pages.data_list)
# # pages.count_items_on_page(3)
pages.find_page('e')




# a = Pagination('wanna anna nana pana', 3)
# print(a.data_list)
# a.page_count()
# a.count_items_on_page(10)
# a.find_page('nnapa')
# a.display_page(10)