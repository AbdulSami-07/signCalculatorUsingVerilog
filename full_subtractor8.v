
module full_subtractor8(diff,bout,a,b,bin,rst);
input [7:0] a,b;
input bin, rst;
output [7:0] diff;
output bout;
wire w;
full_subtractor4 fs0 (.diff(diff[3:0]),.bout(w), .a(a[3:0]), .b(b[3:0]),
	.bin(bin), .rst(rst));
full_subtractor4 fs1 (.diff(diff[7:4]), .bout(bout), .a(a[7:4]), .b(b[7:4]),
	.bin(w), .rst(rst));
endmodule