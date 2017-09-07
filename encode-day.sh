#!/bin/sh
exec ffmpeg -f image2 -i chemriver/%04d.png -r 30 -c:v libx264 -crf 0 -preset veryslow chemriver.mkv
