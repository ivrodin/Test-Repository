from myAttempt import rss_parser

xml_file = """<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
  <channel>
    <title>Your Channel Title</title>
    <link>https://yourwebsite.com</link>
    <lastBuildDate>Tue, 23 Feb 2024 00:00:00 GMT</lastBuildDate>
    <pubDate>Tue, 23 Feb 2024 00:00:00 GMT</pubDate>
    <language>en-us</language>
    <managingEditor>editor@example.com (Editor Name)</managingEditor>
    <description>Description of your channel</description>
    <category>Category 1</category>
    <category>Category 2</category>
    <category>Category 3</category>

    <item>
      <title>Item 1 Title</title>
      <author>Author Name 1</author>
      <pubDate>Tue, 23 Feb 2024 00:00:00 GMT</pubDate>
      <link>https://yourwebsite.com/item1</link>
      <category>Item Category 1</category>
      <category>Item Category 2</category>
      <description>Description of Item 1</description>
    </item>
    
    <item>
      <title>Item 2 Title</title>
      <author>Author Name 2</author>
      <pubDate>Tue, 23 Feb 2024 00:00:00 GMT</pubDate>
      <link>https://yourwebsite.com/item2</link>
      <category>Item Category 2</category>
      <category>Item Category 3</category>
      <description>Description of Item 2</description>
    </item>
    
    <item>
      <title>Item 3 Title</title>
      <author>Author Name 3</author>
      <pubDate>Tue, 23 Feb 2024 00:00:00 GMT</pubDate>
      <link>https://yourwebsite.com/item3</link>
      <category>Item Category 1</category>
      <category>Item Category 3</category>
      <description>Description of Item 3</description>
    </item>
    
  </channel>
</rss>
"""


a = rss_parser(xml_file, limit=2)
print("\n".join(a))
