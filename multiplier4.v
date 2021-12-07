
module multiplier4 (prod, a , b, rst);
input [3:0] a, b;
input rst;
output [7:0] prod;

/*
Multiplying b0 with all bits of a
*/
wire [3:0] p;
and (p[0], a[0],b[0]), (p[1], a[1],b[0]),
	(p[2], a[2],b[0]), (p[3], a[3],b[0]);
	
/*
Multiplying b[2] with all bits of a
*/
wire [3:0] q;
and (q[0], a[0],b[1]), (q[1], a[1],b[1]),
	(q[2], a[2],b[1]), (q[3], a[3],b[1]);
	
/*
Multiplying b2 with all bits of a
*/
wire [3:0] r;
and (r[0], a[0],b[2]), (r[1], a[1],b[2]),
	(r[2], a[2],b[2]), (r[3], a[3],b[2]);

/*
Multiplying b2 with all bits of a
*/
wire [3:0] s;
and (s[0], a[0],b[3]), (s[1], a[1],b[3]),
	(s[2], a[2],b[3]), (s[3], a[3],b[3]);
	
// p[0] is anded rst_bar and is connected to prod[0]
wire rst_bar;
not g1 (rst_bar, rst);
and g2 (prod[0],p[0],rst_bar);

// {'0',p[3:1]} and q[3:0] are added using full_adder4 giving o/p {t1[2:0],prod[1]}.
wire [2:0] t1;
wire c1; // cout of fa1 is connected c1
full_adder4 fa1 (.sum({t1[2:0],prod[1]}), .cout(c1), .a({1'b0,p[3:1]}), .b(q[3:0]), .cin(1'b0), .rst(rst));

// {c1,r[3:1]} and r[3:0] are added using full_adder4 giving o/p {t2[2:0],prod[2]}.
wire [2:0] t2;
wire c2;
full_adder4 fa2 (.sum({t2[2:0],prod[2]}), .cout(c2), .a({c1,t1[2:0]}), .b(r[3:0]), .cin(1'b0), .rst(rst));
/*
{c2,t2[2:0]} and s[3:0] are added using full_adder4 giving o/p prod[6:3]
and carry out  of full_adder4 gives prod[7].
*/
full_adder4 fa3 (.sum(prod[6:3]), .cout(prod[7]), .a({c2,t2[2:0]}), .b(s[3:0]), .cin(1'b0), .rst(rst));
endmodule
