

// src/peripherals/timer.v
module timer (
    input  wire        clk,
    input  wire        rst,
    input  wire        wb_cyc,
    input  wire        wb_stb,
    input  wire        wb_we,
    input  wire [31:0] wb_addr,
    input  wire [31:0] wb_data_i,
    output reg  [31:0] wb_data_o,
    output reg         wb_ack
);
    reg [31:0] counter;
    reg [31:0] reload_val;
    reg        enabled;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter    <= 0;
            reload_val <= 0;
            enabled    <= 0;
            wb_ack     <= 0;
        end else begin
            wb_ack <= 0;

            if (enabled) begin
                if (counter > 0)
                    counter <= counter - 1;
                else
                    counter <= reload_val;
            end

            if (wb_cyc && wb_stb && !wb_ack) begin
                wb_ack <= 1;
                if (wb_we) begin
                    case (wb_addr[3:2])
                        2'b00: reload_val <= wb_data_i;
                        2'b01: enabled    <= wb_data_i[0];
                    endcase
                end else begin
                    case (wb_addr[3:2])
                        2'b00: wb_data_o <= counter;
                        2'b01: wb_data_o <= {31'b0, enabled};
                    endcase
                end
            end
        end
    end
endmodule
