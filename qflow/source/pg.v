module pg (
    input x, y,
    output gen, prop, half_sum
);


assign gen = x & y;
assign prop = x | y;
assign half_sum = x ^ y;

endmodule
