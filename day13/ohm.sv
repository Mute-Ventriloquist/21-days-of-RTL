module ohm(
  input wire[3:0] sel,
  input wire[3:0] a,
  // Output using ternary operator
  output    wire     y_ter_o,
  // Output using case
  output    logic     y_case_o,
  // Ouput using if-else
  output    logic     y_ifelse_o,
  // Output using for loop
  output    logic     y_loop_o,
  // Output using and-or tree
  output    logic     y_aor_o
);

  // declaring internal logic
  genvar i;

  // Output using ternary operator : defaults to zero in case sel == 0000 if any of the digits are one then MSB 1 wins
  assign y_ter_o = sel[3] ? a[3] : (sel[2] ? a[2] : (sel[1] ? a[1] : (sel[0] ? a[0] : 0)));

  // Output using case : similar default condition
  always_comb begin
    case (sel)
      4'b1000 : y_case_o = a[3];
      4'b0100 : y_case_o = a[2];
      4'b0010 : y_case_o = a[1];
      4'b0001 : y_case_o = a[0];
      default : y_case_o = 1'b0;
    endcase
  end

  // Output using if else 
  always_comb begin
    if(sel[3]) begin
      y_ifelse_o = a[3];
    end else begin
      if(sel[2]) begin
        y_ifelse_o = a[2];
      end else begin
        if(sel[1]) begin
          y_ifelse_o = a[1];
        end else begin
          if(sel[0]) begin
            y_ifelse_o = a[0];
          end else begin
            y_ifelse_o = 1'b0;
          end
        end
      end
    end
  end

  // Output using for loop - had to look at solution :(
  always_comb begin
    y_loop_o = '0;
    for (int i=0; i<4; i++) begin
      y_loop_o = (sel[i] & a[i]) | y_loop_o;
    end
  end

  // Output using and or tree
  always_comb begin
    y_aor_o = (sel[0] & a[0]) | (sel[1] & a[1]) | (sel[2] & a[2]) | (sel[3] & a[3]);
  end

endmodule
