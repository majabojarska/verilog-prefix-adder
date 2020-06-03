module prefix_node (
    input gen_high, gen_low, prop_high, prop_low,
    output gen_out, prop_out
);

assign gen_out = gen_high || (prop_high && prop_low);
assign prop_out = prop_high && prop_low;

endmodule

// Testbench
module prefix_node_tb;

reg gen_high, gen_low, prop_high, prop_low;
wire gen_out, prop_out;

initial begin 
    $monitor (
        "inputs: GH=%b, GL=%b, PH=%b, PL=%b | outputs: GOUT=%b, POUT=%b", 
        gen_high, gen_low, prop_high, prop_low, gen_out, prop_out
    );

    {gen_high, gen_low, prop_high, prop_low} = 4'b0000;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b0001;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b0010;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b0011;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b0100;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b0101;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b0110;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b0111;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b1000;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b1001;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b1010;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b1011;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b1100;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b1101;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b1110;
    #1 {gen_high, gen_low, prop_high, prop_low} = 4'b1111;
    
    #1 $finish;
end

// UUT
prefix_node U0 (
    .gen_high (gen_high), 
    .gen_low (gen_low), 
    .prop_high (prop_high), 
    .prop_low (prop_low), 
    .gen_out (gen_out), 
    .prop_out (prop_out)
);

endmodule