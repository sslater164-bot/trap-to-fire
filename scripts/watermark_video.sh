#!/bin/bash
# Adds a "TRAP TO FIRE" bar to the bottom of a video (1080-wide assumed).
# Usage: watermark_video.sh input.mp4 output.mp4
set -e
IN="$1"
OUT="$2"
FONT="/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
BAR_H=130

ffmpeg -y -i "$IN" -vf "pad=iw:ih+${BAR_H}:0:0:color=0x140F10,drawbox=x=0:y=ih-${BAR_H}:w=iw:h=3:color=0xE8442C:t=fill,drawtext=text='TRAP TO FIRE':fontfile=${FONT}:fontcolor=0xF2EDE4:fontsize=48:x=(w-text_w)/2:y=h-${BAR_H}+(${BAR_H}-48)/2-4" \
  -c:v libx264 -pix_fmt yuv420p -c:a copy "$OUT"
