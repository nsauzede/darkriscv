LIS3DH Sensor specs

SPI Bit-banging:
=======================================================================
tcSPCmin=100ns 10MHz
tsuCSmin=5 thCSmin=20
tsuSImin=5 thSImin=15
tvSOmax=50 thSOmin=5 
SPI-----[-SPI-Communication-Mode---------------------]------Sensor-Pad-
SSN   ~~\_________________________||_________________/~~~~~ CS
SCLK  ~~~~~~\___/~~~\___/~~~\___/~||~\___/~~~\___/~~~~~~~~~ SCL/SPC
MOSI  ======X=MSB=INX=======X=====||=X=======X=LSB=IN====== SDA/SDI/SDO
MISO  -------X=MSBOUTX=======X====||==X=======X=LSBOUTX---- SDO/SA0 (pulled up)

          RnW MnS AD5 AD4 AD3 AD2 AD1 AD0
SDI   ===X===X===X===X===X===X===X===X===X===X===X===X===X===X===X===X=========
                                          DI7 DI6 DI5 DI4 DI3 DI2 DI1 DI0
SDO   -----------------------------------X===X===X===X===X===X===X===X===X-----
                                          DO7 DO6 DO5 DO4 DO3 DO2 DO1 DO0

I2C Bit-banging: (standard timing mode)
========================================================================
fSCLmax=100kHz
twSCLLmin=4.7us
twSCLHmin=4.0us
thSTmin=4us
tsuSDAmin=250ns
thSDAmax=3.45us
I2C-----[-I2C-Communication-Enabled------------------]------Sensor-Pad-
(ena) __/~ST~~~~~~~~~~~~~~~~~~~~~~||~~~~~~~~~~~~~~~~~\_____ CS
SDA   ~~~~\___/======X=========X==||======================= SDA/SDI/SDO
SCL   ~~~~~~\___/~~~\___/~~~\___/~||~\___/~~~~~~~~~~~~~~~~~ SCL/SPC
(SA0) ----------------------------||----------------------- SDO/SA0 (pulled up)

Transmitter sends data to the bus
Receiver receives data from the bus
Master initiates/terminates transfer and generates clock signals
Slave is addressed by the master

ST      STart condition         HIGH-to-LOW SDA while SCL is HIGH
SP      StoP condition          LOW-to-HIGH SDA while SCL is HIGH
SR      Repeated Start condtion <same as ST ?>
NMAK    No Master AcKnowledge
MAK     Master AcKnowledge
SAD     Slave ADdress (7 bit)   LIS3DH is 001100xb, bit0 is SA0: either 0x19 (default) or 0x18
RnW     Read=1 Write=0
W       0
R       1
SAK     Slave AcKnowledge       receiver pulls SDA LOW during HIGH period of ack clock pulse (must be done after each data received)
SUB     SUB-address (7+1 bit)   MSB: enable address auto-increment; 7 LSBs: actual register address
DATA    Byte format data        transferred with MSb first

Master is writing one byte to slave:
----------------------------------------------------------
Master  | ST | SAD+W |     | SUB |     | DATA |     | SP |
Slave   |    |       | SAK |     | SAK |      | SAK |    |

Master is writing multiple bytes to slave:
------------------------------------------------------------------------
Master  | ST | SAD+W |     | SUB |     | DATA |     | DATA |      | SP |
Slave   |    |       | SAK |     | SAK |      | SAK |      | SACK |    |

Master is reading one byte from slave:
------------------------------------------------------------------------------
Master  | ST | SAD+W |     | SUB |     | SR | SAD+R |     |      | NMAK | SP |
Slave   |    |       | SAK |     | SAK |    |       | SAK | DATA |      |    |

Master is reading multiple bytes from slave:
-------------------------------------------------------------------------------------------
Master  | ST | SAD+W |     | SUB |     | SR | SAD+R |     |      | MAK |      | NMAK | SP |
Slave   |    |       | SAK |     | SAK |    |       | SAK | DATA |     | DATA |      |    |




------------------------------------------------------------------------------------
IPORT= out_x_resp, 11'b0, MISO, rd, mosi_tri, spibb_ena, CSN, SCK, MOSI
OPORT= out_x_resp, 11'b0, miso, rd, mosi_tri, spibb_ena, csn, sck, mosi

WHOAMI:
                OCCD            out_x_resp, 11'b0, MISO, rd, mosi_tri, spibb_ena, CSN, SCK, MOSI
                ESLI
7 f b 9 b 8 a 8 a 8 a 9 b 9 b 9 b 9 b  9 b 9 b 9 b 9 b 9 b 9 b 9 b 9 b f 7
0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1 1 0
ioport 7    0   0111            tristate
ioport f    1   1111            SPI Idle
ioport b    1   1011            SPI Active
ioport 9    1   1001            DI0 1           CMD/REG         R/W: 1=READ
ioport b    1   1011            .
ioport 8    1   1000            DI1 0                           M/S: 0=single op
ioport a    1   1010            .
ioport 8    1   1000            DI2 0                           slave addr=0b001111=0x0f
ioport a    1   1010            .                               0f=WHOAMI
ioport 8    1   1000            DI3 0
ioport a    1   1010            .
ioport 9    1   1001            DI4 1
ioport b    1   1011            .
ioport 9    1   1001            DI5 1
ioport b    1   1011            .
ioport 9    1   1001            DI6 1
ioport b    1   1011            .
ioport 9    1   1001            DI7 1
ioport b    1   1011            .
ioport 9    0   1001            DI0 0?          SLAVE RESPONSE  0b00110011=0x33
ioport b    0   1011            .
ioport 9    0   1001            DI1 0?
ioport b    0   1011            .
ioport 9    1   1001            DI2 1?
ioport b    1   1011            .
ioport 9    1   1001            DI3 1?
ioport b    1   1011            .
ioport 9    0   1001            DI4
ioport b    0   1011            .
ioport 9    0   1001            DI5
ioport b    0   1011            .
ioport 9    1   1001            DI6
ioport b    1   1011            .
ioport 9    1   1001            DI7
ioport b    1   1011            .
ioport f    1   1111            SPI Idle
ioport 7    0   0111            tristate



-----------------------------------------------------------------------
SPI current: out_x_resp, 10'b0, MISO, rd, mosi_tri, spibb_ena, CSN, SCK, MOSI
SPI nextgen: out_x_resp, 10'b0, rd, mosi_tri, spibb_ena, CSN, SCK, MOSI, MISO


IPORT= out_x_resp, 11'b0, MISO, rd, mosi_tri, spibb_ena, CSN, SCK, MOSI
OPORT= out_x_resp, 11'b0, miso, rd, mosi_tri, spibb_ena, csn, sck, mosi

WHOAMI:
                OCCD            out_x_resp, 11'b0, MISO, rd, mosi_tri, spibb_ena, CSN, SCK, MOSI
                ESLI
7 f b 9 b 8 a 8 a 8 a 9 b 9 b 9 b 9 b  9 b 9 b 9 b 9 b 9 b 9 b 9 b 9 b f 7
0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1 1 0
ioport 7    0   0111            tristate
ioport f    1   1111            SPI Idle
ioport b    1   1011            SPI Active
ioport 9    1   1001            DI0 1           CMD/REG         R/W: 1=READ
ioport b    1   1011            .
ioport 8    1   1000            DI1 0                           M/S: 0=single op
ioport a    1   1010            .
ioport 8    1   1000            DI2 0                           slave addr=0b001111=0x0f
ioport a    1   1010            .                               0f=WHOAMI
ioport 8    1   1000            DI3 0
ioport a    1   1010            .
ioport 9    1   1001            DI4 1
ioport b    1   1011            .
ioport 9    1   1001            DI5 1
ioport b    1   1011            .
ioport 9    1   1001            DI6 1
ioport b    1   1011            .
ioport 9    1   1001            DI7 1
ioport b    1   1011            .
ioport 9    0   1001            DI0 0?          SLAVE RESPONSE  0b00110011=0x33
ioport b    0   1011            .
ioport 9    0   1001            DI1 0?
ioport b    0   1011            .
ioport 9    1   1001            DI2 1?
ioport b    1   1011            .
ioport 9    1   1001            DI3 1?
ioport b    1   1011            .
ioport 9    0   1001            DI4
ioport b    0   1011            .
ioport 9    0   1001            DI5
ioport b    0   1011            .
ioport 9    1   1001            DI6
ioport b    1   1011            .
ioport 9    1   1001            DI7
ioport b    1   1011            .
ioport f    1   1111            SPI Idle
ioport 7    0   0111            tristate

READ: (OUT_X)
                OCCD            out_x_resp, 11'b0, MISO, spibb_ena, CSN, SCK, MOSI
                ESLI
7 f b 9 b 9 b 9 b 8 a 9 b 8 a 8 a 8 a  8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a f 7
0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  1 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 1 1 0 0 0 ret=0a30 (3fffe1e000198)
