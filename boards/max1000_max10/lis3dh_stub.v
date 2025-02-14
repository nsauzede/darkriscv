module lis3dh_stub (
    input wire clk,        // System clock
    input wire sck,        // SPI clock
    input wire cs,         // SPI chip select (active low)
    input wire mosi,       // SPI master out slave in
    output reg miso        // SPI master in slave out
);

localparam
    IDLE = 0,
    RECEIVING = 1,
    PROCESSING = 2,
    RESPONDING = 3;
    reg [1:0] state = IDLE;
    reg [7:0] shift_reg = 8'b0;   // Shift register for received data
    reg [7:0] response = 8'b0;    // Response register
    reg [3:0] bit_count = 4'b0;   // Bit counter
    reg sck_d, sck_prev;          // Synchronized and previous SCK values
    reg cs_d, cs_prev;            // Synchronized and previous CS values
    reg mosi_d;                   // Synchronized MOSI

    always @(posedge clk) begin
        // Synchronize inputs to system clock
        sck_prev <= sck_d;
        sck_d <= sck;
        cs_prev <= cs_d;
        cs_d <= cs;
        mosi_d <= mosi;
        case (state)
            IDLE: begin
                if (!cs_d) begin
                    state <= RECEIVING;
                    bit_count <= 0;
                    shift_reg <= 8'b0;
                end
                miso <= 1'bZ;
            end
            RECEIVING: begin
                if (!sck_d && sck_prev) begin // Falling edge of SCK
                    shift_reg <= {shift_reg[6:0], mosi_d};
                    bit_count <= bit_count + 1;
                    if (bit_count == 7) begin
                        state <= PROCESSING;
                    end
                end
            end
            PROCESSING: begin
                if (shift_reg[5:0] == 6'h0F) begin // WHOAMI command (ignore RnW & MnS bits)
                    response <= 8'h33; // LIS3DH WHOAMI response
                end else begin
                    response <= 8'h00; // Default response
                end
                state <= RESPONDING;
                bit_count <= 0;
            end
            RESPONDING: begin
                if (cs_d) begin
                    state <= IDLE;
                end else if (!sck_prev && sck_d) begin // Rising edge of SCK
                    miso <= response[7];
                    response <= {response[6:0], 1'b0};
                    bit_count <= bit_count + 1;
                    if (bit_count == 7) begin
                        response <= 8'h00; // Default response
                    end
                end
            end
        endcase
    end

endmodule
