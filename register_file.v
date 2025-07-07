// src/core/register_file.v
module register_file (
    input  wire        clk,
    input  wire        write_enable,
    input  wire [4:0]  rs1,
    input  wire [4:0]  rs2,
    input  wire [4:0]  rd,
    input  wire [31:0] write_data,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);
    reg [31:0] regs [0:31];  // 32 registers, 32-bit each

    // Read operations (combinational)
    assign read_data1 = (rs1 != 0) ? regs[rs1] : 32'b0;  // x0 always 0
    assign read_data2 = (rs2 != 0) ? regs[rs2] : 32'b0;

    // Write operation (synchronous)
    always @(posedge clk) begin
        if (write_enable && rd != 0)
            regs[rd] <= write_data;  // x0 is hardwired to 0
    end
endmodule
