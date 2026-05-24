`timescale 1ns/10ps

module memory_tb()
    reg CLK;
    reg WE;
    reg RSTB;
    reg [7:0] ADDRESS;
    reg CE;
    reg [7:0] INPUT;
    reg SEQ;

    wire [7:0] OUTPUT;

    memory memory1(.CLK(CLK), .WE(WE), .RSTB(RSTB), .ADDRESS(ADDRESS), .CE(CE), .INPUT(INPUT), .SEQ(SEQ), .OUTPUT(OUTPUT));

    always begin
        #10 CLK = ~CLK;  
    end

    initial begin
        CLK = 1'b0;
        WE = 1'b0;
        RSTB = 1'b1;
        ADDRESS = 8'b0;
        CE = 1'b0;
        INPUT = 8'b0;
        SEQ = 1'b0;

        //we flick reset to reset everything
        #5 RSTB = 1'b0;
        #5 RSTB = 1'b1;

        //TEST 1, write circuit
        



    end


endmodule