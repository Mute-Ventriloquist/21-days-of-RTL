module pa #(
  parameter NUM_PORTS = 4
)(
  input wire[NUM_PORTS-1:0] req_i,
  output wire[NUM_PORTS-1:0] gnt_o   // One-hot grant signal
);
  assign gnt_o = req_i & (~req_i + 1);
endmodule
