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
    input flash,
    input [15:0] COUNT,
    output [3:0] an,
    output [6:0] seg
    );
    
    reg [3:0] an_reg;
    reg [6:0] seg_reg;
    reg [1:0] state;
    reg [1:0] next_state;
    wire [6:0] in0, in1, in2, in3;
    assign an = flash? (pulse? (4'b1111):(an_reg)): an_reg;//no flash is an_reg
    assign seg = seg_reg;
    hex_to_sseg bit0(.x(COUNT[3:0]), .r(in0));
    hex_to_sseg bit1(.x(COUNT[7:4]), .r(in1));
    hex_to_sseg bit2(.x(COUNT[11:8]), .r(in2));
    hex_to_sseg bit3(.x(COUNT[15:12]), .r(in3));
    
    initial begin
    state <= 0;
    next_state <= 0;
    end
    
    always @(*) begin
    case(state)
        2'b00: next_state <= 2'b01;
        2'b01: next_state <= 2'b10;
        2'b10: next_state <= 2'b11;
        2'b11: next_state <= 2'b00;
    endcase
    end
    
    always @(*) begin
    case(state)
        2'b00: begin
            an_reg = 4'b1110;
            seg_reg = in0;
            end
        2'b01: begin
            an_reg = 4'b1101;
            seg_reg = in1;
            end
        2'b10: begin
            an_reg = 4'b1011;
            seg_reg = in2;
            end
        2'b11: begin
            an_reg = 4'b0111;
            seg_reg = in3;
            end
    endcase
    end
    
    always @(posedge clk) begin
    state <= next_state;
    end
    
    
endmodule