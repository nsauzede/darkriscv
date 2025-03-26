
iport:  0 0 SDA SA0
oport:  SCL_OE SDA_OE SDA SCL

Master (MCU)   ->|<-  Slave (LIS3DH)
---------------------------------------
[S]            ->|   Start Condition
[0x19]         ->|   Slave Address (0x19) + Write (0)
[ACK]          <-|   Acknowledge from Slave
[0x0F]         ->|   Register Address (0x0F) (WHO_AM_I)
[ACK]          <-|   Acknowledge from Slave
[R]            ->|   Repeated Start Condition
[0x19]         ->|   Slave Address (0x19) + Read (1)
[ACK]          <-|   Acknowledge from Slave
[0x33]         <-|   Data from Slave (WHO_AM_I = 0x33)
[NACK]         ->|   No Acknowledge from Master (end of read)
[P]            ->|   Stop Condition

ST: HIGH to LOW on SDA while SCL held HIGH
SR: 
SP: LOW to HIGH on SDA while SCL held HIGH
SAK: transmitter release SDA then receiver pull SDA LOW

Data transfer: MSb first

SAD: 001100
SA0: 1

cdDC            Ma      Sl
1111    0f
1101    0d      ST
1100
1101            0 SAD
1100
1101            0 SAD
1110
1111            1 SAD
1110
1111            1 SAD
1100
1101            0 SAD
1100
1101            0 SAD
1110
1111            1 SA0


