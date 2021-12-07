
module mux8to1 (y,i,sel,rst);
/*
[3:0] input are given to mux4to1 m1
[7:4] inputs are given to mux4to1 m2
output of mux4to1 (w[1],w[2]) are given to mux2to1
which is anded with notted rst
reset is active high
*/

input [7:0] i;
input [2:0] sel;
input rst;
output y;
wire [3:0] w;
not (w[0], rst); // w[0] is rst_bar.
mux4to1 m1 (.y(w[1]), .i(i[3:0]), .sel(sel[1:0]), .rst(rst));
mux4to1 m2 (.y(w[2]), .i(i[7:4]), .sel(sel[1:0]), .rst(rst));
mux2to1 m3 (.y(w[3]), .i0(w[1]), .i1(w[2]), .sel(sel[2]), .rst(rst));
and (y, w[3], w[0]);
endmodule

