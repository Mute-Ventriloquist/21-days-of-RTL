`timescale 1ns/1ps
`include "rfedge.sv"

module rfedge_tb();
  logic    clk;
  logic    reset;
  logic    a_i;
  logic    rising_edge_o;
  logic    falling_edge_o;

  rfedge rf1(
  .clk(clk),
  .reset(reset),
  .a_i(a_i),
  .rising_edge_o(rising_edge_o),
  .falling_edge_o(falling_edge_o)
);

  initial begin
    clk <= 1'b0;
    forever begin
      clk = ~clk;
      #5;
    end
  end

  initial begin
    $dumpfile("rfedge.vcd");
    $dumpvars(0, rfedge_tb);
    reset = 1; a_i = 0;
    #15;
    reset = 0;
    #10;
    a_i = 1;
    #10;
    a_i = 0;
    #10;
    a_i = 1;
    #10;
    $finish;
  end
endmodule
