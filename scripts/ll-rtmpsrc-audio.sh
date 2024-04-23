#!/bin/sh

ffmpeg -f flv -listen 1 \
  -i rtmp://0.0.0.0:1935/live/app \
  -c:a aac \
  -vn \
  -map a:0 \
  -ldash 1 -streaming 1 \
  -use_template 1 -use_timeline 0 \
  -adaptation_sets "id=0,streams=a" \
  -seg_duration 4 -frag_duration 1 -frag_type duration \
  -utc_timing_url "https://time.akamai.com/?iso" -window_size 15 \
  -extra_window_size 15 -remove_at_exit 1 \
  -f dash ${PWD}/../dash-data/1.mpd
