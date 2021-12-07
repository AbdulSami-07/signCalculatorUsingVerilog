`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:39:03 11/28/2021 
// Design Name: 
// Module Name:    or4_8bits 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module or4_8bits (y, i0, i1, i2, i3, rst);
input [7:0] i0, i1, i2, i3;
input rst;
output [7:0] y;

/*
1.	y[i] = i0[i] + i1[1] + i2[i] + i3[i], where 0 <= i <= 7.
2. y[i] is anded with rst_bar.
*/

wire [7:0] w;
wire rst_bar;
or g1 (w[0], i0[0], i1[0], i2[0], i3[0]);
or g2 (w[1], i0[1], i1[1], i2[1], i3[1]);
or g3 (w[2], i0[2], i1[2], i2[2], i3[2]);
or g4 (w[3], i0[3], i1[3], i2[3], i3[3]);
or g5 (w[4], i0[4], i1[4], i2[4], i3[4]);
or g6 (w[5], i0[5], i1[5], i2[5], i3[5]);
or g7 (w[6], i0[6], i1[6], i2[6], i3[6]);
or g8 (w[7], i0[7], i1[7], i2[7], i3[7]);

not g9 (rst_bar, rst);

and g10 (y[0],w[0],rst_bar);
and g11 (y[1],w[1],rst_bar);
and g12 (y[2],w[2],rst_bar);
and g13 (y[3],w[3],rst_bar);
and g14 (y[4],w[4],rst_bar);
and g15 (y[5],w[5],rst_bar);
and g16 (y[6],w[6],rst_bar);
and g17 (y[7],w[7],rst_bar);

endmodule
