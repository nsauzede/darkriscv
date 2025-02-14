`timescale 1ns / 1ps
`ifndef TOP_VCD
`define TOP_VCD "top.vcd"
`endif
module top_tb;
    parameter integer SHIFT = 0; // Counter shift to increment the address
    reg clk = 0;
//    reg rx = 0;
    wire tx;
    wire CLK12M;
    wire USER_BTN;
    wire [7:0] LED;
//    wire [8:1] PIO;
    wire [5:0] BDBUS;
//    wire [14:0] D;

    reg [3:0] buttons = 0;
    localparam clk_period = 10;
    top #(
		  .SHIFT(SHIFT) // Counter shift to increment the address
    ) top1 (
        .CLK12M(CLK12M),
        .USER_BTN(USER_BTN),
        .LED(LED),
        .PIO(),
        .BDBUS(BDBUS),
        .D()
    );
    assign CLK12M = clk;
    assign tx = 1'b0;
    assign BDBUS[0] = tx;
    assign USER_BTN = ~buttons[0];
    initial begin
        forever begin
            clk = 1'b0;
            #(clk_period / 2);
            clk = 1'b1;
            #(clk_period / 2);
        end
    end
    initial begin
        $dumpfile(`TOP_VCD);
        $dumpvars(0, top1);
        // Hold reset state for 100 ns
        #100;

        // Insert stimulus
        buttons[0] = 1'b1;
        #(clk_period * 2);
        buttons[0] = 1'b0;

        // Additional stimulus or waiting
        #(clk_period * 10);

        // Wait indefinitely
		  #1000
        $finish;
    end
endmodule

