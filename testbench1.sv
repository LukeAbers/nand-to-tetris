// Simple Testbench to ensure the initial modules are in proper working order
module test;

  reg x;
  reg y;
  reg s;
  wire zed;
  wire whye;
  
  logic [0:7] r;
  
  // Instantiate design under test
  //nand_mux nand_mux2(.a(x), .b(y), .sel(s), .z(zed));
  //nand_or nand_or1(.a(x), .b(y), .z(zed));
  //nand_dmux nand_dmux1(.in(x), .sel(s), .a(zed), .b(whye));
  
  //#8 is a parameter defining the width of the input array
  nand_or_multi #8 or8_inst(.in(r), .out(zed));

  initial begin
    $display("Begin SIMULATION.");
    r = 8'b11101111;
;
    display;
    
    
   /*
    y=0;
    x=0;
    s=0;
    display2;
    
    x=1;
    s=0;
    display2;
    
    x=0;
    s=1;
    display2;
    
    x=1;
    s=1;
    display2;

    s = 0;
    
    x = 0;
    y = 0;
    display;
    x = 1;
    y = 0;
    display;
    x = 0;
    y = 1;
    display;
    x = 1;
    y = 1;
    display;
    
    s = 1;
    
    x = 0;
    y = 0;
    display;
    x = 1;
    y = 0;
    display;
    x = 0;
    y = 1;
    display;
    x = 1;
    y = 1;
    display;  
*/
  end
  
  task display;
    #1 $display(x, y, ":", s, ":" , zed);
  endtask
  
  task display2;
    #1 $display(x, y, ":", s, ":" , zed, ":", whye);
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule
