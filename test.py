data = ["flower", "flows"]


res_prefix = data.pop()[0]
for value in data:
    for elem_val in value:
        for elem_res in res_prefix:
            if elem_val == elem_res:
                pass


# print(data[0][0])