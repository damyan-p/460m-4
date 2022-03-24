`timescale 1ns / 1ps


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
    wire n_clk;                                     //  50ms period, for debouncing
    wire db_clk;
    reg [13:0] BCOUNT = 0; //   counting to 9999, in binary
    reg btest;
    //   decimal representation of BCOUNT
    
    wire [15:0] COUNT;
    assign COUNT[15:12] = (BCOUNT / 1000);
    assign COUNT[11:8] = ((BCOUNT / 100) % 10);
    assign COUNT[7:4] = ((BCOUNT / 10) % 10);
    assign COUNT[3:0] = (BCOUNT % 10);
    wire flash;
    assign flash = (BCOUNT < 200);
    //  CLK
    
    clk_div dispClk(.clk(clk), .disp_clk(disp_clk),.sec_clk(sec_clk),.n_clk(n_clk),.db_clk(db_clk)); 
    clk_div_2 dutyCycle50(.clk(clk),.slow_clk(pulse_clk));  
    
    //  DEBOUNCER + SINGLE-PULSER
    //  debouncing and single-pulsing each input
    
    debounce B0(.clk(clk),.slow_clk(db_clk),.in(btnU), .out(add10));  
    debounce B1(.clk(clk),.slow_clk(db_clk),.in(btnL), .out(add180)); 
    debounce B2(.clk(clk),.slow_clk(db_clk),.in(btnR), .out(add200)); 
    debounce B3(.clk(clk),.slow_clk(db_clk),.in(btnD), .out(add550)); 
    

    //  FSM FOR DISPLAY
    //  traditional FSM, like in Lab 3
    //  if (BCOUNT < 200) an = an_reg & pulse_clk;
    pulseFSM displayWithPulse(.clk(disp_clk),.pulse(pulse_clk),.flash(flash),.COUNT(COUNT),.an(an), .seg(seg));


 //ADDING  


always @(posedge sec_clk)begin
if(reset10) BCOUNT  = 11;
if(reset205) BCOUNT = 206;
//resets work
  if(BCOUNT > 0) BCOUNT = BCOUNT - 1;
  if(BCOUNT < 1) BCOUNT = 0;
        if(add10) begin//need to account for saturation @9999 for ulrd
            BCOUNT = BCOUNT + 10;
            if(BCOUNT > 9998) BCOUNT = 9999;
      end
    if(add180)begin
        BCOUNT = BCOUNT + 180;
         if(BCOUNT > 9998) BCOUNT = 9999;
    end
     if(add200) begin
        BCOUNT = BCOUNT + 200;
         if(BCOUNT > 9998) BCOUNT = 9999; 
    end
    if(add550) begin
        BCOUNT = BCOUNT + 550;
         if(BCOUNT > 9998) BCOUNT = 9999;   
    end  
end    
endmodule
