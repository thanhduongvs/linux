# linux

## 1. Cài đặt ARM Cross Compiler: GCC
- `cd toolchain`
- `wget -c https://releases.linaro.org/components/toolchain/binaries/6.5-2018.12/arm-linux-gnueabihf/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz`
- `tar xf gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz`
- `vim ~/.bashrc`
- thêm dòng này ở cuối file `export PATH=$PATH:~/toolchain/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf/bin`
- `source ~/.bashrc`

## 2. Build linux
- `git clone https://github.com/thanhduongvs/linux.git`
- `cd linux`
- `export CROSS_COMPILE=arm-linux-gnueabihf-`
- `export ARCH=arm`
- `export KBUILD_OUTPUT=./build`
- `make distclean`
- `make multi_v7_defconfig`
- `make zImage -j8`
- `make dtbs -j8`
- `make uImage vmlinux dtbs LOADADDR=0xC2000040 -j8`
- `make modules -j8`

## 3. Link tham khảo
1. https://wiki.st.com/stm32mpu/wiki/Getting_started/STM32MP1_boards/STM32MP157x-EV1/Develop_on_Arm%C2%AE_Cortex%C2%AE-A7/Modify,_rebuild_and_reload_the_Linux%C2%AE_kernel