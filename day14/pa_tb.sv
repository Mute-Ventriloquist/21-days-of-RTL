`timescale 1ns/1ps
`include "pa.sv"

module pa_tb ();
  
  // instantiate localparams
  localparam NUM_PORTS = 4;
  // instantiate the dut signals
  logic[NUM_PORTS-1:0] req_i;
  logic[NUM_PORTS-1:0] gnt_o;

  // instantiate the dut
  pa #(
    .NUM_PORTS(NUM_PORTS)
  ) pa1(.*);

  // write tests
  initial begin
    $dumpfile("pa.vcd");
    $dumpvars(0, pa_tb);
    req_i = 4'b1100; #5;
    req_i = 4'b0110; #5;
    req_i = 4'b0011; #5;
    req_i = 4'b0001; #5;
    req_i = 4'b0000; #5;
    $finish;
  end

endmodule
