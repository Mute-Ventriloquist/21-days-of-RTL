`include "rrarb.sv"
`timescale 1ns/1ps

module rrarb_tb();
  // instantiate the dut connections
  logic[3:0] req_i;
  logic[3:0] gnt_o;
  logic clk;
  logic reset;

  // instantiate the dut
  rrarb r1 (.*);

  // start clk
  initial begin
    clk = 1'b0;
    forever begin
      clk = ~clk;
      #5;
    end
  end

  // start tests
  initial begin
    $dumpfile("rrarb.vcd");
    $dumpvars(0, rrarb_tb);
    req_i = 4'b0000; reset = 1'b1; #19;
    req_i = 4'b1011; reset = 1'b0; #51;
    req_i = 4'b0000; reset = 1'b1; #20;
    $finish;
  end
endmodule
