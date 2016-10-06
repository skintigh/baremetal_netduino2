Baremetal attempt to output text to 4 of the UARTS on a Netduino2 

You can run the code with: 

$QEMU/qemu/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin -serial unix:///tmp/uart1,server -serial unix:///tmp/uart2,server -serial unix:///tmp/uart3,server -serial unix:///tmp/uart4,server

and then in 4 other windows:

socat - UNIX-CONNECT:/tmp/uart1

socat - UNIX-CONNECT:/tmp/uart2

socat - UNIX-CONNECT:/tmp/uart3

socat - UNIX-CONNECT:/tmp/uart4

But only 1 and 4 work.

Or if you want to rebuild everything and then run qemu, run:

./build.sh

To build it you will need to install:

sudo apt-get build-dep gcc-arm-none-eabi

sudo apt-get install gcc-arm-none-eabi

If you want to debug the baremetal binary you'll need gdb-arm-none-eabi
