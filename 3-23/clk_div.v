module clk_div(
    input clk,
    output disp_clk,
    output sec_clk,
    output n_clk,
    output db_clk
    );
    
    reg [18:0] COUNT; //  100*10^6 / 2^20 = 95.3 Hz, higher than 60Hz
                      //  not so high that it causes screen flickering
            
    reg [26:0] SEC_COUNT;  //   1 second per clk
                           
    reg [25:0] ROT_COUNT;  //   2 seconds per clk
           //reg [1:0] COUNT; 
    reg [30:0] N_COUNT;
    //reg N_COUNT; 
    reg[21:0] DB_COUNT;      
            
            assign disp_clk = COUNT[18]; // real
            assign n_clk = (N_COUNT == 31'd200000000);//2 seconds
            assign sec_clk = (SEC_COUNT == 27'd100000000);// the stopwatch counter )
            assign db_clk = (DB_COUNT == 22'd2500000);//25ms
            //assign n_clk = (N_COUNT);
            //assign d_clk = COUNT[1]; // simulation 
            
            initial begin
            N_COUNT <= 0;
            COUNT <= 0;
            SEC_COUNT <= 0;
            DB_COUNT <= 0;
            end
            
            
            always @ (posedge clk)
                begin
                if( SEC_COUNT == 100000000 )
                    SEC_COUNT <= 0;               
                     else SEC_COUNT <= SEC_COUNT + 1;
                  if(DB_COUNT == 2500000)
                    DB_COUNT <= 0;
                    else   DB_COUNT <= DB_COUNT + 1;
                if(COUNT == 524289)
                    COUNT <= 0;
                    else   COUNT <= COUNT + 1;
                if( N_COUNT == 200000000 ) //  2000000000
                    N_COUNT <= 0;         
                else N_COUNT <= N_COUNT + 1;
            
            end 
    
    
endmodule
