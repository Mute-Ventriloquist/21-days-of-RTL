`timescale 1ns/1ps
`include "srcounter.sv"

module srcounter_tb();
  // initialise the ports
  logic          clk;
  logic          reset;
  logic          load_i;
  logic[3:0]     load_val_i;
  logic[3:0]     count_o;

  // initialise the dut
  srcounter sr1(
    .clk(clk),
    .reset(reset),
    .load_i(load_i),
    .load_val_i(load_val_i),
    .count_o(count_o)
);
  
  // start the clk
  initial begin
    clk = 1'b0;
    forever begin
      clk = ~clk;
      #5;
    end
  end
  
  // start the tests
  initial begin
    $dumpfile("srcounter.vcd");
    $dumpvars(0, srcounter_tb);
    reset = 1;load_i = 1'b0; load_val_i = 4'b1111;
    #20;
    reset = 0;
    #50;
    load_i = 1'b1; load_val_i = 4'b0011;
    #200;
    $finish;
  end
endmodule
