#!/bin/bash

cd linux-stm32mp
export CROSS_COMPILE=arm-ostl-linux-gnueabi-
export ARCH=arm
export KBUILD_OUTPUT=./build
#make distclean
make multi_v7_defconfig
make dtbs -j8