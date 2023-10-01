// Design
module nand_not (input a, output z);
  nand(z,a,a);
endmodule

module nand_and (input a, input b, output z);
  wire q;
  nand(q,a,b);
  
  nand_not nand_not1(.a(q), .z(z));
endmodule

module nand_or (input a, input b, output z);
  wire q1;
  wire q2;
  nand(q1,a,a);
  nand(q2,b,b);
  
  nand(z,q1,q2);
endmodule

//A&!B+!A&B
module nand_xor (input a, input b, output z);
  wire na;
  wire nb;
  nand_not nand_not1(a, na);
  nand_not nand_not2(b, nb);
  
  wire q1;
  wire q2;
  nand_and nand_and1(a, nb, q1);
  nand_and nand_and2(b, na, q2);

  nand_or nand_or1(q1, q2, z);
endmodule

//if sel = 0, a; else b
//STRUCTURAL : !sel&a + sel&b
module nand_mux (input a, input b, input sel, output z);
  wire nsel;
  nand_not nand_not1(sel, nsel);
  
  wire q1;
  wire q2;
  nand_and nand_and1(nsel, a, q1);
  nand_and nand_and2(sel, b, q2);

  nand_or nand_or1(q1, q2, z);
endmodule

//if sel = 0, a; else b
//DATA FLOW : !sel&a + sel&b
module nand_mux_alt1 (input a, input b, input sel, output z);
  assign z =~sel&a|sel&b;
endmodule

//if sel = 0, a; else b
//BEHAVIORAL : !sel&a + sel&b
module nand_mux_alt2 (input a, input b, input sel, output logic z);
  always@(a,b,sel)
    begin
      if (sel == 0)
      	z=a;
      else
      	z=b;
    end
endmodule

//if sel = 0, then a=in, b = 0; else a = 0, b = in
module nand_dmux (input in, input sel, output logic a, output logic b);
  always@(in,sel)
    begin
      if (sel == 0) begin
      	a=in;
        b=0;
      end else begin
        a=0;
        b=in;
      end
    end
endmodule


// Multi-input AND Gate
module nand_and_multi #(parameter WIDTH = 8) (
    input logic [WIDTH-1:0] in,
    output logic out
);
  
  always_comb begin //always_comb used for combinational logic
    out = 1;
    for(int i=0; i<WIDTH; i=i+1) begin
      if (in[i] == 0) begin
        out = 0;
        break;
      end
    end
  end
  
endmodule

// Multi-input OR Gate
module nand_or_multi #(parameter WIDTH = 8) (
    input logic [WIDTH-1:0] in,
    output logic out
);
  
  always_comb begin //always_comb used for combinational logic
    out = 0;
    for(int i=0; i<WIDTH; i=i+1) begin
      if (in[i] == 1) begin
        out = 1;
        break;
      end
    end
  end
  
endmodule
