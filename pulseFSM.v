`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2022 01:41:17 PM
// Design Name: 
// Module Name: pulseFSM
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


module pulseFSM(
    input clk,
    input pulse,
    input BCOUNT,
    input COUNT,
    output [3:0] an,
    output [6:0] seg
    );
    reg an_reg;
    reg seg_reg;
    assign an = an_reg;
    assign an = seg_reg;
    
    
endmodule
