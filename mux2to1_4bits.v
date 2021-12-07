
module mux2to1_4bits(y,i0,i1,sel,rst);
input [3:0] i0, i1;
input sel, rst;
output [3:0] y;
/*
it is takes 2 4bits inputs and depending upon control line sel
it gives 4bits o/p.
*/
mux2to1 m1 (.y(y[0]), .i0(i0[0]), .i1(i1[0]), .sel(sel), .rst(rst));
mux2to1 m2 (.y(y[1]), .i0(i0[1]), .i1(i1[1]), .sel(sel), .rst(rst));
mux2to1 m3 (.y(y[2]), .i0(i0[2]), .i1(i1[2]), .sel(sel), .rst(rst));
mux2to1 m4 (.y(y[3]), .i0(i0[3]), .i1(i1[3]), .sel(sel), .rst(rst));
endmodule