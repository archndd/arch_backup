import argparse 
import os

parser = argparse.ArgumentParser(description="A small script to download songs")
parser.add_argument("--song-dir", default=os.path.join(os.environ['HOME'], 'Music'), help="provide download directory (default: ~/Music")
parser.add_argument("-r", action="store_true")
my_parse = parser.parse_args()
print(my_parse)
