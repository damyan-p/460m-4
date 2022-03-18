`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2022 03:59:14 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk,
    output disp_clk,
    output sec_clk,
    output n_clk
    );
    
    reg [19:0] COUNT; //  100*10^6 / 2^20 = 95.3 Hz, higher than 60Hz
                      //  not so high that it causes screen flickering
            
    reg [26:0] SEC_COUNT;  //   1 second per clk
                           
    reg [25:0] ROT_COUNT;  //   2 seconds per clk
           //reg [1:0] COUNT; 
    reg [30:0] N_COUNT;        
            
            assign disp_clk = COUNT[19]; // real
            
            assign n_clk = (N_COUNT == 31'd2000000000);
            //assign d_clk = COUNT[1]; // simulation 
            
            always @ (posedge clk)
                begin
                if( SEC_COUNT == 50000000 )
                    SEC_COUNT = 0;
                else SEC_COUNT <= SEC_COUNT + 1;
                COUNT <= COUNT + 1;
                if( N_COUNT == 2000000000 )
                    N_COUNT = 0;
                else N_COUNT <= N_COUNT + 1;
            
            end 
    
    
endmodule
