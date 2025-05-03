`timescale 1ns/1ps
`include "alu.sv"

module alu_tb();

  // get all the signals
  logic [7:0]   a_i;
  logic [7:0]   b_i;
  logic [2:0]   op_i;
  logic [7:0]   alu_o;

  // instantiate the dut
  alu alu1(
    .a_i(a_i),
    .b_i(b_i),
    .op_i(op_i),
    .alu_o(alu_o)
  );

  initial begin
  $dumpfile("alu.vcd");
  $dumpvars(0, alu_tb);
  a_i = 8'b0; b_i = 8'b1; op_i = 3'b000;#5;
  a_i = 8'b10; b_i = 8'b1; op_i = 3'b001;#5;
  a_i = 8'b10; b_i = 8'b1; op_i = 3'b010;#5;
  a_i = 8'b10; b_i = 8'b1; op_i = 3'b011;#5;
  a_i = 8'b11; b_i = 8'b1; op_i = 3'b100;#5;
  a_i = 8'b111; b_i = 8'b1; op_i = 3'b101;#5;
  a_i = 8'b1000; b_i = 8'b1; op_i = 3'b110;#5;
  a_i = 8'b0; b_i = 8'b1; op_i = 3'b111;#5;
  a_i = 8'b1; b_i = 8'b1; op_i = 3'b111;#5;
  $finish;
  end


endmodule
