`timescale 1ns/1ps
`include "rol.sv"


module rol_tb ();
  // instantiate localparams
  localparam SIZE = 16;
  localparam SHAMT_SIZE = $clog2(SIZE);

  // instantiate dut connections
  logic[SIZE-1:0] data_i;
  logic[SHAMT_SIZE-1:0] shamt_i;
  logic[SIZE-1:0] result_by_shift_o;
  logic[SIZE-1:0] result_by_borders_o;

  // instantiate dut
  rol #(.SIZE(SIZE), .SHAMT_SIZE(SHAMT_SIZE)) rol1 (.*);
  
  // start tests
  initial begin
    $dumpfile("rol.vcd");
    $dumpvars(0, rol_tb);
    for (int i = 0; i < 20; i++) begin
      data_i = $urandom_range(0, 16'hFFFF);
      shamt_i = $urandom_range(0, 4'hF);
      #5;
    end
    $finish;
  end
  
endmodule
