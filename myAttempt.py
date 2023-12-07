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

    for key_tag, out_value in channel_tag_to_stdout_dict:
        if key_tag == 'category' or key_tag == 'item':
            xml_several_tags_appender(xml_root, res_rss_list, dict_of_channel_tabs, key_tag, out_value)
        else:
            xml_one_tag_appender(xml_root, res_rss_list, dict_of_channel_tabs, key_tag, out_value)
        
def xml_one_tag_appender(root, req_list, req_dict, tag_name, list_appended_tag_name):
    try:
        tag_text = root[0].find(tag_name).text
        req_list.append(f'{list_appended_tag_name}: {tag_text}\n')
        req_dict[tag_name] = tag_text
    except:
        pass

def xml_several_tags_appender(root, req_list, req_dict, tag_name, list_appended_tag_name):
    try: 
        tag_texts_list = root[0].findall(tag_name)
        if tag_texts_list == []:
            tag_texts_list = None
        else:
            req_list.append(f'{list_appended_tag_name}: {tag_texts_list}\n')
            req_dict[tag_name] = tag_texts_list
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
