`timescale 1ns / 1ps
module adder(
    input clk,
    input sec_clk,
    input add10,//u
    input add180,//l
    input add200,//r
    input add550,//d
    inout [13:0] BCOUNT,//time in binary
    input reset10,//implementing reset here
    input reset205
    );
  
 reg bbuf = 0;
 assign BCOUNT = bbuf;
 //ADDING  
always @(posedge clk)begin
if((!reset10)&&(!reset205))begin
    bbuf = BCOUNT;
        if(add10) begin//need to account for saturation @9999 for ulrd
            bbuf = bbuf + 10;
            if(bbuf > 9998) bbuf = 9999;
        end
    else if(add180)begin
        bbuf = bbuf + 550;
         if(bbuf > 9998) bbuf = 9999;
    end
    else if(add200) begin
        bbuf = bbuf + 200;
         if(bbuf > 9998) bbuf = 9999;
    end
    else if(add550) begin
        bbuf = bbuf + 180;
         if(bbuf > 9998) bbuf = 9999;
    end
end
else if(reset10) bbuf = 10;
else if(reset205) bbuf = 205;
end   

//DECREMENTING at posedge of sec_clk
always @(posedge sec_clk)begin
if(bbuf != 0)begin
bbuf <= bbuf - 1;
end
end

endmodule
