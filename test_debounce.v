`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2022 12:36:19 PM
// Design Name: 
// Module Name: test_debounce
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


module test_debounce(
    input btn1,
    input btn2,
    input clk,
    output one,
    output two
    );
    wire disp_clk;
    wire pulse_clk;
    wire n_clk;
    wire out1, out2;
    assign one = out1;
    assign two = out2;
    
    clk_div dispClk(.clk(clk), .sync({btn1, btn2}), .disp_clk(disp_clk),.sec_clk(sec_clk),.n_clk(n_clk)); 
    
    debounce B0(.clk(clk),.slow_clk(n_clk),.in(btn1), .out(out1));  
    debounce B1(.clk(clk),.slow_clk(n_clk),.in(btn2), .out(out2));
    
endmodule

