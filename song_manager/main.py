from itertools import filterfalse
from bs4 import BeautifulSoup
from mutagen.easyid3 import EasyID3
from csv import reader
from urllib.parse import quote
import youtube_dl
import os
import requests
import shutil


class Downloader():
    def __init__(self, sdir):
        self.sdir = sdir
        self.slink = ''
        self.dlink = ''

    def process_song_name(self, song_name, pos=1):
        self.name = [i.strip() for i in song_name.strip().split(' - ')]
        self.song_name = "{artist} - {title}.mp3".format(artist=self.name[1], title=self.name[0])
        self.song_path = os.path.join(self.sdir, self.song_name)
        self.pos = pos - 1
        song_list.append(self.song_name)

    def change_metadata(self):
        audio = EasyID3(self.song_path)
        audio['title'] = self.name[0]
        audio['artist'] = self.name[1]
        audio.save()


class DefaultDownloader(Downloader):
    def __init__(self, sdir):
        super().__init__(sdir)

    def manage(self, song_name, pos, search_by_title_only=False):
        super().process_song_name(song_name, pos)

        if not os.path.isfile(self.song_path):
            self.get_song_link(search_by_title_only)
            self.get_download_link()
            self.download()
            self.change_metadata()

    def manage_link(self, song_name, link):
        super().process_song_name(song_name)
        self.slink = link
        if not os.path.isfile(self.song_path):
            self.get_download_link()
            self.download()
            self.change_metadata()

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
        os.system("wget -O \"{}\" {}".format(self.song_path, self.dlink))
        # os.system("wget -O \"{}\" {} 1>/dev/null 2>&1".format(self.song_path, self.dlink))


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

    def __init__(self, sdir):
        super().__init__(sdir)

    def manage(self, song_name, pos=1):
        super().process_song_name(song_name, pos)

        if not os.path.isfile(self.song_path):
            self.get_youtube_link()
            self.download()
            self.change_metadata()
    
    def manage_link(self, song_name, link):
        super().process_song_name(song_name)
        self.dlink = link
        self.slink = ''
        if not os.path.isfile(self.song_path):
            self.download()
            self.change_metadata()

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
    elif tag == 'dl':
        default_downloader.manage_link(song_name, pos)
    elif tag == 'yl':
        youtube_downloader.manage_link(song_name, pos)

def delete_song(song_dir, song_list):
    for file_name in os.listdir(song_dir):
        if file_name.endswith(".mp3") and file_name not in song_list:
            file_name_path = os.path.join(song_dir, file_name)
            os.remove(file_name_path)
            print('\033[1;36m' + "Delete {}".format(file_name) + '\033[1;36m')

def copy(from_dir, end_dir):
    end_dir_file_name = os.listdir(end_dir)
    for file_name in os.listdir(from_dir):
        if file_name.endswith(".mp3") and file_name not in end_dir_file_name:
            file_name_path = os.path.join(from_dir, file_name)
            shutil.copyfile(file_name_path, os.path.join(end_dir, file_name))
            print('\033[1;33m' + "Copy {}".format(file_name) + '\033[1;33m')

def add_to_old_list(old_list_dir, song_list_dir):
    with open(song_list_dir) as song_list_name_something, open(old_list_dir, "r+") as old_list_name_something:
        songs = reader(song_list_name_something, delimiter=',')
        for s in songs:
            if (s and not s[0].startswith("#")):
                old_list_name_something.seek(0)
                old_list = reader(old_list_name_something, delimiter=",")
                found = False
                for ol in old_list:
                    if (ol and not ol[0].startswith("#") and s[0] == ol[0]):
                        found = True
                        break

                if (not found):
                    old_list_name_something.write(','.join(s)+'\n')

if __name__ == "__main__":
    print('\033[1;36m' + "DONE" + '\033[1;36m')

    song_list = []
    song_dir = os.path.join(os.environ["HOME"], "Music")

    default_downloader = DefaultDownloader(song_dir)
    youtube_downloader = YoutubeDownloader(song_dir)
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
    delete_song(song_dir, song_list)
    print("add")
    add_to_old_list(os.path.join(dir_path, "old_list"), os.path.join(dir_path, "song_list"))

    # os.system("sudo umount /mnt")
    # os.system("sudo jmtpfs -o allow_other /mnt")
    # path = r"/mnt/Internal shared storage/Music/Music"
    # delete_song(path, song_list)
    # # Copy to phone
    # copy(song_dir, path)


