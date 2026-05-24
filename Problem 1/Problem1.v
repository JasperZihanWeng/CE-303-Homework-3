`timescale 1ns/10ps

module FSM(CLK, INPUT, RSTB, OUTPUT);

    input CLK;
    input INPUT;
    input RSTB;
    output OUTPUT;


    reg Q0;
    reg Q1;

    wire D0;
    wire D1;

    always @(posedge CLK or negedge RSTB) begin

        if (RSTB == 1'b0) begin
            Q0 <= 1'b0;
            Q1 <= 1'b0;
        end
        else begin
            Q0 <= D0;
            Q1 <= D1;
        end
    end

    assign OUTPUT = Q0;
    assign D0 = Q1 ^ Q0 ^ INPUT;
    assign D1 = Q1 ^ Q0;



endmodule