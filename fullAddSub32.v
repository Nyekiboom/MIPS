module fullAddSub32(
  num1,
  num2,
  op,
  sumO,
  carryO
);
  //O berarti OUT :)
  input [31:0] num1;
  input [31:0] num2;
  input op; /* 0 add, 1 subtract */ 
  output [31:0] sumO;
  output carryO;
  
  wire [31:0] sum;
  wire [31:0] carry;
  wire [31:0] num2Comp;

  assign num2Comp = (op == 1'b1) ? ~num2 : num2; //Operasi komoplemeb num2 saat mode SUBTRACT

  genvar i;
  generate 
    for (i = 0; i < 32; i = i + 1) begin
      if (i == 0)
        fullAdder addr(num1[i], num2Comp[i], op, sum[i], carry[i]);
      else
        fullAdder addr(num1[i], num2Comp[i], carry[i-1], sum[i], carry[i]);
    end
  endgenerate

  assign sumO = sum;
  //assign carryO = (op == 1'b1) ? ~carry[31] : carry[31];  //Detection overflow
  assign carryO = carry[30] ^ carry[31]; //Detection overflow
endmodule


