`timescale 1ns/1ps
`include "sb.sv"

module sb_tb();
  // define the localparams
  localparam WIDTH = 12;

  // define dut connections
  logic[WIDTH-1:0] second_bit_o;
  logic[WIDTH-1:0] vec_i;

  // instantiate the dut
  sb #(.WIDTH(WIDTH)) sb1 (.*);

  // write tests
  initial begin
    $dumpfile("sb.vcd");
    $dumpvars(0, sb_tb);
    for (int i = 0; i<20; i++) begin
      vec_i = $urandom_range(0, 12'hFFF);
      #10;    
    end
    $finish;
  end
endmodule
