export KBUILD_BUILD_USER=S133PY
export ARCH=arm64
#export CROSS_COMPILE=/mnt/kernels/caf_kernel_zte_msm8996/toolchains/gcc10/bin/aarch64-linux-gnu-
#export CROSS_COMPILE=/home/sleepy/android/toolchains/GCC-10/bin/aarch64-linux-elf-
export CROSS_COMPILE=/home/sleepy/Lineage-GCC/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/sleepy/Lineage-GCC/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
#export CROSS_COMPILE_ARM32=/mnt/kernels/caf_kernel_zte_msm8996/toolchains/arm32-gcc/bin/arm-eabi-


BUILD="/mnt/kernels/caf_kernel_zte_msm8996/build"
OUT="/mnt/kernels/caf_kernel_zte_msm8996/out"
#NPR=`expr $(nproc) + 1`



echo "setting up build..."
mkdir "$BUILD"
make O="$BUILD" nethunter_defconfig

echo "building kernel..."
make O="$BUILD" -j64

echo "building modules..."
make O="$BUILD" INSTALL_MOD_PATH="." INSTALL_MOD_STRIP=1 modules_install
rm $BUILD/lib/modules/*/build
rm $BUILD/lib/modules/*/source

mkdir -p $OUT/modules
mv "$BUILD/arch/arm64/boot/Image.gz-dtb" "$OUT/Image.gz-dtb"
find "$BUILD/lib/modules/" -name *.ko | xargs -n 1 -I '{}' mv {} "$OUT/modules"

echo "Image.gz-dtb & modules can be found in $BUILD"

