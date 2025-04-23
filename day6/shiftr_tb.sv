`timescale 1ns/1ps
`include "shiftr.sv"

module shiftr_tb();
  // initialise the ports
  logic clk;
  logic reset;
  logic x_i;      // Serial input
  logic[3:0] sr_o;

  // instantiate the dut
  shiftr sr(
    .clk(clk),
    .reset(reset),
    .x_i(x_i),
    .sr_o(sr_o)
);

  // start the clk
  initial begin
    clk = 1'b0;
    forever begin
      clk = ~clk;
      #5;
    end
  end

  // write some tests
  initial begin
    $dumpfile("shiftr.vcd");
    $dumpvars(0, shiftr_tb);
    reset = 1; x_i = 0;
    #15;
    reset = 0; x_i = 1;
    #30;
    $finish;
  end
endmodule
