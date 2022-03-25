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
    wire n_clk;
    wire out1, out2;
    assign one = out1;
    assign two = out2;
    
    initial begin
    PCOUNT <= 0;
    COUNT <= 0;
    end
    
    assign n_clk = PCOUNT[1];
    assign disp_clk = COUNT[2];
    
    reg [2:0] COUNT;
    reg [1:0] PCOUNT;
    
    always @(posedge clk) begin
    COUNT <= COUNT + 1;
    PCOUNT <= PCOUNT + 1;
    end
    
    debounce B0(.clk(clk),.slow_clk(n_clk),.in(btn1), .out(out1));  

    deb2 B3(.in(out1),.clk(clk),.out(out2));
    
endmodule

