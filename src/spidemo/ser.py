#!/usr/bin/env python3

import serial
import time
import glob
import sys

def communicate_with_device(device_path, messages, timeout=0.05, baudrate=115200):
    """
    Open a serial connection to a device, send messages,
    and read the response.

    Args:
        device_path (str): device path to open
        messages (list[str]): ASCII messages to send
        timeout (float): Read timeout in seconds
        baudrate (int): Baud rate for serial communication
    """
    ret=[]
    try:
        ser = serial.Serial(
            port=device_path,
            baudrate=baudrate,
            timeout=timeout,
            bytesize=serial.EIGHTBITS,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE
        )
        # Add a small delay to ensure port is fully open
#        time.sleep(0.2)
        for message in messages:
            message += "\n"
            # Convert string to bytes and write to device
            ser.write(message.encode('ascii'))
            # Skip first response (command echo)
            response = ser.readline().decode('ascii').strip()
            if response != message.strip():
                print(f"Error: first {response=} != {message=}")
                break
            while 1:
                response = ser.readline().decode('ascii').strip()
                if not response:
                    break
                elif response.endswith(">"):
                    break
                elif message.startswith("t16 "):
                    for respl in response.splitlines():
                        #print(f"{respl=}")
                        for resp in respl.split():
                            #print(f"{resp=}")
                            if ':' not in resp:
                                val = int(resp, 16) & 0xffff
                                #print(f"{val=:04x}");
                                ret += [val]
                elif message.startswith("t24 "):
                    for respl in response.splitlines():
                        #print(f"{respl=}")
                        for resp in respl.split():
                            #print(f"{resp=}")
                            if ':' not in resp:
                                val = int(resp, 16) & 0xffff
                                #print(f"{val=:04x}");
                                ret += [val]
                elif message.startswith("bb "):
                    for resp in response.splitlines():
                        print(f"{resp=}")
                        if ':' not in resp:
                            val = int(resp, 16) & 0xffff
                            print(f"{val=:04x}");
                else:
                    for resp in response.splitlines():
                        print(f"{response}")
        ser.close()
    except serial.SerialException as e:
        print(f"Error communicating with {device_path}: {e}")
    #print(f"returning {ret=}")
    return ret
device_path = glob.glob('/dev/ttyUSB?')[0]
def transfer(mosi):
    l = len(mosi)
    if l == 1:
        mosi.extend([0])
    if len(mosi) == 2:
        messages=[f"t16 {mosi[0]:02x} {mosi[1]:02x}"]
    elif len(mosi) == 3:
        messages=[f"t24 {mosi[0]:02x} {mosi[1]:02x} {mosi[2]:02x}"]
    elif len(mosi) == 6:
        #print(f"write mosi {l=} "+" ".join([f"{b:02x}" for b in mosi]))
        messages=[
            f"t24 {mosi[0]:02x} {mosi[1]:02x} {mosi[2]:02x}",
            f"t24 {mosi[0]+2:02x} {mosi[3]:02x} {mosi[4]:02x}",
            f"t24 {mosi[0]+4:02x} {mosi[5]:02x} 00",
        ]
    else:
        raise Exception(f"{mosi=} {l=} (only 2 or 3 is supported)")
    response=communicate_with_device(device_path, messages)
    #print(f"{response=}")
    if l == 1:
        miso=[response[1]]
    elif l == 2:
        miso=[response[0], response[1]]
    elif l == 6:
        miso=[response[2], response[1], response[5], response[4], response[8], response[7]]
    else:
        raise Exception(f"{l=}")
    return miso
if __name__ == "__main__":
    args = sys.argv
    #print(f"{args}")
    if len(args) > 1:
        messages = args[1:]
        #print(f"{messages=}")
    else:
        messages = [
        "set_bb 1",
        #"bb 7 f b 9 b 8 a 8 a 8 a 9 b 9 b 9 b 9 b 9 b 9 b 9 b 9 b 9 b 9 b 9 b 9 b f 7",# WHOAMI 8fff => ff33
        "bb 7 f b 9 b 9 b 9 b 8 a 9 b 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a 8 a f 7",# READ OUT_X => ffa007
        ]
    communicate_with_device(device_path, messages)
