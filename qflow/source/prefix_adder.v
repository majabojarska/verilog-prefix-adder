`include "pg.v"
`include "pg_in.v"
`include "prefix_node.v"

module prefix_adder (
    X, Y, c_in, S
);

input [5:0] X;
input [5:0] Y;
input c_in;

output [6:0] S; // Sum

// PG block outputs, p - propagation, g - generation.
wire [5:0] pg_out_p;
wire [5:0] pg_out_g;
wire [5:0] pg_out_h;

// Prefix graph nodes outputs, p - propagation, g - generation.
wire [6:0] node_out_p;
wire [6:0] node_out_g;

pg_in pg_in_block(
    .x(X[0]), 
    .y(Y[0]), 
    .c_in(c_in),
    .gen(pg_out_g[0]), 
    .prop(pg_out_p[0])
);

pg pg_blocks[5:1] (
    .x(X[5:1]), 
    .y(Y[5:1]), 
    .gen(pg_out_g[5:1]), 
    .prop(pg_out_p[5:1]),
    .half_sum(pg_out_h[5:1])
);

// Instantiate prefix graph nodes.
prefix_node prefix_node_0(
    .gen_high(pg_out_g[1]),
    .prop_high(pg_out_p[1]), 
    .gen_low(pg_out_g[0]), 
    .prop_low(pg_out_p[0]),
    .gen_out(node_out_g[0]),
    .prop_out(node_out_p[0])
);
prefix_node prefix_node_1(
    .gen_high(pg_out_g[3]),
    .prop_high(pg_out_p[3]), 
    .gen_low(pg_out_g[2]), 
    .prop_low(pg_out_p[2]),
    .gen_out(node_out_g[1]),
    .prop_out(node_out_p[1])
);
prefix_node prefix_node_2(
    .gen_high(pg_out_g[5]),
    .prop_high(pg_out_p[5]), 
    .gen_low(pg_out_g[4]), 
    .prop_low(pg_out_p[4]),
    .gen_out(node_out_g[2]),
    .prop_out(node_out_p[2])
);
prefix_node prefix_node_3(
    .gen_high(pg_out_g[2]),
    .prop_high(pg_out_p[2]), 
    .gen_low(node_out_g[0]), 
    .prop_low(node_out_p[0]),
    .gen_out(node_out_g[3]),
    .prop_out(node_out_p[3])
);
prefix_node prefix_node_4(
    .gen_high(node_out_g[1]),
    .prop_high(node_out_p[1]), 
    .gen_low(node_out_g[0]), 
    .prop_low(node_out_p[0]),
    .gen_out(node_out_g[4]),
    .prop_out(node_out_p[4])
);
prefix_node prefix_node_5(
    .gen_high(pg_out_g[4]),
    .prop_high(pg_out_p[4]), 
    .gen_low(node_out_g[4]), 
    .prop_low(node_out_p[4]),
    .gen_out(node_out_g[5]),
    .prop_out(node_out_p[5])
);
prefix_node prefix_node_6(
    .gen_high(node_out_g[2]),
    .prop_high(node_out_p[2]), 
    .gen_low(node_out_g[4]), 
    .prop_low(node_out_p[4]),
    .gen_out(node_out_g[6]),
    .prop_out(node_out_p[6])
);


// Assign S output values.
assign S[0] = pg_out_p[0];
assign S[1] = pg_out_h[1] ^ pg_out_g[0];
assign S[2] = pg_out_h[2] ^ node_out_g[0];
assign S[3] = pg_out_h[3] ^ node_out_g[3];
assign S[4] = pg_out_h[4] ^ node_out_g[4];
assign S[5] = pg_out_h[5] ^ node_out_g[5];
assign S[6] = node_out_g[6];

endmodule
