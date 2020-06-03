module pg_in (
    input x, y, c_in, 
    output g, p // generation, propagation
);

assign g = (x && y) || (c_in && (x || y));
assign p = x ^ y ^ c_in;

endmodule

// Testbench
module pg_in_tb;

reg x, y, c_in;
wire p, g;

initial begin 
    $monitor ("inputs: x=%b, y=%b, c_in=%b | outputs: g=%b, p=%b", x, y, c_in, g, p);

    {x, y, c_in} = 3'b000;
    #1 {x, y, c_in} = 3'b010;
    #1 {x, y, c_in} = 3'b100;
    #1 {x, y, c_in} = 3'b110;
    #1 {x, y, c_in} = 3'b001;
    #1 {x, y, c_in} = 3'b011;
    #1 {x, y, c_in} = 3'b101;
    #1 {x, y, c_in} = 3'b111;
end

initial begin
    #10 $finish;
end

// UUT
pg_in U0 (
    .x (x),
    .y (y),
    .c_in (c_in),
    .g (g),
    .p (p)
);

endmodule