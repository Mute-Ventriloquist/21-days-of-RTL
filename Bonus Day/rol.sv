module rol #(
    parameter SIZE = 16, // Width of the data input and output
    parameter SHAMT_SIZE = $clog2(SIZE) // Width of the shift amount input
)(
    // Do not modify the input/output ports of this module
    input wire [SIZE-1:0]       data_i                 , // Input data to be rotated
    input wire [SHAMT_SIZE-1:0] shamt_i                , // Shift amount (number of positions to rotate)
    output wire [SIZE-1:0]       result_by_shift_o      , // Output result computed using the shift approach
    output wire [SIZE-1:0]       result_by_borders_o      // Output result computed using the border extension approach
);
 
  logic [2*SIZE-1:0] vec;

  assign vec = {data_i, data_i};

  // method 1 logic - using right and left shifting
  assign result_by_shift_o = (data_i << shamt_i) | (data_i >> (SIZE-shamt_i));

  // method 2 logic - border extension
  assign result_by_borders_o = vec[(2*SIZE-shamt_i-1) -: SIZE]; // some indexed part select thingy
     
endmodule
