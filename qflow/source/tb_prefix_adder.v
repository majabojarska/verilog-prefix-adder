`include "prefix_adder.v"

module prefix_adder_tb;

reg [5:0] X;
reg [5:0] Y;
reg c_in;

wire [6:0] S;

parameter TEST_SIGNAL_COUNT = 2 ** (13);

initial begin 
    $monitor (
        "{\"time\": \"%t\", \"X\": \"%6b\", \"Y\": \"%6b\", \"c_in\":\"%b\", \"S\": \"%6b\"}", 
        $time, X, Y, c_in, S
    );

    for(int i=0; i<TEST_SIGNAL_COUNT; i=i+1) begin
        {X, Y, c_in} = i;
        #1;
    end

    #1 $finish;
end

// UUT
prefix_adder U0 (
    .X(X),
    .Y(Y),
    .c_in(c_in),
    .S(S)
);

endmodule
