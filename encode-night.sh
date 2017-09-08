#!/bin/sh
exec ffmpeg -f image2 -framerate 30 -i chemriver-night/%04d.png -c:v libx264 -crf 0 -preset veryslow chemriver-night.mkv
