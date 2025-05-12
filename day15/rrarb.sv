module rrarb (
  input wire [3:0] req_i,
  input wire clk,
  input wire reset,
  output wire [3:0] gnt_o
);

  logic [1:0] ptr;
  logic [3:0] req_cpy;
  logic [3:0] gnt_o_reg;

  always_comb begin
    case (ptr)
      2'b00: req_cpy = req_i;
      2'b01: req_cpy = {req_i[0], req_i[3:1]};
      2'b10: req_cpy = {req_i[1:0], req_i[3:2]};
      2'b11: req_cpy = {req_i[2:0], req_i[3]};
    endcase
  end


  always @(posedge clk or posedge reset) begin
    if (reset) begin
      gnt_o_reg <= 4'b0000;
      ptr       <= 2'b00;
    end else begin
      // Find LSB (same as original)
      gnt_o_reg <= (req_cpy & (~req_cpy + 1)) << ptr;

      // Update pointer (same as original)
      case ((req_cpy & (~req_cpy + 1)) << ptr)
        4'b0001: ptr <= 2'b01;
        4'b0010: ptr <= 2'b10;
        4'b0100: ptr <= 2'b11;
        4'b1000: ptr <= 2'b00;
        default: ptr <= 2'b00;  // Optional: handle no grant case
      endcase
    end
  end

  assign gnt_o = gnt_o_reg;

endmodule
