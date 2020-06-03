module prefix_node (
    input gen_high, prop_high, gen_low, prop_low,
    output gen_out, prop_out
);

assign gen_out = gen_high || (prop_high && prop_low);
assign prop_out = prop_high && prop_low;

endmodule
