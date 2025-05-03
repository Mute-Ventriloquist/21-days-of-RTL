`include "s2p.sv"
`timescale 1ns/1ps

module s2p_tb();

  // instantiate all the connections to dut
  logic[3:0] parallel_i;
  logic empty_o;
  logic valid_o;
  logic reset;
  logic clk;
  logic serial_o;

  // instantiate the dut
  s2p s1(
    .parallel_i(parallel_i),
    .clk(clk),
    .reset(reset),
    .valid_o(valid_o),
    .serial_o(serial_o),
    .empty_o(empty_o)
  );

  // start the clock
  initial begin
    clk = 1'b0;
    forever begin
      clk = ~clk;
      #5;
    end
  end
 
  // start the tests
  initial begin
    $dumpfile("s2p.vcd");
    $dumpvars(0, s2p_tb);
    $dumpvars(0, s2p_tb.s1);
    // reset the dut
    reset = 1'b1; parallel_i = 4'b0;
    #20;
    // test run 
    reset = 0'b0; parallel_i = 4'b1101;
    #80;
    // reset it again
    reset = 1'b1; parallel_i = 4'b0;
    #20;
    $finish;
  end

endmodule
