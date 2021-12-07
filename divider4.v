
module divider4(quot, rem, a, b, rst);
input [3:0] a, b;
input rst;
output [3:0] quot, rem;
/*
1.	divisor = 4 bits
	quotient = 4 bits
	remainder = 4 bits
	so, diviedend should be = 2x4-1 = 7 bits
	therefore we will pad 3 0's in front of 'a'.

2.	hereafter, fs means full_subtractor4

3. hereafter, m means mux2to1_4bits

4. if subtraction is possible, then borrow_out of fs will be 0
	and our quotient will notted of borrow_out i.e 1 and 3 lower bits
	of difference and next bit of 'a' ( say a[3] is prev so next will be a[2])
	in the order as written will be used for used for next subtraction.
	if subtraction is not possible, then borrow_out of fs will be 1
	and our quotient will be 0 and 3 bits of minued of this stage and next bit
	of 'a' will be used for next subtraction stage.
	
5.	subtractend for all fs will be = b (i.e b[3:0])
6. qout[i] = and of w[i] and rst_bar.
*/

wire [3:0] b_out, w;
wire rst_bar;
not n1 (rst_bar, rst);

/*
for 1st fs mineund = 000a[3]
difference will be = d1[3:0]
borrow_out will be = b_out[0]
*/

wire [3:0] d1 , w1;
full_subtractor4 fs1 (.diff(d1[3:0]), .bout(b_out[3]), .a({3'b000,a[3]}), 
	.b(b[3:0]), .bin(1'b0), .rst(rst));
	
not g1 (w[3], b_out[3]);
and g2 (quot[3],w[3],rst_bar);

mux2to1_4bits m1 (.y(w1[3:0]), .i0({2'b00,a[3:2]}), .i1({d1[2:0],a[2]}), 
	.sel(w[3]), .rst(rst));

/*
for 2nd fs mineund = w1[3:0]
difference will be = d2[3:0]
borrow_out will be = b_out[1]
*/

wire [3:0] d2 , w2;
full_subtractor4 fs2 (.diff(d2[3:0]), .bout(b_out[2]), .a(w1[3:0]), 
	.b(b[3:0]), .bin(1'b0), .rst(rst));
	
not g3 ( w[2], b_out[2]);
and g4 (quot[2], w[2],rst_bar);

mux2to1_4bits m2 (.y(w2[3:0]), .i0({w1[2:0],a[1]}), .i1({d2[2:0],a[1]}), 
	.sel(w[2]), .rst(rst));
	
/*
for 3rd fs mineund = w2[3:0]
difference will be = d3[3:0]
borrow_out will be = b_out[2]
*/

wire [3:0] d3 , w3;
full_subtractor4 fs3 (.diff(d3[3:0]), .bout(b_out[1]), .a(w2[3:0]), 
	.b(b[3:0]), .bin(1'b0), .rst(rst));
	
not g5 ( w[1], b_out[1]);
and g6 (quot[1],w[1],rst_bar);

mux2to1_4bits m3 (.y(w3[3:0]), .i0({w2[2:0],a[0]}), .i1({d3[2:0],a[0]}), 
	.sel(w[1]), .rst(rst));
	
/*
for 4th fs mineund = w2[3:0]
difference will be = d3[3:0]
borrow_out will be = b_out[2]
*/
wire [3:0] d4;
full_subtractor4 fs4 (.diff(d4[3:0]), .bout(b_out[0]), .a(w3[3:0]), 
	.b(b[3:0]), .bin(1'b0), .rst(rst));
	
not g7 (w[0], b_out[0]);
and g8 (quot[0], w[0], rst_bar);

mux2to1_4bits m4 (.y(rem[3:0]), .i0(w3[3:0]), .i1(d4[3:0]), 
	.sel(w[0]), .rst(rst));
endmodule
