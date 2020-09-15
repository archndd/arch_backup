from bs4 import BeautifulSoup
from mutagen.easyid3 import EasyID3
from csv import reader
from urllib.parse import quote
import youtube_dl
import os, sys
import time
import argparse
import requests

# TODO Delete song that not in the list

# TODO error handle 

# TODO Add command to play song

class Downloader():
    def __init__(self, sdir, log_file, force_download):
        self.sdir = sdir
        self.log_file = log_file
        self.force_download = force_download
        self.slink = ''
        self.dlink = ''

    def manage(self, song_name, pos):
        self.name = [i.strip() for i in song_name.split('-')]
        self.song_name = "{} - {}.mp3".format(self.name[1], self.name[0])
        self.song_path = os.path.join(self.sdir, self.song_name)
        self.pos = pos - 1

    def change_metadata(self):
        audio = EasyID3(self.song_path)
        audio['title'] = self.name[0]
        audio['artist'] = self.name[1]
        audio.save()

    def write_log(self, error=''):
        ast = time.asctime()
        template = f"[{ast}] {self.song_name}\n[Searching link]: {self.slink}\n[Downloading link]: {self.dlink}\n{error}\n"
        self.log_file.write(template)


class DefaultDownloader(Downloader):
    def __init__(self, sdir, log_file, force_download=False):
        super().__init__(sdir, log_file, force_download)

    def manage(self, song_name, pos=1):
        super().manage(song_name, pos)
        song_list.append(self.song_path)

        if self.force_download or not os.path.isfile(self.song_path):
            self.get_song_link()
            self.get_download_link()
            self.download()
            self.change_metadata()
            self.write_log()

    def get_song_link(self):
        searching_link = "https://chiasenhac.vn/tim-kiem?q={}".format(quote(' '.join(self.name)))
        soup = BeautifulSoup(requests.get(searching_link).text, "html.parser")

        self.slink = soup.select("a.search_title.search-line-music")[self.pos].get('href')

    def get_download_link(self):
        soup = BeautifulSoup(requests.get(self.slink).text, "html.parser")
        download_links = soup.select("a.download_item")
        self.dlink = download_links[1].get('href')
        if "mp3" not in self.dlink:
            self.dlink = download_links[0].get('href')
    
    def download(self):
        print('\033[1;33m' + self.song_name + '\033[0m')
        ### os.system("wget -O \"{}\" {} 1>/dev/null 2>&1".format(self.song_path, self.dlink))
        os.system("wget -O \"{}\" {}".format(self.song_path, self.dlink))


class YoutubeDownloader(Downloader):
    ydl_opts = {
        'format': 'bestaudio/best',
        'outtmpl': '',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '320',
        }],
    }

    def __init__(self, sdir, log_file, force_download=False):
        super().__init__(sdir, log_file, force_download)

    def manage(self, song_name, pos=1):
        super().manage(song_name, pos)
        song_list.append(self.song_path)

        if self.force_download or not os.path.isfile(self.song_path):
            self.get_youtube_link()
            self.download()
            self.change_metadata()
            self.write_log()
    
    def get_youtube_link(self):
        searching_link = "https://youtube.com/results?search_query={}".format(quote(' '.join(self.name)))
        self.slink = searching_link
        soup = BeautifulSoup(requests.get(searching_link).text, "html.parser").select(".yt-uix-tile-link")
        i = 0
        for video in soup:
            if video["href"].startswith("/watch?v="):
                if i < self.pos:
                    i += 1
                else:
                    self.dlink = "https://youtube.com/{}".format(video["href"])
                    break
    
    def download(self):
        self.ydl_opts['outtmpl'] = self.song_path[:-4] + '.%(ext)s'

        print('\033[1;33m' + self.song_name + '\033[0m')
        with youtube_dl.YoutubeDL(self.ydl_opts) as ydl:
            ydl.download([self.dlink])


def download_song(song_name, tag, pos):
    if not tag:
        default_downloader.manage(song_name, pos)
    elif tag == 'y':
        youtube_downloader.manage(song_name, pos)

def delete_song(song_dir, song_list):
    for file in os.listdir(song_dir):
        if file.endswith(".mp3"):
            file_path = os.path.join(song_dir, file)
            if file_path not in song_list:
                os.remove(file_path)
                print('\033[1;36m' + "Delete {}".format(os.path.basename(file_path)) + '\033[1;36m')

song_list = []
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A small script to download songs")
    ### parser.add_argument("--song-dir", default=os.path.join(os.environ['HOME'], 'Music'), help="provide download directory (default: ~/Music")
    parser.add_argument("--song-dir", default=os.path.join(os.getcwd(), 'Music'), help="provide download directory (default: ~/Music")
    parser.add_argument("-r", action="store_true")
    my_parse = parser.parse_args()

    if os.path.exists("log"):
        log_file = open("log", 'a')
    else:
        log_file = open("log", 'w')

    default_downloader = DefaultDownloader(my_parse.song_dir, log_file, my_parse.r)
    youtube_downloader = YoutubeDownloader(my_parse.song_dir, log_file, my_parse.r)
    with open("song_list") as file:
        csv_reader = reader(file, delimiter=',')
        for s in csv_reader:
            if s and (not s[0].startswith('#')):
                pos = 1
                if s[2]:
                    pos = int(s[2])
                download_song(s[0], s[1], pos)
    delete_song(my_parse.song_dir, song_list)
