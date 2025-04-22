`timescale 1ns/1ps
`include "mux.sv"

module mux_tb();
// define parameters
reg[7:0] a_i, b_i;
wire[7:0] y_o;
reg sel_i;

// instantiate the mux
mux m1(
  .a_i(a_i),
  .b_i(b_i),
  .y_o(y_o),
  .sel_i(sel_i) 
);

initial begin
  $dumpfile("mux.vcd");
  $dumpvars(0, mux_tb);
  sel_i = 0; 
  a_i = 8'h00; 
  b_i = 8'h_00;
  #5;
  a_i = 8'h77;
  #5;
  b_i = 8'h88;
  #5;
  sel_i = 1'b1;
  #5;
  $finish;
end
endmodule
