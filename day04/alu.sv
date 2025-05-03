module alu (
  input     logic [7:0]   a_i,
  input     logic [7:0]   b_i,
  input     logic [2:0]   op_i,

  output    logic [7:0]   alu_o
);

always_comb begin
  case (op_i)
    3'b000: alu_o = a_i + b_i; // ADD
    3'b001: alu_o = a_i - b_i; // SUB
    3'b010: alu_o = a_i << b_i[2:0]; // Left Shift
    3'b011: alu_o = a_i >> b_i[2:0]; // Right Shift
    3'b100: alu_o = a_i & b_i; // Bitwise AND
    3'b101: alu_o = a_i | b_i; // Bitwise OR
    3'b110: alu_o = a_i ^ b_i; // Bitwise XOR
    3'b111: alu_o = (a_i == b_i) ? 8'b1 : 8'b0; // EQ
    default: alu_o = 8'b0; 
  endcase
end
endmodule