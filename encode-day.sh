#!/bin/sh
exec ffmpeg -f image2 -framerate 30 -i chemriver/%04d.png -c:v libx264 -crf 0 -preset veryslow chemriver.mkv
