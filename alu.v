// src/core/alu.v
module alu (
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [3:0]  alu_op,    // ALU operation code
    output reg  [31:0] result,
    output wire        zero       // Zero flag (used in branch)
);
    always @(*) begin
        case (alu_op)
            4'b0000: result = a & b;         // AND
            4'b0001: result = a | b;         // OR
            4'b0010: result = a + b;         // ADD
            4'b0110: result = a - b;         // SUB
            4'b0111: result = (a < b) ? 1 : 0; // SLT
            4'b1100: result = ~(a | b);      // NOR
            default: result = 32'b0;
        endcase
    end

    assign zero = (result == 0);

endmodule
