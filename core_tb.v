// tb/core_tb.v
`timescale 1ns/1ps

module core_tb;

    reg clk, reset, pc_write_enable;
    wire [31:0] pc;
    wire [31:0] instruction;
    reg [31:0] next_pc;

    // Instantiate PC
    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_write_enable(pc_write_enable),
        .pc_next(next_pc),
        .pc_current(pc)
    );

    // Instantiate Instruction ROM
    instr_rom rom_inst (
        .addr(pc),
        .instr(instruction)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns period

    initial begin
        // Prepare instruction memory
        $display("Starting simulation...");
        $dumpfile("core_tb.vcd");
        $dumpvars(0, core_tb);

        // Test sequence
        reset = 1;
        pc_write_enable = 0;
        next_pc = 0;

        #10 reset = 0;
        pc_write_enable = 1;

        // Increment PC every cycle
        repeat (5) begin
            next_pc = next_pc + 4;
            #10;
        end

        $finish;
    end
endmodule
