#!/bin/bash

# 设置构建体系
export ARCH=arm
export SUBARCH=arm

# 设置编译器路径
export CROSS_COMPILE=${PWD}/toolchain/bin/arm-linux-androidkernel-

# 新建文件输出文件夹, 防止无法编译内核
mkdir -p out

# 使用设备config创建编译配置
make O=out virgo_defconfig

# 开始编译内核
make -j24 O=out

# 将编译完成的内核映像文件从out复制到anykernel
cp -p ${PWD}/out/arch/arm/boot/zImage-dtb ${PWD}/anykernel/zImage-dtb

# 进入anykernel目录
cd ${PWD}/anykernel

# 打包内核(使用今天的日期)
zip -r cancro-$(date "+%m%d").zip *
