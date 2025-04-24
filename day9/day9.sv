module bg #(
  parameter VEC_W = 3
)(
  input wire[VEC_W-1:0] bin_i,
  output wire[VEC_W-1:0] gray_o
);

  // keep the first bit same and the consecutive bits are obtained by xors
  assign gray_o[VEC_W-1] = bin_i[VEC_W-1];
  generate
    for (genvar i = 0; i<VEC_W-1; i++) begin
      assign gray_o[i] = bin_i[i]^bin_i[i+1];
    end
  endgenerate
endmodule
