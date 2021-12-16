//////////////////////////////////////////////////////////////
// comparator.sv - SystemVerilog module for a parameterized comparator.
//
// Author: Pradeep Reddy (pmanthu@pdx.edu)
// Date: 10/17/2021
//
// Description:
// ------------
// The comparator is a combinational logic block that compares two unsigned numbers and determines whether A is less than B, equal to B, or greater than B.
////////////////////////////////////////////////////////////////

module comparator
#(
parameter WIDTH = 8
)
(
input logic [WIDTH-1:0] A, B, // A and B unsigned numbers to compare
output logic AltB, // asserted high if A < B
output logic AeqB, // asserted high if A = B
output logic AgtB // asserted high if A > B
);

always_comb begin

	if(A<B)
	 AgtB=1;
	else
	 AgtB=0;

	if(A==B)
	 AeqB=1;
	else
	 AeqB=0;
	 
	if(A>B)
	 AltB=1;
	else
	 AltB=0;
end

endmodule