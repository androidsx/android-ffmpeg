#!/bin/bash

function die {
  echo "$1 failed" && exit 1
}

./clean.sh

# TODO: could not configure yasm
#./configure_yasm.sh || die "yasm configure"
#./make_yasm.sh || die "yasm make"

# TODO: could not compile lame static library
#./configure_lame.sh || die "lame configure"
#./make_lame.sh || die "lame make"

# x264: ok
./configure_x264.sh || die "X264 configure"
./make_x264.sh || die "X264 make"

# TODO: could not compile freetype (excluded in ffmpeg)
#./configure_freetype2.sh || die "freetype2 configure"
#./make_freetype2.sh || die "freetype2 make"

# ffmpeg: ok
./configure_ffmpeg.sh || die "FFMPEG configure"
./make_ffmpeg.sh || die "FFMPEG make"

# sox: not tested yet
#./configure_sox.sh || die "SoX configure"
#./make_sox.sh || die "SoX make"
