
module full_adder8(sum, cout, a, b, cin, rst);
input [7:0] a, b;
input cin, rst;
output [7:0] sum;
output cout;
wire c0;
full_adder4 fa0 (.sum(sum[3:0]), .cout(c0), .a(a[3:0]), .b(b[3:0]), .cin(cin), .rst(rst));
full_adder4 fa1 (.sum(sum[7:4]), .cout(cout), .a(a[7:4]), .b(b[7:4]), .cin(c0), .rst(rst));
endmodule