
module full_adder4 (sum,cout,a,b,cin,rst);
input [3:0] a, b;
input cin, rst;
output [3:0] sum;
output cout;
wire [2:0] c;
full_adder fa0 (.sum(sum[0]), .cout(c[0]), .a(a[0]), .b(b[0]), .cin(cin), .rst(rst));
full_adder fa1 (.sum(sum[1]), .cout(c[1]), .a(a[1]), .b(b[1]), .cin(c[0]), .rst(rst));
full_adder fa2 (.sum(sum[2]), .cout(c[2]), .a(a[2]), .b(b[2]), .cin(c[1]), .rst(rst));
full_adder fa3 (.sum(sum[3]), .cout(cout), .a(a[3]), .b(b[3]), .cin(c[2]), .rst(rst));
endmodule