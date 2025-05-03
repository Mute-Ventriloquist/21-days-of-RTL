`timescale 1ns/1ps
`include "day9.sv"

module bg_tb();
  // define parameters related to the dut
  localparam VEC_W = 3;
  // define the ports related to the gut
  logic[VEC_W-1:0] bin_i;
  logic[VEC_W-1:0] gray_o;

  // instantiate the dut
  bg#(
    .VEC_W(VEC_W)
) bg1 (
    .bin_i(bin_i),
    .gray_o(gray_o)
);

  // write tests
  initial begin
    $dumpfile("bg.vcd");
    $dumpvars(0, bg_tb);
    for (int j = 0; j<2**VEC_W; j++) begin
      bin_i = VEC_W'(j);
      #5;
    end
    $finish;
  end
endmodule
