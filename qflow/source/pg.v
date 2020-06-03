module pg (
    input x, y,
    output gen, prop
);


assign gen = x && y;
assign prop = x ^ y;

endmodule

// Testbench
module pg_tb;

reg x, y;
wire gen, prop;

initial begin 
    $monitor ("inputs: x=%b, y=%b | outputs: gen=%b, prop=%b", x, y, gen, prop);
    
    {x, y} = 2'b00;
    #1 {x, y} = 2'b01;
    #1 {x, y} = 2'b10;
    #1 {x, y} = 2'b11;
    
    #1 $finish;
end

// UUT
pg U0 (
    .x (x),
    .y (y),
    .gen (gen),
    .prop (prop)
);

endmodule