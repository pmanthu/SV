//////////////////////////////////////////////////////////////
// findMax.sv - Top level (DUT) module for the findMaxValue FSM-D.
//
// Author: Pradeep Reddy (pmanthu@pdx.edu)
// Date: 10/17/2021
//
// Description:
// ------------
// This module instantiates design modules and connect them together
////////////////////////////////////////////////////////////////

module findMax
(
input clk, rst, // clock and reset signals. rst is asserted high
// to clear register and reset FSM
input logic start, // start signal asserted to start detecting a max
// value from a stream of input values
input logic [7:0] inputA, // holds the input data that is streamed to
// the findMax FSM-D
output logic [7:0] maxValue, // holds the current maximum value for the sequence
// being checked
output done // asserted high for one cycle when the checking
// sequence is complete
);

logic AGTB,FSM_OUT;

register r(.D(inputA),.Q(maxValue),.clk(clk),.rst(rst),.en(FSM.ldMax));
comparator c(.A(maxValue),.B(inputA),.AgtB(AGTB),.AltB(),.AeqB());
fsm FSM(.clk(clk),.rst(rst),.start(start),.in_GTR_Max(c.AgtB),.ldMax(FSM_OUT),.done(done));

endmodule