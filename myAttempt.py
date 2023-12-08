# You shouldn't change  name of function or their arguments
# but you can change content of the initial functions.
from argparse import ArgumentParser
from typing import List, Optional, Sequence
from xml.etree import ElementTree as ET
import sys
from datetime import datetime
import requests


class UnhandledException(Exception):
    pass


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
        json_file_creator(rss_dict, items_list_of_dicts)

    return rss_list

def json_file_creator(rss_tabs_dictionary, items_list_of_dictionaries):
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
        parent_list.append('\n')
        for item_tag_key, item_out_value in items_tags_outs_dict.items():
            if item_tag_key == 'category':
                xml_several_tags_appender(current_item, item_list, item_dict, item_tag_key, item_out_value)
            else:
                xml_one_tag_appender(current_item, item_list, item_dict, item_tag_key, item_out_value)
        item_list_of_dicts.append(item_dict)

        if counter == items_limit:
            break
        else:
            for elem in item_list:
                parent_list.append(elem)
            parent_dict['items'] = item_list_of_dicts
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

def main(argv: Optional[Sequence] = None):
    """
    The main function of your task.
    """
    parser = ArgumentParser(
        prog="rss_reader",
        description="Pure Python command-line RSS reader.",
    )
    parser.add_argument("source", help="RSS URL", type=str, nargs="?")
    parser.add_argument(
        "--json", help="Print result as JSON in stdout", action="store_true"
    )
    parser.add_argument(
        "--limit", help="Limit news topics if this parameter provided", type=int
    )

    args = parser.parse_args(argv)
    xml = requests.get(args.source).text
    try:
        print("\n".join(rss_parser(xml, args.limit, args.json)))
        return 0
    except Exception as e:
        raise UnhandledException(e)


if __name__ == "__main__":
    main()
