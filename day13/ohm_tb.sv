`include "ohm.sv"
`timescale 1ns/1ps

module ohm_tb();

  // instantiate all the connections
  logic[3:0] a;
  logic[3:0] sel;
  logic y_aor_o;
  logic y_loop_o;
  logic y_ifelse_o;
  logic y_ter_o;
  logic y_case_o;

  //  instantiate the dut
  ohm ohm1(.*);
 
  // run tests
  initial begin
    $dumpfile("ohm.vcd");
    $dumpvars(0, ohm_tb);
    sel = 4'b1000; a = 4'b1010; #5;
    sel = 4'b0100; a = 4'b1010; #5;
    sel = 4'b0010; a = 4'b1010; #5;
    sel = 4'b0001; a = 4'b1010; #5;
    sel = 4'b0000; a = 4'b1010; #5;
  end

endmodule
