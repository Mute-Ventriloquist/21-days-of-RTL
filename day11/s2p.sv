module s2p(
  input     wire      clk,
  input     wire      reset,
  output    wire      empty_o,
  input     wire[3:0] parallel_i,
  output    wire      serial_o,
  output    wire      valid_o
);

  // empty_o = 1 ---> streaming done
  // valid_o = 1 ---> data valid
  // serial_o idle state ---> 0
  // assuming asynchronous reset

  reg empty_reg;
  reg[3:0] parallel_reg;
  reg serial_reg;
  reg valid_reg;
  reg[2:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      empty_reg <= 1'b1;
      serial_reg <= 1'b0;
      valid_reg <= 1'b0;
      count <= 3'b111;
    end
    else begin
      // Remove the empty_reg and valid_reg checks for first sample
      if ((count == 3'b111) || (count >= 3'b011)) begin  // Simplified condition
        parallel_reg <= parallel_i;
        count <= 3'b00;
        empty_reg <= 1'b0;
        valid_reg <= 1'b1;
        serial_reg <= parallel_i[0];  // Output first bit immediately
      end
      else if ((count < 3'b100) && (empty_reg == 1'b0)) begin
        serial_reg <= parallel_reg[count];
        count <= count + 1;
      end
    end
  end
  
  assign empty_o = empty_reg;
  assign serial_o = serial_reg;
  assign valid_o = valid_reg;
endmodule
