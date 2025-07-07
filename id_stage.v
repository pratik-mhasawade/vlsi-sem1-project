// src/core/id_stage.v
module id_stage (
    input  wire [31:0] instr,        // instruction from IF stage
    input  wire [31:0] reg_data1,    // value from rs1
    input  wire [31:0] reg_data2,    // value from rs2
    output wire [4:0]  rs1,          // read register 1 address
    output wire [4:0]  rs2,          // read register 2 address
    output wire [4:0]  rd,           // destination register
    output wire [31:0] imm_out,      // immediate output
    output wire [6:0]  opcode,       // opcode to control unit
    output wire [2:0]  funct3,       // funct3 to ALU
    output wire [6:0]  funct7        // funct7 to ALU
);
    // Extract instruction fields
    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1    = instr[19:15];
    assign rs2    = instr[24:20];
    assign funct7 = instr[31:25];

    // Immediate Generator logic
    wire [31:0] imm_i = {{20{instr[31]}}, instr[31:20]};                              // I-type
    wire [31:0] imm_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};                // S-type
    wire [31:0] imm_b = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type
    wire [31:0] imm_u = {instr[31:12], 12'b0};                                        // U-type
    wire [31:0] imm_j = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; // J-type

    // Select immediate based on opcode
    assign imm_out = (opcode == 7'b0010011 || opcode == 7'b0000011 || opcode == 7'b1100111) ? imm_i : // I-type
                     (opcode == 7'b0100011) ? imm_s :        // S-type (store)
                     (opcode == 7'b1100011) ? imm_b :        // B-type (branch)
                     (opcode == 7'b0110111 || opcode == 7'b0010111) ? imm_u : // LUI/AUIPC
                     (opcode == 7'b1101111) ? imm_j :        // JAL
                     32'b0;

endmodule
