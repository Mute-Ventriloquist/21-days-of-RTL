`timescale 1ns/1ps
`include "day8.sv"

module bo_tb();

  // initialise the parameters
  localparam ONE_HOT_W = 16;
  localparam BIN_W = 4;

  // initialise all ports
  logic[ONE_HOT_W-1:0] one_hot_o;
  logic[BIN_W-1:0] bin_i;

  // instantiate the dut
  bo#(
    .ONE_HOT_W(ONE_HOT_W),
    .BIN_W(BIN_W)
  ) bo1 (
    .one_hot_o(one_hot_o),
    .bin_i(bin_i)
  );

  // run tests
  initial begin
    $dumpfile("bo.vcd");
    $dumpvars(0, bo_tb);
    for (int i = 0; i<16; i++) begin
      bin_i <= 4'(i);
      #5;
    end
    $finish;
  end
  
endmodule
