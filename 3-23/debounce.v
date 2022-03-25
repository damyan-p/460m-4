`timescale 1ns / 1ps


module debounce(
    input clk,
    input slow_clk,
    input in,
    output out
    );
    wire Q1, Q2;
    assign out = (Q1 && (~Q2));
    
    dflip d0(.clk(slow_clk),.D(in),.Q(Q1));
    dflip d1(.clk(slow_clk),.D(Q1),.Q(Q2));
    
    
endmodule


module dflip(
    input clk,
    input D,
    output reg Q
    );
    initial begin
    Q <= 0;
    end
    
    always @(posedge clk) begin
    Q <= D;
    end
    
endmodule




