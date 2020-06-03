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
    
    x = 0;
    y = 0;
    
    #5 x = 0;
    #5 y = 1;
    
    #10 x = 1;
    #10 y = 0;
    
    #15 $finish;
    #15 x = 1;
    #15 y = 1;
end

pg U0 (
    .x (x),
    .y (y),
    .g (g),
    .p (p)
);

endmodule