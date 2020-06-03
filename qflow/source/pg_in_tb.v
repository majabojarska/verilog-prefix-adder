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

    {x, y, c_in} = 3'b000;
    #1 {x, y, c_in} = 3'b010;
    #1 {x, y, c_in} = 3'b100;
    #1 {x, y, c_in} = 3'b110;
    #1 {x, y, c_in} = 3'b001;
    #1 {x, y, c_in} = 3'b011;
    #1 {x, y, c_in} = 3'b101;
    #1 {x, y, c_in} = 3'b111;

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
