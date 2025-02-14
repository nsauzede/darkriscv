`timescale 1ns / 1ps
`ifndef DUT_VCD
`define DUT_VCD "dut.vcd"
`endif
module dut_tb;
    // Parameters
    parameter integer BOARD_CK = 32000000;

    localparam clk_period = 10;

    reg clk = 0;
    reg rx = 0;
    wire tx;
    reg reset = 1;
    wire [7:0] leds;

    dut 
	 #(.BOARD_CK(BOARD_CK)) 
	 dut1 (
        .rx(rx),
        .tx(tx),
        .leds(leds),
        .reset(reset),
        .clk(clk)
    );

    // Clock generation
    initial begin
        forever begin
            clk = 1'b0;
            #(clk_period / 2);
            clk = 1'b1;
            #(clk_period / 2);
        end
    end

    // Stimulus process
    initial begin
        $dumpfile(`DUT_VCD);
        $dumpvars(0, dut1);
        #1e3       reset = 1'b0;

        // Wait more and finish
        #510695
        $finish;
    end
endmodule

