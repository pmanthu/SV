//////////////////////////////////////////////////////////////
// register.sv - SystemVerilog model for the register in the datapath.
//
// Author: Pradeep Reddy (pmanthu@pdx.edu)
// Date: 10/17/2021
//
// Description:
// ------------
// SystemVerilog model for the register in the datapath.
////////////////////////////////////////////////////////////////

module register
#(
parameter WIDTH = 8
)
(
input logic [WIDTH-1: 0] D, // D input to the register
input logic en, // enable. Assert high to load D into the register
input logic clk, rst, // clock and reset. Assert rst high to clear the register
output logic [WIDTH-1:0] Q // Q output from the register
);

always @(posedge clk or posedge rst) begin
if(rst)
Q<=0;
else begin
	if(en)
	Q<=D;
end

end

endmodule