
module full_subtractor4(diff, bout, a, b, bin, rst);
input [3:0] a, b;
input bin, rst;
output [3:0] diff;
output bout;
wire [2:0] w;
full_subtractor fs0 (.diff(diff[0]), .bout(w[0]),
	.a(a[0]), .b(b[0]), .bin(bin), .rst(rst));
full_subtractor fs1 (.diff(diff[1]), .bout(w[1]),
	.a(a[1]), .b(b[1]), .bin(w[0]), .rst(rst));
full_subtractor fs2 (.diff(diff[2]), .bout(w[2]),
	.a(a[2]), .b(b[2]), .bin(w[1]), .rst(rst));
full_subtractor fs3 (.diff(diff[3]), .bout(bout),
	.a(a[3]), .b(b[3]), .bin(w[2]), .rst(rst));
endmodule