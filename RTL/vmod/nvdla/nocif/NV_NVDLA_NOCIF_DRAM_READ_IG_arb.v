// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_NOCIF_DRAM_READ_IG_arb.v
`include "simulate_x_tick.vh"
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_define.h
///////////////////////////////////////////////////
//
//#if ( NVDLA_PRIMARY_MEMIF_WIDTH  ==  512 )
//    #define LARGE_MEMBUS
//#endif
//#if ( NVDLA_PRIMARY_MEMIF_WIDTH  ==  64 )
//    #define SMALL_MEMBUS
//#endif
module NV_NVDLA_NOCIF_DRAM_READ_IG_arb (
   arb2spt_req_ready //|< i
   ,arb2spt_req_valid
   ,arb2spt_req_pd
   ,nvdla_core_clk
   ,nvdla_core_rstn
//:my $k=7;
//:my $i;
//:for ($i=0;$i<$k;$i++) {
//:print(",bpt2arb_req${i}_pd\n");
//:print(",bpt2arb_req${i}_valid\n");
//:print(",bpt2arb_req${i}_ready\n");
//:print(",client${i}2mcif_rd_wt\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
,bpt2arb_req0_pd
,bpt2arb_req0_valid
,bpt2arb_req0_ready
,client02mcif_rd_wt
,bpt2arb_req1_pd
,bpt2arb_req1_valid
,bpt2arb_req1_ready
,client12mcif_rd_wt
,bpt2arb_req2_pd
,bpt2arb_req2_valid
,bpt2arb_req2_ready
,client22mcif_rd_wt
,bpt2arb_req3_pd
,bpt2arb_req3_valid
,bpt2arb_req3_ready
,client32mcif_rd_wt
,bpt2arb_req4_pd
,bpt2arb_req4_valid
,bpt2arb_req4_ready
,client42mcif_rd_wt
,bpt2arb_req5_pd
,bpt2arb_req5_valid
,bpt2arb_req5_ready
,client52mcif_rd_wt
,bpt2arb_req6_pd
,bpt2arb_req6_valid
,bpt2arb_req6_ready
,client62mcif_rd_wt

//| eperl: generated_end (DO NOT EDIT ABOVE)
);
input nvdla_core_clk;
input nvdla_core_rstn;
input arb2spt_req_ready;
output arb2spt_req_valid;
output [32 +10:0] arb2spt_req_pd;
//:my $k=7;
//:my $i;
//:for ($i=0;$i<$k;$i++) {
//:print("input bpt2arb_req${i}_valid;\n");
//:print("output bpt2arb_req${i}_ready;\n");
//:print qq(
//:input [32 +10:0] bpt2arb_req${i}_pd;
//:);
//:print("input [7:0] client${i}2mcif_rd_wt;\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
input bpt2arb_req0_valid;
output bpt2arb_req0_ready;

input [32 +10:0] bpt2arb_req0_pd;
input [7:0] client02mcif_rd_wt;
input bpt2arb_req1_valid;
output bpt2arb_req1_ready;

input [32 +10:0] bpt2arb_req1_pd;
input [7:0] client12mcif_rd_wt;
input bpt2arb_req2_valid;
output bpt2arb_req2_ready;

input [32 +10:0] bpt2arb_req2_pd;
input [7:0] client22mcif_rd_wt;
input bpt2arb_req3_valid;
output bpt2arb_req3_ready;

input [32 +10:0] bpt2arb_req3_pd;
input [7:0] client32mcif_rd_wt;
input bpt2arb_req4_valid;
output bpt2arb_req4_ready;

input [32 +10:0] bpt2arb_req4_pd;
input [7:0] client42mcif_rd_wt;
input bpt2arb_req5_valid;
output bpt2arb_req5_ready;

input [32 +10:0] bpt2arb_req5_pd;
input [7:0] client52mcif_rd_wt;
input bpt2arb_req6_valid;
output bpt2arb_req6_ready;

input [32 +10:0] bpt2arb_req6_pd;
input [7:0] client62mcif_rd_wt;

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [32 +10:0] arb_pd;
wire [15:0] arb_gnt;
wire gnt_busy;
//:my $k=7;
//:my $i;
//:my $w=eval(32 +10);
//:for ($i=0;$i<$k;$i++) {
//:print("wire  src${i}_req;\n");
//:print("wire  src${i}_gnt;\n");
//:print("wire [7:0]  wt${i};\n");
//: print("wire [$w:0] arb_src${i}_pd;\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire  src0_req;
wire  src0_gnt;
wire [7:0]  wt0;
wire [42:0] arb_src0_pd;
wire  src1_req;
wire  src1_gnt;
wire [7:0]  wt1;
wire [42:0] arb_src1_pd;
wire  src2_req;
wire  src2_gnt;
wire [7:0]  wt2;
wire [42:0] arb_src2_pd;
wire  src3_req;
wire  src3_gnt;
wire [7:0]  wt3;
wire [42:0] arb_src3_pd;
wire  src4_req;
wire  src4_gnt;
wire [7:0]  wt4;
wire [42:0] arb_src4_pd;
wire  src5_req;
wire  src5_gnt;
wire [7:0]  wt5;
wire [42:0] arb_src5_pd;
wire  src6_req;
wire  src6_gnt;
wire [7:0]  wt6;
wire [42:0] arb_src6_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//
//:my $k=7;
//:my $i;
//:my $w=eval(32 +10);
//:for ($i=7;$i<16;$i++) {
//: print("wire [$w:0] arb_src${i}_pd;\n");
//: print("wire  src${i}_req;\n");
//: print("wire  src${i}_gnt;\n");
//:}
//:my $k=7;
//:my $i;
//:for ($i=0;$i<$k;$i++) {
//:my $wid = 32 +11;
//:print qq(
//:wire arb_src${i}_rdy, arb_src${i}_vld;
//:NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 pipe_p1_${i} (
//: .nvdla_core_clk(nvdla_core_clk)
//: ,.nvdla_core_rstn(nvdla_core_rstn)
//: ,.arb_src0_rdy(arb_src${i}_rdy)
//: ,.bpt2arb_req0_pd(bpt2arb_req${i}_pd)
//: ,.bpt2arb_req0_valid(bpt2arb_req${i}_valid)
//: ,.arb_src0_pd(arb_src${i}_pd)
//: ,.arb_src0_vld(arb_src${i}_vld)
//: ,.bpt2arb_req0_ready(bpt2arb_req${i}_ready)
//:);
//:);
//:print qq(
//: assign src${i}_req = arb_src${i}_vld;
//: assign arb_src${i}_rdy = src${i}_gnt;
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [42:0] arb_src7_pd;
wire  src7_req;
wire  src7_gnt;
wire [42:0] arb_src8_pd;
wire  src8_req;
wire  src8_gnt;
wire [42:0] arb_src9_pd;
wire  src9_req;
wire  src9_gnt;
wire [42:0] arb_src10_pd;
wire  src10_req;
wire  src10_gnt;
wire [42:0] arb_src11_pd;
wire  src11_req;
wire  src11_gnt;
wire [42:0] arb_src12_pd;
wire  src12_req;
wire  src12_gnt;
wire [42:0] arb_src13_pd;
wire  src13_req;
wire  src13_gnt;
wire [42:0] arb_src14_pd;
wire  src14_req;
wire  src14_gnt;
wire [42:0] arb_src15_pd;
wire  src15_req;
wire  src15_gnt;

wire arb_src0_rdy, arb_src0_vld;
NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 pipe_p1_0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.arb_src0_rdy(arb_src0_rdy)
,.bpt2arb_req0_pd(bpt2arb_req0_pd)
,.bpt2arb_req0_valid(bpt2arb_req0_valid)
,.arb_src0_pd(arb_src0_pd)
,.arb_src0_vld(arb_src0_vld)
,.bpt2arb_req0_ready(bpt2arb_req0_ready)
);

assign src0_req = arb_src0_vld;
assign arb_src0_rdy = src0_gnt;

wire arb_src1_rdy, arb_src1_vld;
NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 pipe_p1_1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.arb_src0_rdy(arb_src1_rdy)
,.bpt2arb_req0_pd(bpt2arb_req1_pd)
,.bpt2arb_req0_valid(bpt2arb_req1_valid)
,.arb_src0_pd(arb_src1_pd)
,.arb_src0_vld(arb_src1_vld)
,.bpt2arb_req0_ready(bpt2arb_req1_ready)
);

assign src1_req = arb_src1_vld;
assign arb_src1_rdy = src1_gnt;

wire arb_src2_rdy, arb_src2_vld;
NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 pipe_p1_2 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.arb_src0_rdy(arb_src2_rdy)
,.bpt2arb_req0_pd(bpt2arb_req2_pd)
,.bpt2arb_req0_valid(bpt2arb_req2_valid)
,.arb_src0_pd(arb_src2_pd)
,.arb_src0_vld(arb_src2_vld)
,.bpt2arb_req0_ready(bpt2arb_req2_ready)
);

assign src2_req = arb_src2_vld;
assign arb_src2_rdy = src2_gnt;

wire arb_src3_rdy, arb_src3_vld;
NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 pipe_p1_3 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.arb_src0_rdy(arb_src3_rdy)
,.bpt2arb_req0_pd(bpt2arb_req3_pd)
,.bpt2arb_req0_valid(bpt2arb_req3_valid)
,.arb_src0_pd(arb_src3_pd)
,.arb_src0_vld(arb_src3_vld)
,.bpt2arb_req0_ready(bpt2arb_req3_ready)
);

assign src3_req = arb_src3_vld;
assign arb_src3_rdy = src3_gnt;

wire arb_src4_rdy, arb_src4_vld;
NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 pipe_p1_4 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.arb_src0_rdy(arb_src4_rdy)
,.bpt2arb_req0_pd(bpt2arb_req4_pd)
,.bpt2arb_req0_valid(bpt2arb_req4_valid)
,.arb_src0_pd(arb_src4_pd)
,.arb_src0_vld(arb_src4_vld)
,.bpt2arb_req0_ready(bpt2arb_req4_ready)
);

assign src4_req = arb_src4_vld;
assign arb_src4_rdy = src4_gnt;

wire arb_src5_rdy, arb_src5_vld;
NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 pipe_p1_5 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.arb_src0_rdy(arb_src5_rdy)
,.bpt2arb_req0_pd(bpt2arb_req5_pd)
,.bpt2arb_req0_valid(bpt2arb_req5_valid)
,.arb_src0_pd(arb_src5_pd)
,.arb_src0_vld(arb_src5_vld)
,.bpt2arb_req0_ready(bpt2arb_req5_ready)
);

assign src5_req = arb_src5_vld;
assign arb_src5_rdy = src5_gnt;

wire arb_src6_rdy, arb_src6_vld;
NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 pipe_p1_6 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.arb_src0_rdy(arb_src6_rdy)
,.bpt2arb_req0_pd(bpt2arb_req6_pd)
,.bpt2arb_req0_valid(bpt2arb_req6_valid)
,.arb_src0_pd(arb_src6_pd)
,.arb_src0_vld(arb_src6_vld)
,.bpt2arb_req0_ready(bpt2arb_req6_ready)
);

assign src6_req = arb_src6_vld;
assign arb_src6_rdy = src6_gnt;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//&eperl::pipe("-is -wid 75 -do arb_src${i}_pd -vo arb_src${i}_vld -ri  bpt2arb_req${i}_ready -di bpt2arb_req${i}_pd -vi bpt2arb_req${i}_valid -ro arc_src${i}_rdy");
//:my $k=7;
//:my $i;
//:for($i=7;$i<16;$i++) {
//: print("assign src${i}_req = 1'b0;\n");
//: print("assign arb_src${i}_rdy = 1'b1;\n");
//: print("wire [7:0] wt${i} = 0;\n");
//:}
//:my $k=7;
//:my $i;
//:for ($i=0;$i<$k;$i++) {
//:print("assign wt${i} = client${i}2mcif_rd_wt;\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign src7_req = 1'b0;
assign arb_src7_rdy = 1'b1;
wire [7:0] wt7 = 0;
assign src8_req = 1'b0;
assign arb_src8_rdy = 1'b1;
wire [7:0] wt8 = 0;
assign src9_req = 1'b0;
assign arb_src9_rdy = 1'b1;
wire [7:0] wt9 = 0;
assign src10_req = 1'b0;
assign arb_src10_rdy = 1'b1;
wire [7:0] wt10 = 0;
assign src11_req = 1'b0;
assign arb_src11_rdy = 1'b1;
wire [7:0] wt11 = 0;
assign src12_req = 1'b0;
assign arb_src12_rdy = 1'b1;
wire [7:0] wt12 = 0;
assign src13_req = 1'b0;
assign arb_src13_rdy = 1'b1;
wire [7:0] wt13 = 0;
assign src14_req = 1'b0;
assign arb_src14_rdy = 1'b1;
wire [7:0] wt14 = 0;
assign src15_req = 1'b0;
assign arb_src15_rdy = 1'b1;
wire [7:0] wt15 = 0;
assign wt0 = client02mcif_rd_wt;
assign wt1 = client12mcif_rd_wt;
assign wt2 = client22mcif_rd_wt;
assign wt3 = client32mcif_rd_wt;
assign wt4 = client42mcif_rd_wt;
assign wt5 = client52mcif_rd_wt;
assign wt6 = client62mcif_rd_wt;

//| eperl: generated_end (DO NOT EDIT ABOVE)
read_ig_arb u_read_ig_arb (
   .req0 (src0_req) //|< w
  ,.req1 (src1_req) //|< w
  ,.req2 (src2_req) //|< w
  ,.req3 (src3_req) //|< w
  ,.req4 (src4_req) //|< w
  ,.req5 (src5_req) //|< w
  ,.req6 (src6_req) //|< w
  ,.req7 (src7_req) //|< w
  ,.req8 (src8_req) //|< w
  ,.req9 (src9_req) //|< w
  ,.req10 (src10_req) //|< w
  ,.req11 (src11_req) //|< w
  ,.req12 (src12_req) //|< w
  ,.req13 (src13_req) //|< w
  ,.req14 (src14_req) //|< w
  ,.req15 (src15_req) //|< w
  ,.wt0 (wt0[7:0]) //|< w
  ,.wt1 (wt1[7:0]) //|< w
  ,.wt2 (wt2[7:0]) //|< w
  ,.wt3 (wt3[7:0]) //|< w
  ,.wt4 (wt4[7:0]) //|< w
  ,.wt5 (wt5[7:0]) //|< w
  ,.wt6 (wt6[7:0]) //|< w
  ,.wt7 (wt7[7:0]) //|< w
  ,.wt8 (wt8[7:0]) //|< w
  ,.wt9 (wt9[7:0]) //|< w
  ,.wt10 (wt10[7:0]) //|< w
  ,.wt11 (wt11[7:0]) //|< w
  ,.wt12 (wt12[7:0]) //|< w
  ,.wt13 (wt13[7:0]) //|< w
  ,.wt14 (wt14[7:0]) //|< w
  ,.wt15 (wt15[7:0]) //|< w
  ,.gnt_busy (gnt_busy) //|< w
  ,.clk (nvdla_core_clk) //|< i
  ,.reset_ (nvdla_core_rstn) //|< i
  ,.gnt0 (src0_gnt) //|> w
  ,.gnt1 (src1_gnt) //|> w
  ,.gnt2 (src2_gnt) //|> w
  ,.gnt3 (src3_gnt) //|> w
  ,.gnt4 (src4_gnt) //|> w
  ,.gnt5 (src5_gnt) //|> w
  ,.gnt6 (src6_gnt) //|> w
  ,.gnt7 (src7_gnt) //|> w
  ,.gnt8 (src8_gnt) //|> w
  ,.gnt9 (src9_gnt) //|> w
  ,.gnt10 (src10_gnt) //|> w
  ,.gnt11 (src11_gnt) //|> w
  ,.gnt12 (src12_gnt) //|> w
  ,.gnt13 (src13_gnt) //|> w
  ,.gnt14 (src14_gnt) //|> w
  ,.gnt15 (src15_gnt) //|> w
  );
// MUX OUT
always @(
  src0_gnt
  or arb_src0_pd
  or src1_gnt
  or arb_src1_pd
  or src2_gnt
  or arb_src2_pd
  or src3_gnt
  or arb_src3_pd
  or src4_gnt
  or arb_src4_pd
  or src5_gnt
  or arb_src5_pd
  or src6_gnt
  or arb_src6_pd
  or src7_gnt
  or arb_src7_pd
  or src8_gnt
  or arb_src8_pd
  or src9_gnt
  or arb_src9_pd
  or src10_gnt
  or arb_src10_pd
  or src11_gnt
  or arb_src11_pd
  or src12_gnt
  or arb_src12_pd
  or src13_gnt
  or arb_src13_pd
  or src14_gnt
  or arb_src14_pd
  or src15_gnt
  or arb_src15_pd
  ) begin
//spyglass disable_block W171 W226
    case (1'b1 )
       src0_gnt: arb_pd = arb_src0_pd;
       src1_gnt: arb_pd = arb_src1_pd;
       src2_gnt: arb_pd = arb_src2_pd;
       src3_gnt: arb_pd = arb_src3_pd;
       src4_gnt: arb_pd = arb_src4_pd;
       src5_gnt: arb_pd = arb_src5_pd;
       src6_gnt: arb_pd = arb_src6_pd;
       src7_gnt: arb_pd = arb_src7_pd;
       src8_gnt: arb_pd = arb_src8_pd;
       src9_gnt: arb_pd = arb_src9_pd;
       src10_gnt: arb_pd = arb_src10_pd;
       src11_gnt: arb_pd = arb_src11_pd;
       src12_gnt: arb_pd = arb_src12_pd;
       src13_gnt: arb_pd = arb_src13_pd;
       src14_gnt: arb_pd = arb_src14_pd;
       src15_gnt: arb_pd = arb_src15_pd;
//VCS coverage off
    default : begin
                arb_pd[32 +10:0] = {32 +11{`x_or_0}};
              end
//VCS coverage on
    endcase
//spyglass enable_block W171 W226
end
assign arb_gnt = {src15_gnt, src14_gnt, src13_gnt, src12_gnt, src11_gnt, src10_gnt, src9_gnt, src8_gnt, src7_gnt, src6_gnt, src5_gnt, src4_gnt, src3_gnt, src2_gnt, src1_gnt, src0_gnt};
assign arb2spt_req_valid = |arb_gnt;
assign gnt_busy = !arb2spt_req_ready;
assign arb2spt_req_pd = arb_pd;
//==========================================
// OBS
//assign obs_bus_mcif_read_ig_arb_gnt_busy = gnt_busy;
endmodule
module NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,arb_src0_rdy
  ,bpt2arb_req0_pd
  ,bpt2arb_req0_valid
  ,arb_src0_pd
  ,arb_src0_vld
  ,bpt2arb_req0_ready
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input arb_src0_rdy;
input [32 +10:0] bpt2arb_req0_pd;
input bpt2arb_req0_valid;
output [32 +10:0] arb_src0_pd;
output arb_src0_vld;
output bpt2arb_req0_ready;
reg [32 +10:0] arb_src0_pd;
reg arb_src0_vld;
reg bpt2arb_req0_ready;
reg [32 +10:0] p1_pipe_data;
reg p1_pipe_ready;
reg p1_pipe_ready_bc;
reg [32 +10:0] p1_pipe_skid_data;
reg p1_pipe_skid_ready;
reg p1_pipe_skid_valid;
reg p1_pipe_valid;
reg p1_skid_catch;
reg [32 +10:0] p1_skid_data;
reg p1_skid_ready;
reg p1_skid_ready_flop;
reg p1_skid_valid;
//## pipe (1) valid-ready-bubble-collapse
always @(
  p1_pipe_ready
  or p1_pipe_valid
  ) begin
  p1_pipe_ready_bc = p1_pipe_ready || !p1_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p1_pipe_valid <= 1'b0;
  end else begin
  p1_pipe_valid <= (p1_pipe_ready_bc)? bpt2arb_req0_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p1_pipe_data <= (p1_pipe_ready_bc && bpt2arb_req0_valid)? bpt2arb_req0_pd[32 +10:0] : p1_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p1_pipe_ready_bc
  ) begin
  bpt2arb_req0_ready = p1_pipe_ready_bc;
end
//## pipe (1) skid buffer
always @(
  p1_pipe_valid
  or p1_skid_ready_flop
  or p1_pipe_skid_ready
  or p1_skid_valid
  ) begin
  p1_skid_catch = p1_pipe_valid && p1_skid_ready_flop && !p1_pipe_skid_ready;
  p1_skid_ready = (p1_skid_valid)? p1_pipe_skid_ready : !p1_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p1_skid_valid <= 1'b0;
    p1_skid_ready_flop <= 1'b1;
    p1_pipe_ready <= 1'b1;
  end else begin
  p1_skid_valid <= (p1_skid_valid)? !p1_pipe_skid_ready : p1_skid_catch;
  p1_skid_ready_flop <= p1_skid_ready;
  p1_pipe_ready <= p1_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p1_skid_data <= (p1_skid_catch)? p1_pipe_data : p1_skid_data;
// VCS sop_coverage_off end
end
always @(
  p1_skid_ready_flop
  or p1_pipe_valid
  or p1_skid_valid
  or p1_pipe_data
  or p1_skid_data
  ) begin
  p1_pipe_skid_valid = (p1_skid_ready_flop)? p1_pipe_valid : p1_skid_valid;
// VCS sop_coverage_off start
  p1_pipe_skid_data = (p1_skid_ready_flop)? p1_pipe_data : p1_skid_data;
// VCS sop_coverage_off end
end
//## pipe (1) output
always @(
  p1_pipe_skid_valid
  or arb_src0_rdy
  or p1_pipe_skid_data
  ) begin
  arb_src0_vld = p1_pipe_skid_valid;
  p1_pipe_skid_ready = arb_src0_rdy;
  arb_src0_pd = p1_pipe_skid_data;
end
//## pipe (1) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p1_assert_clk = nvdla_core_clk;
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_1x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (arb_src0_vld^arb_src0_rdy^bpt2arb_req0_valid^bpt2arb_req0_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
// VCS coverage off
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_2x (nvdla_core_clk, `ASSERT_RESET, (bpt2arb_req0_valid && !bpt2arb_req0_ready), (bpt2arb_req0_valid), (bpt2arb_req0_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`endif
endmodule // NV_NVDLA_NOCIF_DRAM_READ_IG_ARB_pipe_p1
