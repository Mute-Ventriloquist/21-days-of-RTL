`timescale 1ns/1ps
`include "oddcnt.sv"

module oddcnt_tb();

  // initialise the ports
  logic        clk;
  logic        reset;
  logic[7:0]  cnt_o;

  // instantiate the dut
  oddcnt o1(
    .clk(clk),
    .reset(reset),
    .cnt_o(cnt_o)
);
  
  initial begin
    clk = 1'b0;
    forever begin
      clk = ~clk;
      #5;
    end
  end

  initial begin
    $dumpfile("oddcnt.vcd");
    $dumpvars(0, oddcnt_tb);
    reset = 0; #15;
    reset = 1; #15;
    reset = 0; #100;
    $finish; 
  end
endmodule
