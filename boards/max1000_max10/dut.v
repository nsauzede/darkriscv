`timescale 1ns / 1ps
`include "../../rtl/config.vh"

`ifdef SPI
`define SENSOR
`elsif I2C
`define SENSOR
`endif

module dut (
    input rx,
    output tx,
`ifdef SENSOR                   //              SPI         I2C
    inout sen_sdi,              // SDA/SDI/SDO  O MOSI     IO SDA
    inout sen_sdo,              // SDO/SA0      I MISO     IO (SA0)
    output sen_spc,             // SCL/SPC      O SCK       O SCL
    output sen_cs,              // CS           O CSN       O (1)
`endif
    inout [8:1] pio,
    output [31:0] leds,
    input reset,
    input clk
);
    wire [31:0] oport;
    wire [31:0] iport;
    darksocv soc0 (
        .UART_RXD(rx),          // UART receive line
        .UART_TXD(tx),          // UART transmit line
`ifdef SPI
        .SPI_MOSI(sen_sdi),     // SPI master data output, slave data input
        .SPI_MISO(sen_sdo),     // SPI master data input, slave data output
        .SPI_SCK(sen_spc),      // SPI clock output
        .SPI_CSN(sen_cs),       // SPI CSN output (active LOW)
`endif
`ifndef I2C
`ifndef SPIBB_
        .LED(leds),             // on-board leds
`endif
`endif
        .IPORT(iport),
        .OPORT(oport),

        .XCLK(clk),             // external clock
        .XRES(reset)            // external reset
    );
`ifdef I2C
    wire [3:0] pmbuttons;
    wire [3:0] pmleds;

    assign leds = {24'b0, oport[3:0], iport[3:0]};

    wire sda_oe, scl_oe;
    wire i2c_scl, i2c_sda;

    assign pmleds = {2'b0, sen_sdi, sen_sdo};
    assign iport = {30'b0, sen_sdi, sen_sdo};
    assign scl_oe = oport[3];
    assign sda_oe = oport[2];
    assign i2c_sda = oport[1];
    assign i2c_scl = oport[0];

    assign sen_sdi = sda_oe ? i2c_sda : 1'bz;   // SDA/SDI/SDO  O MOSI     IO SDA
    assign sen_sdo = 1'bz;                      // SDO/SA0      I MISO      I (SA0)
    assign sen_spc = scl_oe ? i2c_scl : 1'bz;   // SCL/SPC      O SCK       O SCL
    assign sen_cs = 1'b1;                       // CS           O CSN       O (1)

    pmodbutled pmodbutled1(
        .pio(pio),
        .buttons(pmbuttons),
        .leds(pmleds)
    );
`elsif SPIBB_    //TODO: add LIS3DH stub + SPI BB wiring
    wire [15:0] out_x_l_response;
    wire oe;
    wire mosi;                                  // SDA/SDI/SDO  O MOSI     IO SDA
    wire miso;                                  // SDO/SA0      I MISO      I (SA0)
    wire sck;                                   // SCL/SPC      O SCK       O SCL
    wire csn;                                   // CS           O CSN       O (1)
    assign leds = {11'b0, out_x_l_response, oport[19:16], iport[0]};
    assign iport = {31'b0, miso};
    assign oe = oport[19];
    assign mosi = oport[18];
    assign sck = oport[17];
    assign csn = oport[16];
    assign out_x_l_response = oport[15:0];
    lis3dh_stub lis3dh_stub0 (
        .out_x_l_response(out_x_l_response),
        .clk(clk),
        .mosi(oe ? mosi : 1'bz),
        .miso(miso),
        .sck(oe ? sck : 1'bz),
        .cs(oe ? csn : 1'bz)
    );
`else
    wire [3:0] pmbuttons;
    wire [3:0] pmleds;
    assign pmleds = oport[3:0];
    assign iport[3:0] = pmbuttons;
    assign iport[31:4] = 0;
    pmodbutled pmodbutled1(
        .pio(pio),
        .buttons(pmbuttons),
        .leds(pmleds)
    );
`endif
endmodule
