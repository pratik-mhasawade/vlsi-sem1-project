// src/core/ex_stage.v
module ex_stage (
    input  wire [31:0] reg_data1,
    input  wire [31:0] reg_data2,
    input  wire [31:0] imm,
    input  wire        alu_src,     // 0: reg2, 1: imm
    input  wire [1:0]  alu_op_main,
    input  wire [2:0]  funct3,
    input  wire [6:0]  funct7,
    output wire [31:0] alu_result,
    output wire        zero
);
    wire [31:0] alu_in2;
    wire [3:0] alu_control_out;

    assign alu_in2 = alu_src ? imm : reg_data2;

    // ALU Control Logic
    alu_control alu_ctrl_inst (
        .alu_op_main(alu_op_main),
        .funct3(funct3),
        .funct7(funct7),
        .alu_op(alu_control_out)
    );

    // ALU
    alu alu_inst (
        .a(reg_data1),
        .b(alu_in2),
        .alu_op(alu_control_out),
        .result(alu_result),
        .zero(zero)
    );

endmodule
