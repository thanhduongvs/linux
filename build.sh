#!/bin/bash

devices=("stm32mp157c-onekiwi")
devices+=("stm32mp157c-kmtek-octavo")

device=${devices[0]}
clean=0

printusage() {
    echo "Usage: $0" >&2
    echo
    echo "    -d, --devicetree                DEVICE_TREE"
    for i in ${!devices[@]}; do
        echo "        ${devices[$i]}"
    done
    echo "    -c, --distclean                 enable make distclean"
    echo
    echo "Example:"
    echo "$0 -d stm32mp157c-onekiwi"
    echo "$0 -d stm32mp151a-kiwi -c"
    echo
    # echo some stuff here for the -a or --add-options 
    exit 1
}

run_build() {
    export CROSS_COMPILE=arm-ostl-linux-gnueabi-
    export ARCH=arm
    export KBUILD_OUTPUT=./build

    if [ $clean -eq 1 ]; then
        make distclean
    fi
    echo "1. make multi_v7_defconfig"
    make multi_v7_defconfig
    echo "2. make $device.dtb -j8"
    make $device.dtb -j8
    echo "3. make $device-a7-examples.dtb -j8"
    make $device-a7-examples.dtb -j8
    echo "4. make $device-m4-examples.dtb -j8"
    make $device-m4-examples.dtb -j8
}

parse_arguments() {
    while :
    do
        case "$1" in
        -d | --devicetree)
            device="$2"
            shift 2
            ;;
        
        -f | --config)
            config="$2"
            shift 2
            ;;
        
        -c | --distclean)
            clean=1
            shift
            ;;

        --) # End of all options
            shift
            break
            ;;

        -*)
            echo "Error: Invalid option: $1" >&2
            printusage
            ## or call function printusage
            exit 1 
            ;;

        *)  # No more options
            break
            ;;
        esac
    done
}


# main
if [ $# -eq 0 ]; then
    printusage
else
    parse_arguments $*
    run_build
fi