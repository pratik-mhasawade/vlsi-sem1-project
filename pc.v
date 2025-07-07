// src/core/pc.v
module pc (
    input  wire        clk,
    input  wire        reset,
    input  wire        pc_write_enable,
    input  wire [31:0] pc_next,
    output reg  [31:0] pc_current
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_current <= 32'h00000000;
        else if (pc_write_enable)
            pc_current <= pc_next;
    end
endmodule

