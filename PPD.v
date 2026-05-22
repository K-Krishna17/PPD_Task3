module pipeline_processor(
    input clk,
    input reset
);

reg [7:0] regfile [0:3];
reg [15:0] instr_mem [0:7];

reg [2:0] pc;

// IF/ID Pipeline Register
reg [15:0] IF_ID_instr;

// ID/EX Pipeline Registers
reg [3:0] ID_EX_opcode;
reg [7:0] ID_EX_op1, ID_EX_op2;
reg [1:0] ID_EX_dest;

// EX/WB Pipeline Registers
reg [7:0] EX_WB_result;
reg [1:0] EX_WB_dest;

integer i;

// Instruction Format
// [15:12] Opcode
// [11:10] Destination
// [9:8] Source
// [7:0] Immediate/Data

parameter ADD  = 4'b0001;
parameter SUB  = 4'b0010;
parameter LOAD = 4'b0011;

// Initialize Instructions
initial begin
    instr_mem[0] = {LOAD, 2'b00, 2'b00, 8'd10}; // R0 = 10
    instr_mem[1] = {LOAD, 2'b01, 2'b00, 8'd5};  // R1 = 5
    instr_mem[2] = {ADD, 2'b00, 2'b01, 8'd0};   // R0 = R0 + R1
    instr_mem[3] = {SUB, 2'b00, 2'b01, 8'd0};   // R0 = R0 - R1
end

// Processor Operation
always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        pc <= 0;

        for(i=0;i<4;i=i+1)
            regfile[i] <= 0;
    end

    else
    begin

        // ---------------- WB Stage ----------------
        regfile[EX_WB_dest] <= EX_WB_result;

        // ---------------- EX Stage ----------------
        case(ID_EX_opcode)

            ADD:
                EX_WB_result <= ID_EX_op1 + ID_EX_op2;

            SUB:
                EX_WB_result <= ID_EX_op1 - ID_EX_op2;

            LOAD:
                EX_WB_result <= ID_EX_op2;

            default:
                EX_WB_result <= 0;
        endcase

        EX_WB_dest <= ID_EX_dest;

        // ---------------- ID Stage ----------------
        ID_EX_opcode <= IF_ID_instr[15:12];
        ID_EX_dest   <= IF_ID_instr[11:10];

        ID_EX_op1 <= regfile[IF_ID_instr[11:10]];

        if(IF_ID_instr[15:12] == LOAD)
            ID_EX_op2 <= IF_ID_instr[7:0];
        else
            ID_EX_op2 <= regfile[IF_ID_instr[9:8]];

        // ---------------- IF Stage ----------------
        IF_ID_instr <= instr_mem[pc];
        pc <= pc + 1;

    end
end
endmodule

