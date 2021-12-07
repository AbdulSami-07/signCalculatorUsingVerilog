
module  half_adder(sum, cout, a, b, rst);
input a, b, rst;
output sum, cout;
wire [2:0] w;
xor x0(w[0],a,b);
and a0 (w[1],a,b);
not n0 (w[2],rst);
and a1 (sum, w[0], w[2]);
and a2 (cout, w[1], w[2]);
endmodule