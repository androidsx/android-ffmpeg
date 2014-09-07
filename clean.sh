#!/bin/bash
pushd `dirname $0`
. settings.sh

find . -name \*.o -delete

pushd yasm
make clean

pushd lame
make clean

popd
pushd x264
make clean

popd
pushd freetype2
make clean

popd
pushd ffmpeg
make clean

popd
pushd sox
make clean

popd
