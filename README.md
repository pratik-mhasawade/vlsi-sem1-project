
# 🚀 RISC-V Harvard Architecture Microcontroller with Wishbone Peripherals

A modular, pipelined 32-bit RISC-V microcontroller designed in Verilog HDL with Harvard architecture and Wishbone interconnect. This design is suitable for FPGA prototyping, learning CPU design, or embedded research.

---

## 📐 Architecture Overview

- **Architecture**: Harvard (Separate instruction and data paths)
- **ISA**: RISC-V (RV32I subset)
- **Pipeline**: 5 Stages — IF, ID, EX, MEM, WB
- **Bus**: Wishbone Interconnect
- **Peripherals**: UART, GPIO, Timer (Wishbone Slaves)

---

## 🔄 Pipeline Stages Explained

| Stage | Components           | Function |
|-------|----------------------|----------|
| **IF** (Instruction Fetch) | `pc.v`, `instr_rom.v` | Fetches instruction from ROM using PC |
| **ID** (Instruction Decode) | `control_unit.v`, `register_file.v`, `id_stage.v` | Decodes opcode, reads registers, and generates immediate values |
| **EX** (Execute) | `alu.v`, `alu_control.v`, `ex_stage.v` | Performs arithmetic, logic, branch conditions |
| **MEM** (Memory Access) | `mem_stage.v`, `wishbone_interconnect.v` | Handles data memory and peripherals using Wishbone bus |
| **WB** (Writeback) | `wb_stage.v` | Writes result back to register file |

### 📊 Data Flow Summary

1. **Instruction Fetch**: PC fetches instruction from `instr_rom`.
2. **Decode**: `control_unit` decodes it. `register_file` supplies operands.
3. **Execute**: ALU does arithmetic/logic. Branch decisions are evaluated.
4. **Memory Access**: Loads/stores go to RAM/Peripherals via Wishbone bus.
5. **Writeback**: Result (ALU or memory) is written back to register file.

---

## 📁 Directory Structure

```bash
riscv_microcontroller/
├── src/
│   ├── core/                 # CPU Core Logic
│   ├── memory/               # Instruction ROM
│   ├── bus/                  # Wishbone interconnect
│   └── peripherals/          # UART, GPIO, Timer (Wishbone compliant)
├── sim/                      # Simulation
│   ├── cpu_tb.v
│   └── instr_mem.hex         # RISC-V Program Memory
├── docs/                     # Diagrams & Reports
├── README.md
```

---

## 🧠 Peripherals (Wishbone-Mapped)

| Peripheral | Address Base   | Registers            |
|------------|----------------|----------------------|
| RAM        | `0x00000000`   | Word-addressed       |
| UART       | `0x10000000`   | `TX_DATA`, `STATUS`  |
| GPIO       | `0x20000000`   | `GPIO_DATA`, `DIR`   |
| TIMER      | `0x30000000`   | `LOAD`, `CTRL`       |

---

## 🛠️ Build & Simulate

### 🔧 Requirements
- Icarus Verilog / ModelSim / Vivado Simulator

### 🏗️ Compile & Run
```bash
# Compile
iverilog -o cpu_tb sim/cpu_tb.v src/**/*.v

# Run Simulation
vvp cpu_tb
```

---

## 📘 Example Usage (Assembly)
```assembly
# Toggle GPIO pin
li t0, 0x20000000     # GPIO_DATA address
li t1, 0x01
sw t1, 0(t0)          # Turn ON first GPIO pin

# Send UART byte
li t0, 0x10000000     # UART TX address
li t1, 0x41           # ASCII 'A'
sw t1, 0(t0)
```

---

## 🔜 To-Do / Extensions

- [x] Branch support (`beq`)
- [x] Memory-mapped I/O via Wishbone
- [x] Peripherals: UART, GPIO, Timer
- [ ] Instruction forwarding (Hazard resolution)
- [ ] Interrupt support
- [ ] RV32M and compressed ISA extension

---

## 👨‍💻 Author
**Pratik Uttam Mhasawade**  
Electronics & Telecommunication Engineering (VLSI)

---

## 📝 License
Open-source under MIT License
