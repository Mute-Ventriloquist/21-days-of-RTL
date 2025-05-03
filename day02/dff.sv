module dff (
  input     logic      clk,
  input     logic      reset,

  input     logic      d_i,

  output    logic      q_norst_o,
  output    logic      q_syncrst_o,
  output    logic      q_asyncrst_o
);

// async reset => doesnt wait for clock

always @(posedge reset) begin
  // async reset output gets zeroed
  q_asyncrst_o <= 1'b0;
end

always @(posedge clk) begin
  if(reset) begin
    q_syncrst_o <= 1'b0;
    q_asyncrst_o <= 1'b0;
    q_norst_o <= d_i;
  end else begin
    q_syncrst_o <= d_i;
    q_asyncrst_o <= d_i;
    q_norst_o <= d_i;
  end
end 
endmodule
