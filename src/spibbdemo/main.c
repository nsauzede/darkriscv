/*
 * Copyright (c) 2025, Nicolas Sauzede <nicolas.sauzede@gmail.com>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 * * Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <io.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#define MAX_RETRY 1000
volatile int waste_counter = 0;
static inline void waste_time(int n) {
    //printf("waste_counter=%d\n", waste_counter);
    for (int i = 0; i < n; i++) {
        waste_counter++;
    }
}
static inline int spi_read_do_(void) {
//    return 1 & (io->iport >> 31);
    return !!(io->iport & (1 << 31));
}
unsigned int ret = 0;
static inline void spi_write_oe_es_cl_di_(unsigned char oe_es_cl_di) {
    io->oport = ((ret & 0xffff) << 16) | oe_es_cl_di;
//    spi_read_do_();
}
unsigned int spi_transfer_(unsigned int command_data, int nbits) {
    printf("%s: command_data=%x nbits=%d\n", __func__, command_data, nbits);
    ret = 0;
    spi_write_oe_es_cl_di_(0x7);    // output disabled / tristate       0111
    spi_write_oe_es_cl_di_(0xf);    // output enabled / SPI Idle        1111
    spi_write_oe_es_cl_di_(0xb);    // output enabled / SPI Active      1011
    for (int i = nbits; i >= 0; i--) {
        int bit;
        bit = !!(command_data & (1 << i));
//        printf("%s: i=%d bit=%d\n", __func__, i, bit);
        spi_write_oe_es_cl_di_(0x8 | bit);                      //      100?
        waste_time(3);
        spi_write_oe_es_cl_di_(0xa | bit);
        bit = spi_read_do_();
//        waste_time(0);
        ret = (ret << 1) | bit;
    }
    spi_write_oe_es_cl_di_(0xf);    // output enabled / SPI Idle
    spi_write_oe_es_cl_di_(0x7);    // output disabled / tristate
    printf("%s: returning %x\n", __func__, ret);
    return ret;
}
static inline unsigned short spi_transfer16(unsigned short command_data) {
#if 1
    return spi_transfer_(command_data, 15);
#else
    return 0;
#endif
}
static inline unsigned int spi_transfer24(unsigned int command_data) {
#if 1
    return spi_transfer_(command_data, 23);
#else
    return 0;
#endif
}
int simu() {
    printf("%s\n", __func__);
    io->led = 0xff;
    unsigned short ret = 0;
    unsigned short exp;
    exp = 0x33;
    ret = spi_transfer16(0x8f00);
    io->led = ret;
    if ((ret & 0xff) != exp) {
        printf("Bad Whoami %x expected %x\n>", ret, exp);
//        printf("Bad Whoami\n");
//        io->led = ret;
//        printf("got %x\n", ret);
//        printf("expected %x\n", exp);
//        printf(">");
        return -1;
    }
    io->led = 0xfe;
    spi_transfer16(0x2077);
    io->led = 0xfd;
    spi_transfer16(0x1fc0);
    io->led = 0xfb;
    spi_transfer16(0x2388);
    exp = 0x9a00;
    printf("%s: looping\n", __func__);
    for (int i = 0; i < 1000000; i++) {
        printf("%s: i=%d\n", __func__, i);
        io->spi.out_x_l_response = exp;
        ret = spi_transfer24(0xe80000);
        if (ret != exp) {
            printf("Bad out_x %x expected %x\n>", ret, exp);
            return -1;
        }
        unsigned char led_out = 1 << (((ret & 0xff00) >> 8) >> 5);
        io->led = led_out;
        exp += 0x2000;
        if (i == 16)
            printf("Test passed.\n>");
    }
    printf("%s: returning 0\n", __func__);
    return 0;
}
int sensor() {
    printf("%s\n", __func__);
    io->led = 0xff;
    unsigned short ret = 0;
    unsigned short exp;
    exp = 0x33;
    ret = spi_transfer16(0x8f00);
    io->led = ret;
    if ((ret & 0xff) != exp) {
        printf("Bad Whoami %x expected %x\n>", ret, exp);
        return -1;
    }
    io->led = 0xfe;
    spi_transfer16(0x2077);
    io->led = 0xfd;
    spi_transfer16(0x1fc0);
    io->led = 0xfb;
    spi_transfer16(0x2388);
    printf("Reading OUT_X.. (press a key to stop)\n");
    while (1) {
        if (io->uart.stat&2) {
            break;
        }
        ret = spi_transfer24(0xe80000);
        unsigned char acc = ((ret & 0xff00) >> 8) + 0x20 * 4;
        static unsigned char accmin = 0, accmax = 0;
        if (!accmin && !accmax) {
            accmin = acc;
            accmax = acc;
        } else {
            if (acc < accmin) {
                accmin = acc;
            }
            if (acc > accmax) {
                accmax = acc;
            }
        }
        int range = accmax - accmin;
        if (!range) range++;
        unsigned char val = (int)(acc - accmin) * 8 / range;
        if (val > 7) val = 7;
        static unsigned char oldval = -1;
        if (oldval != val) {
            printf("out_x=%x acc=%x min=%x max=%x val=%x\n", ret, acc, accmin, accmax, val);
        }
        oldval = val;
        unsigned char led_out = 1 << val;
        io->led = led_out;
    }
    return 0;
}
int whoami() {
    io->led = 0x55;
    unsigned short ret = 0;
    unsigned short exp;
    exp = 0x33;
    ret = spi_transfer16(0x8f00);
    io->led = ret;
    if ((ret & 0xff) != exp) {
        printf("Bad Whoami %x expected %x\n", ret, exp);
        return 1;
    } else {
        printf("Whoami returned %x\n", ret);
        return 0;
    }
}
int main(void)
{
    if (!io->board_id) {
        return simu();
    }

    unsigned t=0,t0=0;
    printf("Welcome to DarkRISCV!\n\n");
    if (!whoami()) {
        sensor();
    }
    // main loop
    while(1)
    {
        char  buffer[32];
        memset(buffer,0,sizeof(buffer));
        t = io->timeus;
        printf("%d> ",t-t0);
        gets(buffer,sizeof(buffer));
//        printf("You entered [%s]\n", buffer);
        char *argv[8] = {0, 0, 0, 0, 0, 0, 0, 0};
        int   argc;

        for(argc=0;argc<8 && (argv[argc]=strtok(argc==0?buffer:NULL," "));argc++)
#if 0
        printf("argc=%d:", argc);
        for(argc=0;argc<8 && argv[argc]; argc++) printf(" [%s]", argv[argc]);
        printf("\n");
#endif
        if(argv[0]) {
            if (!strcmp("whoami", argv[0])) {
                whoami();
            } else if (!strcmp("led", argv[0])) {
                printf("led was %x\n", io->led);
                io->led = ~io->led;
            } else if (!strcmp("sensor", argv[0])) {
                sensor();
            } else if(!strcmp(argv[0],"reboot")) {
                printf("rebooting...\n");
                break;
            } else if(!strcmp(argv[0],"oport")) {
                if(argv[1]) io->oport = xtoi(argv[1]);
                printf("oport = %x\n", io->oport);
            } else if(!strcmp(argv[0],"iport")) {
                printf("iport = %x\n", io->iport);
            } else if(!strcmp(argv[0],"ioport")) {
                if(argv[1]) {
                    io->oport = xtoi(argv[1]);
                    printf("iport = %x\n", io->iport);
                }
            } else {
                printf("Error: You entered [%s]\n", buffer);
            }
        }
        t0 = t;
    }
    return 0;
}
