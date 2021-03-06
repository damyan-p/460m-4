`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2022 01:43:02 PM
// Design Name: 
// Module Name: debounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debounce(
    input clk,
    input slow_clk,
    input in,
    output out
    );
    wire Q1, Q2;
    dflip d0(.clk(slow_clk),.D(in),.Q(Q1));
    dflip d1(.clk(slow_clk),.D(Q1),.Q(Q2));
    
    assign out = Q1 && (~Q2);
    
endmodule



module dflip(
    input clk,
    input D,
    output reg Q
    );
    
    always @(posedge clk) begin
    Q <= D;
    end
    
endmodule