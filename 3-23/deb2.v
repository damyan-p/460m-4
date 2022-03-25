`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2022 11:05:05 PM
// Design Name: 
// Module Name: deb2
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


module deb2(
    input in,
    input clk,
    input sec_clk,
    output out
    );
    reg [30:0] COUNT;
    
    reg hold;
    
    assign out = hold;
    
    initial begin
    hold <= 0;
    COUNT <= 0;
    end
    
    always @(posedge clk) begin
    if(COUNT == 1) hold <= 0;
    if(COUNT > 1) COUNT <= COUNT - 1;
    if(in) begin
        hold <= 1;
        COUNT <= 80000000;
        end
    end
endmodule
