from __future__ import unicode_literals
import youtube_dl
import sys

class MyLogger(object):
    def debug(self, msg):
        pass

    def warning(self, msg):
        pass

    def error(self, msg):
        print(msg)


def my_hook(d):
    if d['status'] == 'finished':
        print('Done downloading, now converting ...')


ydl_opts = {
    'format': 'bestaudio/best',
    'postprocessors': [{
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'mp3',
        'preferredquality': '192',
    }],
    'logger': MyLogger(),
    'progress_hooks': [my_hook],
}

if(len(sys.argv) < 2):
    print("usage: " + sys.argv[0] + " <url>")
    sys.exit(1)

myurl = sys.argv[1]

with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    ydl.download([myurl])
