module nv_ram_rwsp_4x128 (
  clk,
  ra,
  re,
  ore,
  dout,
  wa,
  we,
  di,
  pwrbus_ram_pd
);
parameter FORCE_CONTENTION_ASSERTION_RESET_ACTIVE=1'b0;
// port list
input clk;
input [1:0] ra;
input re;
input ore;
output [127:0] dout;
input [1:0] wa;
input we;
input [127:0] di;
input [31:0] pwrbus_ram_pd;
//reg and wire list
reg [1:0] ra_d;
wire [127:0] dout;
reg [127:0] M [3:0];
always @( posedge clk ) begin
    if (we)
       M[wa] <= di;
end
always @( posedge clk ) begin
    if (re)
       ra_d <= ra;
end
wire [127:0] dout_ram = M[ra_d];
reg [127:0] dout_r;
always @( posedge clk ) begin
   if (ore)
       dout_r <= dout_ram;
end
assign dout = dout_r;
endmodule
