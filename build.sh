#assemble boot.s file
as --32 ./src/boot.s -o ./src/boot.o

#compile kernel.c file
gcc -m32 -c ./src/kernel.c -o ./src/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

#linking the kernel with kernel.o and boot.o files
ld -m elf_i386 -T ./src/linker.ld ./src/kernel.o ./src/boot.o -o ./src/KernelOS.bin -nostdlib

#check MyOS.bin file is x86 multiboot file or not
grub-file --is-x86-multiboot ./src/KernelOS.bin

#building the iso file
mkdir -p isodir/boot/grub
cp ./src/KernelOS.bin isodir/boot/KernelOS.bin
cp ./src/grub.cfg isodir/boot/grub/grub.cfg
mkdir -p build
grub-mkrescue -o ./build/KernelOS.iso isodir