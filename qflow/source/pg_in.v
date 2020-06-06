module pg_in (
    input x, y, c_in, 
    output gen, prop
);

assign gen = (x & y) | (c_in & (x | y));
assign prop = x ^ y ^ c_in;

endmodule
