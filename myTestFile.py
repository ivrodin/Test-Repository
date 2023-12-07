from argparse import ArgumentParser
from typing import List, Optional, Sequence
from xml.etree import ElementTree as ET
import sys
from datetime import datetime
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


rss_txt_string = '''<?xml version="1.0" encoding="UTF-8"?><rss xmlns:media="http://search.yahoo.com/mrss/" version="2.0">
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

rss_url_string = 'https://news.yahoo.com/rss'

class Cmd_out:

    def __init__(self, rss_txt, rss_source_url) -> None:

        self.root = ET.fromstring(rss_txt)

        self.source_url = rss_source_url

        self.channel_title = None
        self.channel_link = None
        self.channel_lastBuildDate = None
        self.channel_pubDate = None
        self.channel_language = None
        self.channel_categories = None
        self.channel_managinEditor = None
        self.channel_description = None
        self.channel_items = None

        self.list_of_items_dicts = []
        self.dict_of_channel_tabs = {}


    def channel_stdout(self, number_of_items = -1):
        '''
        TODO: Add all the other tabs
        '''
        self.channel_title = self.root[0].find('title').text
        sys.stdout.write(f'Feed: {self.channel_title}\n')
        self.dict_of_channel_tabs['title'] = self.channel_title

        self.channel_link = self.root[0].find('link').text # not source_url
        sys.stdout.write(f'Link: {self.source_url}\n') # printed source_url
        self.dict_of_channel_tabs['link'] = self.channel_link


        try: 
            self.channel_lastBuildDate = self.root[0].find('lastBuildDate').text
            sys.stdout.write(f'lastBuildDate: {self.channel_lastBuildDate}\n')
            self.dict_of_channel_tabs['lastBuildDate'] = self.channel_lastBuildDate
        except:
            pass

        try: 
            self.channel_pubDate = self.root[0].find('pubDate').text
            sys.stdout.write(f'Published: {self.channel_pubDate}\n')
            self.dict_of_channel_tabs['pubDate'] = self.channel_pubDate
        except:
            pass

        try: 
            self.channel_language = self.root[0].find('language').text
            sys.stdout.write(f'Language: {self.channel_language}\n')
            self.dict_of_channel_tabs['language'] = self.channel_language
        except:
            pass
        
        try: 
            self.channel_categories = self.root[0].findall('category') #TODO: test later (add for loop)
            if self.channel_categories == []:
                self.channel_categories = None
            else:
                sys.stdout.write(f'Categories: {self.channel_categories}\n')
                self.dict_of_channel_tabs['categories'] = self.channel_categories
        except:
            pass

        try:
            self.channel_managinEditor = self.root[0].find('managinEditor').text
            sys.stdout.write(f'managinEditor: {self.channel_managinEditor}\n')
            self.dict_of_channel_tabs['managinEditor'] = self.channel_managinEditor
        except:
            pass

        self.channel_description = self.root[0].find('description').text
        sys.stdout.write(f'Description: {self.channel_description}\n\n')
        self.dict_of_channel_tabs['description'] = self.channel_description

        self.channel_items = self.root[0].findall('item')
        
        self.items_stdout(number_of_items)
        return self.dict_of_channel_tabs


    def items_stdout(self, items):

        for counter, current_item in enumerate(self.channel_items):
            item_dict = {}

            try:
                item_title = current_item.find('title').text
                sys.stdout.write(f'Title: {item_title}\n')
                item_dict['title'] = item_title
            except:
                pass

            try:    
                item_author = current_item.find('author').text
                sys.stdout.write(f'Author: {item_author}\n')
                item_dict['author'] = item_author
            except:
                pass

            try:    
                item_pubDate = current_item.find('pubDate').text #TODO: fix date format (maybe...)
                # a = '2023-12-03T14:07:37Z'
                # b = datetime.strptime(a, "%Y-%m-%dT%H:%M:%SZ")
                # date = b.strftime('%a, %d %b %Y, %H:%M:%S %z')
                sys.stdout.write(f'Published: {item_pubDate}\n')
                item_dict['pubDate'] = item_pubDate
            except:
                pass

            try:    
                item_link = current_item.find('link').text
                sys.stdout.write(f'Link: {item_link}\n')
                item_dict['link'] = item_link
            except:
                pass            

            try:    
                item_category = current_item.find('category').text
                sys.stdout.write(f'Category: {item_category}\n')
                item_dict['category'] = item_category
            except:
                pass

            try:    
                item_description = current_item.find('description').text
                sys.stdout.write(f'\n{item_description}\n')
                item_dict['description'] = item_description
            except:
                pass

            sys.stdout.write('\n')
            self.list_of_items_dicts.append(item_dict)
            counter += 1

            if counter == items:
                break 
        self.dict_of_channel_tabs['items'] = self.list_of_items_dicts

    def json_file_creator(self):
        item_counter = 0
        with open ('rss_json_parse.json', 'w', encoding= 'utf-8') as f:
            f.write('{\n')
            for channel_key, channel_value in self.dict_of_channel_tabs.items():
                if channel_key == 'items':
                    f.write(f'\t"{channel_key}": [\n')
                    for counter, elem in enumerate(channel_value):
                        f.write('\t\t{\n')
                        for item_key, item_value in elem.items():
                            item_counter += 1
                            if item_counter == len(self.list_of_items_dicts[0]):
                                f.write(f'\t\t\t"{item_key}": "{item_value}"\n')
                                item_counter = 0
                            else:
                                f.write(f'\t\t\t"{item_key}": "{item_value}",\n')
                        if counter == len(channel_value) - 1:
                            f.write('\t\t}\n')
                        else:
                            f.write('\t\t},\n')
                    f.write('\t]\n')
                else:
                    f.write(f'\t"{channel_key}": "{channel_value}",\n')
            f.write('}')









# Task Start


def rss_parser(
    xml: str,
    limit: Optional[int] = None,
    json: bool = False,
) -> List[str]:
    """
    RSS parser.

    Args:
        xml: XML document as a string.
        limit: Number of the news to return. if None, returns all news.
        json: If True, format output as JSON.

    Returns:
        List of strings.
        Which then can be printed to stdout or written to file as a separate lines.

    Examples:
        >>> xml = '<rss><channel><title>Some RSS Channel</title><link>https://some.rss.com</link><description>Some RSS Channel</description></channel></rss>'
        >>> rss_parser(xml)
        ["Feed: Some RSS Channel",
        "Link: https://some.rss.com"]
        >>> print("\\n".join(rss_parser(xmls)))
        Feed: Some RSS Channel
        Link: https://some.rss.com
    """
    res_rss_list = []
    dict_of_channel_tabs = {}
    channel_tag_to_stdout_dict = {'title': 'Feed',
                                  'link': 'Link',
                                  'lastBuildDate': 'lastBuildDate',
                                  'pubDate': 'Published',
                                  'language': 'Language',
                                  'category': 'Categories',
                                  'managinEditor': 'managinEditor',
                                  'description': 'Description',
                                  'item': 'Items'}
    xml_root = ET.fromstring(xml)

    for key_tag, out_value in channel_tag_to_stdout_dict.items():
        if key_tag == 'category' or key_tag == 'item':
            xml_several_tags_appender(xml_root, res_rss_list, dict_of_channel_tabs, key_tag, out_value)
        else:
            xml_one_tag_appender(xml_root, res_rss_list, dict_of_channel_tabs, key_tag, out_value)
    
    return res_rss_list

def xml_one_tag_appender(root, req_list, req_dict, tag_name, list_appended_tag_name):
    try:
        tag_text = root[0].find(tag_name).text
        req_list.append(f'{list_appended_tag_name}: {tag_text}')
        req_dict[tag_name] = tag_text
    except:
        pass

def xml_several_tags_appender(root, req_list, req_dict, tag_name, list_appended_tag_name):
    try: 
        tag_texts_list = root[0].findall(tag_name)
        if tag_texts_list == []:
            tag_texts_list = None
        else:
            req_list.append(f'{list_appended_tag_name}: {tag_texts_list}')
            req_dict[tag_name] = tag_texts_list
    except:
        pass

a = rss_parser(rss_txt_string)

print(a)