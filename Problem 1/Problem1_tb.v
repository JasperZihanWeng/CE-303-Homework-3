`timescale 1ns/10ps

module FSM_tb();

    reg CLK;
    reg INPUT;
    reg RSTB;
    wire OUTPUT;

    FSM FSM1(.CLK(CLK), .INPUT(INPUT), .RSTB(RSTB), .OUTPUT(OUTPUT));

    always begin
        #5 CLK = ~CLK;
    end

    initial begin
        CLK = 1'b0;
        INPUT = 1'b0; 
        RSTB = 1'b1;
        
        //flick RSTB
        #3 RSTB = 1'b0;
        #3 RSTB = 1'b1;

        //testing, do the exact SAME as the document example

        #14 INPUT = 1'b1;
        #20 INPUT = 1'b0;
        #20 INPUT = 1'b1;
        #10 INPUT = 1'b0;
        #10 INPUT = 1'b1;
        #25;
        
        $finish;
        
    end

endmodule