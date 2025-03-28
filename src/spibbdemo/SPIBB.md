tcSPCmin=100ns 10MHz
tsuCSmin=5 thCSmin=20
tsuSImin=5 thSImin=15
tvSOmax=50 thSOmin=5 
                OCCD            {miso, 7'b0, out_x_l_response, 4'b0, oe, csn, sck, mosi}
                ESLI
7 f b 9 b 8 b 8 b 8 b 9 b 9 b 9 b 9 b  8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a f 7
8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8  0 0 0 0 8 8 8 8 0 0 0 0 8 8 8 8 0 8
ioport 7    8   0111            tristate
ioport f    8   1111            SPI Idle
ioport b    8   1011            SPI Active
ioport 9    8   1001            DI0 1           CMD/REG
ioport b        1011            .
ioport 8        1000            DI1 0
ioport b        1011            .
ioport 8        1000            DI2 0
ioport b        1011            .
ioport 8        1000            DI3 0
ioport b        1011            .
ioport 9        1001            DI4 1
ioport b        1011            .
ioport 9        1001            DI5 1
ioport b        1011            .
ioport 9        1001            DI6 1
ioport b        1011            .
ioport 9        1001            DI7 1
ioport b        1011            .

ioport 8        1000            DI0 0?          RET
ioport a        1010            .
ioport 8        1000            DI1 0?
ioport a        1010            .
ioport 8        1000            DI2 1?
ioport a        1010            .
ioport 8        1000            DI3
ioport a        1010            .
ioport 8        1000            DI4
ioport a        1010            .
ioport 8        1000            DI5
ioport a        1010            .
ioport 8        1000            DI6
ioport a        1010            .
ioport 8        1000            DI7
ioport a        1010            .

ioport f        1111            SPI Idle

ioport 7        0111            tristate
