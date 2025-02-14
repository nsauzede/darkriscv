# MAX1000 board (Trenz Electronic)

## General information
The Max1000 board is a small development board based on Intel/Altera Max10 family of FPGAs.
It has a 10M08SAU169C8G chip and also includes the following peripherals:
* 64MBit SDRAM (16-bit data bus)
* 64Mbit Flash Memory
* Arrow USB Programmer2 on-board for programming; JTAG + Serial (FT2232H)
* 8 LEDs + 2 push-buttons
* 12 MHz MEMS Oscillator
* 3-axis accelerometer + thermal sensor
* Many headers: PMOD, Arduino MKR, JTAG, I/O

For more detailed information, see here:
https://wiki.trenz-electronic.de/display/PD/TEI0001+Getting+Started

The DarkRISCV/darksoc builds out-of-the box using Quartus command-line,
taking about ~40% of the on-chip LUTs for the SoC demo.
It uses an altera pll QIP to transform 12=>32MHz (TODO: maybe move it to darkpll),
a modified darkram based on altsyncram to properly infer BRAM,
a modified darkio including an experimental SPI master to interface with the accelerometer sensor,
as well as a modified darksocv to expose the 8 leds + SPI interface.
NOTE: the SPI interface is not yet functional (TODO: properly connect the SPI master to the darkio variant).

There is a convenience local `Makefile` here that is only useful to run a simulation of this board (with a sensor stub).
Otherwise, to build and program the bitstream, use the top-level darkriscv `Makefile`, as per instructions below.

## Instructions
Install Quartus with Max10 support, `srecord`, `awk`, `xxd`.
Read/apply the Trenz Electronics docs to enable the max1000 support (eg: udev rules, ftdi driver etc..)
Source the Quartus setup script, then build the bitstream:
`darkriscv$ make all BOARD=max1000_max10 BUILD=NO_BUILD_DATE`
Once the bitstream has been built, program the device like this:
`darkriscv$ make install BOARD=max1000_max10`
Finally connect to the serial port, eg: with Putty on /dev/ttyUSB0 (baudrate=115200)
