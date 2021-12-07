
module mux2to1 (y, i0, i1, sel, rst);
input i0, i1, sel, rst;
output y;
wire [3:0] w;
not g0 (w[0],rst); // w[0] is rst_bar;
not g1 (w[1],sel);
and g2 (w[2],i0,w[1]);
and g3 (w[3],i1,sel);
or g4 (y,w[2],w[3],w[0]);