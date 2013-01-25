#!/bin/bash
BITRATE=${BITRATE:-2000k}

avconv -i $1 -y -an -pass 1 -vcodec libx264 -threads 0 -b $BITRATE -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -subq 1 -trellis 0 -refs 1 -bf 3 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 $2

avconv -i $1 -y -acodec libfaac -b:a 128k -pass 2 -vcodec libx264 -threads 0 -b:v $BITRATE -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -flags2 +mixed_refs -subq 5 -trellis 1 -refs 5 -bf 3 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 $2


#ffmpeg -i $i  -pass 2 -vcodec libx264 -vpre slow -b 300k -threads 0 -acodec libmp3lame -ar 48000 -ab 128k $2

#ffmpeg -i $1 -f mp4 -acodec libmp3lame -ab 128k -ar 44100 -vcodec mpeg4 -minrate 0 -b 6000k -mbd 2 -trellis 1 $2
