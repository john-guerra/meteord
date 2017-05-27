#!/bin/bash
set -e
apt-get update -y
apt-get install -y curl bzip2 build-essential g++ python git libmagick++-dev imagemagick
echo "export PATH=/usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16:$PATH" >> /etc/profile
ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/Magick++* /usr/bin
source ~/.bashrc