`include "mux.v"
`timescale 1ns/1ps

module mux_tb;
  reg[7:0] a_i, b_i;
  wire[7:0] y_o;
  reg sel_i;
  
  mux mux1(
    .a_i(a_i),
    .b_i(b_i),
    .y_o(y_o),
    .sel_i(sel_i)
  );
  
  initial begin
    $dumpfile("mux.vcd");
    $dumpvars(0, mux_tb);
    $monitor("Time: %0t ; a_i: %0b ; b_i: %0b ; sel_i: %0b ; y_o: %0b", $time, a_i, b_i, sel_i, y_o);
    a_i = 8'hAA;
    b_i = 8'h11;
    sel_i = 1'b0;
    #5;
    sel_i = 1'b1;
    #5;
    sel_i = 1'b0;
    #5;
    sel_i = 1'b1;
    #5;
    $finish;
  end
endmodule
