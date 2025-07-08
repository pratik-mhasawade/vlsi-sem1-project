// src/bus/wishbone_interconnect.v
module wishbone_interconnect (
    input  wire [31:0] addr,
    input  wire [31:0] data_in,
    output reg  [31:0] data_out,
    input  wire        we,
    input  wire        stb,
    input  wire        cyc,
    output reg         ack,

    // RAM
    output wire [31:0] ram_addr,
    output wire [31:0] ram_data_in,
    input  wire [31:0] ram_data_out,
    output wire        ram_we,
    output wire        ram_stb,
    output wire        ram_cyc,
    input  wire        ram_ack,

    // UART
    output wire        uart_we,
    output wire        uart_stb,
    output wire        uart_cyc,
    input  wire        uart_ack,
    output wire [31:0] uart_data_in,
    input  wire [31:0] uart_data_out,

    // GPIO
    output wire        gpio_we,
    output wire        gpio_stb,
    output wire        gpio_cyc,
    input  wire        gpio_ack,
    output wire [31:0] gpio_data_in,
    input  wire [31:0] gpio_data_out
);

    // Peripheral selection
    wire sel_ram  = (addr[31:12] == 20'h00000); // 0x00000000 - 0x00000FFF
    wire sel_uart = (addr[31:12] == 20'h10000); // 0x10000000 - 0x10000FFF
    wire sel_gpio = (addr[31:12] == 20'h20000); // 0x20000000 - 0x20000FFF

    // Default
    assign ram_addr     = addr;
    assign ram_data_in  = data_in;
    assign ram_we       = we && sel_ram;
    assign ram_stb      = stb && sel_ram;
    assign ram_cyc      = cyc && sel_ram;

    assign uart_we      = we && sel_uart;
    assign uart_stb     = stb && sel_uart;
    assign uart_cyc     = cyc && sel_uart;
    assign uart_data_in = data_in;

    assign gpio_we      = we && sel_gpio;
    assign gpio_stb     = stb && sel_gpio;
    assign gpio_cyc     = cyc && sel_gpio;
    assign gpio_data_in = data_in;

    always @(*) begin
        ack = 0;
        data_out = 32'h00000000;

        if (sel_ram) begin
            ack = ram_ack;
            data_out = ram_data_out;
        end else if (sel_uart) begin
            ack = uart_ack;
            data_out = uart_data_out;
        end else if (sel_gpio) begin
            ack = gpio_ack;
            data_out = gpio_data_out;
        end
    end
endmodule

