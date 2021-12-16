//////////////////////////////////////////////////////////////
// tb_findMax.sv - Testbench to verify that the findMax FSM-D works as specified
//
// Author:	Roy Kravitz (roy.kravitz@pdx.edu) 
// Date:	13-Oct-2021
//
// Description:
// ------------
// Implements a testbench for the findMax problem on Homework #2.  This testbench
// makes use several of the SystemVerilog verification features including classes
// and constrained randomization and assertions.   These verification constructs are not
// synthesizable.
//
// Original testbench provided by Donald Thomas (Solution is in Problem 7.6)
////////////////////////////////////////////////////////////////
module tb_findMax;

// make use of the SystemVerilog C programming interface
// https://stackoverflow.com/questions/33394999/how-can-i-know-my-current-path-in-system-verilog
import "DPI-C" function string getenv(input string env_name);

// inputs and outputs to the findMax FSM-D
logic start, clk, rst, done;
logic [7:0] inputA, maxValue;

bit [7:0] myMax, savedMax;
int errorCnt = 0;

// instantiate the findMax FSM-D
findMax DUT(.*);

initial begin: monitor_outputs
    $monitor($time,, "st=%s, ns=%s, start=%b, inputA=%h, done=%b, myMax=%h, maxValue=%h",
        DUT.FSM.current_st, DUT.FSM.next_st, start, inputA, done, myMax, maxValue);
end: monitor_outputs

initial begin: clock_reset_gen
    rst = 0;
    rst <= 1;
    #1 rst = 0;
    clk = 0;
    forever #5 clk = ~clk;
end: clock_reset_gen

// number generator (uses constrained randomization)
class pktMax;
    rand bit [7:0] howMany;
    rand bit [7:0] item[];
    
    constraint N    {howMany inside {[4:20]};};
    constraint arraySize {item.size == howMany;}
endclass

pktMax pkt = new;

// stimulus generator and checker
initial begin: stimulus
    // TODO: CHANGE THE GREETING MESSAGE
    $display("ECE (System)Verilog workshop Fall 2021: findMax test - Pradeep Reddy (pmanthu@pdx.edu)");
    $display("Sources: %s\n", getenv("PWD"));
    
    start = 0;
    repeat(20) begin: gen_test_cases
        byte i;
        
        @(posedge clk);
        assert(pkt.randomize()) else $error("Problems generating random numbers");
        
        for (i = 0, myMax = 0; i <pkt.howMany; i++) begin: apply_test_case
            inputA <= pkt.item[i];
            myMax <= (pkt.item[i] < myMax) ? myMax : pkt.item[i];
            start <= 1;
            @(posedge clk);
        end: apply_test_case
        start <= 0;
        @(posedge clk);
        savedMax = myMax;
        if (myMax == maxValue) begin
            $display("Correct max (%h) found", maxValue);
        end
        else begin
            $display("Incorrect max (%h) found, should be %h", maxValue, myMax);
            errorCnt++;
        end
            
        if ((pkt.howMany % 8'h03) == 8'h03)
            @(posedge clk);  // start comes back immediately now and then
    end: gen_test_cases
    
    @(posedge clk);
    if (errorCnt == 0)
        $display("Congratulations!  Your implementation passes the testbenc");
    else
        $display("Nice try, but you had %d errors...take a break, do some debug, and try again", errorCnt);
        
    $display("End simulation of findMax test - Pradeep Reddy (pmanthu@pdx.edu)\n");
    $stop;
end:  stimulus

endmodule: tb_findMax
    
        
