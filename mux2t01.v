
module mux2to1(y, i0, i1, sel, rst);
input i0, i1, sel, rst;
output y;
wire [4:0] w;
not g1 (w[0],rst); // w[0] is rst_bar;
not g2 (w[1], sel);
and g3 (w[2], i0, w[1]);
and g4 (w[3], i1, sel);
or g5 (w[4], w[2], w[3]);
and g6 (y,w[4],w[0]);
endmodule