`ifndef SYNTHESIS

`include "mycpu.svh"

import mycpu_pkg::*;

module pc_tb;

   
`ifdef RTL_SIM
 `include "mycpu_svabind.svh"   
`endif 
   

endmodule

`endif
