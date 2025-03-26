`timescale 1ns / 1ps
`include "../../rtl/config.vh"

`ifdef SPI
`define SENSOR
`elsif I2C
`define SENSOR
`endif

module top (
    input CLK12M,
    input USER_BTN,
    output [7:0] LED,

`ifdef SENSOR           //              SPI         I2C
    inout SEN_SDI,      // SDA/SDI/SDO  O MOSI     IO SDA
    inout SEN_SDO,      // SDO/SA0      I MISO     IO (SA0)
    output SEN_SPC,     // SCL/SPC      O SCK       O SCL
    output SEN_CS,      // CS           O CSN       O (1)
`endif
    inout [8:1] PIO,
    inout [5:0] BDBUS,
    inout [14:0] D
);
    wire clk;
    pll pll0 (
        .inclk0(CLK12M),
        .c0(clk)
    );
    wire [31:0] leds;
    assign LED = leds[7:0];
    dut dut1 (
        .rx(BDBUS[0]),          // BDBUS[0] is USB UART TX (FPGA RX)
        .tx(BDBUS[1]),          // BDBUS[1] is USB UART RX (FPGA TX)
        .leds(leds),
`ifdef SENSOR
        .sen_sdi(SEN_SDI),
        .sen_sdo(SEN_SDO),
        .sen_spc(SEN_SPC),
        .sen_cs(SEN_CS),
`endif
        .pio(PIO),
        .reset(~USER_BTN),
        .clk(clk)
    );
endmodule
