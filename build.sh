QEMU=~/qemu

set -e #stop on error

echo \#Compile init.c:
arm-none-eabi-as -mcpu=cortex-m4 -g startup.s -o startup.o

echo \#Assemble the startup.s file:
arm-none-eabi-gcc -c -mcpu=cortex-m4 -mthumb -g init.c -o init.o

echo \#Link the object files into an ELF file:
arm-none-eabi-ld -T linker.ld init.o startup.o -o output.elf

echo \#Objcopy:
arm-none-eabi-objcopy -O binary output.elf output.bin

echo \#Run Qemu:

#This prints UART1 to the screen
#$QEMU/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin 

#This prints UART4 to the screen, reset sent to /dev/null
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -chardev stdio,mux=on,id=terminal -serial /dev/null -serial chardev:terminal -serial /dev/null -serial chardev:terminal -monitor chardev:terminal

#-chardev makes the device, -serial connects it
#2 down
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -chardev stdio,mux=on,id=terminal -serial unix:///tmp/uart1,server -serial unix:///tmp/uart2,server -serial /dev/null -serial chardev:terminal -monitor chardev:terminal
#3 down
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -chardev stdio,mux=on,id=terminal -serial unix:///tmp/uart1,server -serial unix:///tmp/uart2,server -serial unix:///tmp/uart3,server -serial chardev:terminal -monitor chardev:terminal
#fail
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -chardev stdio,mux=on,id=terminal -serial unix:///tmp/uart1,server -serial unix:///tmp/uart2,server -serial unix:///tmp/uart3,server -serial unix:///tmp/uart4,server

../qemu/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -serial unix:///tmp/uart1,server -serial unix:///tmp/uart2,server -serial unix:///tmp/uart3,server -serial unix:///tmp/uart4,server


#this one sends UART1 to a socket but not UART2
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -m 128M -nographic -kernel output.bin -serial unix:///tmp/uart,server -serial unix:///tmp/uart2,server
#socat - UNIX-CONNECT:/tmp/uart

#../../qemu/arm-softmmu/qemu-system-arm -M netduino2 -m 128M -nographic -kernel output.bin -serial unix:///tmp/uart1,server,id=uart2 -serial unix:///tmp/uart2,server,id=uart1
#didn't redirect

#other desperation
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -m 128M -nographic -s -d cpu,in_asm -kernel output.bin
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -m 128M -nographic -serial unix:///tmp/uart,server -kernel output.bin
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -m 128M -nographic -chardev socket,id=usar0,host=localhost,port=31337,server -kernel output.bin
#../qemu/arm-softmmu/qemu-system-arm -M netduino2 -m 128M -nographic -chardev socket,id=chardev,host=localhost,port=31337,server -kernel output.bin
#../../qemu/arm-softmmu/qemu-system-arm -M netduino2 -m 128M -nographic -kernel output.bin -s -S
#   arm-none-eabi-gdb -ex "target remote localhost:1234"

