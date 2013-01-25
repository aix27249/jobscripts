#!/bin/sh
ffmpeg -i $1 -f mp4 -acodec libmp3lame -ab 128k -ar 44100 -vcodec mpeg4 -minrate 0 -b 6000k -mbd 2 -trellis 1 $2
