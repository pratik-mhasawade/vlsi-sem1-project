// src/core/control_unit.v
module control_unit (
    input  wire [6:0] opcode,
    output reg        alu_src,
    output reg        mem_to_reg,
    output reg        mem_read,
    output reg        mem_write,
    output reg        reg_write_enable,
    output reg [1:0]  alu_op_main
);

    always @(*) begin
        // Default values
        alu_src          = 1'b0;
        mem_to_reg       = 1'b0;
        mem_read         = 1'b0;
        mem_write        = 1'b0;
        reg_write_enable = 1'b0;
        alu_op_main      = 2'b00;

        case (opcode)
            7'b0110011: begin  // R-type (add, sub, and, or)
                alu_src          = 1'b0;
                mem_to_reg       = 1'b0;
                mem_read         = 1'b0;
                mem_write        = 1'b0;
                reg_write_enable = 1'b1;
                alu_op_main      = 2'b10;
            end
            7'b0010011: begin  // I-type (addi, andi, ori)
                alu_src          = 1'b1;
                mem_to_reg       = 1'b0;
                mem_read         = 1'b0;
                mem_write        = 1'b0;
                reg_write_enable = 1'b1;
                alu_op_main      = 2'b10;
            end
            7'b0000011: begin  // Load (lw)
                alu_src          = 1'b1;
                mem_to_reg       = 1'b1;
                mem_read         = 1'b1;
                mem_write        = 1'b0;
                reg_write_enable = 1'b1;
                alu_op_main      = 2'b00;
            end
            7'b0100011: begin  // Store (sw)
                alu_src          = 1'b1;
                mem_to_reg       = 1'bx;
                mem_read         = 1'b0;
                mem_write        = 1'b1;
                reg_write_enable = 1'b0;
                alu_op_main      = 2'b00;
            end
            7'b1100011: begin  // Branch (beq)
                alu_src          = 1'b0;
                mem_to_reg       = 1'bx;
                mem_read         = 1'b0;
                mem_write        = 1'b0;
                reg_write_enable = 1'b0;
                alu_op_main      = 2'b01;
            end
            default: begin
                // NOP or unsupported opcode
                alu_src          = 1'b0;
                mem_to_reg       = 1'b0;
                mem_read         = 1'b0;
                mem_write        = 1'b0;
                reg_write_enable = 1'b0;
                alu_op_main      = 2'b00;
            end
        endcase
    end

endmodule
