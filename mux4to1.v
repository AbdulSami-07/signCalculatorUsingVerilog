
module mux4to1 (y, i, sel, rst);
input [3:0] i;
input [1:0] sel;
input rst;
output y;
wire [1:0] w;
mux2to1 m1 (.y(w[0]), .i0(i[0]), .i1(i[1]), .sel(sel[0]), .rst(rst));
mux2to1 m2 (.y(w[1]), .i0(i[2]), .i1(i[3]), .sel(sel[0]), .rst(rst));
mux2to1 m3 (.y(y), .i0(w[0]), .i1(w[1]), .sel(sel[1]), .rst(rst));
endmodule