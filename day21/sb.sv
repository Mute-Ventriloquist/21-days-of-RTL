module sb #(
  parameter WIDTH = 12
)(
  input wire[WIDTH-1:0] vec_i,
  output wire[WIDTH-1:0] second_bit_o 
);
  // instantiate intra module vars
  logic[WIDTH-1:0] vec1; // bitmask to mask the 1st set 1.
  logic[WIDTH-1:0] vec2; // vec_i without first bit set
  

  // write the logic
  assign vec1 = vec_i & (~vec_i + 1); 
  assign vec2 = vec_i & (~vec1); 
  assign second_bit_o = vec2 & (~vec2 + 1);
  
  
endmodule
