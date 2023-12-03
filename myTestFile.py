from argparse import ArgumentParser
from typing import List, Optional, Sequence
from xml.etree import ElementTree as ET
import sys
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

    with open ('my_rss_feed.xml', 'w') as f:
        f.write(response.text)

    return res_parse_dict

# a = parse_cli()

def tab_content(start_tab, data, tabs_num = -1):
    '''
    Returns list of contents iside <tab> in provided data (<tab> number - optional)
    TODO: Redo with end </item>
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

rss_string = '''<?xml version="1.0" encoding="UTF-8"?><rss xmlns:media="http://search.yahoo.com/mrss/" version="2.0">
<channel>
<title>Yahoo News - Latest News &amp; Headlines</title>
<link>https://www.yahoo.com/news</link>
<description>The latest news and headlines from Yahoo! News. Get breaking news stories and in-depth coverage with videos and photos.</description>
<language>en-US</language>
<copyright>Copyright (c) 2023 Yahoo! Inc. All rights reserved</copyright>
<pubDate>Sun, 03 Dec 2023 15:53:26 -0500</pubDate>
<ttl>5</ttl>
<image>
<title>Yahoo News - Latest News &amp; Headlines</title>
<link>https://www.yahoo.com/news</link>
<url>http://l.yimg.com/rz/d/yahoo_news_en-US_s_f_p_168x21_news.png</url>
</image>
<item>
<title>Homebuyer conundrum: If mortgage rates fall, bidding wars will follow, expert says</title>
<link>https://finance.yahoo.com/news/homebuyer-conundrum-if-mortgage-rates-fall-bidding-wars-will-follow-expert-says-140737858.html</link>
<pubDate>2023-12-03T14:07:37Z</pubDate>
<source url="http://finance.yahoo.com/">Yahoo Finance</source>
<guid isPermaLink="false">homebuyer-conundrum-if-mortgage-rates-fall-bidding-wars-will-follow-expert-says-140737858.html</guid>
<media:content height="86" url="https://s.yimg.com/os/creatr-uploaded-images/2023-09/6398cf80-5406-11ee-b3ff-9bc8ee8a925f" width="130"/>
<media:credit role="publishing company"/>
</item>
<item>
<title>�So many yoga gurus try to have sex with female followers � I�m amazed women still fall for it�</title>
<link>https://news.yahoo.com/many-yoga-gurus-try-sex-110000318.html</link>
<pubDate>2023-12-02T11:00:00Z</pubDate>
<source url="http://www.telegraph.co.uk/">The Telegraph</source>
<guid isPermaLink="false">many-yoga-gurus-try-sex-110000318.html</guid>
<media:content height="86" url="https://media.zenfs.com/en/the_telegraph_258/4d0ef16eb319aba776664f9f7cfe3990" width="130"/>
<media:credit role="publishing company"/>
</item>
<item>
<title>�This has gotta stop': This Cleveland man going through a divorce is spending $970/month to pay off his truck � and now his ex wants him to eat $15K more of debt. Dave Ramsey responds</title>
<link>https://finance.yahoo.com/news/gotta-stop-cleveland-man-going-110000961.html</link>
<pubDate>2023-12-03T11:00:00Z</pubDate>
<source url="https://moneywise.com/">Moneywise</source>
<guid isPermaLink="false">gotta-stop-cleveland-man-going-110000961.html</guid>
<media:content height="86" url="https://media.zenfs.com/en/moneywise_327/031a98d7257d9c57c436247decb19330" width="130"/>
<media:credit role="publishing company"/>
</item>
<item>
<title>An Israeli raced to confront Palestinian attackers. He was then killed by an Israeli soldier</title>
<link>https://news.yahoo.com/israeli-raced-confront-palestinian-attackers-173551862.html</link>
<pubDate>2023-12-03T17:35:51Z</pubDate>
<source url="https://apnews.com/">Associated Press</source>
<guid isPermaLink="false">israeli-raced-confront-palestinian-attackers-173551862.html</guid>
<media:content height="86" url="https://media.zenfs.com/en/ap.org/810f42c2f9c436f7f479bc621bef36cc" width="130"/>
<media:credit role="publishing company"/>
</item>
</channel>
</rss>
'''

# for x in myroot.iter('title'):
#     print(f'x.tag = {x.tag}, x.attrib = {x.attrib}, x.text = {x.text}\n')

def channel_stdout(root):
    '''
    TODO: Add all the other tabs
    '''
    for count, elem in enumerate(root.iter('title')):
        sys.stdout.write(f'Feed: {elem.text}\n')
        if count != 1:
            break

    for count, elem in enumerate(root.iter('link')):
        sys.stdout.write(f'Link: {elem.text}\n')
        if count != 1:
            break

    for count, elem in enumerate(root.iter('description')):
        sys.stdout.write(f'Description: {elem.text}\n')
        if count != 1:
            break

def items_stdout(root, count_limit = -1):
    '''
    TODO: Fix it
    '''
    for count, elem in enumerate(root.iter('title')):
        sys.stdout.write(f'\nTitle: {elem.text}\n')
        if count == count_limit:
            break

    for count, elem in enumerate(root.iter('pubDate')):
        sys.stdout.write(f'Published: {elem.text}\n')
        if count != count_limit:
            break

    for count, elem in enumerate(root.iter('link')):
        sys.stdout.write(f'Link: {elem.text}\n')
        if count != count_limit:
            break

    for count, elem in enumerate(root.iter('description')):
        sys.stdout.write(f'\n{elem.text}\n')
        if count != count_limit:
            break

myroot = ET.fromstring(rss_string)
channel_stdout(myroot)
items_stdout(myroot, 2)











