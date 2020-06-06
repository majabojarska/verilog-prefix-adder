`include "pg.v"

// Testbench
module pg_tb;

reg x, y;
wire gen, prop, half_sum;

initial begin 
    $monitor ("{\"x\":\"%b\", \"y\":\"%b\", \"gen\":\"%b\", \"prop\":\"%b\", \"half_sum\":\"%b\"}", x, y, gen, prop, half_sum);
    
    for(int i=0; i<4; i=i+1) begin
        {x, y} = i;
        #1;
    end
    
    #1 $finish;
end

// UUT
pg U0 (
    .x (x),
    .y (y),
    .gen (gen),
    .prop (prop),
    .half_sum (half_sum)
);

endmodule