Baremetal attempt to output text to 4 of the UARTS on a Netduino2

You can run the code with: 

$QEMU/arm-softmmu/qemu-system-arm -M netduino2 -nographic -kernel output.bin 

Or if you want to rebuild everything and then run qemu run:

./build.sh

To build it you will need to install:

sudo apt-get build-dep gcc-arm-none-eabi
sudo apt-get install gcc-arm-none-eabi

If you want to debug the baremetal binary you'll need gdb-arm-none-eabi
