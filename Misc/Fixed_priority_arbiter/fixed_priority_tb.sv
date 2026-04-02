`timescale 1ns/1ps

module tb_fp;

  parameter WIDTH = 4;

  logic clk;
  logic rst;
  logic [WIDTH-1:0] req;
  logic [WIDTH-1:0] gnt;

  // Instantiate DUT
  fp #(WIDTH) dut (
    .clk(clk),
    .rst(rst),
    .req(req),
    .gnt(gnt)
  );

  // Clock generation (10ns period)
  always #5 clk = ~clk;

  // Task to display nicely
  task show;
    $display("Time=%0t | req=%b | gnt=%b", $time, req, gnt);
  endtask

  initial begin
    // Initialize
    clk = 0;
    rst = 1;
    req = 0;

    // Apply reset
    #10;
    rst = 0;

    // Test 1: single requests
    req = 4'b0001; #10; show(); // expect 0001
    req = 4'b0010; #10; show(); // expect 0010
    req = 4'b0100; #10; show(); // expect 0100
    req = 4'b1000; #10; show(); // expect 1000

    // Test 2: multiple requests (LSB priority)
    req = 4'b1010; #10; show(); // expect 0010
    req = 4'b1100; #10; show(); // expect 0100
    req = 4'b1111; #10; show(); // expect 0001

    // Test 3: no requests
    req = 4'b0000; #10; show(); // expect 0000

    // Random tests
    repeat (5) begin
      req = $urandom_range(0, 15);
      #10;
      show();
    end

    $finish;
  end

endmodule
