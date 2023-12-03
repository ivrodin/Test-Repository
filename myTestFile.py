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

def tab_content(start_tab, data, tabs_num = -1):
    '''
    Returns list of contents iside <tab> in provided data (<tab> number - optional)
    '''
    tab_str = ''
    end_tab = start_tab + start_tab[:1] + '/' + start_tab[1:]
    content_txt = ''
    content_lst = []
    appender_flag = False
    for elem in data:
        if appender_flag is True or elem == '<':
            tab_str += elem
            appender_flag = True
            if elem == '>':
                appender_flag = False
                if tab_str != start_tab and tab_str != end_tab:
                    tab_str = ''
        if tab_str == start_tab:
            content_txt += elem
        if tab_str == end_tab:
            content_lst.append(content_txt[1:])
            if len(content_lst) == tabs_num:
                break
            tab_str = ''
            content_txt = ''
            continue
    return content_lst

# my_text = '''<item>hello</item><link>www.hello.ru</link>
#             <item>world</item><link>www.world.ru</link>
#             <item>im alive</item><link>www.imalive.ru</link>'''

# print(tab_content('<item>', my_text))

with open ('my_rss_feed.txt', 'r') as f:
    my_feed = f.read()
    items_list = tab_content('<item>', my_feed, 2)

print(items_list)









