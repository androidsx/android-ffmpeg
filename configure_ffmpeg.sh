#!/bin/bash

# Helium version: 2.6 for Android-5 (added two additional filters)

pushd `dirname $0`
. settings.sh

# I haven't found a reliable way to install/uninstall a patch from a Makefile,
# so just always try to apply it, and ignore it if it fails. Works fine unless
# the files being patched have changed, in which cause a partial application
# could happen unnoticed.
#patch -N -p1 --reject-file=- < redact-plugins.patch
#patch -N -p1 --reject-file=- < arm-asm-fix.patch
#patch -d ffmpeg -N -p1 --reject-file=- < \
    #ARM_generate_position_independent_code_to_access_data_symbols.patch
#patch -d ffmpeg -N -p1 --reject-file=- < \
#    ARM_intmath_use_native-#size_return_types_for_clipping_functions.patch
#patch -d ffmpeg -N -p1 --reject-file=- < \
#    enable-fake-pkg-config.patch

# In the line EXTRA_FLAGS, use one of these:
# For Android 4.x
#--extra-cflags="-I../x264 -I../yasm -mfloat-abi=softfp -mfpu=neon" \
#--extra-ldflags="-L../x264 -L../yasm" \
# For Android 5.x
#--extra-cflags="-I../x264 -I../yasm -mfloat-abi=softfp -mfpu=neon -fPIE" \
#--extra-ldflags="-L../x264 -L../yasm -fPIE -pie" \


pushd ffmpeg

./configure \
--enable-stripping \
--arch=arm \
--cpu=cortex-a8 \
--target-os=linux \
--enable-runtime-cpudetect \
--prefix=$prefix \
--enable-pic \
--disable-shared \
--enable-static \
--cross-prefix=$NDK_TOOLCHAIN_BASE/bin/$NDK_ABI-linux-androideabi- \
--sysroot="$NDK_SYSROOT" \
--extra-cflags="-I../x264 -I../yasm -mfloat-abi=softfp -mfpu=neon -fPIE" \
--extra-ldflags="-L../x264 -L../yasm -fPIE -pie" \
\
--enable-version3 \
--enable-gpl \
\
--disable-doc \
--enable-yasm \
\
--disable-decoders \
--enable-decoder=mpeg4 \
--enable-decoder=wavpack \
--enable-decoder=pcm_s16le \
--enable-decoder=h264 \
--enable-decoder=aac \
--enable-decoder=png \
\
--disable-encoders \
--enable-encoder=pcm_s16le \
--enable-encoder=aac \
--enable-encoder=png \
--enable-encoder=mpeg4 \
\
--disable-parsers \
--enable-parser=aac \
--enable-parser=h264 \
--enable-parser=png \
--enable-parser=mpeg4video \
\
--disable-demuxers \
--enable-demuxer=pcm_s16le \
--enable-demuxer=h264 \
--enable-demuxer=wav \
--enable-demuxer=image2 \
--enable-demuxer=mov \
\
--disable-muxers \
--enable-muxer=pcm_s16le \
--enable-muxer=h264 \
--enable-muxer=image2 \
--enable-muxer=wav \
--enable-muxer=mp4 \
\
--disable-protocols \
--enable-protocol=file \
\
--disable-filters \
--enable-filter=amerge \
--enable-filter=amix \
--enable-filter=aresample \
--enable-filter=overlay \
--enable-filter=scale \
\
--disable-avresample \
--disable-indevs \
--disable-outdevs \
--disable-bsfs \
\
--enable-hwaccels \
\
--enable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-network \
\

popd; popd

