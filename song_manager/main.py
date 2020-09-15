from bs4 import BeautifulSoup
from mutagen.easyid3 import EasyID3
from csv import reader
from urllib.parse import quote
import youtube_dl
import os, sys
import time
import argparse
import requests

# TODO error handle 

class Downloader():
    def __init__(self, sdir, log_file, force_download):
        self.sdir = sdir
        self.log_file = log_file
        self.force_download = force_download
        self.slink = ''
        self.dlink = ''

    def process_song_name(self, song_name, pos=1):
        self.name = [i.strip() for i in song_name.strip().split(' - ')]
        self.song_name = "{artist} - {title}.mp3".format(artist=self.name[1], title=self.name[0])
        self.song_path = os.path.join(self.sdir, self.song_name)
        self.pos = pos - 1
        song_list.append(self.song_path)

    def change_metadata(self):
        audio = EasyID3(self.song_path)
        audio['title'] = self.name[0]
        audio['artist'] = self.name[1]
        audio.save()

    def write_log(self, error=''):
        timestamp = time.asctime()
        template = f"[{timestamp}] {self.song_name}\n[Searching link]: {self.slink}\n[Downloading link]: {self.dlink}\n{error}\n"
        self.log_file.write(template)


class DefaultDownloader(Downloader):
    def __init__(self, sdir, log_file, force_download=False):
        super().__init__(sdir, log_file, force_download)

    def manage(self, song_name, pos, search_by_title_only=False):
        super().process_song_name(song_name, pos)

        if self.force_download or not os.path.isfile(self.song_path):
            self.get_song_link(search_by_title_only)
            self.get_download_link()
            self.download()
            self.change_metadata()
            self.write_log()

    def manage_link(self, song_name, link):
        super().process_song_name(song_name)
        self.slink = link
        if self.force_download or not os.path.isfile(self.song_path):
            self.get_download_link()
            self.download()
            self.change_metadata()
            self.write_log()

    def get_song_link(self, search_by_title_only):
        if search_by_title_only is True:
            search_query = self.name[0]
        else:
            search_query = ' '.join(self.name)

        searching_link = "https://chiasenhac.vn/tim-kiem?q={}".format(quote(search_query))
        soup = BeautifulSoup(requests.get(searching_link).text, "html.parser")

        self.slink = soup.select("a.search_title.search-line-music")[self.pos].get('href')

    def get_download_link(self):
        soup = BeautifulSoup(requests.get(self.slink).text, "html.parser")
        download_links = soup.select("a.download_item")
        self.dlink = download_links[1].get('href')
        # In case there is no 320kbps
        if "mp3" not in self.dlink:
            self.dlink = download_links[0].get('href')
    
    def download(self):
        print('\033[1;33m' + self.song_name + '\033[0m')
        # os.system("wget -O \"{}\" {}".format(self.song_path, self.dlink))
        os.system("wget -O \"{}\" {} 1>/dev/null 2>&1".format(self.song_path, self.dlink))


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
        super().process_song_name(song_name, pos)

        if self.force_download or not os.path.isfile(self.song_path):
            self.get_youtube_link()
            self.download()
            self.change_metadata()
            self.write_log()
    
    def manage_link(self, song_name, link):
        super().process_song_name(song_name)
        self.dlink = link
        self.slink = ''
        if self.force_download or not os.path.isfile(self.song_path):
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
        # %(ext)s is the extension in ydl_opts 
        self.ydl_opts['outtmpl'] = self.song_path[:-4] + '.%(ext)s'

        print('\033[1;33m' + self.song_name + '\033[0m')
        with youtube_dl.YoutubeDL(self.ydl_opts) as ydl:
            try: 
                ydl.cache.remove()
                ydl.download([self.dlink])
            except youtube_dl.DownloadError as error:
                print("Error", error)


def download_song(song_name, tag, pos):
    if not tag:
        default_downloader.manage(song_name, pos)
    elif tag == 'dn':
        default_downloader.manage(song_name, pos, True)
    elif tag == 'y':
        youtube_downloader.manage(song_name, pos)
    elif tag == 'dl':
        default_downloader.manage_link(song_name, pos)
    elif tag == 'yl':
        youtube_downloader.manage_link(song_name, pos)

def delete_song(song_dir, song_list):
    for file in os.listdir(song_dir):
        if file.endswith(".mp3"):
            file_path = os.path.join(song_dir, file)
            if file_path not in song_list:
                os.remove(file_path)
                print('\033[1;36m' + "Delete {}".format(os.path.basename(file_path)) + '\033[1;36m')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A small script to download songs")
    parser.add_argument("--song-dir", default=os.path.join(os.environ['HOME'], 'Music'), help="provide download directory (default: ~/Music")
    parser.add_argument("-r", action="store_true")
    my_parse = parser.parse_args()

    if os.path.exists("log"):
        log_file = open("log", 'a')
    else:
        log_file = open("log", 'w')

    song_list = []
    default_downloader = DefaultDownloader(my_parse.song_dir, log_file, my_parse.r)
    youtube_downloader = YoutubeDownloader(my_parse.song_dir, log_file, my_parse.r)
    dir_path = os.path.dirname(os.path.realpath(__file__))
    with open(os.path.join(dir_path, "song_list")) as file:
        csv_reader = reader(file, delimiter=',')
        for s in csv_reader:
            if s and (not s[0].startswith('#')):
                pos = 1
                if s[1] == 'dl' or s[1] == 'yl':
                    pos = s[2]
                elif s[2]:
                    pos = int(s[2])

                download_song(s[0], s[1], pos)
    delete_song(my_parse.song_dir, song_list)

    song_list = []
    new_dir = os.path.join(os.environ["HOME"], "PhoneMusic")
    default_downloader.sdir = new_dir
    youtube_downloader.sdir = new_dir 
    with open(os.path.join(dir_path, "phone_list")) as file:
        csv_reader = reader(file, delimiter=',')
        for s in csv_reader:
            if s and (not s[0].startswith('#')):
                pos = 1
                if s[1] == 'dl' or s[1] == 'yl':
                    pos = s[2]
                elif s[2]:
                    pos = int(s[2])

                download_song(s[0], s[1], pos)
    delete_song(new_dir, song_list)
