`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2022 01:06:08 PM
// Design Name: 
// Module Name: meter
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


module meter(
    input clk,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input reset10,
    input reset205,
    output [6:0] seg,
    output [3:0] an
    );
    
    wire add10, add180, add200, add550;             //  debounced inputs
    wire disp_clk;                                  //  approx. 60Hz, for FSM
    wire pulse_clk;                                 //  50% duty cycle, period 2 seconds
    wire sec_clk;                                   //  1 Hz
    reg [13:0] BCOUNT; //   counting to 9999, in binary
    
    //   decimal representation of BCOUNT
    
    reg [15:0] COUNT;
    assign COUNT[15:12] = (BCOUNT / 1000);
    assign COUNT[11:8] = ((BCOUNT / 100) % 10);
    assign COUNT[7:4] = ((BCOUNT / 10) % 10);
    assign COUNT[3:0] = BCOUNT % 10;

    //  CLK
    
    clk_div dispClk(.clk(clk), .disp_clk(disp_clk),.sec_clk(sec_clk)); 
    clk_div_2 dutyCycle50(.clk(clk),.slow_clk(pulse_clk));  
    
    //  DEBOUNCER + SINGLE-PULSER
    //  debouncing and single-pulsing each input
    
    debounce B0(.clk(clk),.in(btnU), .out(add10));  
    debounce B1(.clk(clk),.in(btnL), .out(add180)); 
    debounce B2(.clk(clk),.in(btnR), .out(add200)); 
    debounce B3(.clk(clk),.in(btnD), .out(add550)); 
    
    //  ADDER + SUBTRACTOR
    //  always at posedge clk begin
    
    //  if one of these buttons are high, add to BCOUNT
    adder addTime(.clk(clk),.add10(add10),.add180(add180),.add200(add200),.add550(add550),.BCOUNT(BCOUNT));
    //  always at posedge sec_clk
    decrementer counter(.clk(sec_clk),.BCOUNT(BCOUNT));
    
    //  FSM FOR DISPLAY
    //  traditional FSM, like in Lab 3
    //  if (BCOUNT < 200) an = an_reg & pulse_clk;
    pulseFSM displayWithPulse(.clk(disp_clk),.pulse(pulse_clk),.BCOUNT(BCOUNT),.COUNT(COUNT),.an(an), .seg(seg));
    
    
endmodule
