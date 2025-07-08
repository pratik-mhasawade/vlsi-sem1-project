
// src/peripherals/gpio.v
module gpio (
    input  wire        clk,
    input  wire        rst,
    input  wire        wb_cyc,
    input  wire        wb_stb,
    input  wire        wb_we,
    input  wire [31:0] wb_addr,
    input  wire [31:0] wb_data_i,
    output reg  [31:0] wb_data_o,
    output reg         wb_ack,
    inout  wire [7:0]  gpio_pins
);
    reg [7:0] gpio_data;
    reg [7:0] gpio_dir;

    assign gpio_pins = gpio_dir ? gpio_data : 8'bz;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            gpio_data <= 8'b0;
            gpio_dir  <= 8'b0;
            wb_ack    <= 0;
        end else begin
            wb_ack <= 0;
            if (wb_cyc && wb_stb && !wb_ack) begin
                wb_ack <= 1;
                if (wb_we) begin
                    case (wb_addr[3:2])
                        2'b00: gpio_data <= wb_data_i[7:0];
                        2'b01: gpio_dir  <= wb_data_i[7:0];
                    endcase
                end else begin
                    case (wb_addr[3:2])
                        2'b00: wb_data_o <= {24'b0, gpio_pins};
                        2'b01: wb_data_o <= {24'b0, gpio_dir};
                    endcase
                end
            end
        end
    end
endmodule
