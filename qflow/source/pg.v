module pg (
    input x, y,
    output gen, prop
);


assign gen = x & y;
assign prop = x ^ y;

endmodule
