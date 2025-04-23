module linearsr(
  input     wire      clk,
  input     wire      reset,
  output    wire[3:0] lfsr_o
);
  logic[3:0] lfsr_reg;
  logic[3:0] lfsr_reg_next;
  
  always @(posedge clk) begin
    if (reset) begin
      lfsr_reg <= 4'b1110;
    end else begin
      lfsr_reg <= lfsr_reg_next;
    end
  end
  assign lfsr_reg_next = {lfsr_reg[2:0], lfsr_reg[1] ^ lfsr_reg[3]};
  assign lfsr_o = lfsr_reg;
endmodule
