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

`timescale 1ns / 1ps
//`include "../../../rtl/config.vh"

module i2c_master #( parameter integer DIV_COEF = 0 ) (
    input wire clk_in, // Logic clock
    input wire nrst,   // SPI is active when nreset is HIGH

    output reg i2c_sck,  // SPI clock output
    output reg i2c_mosi, // SPI master data output, slave data input
    input wire i2c_miso, // SPI master data input, slave data output
    output reg i2c_csn,  // SPI CSN output (active LOW)

    input wire [31:0] mosi_data, // Parallel FPGA data write to SPI
    output reg [31:0] miso_data, // Parallel FPGA data read from SPI
    input wire [5:0] nbits,      // Number of bits: nbits==0 means 1 bit

    input wire request, // Request to start transfer: Active HIGH
    output reg ready    // Active HIGH when transfer has finished
);

localparam div_coef = (DIV_COEF == 0) ? 32'd10000 : DIV_COEF;

// Frequency divider
reg [31:0] divider;
reg divider_out;
always @(posedge clk_in or negedge nrst) begin
    if (nrst == 1'b0) begin
        divider <= 32'b0;
        divider_out <= 1'b0;
    end else begin
        if (divider != div_coef) begin
            divider <= divider + 1;
            divider_out <= 1'b0;
        end else begin
            divider <= 32'b0;
            divider_out <= 1'b1;
        end
    end
end

localparam
    STATE_Idle = 4'd0,
    STATE_Run = 4'd1,
    STATE_High = 4'd2,
    STATE_Low = 4'd3,
    STATE_Finish = 4'd4,
    STATE_End = 4'd5;

reg [3:0] state;
reg [31:0] data_in_reg;
reg [5:0] nbits_reg;
reg [5:0] bit_counter;

always @(posedge clk_in or negedge nrst)
    if (nrst == 1'b0) begin
        i2c_csn <= 1'b1;
        i2c_sck <= 1'b1;
        i2c_mosi <= 1'b1;
        ready <= 1'b0;
        miso_data <= 32'b0;

        data_in_reg <= 32'b0;
        nbits_reg <= 6'b0;
        bit_counter <= 6'b0;

        state <= STATE_Idle;
    end else begin
        case (state)
            STATE_Idle: begin
                if (request) begin
                    state <= STATE_Run;
                    ready <= 1'b0;
                    i2c_csn <= 1'b0;
                    data_in_reg <= mosi_data;
                    nbits_reg <= nbits;
                    bit_counter <= nbits;
                    miso_data <= 32'b0;
                end
            end

            // Shift left output data word to align MSBit to position 31
            STATE_Run: begin
                if (nbits_reg == 6'b011111) begin
                    state <= STATE_High;
                end else begin
                    data_in_reg <= data_in_reg << 1;
                    nbits_reg <= nbits_reg + 6'b1;
                end
            end

            // During this state SCK is High
            // Transition to SCK=LOW and output MOSI data in position 31
            STATE_High: if (divider_out) begin
                state <= STATE_Low;
                i2c_sck <= 1'b0;
                i2c_mosi <= data_in_reg[31];
            end

            // During this state SCK is LOW & DATA is in the MOSI line
            // Transition to SCK==HIGH and sample MISO line
            STATE_Low: if (divider_out) begin
                if (bit_counter == 6'b0) begin
                    state <= STATE_Finish;
                end else begin
                    state <= STATE_High;
                    bit_counter <= bit_counter - 6'b1;
                    data_in_reg <= data_in_reg << 1'b1; // this must be out of the if (counter==0)?
                end
                i2c_sck <= 1'b1;
                miso_data <= {miso_data[30:0], i2c_miso}; // Sample MISO at SCK posedge
            end

            STATE_Finish: if (divider_out) begin
                state <= STATE_End;
                i2c_csn <= 1'b1;
                i2c_sck <= 1'b1;
                i2c_mosi <= 1'b0;
            end

            STATE_End: if (divider_out) begin
                state <= STATE_Idle;
                ready <= 1'b1;
            end
        endcase
    end
endmodule
