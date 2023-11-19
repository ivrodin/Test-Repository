from collections import OrderedDict

class Cipher:

    natural_alphabet = 'abcdefghijklmnopqrstuvwxyz'

    def __init__(self, key) -> None:
        self.key = ''.join(OrderedDict.fromkeys(key))
        self.natural_alphabet_dict = self.alphabet_dictionarization(self.natural_alphabet)
        self.encripted_alphabet = self.alphabet_encription()
        self.encripted_alphabet_dict = self.alphabet_dictionarization(self.encripted_alphabet)

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
    
    def encode(self, data: str):
        encoded_str = ''
        for elem in data:
            upper_flag = False
            if elem == ' ':
                encoded_str += elem
            if elem.isupper() is True:
                upper_flag = True
                elem = elem.lower()
            for nat_key,nat_value in self.natural_alphabet_dict.items():
                if elem == nat_value:
                    for enc_key,enc_value in self.encripted_alphabet_dict.items():
                        if upper_flag is True and nat_key == enc_key:
                            encoded_str += enc_value.upper()
                        elif nat_key == enc_key:
                            encoded_str += enc_value
        return encoded_str
    
    def decode(self, data:str):
        decoded_str = ''
        for elem in data:
            upper_flag = False
            if elem == ' ':
                decoded_str += elem
            if elem.isupper() is True:
                upper_flag = True
                elem = elem.lower()
            for encded_key,encded_value in self.encripted_alphabet_dict.items():
                if elem == encded_value:
                    for nat_key,nat_value in self.natural_alphabet_dict.items():
                        if upper_flag is True and encded_key == nat_key:
                            decoded_str += nat_value.upper()
                        elif encded_key == nat_key:
                            decoded_str += nat_value
        return decoded_str




a = Cipher('proto')

print(a.encode('I am coming for you'))

print(a.decode('E pi okiejc bkn yku'))













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








