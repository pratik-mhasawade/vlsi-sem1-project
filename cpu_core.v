// src/core/cpu_core.v
module cpu_core (
    input  wire clk,
    input  wire reset

    // Wishbone master interface
    output wire [31:0] wb_addr,
    output wire [31:0] wb_data_out,
    input  wire [31:0] wb_data_in,
    output wire        wb_we,
    output wire        wb_stb,
    output wire        wb_cyc,
    input  wire        wb_ack,
);


    // Internal wires
    wire [31:0] alu_result;
    wire [31:0] write_data;
    wire [31:0] mem_data_out;
    wire        mem_read;
    wire        mem_write;

    
    // Instantiate MEM stage with Wishbone signals
    mem_stage mem_stage_inst (
        .clk(clk),
        .rst(rst),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_result(alu_result),
        .write_data(write_data),
        .mem_read_data(mem_data_out),
        .wb_addr(wb_addr),
        .wb_data_out(wb_data_out),
        .wb_data_in(wb_data_in),
        .wb_we(wb_we),
        .wb_stb(wb_stb),
        .wb_cyc(wb_cyc),
        .wb_ack(wb_ack)
    );

    // ----------------- IF Stage -----------------
    wire [31:0] pc_current, pc_next, instruction;

    reg pc_write_enable = 1'b1; // Always enabled for now

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_write_enable(pc_write_enable),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );

    instr_rom instr_mem (
        .addr(pc_current),
        .instr(instruction)
    );

    assign pc_next = pc_current + 4; // Simple sequential fetch

    // ----------------- ID Stage -----------------
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;
    wire [6:0] funct7, opcode;
    wire [31:0] imm_out;
    wire [31:0] reg_data1, reg_data2;

    id_stage id_stage_inst (
        .instr(instruction),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .imm_out(imm_out),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );

    register_file reg_file (
        .clk(clk),
        .write_enable(reg_write_enable),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(writeback_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // ----------------- Control Signals (Simple Decoder) -----------------
    wire alu_src, mem_to_reg, mem_read, mem_write, reg_write_enable;
    wire [1:0] alu_op_main;

    control_unit control (
        .opcode(opcode),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write_enable(reg_write_enable),
        .alu_op_main(alu_op_main)
    );

    // ----------------- EX Stage -----------------
    wire [31:0] alu_result;
    wire zero;

    ex_stage ex_stage_inst (
        .reg_data1(reg_data1),
        .reg_data2(reg_data2),
        .imm(imm_out),
        .alu_src(alu_src),
        .alu_op_main(alu_op_main),
        .funct3(funct3),
        .funct7(funct7),
        .alu_result(alu_result),
        .zero(zero)
    );

    // ----------------- MEM Stage -----------------
    wire [31:0] mem_read_data;

    mem_stage mem_stage_inst (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_result(alu_result),
        .write_data(reg_data2),
        .read_data(mem_read_data)
    );

    // ----------------- WB Stage -----------------
    wire [31:0] writeback_data;

    wb_stage wb_stage_inst (
        .mem_to_reg(mem_to_reg),
        .alu_result(alu_result),
        .read_data(mem_read_data),
        .writeback_data(writeback_data)
    );

endmodule




// src/core/cpu_core.v (partial update - connecting Wishbone signals)
module cpu_core (
    input  wire        clk,
    input  wire        rst,
    // Wishbone master interface
    output wire [31:0] wb_addr,
    output wire [31:0] wb_data_out,
    input  wire [31:0] wb_data_in,
    output wire        wb_we,
    output wire        wb_stb,
    output wire        wb_cyc,
    input  wire        wb_ack,
    // ... other signals
);

    // Internal wires
    wire [31:0] alu_result;
    wire [31:0] write_data;
    wire [31:0] mem_data_out;
    wire        mem_read;
    wire        mem_write;

    // Instantiate MEM stage with Wishbone signals
    mem_stage mem_stage_inst (
        .clk(clk),
        .rst(rst),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_result(alu_result),
        .write_data(write_data),
        .mem_read_data(mem_data_out),
        .wb_addr(wb_addr),
        .wb_data_out(wb_data_out),
        .wb_data_in(wb_data_in),
        .wb_we(wb_we),
        .wb_stb(wb_stb),
        .wb_cyc(wb_cyc),
        .wb_ack(wb_ack)
    );

    // ... remaining pipeline stages, control, register file, etc.
endmodule
