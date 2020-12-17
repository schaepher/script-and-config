#!/usr/bin/python
# -*- coding: UTF-8 -*-

import http.client
import re
import html
import sys
import os

# 使用方式：
# ./download-github-code.py https://github.com/redis/redis/blob/unstable/src/pqsort.c

url = sys.argv[1]
filename = os.path.basename(url)

conn = http.client.HTTPSConnection("github.com")
conn.request('GET', url[18:])
text = conn.getresponse().read().decode("utf-8")

text = re.search("<table.+?>.+?</table>", text, re.S).group(0)
text = html.unescape(text)
lines = re.findall("<td id=\"LC\d+\".+", text)

fo = open(filename, "w")
for line in lines:
    line = re.sub("<.+?>", "", line)
    fo.write(line + "\n")
fo.close()
