// src/core/wb_stage.v
module wb_stage (
    input  wire        mem_to_reg,     // 1: use memory data, 0: use ALU result
    input  wire [31:0] alu_result,
    input  wire [31:0] read_data,
    output wire [31:0] writeback_data
);

    assign writeback_data = (mem_to_reg) ? read_data : alu_result;

endmodule
