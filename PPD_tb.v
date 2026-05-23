// ============================================================
// Testbench: 4-Stage Pipeline Processor
// Monitors PC, R0, R1 every clock cycle
// ============================================================

module pipeline_processor_tb;

    reg clk;
    reg reset;

    // Instantiate the Unit Under Test (UUT)
    pipeline_processor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock Generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        #10;
        reset = 0;   // Release reset after 10ns
        #100;
        $finish;
    end

    // Monitor output at each simulation step
    initial begin
        $monitor("Time=%0t | PC=%d | R0=%d | R1=%d",
                  $time, uut.pc, uut.regfile[0], uut.regfile[1]);
    end
endmodule
