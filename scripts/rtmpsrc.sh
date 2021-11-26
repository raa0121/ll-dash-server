#!/bin/sh

# -f lavfi -i testsrc=duration=30:size=1280x720:rate=30 \
# -f lavfi -i sine=frequency=1000:d=30 \
#  -f flv -listen 1 -i rtmp://10.146.0.58:1935/live/app \

ffmpeg -f flv -listen 1 \
  -i rtmp://127.0.0.1:1935/live/app \
  -c:a aac \
  -c:v h264 -force_key_frames "expr:gte(t,n_forced*4)" -profile:v baseline \
  -map v:0 -b:0 1000k -s:0 640x360 \
  -map v:0 -b:0 500k -s:1 320x180 \
  -map a:0 \
  -ldash 1 -streaming 1 \
  -use_template 1 -use_timeline 0 \
  -adaptation_sets "id=0,streams=v id=1,streams=a" \
  -seg_duration 4 -frag_duration 1 -frag_type duration \
  -utc_timing_url "https://time.akamai.com/?iso" -window_size 15 \
  -extra_window_size 15 -remove_at_exit 1 \
  -f dash ${PWD}/../dash-data/1.mpd
