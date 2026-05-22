# 4-STAGE PIPELINE PROCESSOR DESIGN 

*COMPANY*: CODTECH IT SOLUTIONS

*NAME*: KOTHURI MURALI KRISHNA 

*INTERN ID*: CTIS9479

*DOMAIN*: VLSI

*DURATION*: 6 WEEEKS

*MENTOR*: NEELA SANTOSH


# DESCRIPTION

To design and implement a simple 4-stage pipelined processor using Verilog HDL that supports basic instructions such as:

-> ADD

-> SUB

-> LOAD

and verify its functionality through simulation showing the operation of each pipeline stage.

-> A pipelined processor divides instruction execution into stages so multiple instructions execute simultaneously in different stages.

#4 Stages Used:

| Stage   | Name                    | Function                                  |
| ------- | ----------------------- | ----------------------------------------- |
| Stage 1 | IF (Instruction Fetch)  | Fetch instruction from memory             |
| Stage 2 | ID (Instruction Decode) | Decode instruction and read registers     |
| Stage 3 | EX (Execute)            | Perform ALU operation/address calculation |
| Stage 4 | WB (Write Back)         | Store result back into register           |

#Major Blocks:

-> Program Counter (PC)

-> Instruction Memory

-> Register File

-> ALU

-> Pipeline Registers

-> Write Back Unit


#Data Flow:

-> Instruction fetched from memory.

-> Decoded into opcode and operands.

-> ALU executes operation.

-> Result written back to register.


#Registers:

Pipeline registers store intermediate data between stages.

| Register | Between                |
| -------- | ---------------------- |
| IF/ID    | Fetch and Decode       |
| ID/EX    | Decode and Execute     |
| EX/WB    | Execute and Write Back |


#Observations:

Cycle 1

-> LOAD instruction fetched.

Cycle 2

-> LOAD decoded.

-> Next instruction fetched.

Cycle 3

-> LOAD executed.

-> Second instruction decoded.

Cycle 4

-> Result written back to register.

This overlapping of instructions increases processor efficiency.


# OUTPUT

1. RTL DESIGN:


2. TCL CONSOLE SIMULATION:


3. SIMULATION WAVEFORM:


