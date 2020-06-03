module pg (
    x, y, g, p
);

input x, y;
output g, p; // generation, propagation

assign g = x && y;
assign p = x ^ y;

endmodule

// Testbench
module pg_tb;

reg x, y;
wire p, g;

initial begin 
    $monitor ("inputs: x=%b, y=%b | outputs: g=%b, p=%b", x, y, g, p);
    
    {x, y} = 2'b00;
    #1 {x, y} = 2'b01;
    #1 {x, y} = 2'b10;
    #1 {x, y} = 2'b11;
end

initial begin
    #10 $finish;
end

// UUT
pg U0 (
    .x (x),
    .y (y),
    .g (g),
    .p (p)
);

endmodule