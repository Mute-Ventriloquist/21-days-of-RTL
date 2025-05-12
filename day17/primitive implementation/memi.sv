// A memory interface

module memi (
  input       wire        clk,
  input       wire        reset,

  input       wire        req_i,
  input       wire        req_rnw_i,    // 1 - read, 0 - write
  input       wire[3:0]   req_addr_i,
  input       wire[31:0]  req_wdata_i,
  output      wire        req_ready_o,
  output      wire[31:0]  req_rdata_o
);

  // Write your logic here...

  // Memory array
  logic [15:0][31:0] mem;
  logic req_ready_reg;
  logic[31:0] req_rdata_reg;

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      req_ready_reg <= 1'b0;
    end else begin
      if(req_i) begin // valid request
        if(req_rnw_i) begin // read
          req_ready_reg <= 1'b1;
          req_rdata_reg <= mem[req_addr_i];
        end else begin // write
          req_ready_reg <= 1'b1;
          mem[req_addr_i] <= req_wdata_i;
        end
      end
    end
  end
 
  assign req_ready_o = req_ready_reg;
  assign req_rdata_o = req_rdata_reg;



endmodule
