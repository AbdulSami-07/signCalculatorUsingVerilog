
module full_subtractor(diff, bout, a, b, bin, rst);
input a, b, bin, rst;
output diff, bout;
wire d0;
wire [1:0] w;
half_subtractor h0 (.diff(d0), .bout(w[0]),
	.a(a), .b(b),  .rst(rst));
half_subtractor h1 (.diff(diff), .bout(w[1]),
	.a(d0), .b(bin), .rst(rst)); 
or o0 (bout, w[0], w[1]); // w0 is the bout
endmodule
