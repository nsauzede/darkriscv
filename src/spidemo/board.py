import sys
from ser import transfer
def print_(self, s, end='\n'):print(f"{type(self).__name__}.{sys._getframe(1).f_code.co_name}: {s}", end=end)
class SPI:
    def __init__(self):
        self.mosi = []
    def transfer(self, mosi):
        l=len(mosi)
        #print(f"write mosi {l=} "+" ".join([f"{b:02x}" for b in mosi]),end='')
        miso = transfer(mosi)
        #print(f" => read "+" ".join([f"{b:02x}" for b in miso]))
        return miso
    def transfer2(self, mosi):
        miso = []
        l = len(mosi)
        print(f"write {l=} "+" ".join([f"{b:02x}" for b in mosi]),end='')
        if (mosi[0] & 0x80):
            miso.extend([0] * l)
            mns = mosi[0] & 0x40
            reg = mosi[0] & 0x3f
            for i in range(l):
                val = 0
                if reg == 0x0f:
                    val = 0x33
                    #print_(self,f"{reg=:02x} WHOAMI")
                    print(" WHOAMI", end='')
                elif reg == 0x20:
                    #print_(self,f"{reg=:02x} CTRL_REG1 ODR3 ODR2 ODR1 ODR0 LPen Zen Yen Xen")
                    print(" CTRL_REG1", end='')
                    pass
                elif reg == 0x23:
                    #print_(self,f"{reg=:02x} CTRL_REG4 BDU BLE FS1 FS0 HR ST1 ST0 SIM")
                    print(" CTRL_REG4", end='')
                    pass
                elif reg == 0x28:
                    #print_(self,f"{reg=:02x} OUT_X_L")
                    print(" OUT_X_L", end='')
                    pass
                elif reg == 0x29:
                    #print_(self,f"{reg=:02x} OUT_X_H")
                    print(" OUT_X_H", end='')
                    pass
                elif reg == 0x2a:
                    #print_(self,f"{reg=:02x} OUT_Y_L")
                    print(" OUT_Y_L", end='')
                    pass
                elif reg == 0x2b:
                    #print_(self,f"{reg=:02x} OUT_Y_H")
                    print(" OUT_Y_H", end='')
                    pass
                elif reg == 0x2c:
                    #print_(self,f"{reg=:02x} OUT_Z_L")
                    print(" OUT_Z_L", end='')
                    pass
                elif reg == 0x2d:
                    #print_(self,f"{reg=:02x} OUT_Z_H")
                    print(" OUT_Z_H", end='')
                    pass
                else:
                    raise Exception(f"{reg=:02x}")
                miso[i] = val
                if mns:
                    reg += 1
            print(f" ==> read "+" ".join([f"{b:02x}" for b in miso]))
        else:
            print()
        return miso
    def write(self, buffer, start, end):
        self.mosi = []
        #print_(self,f"{buffer=} {start=} {end=}")
        if start>end:raise Exception("circular buffer??")
        l = end - start
        if l == 0:raise Exception("empty buffer??")
        for i in range(start, end):
            self.mosi += [buffer[i]]
        if (self.mosi[0] & 0x80) == 0:
            self.transfer(self.mosi)
    def readinto(self, buffer, start, end):
        #print_(self,f"{buffer=} {start=} {end=}")
        if start>end:raise Exception("circular buffer??")
        l = end - start
        if l == 0:raise Exception("empty buffer??")
        if l > len(self.mosi):
            self.mosi.extend([0] * (l - len(self.mosi)))
        miso = self.transfer(self.mosi)
        #print_(self,f"{l=} {len(miso)=}")
        for i in range(l):
            b = miso[i] if i < len(miso) else 0
            buffer[start + i] = b
        self.mosi = []
    def unlock(self):
        #print_(self,f"")
        pass
    def try_lock(self):
        #print_(self,f"")
        return True
    def configure(self, baudrate, polarity, phase):
        #print_(self,f"{baudrate=} {polarity=} {phase=}")
        pass

#D5="D5"
class myPin:
    def __init__(self, id):
        #print_(self,f"{id=}")
        self.id = id
D5=myPin(5)
D6=myPin(6)
