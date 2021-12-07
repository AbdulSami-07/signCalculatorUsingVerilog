

module signed_calculator(y,sign,a,b,s,m,rst);
input [3:0] a, b;
input [1:0] s, m;
input rst;
output [7:0] y;
output sign;
/*
1. There are 4 block addition, subtraction, multiplication and division.
2.	m[1]m[0] = 00 -> +
	m[1]m[0] = 01 -> -
	m[1]m[0] = 10 -> x
	m[1]m[0] = 11 -> /
3. s[0] = 0 -> a = + 
	s[0] = 0 -> a = -
	s[1] = 0 -> b = +
	s[1] = 1 -> b = -
4. hereafter, mux2to1_8bits = m8
5. hereafter, mux2to1_4bits = m4
*/

/*
decoder block
*/
wire [3:0] d;
decoder2to4 dcd (.d0(d[0]), .d1(d[1]), .d2(d[2]), .d3(d[3]),
	.x(m[1]), .y(m[0]), .rst(1'b0));
wire [3:0] d_bar;
not g1 (d_bar[0],d[0]), g2 (d_bar[1],d[1]), g3 (d_bar[2],d[2]), g4 (d_bar[3],d[3]);

/*
Addition block
1. 4bits i/p(s) a and b are converted into 8bits and in their 8bits compliment.
2. Depending upon signs of s[0] and s[1] uncomplimented or complimented a and b are
	seleted using 8bits mux2to1 and given to the full_adder8.
3. sign of resulted is taken from MSB of sum.
4. y1 and sign1 are the o/p and sign bit of full_adder8
*/
wire [7:0] w1; // w1 is 2s compliment of 0(s) paded a.
wire [7:0] w2; // w2 is 2s compliment of 0(s) paded b.
compliment_2s_8bits cmpt1 (.y(w1[7:0]), .i({4'b0000,a[3:0]}), .rst(1'b0));
compliment_2s_8bits cmpt2 (.y(w2[7:0]), .i({4'b0000,b[3:0]}), .rst(1'b0));

wire [7:0] t1;// t1 gives 'a' or 'a_bar depending upon s[0]
mux2to1_8bits m8_1 (.y(t1[7:0]), .i0({4'b0000,a[3:0]}), .i1(w1[7:0]), .sel(s[0]), .rst(1'b0));
wire [7:0] t2;// t1 gives 'b' or 'b_bar depending upon s[1]
mux2to1_8bits m8_2 (.y(t2[7:0]), .i0({4'b0000,b[3:0]}), .i1(w2[7:0]), .sel(s[1]), .rst(1'b0));

wire [7:0] y1; // y1 is the o/p of full
full_adder8 fa1 (.sum(y1[7:0]), .cout(gnd), .a(t1[7:0]), .b(t2[7:0]),
	.cin(1'b0), .rst(d_bar[0]));
wire sign1;
buf g5 (sign1,y1[7]);

/*
subtracttion block
1. 4bits i/p(s) a and b are converted into 8bits and in their 8bits compliment.
2. Depending upon signs of s[0] and s[1] uncomplimented or complimented a and b are
	seleted using 8bits mux2to1 and given to the subtractor_adder8.
3. we will use o/p of m8_1 and m8_2 i.e t1 and t2.
4. sign of resulted is taken from MSB of diff.
5. yw and sign1 are the o/p and sign bit of full_subtractor8
*/

wire [7:0] y2;
full_subtractor8 fs1 (.diff(y2[7:0]), .bout(gnd), .a(t1[7:0]), .b(t2[7:0]),
	.bin(1'b0), .rst(d_bar[1]));
wire sign2;
buf g6 (sign2,y2[7]);

/*
multiplication block
1. i/p(s) to this block is of 4bits and so will use a[3:0] and b[3:0] as i/p(s).
2. o/p is y3 of 8bits and sign bit is sign3 = xnor of s[0] and s[1].
3. if sign3 = 1 , then y3[7:0] = 2's compliment of prod (i.e w3[7:0])
*/

wire [7:0] w3,w4,y3;
multiplier4 mlt1 (.prod(w3[7:0]), .a(a[3:0]), .b(b[3:0]), .rst(d_bar[2]));
wire sign3;
xor g7 (sign3,s[0],s[1]);
compliment_2s_8bits cmpt3 (.y(w4[7:0]), .i(w3[7:0]), .rst(1'b0));
mux2to1_8bits m8_3 (.y(y3[7:0]), .i0(w3[7:0]), .i1(w4[7:0]), .sel(sign3),
	.rst(1'b0));

/*
division block
1. i/p(s) to this block is of 4bits and so will use a[3:0] and b[3:0] as i/p(s).
2. o/p is y4 = {quotient of 4 bits , rem of 4 bits} of 8bits
	and sign bit is sign3 = xnor of s[0] and s[1].
3. if sign3 = 1 , then y4[7:4] = 2's compliment of quot (i.e w5[7:4])
*/
wire [7:0] w5, w6, y4;
wire [3:0] discard;
divider4 div1 (.quot(w5[7:4]), .rem(w5[3:0]), .a(a[3:0]), .b(b[3:0]),
	.rst(d_bar[3]));
compliment_2s_8bits cmpt4 (.y({discard[3:0],w6[7:4]}), .i({4'b0000,w5[7:4]}),
	.rst(1'b0));
mux2to1_8bits m8_4 (.y(y4[7:0]), .i0(w5[7:0]), .i1({w6[7:4],w5[3:0]}),
	.sel(sign3), .rst(1'b0));

/*
1.	Taking oring the o/p(s) y1,y2,y3 and y4.
2. Hereafter or4 = or4_8bits.
3.  sign_t =  or of sign1, sign2, and sign3.
*/

or4_8bits or4_1 (.y(y[7:0]), .i0(y1[7:0]), .i1(y2[7:0]), .i2(y3[7:0]),
	.i3(y4[7:0]), .rst(rst));
	
wire rst_bar;
not g8 (rst_bar, rst);
or g9 (sign_t, sign1, sign2, sign3);
and g10 (sign, sign_t, rst_bar);

endmodule