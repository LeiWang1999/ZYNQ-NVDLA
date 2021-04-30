// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_NOCIF_DRAM_read.v
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
module NV_NVDLA_NOCIF_DRAM_read (
  nvdla_core_clk
  ,nvdla_core_rstn
//:my $k=7;
//:my $i;
//:for ($i=0;$i<$k;$i++) {
//: print(",client${i}2mcif_rd_cdt_lat_fifo_pop\n");
//: print(",client${i}2mcif_rd_req_valid\n");
//: print(",client${i}2mcif_rd_req_ready\n");
//: print(",client${i}2mcif_rd_req_pd\n");
//: print(",mcif2client${i}_rd_rsp_valid\n");
//: print(",mcif2client${i}_rd_rsp_ready\n");
//: print(",mcif2client${i}_rd_rsp_pd\n"),
//: print(",client${i}2mcif_rd_wt\n"),
//: print(",client${i}2mcif_rd_axid\n"),
//: print(",client${i}2mcif_lat_fifo_depth\n"),
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
,client02mcif_rd_cdt_lat_fifo_pop
,client02mcif_rd_req_valid
,client02mcif_rd_req_ready
,client02mcif_rd_req_pd
,mcif2client0_rd_rsp_valid
,mcif2client0_rd_rsp_ready
,mcif2client0_rd_rsp_pd
,client02mcif_rd_wt
,client02mcif_rd_axid
,client02mcif_lat_fifo_depth
,client12mcif_rd_cdt_lat_fifo_pop
,client12mcif_rd_req_valid
,client12mcif_rd_req_ready
,client12mcif_rd_req_pd
,mcif2client1_rd_rsp_valid
,mcif2client1_rd_rsp_ready
,mcif2client1_rd_rsp_pd
,client12mcif_rd_wt
,client12mcif_rd_axid
,client12mcif_lat_fifo_depth
,client22mcif_rd_cdt_lat_fifo_pop
,client22mcif_rd_req_valid
,client22mcif_rd_req_ready
,client22mcif_rd_req_pd
,mcif2client2_rd_rsp_valid
,mcif2client2_rd_rsp_ready
,mcif2client2_rd_rsp_pd
,client22mcif_rd_wt
,client22mcif_rd_axid
,client22mcif_lat_fifo_depth
,client32mcif_rd_cdt_lat_fifo_pop
,client32mcif_rd_req_valid
,client32mcif_rd_req_ready
,client32mcif_rd_req_pd
,mcif2client3_rd_rsp_valid
,mcif2client3_rd_rsp_ready
,mcif2client3_rd_rsp_pd
,client32mcif_rd_wt
,client32mcif_rd_axid
,client32mcif_lat_fifo_depth
,client42mcif_rd_cdt_lat_fifo_pop
,client42mcif_rd_req_valid
,client42mcif_rd_req_ready
,client42mcif_rd_req_pd
,mcif2client4_rd_rsp_valid
,mcif2client4_rd_rsp_ready
,mcif2client4_rd_rsp_pd
,client42mcif_rd_wt
,client42mcif_rd_axid
,client42mcif_lat_fifo_depth
,client52mcif_rd_cdt_lat_fifo_pop
,client52mcif_rd_req_valid
,client52mcif_rd_req_ready
,client52mcif_rd_req_pd
,mcif2client5_rd_rsp_valid
,mcif2client5_rd_rsp_ready
,mcif2client5_rd_rsp_pd
,client52mcif_rd_wt
,client52mcif_rd_axid
,client52mcif_lat_fifo_depth
,client62mcif_rd_cdt_lat_fifo_pop
,client62mcif_rd_req_valid
,client62mcif_rd_req_ready
,client62mcif_rd_req_pd
,mcif2client6_rd_rsp_valid
,mcif2client6_rd_rsp_ready
,mcif2client6_rd_rsp_pd
,client62mcif_rd_wt
,client62mcif_rd_axid
,client62mcif_lat_fifo_depth

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,pwrbus_ram_pd
  ,reg2dp_rd_os_cnt
  ,mcif2noc_axi_ar_arvalid
  ,mcif2noc_axi_ar_arready
  ,mcif2noc_axi_ar_arid
  ,mcif2noc_axi_ar_arlen
  ,mcif2noc_axi_ar_araddr
  ,noc2mcif_axi_r_rvalid
  ,noc2mcif_axi_r_rready
  ,noc2mcif_axi_r_rid
  ,noc2mcif_axi_r_rlast
  ,noc2mcif_axi_r_rdata
);
input nvdla_core_clk;
input nvdla_core_rstn;
//:my $k=7;
//:my $w = 64 +(( 64 )/8/8)-1;
//:my $i;
//:for ($i=0;$i<$k;$i++) {
//: print("input client${i}2mcif_rd_cdt_lat_fifo_pop;\n");
//: print("input client${i}2mcif_rd_req_valid;\n");
//: print("output client${i}2mcif_rd_req_ready;\n");
//: print qq(
//: input [32 +14:0] client${i}2mcif_rd_req_pd;
//: );
//: print("output mcif2client${i}_rd_rsp_valid;\n");
//: print("output [$w:0] mcif2client${i}_rd_rsp_pd;\n");
//: print("input mcif2client${i}_rd_rsp_ready;\n");
//: print("input [7:0] client${i}2mcif_rd_wt;\n");
//: print("input [3:0] client${i}2mcif_rd_axid;\n");
//: print("input [7:0] client${i}2mcif_lat_fifo_depth;\n");
//: }
//:my $i;
//:for($i=0;$i<16;$i++) {
//: print qq(
//:wire [6:0] cq_rd${i}_pd;
//:wire cq_rd${i}_prdy;
//:wire cq_rd${i}_pvld;
//: );
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
input client02mcif_rd_cdt_lat_fifo_pop;
input client02mcif_rd_req_valid;
output client02mcif_rd_req_ready;

input [32 +14:0] client02mcif_rd_req_pd;
output mcif2client0_rd_rsp_valid;
output [64:0] mcif2client0_rd_rsp_pd;
input mcif2client0_rd_rsp_ready;
input [7:0] client02mcif_rd_wt;
input [3:0] client02mcif_rd_axid;
input [7:0] client02mcif_lat_fifo_depth;
input client12mcif_rd_cdt_lat_fifo_pop;
input client12mcif_rd_req_valid;
output client12mcif_rd_req_ready;

input [32 +14:0] client12mcif_rd_req_pd;
output mcif2client1_rd_rsp_valid;
output [64:0] mcif2client1_rd_rsp_pd;
input mcif2client1_rd_rsp_ready;
input [7:0] client12mcif_rd_wt;
input [3:0] client12mcif_rd_axid;
input [7:0] client12mcif_lat_fifo_depth;
input client22mcif_rd_cdt_lat_fifo_pop;
input client22mcif_rd_req_valid;
output client22mcif_rd_req_ready;

input [32 +14:0] client22mcif_rd_req_pd;
output mcif2client2_rd_rsp_valid;
output [64:0] mcif2client2_rd_rsp_pd;
input mcif2client2_rd_rsp_ready;
input [7:0] client22mcif_rd_wt;
input [3:0] client22mcif_rd_axid;
input [7:0] client22mcif_lat_fifo_depth;
input client32mcif_rd_cdt_lat_fifo_pop;
input client32mcif_rd_req_valid;
output client32mcif_rd_req_ready;

input [32 +14:0] client32mcif_rd_req_pd;
output mcif2client3_rd_rsp_valid;
output [64:0] mcif2client3_rd_rsp_pd;
input mcif2client3_rd_rsp_ready;
input [7:0] client32mcif_rd_wt;
input [3:0] client32mcif_rd_axid;
input [7:0] client32mcif_lat_fifo_depth;
input client42mcif_rd_cdt_lat_fifo_pop;
input client42mcif_rd_req_valid;
output client42mcif_rd_req_ready;

input [32 +14:0] client42mcif_rd_req_pd;
output mcif2client4_rd_rsp_valid;
output [64:0] mcif2client4_rd_rsp_pd;
input mcif2client4_rd_rsp_ready;
input [7:0] client42mcif_rd_wt;
input [3:0] client42mcif_rd_axid;
input [7:0] client42mcif_lat_fifo_depth;
input client52mcif_rd_cdt_lat_fifo_pop;
input client52mcif_rd_req_valid;
output client52mcif_rd_req_ready;

input [32 +14:0] client52mcif_rd_req_pd;
output mcif2client5_rd_rsp_valid;
output [64:0] mcif2client5_rd_rsp_pd;
input mcif2client5_rd_rsp_ready;
input [7:0] client52mcif_rd_wt;
input [3:0] client52mcif_rd_axid;
input [7:0] client52mcif_lat_fifo_depth;
input client62mcif_rd_cdt_lat_fifo_pop;
input client62mcif_rd_req_valid;
output client62mcif_rd_req_ready;

input [32 +14:0] client62mcif_rd_req_pd;
output mcif2client6_rd_rsp_valid;
output [64:0] mcif2client6_rd_rsp_pd;
input mcif2client6_rd_rsp_ready;
input [7:0] client62mcif_rd_wt;
input [3:0] client62mcif_rd_axid;
input [7:0] client62mcif_lat_fifo_depth;

wire [6:0] cq_rd0_pd;
wire cq_rd0_prdy;
wire cq_rd0_pvld;

wire [6:0] cq_rd1_pd;
wire cq_rd1_prdy;
wire cq_rd1_pvld;

wire [6:0] cq_rd2_pd;
wire cq_rd2_prdy;
wire cq_rd2_pvld;

wire [6:0] cq_rd3_pd;
wire cq_rd3_prdy;
wire cq_rd3_pvld;

wire [6:0] cq_rd4_pd;
wire cq_rd4_prdy;
wire cq_rd4_pvld;

wire [6:0] cq_rd5_pd;
wire cq_rd5_prdy;
wire cq_rd5_pvld;

wire [6:0] cq_rd6_pd;
wire cq_rd6_prdy;
wire cq_rd6_pvld;

wire [6:0] cq_rd7_pd;
wire cq_rd7_prdy;
wire cq_rd7_pvld;

wire [6:0] cq_rd8_pd;
wire cq_rd8_prdy;
wire cq_rd8_pvld;

wire [6:0] cq_rd9_pd;
wire cq_rd9_prdy;
wire cq_rd9_pvld;

wire [6:0] cq_rd10_pd;
wire cq_rd10_prdy;
wire cq_rd10_pvld;

wire [6:0] cq_rd11_pd;
wire cq_rd11_prdy;
wire cq_rd11_pvld;

wire [6:0] cq_rd12_pd;
wire cq_rd12_prdy;
wire cq_rd12_pvld;

wire [6:0] cq_rd13_pd;
wire cq_rd13_prdy;
wire cq_rd13_pvld;

wire [6:0] cq_rd14_pd;
wire cq_rd14_prdy;
wire cq_rd14_pvld;

wire [6:0] cq_rd15_pd;
wire cq_rd15_prdy;
wire cq_rd15_pvld;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input [7:0] reg2dp_rd_os_cnt;
input noc2mcif_axi_r_rvalid; /* data valid */
output noc2mcif_axi_r_rready; /* data return handshake */
input [7:0] noc2mcif_axi_r_rid;
input noc2mcif_axi_r_rlast;
input [64 -1:0] noc2mcif_axi_r_rdata;
output mcif2noc_axi_ar_arvalid; /* data valid */
input mcif2noc_axi_ar_arready; /* data return handshake */
output [7:0] mcif2noc_axi_ar_arid;
output [3:0] mcif2noc_axi_ar_arlen;
output [32 -1:0] mcif2noc_axi_ar_araddr;
input [31:0] pwrbus_ram_pd;
wire [3:0] cq_wr_thread_id;
wire [6:0] cq_wr_pd;
wire cq_wr_pvld;
wire cq_wr_prdy;
NV_NVDLA_NOCIF_DRAM_READ_ig u_ig (
  .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.reg2dp_rd_os_cnt (reg2dp_rd_os_cnt)
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|> w
//:my $i;
//:my $k=7;
//:for ($i=0;$i<$k;$i++) {
//: print (",.client${i}2mcif_rd_cdt_lat_fifo_pop(client${i}2mcif_rd_cdt_lat_fifo_pop)\n");
//: print (",.client${i}2mcif_rd_req_valid(client${i}2mcif_rd_req_valid)\n");
//: print (",.client${i}2mcif_rd_req_ready(client${i}2mcif_rd_req_ready)\n");
//: print (",.client${i}2mcif_rd_req_pd(client${i}2mcif_rd_req_pd)\n");
//: print (",.client${i}2mcif_rd_wt(client${i}2mcif_rd_wt)\n");
//: print (",.client${i}2mcif_rd_axid(client${i}2mcif_rd_axid)\n");
//: print (",.client${i}2mcif_lat_fifo_depth(client${i}2mcif_lat_fifo_depth)\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
,.client02mcif_rd_cdt_lat_fifo_pop(client02mcif_rd_cdt_lat_fifo_pop)
,.client02mcif_rd_req_valid(client02mcif_rd_req_valid)
,.client02mcif_rd_req_ready(client02mcif_rd_req_ready)
,.client02mcif_rd_req_pd(client02mcif_rd_req_pd)
,.client02mcif_rd_wt(client02mcif_rd_wt)
,.client02mcif_rd_axid(client02mcif_rd_axid)
,.client02mcif_lat_fifo_depth(client02mcif_lat_fifo_depth)
,.client12mcif_rd_cdt_lat_fifo_pop(client12mcif_rd_cdt_lat_fifo_pop)
,.client12mcif_rd_req_valid(client12mcif_rd_req_valid)
,.client12mcif_rd_req_ready(client12mcif_rd_req_ready)
,.client12mcif_rd_req_pd(client12mcif_rd_req_pd)
,.client12mcif_rd_wt(client12mcif_rd_wt)
,.client12mcif_rd_axid(client12mcif_rd_axid)
,.client12mcif_lat_fifo_depth(client12mcif_lat_fifo_depth)
,.client22mcif_rd_cdt_lat_fifo_pop(client22mcif_rd_cdt_lat_fifo_pop)
,.client22mcif_rd_req_valid(client22mcif_rd_req_valid)
,.client22mcif_rd_req_ready(client22mcif_rd_req_ready)
,.client22mcif_rd_req_pd(client22mcif_rd_req_pd)
,.client22mcif_rd_wt(client22mcif_rd_wt)
,.client22mcif_rd_axid(client22mcif_rd_axid)
,.client22mcif_lat_fifo_depth(client22mcif_lat_fifo_depth)
,.client32mcif_rd_cdt_lat_fifo_pop(client32mcif_rd_cdt_lat_fifo_pop)
,.client32mcif_rd_req_valid(client32mcif_rd_req_valid)
,.client32mcif_rd_req_ready(client32mcif_rd_req_ready)
,.client32mcif_rd_req_pd(client32mcif_rd_req_pd)
,.client32mcif_rd_wt(client32mcif_rd_wt)
,.client32mcif_rd_axid(client32mcif_rd_axid)
,.client32mcif_lat_fifo_depth(client32mcif_lat_fifo_depth)
,.client42mcif_rd_cdt_lat_fifo_pop(client42mcif_rd_cdt_lat_fifo_pop)
,.client42mcif_rd_req_valid(client42mcif_rd_req_valid)
,.client42mcif_rd_req_ready(client42mcif_rd_req_ready)
,.client42mcif_rd_req_pd(client42mcif_rd_req_pd)
,.client42mcif_rd_wt(client42mcif_rd_wt)
,.client42mcif_rd_axid(client42mcif_rd_axid)
,.client42mcif_lat_fifo_depth(client42mcif_lat_fifo_depth)
,.client52mcif_rd_cdt_lat_fifo_pop(client52mcif_rd_cdt_lat_fifo_pop)
,.client52mcif_rd_req_valid(client52mcif_rd_req_valid)
,.client52mcif_rd_req_ready(client52mcif_rd_req_ready)
,.client52mcif_rd_req_pd(client52mcif_rd_req_pd)
,.client52mcif_rd_wt(client52mcif_rd_wt)
,.client52mcif_rd_axid(client52mcif_rd_axid)
,.client52mcif_lat_fifo_depth(client52mcif_lat_fifo_depth)
,.client62mcif_rd_cdt_lat_fifo_pop(client62mcif_rd_cdt_lat_fifo_pop)
,.client62mcif_rd_req_valid(client62mcif_rd_req_valid)
,.client62mcif_rd_req_ready(client62mcif_rd_req_ready)
,.client62mcif_rd_req_pd(client62mcif_rd_req_pd)
,.client62mcif_rd_wt(client62mcif_rd_wt)
,.client62mcif_rd_axid(client62mcif_rd_axid)
,.client62mcif_lat_fifo_depth(client62mcif_lat_fifo_depth)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.cq_wr_pvld (cq_wr_pvld) //|> w
  ,.cq_wr_prdy (cq_wr_prdy) //|< w
  ,.cq_wr_thread_id (cq_wr_thread_id[3:0]) //|> w
  ,.cq_wr_pd (cq_wr_pd[6:0]) //|> w
  ,.mcif2noc_axi_ar_arvalid (mcif2noc_axi_ar_arvalid) //|> o
  ,.mcif2noc_axi_ar_arready (mcif2noc_axi_ar_arready) //|< i
  ,.mcif2noc_axi_ar_arid (mcif2noc_axi_ar_arid[7:0]) //|> o
  ,.mcif2noc_axi_ar_arlen (mcif2noc_axi_ar_arlen[3:0]) //|> o
  ,.mcif2noc_axi_ar_araddr (mcif2noc_axi_ar_araddr[32 -1:0]) //|> o
);
NV_NVDLA_NOCIF_DRAM_READ_eg u_eg (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
//:my $k=7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print(" ,.mcif2client${i}_rd_rsp_valid(mcif2client${i}_rd_rsp_valid)\n");
//:print(" ,.mcif2client${i}_rd_rsp_ready(mcif2client${i}_rd_rsp_ready)\n");
//:print(" ,.mcif2client${i}_rd_rsp_pd(mcif2client${i}_rd_rsp_pd)\n");
//:}
//:my $i;
//:for($i=0;$i<7;$i++) {
//: print qq(
//: ,.cq_rd${i}_prdy(cq_rd${i}_prdy)
//: ,.cq_rd${i}_pvld(cq_rd${i}_pvld)
//: ,.cq_rd${i}_pd(cq_rd${i}_pd[6:0])
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
 ,.mcif2client0_rd_rsp_valid(mcif2client0_rd_rsp_valid)
 ,.mcif2client0_rd_rsp_ready(mcif2client0_rd_rsp_ready)
 ,.mcif2client0_rd_rsp_pd(mcif2client0_rd_rsp_pd)
 ,.mcif2client1_rd_rsp_valid(mcif2client1_rd_rsp_valid)
 ,.mcif2client1_rd_rsp_ready(mcif2client1_rd_rsp_ready)
 ,.mcif2client1_rd_rsp_pd(mcif2client1_rd_rsp_pd)
 ,.mcif2client2_rd_rsp_valid(mcif2client2_rd_rsp_valid)
 ,.mcif2client2_rd_rsp_ready(mcif2client2_rd_rsp_ready)
 ,.mcif2client2_rd_rsp_pd(mcif2client2_rd_rsp_pd)
 ,.mcif2client3_rd_rsp_valid(mcif2client3_rd_rsp_valid)
 ,.mcif2client3_rd_rsp_ready(mcif2client3_rd_rsp_ready)
 ,.mcif2client3_rd_rsp_pd(mcif2client3_rd_rsp_pd)
 ,.mcif2client4_rd_rsp_valid(mcif2client4_rd_rsp_valid)
 ,.mcif2client4_rd_rsp_ready(mcif2client4_rd_rsp_ready)
 ,.mcif2client4_rd_rsp_pd(mcif2client4_rd_rsp_pd)
 ,.mcif2client5_rd_rsp_valid(mcif2client5_rd_rsp_valid)
 ,.mcif2client5_rd_rsp_ready(mcif2client5_rd_rsp_ready)
 ,.mcif2client5_rd_rsp_pd(mcif2client5_rd_rsp_pd)
 ,.mcif2client6_rd_rsp_valid(mcif2client6_rd_rsp_valid)
 ,.mcif2client6_rd_rsp_ready(mcif2client6_rd_rsp_ready)
 ,.mcif2client6_rd_rsp_pd(mcif2client6_rd_rsp_pd)

,.cq_rd0_prdy(cq_rd0_prdy)
,.cq_rd0_pvld(cq_rd0_pvld)
,.cq_rd0_pd(cq_rd0_pd[6:0])

,.cq_rd1_prdy(cq_rd1_prdy)
,.cq_rd1_pvld(cq_rd1_pvld)
,.cq_rd1_pd(cq_rd1_pd[6:0])

,.cq_rd2_prdy(cq_rd2_prdy)
,.cq_rd2_pvld(cq_rd2_pvld)
,.cq_rd2_pd(cq_rd2_pd[6:0])

,.cq_rd3_prdy(cq_rd3_prdy)
,.cq_rd3_pvld(cq_rd3_pvld)
,.cq_rd3_pd(cq_rd3_pd[6:0])

,.cq_rd4_prdy(cq_rd4_prdy)
,.cq_rd4_pvld(cq_rd4_pvld)
,.cq_rd4_pd(cq_rd4_pd[6:0])

,.cq_rd5_prdy(cq_rd5_prdy)
,.cq_rd5_pvld(cq_rd5_pvld)
,.cq_rd5_pd(cq_rd5_pd[6:0])

,.cq_rd6_prdy(cq_rd6_prdy)
,.cq_rd6_pvld(cq_rd6_pvld)
,.cq_rd6_pd(cq_rd6_pd[6:0])

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.noc2mcif_axi_r_rvalid (noc2mcif_axi_r_rvalid) //|< i
  ,.noc2mcif_axi_r_rready (noc2mcif_axi_r_rready) //|> o
  ,.noc2mcif_axi_r_rid (noc2mcif_axi_r_rid[7:0]) //|< i
  ,.noc2mcif_axi_r_rlast (noc2mcif_axi_r_rlast) //|< i
  ,.noc2mcif_axi_r_rdata (noc2mcif_axi_r_rdata[64 -1:0]) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|> w
  );
NV_NVDLA_NOCIF_DRAM_READ_cq u_cq (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.cq_wr_prdy (cq_wr_prdy) //|> w
  ,.cq_wr_pvld (cq_wr_pvld) //|< w
  ,.cq_wr_thread_id (cq_wr_thread_id[3:0]) //|< w
  ,.cq_wr_pd (cq_wr_pd[6:0]) //|< w
//:my $i;
//:for($i=0;$i<7;$i++) {
//: print qq(
//: ,.cq_rd${i}_prdy(cq_rd${i}_prdy)
//: ,.cq_rd${i}_pvld(cq_rd${i}_pvld)
//: ,.cq_rd${i}_pd(cq_rd${i}_pd[6:0])
//: );
//:}
//:my $i;
//:for($i=7;$i<16;$i++) {
//: print qq(
//: ,.cq_rd${i}_prdy(1'b1)
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.cq_rd0_prdy(cq_rd0_prdy)
,.cq_rd0_pvld(cq_rd0_pvld)
,.cq_rd0_pd(cq_rd0_pd[6:0])

,.cq_rd1_prdy(cq_rd1_prdy)
,.cq_rd1_pvld(cq_rd1_pvld)
,.cq_rd1_pd(cq_rd1_pd[6:0])

,.cq_rd2_prdy(cq_rd2_prdy)
,.cq_rd2_pvld(cq_rd2_pvld)
,.cq_rd2_pd(cq_rd2_pd[6:0])

,.cq_rd3_prdy(cq_rd3_prdy)
,.cq_rd3_pvld(cq_rd3_pvld)
,.cq_rd3_pd(cq_rd3_pd[6:0])

,.cq_rd4_prdy(cq_rd4_prdy)
,.cq_rd4_pvld(cq_rd4_pvld)
,.cq_rd4_pd(cq_rd4_pd[6:0])

,.cq_rd5_prdy(cq_rd5_prdy)
,.cq_rd5_pvld(cq_rd5_pvld)
,.cq_rd5_pd(cq_rd5_pd[6:0])

,.cq_rd6_prdy(cq_rd6_prdy)
,.cq_rd6_pvld(cq_rd6_pvld)
,.cq_rd6_pd(cq_rd6_pd[6:0])

,.cq_rd7_prdy(1'b1)

,.cq_rd8_prdy(1'b1)

,.cq_rd9_prdy(1'b1)

,.cq_rd10_prdy(1'b1)

,.cq_rd11_prdy(1'b1)

,.cq_rd12_prdy(1'b1)

,.cq_rd13_prdy(1'b1)

,.cq_rd14_prdy(1'b1)

,.cq_rd15_prdy(1'b1)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  );
endmodule
