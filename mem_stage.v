
// src/core/mem_stage.v (updated with Wishbone master interface)
module mem_stage (
    input  wire        clk,
    input  wire        rst,
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire [31:0] alu_result,
    input  wire [31:0] write_data,
    output wire [31:0] mem_read_data,

    // Wishbone master interface
    output wire [31:0] wb_addr,
    output wire [31:0] wb_data_out,
    input  wire [31:0] wb_data_in,
    output wire        wb_we,
    output wire        wb_stb,
    output wire        wb_cyc,
    input  wire        wb_ack
);

    assign wb_addr      = alu_result;
    assign wb_data_out  = write_data;
    assign wb_we        = mem_write;
    assign wb_stb       = mem_read | mem_write;
    assign wb_cyc       = mem_read | mem_write;
    assign mem_read_data = wb_data_in;

endmodule

