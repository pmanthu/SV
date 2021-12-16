//////////////////////////////////////////////////////////////////////////////
// SerialTOFEDDefs.sv - Global definitions for Serial TOFED problem
//
// Author:			Roy Kravitz
// Version:			2.0
// Last modified:	11-Oct-2021
//
// Contains the global typedefs, const, enum, structs, etc. for the Serial 
// TOFED problem.
/////////////////////////////////////////////////////////////////////////////
package SerialTOFEDDefs;

parameter FBIBBLE_SIZE = 5;
parameter ONESPERFBIBBLE = 3;

typedef enum {FALSE, TRUE} bool_t;

endpackage