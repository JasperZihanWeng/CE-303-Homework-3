`timescale 1ns/10ps

module memory(CLK, WE, RSTB, ADDRESS, CE, INPUT, OUTPUT, SEQ);
    
    //all inputs
    input CLK;
    input WE;
    input RSTB;
    input [7:0] ADDRESS;
    input CE;
    input [7:0] INPUT;
    input SEQ;

    //all outputs
    output reg [7:0] OUTPUT;


    //temporary variables and registers
    reg [7:0] memory[255:0];
    reg [7:0] temporary_address;
    integer i;


    always @(posedge CLK or negedge RSTB) begin
        if(RSTB == 1'b0)begin
            
            //set everything to zero
            temporary_address <= 8'b0;
            OUTPUT <= 8'b0;

            for (i=0; i<256; i = i+1) begin
                memory[i] <= 8'b0;
            end
        end

        else begin
            if(CE == 1'b0)begin //chip is not enabled, CE = 0
                OUTPUT <= 8'bz;
                temporary_address <= ADDRESS;
            end
            else begin //chip is enabled, CE = 1
                if(SEQ == 1'b0) begin //SEQ = 0
                    temporary_address <= ADDRESS;
                
                    if (WE == 1'b1) begin //WE = 1
                        memory[ADDRESS] <= INPUT;
                        OUTPUT <= INPUT;
                    end
                    else begin //WE = 0
                        OUTPUT <= memory[ADDRESS];
                    end

                end

                else begin //SEQ = 1
                    temporary_address <= temporary_address + 1;

                    if (WE == 1'b1) begin //WE = 1
                        memory[temporary_address] <= INPUT;
                        OUTPUT <= INPUT;
                    end
                    else begin //WE = 0
                        OUTPUT <= memory[temporary_address];
                    end

                end

                
            end
        end 


    end

endmodule
