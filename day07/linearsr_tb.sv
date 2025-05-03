`timescale 1ns/1ps
`include "linearsr.sv"

module linearsr_tb();
  // initialise all the ports
  logic      clk;
  logic      reset;
  logic[3:0] lfsr_o;

  // instantiate the dut
  linearsr lsr(
    .clk(clk),
    .reset(reset),
    .lfsr_o(lfsr_o)
);

  // start clk
  initial begin
    clk = 1'b0;
    forever begin
      clk = ~clk;
      #5;
    end
  end

  //start testing
  initial begin
    $dumpfile("linearsr.vcd");
    $dumpvars(0, linearsr_tb);
    reset = 1; #15;
    reset = 0; #50;
    reset = 1; #15;
    reset = 0; #50;
    $finish;
  end
endmodule
