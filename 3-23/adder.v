`timescale 1ns / 1ps
module adder(
    input clk,
    input sec_clk,
    input add10,//u
    input add180,//l
    input add200,//r
    input add550,//d
    input reset10,//implementing reset here
    input reset205,
    output flash,
    output [15:0] COUNT
    );
  
 reg [13:0] bbuf;
 
    assign COUNT[15:12] = (bbuf > 999)?(bbuf / 1000) % 10 : 0;
    assign COUNT[11:8] = (bbuf > 99)?((bbuf / 100) % 10) : 0;
    assign COUNT[7:4] = (bbuf > 9)?((bbuf / 10) % 10) : 0;
    assign COUNT[3:0] = bbuf % 10;
    
    assign flash = (bbuf < 200);
    
    initial begin
    bbuf <= 0;
    end
    
 //ADDING  
always @(posedge sec_clk or posedge reset10 or posedge reset205)begin

if(reset10) bbuf <= 10;
else if(reset205) bbuf <= 205;
else if((!reset10)||(!reset205))begin
        if(add10) begin//need to account for saturation @9999 for ulrd
            bbuf <= bbuf + 10;
            if(bbuf > 9998) bbuf <= 9999;
        end
    else if(add180)begin
        bbuf <= bbuf + 550;
         if(bbuf > 9998) bbuf <= 9999;
    end
    else if(add200) begin
        bbuf <= bbuf + 200;
         if(bbuf > 9998) bbuf <= 9999;
    end
    else if(add550) begin
        bbuf <= bbuf + 180;
         if(bbuf > 9998) bbuf <= 9999;
    end
    if(sec_clk) begin
    if(bbuf > 0) bbuf <= bbuf - 1;
    end
end   
end

endmodule
