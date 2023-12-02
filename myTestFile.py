from argparse import ArgumentParser
from typing import List, Optional, Sequence
import requests

def parse_cli():
    parser = ArgumentParser(description='Pure Python command-line RSS reader.')
    parser.add_argument('url', type=str, metavar= 'source', help='RSS URL')
    parser.add_argument('--json', help='Print result as JSON in stdout', default= False, action= 'store_true')
    parser.add_argument('--limit', metavar= 'LIMIT', help= 'Limit news topics if this parameter is provided', action= 'store', nargs='?')

    args = parser.parse_args()

    response = requests.get(args.url)
    res_parse_dict = args.__dict__
    res_parse_dict['text_content'] = response.text

    
    with open ('my_rss_feed.txt', 'w') as f:
        f.write(response.text)

    return res_parse_dict

# a = parse_cli()

def item_formater(data):
    temp_str = ''
    formated_txt = ''
    appender_flag = False
    for elem in data:
        if appender_flag is True or  elem == '<':
            temp_str += elem
            appender_flag = True
            if elem == '>':
                appender_flag = False
                if temp_str == '<item>' or temp_str == '</item>':
                    formated_txt += '\n' + temp_str + '\n' + '\t'
                    temp_str = ''
            continue
        formated_txt += elem
    return formated_txt

my_text = '<item>hello</item><item>world<item></item><item>im alive</item>'

my_new_text = item_formater(my_text)

print(my_new_text)







