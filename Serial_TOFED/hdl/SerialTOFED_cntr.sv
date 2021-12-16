//////////////////////////////////////////////////////////////////////////////
// SerialTOFED_cntr.sv - Serial TOFED
//
// Author:			Pradeep Reddy
// Version:			2.0
// Last modified:	22-Oct-2021
//
// Serial TOFED code that checks if exactly three bits are logic high and exactly two bits are logic low.
/////////////////////////////////////////////////////////////////////////////

import SerialTOFEDDefs::*;
module SerialTOFED_cntr(
input bit								din,		// Serial data input
output bool_t						 	valid,		// Valid outputs
input logic 						    clk,		// system clock
input logic							    resetH		// reset signal
);


int temp=0,one=0;

always @(posedge clk) begin: counter1
	if(!resetH)
		temp++;
end: counter1

always @(posedge clk) begin: counter2
	if(din==1'b1)
	one++;
		if(temp%5==0)begin
			if(one==3)
			valid=TRUE;
			else
			valid=FALSE;
		one=0;
		end
end: counter2

endmodule