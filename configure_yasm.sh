#!/bin/bash
pushd `dirname $0`
. settings.sh

pushd yasm

./configure \
    CC="$CC" \
    LD="$LD" \
    CFLAGS="-std=gnu99 -mcpu=cortex-a8 -marm -mfloat-abi=softfp -mfpu=neon" \
--host=$HOST \
--host=arm-linux \
--enable-static

popd;popd
