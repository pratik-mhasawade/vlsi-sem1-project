// src/core/alu_control.v
module alu_control (
    input  wire [1:0] alu_op_main,   // Main control signal (from control unit)
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg  [3:0] alu_op
);
    always @(*) begin
        case (alu_op_main)
            2'b00: alu_op = 4'b0010; // LW/SW: ADD
            2'b01: alu_op = 4'b0110; // BEQ: SUB
            2'b10: begin             // R-type/I-type ALU
                case ({funct7, funct3})
                    10'b0000000_000: alu_op = 4'b0010; // ADD
                    10'b0100000_000: alu_op = 4'b0110; // SUB
                    10'b0000000_111: alu_op = 4'b0000; // AND
                    10'b0000000_110: alu_op = 4'b0001; // OR
                    default: alu_op = 4'b0000;
                endcase
            end
            default: alu_op = 4'b0000;
        endcase
    end
endmodule
