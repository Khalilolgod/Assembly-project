nasm -f elf -d ELF_TYPE asm_io.asm
nasm -f elf myprog.asm
gcc -m32 -c driver.c
gcc -m32 driver.o asm_io.o myprog.o -o a
./a
rm *.o
rm a
