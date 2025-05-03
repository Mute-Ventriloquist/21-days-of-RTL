module oddcnt (
  input     wire        clk,
  input     wire        reset,

  output    logic[7:0]  cnt_o
);

  // write the logic
  always_ff @(posedge clk) begin
    if(reset) begin
      cnt_o <= 8'b1;
    end else if(cnt_o == 8'b11111111) begin
      cnt_o <= 8'b1;
    end else begin
      cnt_o <= cnt_o + 8'b10;
    end
  end
endmodule

// note : case of overflow is considered
