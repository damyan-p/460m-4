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
    wire new10, new180, new200, new550;
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
    //clk_div_2 dutyCycle50(.clk(clk),.slow_clk(pulse_clk));  
    
    //  DEBOUNCER + SINGLE-PULSER
    //  debouncing and single-pulsing each input
    
    debounce B0(.clk(clk),.slow_clk(n_clk),.in(btnU), .out(add10));  
    debounce B1(.clk(clk),.slow_clk(n_clk),.in(btnL), .out(add180)); 
    debounce B2(.clk(clk),.slow_clk(n_clk),.in(btnR), .out(add200)); 
    debounce B3(.clk(clk),.slow_clk(n_clk),.in(btnD), .out(add550)); 
    
    deb2 B4(.in(add10),.clk(clk),.sec_clk(sec_clk),.out(new10));
    deb2 B5(.in(add180),.clk(clk),.sec_clk(sec_clk),.out(new180));
    deb2 B6(.in(add200),.clk(clk),.sec_clk(sec_clk),.out(new200));
    deb2 B7(.in(add550),.clk(clk),.sec_clk(sec_clk),.out(new550));

    //  FSM FOR DISPLAY
    //  traditional FSM, like in Lab 3
    //  if (BCOUNT < 200) an = an_reg & pulse_clk;
    pulseFSM displayWithPulse(.clk(disp_clk),.pulse(n_clk),.flash(flash),.COUNT(COUNT),.an(an), .seg(seg));


 //ADDING  


always @(posedge sec_clk)begin
//resets work
  if(BCOUNT > 0) BCOUNT = BCOUNT - 1;
  if(BCOUNT < 1) BCOUNT = 0;
        if(new10) begin//need to account for saturation @9999 for ulrd
            BCOUNT = BCOUNT + 10;
            if(BCOUNT > 9998) BCOUNT = 9999;
      end
    if(new180) begin
        BCOUNT = BCOUNT + 180;
         if(BCOUNT > 9998) BCOUNT = 9999;
    end
     if(new200) begin
        BCOUNT = BCOUNT + 200;
         if(BCOUNT > 9998) BCOUNT = 9999; 
    end
    if(new550) begin
        BCOUNT = BCOUNT + 550;
         if(BCOUNT > 9998) BCOUNT = 9999;   
    end  
    if(reset10) BCOUNT  = 10;
    if(reset205) BCOUNT = 205;
end    
endmodule
