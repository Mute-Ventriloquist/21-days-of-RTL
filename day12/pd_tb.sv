`include "pd.sv"
`timescale 1ns/1ps


module pd_tb();

  // initialise all the dut connections
  logic clk;
  logic x_i;
  logic reset;
  logic det_o;

  // localparam
  localparam SEQ_LEN = 12;
  localparam PAT = 12'b1110_1101_1011;

  // tb specific instantiations
  logic[0:21] big_seq = 22'b1110_1101_1011_1011_0110_11;
  
  // instantiate the dut
  pd #(
    .SEQ_LEN(SEQ_LEN),
    .PAT(PAT)
  ) pd1 (.*);

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
    $dumpfile("pd.vcd");
    $dumpvars(0, pd_tb);
    // reset for 20 cycles
    x_i = 1'b0; reset = 1'b1;
    #20;
    // overlapping seq
    reset = 1'b0;
    for (int i = 0; i < 22; i++) begin
      x_i = 1'(big_seq[i]);
      #10;
    end
    // end on a reset seq
    reset = 1'b1; x_i = 1'b1;
    #20;
    $finish;
  end
endmodule
