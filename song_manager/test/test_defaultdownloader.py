from bs4 import BeautifulSoup
from mutagen.easyid3 import EasyID3
from csv import reader
from urllib.parse import quote
import youtube_dl
import os, sys
import time
import argparse
import requests
import sys

name = "Mơ"
searching_link = "https://chiasenhac.vn/tim-kiem?q={}".format(quote(name))
soup = BeautifulSoup(requests.get(searching_link).text, "html.parser")
slink = soup.select("a.search_title.search-line-music")[0].get('href')
print(slink)

# with open("song_list") as file:
#     csv_reader = reader(file, delimiter=',')
#     for s in csv_reader:
#         name = [i.strip() for i in s[0].split(' - ')]
#         pos = 0
#         if s[2]:
#             pos = int(s[2])
# 
#         searching_link = "https://chiasenhac.vn/tim-kiem?q={}".format(quote(' '.join(name)))
#         soup = BeautifulSoup(requests.get(searching_link).text, "html.parser")
#         slink = soup.select("a.search_title.search-line-music")[pos].get('href')
#         searching_link2 = "https://chiasenhac.vn/tim-kiem?q={}".format(quote(name[0]))
#         soup2 = BeautifulSoup(requests.get(searching_link2).text, "html.parser")
#         slink2 = soup2.select("a.search_title.search-line-music")[pos].get('href')
# 
#         print(' - '.join(name))
#         print(slink)
#         print(slink2)
#         print()
#         assert slink == slink2
# 
