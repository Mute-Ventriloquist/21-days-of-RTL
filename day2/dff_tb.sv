`timescale 1ns/1ps
`include "dff.sv"

module dff_tb();
// define all parameters
logic      clk;
logic      reset;
logic      d_i;
logic      q_norst_o;
logic      q_syncrst_o;
logic      q_asyncrst_o;

// instantiate the dut
dff dff1(
  .clk(clk),
  .reset(reset),
  .d_i(d_i),
  .q_norst_o(q_norst_o),
  .q_syncrst_o(q_syncrst_o),
  .q_asyncrst_o(q_asyncrst_o)
);

// start the clock - switches every 5 ns
initial begin
  clk <= 1'b0;
  forever begin
    clk = ~clk;
    #5;
  end
end

// tests

initial begin 
  $dumpfile("dff.vcd");
  $dumpvars(0, dff_tb);
  d_i = 0; reset = 0;
  #10;
  d_i = 1; 
  #10; // observe input changing to 1
  reset = 1;
  #10; // norst - 1; syncrst,async - 0
  reset = 0; 
  #13; // all ops back to 1
  reset = 1; 
  #10 // async rst test
  $finish;
end

endmodule
