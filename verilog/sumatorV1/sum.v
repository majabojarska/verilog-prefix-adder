module sum(
    input [5:0] x,
    input [5:0] y,
    inout [5:0] g,
    inout [5:0] p,
    inout [5:0] h,
    output [6:0] s
);

genvar i;
for (i=0; i<6; i=i+1) begin
    assign g[i] = x[i] & y[i];
    assign p[i] = x[i] | y[i];
    assign h[i] = x[i] ^ y[i];
end

for (i=1; i<6; i=i+2) begin
    assign g[i] = g[i] | (p[i] & g[i-1]);
    assign p[i] = p[i] & p[i-1];
end

assign g[2] = g[2] | (p[2] & g[2-1]);
assign p[2] = p[2] & p[2-1];
assign g[3] = g[3] | (p[3] & g[3-1]);
assign p[3] = p[3] & p[3-1];

assign g[4] = g[4] | (p[4] & g[4-1]);
assign p[4] = p[4] & p[4-1];
assign g[5] = g[5] | (p[5] & g[5-1]);
assign p[5] = p[5] & p[5-1];

assign s[0] = h[0];
for (i=1; i<6; i=i+1) begin
    assign s[i] = g[i-1] ^ h[i];
end 
assign s[6] = g[6-1];


endmodule