`timescale 1ns / 1ps
`include "../../rtl/config.vh"

module dut #(
    parameter integer BOARD_CK = 32000000,
    parameter INIT_FILE = "../darkriscv/src/darksocv_padded.hex"
) (
    input rx,
    output tx,
`ifdef SPI
        input spi_miso,
        output spi_mosi,
        output spi_csn,
        output spi_sck,
`endif
    output [7:0] leds,
    input reset,
    input clk
);

	 darksocv soc0 (
		.UART_RXD(rx),  // UART receive line
		.UART_TXD(tx),  // UART transmit line

		.LED(leds),       // on-board leds
//		.DEBUG(leds[7:4]),      // osciloscope
`ifdef SPI
    .spi_miso(spi_miso),
    .spi_mosi(spi_mosi),
    .spi_csn(spi_csn),
    .spi_sck(spi_sck),
`endif

		.XCLK(clk),      // external clock
		.XRES(reset)      // external reset
	);

`ifdef SPI
`ifdef SIMULATION
lis3dh_stub lis3dh_stub0 (
        .clk(clk),
        .sck(spi_sck),
        .cs(spi_csn),
        .mosi(spi_mosi),
        .miso(spi_miso)
);
`endif
`endif
endmodule
