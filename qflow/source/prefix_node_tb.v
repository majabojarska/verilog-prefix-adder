`include "prefix_node.v"

// Testbench
module prefix_node_tb;

reg gen_high, prop_high, gen_low, prop_low;
wire gen_out, prop_out;

initial begin 
    $monitor (
        "{\"GH\":\"%b\", \"PH\":\"%b\", \"GL\":\"%b\", \"PL\":\"%b\" ,\"GOUT\":\"%b\", \"POUT\":\"%b\"}", 
        gen_high, prop_high, gen_low, prop_low, gen_out, prop_out
    );

    for(int i=0; i<2**4; i=i+1) begin
        {gen_high, gen_low, prop_high, prop_low} = i;
        #1;
    end
    
    #1 $finish;
end

// UUT
prefix_node U0 (
    .gen_high (gen_high), 
    .prop_high (prop_high), 
    .gen_low (gen_low), 
    .prop_low (prop_low), 
    .gen_out (gen_out), 
    .prop_out (prop_out)
);

endmodule
