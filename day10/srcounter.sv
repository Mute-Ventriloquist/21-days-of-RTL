module srcounter (
  input     wire          clk,
  input     wire          reset = 1'b0,
  input     wire          load_i = 1'b0,
  input     wire[3:0]     load_val_i = 4'b0000,

  output    wire[3:0]     count_o
);

  // code the logic - assuming async reset
  logic[3:0] count_o_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count_o_reg <= 4'b0000;
    end else if (load_i && (count_o_reg == 4'b1111)) begin
      count_o_reg <= load_val_i;
    end else begin
      count_o_reg <= count_o_reg + 1;
    end
  end

  assign count_o = count_o_reg;

endmodule
