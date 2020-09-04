export KBUILD_BUILD_USER=S133PY
export ARCH=arm64
#export CROSS_COMPILE=/mnt/kernels/caf_kernel_zte_msm8996/toolchains/gcc10/bin/aarch64-linux-gnu-
export CROSS_COMPILE=/home/sleepy/android/toolchains/GCC-10/bin/aarch64-linux-elf-
#export CROSS_COMPILE=/home/sleepy/Lineage-GCC/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android-
#export CROSS_COMPILE_ARM32=/home/sleepy/Lineage-GCC/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export CROSS_COMPILE_ARM32=/mnt/kernels/caf_kernel_zte_msm8996/toolchains/arm32-gcc/bin/arm-eabi-


BUILD="/mnt/kernels/caf_kernel_zte_msm8996/build"
OUT="/mnt/kernels/caf_kernel_zte_msm8996/out"
#NPR=`expr $(nproc) + 1`



echo "setting up build..."
mkdir "$BUILD"
make O="$BUILD" nethunter_defconfig

echo "building kernel..."
make O="$BUILD" -j64

echo "building modules..."
make O="$BUILD" -j8 INSTALL_MOD_PATH=MODULES_OUT modules_install


mkdir -p $OUT/modules
mv "$BUILD/arch/arm64/boot/Image.gz-dtb" "$OUT/Image.gz-dtb"
rm -rf $OUT
mv "$BUILD/MODULES_OUT" "$OUT/modules"

echo "Image.gz-dtb & modules can be found in $BUILD"

