`timescale 1ns/1ps

module mux (
  input   wire [7:0]    a_i,
  input   wire [7:0]    b_i,
  input   wire          sel_i,
  output  wire [7:0]    y_o
);

assign y_o = sel_i ? b_i : a_i; // if sel_i is 1 then a_i else b_i

endmodule

