`timescale 1s/100ms
`include "sum.v"

module sum_tb();
reg [5:0] x;
reg [5:0] y;
wire [5:0] g;
wire [5:0] p;
wire [5:0] h;
wire [6:0] s;

sum isum (x,y,g,p,h,s);
initial
begin
    $monitor("x=%b, y=%b, g=%b, p=%b, h=%b, s=%b", x,y,g,p,h,s);
    $dumpfile("sum.vcd");
    $dumpvars(0, sum_tb);
    x = 6'b010101; y = 6'b001001; #10;
    //x = 6'b111000; y = 6'b010101; #10;
    //x = 6'b001001; y = 6'b010110; #10;
    //x = 6'b011011; y = 6'b101001; #10;
    $finish;
end
endmodule