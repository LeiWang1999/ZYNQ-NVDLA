// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_NOCIF_DRAM_READ_eg.v
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
module NV_NVDLA_NOCIF_DRAM_READ_eg (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print(",cq_rd${i}_pd\n");
//:print(",cq_rd${i}_pvld\n");
//:print(",cq_rd${i}_prdy\n");
//:print(",mcif2client${i}_rd_rsp_ready\n");
//:print(",mcif2client${i}_rd_rsp_pd\n");
//:print(",mcif2client${i}_rd_rsp_valid\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
,cq_rd0_pd
,cq_rd0_pvld
,cq_rd0_prdy
,mcif2client0_rd_rsp_ready
,mcif2client0_rd_rsp_pd
,mcif2client0_rd_rsp_valid
,cq_rd1_pd
,cq_rd1_pvld
,cq_rd1_prdy
,mcif2client1_rd_rsp_ready
,mcif2client1_rd_rsp_pd
,mcif2client1_rd_rsp_valid
,cq_rd2_pd
,cq_rd2_pvld
,cq_rd2_prdy
,mcif2client2_rd_rsp_ready
,mcif2client2_rd_rsp_pd
,mcif2client2_rd_rsp_valid
,cq_rd3_pd
,cq_rd3_pvld
,cq_rd3_prdy
,mcif2client3_rd_rsp_ready
,mcif2client3_rd_rsp_pd
,mcif2client3_rd_rsp_valid
,cq_rd4_pd
,cq_rd4_pvld
,cq_rd4_prdy
,mcif2client4_rd_rsp_ready
,mcif2client4_rd_rsp_pd
,mcif2client4_rd_rsp_valid
,cq_rd5_pd
,cq_rd5_pvld
,cq_rd5_prdy
,mcif2client5_rd_rsp_ready
,mcif2client5_rd_rsp_pd
,mcif2client5_rd_rsp_valid
,cq_rd6_pd
,cq_rd6_pvld
,cq_rd6_prdy
,mcif2client6_rd_rsp_ready
,mcif2client6_rd_rsp_pd
,mcif2client6_rd_rsp_valid

//| eperl: generated_end (DO NOT EDIT ABOVE)
   ,noc2mcif_axi_r_rdata //|< i
  ,noc2mcif_axi_r_rid //|< i
  ,noc2mcif_axi_r_rlast //|< i
  ,noc2mcif_axi_r_rvalid //|< i
  ,pwrbus_ram_pd //|< i
  ,eg2ig_axi_vld //|> o
  ,noc2mcif_axi_r_rready //|> o
);
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print("output mcif2client${i}_rd_rsp_valid;\n");
//:print("input mcif2client${i}_rd_rsp_ready;\n");
//:print qq(
//:output [64 +(( 64 )/8/8)-1:0] mcif2client${i}_rd_rsp_pd;
//:);
//:print("input  cq_rd${i}_pvld;\n");
//:print("output  cq_rd${i}_prdy;\n");
//:print("input [6:0] cq_rd${i}_pd;\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
output mcif2client0_rd_rsp_valid;
input mcif2client0_rd_rsp_ready;

output [64 +(( 64 )/8/8)-1:0] mcif2client0_rd_rsp_pd;
input  cq_rd0_pvld;
output  cq_rd0_prdy;
input [6:0] cq_rd0_pd;
output mcif2client1_rd_rsp_valid;
input mcif2client1_rd_rsp_ready;

output [64 +(( 64 )/8/8)-1:0] mcif2client1_rd_rsp_pd;
input  cq_rd1_pvld;
output  cq_rd1_prdy;
input [6:0] cq_rd1_pd;
output mcif2client2_rd_rsp_valid;
input mcif2client2_rd_rsp_ready;

output [64 +(( 64 )/8/8)-1:0] mcif2client2_rd_rsp_pd;
input  cq_rd2_pvld;
output  cq_rd2_prdy;
input [6:0] cq_rd2_pd;
output mcif2client3_rd_rsp_valid;
input mcif2client3_rd_rsp_ready;

output [64 +(( 64 )/8/8)-1:0] mcif2client3_rd_rsp_pd;
input  cq_rd3_pvld;
output  cq_rd3_prdy;
input [6:0] cq_rd3_pd;
output mcif2client4_rd_rsp_valid;
input mcif2client4_rd_rsp_ready;

output [64 +(( 64 )/8/8)-1:0] mcif2client4_rd_rsp_pd;
input  cq_rd4_pvld;
output  cq_rd4_prdy;
input [6:0] cq_rd4_pd;
output mcif2client5_rd_rsp_valid;
input mcif2client5_rd_rsp_ready;

output [64 +(( 64 )/8/8)-1:0] mcif2client5_rd_rsp_pd;
input  cq_rd5_pvld;
output  cq_rd5_prdy;
input [6:0] cq_rd5_pd;
output mcif2client6_rd_rsp_valid;
input mcif2client6_rd_rsp_ready;

output [64 +(( 64 )/8/8)-1:0] mcif2client6_rd_rsp_pd;
input  cq_rd6_pvld;
output  cq_rd6_prdy;
input [6:0] cq_rd6_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input nvdla_core_clk;
input nvdla_core_rstn;
input noc2mcif_axi_r_rvalid; /* data valid */
output noc2mcif_axi_r_rready; /* data return handshake */
input [7:0] noc2mcif_axi_r_rid;
input noc2mcif_axi_r_rlast;
input [64 -1:0] noc2mcif_axi_r_rdata;
input [31:0] pwrbus_ram_pd;
output eg2ig_axi_vld;
reg [1:0] arb_cnt;
reg [6:0] arb_cq_pd;
reg [64 -1:0] arb_data;
reg [1:0] arb_wen;
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print("reg [1:0] ctt${i}_cnt;\n");
//:print("reg [6:0] ctt${i}_cq_pd;\n");
//:print("reg  ctt${i}_vld;\n");
//:print("wire ctt${i}_accept;\n");
//:print("wire ctt${i}_last_beat;\n");
//:print("wire ctt${i}_rdy;\n");
//:print qq(
//:wire [64 -1:0] dma${i}_data;
//:);
//:print qq(
//:wire [64/2-1:0] dma${i}_data0;
//:);
//:print qq(
//:wire [64/2-1:0] dma${i}_data1;
//:);
//:print("wire dma${i}_is_last_odd;\n");
//:print("wire dma${i}_last_odd;\n");
//:print("wire [1:0] dma${i}_mask;\n");
//:print qq(
//:wire [64/2-1:0] dma${i}_mdata0;
//:);
//:print qq(
//:wire [64/2-1:0] dma${i}_mdata1;
//:);
//:print qq(
//:wire [64 +(( 64 )/8/8)-1:0] dma${i}_pd;
//:);
//:print("wire dma${i}_rdy;\n");
//:print("wire dma${i}_vld;\n");
//:print("wire mon_dma${i}_lodd;\n");
//:print qq(wire [64/2:0] ro${i}_rd0_pd;\n);
//:print qq(wire [64/2:0] ro${i}_rd1_pd;\n);
//:print("wire ro${i}_rd0_prdy;\n");
//:print("wire ro${i}_rd0_pvld;\n");
//:print("wire ro${i}_wr_rdy;\n");
//:print("wire ro${i}_wr0_prdy;\n");
//:print("wire ro${i}_wr1_prdy;\n");
//:print qq(wire [64 -1:0] rq${i}_rd_pd;\n);
//:print("wire  rq${i}_rd_prdy;\n");
//:print("wire  rq${i}_rd_pvld;\n");
//:print("wire src${i}_gnt;\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [1:0] ctt0_cnt;
reg [6:0] ctt0_cq_pd;
reg  ctt0_vld;
wire ctt0_accept;
wire ctt0_last_beat;
wire ctt0_rdy;

wire [64 -1:0] dma0_data;

wire [64/2-1:0] dma0_data0;

wire [64/2-1:0] dma0_data1;
wire dma0_is_last_odd;
wire dma0_last_odd;
wire [1:0] dma0_mask;

wire [64/2-1:0] dma0_mdata0;

wire [64/2-1:0] dma0_mdata1;

wire [64 +(( 64 )/8/8)-1:0] dma0_pd;
wire dma0_rdy;
wire dma0_vld;
wire mon_dma0_lodd;
wire [64/2:0] ro0_rd0_pd;
wire [64/2:0] ro0_rd1_pd;
wire ro0_rd0_prdy;
wire ro0_rd0_pvld;
wire ro0_wr_rdy;
wire ro0_wr0_prdy;
wire ro0_wr1_prdy;
wire [64 -1:0] rq0_rd_pd;
wire  rq0_rd_prdy;
wire  rq0_rd_pvld;
wire src0_gnt;
reg [1:0] ctt1_cnt;
reg [6:0] ctt1_cq_pd;
reg  ctt1_vld;
wire ctt1_accept;
wire ctt1_last_beat;
wire ctt1_rdy;

wire [64 -1:0] dma1_data;

wire [64/2-1:0] dma1_data0;

wire [64/2-1:0] dma1_data1;
wire dma1_is_last_odd;
wire dma1_last_odd;
wire [1:0] dma1_mask;

wire [64/2-1:0] dma1_mdata0;

wire [64/2-1:0] dma1_mdata1;

wire [64 +(( 64 )/8/8)-1:0] dma1_pd;
wire dma1_rdy;
wire dma1_vld;
wire mon_dma1_lodd;
wire [64/2:0] ro1_rd0_pd;
wire [64/2:0] ro1_rd1_pd;
wire ro1_rd0_prdy;
wire ro1_rd0_pvld;
wire ro1_wr_rdy;
wire ro1_wr0_prdy;
wire ro1_wr1_prdy;
wire [64 -1:0] rq1_rd_pd;
wire  rq1_rd_prdy;
wire  rq1_rd_pvld;
wire src1_gnt;
reg [1:0] ctt2_cnt;
reg [6:0] ctt2_cq_pd;
reg  ctt2_vld;
wire ctt2_accept;
wire ctt2_last_beat;
wire ctt2_rdy;

wire [64 -1:0] dma2_data;

wire [64/2-1:0] dma2_data0;

wire [64/2-1:0] dma2_data1;
wire dma2_is_last_odd;
wire dma2_last_odd;
wire [1:0] dma2_mask;

wire [64/2-1:0] dma2_mdata0;

wire [64/2-1:0] dma2_mdata1;

wire [64 +(( 64 )/8/8)-1:0] dma2_pd;
wire dma2_rdy;
wire dma2_vld;
wire mon_dma2_lodd;
wire [64/2:0] ro2_rd0_pd;
wire [64/2:0] ro2_rd1_pd;
wire ro2_rd0_prdy;
wire ro2_rd0_pvld;
wire ro2_wr_rdy;
wire ro2_wr0_prdy;
wire ro2_wr1_prdy;
wire [64 -1:0] rq2_rd_pd;
wire  rq2_rd_prdy;
wire  rq2_rd_pvld;
wire src2_gnt;
reg [1:0] ctt3_cnt;
reg [6:0] ctt3_cq_pd;
reg  ctt3_vld;
wire ctt3_accept;
wire ctt3_last_beat;
wire ctt3_rdy;

wire [64 -1:0] dma3_data;

wire [64/2-1:0] dma3_data0;

wire [64/2-1:0] dma3_data1;
wire dma3_is_last_odd;
wire dma3_last_odd;
wire [1:0] dma3_mask;

wire [64/2-1:0] dma3_mdata0;

wire [64/2-1:0] dma3_mdata1;

wire [64 +(( 64 )/8/8)-1:0] dma3_pd;
wire dma3_rdy;
wire dma3_vld;
wire mon_dma3_lodd;
wire [64/2:0] ro3_rd0_pd;
wire [64/2:0] ro3_rd1_pd;
wire ro3_rd0_prdy;
wire ro3_rd0_pvld;
wire ro3_wr_rdy;
wire ro3_wr0_prdy;
wire ro3_wr1_prdy;
wire [64 -1:0] rq3_rd_pd;
wire  rq3_rd_prdy;
wire  rq3_rd_pvld;
wire src3_gnt;
reg [1:0] ctt4_cnt;
reg [6:0] ctt4_cq_pd;
reg  ctt4_vld;
wire ctt4_accept;
wire ctt4_last_beat;
wire ctt4_rdy;

wire [64 -1:0] dma4_data;

wire [64/2-1:0] dma4_data0;

wire [64/2-1:0] dma4_data1;
wire dma4_is_last_odd;
wire dma4_last_odd;
wire [1:0] dma4_mask;

wire [64/2-1:0] dma4_mdata0;

wire [64/2-1:0] dma4_mdata1;

wire [64 +(( 64 )/8/8)-1:0] dma4_pd;
wire dma4_rdy;
wire dma4_vld;
wire mon_dma4_lodd;
wire [64/2:0] ro4_rd0_pd;
wire [64/2:0] ro4_rd1_pd;
wire ro4_rd0_prdy;
wire ro4_rd0_pvld;
wire ro4_wr_rdy;
wire ro4_wr0_prdy;
wire ro4_wr1_prdy;
wire [64 -1:0] rq4_rd_pd;
wire  rq4_rd_prdy;
wire  rq4_rd_pvld;
wire src4_gnt;
reg [1:0] ctt5_cnt;
reg [6:0] ctt5_cq_pd;
reg  ctt5_vld;
wire ctt5_accept;
wire ctt5_last_beat;
wire ctt5_rdy;

wire [64 -1:0] dma5_data;

wire [64/2-1:0] dma5_data0;

wire [64/2-1:0] dma5_data1;
wire dma5_is_last_odd;
wire dma5_last_odd;
wire [1:0] dma5_mask;

wire [64/2-1:0] dma5_mdata0;

wire [64/2-1:0] dma5_mdata1;

wire [64 +(( 64 )/8/8)-1:0] dma5_pd;
wire dma5_rdy;
wire dma5_vld;
wire mon_dma5_lodd;
wire [64/2:0] ro5_rd0_pd;
wire [64/2:0] ro5_rd1_pd;
wire ro5_rd0_prdy;
wire ro5_rd0_pvld;
wire ro5_wr_rdy;
wire ro5_wr0_prdy;
wire ro5_wr1_prdy;
wire [64 -1:0] rq5_rd_pd;
wire  rq5_rd_prdy;
wire  rq5_rd_pvld;
wire src5_gnt;
reg [1:0] ctt6_cnt;
reg [6:0] ctt6_cq_pd;
reg  ctt6_vld;
wire ctt6_accept;
wire ctt6_last_beat;
wire ctt6_rdy;

wire [64 -1:0] dma6_data;

wire [64/2-1:0] dma6_data0;

wire [64/2-1:0] dma6_data1;
wire dma6_is_last_odd;
wire dma6_last_odd;
wire [1:0] dma6_mask;

wire [64/2-1:0] dma6_mdata0;

wire [64/2-1:0] dma6_mdata1;

wire [64 +(( 64 )/8/8)-1:0] dma6_pd;
wire dma6_rdy;
wire dma6_vld;
wire mon_dma6_lodd;
wire [64/2:0] ro6_rd0_pd;
wire [64/2:0] ro6_rd1_pd;
wire ro6_rd0_prdy;
wire ro6_rd0_pvld;
wire ro6_wr_rdy;
wire ro6_wr0_prdy;
wire ro6_wr1_prdy;
wire [64 -1:0] rq6_rd_pd;
wire  rq6_rd_prdy;
wire  rq6_rd_pvld;
wire src6_gnt;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [3:0] ipipe_axi_axid;
wire [64 -1:0] ipipe_axi_data;
wire [64 +3:0] ipipe_axi_pd;
wire ipipe_axi_rdy;
wire ipipe_axi_vld;
wire last_odd;
wire [64 +3:0] noc2mcif_axi_r_pd;
wire [4:0] noc2mcif_axi_r_rid_NC;
wire noc2mcif_axi_r_rlast_NC;
wire arb_cq_fdrop;
wire arb_cq_ldrop;
wire [1:0] arb_cq_lens;
wire arb_cq_ltran;
wire arb_cq_odd;
wire arb_cq_swizzle;
wire [(64/2)-1:0] arb_data0;
wire [(64/2)-1:0] arb_data0_swizzled;
wire [(64/2)-1:0] arb_data1;
wire [(64/2)-1:0] arb_data1_swizzled;
wire arb_first_beat;
wire arb_last_beat;
wire [(64/2):0] arb_pd0;
wire [(64/2):0] arb_pd1;
wire arb_wen0_swizzled;
wire arb_wen1_swizzled;
//stepheng,remove
//// TIE-OFFs 
//assign noc2mcif_axi_r_rresp_NC = noc2mcif_axi_r_rresp;
assign noc2mcif_axi_r_rlast_NC = noc2mcif_axi_r_rlast;
//assign noc2mcif_axi_r_ruser_NC = noc2mcif_axi_r_ruser;
assign noc2mcif_axi_r_rid_NC = noc2mcif_axi_r_rid[7:3];
assign noc2mcif_axi_r_pd = {noc2mcif_axi_r_rid[3:0],noc2mcif_axi_r_rdata};
NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p1 pipe_p1 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.ipipe_axi_rdy (ipipe_axi_rdy) //|< w
  ,.noc2mcif_axi_r_pd (noc2mcif_axi_r_pd[64 +3:0]) //|< w
  ,.noc2mcif_axi_r_rvalid (noc2mcif_axi_r_rvalid) //|< i
  ,.ipipe_axi_pd (ipipe_axi_pd[64 +3:0]) //|> w
  ,.ipipe_axi_vld (ipipe_axi_vld) //|> w
  ,.noc2mcif_axi_r_rready (noc2mcif_axi_r_rready) //|> o
  );
//my $dw = eval(64 +4);
//&eperl::pipe(" -os -wid $dw -do ipipe_axi_pd -vo ipipe_axi_vld -ri noc2mcif_axi_r_rready -vi noc2mcif_axi_r_rvalid -di noc2mcif_axi_r_pd -ro ipipe_axi_rdy");
wire [64 -1:0] rq_wr_pd;
assign eg2ig_axi_vld = ipipe_axi_vld & ipipe_axi_rdy;
assign {ipipe_axi_axid,ipipe_axi_data} = ipipe_axi_pd;
assign rq_wr_pd = ipipe_axi_data;
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print qq(wire rq${i}_wr_pvld, rq${i}_wr_prdy;\n);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire rq0_wr_pvld, rq0_wr_prdy;
wire rq1_wr_pvld, rq1_wr_prdy;
wire rq2_wr_pvld, rq2_wr_prdy;
wire rq3_wr_pvld, rq3_wr_prdy;
wire rq4_wr_pvld, rq4_wr_prdy;
wire rq5_wr_pvld, rq5_wr_prdy;
wire rq6_wr_pvld, rq6_wr_prdy;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign ipipe_axi_rdy = 0
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//: print ("| (rq${i}_wr_pvld & rq${i}_wr_prdy)\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
| (rq0_wr_pvld & rq0_wr_prdy)
| (rq1_wr_pvld & rq1_wr_prdy)
| (rq2_wr_pvld & rq2_wr_prdy)
| (rq3_wr_pvld & rq3_wr_prdy)
| (rq4_wr_pvld & rq4_wr_prdy)
| (rq5_wr_pvld & rq5_wr_prdy)
| (rq6_wr_pvld & rq6_wr_prdy)

//| eperl: generated_end (DO NOT EDIT ABOVE)
;
//:my $k = 7;
//:my $i;
//:my @dma_index = (0, 1, 1,1, 1,0, 1, 1, 0, 1,0,0,0,0,0,0);
//:my @client_id = (0,8,9,3,2,4,1,5,7,6,0,0,0,0,0,0);
//:my @remap_clientid = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
//:my $nindex = 0;
//:for ($i=0;$i<16;$i++) {
//: if ($dma_index[$i] != 0) {
//: $remap_clientid[$nindex] = $client_id[$i];
//: $nindex++;
//: }
//:}
//:for($i=0;$i<$k;$i++) {
//:print("assign rq${i}_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == $remap_clientid[$i]);\n");
//:print qq(wire [64 -1:0] rq${i}_wr_pd = rq_wr_pd;\n);
//:print("NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo lat_fifo${i} (\n");
//:print(".nvdla_core_clk(nvdla_core_clk)\n");
//:print(",.nvdla_core_rstn(nvdla_core_rstn)\n");
//:print(",.rq_wr_prdy(rq${i}_wr_prdy)\n");
//:print(",.rq_wr_pvld(rq${i}_wr_pvld)\n");
//:print(",.rq_wr_pd(rq${i}_wr_pd)\n");
//:print(",.rq_rd_prdy(rq${i}_rd_prdy)\n");
//:print(",.rq_rd_pvld(rq${i}_rd_pvld)\n");
//:print(",.rq_rd_pd(rq${i}_rd_pd)\n");
//:print(",.pwrbus_ram_pd(pwrbus_ram_pd)\n");
//:print(");\n");
//:}
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print("wire src${i}_req = rq${i}_rd_pvld && ctt${i}_vld && ro${i}_wr_rdy;\n");
//:print("assign ctt${i}_rdy = src${i}_gnt;\n");
//:print("assign rq${i}_rd_prdy = src${i}_gnt;\n");
//:}
//:my $k = 7;
//:my $i;
//:for ($i=$k; $i<16;$i++) {
//:print qq(
//: assign src${i}_req = 1'b0;
//: wire src${i}_gnt;
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign rq0_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == 8);
wire [64 -1:0] rq0_wr_pd = rq_wr_pd;
NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo lat_fifo0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rq_wr_prdy(rq0_wr_prdy)
,.rq_wr_pvld(rq0_wr_pvld)
,.rq_wr_pd(rq0_wr_pd)
,.rq_rd_prdy(rq0_rd_prdy)
,.rq_rd_pvld(rq0_rd_pvld)
,.rq_rd_pd(rq0_rd_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign rq1_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == 9);
wire [64 -1:0] rq1_wr_pd = rq_wr_pd;
NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo lat_fifo1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rq_wr_prdy(rq1_wr_prdy)
,.rq_wr_pvld(rq1_wr_pvld)
,.rq_wr_pd(rq1_wr_pd)
,.rq_rd_prdy(rq1_rd_prdy)
,.rq_rd_pvld(rq1_rd_pvld)
,.rq_rd_pd(rq1_rd_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign rq2_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == 3);
wire [64 -1:0] rq2_wr_pd = rq_wr_pd;
NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo lat_fifo2 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rq_wr_prdy(rq2_wr_prdy)
,.rq_wr_pvld(rq2_wr_pvld)
,.rq_wr_pd(rq2_wr_pd)
,.rq_rd_prdy(rq2_rd_prdy)
,.rq_rd_pvld(rq2_rd_pvld)
,.rq_rd_pd(rq2_rd_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign rq3_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == 2);
wire [64 -1:0] rq3_wr_pd = rq_wr_pd;
NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo lat_fifo3 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rq_wr_prdy(rq3_wr_prdy)
,.rq_wr_pvld(rq3_wr_pvld)
,.rq_wr_pd(rq3_wr_pd)
,.rq_rd_prdy(rq3_rd_prdy)
,.rq_rd_pvld(rq3_rd_pvld)
,.rq_rd_pd(rq3_rd_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign rq4_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == 1);
wire [64 -1:0] rq4_wr_pd = rq_wr_pd;
NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo lat_fifo4 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rq_wr_prdy(rq4_wr_prdy)
,.rq_wr_pvld(rq4_wr_pvld)
,.rq_wr_pd(rq4_wr_pd)
,.rq_rd_prdy(rq4_rd_prdy)
,.rq_rd_pvld(rq4_rd_pvld)
,.rq_rd_pd(rq4_rd_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign rq5_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == 5);
wire [64 -1:0] rq5_wr_pd = rq_wr_pd;
NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo lat_fifo5 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rq_wr_prdy(rq5_wr_prdy)
,.rq_wr_pvld(rq5_wr_pvld)
,.rq_wr_pd(rq5_wr_pd)
,.rq_rd_prdy(rq5_rd_prdy)
,.rq_rd_pvld(rq5_rd_pvld)
,.rq_rd_pd(rq5_rd_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign rq6_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == 6);
wire [64 -1:0] rq6_wr_pd = rq_wr_pd;
NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo lat_fifo6 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rq_wr_prdy(rq6_wr_prdy)
,.rq_wr_pvld(rq6_wr_pvld)
,.rq_wr_pd(rq6_wr_pd)
,.rq_rd_prdy(rq6_rd_prdy)
,.rq_rd_pvld(rq6_rd_pvld)
,.rq_rd_pd(rq6_rd_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
wire src0_req = rq0_rd_pvld && ctt0_vld && ro0_wr_rdy;
assign ctt0_rdy = src0_gnt;
assign rq0_rd_prdy = src0_gnt;
wire src1_req = rq1_rd_pvld && ctt1_vld && ro1_wr_rdy;
assign ctt1_rdy = src1_gnt;
assign rq1_rd_prdy = src1_gnt;
wire src2_req = rq2_rd_pvld && ctt2_vld && ro2_wr_rdy;
assign ctt2_rdy = src2_gnt;
assign rq2_rd_prdy = src2_gnt;
wire src3_req = rq3_rd_pvld && ctt3_vld && ro3_wr_rdy;
assign ctt3_rdy = src3_gnt;
assign rq3_rd_prdy = src3_gnt;
wire src4_req = rq4_rd_pvld && ctt4_vld && ro4_wr_rdy;
assign ctt4_rdy = src4_gnt;
assign rq4_rd_prdy = src4_gnt;
wire src5_req = rq5_rd_pvld && ctt5_vld && ro5_wr_rdy;
assign ctt5_rdy = src5_gnt;
assign rq5_rd_prdy = src5_gnt;
wire src6_req = rq6_rd_pvld && ctt6_vld && ro6_wr_rdy;
assign ctt6_rdy = src6_gnt;
assign rq6_rd_prdy = src6_gnt;

assign src7_req = 1'b0;
wire src7_gnt;

assign src8_req = 1'b0;
wire src8_gnt;

assign src9_req = 1'b0;
wire src9_gnt;

assign src10_req = 1'b0;
wire src10_gnt;

assign src11_req = 1'b0;
wire src11_gnt;

assign src12_req = 1'b0;
wire src12_gnt;

assign src13_req = 1'b0;
wire src13_gnt;

assign src14_req = 1'b0;
wire src14_gnt;

assign src15_req = 1'b0;
wire src15_gnt;

//| eperl: generated_end (DO NOT EDIT ABOVE)
read_eg_arb u_read_eg_arb (
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
  ,.wt0 ({8{1'b1}}) //|< ?
  ,.wt1 ({8{1'b1}}) //|< ?
  ,.wt2 ({8{1'b1}}) //|< ?
  ,.wt3 ({8{1'b1}}) //|< ?
  ,.wt4 ({8{1'b1}}) //|< ?
  ,.wt5 ({8{1'b1}}) //|< ?
  ,.wt6 ({8{1'b1}}) //|< ?
  ,.wt7 ({8{1'b1}}) //|< ?
  ,.wt8 ({8{1'b1}}) //|< ?
  ,.wt9 ({8{1'b1}}) //|< ?
  ,.wt10 ({8{1'b1}}) //|< ?
  ,.wt11 ({8{1'b1}}) //|< ?
  ,.wt12 ({8{1'b1}}) //|< ?
  ,.wt13 ({8{1'b1}}) //|< ?
  ,.wt14 ({8{1'b1}}) //|< ?
  ,.wt15 ({8{1'b1}}) //|< ?
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
always @(src0_gnt or rq0_rd_pd
//:my $k = 7;
//:my $i;
//:for($i=1;$i<$k;$i++) {
//:print("or src${i}_gnt or rq${i}_rd_pd\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
or src1_gnt or rq1_rd_pd
or src2_gnt or rq2_rd_pd
or src3_gnt or rq3_rd_pd
or src4_gnt or rq4_rd_pd
or src5_gnt or rq5_rd_pd
or src6_gnt or rq6_rd_pd

//| eperl: generated_end (DO NOT EDIT ABOVE)
) begin
 case (1'b1)
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//: print("src${i}_gnt: arb_data = rq${i}_rd_pd;\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
src0_gnt: arb_data = rq0_rd_pd;
src1_gnt: arb_data = rq1_rd_pd;
src2_gnt: arb_data = rq2_rd_pd;
src3_gnt: arb_data = rq3_rd_pd;
src4_gnt: arb_data = rq4_rd_pd;
src5_gnt: arb_data = rq5_rd_pd;
src6_gnt: arb_data = rq6_rd_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
  default : begin
                arb_data[64 -1:0] = {64{`x_or_0}};
              end
//VCS coverage on
    endcase
//spyglass enable_block W171 W226
end
always @(src0_gnt or ctt0_cq_pd
//:my $k = 7;
//:my $i;
//:for($i=1;$i<$k;$i++) {
//:print("or src${i}_gnt or ctt${i}_cq_pd\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
or src1_gnt or ctt1_cq_pd
or src2_gnt or ctt2_cq_pd
or src3_gnt or ctt3_cq_pd
or src4_gnt or ctt4_cq_pd
or src5_gnt or ctt5_cq_pd
or src6_gnt or ctt6_cq_pd

//| eperl: generated_end (DO NOT EDIT ABOVE)
) begin
 case (1'b1)
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//: print("src${i}_gnt: arb_cq_pd = ctt${i}_cq_pd;\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
src0_gnt: arb_cq_pd = ctt0_cq_pd;
src1_gnt: arb_cq_pd = ctt1_cq_pd;
src2_gnt: arb_cq_pd = ctt2_cq_pd;
src3_gnt: arb_cq_pd = ctt3_cq_pd;
src4_gnt: arb_cq_pd = ctt4_cq_pd;
src5_gnt: arb_cq_pd = ctt5_cq_pd;
src6_gnt: arb_cq_pd = ctt6_cq_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
  default : begin
                arb_cq_pd = {64{`x_or_0}};
              end
//VCS coverage on
    endcase
//spyglass enable_block W171 W226
end
always @(src0_gnt or ctt0_cnt
//:my $k = 7;
//:my $i;
//:for($i=1;$i<$k;$i++) {
//:print("or src${i}_gnt or ctt${i}_cnt\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
or src1_gnt or ctt1_cnt
or src2_gnt or ctt2_cnt
or src3_gnt or ctt3_cnt
or src4_gnt or ctt4_cnt
or src5_gnt or ctt5_cnt
or src6_gnt or ctt6_cnt

//| eperl: generated_end (DO NOT EDIT ABOVE)
) begin
 case (1'b1)
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//: print("src${i}_gnt: arb_cnt = ctt${i}_cnt;\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
src0_gnt: arb_cnt = ctt0_cnt;
src1_gnt: arb_cnt = ctt1_cnt;
src2_gnt: arb_cnt = ctt2_cnt;
src3_gnt: arb_cnt = ctt3_cnt;
src4_gnt: arb_cnt = ctt4_cnt;
src5_gnt: arb_cnt = ctt5_cnt;
src6_gnt: arb_cnt = ctt6_cnt;

//| eperl: generated_end (DO NOT EDIT ABOVE)
  default : begin
                arb_cnt = {64{`x_or_0}};
              end
//VCS coverage on
    endcase
//spyglass enable_block W171 W226
end
// PKT_UNPACK_WIRE( nocif_read_ig2eg , arb_cq_ , arb_cq_pd )
assign arb_cq_lens[1:0] = arb_cq_pd[1:0];
assign arb_cq_swizzle = arb_cq_pd[2];
assign arb_cq_odd = arb_cq_pd[3];
assign arb_cq_ltran = arb_cq_pd[4];
assign arb_cq_fdrop = arb_cq_pd[5];
assign arb_cq_ldrop = arb_cq_pd[6];
always @(
  arb_first_beat
  or arb_cq_fdrop
  or arb_last_beat
  or arb_cq_ldrop
  ) begin
    if (arb_first_beat && arb_cq_fdrop) begin
        arb_wen = 2'b10;
    end else if (arb_last_beat && arb_cq_ldrop) begin
        arb_wen = 2'b01;
    end else begin
        arb_wen = 2'b11;
    end
end
assign last_odd = arb_last_beat && arb_cq_ltran && arb_cq_odd;
assign arb_data0 = {arb_data[(64/2)-1:0]};
assign arb_data1 = {arb_data[64 -1:(64/2)]};
assign arb_data0_swizzled = arb_cq_swizzle ? arb_data1 : arb_data0;
assign arb_data1_swizzled = arb_cq_swizzle ? arb_data0 : arb_data1;
assign arb_pd0 = {last_odd,arb_data0_swizzled};
assign arb_pd1 = {1'b0 ,arb_data1_swizzled};
assign arb_wen0_swizzled = arb_cq_swizzle ? arb_wen[1] : arb_wen[0];
assign arb_wen1_swizzled = arb_cq_swizzle ? arb_wen[0] : arb_wen[1];
assign arb_last_beat = (arb_cnt==arb_cq_lens);
assign arb_first_beat = (arb_cnt==0);
//:my $k = 7;
//:my $i;
//:my $j=(( 64 )/8/8);
//:for($i=0;$i<$k;$i++) {
//:print qq(
//:assign ro${i}_wr_rdy = ro${i}_wr0_prdy & ro${i}_wr1_prdy;
//:wire ro${i}_wr0_pvld = src${i}_gnt & arb_wen0_swizzled & ro${i}_wr1_prdy;
//:wire ro${i}_rd1_prdy;
//:wire [64/2:0] ro${i}_wr0_pd = arb_pd0;
//:NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro${i}_fifo0 (
//:.nvdla_core_clk(nvdla_core_clk)
//:,.nvdla_core_rstn(nvdla_core_rstn)
//:,.ro_wr_prdy(ro${i}_wr0_prdy)
//:,.ro_wr_pvld(ro${i}_wr0_pvld)
//:,.ro_wr_pd(ro${i}_wr0_pd)
//:,.ro_rd_prdy(ro${i}_rd0_prdy)
//:,.ro_rd_pvld(ro${i}_rd0_pvld)
//:,.ro_rd_pd(ro${i}_rd0_pd)
//:,.pwrbus_ram_pd(pwrbus_ram_pd)
//:);
//:);
//:print("wire ro${i}_wr1_pvld = src${i}_gnt & arb_wen1_swizzled & ro${i}_wr0_prdy;\n");
//:print qq(wire [64/2:0] ro${i}_wr1_pd = arb_pd1;\n);
//:print qq(
//:NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro${i}_fifo1 (
//:.nvdla_core_clk(nvdla_core_clk)
//:,.nvdla_core_rstn(nvdla_core_rstn)
//:,.ro_wr_prdy(ro${i}_wr1_prdy)
//:,.ro_wr_pvld(ro${i}_wr1_pvld)
//:,.ro_wr_pd(ro${i}_wr1_pd)
//:,.ro_rd_prdy(ro${i}_rd1_prdy)
//:,.ro_rd_pvld(ro${i}_rd1_pvld)
//:,.ro_rd_pd(ro${i}_rd1_pd)
//:,.pwrbus_ram_pd(pwrbus_ram_pd)
//:);
//:);
//:print("assign dma${i}_vld = ro${i}_rd0_pvld & (dma${i}_last_odd ? 1'b1 : ro${i}_rd1_pvld);\n");
//:print("assign {dma${i}_last_odd,dma${i}_data0} = ro${i}_rd0_pd;\n");
//:print("assign {mon_dma${i}_lodd,dma${i}_data1} = ro${i}_rd1_pd;\n");
//:print("assign dma${i}_is_last_odd = ro${i}_rd0_pvld & dma${i}_last_odd;\n");
//:print("assign dma${i}_mask = dma${i}_is_last_odd ? 2'b01: 2'b11;\n");
//:print qq(assign dma${i}_mdata0 = {64/2{dma${i}_mask[0]}} & dma${i}_data0;\n);
//:print qq(assign dma${i}_mdata1 = {64/2{dma${i}_mask[1]}} & dma${i}_data1;\n);
//:if ($j > 1) {
//: print("assign dma${i}_pd = {dma${i}_mask,dma${i}_data};\n");
//:} elsif ($j == 1) {
//: print("assign dma${i}_pd = {1'b1,dma${i}_data};\n");
//:}
//:print("assign dma${i}_data = {dma${i}_mdata1,dma${i}_mdata0};\n");
//:print("assign ro${i}_rd0_prdy = dma${i}_rdy & (dma${i}_is_last_odd ? 1'b1: ro${i}_rd1_pvld);\n");
//:print("assign ro${i}_rd1_prdy = dma${i}_rdy & (dma${i}_is_last_odd ? 1'b1: ro${i}_rd0_pvld);\n");
//:print qq(
//:NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 pipe_pp${i} (
//:.nvdla_core_clk(nvdla_core_clk)
//:,.nvdla_core_rstn(nvdla_core_rstn)
//:,.rd_rsp_rdy(mcif2client${i}_rd_rsp_ready)
//:,.dma_pd(dma${i}_pd)
//:,.dma_vld(dma${i}_vld)
//:,.rd_rsp_pd(mcif2client${i}_rd_rsp_pd)
//:,.rd_rsp_valid(mcif2client${i}_rd_rsp_valid)
//:,.dma_rdy(dma${i}_rdy)
//:);
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign ro0_wr_rdy = ro0_wr0_prdy & ro0_wr1_prdy;
wire ro0_wr0_pvld = src0_gnt & arb_wen0_swizzled & ro0_wr1_prdy;
wire ro0_rd1_prdy;
wire [64/2:0] ro0_wr0_pd = arb_pd0;
NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro0_fifo0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro0_wr0_prdy)
,.ro_wr_pvld(ro0_wr0_pvld)
,.ro_wr_pd(ro0_wr0_pd)
,.ro_rd_prdy(ro0_rd0_prdy)
,.ro_rd_pvld(ro0_rd0_pvld)
,.ro_rd_pd(ro0_rd0_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
wire ro0_wr1_pvld = src0_gnt & arb_wen1_swizzled & ro0_wr0_prdy;
wire [64/2:0] ro0_wr1_pd = arb_pd1;

NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro0_fifo1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro0_wr1_prdy)
,.ro_wr_pvld(ro0_wr1_pvld)
,.ro_wr_pd(ro0_wr1_pd)
,.ro_rd_prdy(ro0_rd1_prdy)
,.ro_rd_pvld(ro0_rd1_pvld)
,.ro_rd_pd(ro0_rd1_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign dma0_vld = ro0_rd0_pvld & (dma0_last_odd ? 1'b1 : ro0_rd1_pvld);
assign {dma0_last_odd,dma0_data0} = ro0_rd0_pd;
assign {mon_dma0_lodd,dma0_data1} = ro0_rd1_pd;
assign dma0_is_last_odd = ro0_rd0_pvld & dma0_last_odd;
assign dma0_mask = dma0_is_last_odd ? 2'b01: 2'b11;
assign dma0_mdata0 = {64/2{dma0_mask[0]}} & dma0_data0;
assign dma0_mdata1 = {64/2{dma0_mask[1]}} & dma0_data1;
assign dma0_pd = {1'b1,dma0_data};
assign dma0_data = {dma0_mdata1,dma0_mdata0};
assign ro0_rd0_prdy = dma0_rdy & (dma0_is_last_odd ? 1'b1: ro0_rd1_pvld);
assign ro0_rd1_prdy = dma0_rdy & (dma0_is_last_odd ? 1'b1: ro0_rd0_pvld);

NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 pipe_pp0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rd_rsp_rdy(mcif2client0_rd_rsp_ready)
,.dma_pd(dma0_pd)
,.dma_vld(dma0_vld)
,.rd_rsp_pd(mcif2client0_rd_rsp_pd)
,.rd_rsp_valid(mcif2client0_rd_rsp_valid)
,.dma_rdy(dma0_rdy)
);

assign ro1_wr_rdy = ro1_wr0_prdy & ro1_wr1_prdy;
wire ro1_wr0_pvld = src1_gnt & arb_wen0_swizzled & ro1_wr1_prdy;
wire ro1_rd1_prdy;
wire [64/2:0] ro1_wr0_pd = arb_pd0;
NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro1_fifo0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro1_wr0_prdy)
,.ro_wr_pvld(ro1_wr0_pvld)
,.ro_wr_pd(ro1_wr0_pd)
,.ro_rd_prdy(ro1_rd0_prdy)
,.ro_rd_pvld(ro1_rd0_pvld)
,.ro_rd_pd(ro1_rd0_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
wire ro1_wr1_pvld = src1_gnt & arb_wen1_swizzled & ro1_wr0_prdy;
wire [64/2:0] ro1_wr1_pd = arb_pd1;

NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro1_fifo1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro1_wr1_prdy)
,.ro_wr_pvld(ro1_wr1_pvld)
,.ro_wr_pd(ro1_wr1_pd)
,.ro_rd_prdy(ro1_rd1_prdy)
,.ro_rd_pvld(ro1_rd1_pvld)
,.ro_rd_pd(ro1_rd1_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign dma1_vld = ro1_rd0_pvld & (dma1_last_odd ? 1'b1 : ro1_rd1_pvld);
assign {dma1_last_odd,dma1_data0} = ro1_rd0_pd;
assign {mon_dma1_lodd,dma1_data1} = ro1_rd1_pd;
assign dma1_is_last_odd = ro1_rd0_pvld & dma1_last_odd;
assign dma1_mask = dma1_is_last_odd ? 2'b01: 2'b11;
assign dma1_mdata0 = {64/2{dma1_mask[0]}} & dma1_data0;
assign dma1_mdata1 = {64/2{dma1_mask[1]}} & dma1_data1;
assign dma1_pd = {1'b1,dma1_data};
assign dma1_data = {dma1_mdata1,dma1_mdata0};
assign ro1_rd0_prdy = dma1_rdy & (dma1_is_last_odd ? 1'b1: ro1_rd1_pvld);
assign ro1_rd1_prdy = dma1_rdy & (dma1_is_last_odd ? 1'b1: ro1_rd0_pvld);

NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 pipe_pp1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rd_rsp_rdy(mcif2client1_rd_rsp_ready)
,.dma_pd(dma1_pd)
,.dma_vld(dma1_vld)
,.rd_rsp_pd(mcif2client1_rd_rsp_pd)
,.rd_rsp_valid(mcif2client1_rd_rsp_valid)
,.dma_rdy(dma1_rdy)
);

assign ro2_wr_rdy = ro2_wr0_prdy & ro2_wr1_prdy;
wire ro2_wr0_pvld = src2_gnt & arb_wen0_swizzled & ro2_wr1_prdy;
wire ro2_rd1_prdy;
wire [64/2:0] ro2_wr0_pd = arb_pd0;
NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro2_fifo0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro2_wr0_prdy)
,.ro_wr_pvld(ro2_wr0_pvld)
,.ro_wr_pd(ro2_wr0_pd)
,.ro_rd_prdy(ro2_rd0_prdy)
,.ro_rd_pvld(ro2_rd0_pvld)
,.ro_rd_pd(ro2_rd0_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
wire ro2_wr1_pvld = src2_gnt & arb_wen1_swizzled & ro2_wr0_prdy;
wire [64/2:0] ro2_wr1_pd = arb_pd1;

NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro2_fifo1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro2_wr1_prdy)
,.ro_wr_pvld(ro2_wr1_pvld)
,.ro_wr_pd(ro2_wr1_pd)
,.ro_rd_prdy(ro2_rd1_prdy)
,.ro_rd_pvld(ro2_rd1_pvld)
,.ro_rd_pd(ro2_rd1_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign dma2_vld = ro2_rd0_pvld & (dma2_last_odd ? 1'b1 : ro2_rd1_pvld);
assign {dma2_last_odd,dma2_data0} = ro2_rd0_pd;
assign {mon_dma2_lodd,dma2_data1} = ro2_rd1_pd;
assign dma2_is_last_odd = ro2_rd0_pvld & dma2_last_odd;
assign dma2_mask = dma2_is_last_odd ? 2'b01: 2'b11;
assign dma2_mdata0 = {64/2{dma2_mask[0]}} & dma2_data0;
assign dma2_mdata1 = {64/2{dma2_mask[1]}} & dma2_data1;
assign dma2_pd = {1'b1,dma2_data};
assign dma2_data = {dma2_mdata1,dma2_mdata0};
assign ro2_rd0_prdy = dma2_rdy & (dma2_is_last_odd ? 1'b1: ro2_rd1_pvld);
assign ro2_rd1_prdy = dma2_rdy & (dma2_is_last_odd ? 1'b1: ro2_rd0_pvld);

NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 pipe_pp2 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rd_rsp_rdy(mcif2client2_rd_rsp_ready)
,.dma_pd(dma2_pd)
,.dma_vld(dma2_vld)
,.rd_rsp_pd(mcif2client2_rd_rsp_pd)
,.rd_rsp_valid(mcif2client2_rd_rsp_valid)
,.dma_rdy(dma2_rdy)
);

assign ro3_wr_rdy = ro3_wr0_prdy & ro3_wr1_prdy;
wire ro3_wr0_pvld = src3_gnt & arb_wen0_swizzled & ro3_wr1_prdy;
wire ro3_rd1_prdy;
wire [64/2:0] ro3_wr0_pd = arb_pd0;
NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro3_fifo0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro3_wr0_prdy)
,.ro_wr_pvld(ro3_wr0_pvld)
,.ro_wr_pd(ro3_wr0_pd)
,.ro_rd_prdy(ro3_rd0_prdy)
,.ro_rd_pvld(ro3_rd0_pvld)
,.ro_rd_pd(ro3_rd0_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
wire ro3_wr1_pvld = src3_gnt & arb_wen1_swizzled & ro3_wr0_prdy;
wire [64/2:0] ro3_wr1_pd = arb_pd1;

NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro3_fifo1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro3_wr1_prdy)
,.ro_wr_pvld(ro3_wr1_pvld)
,.ro_wr_pd(ro3_wr1_pd)
,.ro_rd_prdy(ro3_rd1_prdy)
,.ro_rd_pvld(ro3_rd1_pvld)
,.ro_rd_pd(ro3_rd1_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign dma3_vld = ro3_rd0_pvld & (dma3_last_odd ? 1'b1 : ro3_rd1_pvld);
assign {dma3_last_odd,dma3_data0} = ro3_rd0_pd;
assign {mon_dma3_lodd,dma3_data1} = ro3_rd1_pd;
assign dma3_is_last_odd = ro3_rd0_pvld & dma3_last_odd;
assign dma3_mask = dma3_is_last_odd ? 2'b01: 2'b11;
assign dma3_mdata0 = {64/2{dma3_mask[0]}} & dma3_data0;
assign dma3_mdata1 = {64/2{dma3_mask[1]}} & dma3_data1;
assign dma3_pd = {1'b1,dma3_data};
assign dma3_data = {dma3_mdata1,dma3_mdata0};
assign ro3_rd0_prdy = dma3_rdy & (dma3_is_last_odd ? 1'b1: ro3_rd1_pvld);
assign ro3_rd1_prdy = dma3_rdy & (dma3_is_last_odd ? 1'b1: ro3_rd0_pvld);

NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 pipe_pp3 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rd_rsp_rdy(mcif2client3_rd_rsp_ready)
,.dma_pd(dma3_pd)
,.dma_vld(dma3_vld)
,.rd_rsp_pd(mcif2client3_rd_rsp_pd)
,.rd_rsp_valid(mcif2client3_rd_rsp_valid)
,.dma_rdy(dma3_rdy)
);

assign ro4_wr_rdy = ro4_wr0_prdy & ro4_wr1_prdy;
wire ro4_wr0_pvld = src4_gnt & arb_wen0_swizzled & ro4_wr1_prdy;
wire ro4_rd1_prdy;
wire [64/2:0] ro4_wr0_pd = arb_pd0;
NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro4_fifo0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro4_wr0_prdy)
,.ro_wr_pvld(ro4_wr0_pvld)
,.ro_wr_pd(ro4_wr0_pd)
,.ro_rd_prdy(ro4_rd0_prdy)
,.ro_rd_pvld(ro4_rd0_pvld)
,.ro_rd_pd(ro4_rd0_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
wire ro4_wr1_pvld = src4_gnt & arb_wen1_swizzled & ro4_wr0_prdy;
wire [64/2:0] ro4_wr1_pd = arb_pd1;

NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro4_fifo1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro4_wr1_prdy)
,.ro_wr_pvld(ro4_wr1_pvld)
,.ro_wr_pd(ro4_wr1_pd)
,.ro_rd_prdy(ro4_rd1_prdy)
,.ro_rd_pvld(ro4_rd1_pvld)
,.ro_rd_pd(ro4_rd1_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign dma4_vld = ro4_rd0_pvld & (dma4_last_odd ? 1'b1 : ro4_rd1_pvld);
assign {dma4_last_odd,dma4_data0} = ro4_rd0_pd;
assign {mon_dma4_lodd,dma4_data1} = ro4_rd1_pd;
assign dma4_is_last_odd = ro4_rd0_pvld & dma4_last_odd;
assign dma4_mask = dma4_is_last_odd ? 2'b01: 2'b11;
assign dma4_mdata0 = {64/2{dma4_mask[0]}} & dma4_data0;
assign dma4_mdata1 = {64/2{dma4_mask[1]}} & dma4_data1;
assign dma4_pd = {1'b1,dma4_data};
assign dma4_data = {dma4_mdata1,dma4_mdata0};
assign ro4_rd0_prdy = dma4_rdy & (dma4_is_last_odd ? 1'b1: ro4_rd1_pvld);
assign ro4_rd1_prdy = dma4_rdy & (dma4_is_last_odd ? 1'b1: ro4_rd0_pvld);

NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 pipe_pp4 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rd_rsp_rdy(mcif2client4_rd_rsp_ready)
,.dma_pd(dma4_pd)
,.dma_vld(dma4_vld)
,.rd_rsp_pd(mcif2client4_rd_rsp_pd)
,.rd_rsp_valid(mcif2client4_rd_rsp_valid)
,.dma_rdy(dma4_rdy)
);

assign ro5_wr_rdy = ro5_wr0_prdy & ro5_wr1_prdy;
wire ro5_wr0_pvld = src5_gnt & arb_wen0_swizzled & ro5_wr1_prdy;
wire ro5_rd1_prdy;
wire [64/2:0] ro5_wr0_pd = arb_pd0;
NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro5_fifo0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro5_wr0_prdy)
,.ro_wr_pvld(ro5_wr0_pvld)
,.ro_wr_pd(ro5_wr0_pd)
,.ro_rd_prdy(ro5_rd0_prdy)
,.ro_rd_pvld(ro5_rd0_pvld)
,.ro_rd_pd(ro5_rd0_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
wire ro5_wr1_pvld = src5_gnt & arb_wen1_swizzled & ro5_wr0_prdy;
wire [64/2:0] ro5_wr1_pd = arb_pd1;

NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro5_fifo1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro5_wr1_prdy)
,.ro_wr_pvld(ro5_wr1_pvld)
,.ro_wr_pd(ro5_wr1_pd)
,.ro_rd_prdy(ro5_rd1_prdy)
,.ro_rd_pvld(ro5_rd1_pvld)
,.ro_rd_pd(ro5_rd1_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign dma5_vld = ro5_rd0_pvld & (dma5_last_odd ? 1'b1 : ro5_rd1_pvld);
assign {dma5_last_odd,dma5_data0} = ro5_rd0_pd;
assign {mon_dma5_lodd,dma5_data1} = ro5_rd1_pd;
assign dma5_is_last_odd = ro5_rd0_pvld & dma5_last_odd;
assign dma5_mask = dma5_is_last_odd ? 2'b01: 2'b11;
assign dma5_mdata0 = {64/2{dma5_mask[0]}} & dma5_data0;
assign dma5_mdata1 = {64/2{dma5_mask[1]}} & dma5_data1;
assign dma5_pd = {1'b1,dma5_data};
assign dma5_data = {dma5_mdata1,dma5_mdata0};
assign ro5_rd0_prdy = dma5_rdy & (dma5_is_last_odd ? 1'b1: ro5_rd1_pvld);
assign ro5_rd1_prdy = dma5_rdy & (dma5_is_last_odd ? 1'b1: ro5_rd0_pvld);

NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 pipe_pp5 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rd_rsp_rdy(mcif2client5_rd_rsp_ready)
,.dma_pd(dma5_pd)
,.dma_vld(dma5_vld)
,.rd_rsp_pd(mcif2client5_rd_rsp_pd)
,.rd_rsp_valid(mcif2client5_rd_rsp_valid)
,.dma_rdy(dma5_rdy)
);

assign ro6_wr_rdy = ro6_wr0_prdy & ro6_wr1_prdy;
wire ro6_wr0_pvld = src6_gnt & arb_wen0_swizzled & ro6_wr1_prdy;
wire ro6_rd1_prdy;
wire [64/2:0] ro6_wr0_pd = arb_pd0;
NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro6_fifo0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro6_wr0_prdy)
,.ro_wr_pvld(ro6_wr0_pvld)
,.ro_wr_pd(ro6_wr0_pd)
,.ro_rd_prdy(ro6_rd0_prdy)
,.ro_rd_pvld(ro6_rd0_pvld)
,.ro_rd_pd(ro6_rd0_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
wire ro6_wr1_pvld = src6_gnt & arb_wen1_swizzled & ro6_wr0_prdy;
wire [64/2:0] ro6_wr1_pd = arb_pd1;

NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo ro6_fifo1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.ro_wr_prdy(ro6_wr1_prdy)
,.ro_wr_pvld(ro6_wr1_pvld)
,.ro_wr_pd(ro6_wr1_pd)
,.ro_rd_prdy(ro6_rd1_prdy)
,.ro_rd_pvld(ro6_rd1_pvld)
,.ro_rd_pd(ro6_rd1_pd)
,.pwrbus_ram_pd(pwrbus_ram_pd)
);
assign dma6_vld = ro6_rd0_pvld & (dma6_last_odd ? 1'b1 : ro6_rd1_pvld);
assign {dma6_last_odd,dma6_data0} = ro6_rd0_pd;
assign {mon_dma6_lodd,dma6_data1} = ro6_rd1_pd;
assign dma6_is_last_odd = ro6_rd0_pvld & dma6_last_odd;
assign dma6_mask = dma6_is_last_odd ? 2'b01: 2'b11;
assign dma6_mdata0 = {64/2{dma6_mask[0]}} & dma6_data0;
assign dma6_mdata1 = {64/2{dma6_mask[1]}} & dma6_data1;
assign dma6_pd = {1'b1,dma6_data};
assign dma6_data = {dma6_mdata1,dma6_mdata0};
assign ro6_rd0_prdy = dma6_rdy & (dma6_is_last_odd ? 1'b1: ro6_rd1_pvld);
assign ro6_rd1_prdy = dma6_rdy & (dma6_is_last_odd ? 1'b1: ro6_rd0_pvld);

NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 pipe_pp6 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.rd_rsp_rdy(mcif2client6_rd_rsp_ready)
,.dma_pd(dma6_pd)
,.dma_vld(dma6_vld)
,.rd_rsp_pd(mcif2client6_rd_rsp_pd)
,.rd_rsp_valid(mcif2client6_rd_rsp_valid)
,.dma_rdy(dma6_rdy)
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//my $dw = eval(64 +2);
//&eperl::pipe("-is -wid $dw -vo mcif2client${i}_rd_rsp_valid -do mcif2client${i}_rd_rsp_pd -ro dma${i}_rdy -vi dma${i}_vld -di dma${i}_pd -ri mcif2client${i}_rd_rsp_ready");
//:my $k = 7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print("assign ctt${i}_last_beat = src${i}_gnt & arb_last_beat;\n");
//:print("assign cq_rd${i}_prdy = (ctt${i}_rdy & ctt${i}_last_beat) || !ctt${i}_vld;\n");
//:print("always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin\n");
//:print("   if (!nvdla_core_rstn) begin\n");
//:print("      ctt${i}_vld <= 1'b0;\n");
//:print("   end else begin\n");
//:print("       if ((cq_rd${i}_prdy) == 1'b1) begin\n");
//:print("          ctt${i}_vld <= cq_rd${i}_pvld;\n");
//:print("       end\n");
//:print("   end\n");
//:print("end\n");
//:print("always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin\n");
//:print("   if (!nvdla_core_rstn) begin\n");
//:print("      ctt${i}_cnt <= {2{1'b0}};\n");
//:print("   end else begin\n");
//:print("    if (cq_rd${i}_pvld && cq_rd${i}_prdy) begin \n");
//:print("       ctt${i}_cnt <= 0;\n");
//:print("    end else if (ctt${i}_accept) begin\n");
//:print("       ctt${i}_cnt <= ctt${i}_cnt + 1;\n");
//:print("    end\n");
//:print("   end\n");
//:print("end\n");
//:print("assign ctt${i}_accept = ctt${i}_vld & ctt${i}_rdy;\n");
//:print("always @(posedge nvdla_core_clk) begin\n");
//:print("   if (cq_rd${i}_pvld && cq_rd${i}_prdy) begin\n");
//:print("      ctt${i}_cq_pd <= cq_rd${i}_pd;\n");
//:print("   end\n");
//:print("end\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign ctt0_last_beat = src0_gnt & arb_last_beat;
assign cq_rd0_prdy = (ctt0_rdy & ctt0_last_beat) || !ctt0_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt0_vld <= 1'b0;
   end else begin
       if ((cq_rd0_prdy) == 1'b1) begin
          ctt0_vld <= cq_rd0_pvld;
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt0_cnt <= {2{1'b0}};
   end else begin
    if (cq_rd0_pvld && cq_rd0_prdy) begin 
       ctt0_cnt <= 0;
    end else if (ctt0_accept) begin
       ctt0_cnt <= ctt0_cnt + 1;
    end
   end
end
assign ctt0_accept = ctt0_vld & ctt0_rdy;
always @(posedge nvdla_core_clk) begin
   if (cq_rd0_pvld && cq_rd0_prdy) begin
      ctt0_cq_pd <= cq_rd0_pd;
   end
end
assign ctt1_last_beat = src1_gnt & arb_last_beat;
assign cq_rd1_prdy = (ctt1_rdy & ctt1_last_beat) || !ctt1_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt1_vld <= 1'b0;
   end else begin
       if ((cq_rd1_prdy) == 1'b1) begin
          ctt1_vld <= cq_rd1_pvld;
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt1_cnt <= {2{1'b0}};
   end else begin
    if (cq_rd1_pvld && cq_rd1_prdy) begin 
       ctt1_cnt <= 0;
    end else if (ctt1_accept) begin
       ctt1_cnt <= ctt1_cnt + 1;
    end
   end
end
assign ctt1_accept = ctt1_vld & ctt1_rdy;
always @(posedge nvdla_core_clk) begin
   if (cq_rd1_pvld && cq_rd1_prdy) begin
      ctt1_cq_pd <= cq_rd1_pd;
   end
end
assign ctt2_last_beat = src2_gnt & arb_last_beat;
assign cq_rd2_prdy = (ctt2_rdy & ctt2_last_beat) || !ctt2_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt2_vld <= 1'b0;
   end else begin
       if ((cq_rd2_prdy) == 1'b1) begin
          ctt2_vld <= cq_rd2_pvld;
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt2_cnt <= {2{1'b0}};
   end else begin
    if (cq_rd2_pvld && cq_rd2_prdy) begin 
       ctt2_cnt <= 0;
    end else if (ctt2_accept) begin
       ctt2_cnt <= ctt2_cnt + 1;
    end
   end
end
assign ctt2_accept = ctt2_vld & ctt2_rdy;
always @(posedge nvdla_core_clk) begin
   if (cq_rd2_pvld && cq_rd2_prdy) begin
      ctt2_cq_pd <= cq_rd2_pd;
   end
end
assign ctt3_last_beat = src3_gnt & arb_last_beat;
assign cq_rd3_prdy = (ctt3_rdy & ctt3_last_beat) || !ctt3_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt3_vld <= 1'b0;
   end else begin
       if ((cq_rd3_prdy) == 1'b1) begin
          ctt3_vld <= cq_rd3_pvld;
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt3_cnt <= {2{1'b0}};
   end else begin
    if (cq_rd3_pvld && cq_rd3_prdy) begin 
       ctt3_cnt <= 0;
    end else if (ctt3_accept) begin
       ctt3_cnt <= ctt3_cnt + 1;
    end
   end
end
assign ctt3_accept = ctt3_vld & ctt3_rdy;
always @(posedge nvdla_core_clk) begin
   if (cq_rd3_pvld && cq_rd3_prdy) begin
      ctt3_cq_pd <= cq_rd3_pd;
   end
end
assign ctt4_last_beat = src4_gnt & arb_last_beat;
assign cq_rd4_prdy = (ctt4_rdy & ctt4_last_beat) || !ctt4_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt4_vld <= 1'b0;
   end else begin
       if ((cq_rd4_prdy) == 1'b1) begin
          ctt4_vld <= cq_rd4_pvld;
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt4_cnt <= {2{1'b0}};
   end else begin
    if (cq_rd4_pvld && cq_rd4_prdy) begin 
       ctt4_cnt <= 0;
    end else if (ctt4_accept) begin
       ctt4_cnt <= ctt4_cnt + 1;
    end
   end
end
assign ctt4_accept = ctt4_vld & ctt4_rdy;
always @(posedge nvdla_core_clk) begin
   if (cq_rd4_pvld && cq_rd4_prdy) begin
      ctt4_cq_pd <= cq_rd4_pd;
   end
end
assign ctt5_last_beat = src5_gnt & arb_last_beat;
assign cq_rd5_prdy = (ctt5_rdy & ctt5_last_beat) || !ctt5_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt5_vld <= 1'b0;
   end else begin
       if ((cq_rd5_prdy) == 1'b1) begin
          ctt5_vld <= cq_rd5_pvld;
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt5_cnt <= {2{1'b0}};
   end else begin
    if (cq_rd5_pvld && cq_rd5_prdy) begin 
       ctt5_cnt <= 0;
    end else if (ctt5_accept) begin
       ctt5_cnt <= ctt5_cnt + 1;
    end
   end
end
assign ctt5_accept = ctt5_vld & ctt5_rdy;
always @(posedge nvdla_core_clk) begin
   if (cq_rd5_pvld && cq_rd5_prdy) begin
      ctt5_cq_pd <= cq_rd5_pd;
   end
end
assign ctt6_last_beat = src6_gnt & arb_last_beat;
assign cq_rd6_prdy = (ctt6_rdy & ctt6_last_beat) || !ctt6_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt6_vld <= 1'b0;
   end else begin
       if ((cq_rd6_prdy) == 1'b1) begin
          ctt6_vld <= cq_rd6_pvld;
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
      ctt6_cnt <= {2{1'b0}};
   end else begin
    if (cq_rd6_pvld && cq_rd6_prdy) begin 
       ctt6_cnt <= 0;
    end else if (ctt6_accept) begin
       ctt6_cnt <= ctt6_cnt + 1;
    end
   end
end
assign ctt6_accept = ctt6_vld & ctt6_rdy;
always @(posedge nvdla_core_clk) begin
   if (cq_rd6_pvld && cq_rd6_prdy) begin
      ctt6_cq_pd <= cq_rd6_pd;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
module NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,ipipe_axi_rdy
  ,noc2mcif_axi_r_pd
  ,noc2mcif_axi_r_rvalid
  ,ipipe_axi_pd
  ,ipipe_axi_vld
  ,noc2mcif_axi_r_rready
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input ipipe_axi_rdy;
input [64 +3:0] noc2mcif_axi_r_pd;
input noc2mcif_axi_r_rvalid;
output [64 +3:0] ipipe_axi_pd;
output ipipe_axi_vld;
output noc2mcif_axi_r_rready;
reg [64 +3:0] ipipe_axi_pd;
reg ipipe_axi_vld;
reg noc2mcif_axi_r_rready;
reg [64 +3:0] p1_pipe_data;
reg p1_pipe_ready;
reg p1_pipe_ready_bc;
reg [64 +3:0] p1_pipe_skid_data;
reg p1_pipe_skid_ready;
reg p1_pipe_skid_valid;
reg p1_pipe_valid;
reg p1_skid_catch;
reg [64 +3:0] p1_skid_data;
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
  p1_pipe_valid <= (p1_pipe_ready_bc)? noc2mcif_axi_r_rvalid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p1_pipe_data <= (p1_pipe_ready_bc && noc2mcif_axi_r_rvalid)? noc2mcif_axi_r_pd[64 +3:0] : p1_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p1_pipe_ready_bc
  ) begin
  noc2mcif_axi_r_rready = p1_pipe_ready_bc;
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
  or ipipe_axi_rdy
  or p1_pipe_skid_data
  ) begin
  ipipe_axi_vld = p1_pipe_skid_valid;
  p1_pipe_skid_ready = ipipe_axi_rdy;
  ipipe_axi_pd = p1_pipe_skid_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (ipipe_axi_vld^ipipe_axi_rdy^noc2mcif_axi_r_rvalid^noc2mcif_axi_r_rready)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_12x (nvdla_core_clk, `ASSERT_RESET, (noc2mcif_axi_r_rvalid && !noc2mcif_axi_r_rready), (noc2mcif_axi_r_rvalid), (noc2mcif_axi_r_rready)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule
module NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,rd_rsp_rdy
  ,dma_pd
  ,dma_vld
  ,rd_rsp_pd
  ,rd_rsp_valid
  ,dma_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input rd_rsp_rdy;
input [64 +(( 64 )/8/8)-1:0] dma_pd;
input dma_vld;
output [64 +(( 64 )/8/8)-1:0] rd_rsp_pd;
output rd_rsp_valid;
output dma_rdy;
reg [64 +(( 64 )/8/8)-1:0] rd_rsp_pd;
reg rd_rsp_valid;
reg dma_rdy;
reg [64 +(( 64 )/8/8)-1:0] p2_pipe_data;
reg p2_pipe_ready;
reg p2_pipe_ready_bc;
reg p2_pipe_valid;
reg p2_skid_catch;
reg [64 +(( 64 )/8/8)-1:0] p2_skid_data;
reg [64 +(( 64 )/8/8)-1:0] p2_skid_pipe_data;
reg p2_skid_pipe_ready;
reg p2_skid_pipe_valid;
reg p2_skid_ready;
reg p2_skid_ready_flop;
reg p2_skid_valid;
//## pipe (2) skid buffer
always @(
  dma_vld
  or p2_skid_ready_flop
  or p2_skid_pipe_ready
  or p2_skid_valid
  ) begin
  p2_skid_catch = dma_vld && p2_skid_ready_flop && !p2_skid_pipe_ready;
  p2_skid_ready = (p2_skid_valid)? p2_skid_pipe_ready : !p2_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p2_skid_valid <= 1'b0;
    p2_skid_ready_flop <= 1'b1;
    dma_rdy <= 1'b1;
  end else begin
  p2_skid_valid <= (p2_skid_valid)? !p2_skid_pipe_ready : p2_skid_catch;
  p2_skid_ready_flop <= p2_skid_ready;
  dma_rdy <= p2_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p2_skid_data <= (p2_skid_catch)? dma_pd[64 +(( 64 )/8/8)-1:0] : p2_skid_data;
// VCS sop_coverage_off end
end
always @(
  p2_skid_ready_flop
  or dma_vld
  or p2_skid_valid
  or dma_pd
  or p2_skid_data
  ) begin
  p2_skid_pipe_valid = (p2_skid_ready_flop)? dma_vld : p2_skid_valid;
// VCS sop_coverage_off start
  p2_skid_pipe_data = (p2_skid_ready_flop)? dma_pd[64 +(( 64 )/8/8)-1:0] : p2_skid_data;
// VCS sop_coverage_off end
end
//## pipe (2) valid-ready-bubble-collapse
always @(
  p2_pipe_ready
  or p2_pipe_valid
  ) begin
  p2_pipe_ready_bc = p2_pipe_ready || !p2_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p2_pipe_valid <= 1'b0;
  end else begin
  p2_pipe_valid <= (p2_pipe_ready_bc)? p2_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p2_pipe_data <= (p2_pipe_ready_bc && p2_skid_pipe_valid)? p2_skid_pipe_data : p2_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p2_pipe_ready_bc
  ) begin
  p2_skid_pipe_ready = p2_pipe_ready_bc;
end
//## pipe (2) output
always @(
  p2_pipe_valid
  or rd_rsp_rdy
  or p2_pipe_data
  ) begin
  rd_rsp_valid = p2_pipe_valid;
  p2_pipe_ready = rd_rsp_rdy;
  rd_rsp_pd = p2_pipe_data;
end
//## pipe (2) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p2_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_13x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (rd_rsp_valid^rd_rsp_rdy^dma_vld^dma_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_14x (nvdla_core_clk, `ASSERT_RESET, (dma_vld && !dma_rdy), (dma_vld), (dma_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_NOCIF_DRAM_READ_EG_pipe_p2
//
// AUTOMATICALLY GENERATED -- DO NOT EDIT OR CHECK IN
//
// /home/nvtools/engr/2017/03/11_05_00_06/nvtools/scripts/fifogen
// fifogen -input_config_yaml ../../../../../../../socd/ip_chip_tools/1.0/defs/public/fifogen/golden/tlit5/fifogen.yml -no_make_ram -no_make_ram -stdout -m NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo -clk_name nvdla_core_clk -reset_name nvdla_core_rstn -wr_pipebus rq_wr -rd_pipebus rq_rd -d 4 -w 64 -ram ff [Chosen ram type: ff - fifogen_flops (user specified, thus no other ram type is allowed)]
// chip config vars: assertion_module_prefix=nv_ strict_synchronizers=1 strict_synchronizers_use_lib_cells=1 strict_synchronizers_use_tm_lib_cells=1 strict_sync_randomizer=1 assertion_message_prefix=FIFOGEN_ASSERTION allow_async_fifola=0 ignore_ramgen_fifola_variant=1 uses_p_SSYNC=0 uses_prand=1 uses_rammake_inc=1 use_x_or_0=1 force_wr_reg_gated=1 no_force_reset=1 no_timescale=1 no_pli_ifdef=1 requires_full_throughput=1 ram_auto_ff_bits_cutoff=16 ram_auto_ff_width_cutoff=2 ram_auto_ff_width_cutoff_max_depth=32 ram_auto_ff_depth_cutoff=-1 ram_auto_ff_no_la2_depth_cutoff=5 ram_auto_la2_width_cutoff=8 ram_auto_la2_width_cutoff_max_depth=56 ram_auto_la2_depth_cutoff=16 flopram_emu_model=1 dslp_single_clamp_port=1 dslp_clamp_port=1 slp_single_clamp_port=1 slp_clamp_port=1 master_clk_gated=1 clk_gate_module=NV_CLK_gate_power redundant_timing_flops=0 hot_reset_async_force_ports_and_loopback=1 ram_sleep_en_width=1 async_cdc_reg_id=NV_AFIFO_ rd_reg_default_for_async=1 async_ram_instance_prefix=NV_ASYNC_RAM_ allow_rd_busy_reg_warning=0 do_dft_xelim_gating=1 add_dft_xelim_wr_clkgate=1 add_dft_xelim_rd_clkgate=1
//
// leda B_3208_NV OFF -- Unequal length LHS and RHS in assignment
// leda B_1405 OFF -- 2 asynchronous resets in this unit detected
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
module NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo (
      nvdla_core_clk
    , nvdla_core_rstn
    , rq_wr_prdy
    , rq_wr_pvld
`ifdef FV_RAND_WR_PAUSE
    , rq_wr_pause
`endif
    , rq_wr_pd
    , rq_rd_prdy
    , rq_rd_pvld
    , rq_rd_pd
    , pwrbus_ram_pd
    );
// spyglass disable_block W401 -- clock is not input to module
input nvdla_core_clk;
input nvdla_core_rstn;
output rq_wr_prdy;
input rq_wr_pvld;
`ifdef FV_RAND_WR_PAUSE
input rq_wr_pause;
`endif
input [64 -1:0] rq_wr_pd;
input rq_rd_prdy;
output rq_rd_pvld;
output [64 -1:0] rq_rd_pd;
input [31:0] pwrbus_ram_pd;
// Master Clock Gating (SLCG)
//
// We gate the clock(s) when idle or stalled.
// This allows us to turn off numerous miscellaneous flops
// that don't get gated during synthesis for one reason or another.
//
// We gate write side and read side separately.
// If the fifo is synchronous, we also gate the ram separately, but if
// -master_clk_gated_unified or -status_reg/-status_logic_reg is specified,
// then we use one clk gate for write, ram, and read.
//
wire nvdla_core_clk_mgated_enable; // assigned by code at end of this module
wire nvdla_core_clk_mgated; // used only in synchronous fifos
NV_CLK_gate_power nvdla_core_clk_mgate( .clk(nvdla_core_clk), .reset_(nvdla_core_rstn), .clk_en(nvdla_core_clk_mgated_enable), .clk_gated(nvdla_core_clk_mgated) );
//
// WRITE SIDE
//
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
wire wr_pause_rand; // random stalling
`endif
`endif
// synopsys translate_on
wire wr_reserving;
reg rq_wr_busy_int; // copy for internal use
assign rq_wr_prdy = !rq_wr_busy_int;
assign wr_reserving = rq_wr_pvld && !rq_wr_busy_int; // reserving write space?
wire wr_popping; // fwd: write side sees pop?
reg [2:0] rq_wr_count; // write-side count
wire [2:0] wr_count_next_wr_popping = wr_reserving ? rq_wr_count : (rq_wr_count - 1'd1); // spyglass disable W164a W484
wire [2:0] wr_count_next_no_wr_popping = wr_reserving ? (rq_wr_count + 1'd1) : rq_wr_count; // spyglass disable W164a W484
wire [2:0] wr_count_next = wr_popping ? wr_count_next_wr_popping :
                                               wr_count_next_no_wr_popping;
wire wr_count_next_no_wr_popping_is_4 = ( wr_count_next_no_wr_popping == 3'd4 );
wire wr_count_next_is_4 = wr_popping ? 1'b0 :
                                          wr_count_next_no_wr_popping_is_4;
wire [2:0] wr_limit_muxed; // muxed with simulation/emulation overrides
wire [2:0] wr_limit_reg = wr_limit_muxed;
`ifdef FV_RAND_WR_PAUSE
// VCS coverage off
wire rq_wr_busy_next = wr_count_next_is_4 || // busy next cycle?
                          (wr_limit_reg != 3'd0 && // check rq_wr_limit if != 0
                           wr_count_next >= wr_limit_reg) || rq_wr_pause;
// VCS coverage on
`else
// VCS coverage off
wire rq_wr_busy_next = wr_count_next_is_4 || // busy next cycle?
                          (wr_limit_reg != 3'd0 && // check rq_wr_limit if != 0
                           wr_count_next >= wr_limit_reg)
// synopsys translate_off
  `ifndef SYNTH_LEVEL1_COMPILE
  `ifndef SYNTHESIS
 || wr_pause_rand
  `endif
  `endif
// synopsys translate_on
;
// VCS coverage on
`endif
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        rq_wr_busy_int <= 1'b0;
        rq_wr_count <= 3'd0;
    end else begin
 rq_wr_busy_int <= rq_wr_busy_next;
 if ( wr_reserving ^ wr_popping ) begin
     rq_wr_count <= wr_count_next;
        end
//synopsys translate_off
            else if ( !(wr_reserving ^ wr_popping) ) begin
        end else begin
            rq_wr_count <= {3{`x_or_0}};
        end
//synopsys translate_on
    end
end
wire wr_pushing = wr_reserving; // data pushed same cycle as rq_wr_pvld
//
// RAM
//
reg [1:0] rq_wr_adr; // current write address
// spyglass disable_block W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        rq_wr_adr <= 2'd0;
    end else begin
        if ( wr_pushing ) begin
     rq_wr_adr <= rq_wr_adr + 1'd1;
        end
    end
end
// spyglass enable_block W484
reg [1:0] rq_rd_adr; // read address this cycle
wire ram_we = wr_pushing; // note: write occurs next cycle
wire [64 -1:0] rq_rd_pd; // read data out of ram
wire [31 : 0] pwrbus_ram_pd;
// Adding parameter for fifogen to disable wr/rd contention assertion in ramgen.
// Fifogen handles this by ignoring the data on the ram data out for that cycle.
NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH ram (
      .clk( nvdla_core_clk_mgated )
    , .pwrbus_ram_pd ( pwrbus_ram_pd )
    , .di ( rq_wr_pd )
    , .we ( ram_we )
    , .wa ( rq_wr_adr )
    , .ra ( rq_rd_adr )
    , .dout ( rq_rd_pd )
    );
wire rd_popping; // read side doing pop this cycle?
wire [1:0] rd_adr_next_popping = rq_rd_adr + 1'd1; // spyglass disable W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        rq_rd_adr <= 2'd0;
    end else begin
        if ( rd_popping ) begin
     rq_rd_adr <= rd_adr_next_popping;
        end
//synopsys translate_off
            else if ( !rd_popping ) begin
        end else begin
            rq_rd_adr <= {2{`x_or_0}};
        end
//synopsys translate_on
    end
end
//
// SYNCHRONOUS BOUNDARY
//
assign wr_popping = rd_popping; // let it be seen immediately
wire rd_pushing = wr_pushing; // let it be seen immediately
//
// READ SIDE
//
reg rq_rd_pvld; // data out of fifo is valid
reg rq_rd_pvld_int; // internal copy of rq_rd_pvld
assign rd_popping = rq_rd_pvld_int && rq_rd_prdy;
reg [2:0] rq_rd_count; // read-side fifo count
// spyglass disable_block W164a W484
wire [2:0] rd_count_next_rd_popping = rd_pushing ? rq_rd_count :
                                                                (rq_rd_count - 1'd1);
wire [2:0] rd_count_next_no_rd_popping = rd_pushing ? (rq_rd_count + 1'd1) :
                                                                    rq_rd_count;
// spyglass enable_block W164a W484
wire [2:0] rd_count_next = rd_popping ? rd_count_next_rd_popping :
                                                     rd_count_next_no_rd_popping;
wire rd_count_next_rd_popping_not_0 = rd_count_next_rd_popping != 0;
wire rd_count_next_no_rd_popping_not_0 = rd_count_next_no_rd_popping != 0;
wire rd_count_next_not_0 = rd_popping ? rd_count_next_rd_popping_not_0 :
                                              rd_count_next_no_rd_popping_not_0;
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        rq_rd_count <= 3'd0;
        rq_rd_pvld <= 1'b0;
        rq_rd_pvld_int <= 1'b0;
    end else begin
        if ( rd_pushing || rd_popping ) begin
     rq_rd_count <= rd_count_next;
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            rq_rd_count <= {3{`x_or_0}};
        end
//synopsys translate_on
        if ( rd_pushing || rd_popping ) begin
     rq_rd_pvld <= (rd_count_next_not_0);
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            rq_rd_pvld <= `x_or_0;
        end
//synopsys translate_on
        if ( rd_pushing || rd_popping ) begin
     rq_rd_pvld_int <= (rd_count_next_not_0);
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            rq_rd_pvld_int <= `x_or_0;
        end
//synopsys translate_on
    end
end
// Master Clock Gating (SLCG) Enables
//
// plusarg for disabling this stuff:
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg master_clk_gating_disabled; initial master_clk_gating_disabled = $test$plusargs( "fifogen_disable_master_clk_gating" ) != 0;
`endif
`endif
// synopsys translate_on
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg wr_pause_rand_dly;
always @( posedge nvdla_core_clk or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        wr_pause_rand_dly <= 1'b0;
    end else begin
        wr_pause_rand_dly <= wr_pause_rand;
    end
end
`endif
`endif
// synopsys translate_on
assign nvdla_core_clk_mgated_enable = ((wr_reserving || wr_pushing || wr_popping || (rq_wr_pvld && !rq_wr_busy_int) || (rq_wr_busy_int != rq_wr_busy_next)) || (rd_pushing || rd_popping || (rq_rd_pvld && rq_rd_prdy)) || (wr_pushing))
                               `ifdef FIFOGEN_MASTER_CLK_GATING_DISABLED
                               || 1'b1
                               `endif
// synopsys translate_off
          `ifndef SYNTH_LEVEL1_COMPILE
          `ifndef SYNTHESIS
                               || master_clk_gating_disabled || (wr_pause_rand != wr_pause_rand_dly)
          `endif
          `endif
// synopsys translate_on
                               ;
// Simulation and Emulation Overrides of wr_limit(s)
//
`ifdef EMU
`ifdef EMU_FIFO_CFG
// Emulation Global Config Override
//
assign wr_limit_muxed = `EMU_FIFO_CFG.NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_wr_limit_override ? `EMU_FIFO_CFG.NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_wr_limit : 3'd0;
`else
// No Global Override for Emulation
//
assign wr_limit_muxed = 3'd0;
`endif // EMU_FIFO_CFG
`else // !EMU
`ifdef SYNTH_LEVEL1_COMPILE
// No Override for GCS Compiles
//
assign wr_limit_muxed = 3'd0;
`else
`ifdef SYNTHESIS
// No Override for RTL Synthesis
//
assign wr_limit_muxed = 3'd0;
`else
// RTL Simulation Plusarg Override
// VCS coverage off
reg wr_limit_override;
reg [2:0] wr_limit_override_value;
assign wr_limit_muxed = wr_limit_override ? wr_limit_override_value : 3'd0;
`ifdef NV_ARCHPRO
event reinit;
initial begin
    $display("fifogen reinit initial block %m");
    -> reinit;
end
`endif
`ifdef NV_ARCHPRO
always @( reinit ) begin
`else
initial begin
`endif
    wr_limit_override = 0;
    wr_limit_override_value = 0; // to keep viva happy with dangles
    if ( $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_wr_limit" ) ) begin
        wr_limit_override = 1;
        $value$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_wr_limit=%d", wr_limit_override_value);
    end
end
// VCS coverage on
`endif
`endif
`endif
// Random Write-Side Stalling
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
// VCS coverage off
// leda W339 OFF -- Non synthesizable operator
// leda W372 OFF -- Undefined PLI task
// leda W373 OFF -- Undefined PLI function
// leda W599 OFF -- This construct is not supported by Synopsys
// leda W430 OFF -- Initial statement is not synthesizable
// leda W182 OFF -- Illegal statement for synthesis
// leda W639 OFF -- For synthesis, operands of a division or modulo operation need to be constants
// leda DCVER_274_NV OFF -- This system task is not supported by DC
integer stall_probability; // prob of stalling
integer stall_cycles_min; // min cycles to stall
integer stall_cycles_max; // max cycles to stall
integer stall_cycles_left; // stall cycles left
`ifdef NV_ARCHPRO
always @( reinit ) begin
`else
initial begin
`endif
    stall_probability = 0; // no stalling by default
    stall_cycles_min = 1;
    stall_cycles_max = 10;
`ifdef NO_PLI
`else
    if ( $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_probability" ) ) begin
        $value$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_probability=%d", stall_probability);
    end else if ( $test$plusargs( "default_fifo_stall_probability" ) ) begin
        $value$plusargs( "default_fifo_stall_probability=%d", stall_probability);
    end
    if ( $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_cycles_min" ) ) begin
        $value$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_cycles_min=%d", stall_cycles_min);
    end else if ( $test$plusargs( "default_fifo_stall_cycles_min" ) ) begin
        $value$plusargs( "default_fifo_stall_cycles_min=%d", stall_cycles_min);
    end
    if ( $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_cycles_max" ) ) begin
        $value$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_cycles_max=%d", stall_cycles_max);
    end else if ( $test$plusargs( "default_fifo_stall_cycles_max" ) ) begin
        $value$plusargs( "default_fifo_stall_cycles_max=%d", stall_cycles_max);
    end
`endif
    if ( stall_cycles_min < 1 ) begin
        stall_cycles_min = 1;
    end
    if ( stall_cycles_min > stall_cycles_max ) begin
        stall_cycles_max = stall_cycles_min;
    end
end
`ifdef NO_PLI
`else
// randomization globals
`ifdef SIMTOP_RANDOMIZE_STALLS
  always @( `SIMTOP_RANDOMIZE_STALLS.global_stall_event ) begin
    if ( ! $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_probability" ) ) stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_probability;
    if ( ! $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_cycles_min" ) ) stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_cycles_min;
    if ( ! $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_fifo_stall_cycles_max" ) ) stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_cycles_max;
  end
`endif
`endif
always @( negedge nvdla_core_clk or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        stall_cycles_left <= 0;
    end else begin
`ifdef NO_PLI
            stall_cycles_left <= 0;
`else
            if ( rq_wr_pvld && !(!rq_wr_prdy)
                 && stall_probability != 0 ) begin
                if ( prand_inst0(1, 100) <= stall_probability ) begin
                    stall_cycles_left <= prand_inst1(stall_cycles_min, stall_cycles_max);
                end else if ( stall_cycles_left !== 0 ) begin
                    stall_cycles_left <= stall_cycles_left - 1;
                end
            end else if ( stall_cycles_left !== 0 ) begin
                stall_cycles_left <= stall_cycles_left - 1;
            end
`endif
    end
end
assign wr_pause_rand = (stall_cycles_left !== 0) ;
// VCS coverage on
`endif
`endif
// synopsys translate_on
// VCS coverage on
// leda W339 ON
// leda W372 ON
// leda W373 ON
// leda W599 ON
// leda W430 ON
// leda W182 ON
// leda W639 ON
// leda DCVER_274_NV ON
//
// Histogram of fifo depth (from write side's perspective)
//
// NOTE: it will reference `SIMTOP.perfmon_enabled, so that
// has to at least be defined, though not initialized.
// tbgen testbenches have it already and various
// ways to turn it on and off.
//
`ifdef PERFMON_HISTOGRAM
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
perfmon_histogram perfmon (
      .clk ( nvdla_core_clk )
    , .max ( {29'd0, (wr_limit_reg == 3'd0) ? 3'd4 : wr_limit_reg} )
    , .curr ( {29'd0, rq_wr_count} )
    );
`endif
`endif
// synopsys translate_on
`endif
// spyglass disable_block W164a W164b W116 W484 W504
`ifdef SPYGLASS
`else
`ifdef FV_ASSERT_ON
`else
// synopsys translate_off
`endif
`ifdef ASSERT_ON
`ifdef SPYGLASS
wire disable_assert_plusarg = 1'b0;
`else
`ifdef FV_ASSERT_ON
wire disable_assert_plusarg = 1'b0;
`else
wire disable_assert_plusarg = $test$plusargs("DISABLE_NESS_FLOW_ASSERTIONS");
`endif
`endif
wire assert_enabled = 1'b1 && !disable_assert_plusarg;
`endif
`ifdef FV_ASSERT_ON
`else
// synopsys translate_on
`endif
`ifdef ASSERT_ON
//synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
always @(assert_enabled) begin
    if ( assert_enabled === 1'b0 ) begin
        $display("Asserts are disabled for %m");
    end
end
`endif
`endif
//synopsys translate_on
`endif
`endif
// spyglass enable_block W164a W164b W116 W484 W504
//The NV_BLKBOX_SRC0 module is only present when the FIFOGEN_MODULE_SEARCH
// define is set. This is to aid fifogen team search for fifogen fifo
// instance and module names in a given design.
`ifdef FIFOGEN_MODULE_SEARCH
NV_BLKBOX_SRC0 dummy_breadcrumb_fifogen_blkbox (.Y());
`endif
// spyglass enable_block W401 -- clock is not input to module
// synopsys dc_script_begin
// set_boundary_optimization find(design, "NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo") true
// synopsys dc_script_end
`ifdef SYNTH_LEVEL1_COMPILE
`else
`ifdef SYNTHESIS
`else
`ifdef PRAND_VERILOG
// Only verilog needs any local variables
reg [47:0] prand_local_seed0;
reg prand_initialized0;
reg prand_no_rollpli0;
`endif
`endif
`endif
function [31:0] prand_inst0;
//VCS coverage off
    input [31:0] min;
    input [31:0] max;
    reg [32:0] diff;
    begin
`ifdef SYNTH_LEVEL1_COMPILE
        prand_inst0 = min;
`else
`ifdef SYNTHESIS
        prand_inst0 = min;
`else
`ifdef PRAND_VERILOG
        if (prand_initialized0 !== 1'b1) begin
            prand_no_rollpli0 = $test$plusargs("NO_ROLLPLI");
            if (!prand_no_rollpli0)
                prand_local_seed0 = {$prand_get_seed(0), 16'b0};
            prand_initialized0 = 1'b1;
        end
        if (prand_no_rollpli0) begin
            prand_inst0 = min;
        end else begin
            diff = max - min + 1;
            prand_inst0 = min + prand_local_seed0[47:16] % diff;
// magic numbers taken from Java's random class (same as lrand48)
            prand_local_seed0 = prand_local_seed0 * 48'h5deece66d + 48'd11;
        end
`else
`ifdef PRAND_OFF
        prand_inst0 = min;
`else
        prand_inst0 = $RollPLI(min, max, "auto");
`endif
`endif
`endif
`endif
    end
//VCS coverage on
endfunction
`ifdef SYNTH_LEVEL1_COMPILE
`else
`ifdef SYNTHESIS
`else
`ifdef PRAND_VERILOG
// Only verilog needs any local variables
reg [47:0] prand_local_seed1;
reg prand_initialized1;
reg prand_no_rollpli1;
`endif
`endif
`endif
function [31:0] prand_inst1;
//VCS coverage off
    input [31:0] min;
    input [31:0] max;
    reg [32:0] diff;
    begin
`ifdef SYNTH_LEVEL1_COMPILE
        prand_inst1 = min;
`else
`ifdef SYNTHESIS
        prand_inst1 = min;
`else
`ifdef PRAND_VERILOG
        if (prand_initialized1 !== 1'b1) begin
            prand_no_rollpli1 = $test$plusargs("NO_ROLLPLI");
            if (!prand_no_rollpli1)
                prand_local_seed1 = {$prand_get_seed(1), 16'b0};
            prand_initialized1 = 1'b1;
        end
        if (prand_no_rollpli1) begin
            prand_inst1 = min;
        end else begin
            diff = max - min + 1;
            prand_inst1 = min + prand_local_seed1[47:16] % diff;
// magic numbers taken from Java's random class (same as lrand48)
            prand_local_seed1 = prand_local_seed1 * 48'h5deece66d + 48'd11;
        end
`else
`ifdef PRAND_OFF
        prand_inst1 = min;
`else
        prand_inst1 = $RollPLI(min, max, "auto");
`endif
`endif
`endif
`endif
    end
//VCS coverage on
endfunction
endmodule // NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo
//
// Flop-Based RAM
//
module NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH (
      clk
    , pwrbus_ram_pd
    , di
    , we
    , wa
    , ra
    , dout
    );
input clk; // write clock
input [31 : 0] pwrbus_ram_pd;
input [64 -1:0] di;
input we;
input [1:0] wa;
input [1:0] ra;
output [64 -1:0] dout;
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_0 (.A(pwrbus_ram_pd[0]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_1 (.A(pwrbus_ram_pd[1]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_2 (.A(pwrbus_ram_pd[2]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_3 (.A(pwrbus_ram_pd[3]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_4 (.A(pwrbus_ram_pd[4]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_5 (.A(pwrbus_ram_pd[5]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_6 (.A(pwrbus_ram_pd[6]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_7 (.A(pwrbus_ram_pd[7]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_8 (.A(pwrbus_ram_pd[8]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_9 (.A(pwrbus_ram_pd[9]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_10 (.A(pwrbus_ram_pd[10]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_11 (.A(pwrbus_ram_pd[11]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_12 (.A(pwrbus_ram_pd[12]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_13 (.A(pwrbus_ram_pd[13]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_14 (.A(pwrbus_ram_pd[14]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_15 (.A(pwrbus_ram_pd[15]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_16 (.A(pwrbus_ram_pd[16]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_17 (.A(pwrbus_ram_pd[17]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_18 (.A(pwrbus_ram_pd[18]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_19 (.A(pwrbus_ram_pd[19]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_20 (.A(pwrbus_ram_pd[20]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_21 (.A(pwrbus_ram_pd[21]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_22 (.A(pwrbus_ram_pd[22]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_23 (.A(pwrbus_ram_pd[23]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_24 (.A(pwrbus_ram_pd[24]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_25 (.A(pwrbus_ram_pd[25]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_26 (.A(pwrbus_ram_pd[26]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_27 (.A(pwrbus_ram_pd[27]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_28 (.A(pwrbus_ram_pd[28]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_29 (.A(pwrbus_ram_pd[29]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_30 (.A(pwrbus_ram_pd[30]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_31 (.A(pwrbus_ram_pd[31]));
`endif
`ifdef EMU
// we use an emulation ram here to save flops on the emulation board
// so that the monstrous chip can fit :-)
//
reg [1:0] Wa0_vmw;
reg we0_vmw;
reg [64 -1:0] Di0_vmw;
always @( posedge clk ) begin
    Wa0_vmw <= wa;
    we0_vmw <= we;
    Di0_vmw <= di;
end
vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH emu_ram (
     .Wa0( Wa0_vmw )
   , .we0( we0_vmw )
   , .Di0( Di0_vmw )
   , .Ra0( ra )
   , .Do0( dout )
   );
`else
reg [64 -1:0] ram_ff0;
reg [64 -1:0] ram_ff1;
reg [64 -1:0] ram_ff2;
reg [64 -1:0] ram_ff3;
always @( posedge clk ) begin
    if ( we && wa == 2'd0 ) begin
 ram_ff0 <= di;
    end
    if ( we && wa == 2'd1 ) begin
 ram_ff1 <= di;
    end
    if ( we && wa == 2'd2 ) begin
 ram_ff2 <= di;
    end
    if ( we && wa == 2'd3 ) begin
 ram_ff3 <= di;
    end
end
reg [64 -1:0] dout;
always @(*) begin
    case( ra )
    2'd0: dout = ram_ff0;
    2'd1: dout = ram_ff1;
    2'd2: dout = ram_ff2;
    2'd3: dout = ram_ff3;
//VCS coverage off
    default: dout = {64{`x_or_0}};
//VCS coverage on
    endcase
end
`endif // EMU
endmodule // NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH
// emulation model of flopram guts
//
`ifdef EMU
module vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH (
   Wa0, we0, Di0,
   Ra0, Do0
   );
input [1:0] Wa0;
input we0;
input [64 -1:0] Di0;
input [1:0] Ra0;
output [64 -1:0] Do0;
// Only visible during Spyglass to avoid blackboxes.
`ifdef SPYGLASS_FLOPRAM
assign Do0 = NVDLA_PRIMARY_MEMIF_WIDTH'd0;
wire dummy = 1'b0 | (|Wa0) | (|we0) | (|Di0) | (|Ra0);
`endif
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg [64 -1:0] mem[3:0];
// expand mem for debug ease
`ifdef EMU_EXPAND_FLOPRAM_MEM
wire [64 -1:0] Q0 = mem[0];
wire [64 -1:0] Q1 = mem[1];
wire [64 -1:0] Q2 = mem[2];
wire [64 -1:0] Q3 = mem[3];
`endif
// asynchronous ram writes
always @(*) begin
  if ( we0 == 1'b1 ) begin
    #0.1;
    mem[Wa0] = Di0;
  end
end
assign Do0 = mem[Ra0];
`endif
`endif
// synopsys translate_on
// synopsys dc_script_begin
// synopsys dc_script_end
// g2c if { [find / -null_ok -subdesign vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH] != {} } { set_attr preserve 1 [find / -subdesign vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xPRIMARY_MEMIF_WIDTH] }
endmodule // vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH
//vmw: Memory vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH
//vmw: Address-size 2
//vmw: Data-size 64
//vmw: Sensitivity level 1
//vmw: Ports W R
//vmw: terminal we0 WriteEnable0
//vmw: terminal Wa0 address0
//vmw: terminal Di0[64 -1:0] data0[PRIMARY_MEMIF_WIDTH-1:0]
//vmw:
//vmw: terminal Ra0 address1
//vmw: terminal Do0[64 -1:0] data1[PRIMARY_MEMIF_WIDTH-1:0]
//vmw:
//qt: CELL vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_lat_fifo_flopram_rwsa_4xNVDLA_PRIMARY_MEMIF_WIDTH
//qt: TERMINAL we0 TYPE=WE POLARITY=H PORT=1
//qt: TERMINAL Wa0[%d] TYPE=ADDRESS DIR=W BIT=%1 PORT=1
//qt: TERMINAL Di0[%d] TYPE=DATA DIR=I BIT=%1 PORT=1
//qt:
//qt: TERMINAL Ra0[%d] TYPE=ADDRESS DIR=R BIT=%1 PORT=1
//qt: TERMINAL Do0[%d] TYPE=DATA DIR=O BIT=%1 PORT=1
//qt:
`endif // EMU
//
// AUTOMATICALLY GENERATED -- DO NOT EDIT OR CHECK IN
//
// /home/nvtools/engr/2017/03/11_05_00_06/nvtools/scripts/fifogen
// fifogen -input_config_yaml ../../../../../../../socd/ip_chip_tools/1.0/defs/public/fifogen/golden/tlit5/fifogen.yml -no_make_ram -no_make_ram -stdout -m NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo -clk_name nvdla_core_clk -reset_name nvdla_core_rstn -wr_pipebus ro_wr -rd_pipebus ro_rd -d 4 -ram_bypass -rd_reg -rd_busy_reg -w 257 -ram ff [Chosen ram type: ff - fifogen_flops (user specified, thus no other ram type is allowed)]
// chip config vars: assertion_module_prefix=nv_ strict_synchronizers=1 strict_synchronizers_use_lib_cells=1 strict_synchronizers_use_tm_lib_cells=1 strict_sync_randomizer=1 assertion_message_prefix=FIFOGEN_ASSERTION allow_async_fifola=0 ignore_ramgen_fifola_variant=1 uses_p_SSYNC=0 uses_prand=1 uses_rammake_inc=1 use_x_or_0=1 force_wr_reg_gated=1 no_force_reset=1 no_timescale=1 no_pli_ifdef=1 requires_full_throughput=1 ram_auto_ff_bits_cutoff=16 ram_auto_ff_width_cutoff=2 ram_auto_ff_width_cutoff_max_depth=32 ram_auto_ff_depth_cutoff=-1 ram_auto_ff_no_la2_depth_cutoff=5 ram_auto_la2_width_cutoff=8 ram_auto_la2_width_cutoff_max_depth=56 ram_auto_la2_depth_cutoff=16 flopram_emu_model=1 dslp_single_clamp_port=1 dslp_clamp_port=1 slp_single_clamp_port=1 slp_clamp_port=1 master_clk_gated=1 clk_gate_module=NV_CLK_gate_power redundant_timing_flops=0 hot_reset_async_force_ports_and_loopback=1 ram_sleep_en_width=1 async_cdc_reg_id=NV_AFIFO_ rd_reg_default_for_async=1 async_ram_instance_prefix=NV_ASYNC_RAM_ allow_rd_busy_reg_warning=0 do_dft_xelim_gating=1 add_dft_xelim_wr_clkgate=1 add_dft_xelim_rd_clkgate=1
//
// leda B_3208_NV OFF -- Unequal length LHS and RHS in assignment
// leda B_1405 OFF -- 2 asynchronous resets in this unit detected
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
module NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo (
      nvdla_core_clk
    , nvdla_core_rstn
    , ro_wr_prdy
    , ro_wr_pvld
`ifdef FV_RAND_WR_PAUSE
    , ro_wr_pause
`endif
    , ro_wr_pd
    , ro_rd_prdy
    , ro_rd_pvld
    , ro_rd_pd
    , pwrbus_ram_pd
    );
// spyglass disable_block W401 -- clock is not input to module
input nvdla_core_clk;
input nvdla_core_rstn;
output ro_wr_prdy;
input ro_wr_pvld;
`ifdef FV_RAND_WR_PAUSE
input ro_wr_pause;
`endif
input [64/2:0] ro_wr_pd;
input ro_rd_prdy;
output ro_rd_pvld;
output [64/2:0] ro_rd_pd;
input [31:0] pwrbus_ram_pd;
// Master Clock Gating (SLCG)
//
// We gate the clock(s) when idle or stalled.
// This allows us to turn off numerous miscellaneous flops
// that don't get gated during synthesis for one reason or another.
//
// We gate write side and read side separately.
// If the fifo is synchronous, we also gate the ram separately, but if
// -master_clk_gated_unified or -status_reg/-status_logic_reg is specified,
// then we use one clk gate for write, ram, and read.
//
wire nvdla_core_clk_mgated_enable; // assigned by code at end of this module
wire nvdla_core_clk_mgated; // used only in synchronous fifos
NV_CLK_gate_power nvdla_core_clk_mgate( .clk(nvdla_core_clk), .reset_(nvdla_core_rstn), .clk_en(nvdla_core_clk_mgated_enable), .clk_gated(nvdla_core_clk_mgated) );
//
// WRITE SIDE
//
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
wire wr_pause_rand; // random stalling
`endif
`endif
// synopsys translate_on
wire wr_reserving;
reg ro_wr_busy_int; // copy for internal use
assign ro_wr_prdy = !ro_wr_busy_int;
assign wr_reserving = ro_wr_pvld && !ro_wr_busy_int; // reserving write space?
wire wr_popping; // fwd: write side sees pop?
reg [2:0] ro_wr_count; // write-side count
wire [2:0] wr_count_next_wr_popping = wr_reserving ? ro_wr_count : (ro_wr_count - 1'd1); // spyglass disable W164a W484
wire [2:0] wr_count_next_no_wr_popping = wr_reserving ? (ro_wr_count + 1'd1) : ro_wr_count; // spyglass disable W164a W484
wire [2:0] wr_count_next = wr_popping ? wr_count_next_wr_popping :
                                               wr_count_next_no_wr_popping;
wire wr_count_next_no_wr_popping_is_4 = ( wr_count_next_no_wr_popping == 3'd4 );
wire wr_count_next_is_4 = wr_popping ? 1'b0 :
                                          wr_count_next_no_wr_popping_is_4;
wire [2:0] wr_limit_muxed; // muxed with simulation/emulation overrides
wire [2:0] wr_limit_reg = wr_limit_muxed;
`ifdef FV_RAND_WR_PAUSE
// VCS coverage off
wire ro_wr_busy_next = wr_count_next_is_4 || // busy next cycle?
                          (wr_limit_reg != 3'd0 && // check ro_wr_limit if != 0
                           wr_count_next >= wr_limit_reg) || ro_wr_pause;
// VCS coverage on
`else
// VCS coverage off
wire ro_wr_busy_next = wr_count_next_is_4 || // busy next cycle?
                          (wr_limit_reg != 3'd0 && // check ro_wr_limit if != 0
                           wr_count_next >= wr_limit_reg)
// synopsys translate_off
  `ifndef SYNTH_LEVEL1_COMPILE
  `ifndef SYNTHESIS
 || wr_pause_rand
  `endif
  `endif
// synopsys translate_on
;
// VCS coverage on
`endif
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        ro_wr_busy_int <= 1'b0;
        ro_wr_count <= 3'd0;
    end else begin
 ro_wr_busy_int <= ro_wr_busy_next;
 if ( wr_reserving ^ wr_popping ) begin
     ro_wr_count <= wr_count_next;
        end
//synopsys translate_off
            else if ( !(wr_reserving ^ wr_popping) ) begin
        end else begin
            ro_wr_count <= {3{`x_or_0}};
        end
//synopsys translate_on
    end
end
wire wr_pushing = wr_reserving; // data pushed same cycle as ro_wr_pvld
//
// RAM
//
reg [1:0] ro_wr_adr; // current write address
// spyglass disable_block W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        ro_wr_adr <= 2'd0;
    end else begin
        if ( wr_pushing ) begin
     ro_wr_adr <= ro_wr_adr + 1'd1;
        end
    end
end
// spyglass enable_block W484
wire rd_popping;
reg [1:0] ro_rd_adr; // read address this cycle
wire ram_we = wr_pushing && (ro_wr_count > 3'd0 || !rd_popping); // note: write occurs next cycle
wire [64/2:0] ro_rd_pd_p; // read data out of ram
wire [31 : 0] pwrbus_ram_pd;
// Adding parameter for fifogen to disable wr/rd contention assertion in ramgen.
// Fifogen handles this by ignoring the data on the ram data out for that cycle.
NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257 ram (
      .clk( nvdla_core_clk_mgated )
    , .pwrbus_ram_pd ( pwrbus_ram_pd )
    , .di ( ro_wr_pd )
    , .we ( ram_we )
    , .wa ( ro_wr_adr )
    , .ra ( (ro_wr_count == 0) ? 3'd4 : {1'b0,ro_rd_adr} )
    , .dout ( ro_rd_pd_p )
    );
wire [1:0] rd_adr_next_popping = ro_rd_adr + 1'd1; // spyglass disable W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        ro_rd_adr <= 2'd0;
    end else begin
        if ( rd_popping ) begin
     ro_rd_adr <= rd_adr_next_popping;
        end
//synopsys translate_off
            else if ( !rd_popping ) begin
        end else begin
            ro_rd_adr <= {2{`x_or_0}};
        end
//synopsys translate_on
    end
end
//
// SYNCHRONOUS BOUNDARY
//
assign wr_popping = rd_popping; // let it be seen immediately
wire rd_pushing = wr_pushing; // let it be seen immediately
//
// READ SIDE
//
reg ro_rd_prdy_d; // ro_rd_prdy registered in cleanly
always @( posedge nvdla_core_clk or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        ro_rd_prdy_d <= 1'b1;
    end else begin
        ro_rd_prdy_d <= ro_rd_prdy;
    end
end
wire ro_rd_prdy_d_o; // combinatorial rd_busy
reg ro_rd_pvld_int; // internal copy of ro_rd_pvld
assign ro_rd_pvld = ro_rd_pvld_int;
wire ro_rd_pvld_p; // data out of fifo is valid
reg ro_rd_pvld_int_o; // internal copy of ro_rd_pvld_o
wire ro_rd_pvld_o = ro_rd_pvld_int_o;
assign rd_popping = ro_rd_pvld_p && !(ro_rd_pvld_int_o && !ro_rd_prdy_d_o);
reg [2:0] ro_rd_count_p; // read-side fifo count
// spyglass disable_block W164a W484
wire [2:0] rd_count_p_next_rd_popping = rd_pushing ? ro_rd_count_p :
                                                                (ro_rd_count_p - 1'd1);
wire [2:0] rd_count_p_next_no_rd_popping = rd_pushing ? (ro_rd_count_p + 1'd1) :
                                                                    ro_rd_count_p;
// spyglass enable_block W164a W484
wire [2:0] rd_count_p_next = rd_popping ? rd_count_p_next_rd_popping :
                                                     rd_count_p_next_no_rd_popping;
assign ro_rd_pvld_p = ro_rd_count_p != 0 || rd_pushing;
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        ro_rd_count_p <= 3'd0;
    end else begin
        if ( rd_pushing || rd_popping ) begin
     ro_rd_count_p <= rd_count_p_next;
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            ro_rd_count_p <= {3{`x_or_0}};
        end
//synopsys translate_on
    end
end
//
// SKID for -rd_busy_reg
//
reg [64/2:0] ro_rd_pd_o; // output data register
wire rd_req_next_o = (ro_rd_pvld_p || (ro_rd_pvld_int_o && !ro_rd_prdy_d_o)) ;
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        ro_rd_pvld_int_o <= 1'b0;
    end else begin
        ro_rd_pvld_int_o <= rd_req_next_o;
    end
end
always @( posedge nvdla_core_clk_mgated ) begin
    if ( (ro_rd_pvld_int && rd_req_next_o && rd_popping) ) begin
        ro_rd_pd_o <= ro_rd_pd_p;
    end
//synopsys translate_off
        else if ( !((ro_rd_pvld_int && rd_req_next_o && rd_popping)) ) begin
    end else begin
        ro_rd_pd_o <= {257{`x_or_0}};
    end
//synopsys translate_on
end
//
// FINAL OUTPUT
//
reg [64/2:0] ro_rd_pd; // output data register
reg ro_rd_pvld_int_d; // so we can bubble-collapse ro_rd_prdy_d
assign ro_rd_prdy_d_o = !((ro_rd_pvld_o && ro_rd_pvld_int_d && !ro_rd_prdy_d ) );
wire rd_req_next = (!ro_rd_prdy_d_o ? ro_rd_pvld_o : ro_rd_pvld_p) ;
always @( posedge nvdla_core_clk or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        ro_rd_pvld_int <= 1'b0;
        ro_rd_pvld_int_d <= 1'b0;
    end else begin
        if ( !ro_rd_pvld_int || ro_rd_prdy ) begin
     ro_rd_pvld_int <= rd_req_next;
        end
//synopsys translate_off
            else if ( !(!ro_rd_pvld_int || ro_rd_prdy) ) begin
        end else begin
            ro_rd_pvld_int <= `x_or_0;
        end
//synopsys translate_on
        ro_rd_pvld_int_d <= ro_rd_pvld_int;
    end
end
always @( posedge nvdla_core_clk ) begin
    if ( rd_req_next && (!ro_rd_pvld_int || ro_rd_prdy ) ) begin
        case (!ro_rd_prdy_d_o)
            1'b0: ro_rd_pd <= ro_rd_pd_p;
            1'b1: ro_rd_pd <= ro_rd_pd_o;
//VCS coverage off
            default: ro_rd_pd <= {257{`x_or_0}};
//VCS coverage on
        endcase
    end
//synopsys translate_off
        else if ( !(rd_req_next && (!ro_rd_pvld_int || ro_rd_prdy)) ) begin
    end else begin
        ro_rd_pd <= {257{`x_or_0}};
    end
//synopsys translate_on
end
// Master Clock Gating (SLCG) Enables
//
// plusarg for disabling this stuff:
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg master_clk_gating_disabled; initial master_clk_gating_disabled = $test$plusargs( "fifogen_disable_master_clk_gating" ) != 0;
`endif
`endif
// synopsys translate_on
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg wr_pause_rand_dly;
always @( posedge nvdla_core_clk or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        wr_pause_rand_dly <= 1'b0;
    end else begin
        wr_pause_rand_dly <= wr_pause_rand;
    end
end
`endif
`endif
// synopsys translate_on
assign nvdla_core_clk_mgated_enable = ((wr_reserving || wr_pushing || wr_popping || (ro_wr_pvld && !ro_wr_busy_int) || (ro_wr_busy_int != ro_wr_busy_next)) || (rd_pushing || rd_popping || (ro_rd_pvld_int && ro_rd_prdy_d) || (ro_rd_pvld_int_o && ro_rd_prdy_d_o)) || (wr_pushing))
                               `ifdef FIFOGEN_MASTER_CLK_GATING_DISABLED
                               || 1'b1
                               `endif
// synopsys translate_off
          `ifndef SYNTH_LEVEL1_COMPILE
          `ifndef SYNTHESIS
                               || master_clk_gating_disabled || (wr_pause_rand != wr_pause_rand_dly)
          `endif
          `endif
// synopsys translate_on
                               ;
// Simulation and Emulation Overrides of wr_limit(s)
//
`ifdef EMU
`ifdef EMU_FIFO_CFG
// Emulation Global Config Override
//
assign wr_limit_muxed = `EMU_FIFO_CFG.NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_wr_limit_override ? `EMU_FIFO_CFG.NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_wr_limit : 3'd0;
`else
// No Global Override for Emulation
//
assign wr_limit_muxed = 3'd0;
`endif // EMU_FIFO_CFG
`else // !EMU
`ifdef SYNTH_LEVEL1_COMPILE
// No Override for GCS Compiles
//
assign wr_limit_muxed = 3'd0;
`else
`ifdef SYNTHESIS
// No Override for RTL Synthesis
//
assign wr_limit_muxed = 3'd0;
`else
// RTL Simulation Plusarg Override
// VCS coverage off
reg wr_limit_override;
reg [2:0] wr_limit_override_value;
assign wr_limit_muxed = wr_limit_override ? wr_limit_override_value : 3'd0;
`ifdef NV_ARCHPRO
event reinit;
initial begin
    $display("fifogen reinit initial block %m");
    -> reinit;
end
`endif
`ifdef NV_ARCHPRO
always @( reinit ) begin
`else
initial begin
`endif
    wr_limit_override = 0;
    wr_limit_override_value = 0; // to keep viva happy with dangles
    if ( $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_wr_limit" ) ) begin
        wr_limit_override = 1;
        $value$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_wr_limit=%d", wr_limit_override_value);
    end
end
// VCS coverage on
`endif
`endif
`endif
// Random Write-Side Stalling
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
// VCS coverage off
// leda W339 OFF -- Non synthesizable operator
// leda W372 OFF -- Undefined PLI task
// leda W373 OFF -- Undefined PLI function
// leda W599 OFF -- This construct is not supported by Synopsys
// leda W430 OFF -- Initial statement is not synthesizable
// leda W182 OFF -- Illegal statement for synthesis
// leda W639 OFF -- For synthesis, operands of a division or modulo operation need to be constants
// leda DCVER_274_NV OFF -- This system task is not supported by DC
integer stall_probability; // prob of stalling
integer stall_cycles_min; // min cycles to stall
integer stall_cycles_max; // max cycles to stall
integer stall_cycles_left; // stall cycles left
`ifdef NV_ARCHPRO
always @( reinit ) begin
`else
initial begin
`endif
    stall_probability = 0; // no stalling by default
    stall_cycles_min = 1;
    stall_cycles_max = 10;
`ifdef NO_PLI
`else
    if ( $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_probability" ) ) begin
        $value$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_probability=%d", stall_probability);
    end else if ( $test$plusargs( "default_fifo_stall_probability" ) ) begin
        $value$plusargs( "default_fifo_stall_probability=%d", stall_probability);
    end
    if ( $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_cycles_min" ) ) begin
        $value$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_cycles_min=%d", stall_cycles_min);
    end else if ( $test$plusargs( "default_fifo_stall_cycles_min" ) ) begin
        $value$plusargs( "default_fifo_stall_cycles_min=%d", stall_cycles_min);
    end
    if ( $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_cycles_max" ) ) begin
        $value$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_cycles_max=%d", stall_cycles_max);
    end else if ( $test$plusargs( "default_fifo_stall_cycles_max" ) ) begin
        $value$plusargs( "default_fifo_stall_cycles_max=%d", stall_cycles_max);
    end
`endif
    if ( stall_cycles_min < 1 ) begin
        stall_cycles_min = 1;
    end
    if ( stall_cycles_min > stall_cycles_max ) begin
        stall_cycles_max = stall_cycles_min;
    end
end
`ifdef NO_PLI
`else
// randomization globals
`ifdef SIMTOP_RANDOMIZE_STALLS
  always @( `SIMTOP_RANDOMIZE_STALLS.global_stall_event ) begin
    if ( ! $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_probability" ) ) stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_probability;
    if ( ! $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_cycles_min" ) ) stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_cycles_min;
    if ( ! $test$plusargs( "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_fifo_stall_cycles_max" ) ) stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_cycles_max;
  end
`endif
`endif
always @( negedge nvdla_core_clk or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        stall_cycles_left <= 0;
    end else begin
`ifdef NO_PLI
            stall_cycles_left <= 0;
`else
            if ( ro_wr_pvld && !(!ro_wr_prdy)
                 && stall_probability != 0 ) begin
                if ( prand_inst2(1, 100) <= stall_probability ) begin
                    stall_cycles_left <= prand_inst3(stall_cycles_min, stall_cycles_max);
                end else if ( stall_cycles_left !== 0 ) begin
                    stall_cycles_left <= stall_cycles_left - 1;
                end
            end else if ( stall_cycles_left !== 0 ) begin
                stall_cycles_left <= stall_cycles_left - 1;
            end
`endif
    end
end
assign wr_pause_rand = (stall_cycles_left !== 0) ;
// VCS coverage on
`endif
`endif
// synopsys translate_on
// VCS coverage on
// leda W339 ON
// leda W372 ON
// leda W373 ON
// leda W599 ON
// leda W430 ON
// leda W182 ON
// leda W639 ON
// leda DCVER_274_NV ON
//
// Histogram of fifo depth (from write side's perspective)
//
// NOTE: it will reference `SIMTOP.perfmon_enabled, so that
// has to at least be defined, though not initialized.
// tbgen testbenches have it already and various
// ways to turn it on and off.
//
`ifdef PERFMON_HISTOGRAM
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
perfmon_histogram perfmon (
      .clk ( nvdla_core_clk )
    , .max ( {29'd0, (wr_limit_reg == 3'd0) ? 3'd4 : wr_limit_reg} )
    , .curr ( {29'd0, ro_wr_count} )
    );
`endif
`endif
// synopsys translate_on
`endif
// spyglass disable_block W164a W164b W116 W484 W504
`ifdef SPYGLASS
`else
`ifdef FV_ASSERT_ON
`else
// synopsys translate_off
`endif
`ifdef ASSERT_ON
`ifdef SPYGLASS
wire disable_assert_plusarg = 1'b0;
`else
`ifdef FV_ASSERT_ON
wire disable_assert_plusarg = 1'b0;
`else
wire disable_assert_plusarg = $test$plusargs("DISABLE_NESS_FLOW_ASSERTIONS");
`endif
`endif
wire assert_enabled = 1'b1 && !disable_assert_plusarg;
`endif
`ifdef FV_ASSERT_ON
`else
// synopsys translate_on
`endif
`ifdef ASSERT_ON
//synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
always @(assert_enabled) begin
    if ( assert_enabled === 1'b0 ) begin
        $display("Asserts are disabled for %m");
    end
end
`endif
`endif
//synopsys translate_on
`endif
`endif
// spyglass enable_block W164a W164b W116 W484 W504
//The NV_BLKBOX_SRC0 module is only present when the FIFOGEN_MODULE_SEARCH
// define is set. This is to aid fifogen team search for fifogen fifo
// instance and module names in a given design.
`ifdef FIFOGEN_MODULE_SEARCH
NV_BLKBOX_SRC0 dummy_breadcrumb_fifogen_blkbox (.Y());
`endif
// spyglass enable_block W401 -- clock is not input to module
// synopsys dc_script_begin
// set_boundary_optimization find(design, "NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo") true
// synopsys dc_script_end
`ifdef SYNTH_LEVEL1_COMPILE
`else
`ifdef SYNTHESIS
`else
`ifdef PRAND_VERILOG
// Only verilog needs any local variables
reg [47:0] prand_local_seed2;
reg prand_initialized2;
reg prand_no_rollpli2;
`endif
`endif
`endif
function [31:0] prand_inst2;
//VCS coverage off
    input [31:0] min;
    input [31:0] max;
    reg [32:0] diff;
    begin
`ifdef SYNTH_LEVEL1_COMPILE
        prand_inst2 = min;
`else
`ifdef SYNTHESIS
        prand_inst2 = min;
`else
`ifdef PRAND_VERILOG
        if (prand_initialized2 !== 1'b1) begin
            prand_no_rollpli2 = $test$plusargs("NO_ROLLPLI");
            if (!prand_no_rollpli2)
                prand_local_seed2 = {$prand_get_seed(2), 16'b0};
            prand_initialized2 = 1'b1;
        end
        if (prand_no_rollpli2) begin
            prand_inst2 = min;
        end else begin
            diff = max - min + 1;
            prand_inst2 = min + prand_local_seed2[47:16] % diff;
// magic numbers taken from Java's random class (same as lrand48)
            prand_local_seed2 = prand_local_seed2 * 48'h5deece66d + 48'd11;
        end
`else
`ifdef PRAND_OFF
        prand_inst2 = min;
`else
        prand_inst2 = $RollPLI(min, max, "auto");
`endif
`endif
`endif
`endif
    end
//VCS coverage on
endfunction
`ifdef SYNTH_LEVEL1_COMPILE
`else
`ifdef SYNTHESIS
`else
`ifdef PRAND_VERILOG
// Only verilog needs any local variables
reg [47:0] prand_local_seed3;
reg prand_initialized3;
reg prand_no_rollpli3;
`endif
`endif
`endif
function [31:0] prand_inst3;
//VCS coverage off
    input [31:0] min;
    input [31:0] max;
    reg [32:0] diff;
    begin
`ifdef SYNTH_LEVEL1_COMPILE
        prand_inst3 = min;
`else
`ifdef SYNTHESIS
        prand_inst3 = min;
`else
`ifdef PRAND_VERILOG
        if (prand_initialized3 !== 1'b1) begin
            prand_no_rollpli3 = $test$plusargs("NO_ROLLPLI");
            if (!prand_no_rollpli3)
                prand_local_seed3 = {$prand_get_seed(3), 16'b0};
            prand_initialized3 = 1'b1;
        end
        if (prand_no_rollpli3) begin
            prand_inst3 = min;
        end else begin
            diff = max - min + 1;
            prand_inst3 = min + prand_local_seed3[47:16] % diff;
// magic numbers taken from Java's random class (same as lrand48)
            prand_local_seed3 = prand_local_seed3 * 48'h5deece66d + 48'd11;
        end
`else
`ifdef PRAND_OFF
        prand_inst3 = min;
`else
        prand_inst3 = $RollPLI(min, max, "auto");
`endif
`endif
`endif
`endif
    end
//VCS coverage on
endfunction
endmodule // NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo
//
// Flop-Based RAM
//
module NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257 (
      clk
    , pwrbus_ram_pd
    , di
    , we
    , wa
    , ra
    , dout
    );
input clk; // write clock
input [31 : 0] pwrbus_ram_pd;
input [64/2:0] di;
input we;
input [1:0] wa;
input [2:0] ra;
output [64/2:0] dout;
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_0 (.A(pwrbus_ram_pd[0]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_1 (.A(pwrbus_ram_pd[1]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_2 (.A(pwrbus_ram_pd[2]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_3 (.A(pwrbus_ram_pd[3]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_4 (.A(pwrbus_ram_pd[4]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_5 (.A(pwrbus_ram_pd[5]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_6 (.A(pwrbus_ram_pd[6]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_7 (.A(pwrbus_ram_pd[7]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_8 (.A(pwrbus_ram_pd[8]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_9 (.A(pwrbus_ram_pd[9]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_10 (.A(pwrbus_ram_pd[10]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_11 (.A(pwrbus_ram_pd[11]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_12 (.A(pwrbus_ram_pd[12]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_13 (.A(pwrbus_ram_pd[13]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_14 (.A(pwrbus_ram_pd[14]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_15 (.A(pwrbus_ram_pd[15]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_16 (.A(pwrbus_ram_pd[16]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_17 (.A(pwrbus_ram_pd[17]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_18 (.A(pwrbus_ram_pd[18]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_19 (.A(pwrbus_ram_pd[19]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_20 (.A(pwrbus_ram_pd[20]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_21 (.A(pwrbus_ram_pd[21]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_22 (.A(pwrbus_ram_pd[22]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_23 (.A(pwrbus_ram_pd[23]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_24 (.A(pwrbus_ram_pd[24]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_25 (.A(pwrbus_ram_pd[25]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_26 (.A(pwrbus_ram_pd[26]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_27 (.A(pwrbus_ram_pd[27]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_28 (.A(pwrbus_ram_pd[28]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_29 (.A(pwrbus_ram_pd[29]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_30 (.A(pwrbus_ram_pd[30]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_31 (.A(pwrbus_ram_pd[31]));
`endif
`ifdef EMU
wire [64/2:0] dout_p;
// we use an emulation ram here to save flops on the emulation board
// so that the monstrous chip can fit :-)
//
reg [1:0] Wa0_vmw;
reg we0_vmw;
reg [64/2:0] Di0_vmw;
always @( posedge clk ) begin
    Wa0_vmw <= wa;
    we0_vmw <= we;
    Di0_vmw <= di;
end
vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257 emu_ram (
     .Wa0( Wa0_vmw )
   , .we0( we0_vmw )
   , .Di0( Di0_vmw )
   , .Ra0( ra[1:0] )
   , .Do0( dout_p )
   );
assign dout = (ra == 4) ? di : dout_p;
`else
reg [64/2:0] ram_ff0;
reg [64/2:0] ram_ff1;
reg [64/2:0] ram_ff2;
reg [64/2:0] ram_ff3;
always @( posedge clk ) begin
    if ( we && wa == 2'd0 ) begin
 ram_ff0 <= di;
    end
    if ( we && wa == 2'd1 ) begin
 ram_ff1 <= di;
    end
    if ( we && wa == 2'd2 ) begin
 ram_ff2 <= di;
    end
    if ( we && wa == 2'd3 ) begin
 ram_ff3 <= di;
    end
end
reg [64/2:0] dout;
always @(*) begin
    case( ra )
    3'd0: dout = ram_ff0;
    3'd1: dout = ram_ff1;
    3'd2: dout = ram_ff2;
    3'd3: dout = ram_ff3;
    3'd4: dout = di;
//VCS coverage off
    default: dout = {257{`x_or_0}};
//VCS coverage on
    endcase
end
`endif // EMU
endmodule // NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257
// emulation model of flopram guts
//
`ifdef EMU
module vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257 (
   Wa0, we0, Di0,
   Ra0, Do0
   );
input [1:0] Wa0;
input we0;
input [64/2:0] Di0;
input [1:0] Ra0;
output [64/2:0] Do0;
// Only visible during Spyglass to avoid blackboxes.
`ifdef SPYGLASS_FLOPRAM
assign Do0 = 257'd0;
wire dummy = 1'b0 | (|Wa0) | (|we0) | (|Di0) | (|Ra0);
`endif
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg [64/2:0] mem[3:0];
// expand mem for debug ease
`ifdef EMU_EXPAND_FLOPRAM_MEM
wire [64/2:0] Q0 = mem[0];
wire [64/2:0] Q1 = mem[1];
wire [64/2:0] Q2 = mem[2];
wire [64/2:0] Q3 = mem[3];
`endif
// asynchronous ram writes
always @(*) begin
  if ( we0 == 1'b1 ) begin
    #0.1;
    mem[Wa0] = Di0;
  end
end
assign Do0 = mem[Ra0];
`endif
`endif
// synopsys translate_on
// synopsys dc_script_begin
// synopsys dc_script_end
// g2c if { [find / -null_ok -subdesign vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257] != {} } { set_attr preserve 1 [find / -subdesign vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257] }
endmodule // vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257
//vmw: Memory vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257
//vmw: Address-size 2
//vmw: Data-size 257
//vmw: Sensitivity level 1
//vmw: Ports W R
//vmw: terminal we0 WriteEnable0
//vmw: terminal Wa0 address0
//vmw: terminal Di0[64/2:0]
//data0[64/2:0]
//vmw:
//vmw: terminal Ra0 address1
//vmw: terminal Do0[64/2:0]
//data1[64/2:0]
//vmw:
//qt: CELL vmw_NV_NVDLA_NOCIF_DRAM_READ_EG_ro_fifo_flopram_rwsa_4x257
//qt: TERMINAL we0 TYPE=WE POLARITY=H PORT=1
//qt: TERMINAL Wa0[%d] TYPE=ADDRESS DIR=W BIT=%1 PORT=1
//qt: TERMINAL Di0[%d] TYPE=DATA DIR=I BIT=%1 PORT=1
//qt:
//qt: TERMINAL Ra0[%d] TYPE=ADDRESS DIR=R BIT=%1 PORT=1
//qt: TERMINAL Do0[%d] TYPE=DATA DIR=O BIT=%1 PORT=1
//qt:
`endif // EMU
