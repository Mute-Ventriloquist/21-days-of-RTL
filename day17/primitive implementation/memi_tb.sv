`timescale 1ns/1ps
`include "memi.sv"


module memi_tb();
  
  // connection instantiation
  logic        clk;
  logic        reset;

  logic        req_i;
  logic        req_rnw_i;    // 1 - read, 0 - write
  logic[3:0]   req_addr_i;
  logic[31:0]  req_wdata_i;
  logic        req_ready_o;
  logic[31:0]  req_rdata_o;

  // dut instantiation
  memi m1(.*);

  // clk start
  initial begin
    clk = 1'b0;
    forever begin
      clk = ~clk;
      #5;
    end
  end

  // start tests
  initial begin
    $dumpfile("memi.vcd");
    $dumpvars(0, memi_tb);
    reset = 1; req_i = 0; req_rnw_i = 0; req_wdata_i = 1; req_addr_i = 0;
    #20;
    // load initial conditions while keeping reset at 1
    req_i = 1; req_rnw_i = 0; req_wdata_i = 32'hABCDEFAB; req_addr_i = 13;
    #20;
    reset = 0;
    #20;
    reset = 1; req_rnw_i = 1;
    #20;
    // read from same address
    reset = 0;
    #20;
    $finish;
  end
endmodule
