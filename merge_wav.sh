#!/bin/sh
CWD=`pwd`


# Converting sound to raw
for i in *.wav ; do
	sox $i -r 48000 -c 2 -s $i.raw
done

# Concatenating sound
cat *.raw > full.raw

# Converting sound to readable stuff
ffmpeg -y -f s16le -ar 48000 -ac 2 -i full.raw full.wav



