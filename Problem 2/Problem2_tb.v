`timescale 1ns/10ps

module memory_tb();
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
        #5 CLK = ~CLK;  
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

        //TEST 1, SEQ=0
        #5;
        INPUT = 8'b10101010; //Write #1
        ADDRESS = 8'b00000000;
        WE = 1'b1;
        CE = 1'b1;

        #10;
        WE = 1'b0;
        CE = 1'b0;

        #5;
        INPUT = 8'b01010101; // Write #2
        ADDRESS = 8'b11111111;
        WE = 1'b1;
        CE = 1'b1;

        #10;
        WE = 1'b0;
        CE = 1'b0;

        #5;
        ADDRESS = 8'b00000000; // Read #1
        WE = 1'b0;
        CE = 1'b1;

        #10;
        WE = 1'b0;
        CE = 1'b0;

        #5;
        ADDRESS = 8'b11111111; // Read #2
        WE = 1'b0;
        CE = 1'b1;
        
        #10;

        //Test 2, SEQ = 1

        //we need to first load temporary address
        #7;
        SEQ = 1'b0;
        ADDRESS = 8'b00010000; //0x10
        WE = 1'b0;
        CE = 1'b1;

        #10;
        CE = 1'b0;

        #10;
        SEQ = 1'b1;
        INPUT = 8'b00000001;
        ADDRESS = 8'b00010000; //Write #1 0x10
        WE = 1'b1;
        CE = 1'b1;

        #10;
        INPUT = 8'b00000010; //Write #2 0x11 becuase SEQ = 1
        WE = 1'b1;
        CE = 1'b1;

        #10;
        WE = 1'b0;
        CE = 1'b0;
        SEQ = 1'b0;

         #5;
        ADDRESS = 8'b00010000; // Read #1
        WE = 1'b0;
        CE = 1'b1;

        #10;
        WE = 1'b0;
        CE = 1'b0;

        #5;
        ADDRESS = 8'b00010001; // Read #2
        WE = 1'b0;
        CE = 1'b1;
        
        #10;

        $finish;

    end


endmodule