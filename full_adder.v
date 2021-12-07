
module full_adder(sum,cout,a,b,cin,rst);
input a, b, cin, rst;
output sum, cout;
wire [3:0] w;
half_adder h1 (w[0], w[1], a, b, rst);
half_adder h2 (sum, w[3], w[0], cin, rst);
or o0 (cout, w[3], w[1]);
endmodule