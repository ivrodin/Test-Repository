from argparse import ArgumentParser
from typing import List, Optional, Sequence
from xml.etree import ElementTree as ET
import sys
from datetime import datetime
import requests

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
    rss_list = []
    rss_dict = {}
    channel_tags_outs_dict = {'title': 'Feed: ',
                                'link': 'Link: ',
                                'lastBuildDate': 'Last Build Date: ',
                                'pubDate': 'Published: ',
                                'language': 'Language: ',
                                'category': 'Categories: ',
                                'managinEditor': 'Editor: ',
                                'description': 'Description: '}
    item_tag_to_stdout_dict = {'title': 'Title: ',
                               'author': 'Author: ',
                               'pubDate': 'Published: ',
                               'link': 'Link: ',
                               'category': 'Categories: ',
                               'Description': ''}
    
    xml_root = ET.fromstring(xml)

    for channel_tag_key, channel_out_value in channel_tags_outs_dict.items():
        if channel_tag_key == 'category':
            xml_several_tags_appender(xml_root[0], rss_list, rss_dict, channel_tag_key, channel_out_value)
        else:
            xml_one_tag_appender(xml_root[0], rss_list, rss_dict, channel_tag_key, channel_out_value)
    
    items_list_of_dicts = item_parser(xml_root[0], item_tag_to_stdout_dict, rss_list, rss_dict, limit)

    if json is True:
        json_file_creator(rss_dict, items_list_of_dicts, limit)

    return rss_list

def json_file_creator(rss_tabs_dictionary, items_list_of_dictionaries, item_limit):
    item_counter = 0
    with open ('rss_json_parse.json', 'w', encoding= 'utf-8') as f:
        f.write('{\n')
        for channel_key, channel_value in rss_tabs_dictionary.items():
            if channel_key == 'items':
                f.write(f'\t"{channel_key}": [\n')
                for counter, elem in enumerate(channel_value):
                    f.write('\t\t{\n')
                    for item_key, item_value in elem.items():
                        item_counter += 1
                        if item_counter == len(items_list_of_dictionaries[0]):
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
                if item_limit == 0 and channel_key == 'description':
                    f.write(f'\t"{channel_key}": "{channel_value}"\n')
                else:
                    f.write(f'\t"{channel_key}": "{channel_value}",\n')
        f.write('}')

def item_parser(root, items_tags_outs_dict, parent_list, parent_dict, items_limit):
    channel_items = root.findall('item')
    if items_limit is None:
        items_limit == len(channel_items) - 1
    item_list_of_dicts = []
    for counter, current_item in enumerate(channel_items):
        item_dict = {}
        item_list = []
        parent_list.append('')
        for item_tag_key, item_out_value in items_tags_outs_dict.items():
            if item_tag_key == 'category':
                xml_several_tags_appender(current_item, item_list, item_dict, item_tag_key, item_out_value)
            else:
                xml_one_tag_appender(current_item, item_list, item_dict, item_tag_key, item_out_value)

        if counter == items_limit:
            break
        else:
            for elem in item_list:
                parent_list.append(elem)
            parent_dict['items'] = item_list_of_dicts
            item_list_of_dicts.append(item_dict)
    return item_list_of_dicts

def xml_one_tag_appender(root, req_list, req_dict, tag_name, list_appended_tag_name):
    try:
        tag_text = root.find(tag_name).text
        req_list.append(f'{list_appended_tag_name}{tag_text}')
        req_dict[tag_name] = tag_text
    except:
        pass

def xml_several_tags_appender(root, req_list, req_dict, tag_name, list_appended_tag_name):
    try: 
        tag_list = root.findall(tag_name).text
        if tag_list == []:
            tag_list = None
        else:
            req_list.append(f'{list_appended_tag_name}{tag_list}')
            req_dict[tag_name] = tag_list
    except:
        pass

parsed_rss_list = rss_parser(rss_txt_string, 1, True)

print('\nReturned List: \n')
print(parsed_rss_list)
print('\nJoined List: \n')
print("\n".join(parsed_rss_list))