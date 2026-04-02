module fp #(parameter WIDTH = 4) (
  input  logic clk,
  input  logic rst,
  input  logic [WIDTH-1:0] req,
  output logic [WIDTH-1:0] gnt
);

  always_ff @(posedge clk) begin
    if (rst) begin
      gnt <= '0;
    end else begin
      gnt <= '0; // default

      for (int i = 0; i < WIDTH; i++) begin
        if (req[i]) begin
          gnt <= 1 << i;
          break;
        end
      end
    end
  end

endmodule
