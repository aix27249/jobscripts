#!/bin/sh
ffmpeg -i $i  -pass 2 -vcodec libx264 -vpre slow -b 300k -threads 0 -acodec libmp3lame -ar 48000 -ab 128k $2

#ffmpeg -i $1 -f mp4 -acodec libmp3lame -ab 128k -ar 44100 -vcodec mpeg4 -minrate 0 -b 6000k -mbd 2 -trellis 1 $2
