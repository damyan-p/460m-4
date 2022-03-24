`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2022 01:40:27 PM
// Design Name: 
// Module Name: clk_div_2
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


module clk_div_2(
    input clk,
    output slow_clk
    );
    reg [30:0] COUNT;
    reg out;
    assign slow_clk = COUNT < 50000000;
    
    initial begin
    out <= 0;
    COUNT <= 0;
    end
    
    always @(posedge clk) begin
    if(COUNT == 99999999) begin   //49999999
    COUNT <= 0;
    end
    else
    COUNT <= COUNT + 1;
    end
    
    //  creates a 50% duty cycle clock.
    //  period 2s, so 1s on, 1s off
    
endmodule
