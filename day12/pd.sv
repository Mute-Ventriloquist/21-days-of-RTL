module pd #(
  parameter SEQ_LEN = 8,
  parameter PAT = 8'b1010_1100
)(
  input wire x_i,
  input wire reset,
  output wire det_o,
  input wire clk
 
);

  reg[SEQ_LEN-1:0] sr;
  reg det_o_reg;

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      sr <= 'b0;
      det_o_reg <= 1'b0; 
    end else begin
      sr <= (sr << 1);
      sr[0] <= x_i;
      if ({sr[SEQ_LEN-2:0], x_i} == PAT) begin
        det_o_reg <= 1'b1;
      end else begin
        det_o_reg <= 1'b0;
      end
    end
  end
  
  assign det_o = det_o_reg;

endmodule
