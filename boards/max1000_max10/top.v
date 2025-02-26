`timescale 1ns / 1ps
`include "../../rtl/config.vh"

module top (
        input CLK12M,
        input USER_BTN,
        output [7:0] LED,
        inout [8:1] PIO,
`ifdef SPI
        input SEN_SDO,
        output SEN_SDI,
        output SEN_CS,
        output SEN_SPC,
`endif
        inout [5:0] BDBUS,
        inout [14:0] D
);
wire clk;
`ifdef SIMULATION
assign clk = CLK12M;
`else
	pll pll0 (
		.inclk0(CLK12M),
		.c0(clk)
	);
`endif
    dut dut1 (
        .rx(BDBUS[0]),          // BDBUS[0] is USB UART TX (FPGA RX)
        .tx(BDBUS[1]),          // BDBUS[1] is USB UART RX (FPGA TX)
`ifdef SPI
        .spi_miso(SEN_SDO),
        .spi_mosi(SEN_SDI),
        .spi_csn(SEN_CS),
        .spi_sck(SEN_SPC),
`endif
        .leds(LED),
        .reset(~USER_BTN),
        .clk(clk)
    );
endmodule
