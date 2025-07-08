# vlsi-sem1-project
Harvard architecture RISC-V microcontroller with a 5-stage pipeline, Wishbone interconnect, and all standard microcontroller peripherals 
# 🚀 RISC-V Harvard Architecture Microcontroller (5-Stage Pipelined)

A simple, open-source RISC-V microcontroller core designed using Verilog HDL.  
Implements a **Harvard architecture** with a classic **5-stage pipeline**, integrated instruction/data memory, and essential control logic.

Perfect for learning, teaching, and extending toward FPGA-based SoC designs.

---

## 📐 Architecture Overview

- **Architecture Type**: Harvard
- **ISA**: RISC-V (RV32I subset)
- **Pipeline Stages**: 5 (IF, ID, EX, MEM, WB)
- **Pipeline Type**: Classic
- **Word Size**: 32-bit
- **Memory Interface**: Separate Instruction and Data Memory
- **Bus Interface**: Wishbone (Planned for peripheral expansion)

---

## 🔁 Pipeline Stages Explained

| Stage | Module(s) | Function |
|-------|-----------|----------|
| **IF** (Instruction Fetch) | `pc.v`, `instr_rom.v` | Fetch instruction from ROM using the Program Counter |
| **ID** (Instruction Decode) | `id_stage.v`, `register_file.v` | Decode instruction, extract fields, read registers, generate immediate |
| **EX** (Execute) | `ex_stage.v`, `alu.v`, `alu_control.v` | Perform arithmetic, logic, and branch comparison |
| **MEM** (Memory Access) | `mem_stage.v` | Read from / Write to data memory (`lw`, `sw`) |
| **WB** (Writeback) | `wb_stage.v` | Write result back to register file |

---

## 🧠 Control Unit

The `control_unit.v` generates all control signals based on instruction opcode:

| Instruction | Signals |
|-------------|---------|
| R-type      | ALU ops, reg write |
| I-type      | ALU ops, reg write |
| LW          | Memory read, reg write |
| SW          | Memory write |
| BEQ         | Branch logic |

---

## 📁 Project Structure
---

riscv_microcontroller/
├── src/
│ ├── core/
│ │ ├── cpu_core.v
│ │ ├── pc.v
│ │ ├── alu.v
│ │ ├── alu_control.v
│ │ ├── ex_stage.v
│ │ ├── id_stage.v
│ │ ├── wb_stage.v
│ │ ├── control_unit.v
│ │ ├── register_file.v
│ │ ├── mem_stage.v
│ ├── memory/
│ │ └── instr_rom.v
├── sim/
│ ├── cpu_tb.v
│ └── instr_mem.hex
├── README.md
