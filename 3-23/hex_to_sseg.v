`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2022 03:56:59 PM
// Design Name: 
// Module Name: hex_to_sseg
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


module hex_to_sseg(
    input [3:0] x,
    output reg [6:0] r
    );

    always @(*)
        case (x)                        //  4'bxxxx: r =    gfedcba;
            4'b0000: r = 7'b1000000;    //  4'd0: r = 7'b1000000;
            4'b0001: r = 7'b1111001;    //  4'd1: r = 7'b1111001;
            4'b0010: r = 7'b0100100;    //  4'd2: r = 7'b0100100;
            4'b0011: r = 7'b0110000;    //  4'd3: r = 7'b0110000;
            4'b0100: r = 7'b0011001;    //  4'd4: r = 7'b0011001;
            4'b0101: r = 7'b0010010;    //  4'd5: r = 7'b0010010; 
            4'b0110: r = 7'b0000010;    //  4'd6: r = 7'b0000010;
            4'b0111: r = 7'b1111000;    //  4'd7: r = 7'b1111000;
            4'b1000: r = 7'b0000000;    //  4'd8: r = 7'b0000000;
            4'b1001: r = 7'b0010000;    //  4'd9: r = 7'b0010000;
            default: r = 7'b1111111;    //  displays nothing on an error
            //4'b1111: r = 7'b1110111;      on 0xF, displays '_'
        endcase
endmodule