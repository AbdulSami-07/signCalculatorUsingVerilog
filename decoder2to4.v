
module decoder2to4 (d0,d1,d2,d3,x,y,rst);
input x, y, rst;
output d0,d1,d2,d3;
/*
1. for input x is MSB and y is LSB.
2. for output d3 is MSB and d0 is LSB.
3. 00 -> d0 is 1
	01 -> d1 is 1
	10 -> d2 is 1
	11 -> d3 is 1
*/
wire rst_bar,x_bar,y_bar;
not g1 (rst_bar,rst);
not g2 (x_bar,x);
not g3 (y_bar,y);
and g4 (d0, x_bar, y_bar, rst_bar);
and g5 (d1, x_bar, y, rst_bar);
and g6 (d2, x, y_bar, rst_bar);
and g7 (d3, x, y, rst_bar);
endmodule