#!/bin/bash
# Converts a static image (e.g. a watermarked tip card) into a short vertical
# Ken-Burns style video suitable for Instagram Reels.
# Usage: make_reel.sh input.jpg output.mp4 [duration_seconds]
set -e
IN="$1"
OUT="$2"
DUR="${3:-6}"
FPS=30
FRAMES=$((DUR * FPS))
BG="0x140F10"

ffmpeg -y -loop 1 -i "$IN" -vf "scale=1080:1350:force_original_aspect_ratio=decrease,pad=1080:1350:(ow-iw)/2:(oh-ih)/2:color=${BG},zoompan=z='min(zoom+0.0006,1.08)':d=${FRAMES}:s=1080x1350:fps=${FPS},format=yuv420p" \
  -t "$DUR" -c:v libx264 -pix_fmt yuv420p -movflags +faststart "$OUT"
