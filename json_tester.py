import json

with open ('json_rss_feed.json', 'r') as file:
    rss_dict = json.load(file)

print(rss_dict)