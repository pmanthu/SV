//////////////////////////////////////////////////////////////
// fsm.sv - SystemVerilog module that implements the control logic as a Mealy FSM.
//
// Author: Pradeep Reddy (pmanthu@pdx.edu)
// Date: 10/17/2021
//
// Description:
// ------------
// SystemVerilog module that implements the control logic as a Mealy FSM
////////////////////////////////////////////////////////////////

module fsm
(
input logic clk, rst, // clock and reset. Assert rst high to reset the FSM
input logic start, // start signal begin looking for the max value
input logic in_GTR_Max, // asserted by datapath if input data > the stored max value
output logic ldMax, // asserted by FSM to load a new value into the register
output logic done // asserted by FSM to indicate the no more number will be compared until start is received
);

parameter string s1="Reset";
parameter string s2="Check";

string current_st,next_st;

always @ (posedge clk or posedge rst) begin

if(rst)
	current_st<=s1;
else 
	current_st<=next_st;
end

always_comb begin

case(current_st)

s1:begin 
	if(start)
		next_st=s2;
	else
		next_st=s1;
end

s2:begin 
	if(start)
		next_st=s2;
	else
		next_st=s1;
end

default:next_st=s1;

endcase

end	

always_comb begin

case(current_st)

s1:begin
	if(start)
		ldMax=1;
	else
		ldMax=0;
end

s2:begin
	if(start)
		ldMax=in_GTR_Max?1:0;
	else
		done=1;
end

default:begin
	ldMax=0;
	done=0;
end

endcase

end

endmodule