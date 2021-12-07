
module ha (s,c,a,b);
input [1:0] a,b;
output [1:0] s;
output c;
wire [1:0] t;
xor x0 (s[0],a[0],b[0]);
and a0 (t[0],a[0],b[0]);
xor x1 (s[1],a[1],b[1],t[0]);
and a1 (t[1],a[1],b[1]);
or o0 (c,t[0],t[1]);

endmodule