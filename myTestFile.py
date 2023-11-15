from collections import OrderedDict

class Cipher:

    natural_alphabet = 'abcdefghijklmnopqrstuvwxyz'

    def __init__(self, key) -> None:
        self.key = ''.join(OrderedDict.fromkeys(key))
        self.natural_alphabet_dict = self.alphabet_dictionarization(self.natural_alphabet)
        self.encripted_alphabet = self.alphabet_encription()
        self.encripted_alphabet_dict = self.alphabet_dictionarization(self.encripted_alphabet)


        # print(self.key)
        print(self.natural_alphabet_dict)
        print(self.encripted_alphabet_dict)
        # print(self.encripted_alphabet)
        # print(self.natural_alphabet)
        # print(self.encripted_alphabet)
        # print(len(self.encripted_alphabet) == len(self.natural_alphabet))

    def alphabet_encription(self): 
        _alphabet_copy = self.natural_alphabet
        for key_elem in self.key:
            for alph_elem in _alphabet_copy:
                if key_elem == alph_elem:
                    _alphabet_copy = _alphabet_copy.replace(alph_elem, '')
        return self.key + _alphabet_copy

    def alphabet_dictionarization(self, alphabet):
        alphabet_dict = {}
        for key, val in enumerate(alphabet):
            alphabet_dict[key] = val
        return alphabet_dict
    
    def encode(self, data):
        pass


a = Cipher('proto')















# natural_alph = 'abcdefghijklmnopqrstuvwxyz'

# key = 'banana'

# clean_key = key_duplicates_removal(key)

# print(clean_key)

# encr_alph = aplhabet_encription(clean_key, natural_alph)

# print(encr_alph)

# print(len(natural_alph) == len(encr_alph))




# natural_alph = 'protabcdefghijklmnqsuvwxyz'

# nat_alph_dict = {}
# for val, key in enumerate(natural_alph):
#     nat_alph_dict[key] = val

# print(nat_alph_dict)








