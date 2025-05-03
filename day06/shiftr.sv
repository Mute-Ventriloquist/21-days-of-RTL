module shiftr (
  input     wire        clk,
  input     wire        reset,
  input     wire        x_i,      // Serial input

  output    wire[3:0]   sr_o
);
 
  logic[3:0] sr_o_reg;

  // write logic
  always_ff @(posedge clk) begin
    if(reset) begin
      sr_o_reg <= 3'b0000;
    end else begin
      sr_o_reg <= {x_i, sr_o_reg[3:1]};
    end
  end

  assign sr_o = sr_o_reg;
endmodule
