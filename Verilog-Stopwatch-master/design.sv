`timescale 1ns / 1ps

module TFF(input t,clk, reset,load, value, output reg q);
    always @(posedge clk or posedge reset or posedge load)
    if(load == 1'b1) q<= value;
    else begin
        if(reset) q<=1'b0;
        else if(t) q<=~q;
        else q<=q;
    end
endmodule 

module up_down_counter1(input clk,dir, reset_user,load, input [3:0]load_value , output [3:0] a,output w);
  and (reset_10, ~a[0],a[1],~a[2],a[3]);
  or (reset , reset_user,(~dir)&reset_10);
  and (reset_15, a[0],a[1],a[2],a[3]);
  or (reset_user_15, reset_15, reset);
  and (w,a[0],~a[1],~a[2],a[3] );
  TFF T1(1'b1,clk, reset,load ,load_value[0] , a[0]);
  TFF T2((a[0]^dir),clk, reset_user_15,load ,load_value[1] , a[1]);
  TFF T3((a[0]^dir)&(a[1]^dir),clk, reset_user_15, load ,load_value[2] ,a[2]);
  TFF T4((a[0]^dir)&(a[1]^dir)&(a[2]^dir),clk, reset,load ,load_value[3] , a[3]);

endmodule

module up_down_counter2(input clk,dir,b, reset_user,load, input [3:0]load_value,output [3:0] a,output w);
  and (reset_10, ~a[0],a[1],~a[2],a[3]);
  or (reset , reset_user,(~dir)&reset_10);
  and (reset_15, a[0],a[1],a[2],a[3]);
  or (reset_user_15, reset_15, reset);
  and (t,a[0],~a[1],~a[2],a[3] );
  and(w, t,b);
  TFF T1(b,clk, reset,load , load_value[0], a[0]);
  TFF T2(b&(a[0]^dir),clk, reset_user_15,load , load_value[1], a[1]);
  TFF T3(b&(a[0]^dir)&(a[1]^dir),clk, reset_user_15,load , load_value[2], a[2]);
  TFF T4(b&(a[0]^dir)&(a[1]^dir)&(a[2]^dir),clk, reset, load , load_value[3],a[3]);
  
endmodule


module up_down_counter3(input clk,dir, reset_user, b,load, input [3:0]load_value,output [3:0] a,output w);
  and (reset_10, ~a[0],a[1],~a[2],a[3]);
  or (reset , reset_user,(~dir)&reset_10);
  and (reset_15, a[0],a[1],a[2],a[3]);
  or (reset_user_15, reset_15, reset);
  and (t,a[0],~a[1],~a[2],a[3] );
  and(w, t,b);
  TFF T1(b,clk, reset,load, load_value[0], a[0]);
  TFF T2(b&(a[0]^dir),clk, reset_user_15, load, load_value[1],a[1]);
  TFF T3(b&(a[0]^dir)&(a[1]^dir),clk, reset_user_15, load, load_value[2] ,a[2]);
  TFF T4(b&(a[0]^dir)&(a[1]^dir)&(a[2]^dir),clk, reset, load, load_value[3],a[3]);
  
endmodule

module up_down_counter4(input clk,dir, reset_user, b, load, input [2:0]load_value,output [3:0] a);
  and (reset_5, ~a[0],a[1],a[2],~a[3]);
  or (reset , reset_user,(~dir)&reset_5);
  and (reset_15, a[0],a[1],a[2],a[3]);
  or (reset_user_15, reset_15, reset);
  
  TFF T1(b,clk, reset,load, load_value[0], a[0]);
  TFF T2(b&(a[0]^dir),clk, reset_user_15,load, load_value[1], a[1]);
  TFF T3(b&(a[0]^dir)&(a[1]^dir),clk, reset,load, load_value[2], a[2]);
  TFF T4(b&(a[0]^dir)&(a[1]^dir)&(a[2]^dir),clk, reset_user_15,load, 1'b0, a[3]);
  
endmodule

module freq_divider(input  clk, pb1,  output reg clk_output);
    reg [32:0] count=0;
    reg count1 = 1'b0;
    initial 
    begin
         clk_output = 1'b0;
    end 
    always @(posedge clk)
        begin
            if(pb1 == 1'b1) count1 = ~count1;
            if(count1 == 1'b1)
            begin
                if (count == 500000)
                    begin
                         count <= 0;
                         clk_output <= ~clk_output; 
                    end
                else
                    count <= count + 1;
            end
            else if(count1 == 1'b0) clk_output = 1'b0;
         end
         
endmodule 

module StopWatch(input clk100,  dir , pb1_in, pb2_in,input [14:0]load_value,   output [3:0] a,b,c,d, output [3:0]Anode_Activate ,output [6:0] LED_out /*, output [3:0]LED_BCD*/);
    wire  clk;
    reg reset;
    reg load = 1'b0;
  or (t, (~dir & w1),(dir & ((a[0]^dir)&(a[1]^dir)&(a[2]^dir)&(a[3]^dir))) );
  or (t1, (~dir & w2),(dir & t &((b[0]^dir)&(b[1]^dir)&(b[2]^dir)&(b[3]^dir))) );
  or (t2, (~dir & w3),(dir & t1 &((c[0]^dir)&(c[1]^dir)&(c[2]^dir)&(c[3]^dir))) );
  wire o_state, o_onup, o_state1,o_onup1 ;
  seven_segment_display DUT6(clk100, reset, a[3:0],b[3:0],c[3:0],d[3:0], Anode_Activate, LED_out/* ,LED_BCD*/);
  debounce DUT7(clk100,pb1_in, o_state, pb1_out, o_onup);
  debounce DUT8(clk100,pb2_in, o_state1, pb2_out, o_onup1);
  freq_divider DUT5(clk100, pb1_out, clk);
  up_down_counter1 DUT (clk, dir, reset,load, load_value[3:0], a[3:0],w1);
  up_down_counter2 DUT1 (clk, dir, t, reset,load, load_value[7:4], b[3:0],w2);
  up_down_counter3 DUT2 (clk, dir, reset, t1,load, load_value[11:8], c[3:0],w3);
  up_down_counter4 DUT3 (clk, dir, reset, t2,load, load_value[14:12], d[3:0]);
  reg count = 1'b0;
  always @(*)
  begin
    if (pb2_out == 1'b1) count = ~count;
    if (count == 1'b1) begin 
        reset <= 1'b1;
        load = 1'b1;
        end
    if(count == 1'b0) begin 
        reset <= 1'b0; 
        load <= 1'b0;
    end
  end
  
endmodule
module seven_segment_display(input clk100, reset, input [3:0] a,b,c,d, output reg [3:0] Anode_Activate, output reg [6:0] LED_out/*,output reg [3:0] LED_BCD*/);
    reg [19:0] refresh_counter; 
    reg [3:0] LED_BCD;
    wire [1:0] LED_activating_counter; 
    always @(posedge clk100 or posedge reset)
    begin 
        if(reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];
    
        always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; //7
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = d[3:0];
            // the first hex-digit of the 16-bit number
             end
        2'b01: begin
            Anode_Activate = 4'b1011; //11 b
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = c[3:0];
            // the second hex-digit of the 16-bit number
                end
        2'b10: begin
            Anode_Activate = 4'b1101; //13 d
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = b[3:0];
             // the third hex-digit of the 16-bit number
              end
        2'b11: begin
            Anode_Activate = 4'b1110; // e
            // activate LED4 and Deactivate LED2, LED3, LED1
             LED_BCD = a[3:0];
             // the fourth hex-digit of the 16-bit number 
               end   
        default:begin
             Anode_Activate = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = d[3:0];
            // the first hex-digit of the 16-bit number
            end
        endcase
    end
    always @(*)
    begin
     case(LED_BCD)
     4'b0000: LED_out = 7'b0000001; // "0"  
     4'b0001: LED_out = 7'b1001111; // "1" 
     4'b0010: LED_out = 7'b0010010; // "2" 
     4'b0011: LED_out = 7'b0000110; // "3" 
     4'b0100: LED_out = 7'b1001100; // "4" 
     4'b0101: LED_out = 7'b0100100; // "5" 
     4'b0110: LED_out = 7'b0100000; // "6" 
     4'b0111: LED_out = 7'b0001111; // "7" 
     4'b1000: LED_out = 7'b0000000; // "8"  
     4'b1001: LED_out = 7'b0000100; // "9" 
     default: LED_out = 7'b0000001; // "0"
     endcase
    end
endmodule 


module debounce(
    input clk,
    input i_btn,
    output reg o_state,
    output o_ondn,
    output o_onup
    );

    // sync with clock and combat metastability
    reg sync_0, sync_1;
    always @(posedge clk) sync_0 <= i_btn;
    always @(posedge clk) sync_1 <= sync_0;

    // 2.6 ms counter at 100 MHz
    reg [18:0] counter;
    wire idle = (o_state == sync_1);
    wire max = &counter;

    always @(posedge clk)
    begin
        if (idle)
            counter <= 0;
        else
        begin
            counter <= counter + 1;
            if (max)
                o_state <= ~o_state;
        end
    end

    assign o_ondn = ~idle & max & ~o_state;
    assign o_onup = ~idle & max & o_state;
endmodule

