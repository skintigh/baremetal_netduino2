QEMU=~/qemu

set -e #stop on error

echo "############################################################################"
echo \#Compile init.c:
arm-none-eabi-as -mcpu=cortex-m4 -g startup.s -o startup.o

echo \#Assemble the startup.s file:
arm-none-eabi-gcc -c -mcpu=cortex-m4 -mthumb -g init.c -o init.o

echo \#Link the object files into an ELF file:
arm-none-eabi-ld -T linker.ld init.o startup.o -o output.elf

echo \#Objcopy:
arm-none-eabi-objcopy -O binary output.elf output.bin

echo \#Run Qemu:
echo "############################################################################"

#Output 6 UARTs to 6 locations
$QEMU/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -serial unix:///tmp/uart1,server -serial unix:///tmp/uart2,server -serial unix:///tmp/uart3,server -serial unix:///tmp/uart4,server -serial unix:///tmp/uart5,server -serial unix:///tmp/uart6,server
# connect with :
# socat - UNIX-CONNECT:/tmp/uart1
# ...uart6

#This prints UART1 to the screen
#$QEMU/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin 

#works! 4
#$QEMU/arm-softmmu/qemu-system-arm -M netduino2 -m 1G -nographic -kernel output.bin -serial unix:///tmp/uart1,server -serial unix:///tmp/uart2,server -serial unix:///tmp/uart3,server -serial unix:///tmp/uart4,server
#gdb --args $QEMU/arm-softmmu/qemu-system-arm -M netduino2 -m 1G -nographic -kernel output.bin -serial unix:///tmp/uart1,server -serial unix:///tmp/uart2,server -serial unix:///tmp/uart3,server -serial unix:///tmp/uart4,server

#GDB
#$QEMU/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -s -S
#   arm-none-eabi-gdb -ex "target remote localhost:1234"


#This prints UART4 to the screen, reset sent to /dev/null
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -chardev stdio,mux=on,id=terminal -serial /dev/null -serial chardev:terminal -serial /dev/null -serial chardev:terminal -monitor chardev:terminal

#to rebuild qemu:
# pushd ../qemu/ ; make -j $(nproc) ; popd
