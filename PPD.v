// ============================================================
// 4-Stage Pipeline Processor Design
// Company  : CODTECH IT SOLUTIONS
// Author   : KOTHURI MURALI KRISHNA | Intern ID: CTIS9479
// Domain   : VLSI | Tool: Xilinx Vivado | Language: Verilog
// Stages   : IF → ID → EX → WB
// ============================================================

module pipeline_processor(
    input clk,
    input reset
);

    reg [7:0]  regfile [0:3];         // Register File (4 x 8-bit)
    reg [15:0] instr_mem [0:7];       // Instruction Memory
    reg [2:0]  pc;                    // Program Counter

    // --- Pipeline Registers ---
    reg [15:0] IF_ID_instr;           // IF/ID Stage Register

    reg [3:0]  ID_EX_opcode;          // ID/EX Stage Registers
    reg [7:0]  ID_EX_op1, ID_EX_op2;
    reg [1:0]  ID_EX_dest;

    reg [7:0]  EX_WB_result;          // EX/WB Stage Registers
    reg [1:0]  EX_WB_dest;

    integer i;

    // --- Instruction Format: [15:12]=Opcode [11:10]=Dest [9:8]=Src [7:0]=Imm ---
    parameter ADD  = 4'b0001;
    parameter SUB  = 4'b0010;
    parameter LOAD = 4'b0011;

    // --- Load Instructions into Memory ---
    initial begin
        instr_mem[0] = {LOAD, 2'b00, 2'b00, 8'd10}; // R0 = 10
        instr_mem[1] = {LOAD, 2'b01, 2'b00, 8'd5};  // R1 = 5
        instr_mem[2] = {ADD,  2'b00, 2'b01, 8'd0};  // R0 = R0 + R1
        instr_mem[3] = {SUB,  2'b00, 2'b01, 8'd0};  // R0 = R0 - R1
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            for (i = 0; i < 4; i = i + 1)
                regfile[i] <= 0;
        end else begin

            // ---- STAGE 4: Write Back (WB) ----
            regfile[EX_WB_dest] <= EX_WB_result;

            // ---- STAGE 3: Execute (EX) ----
            case (ID_EX_opcode)
                ADD  : EX_WB_result <= ID_EX_op1 + ID_EX_op2;
                SUB  : EX_WB_result <= ID_EX_op1 - ID_EX_op2;
                LOAD : EX_WB_result <= ID_EX_op2;
                default: EX_WB_result <= 0;
            endcase
            EX_WB_dest <= ID_EX_dest;

            // ---- STAGE 2: Instruction Decode (ID) ----
            ID_EX_opcode <= IF_ID_instr[15:12];
            ID_EX_dest   <= IF_ID_instr[11:10];
            ID_EX_op1    <= regfile[IF_ID_instr[11:10]];
            if (IF_ID_instr[15:12] == LOAD)
                ID_EX_op2 <= IF_ID_instr[7:0];
            else
                ID_EX_op2 <= regfile[IF_ID_instr[9:8]];

            // ---- STAGE 1: Instruction Fetch (IF) ----
            IF_ID_instr <= instr_mem[pc];
            pc <= pc + 1;

        end
    end
endmodule
