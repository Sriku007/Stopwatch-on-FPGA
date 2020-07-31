module test1();
    reg clk100, reset,dir, pb1_in;
  wire [3:0] a,b,c,d;
  //wire w1,w2,w3,w4;
  wire [3:0]Anode_Activate;
  wire  [6:0] LED_out;
  wire [3:0] LED_BCD;
    StopWatch DUT (clk100, reset, dir,pb1_in, a[3:0],b[3:0],c[3:0],d[3:0], Anode_Activate[3:0], LED_out[6:0], LED_BCD[3:0] );
    initial
    begin
        clk100 = 1'b0;
        forever #1 clk100=~clk100;       
    end
    initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1,test1);
      reset = 1'b1;
      dir = 1'b0;
      pb1_in = 1'b0;
      #1 reset = 1'b0;
      #50000 pb1_in = 1'b1;
      #55000 pb1_in = 1'b0;
      #100000 pb1_in = 1'b1;
      #105000 pb1_in = 1'b0;
      #2000000; 
      $finish;
    end
endmodule
