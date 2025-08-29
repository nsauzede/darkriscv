# SPI Demo
This SPI demo was written for the max1000_max10 board and its builtin SPI accelerometer sensor (refer to boards/max1000_max10/README.md).

Note however that this application can be simulated without any hardware, using a custom accelerometer stub:
```shell
make clean all APPLICATION=spidemo
gtkwave rtl/lib/spi/darksocv.gtkw &
```

# Python helper
A python helper (tailored for spi/bb stuff) is provided to easily interact with the darkriscv/fpga shell serial port (`/dev/ttyUSB?`).
Following examples assume that APPLICATION=spidemo has been built/installed.
Eg: Set Bit-Banging off, Check WHOAMI then read OUT_X SPI register:
```shell
$ ./ser.py "set_bb 0" whoami read
Good HW whoami returned expected 33
main: ret=70
```
Eg: Set Bit-Banging on, Check WHOAMI then bit-bang-read OUT_X SPI register:
```shell
$ ./ser.py "set_bb 1" "bb 7 f b 9 b 9 b 9 b 8 a 9 b 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a f 7"
Good BB whoami returned expected 33
val=80
```

# Adafruit lis3dh_simpletest
The Adafruit LIS3DH simple test (https://github.com/adafruit/Adafruit_LIS3DH) has been adapted to run
with the darksocv SPI support by the way of the aforementioned `ser.py` Python helper:
```shell
$ python3 lis3dh_simpletest.py
x = -0.075 G, y = -0.015 G, z = 1.024 G
x = 0.152 G, y = -0.023 G, z = 0.961 G
x = 0.095 G, y = -0.024 G, z = 0.921 G
x = 0.119 G, y = -0.036 G, z = 0.984 G
x = 0.382 G, y = 0.022 G, z = 0.779 G
x = 1.021 G, y = 0.024 G, z = -0.158 G
...
```
