`include "pg_in.v"

// Testbench
module pg_in_tb;

reg x, y, c_in;
wire gen, prop;

initial begin 
    $monitor (
        "{\"x\":\"%b\", \"y\":\"%b\", \"c_in\":\"%b\", \"gen\":\"%b\", \"prop\":\"%b\"}", 
        x, y, c_in, gen, prop
    );

    for(int i=0; i<2**3; i=i+1) begin
        {x, y, c_in} = i;
        #1;
    end

    #1 $finish;
end

// UUT
pg_in U0 (
    .x (x),
    .y (y),
    .c_in (c_in),
    .gen (gen),
    .prop (prop)
);

endmodule
