#!/bin/bash

# Helium version: 2.5 (well, we're not 100% sure, the MD5 is not the same. ffmpeg-2.5 is the one that went live)

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
--extra-cflags="-I../x264 -I../yasm -mfloat-abi=softfp -mfpu=neon" \
--extra-ldflags="-L../x264 -L../yasm" \
\
--enable-version3 \
--enable-gpl \
\
--disable-doc \
--enable-yasm \
\
--enable-decoders \
--enable-encoders \
--enable-muxers \
--enable-demuxers \
--enable-parsers \
--disable-protocols \
--enable-protocol=file \
--disable-filters \
--enable-filter=aresample \
--disable-avresample \
--disable-libfreetype \
\
--disable-indevs \
--disable-outdevs \
\
--enable-hwaccels \
\
--enable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-network \
\
#--enableffmpeg-libx264 \
--disable-zlib \
--disable-muxer=md5

popd; popd

