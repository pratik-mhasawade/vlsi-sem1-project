// src/core/mem_stage.v
module mem_stage (
    input  wire        clk,
    input  wire        mem_read,       // From control unit
    input  wire        mem_write,      // From control unit
    input  wire [31:0] alu_result,     // Address to access
    input  wire [31:0] write_data,     // Data to write (for stores)
    output wire [31:0] read_data       // Data read from memory (for loads)
);

    reg [31:0] data_mem [0:255];       // 1KB Data Memory

    // Read logic
    assign read_data = (mem_read) ? data_mem[alu_result[9:2]] : 32'b0;

    // Write logic
    always @(posedge clk) begin
        if (mem_write)
            data_mem[alu_result[9:2]] <= write_data;
    end

endmodule
