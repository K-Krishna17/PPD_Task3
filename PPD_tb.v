module pipeline_processor_tb;

       reg clk;
       reg reset;

pipeline_processor uut(
    .clk(clk),
    .reset(reset)
);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    clk = 0;
    reset = 1;

    #10;
    reset = 0;

    #100;

    $finish;
end

initial
begin
    $monitor("Time=%0t PC=%d R0=%d R1=%d",
              $time,
              uut.pc,
              uut.regfile[0],
              uut.regfile[1]);
end
endmodule
