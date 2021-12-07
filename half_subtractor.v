
module half_subtractor(diff, bout, a, b, rst);
input a, b, rst;
output diff , bout;
wire [3:0] w;
xor x0 (w[0], a, b); // w[0] is diff
not n0 (w[1],a);
and a0 (w[2], w[1], b); // w[2] is bout
not n1 (w[3], rst); // w[3] is rst_bar
and a2 (diff, w[0], w[3]);
and a3 (bout, w[2], w[3]);
endmodule