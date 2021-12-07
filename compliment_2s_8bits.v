
module compliment_2s_8bits(y,i,rst);
input [7:0] i;
input rst;
output [7:0] y;

wire [7:0] w;
// taking 1s compliment of i/p i.
not g1 (w[0],i[0]), g2 (w[1],i[1]), g3 (w[2],i[2]), g4 (w[3],i[3]), 
	 g5 (w[4],i[4]), g6 (w[5],i[5]), g7 (w[6],i[6]), g8 (w[7],i[7]);
	 
// adding 000_000_01 to 1s compliment of i/p i.
wire [7:0] c;
half_adder ha1 (.sum(y[0]), .cout(c[0]), .a(w[0]), .b(1'b1), .rst(rst));
half_adder ha2 (.sum(y[1]), .cout(c[1]), .a(w[1]), .b(c[0]), .rst(rst));
half_adder ha3 (.sum(y[2]), .cout(c[2]), .a(w[2]), .b(c[1]), .rst(rst));
half_adder ha4 (.sum(y[3]), .cout(c[3]), .a(w[3]), .b(c[2]), .rst(rst));
half_adder ha5 (.sum(y[4]), .cout(c[4]), .a(w[4]), .b(c[3]), .rst(rst));
half_adder ha6 (.sum(y[5]), .cout(c[5]), .a(w[5]), .b(c[4]), .rst(rst));
half_adder ha7 (.sum(y[6]), .cout(c[6]), .a(w[6]), .b(c[5]), .rst(rst));
half_adder ha8 (.sum(y[7]), .cout(c[7]), .a(w[7]), .b(c[6]), .rst(rst));
endmodule