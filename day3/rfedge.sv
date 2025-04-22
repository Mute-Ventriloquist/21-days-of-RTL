
module rfedge (
  input     wire    clk,
  input     wire    reset,

  input     wire    a_i,

  output    wire    rising_edge_o,
  output    wire    falling_edge_o
);

logic rising_edge_reg, falling_edge_reg, a_prev;


always_ff @(posedge clk or posedge reset) begin
  if (reset) begin
    a_prev <= 1'b0;
    rising_edge_reg <= 1'b0;
    falling_edge_reg <= 1'b0;
  end else begin
    a_prev <= a_i;
    rising_edge_reg <= (!a_prev && a_i);
    falling_edge_reg <= (a_prev && !a_i);
  end
end

assign rising_edge_o = rising_edge_reg;
assign falling_edge_o = falling_edge_reg;


endmodule
