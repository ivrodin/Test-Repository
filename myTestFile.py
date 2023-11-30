from argparse import ArgumentParser
from typing import List, Optional, Sequence
import requests

def parse_cli():
    parser = ArgumentParser(description='Pure Python command-line RSS reader.')
    parser.add_argument('url', type=str, metavar= 'source', help='RSS URL')
    parser.add_argument('--json', help='Print result as JSON in stdout', default= False, action= 'store_true')
    parser.add_argument('--limit', metavar= 'LIMIT', help= 'Limit news topics if this parameter is provided', action= 'store', nargs='?')

    args = parser.parse_args()


    # print(f'args: {args.__dict__}')
    # print(f'json data is: {args.json}\nlimit data is: {args.limit}')

    response = requests.get(args.url)
    # print(response)
    res_parse_dict = args.__dict__
    res_parse_dict['text_content'] = response.text

    return res_parse_dict

a = parse_cli()
print(a)


