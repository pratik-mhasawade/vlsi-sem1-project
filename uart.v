// src/peripherals/uart.v
module uart (
    input  wire        clk,
    input  wire        rst,
    input  wire        wb_cyc,
    input  wire        wb_stb,
    input  wire        wb_we,
    input  wire [31:0] wb_addr,
    input  wire [31:0] wb_data_i,
    output reg  [31:0] wb_data_o,
    output reg         wb_ack,
    output wire        tx,
    input  wire        rx
);
    reg [7:0] tx_data;
    reg       tx_ready;

    assign tx = tx_data[0]; // Placeholder

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wb_ack   <= 0;
            tx_data  <= 8'b0;
            tx_ready <= 0;
        end else begin
            wb_ack <= 0;
            if (wb_cyc && wb_stb && !wb_ack) begin
                wb_ack <= 1;
                if (wb_we) begin
                    tx_data <= wb_data_i[7:0];
                    tx_ready <= 1;
                end else begin
                    wb_data_o <= {24'b0, tx_data};
                end
            end
        end
    end
endmodule
