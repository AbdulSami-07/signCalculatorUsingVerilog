`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:32:35 11/28/2021 
// Design Name: 
// Module Name:    mux2to1_8bits 
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
module  mux2to1_8bits (y,i0,i1,sel,rst);
input [7:0] i0, i1;
input sel, rst;
output [7:0] y;

// hereafter m4 means mux2to1_4bits

mux2to1_4bits m4_1 (.y(y[3:0]), .i0(i0[3:0]), .i1(i1[3:0]), .sel(sel),
	.rst(rst));
mux2to1_4bits m4_2 (.y(y[7:4]), .i0(i0[7:4]), .i1(i1[7:4]), .sel(sel),
	.rst(rst));
	
endmodule