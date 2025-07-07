// src/memory/instr_rom.v
module instr_rom (
    input  wire [31:0] addr,
    output wire [31:0] instr
);

    // ROM: 256 instructions = 1 KB
    reg [31:0] memory [0:255];

    initial begin
        $readmemh("instr_mem.hex", memory); // Hex file with instructions
    end

    assign instr = memory[addr[9:2]]; // Word-aligned access (addr / 4)

endmodule
