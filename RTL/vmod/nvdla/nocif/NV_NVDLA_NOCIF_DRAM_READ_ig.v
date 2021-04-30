// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_NOCIF_DRAM_READ_ig.v
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
module NV_NVDLA_NOCIF_DRAM_READ_ig (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd
  ,eg2ig_axi_vld
//:my $i;
//:my $k=7;
//:for ($i=0;$i<$k;$i++) {
//: print (",client${i}2mcif_lat_fifo_depth\n");
//: print (",client${i}2mcif_rd_cdt_lat_fifo_pop\n");
//: print (",client${i}2mcif_rd_req_valid\n");
//: print (",client${i}2mcif_rd_req_ready\n");
//: print (",client${i}2mcif_rd_req_pd\n");
//: print (",client${i}2mcif_rd_wt\n");
//: print (",client${i}2mcif_rd_axid\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
,client02mcif_lat_fifo_depth
,client02mcif_rd_cdt_lat_fifo_pop
,client02mcif_rd_req_valid
,client02mcif_rd_req_ready
,client02mcif_rd_req_pd
,client02mcif_rd_wt
,client02mcif_rd_axid
,client12mcif_lat_fifo_depth
,client12mcif_rd_cdt_lat_fifo_pop
,client12mcif_rd_req_valid
,client12mcif_rd_req_ready
,client12mcif_rd_req_pd
,client12mcif_rd_wt
,client12mcif_rd_axid
,client22mcif_lat_fifo_depth
,client22mcif_rd_cdt_lat_fifo_pop
,client22mcif_rd_req_valid
,client22mcif_rd_req_ready
,client22mcif_rd_req_pd
,client22mcif_rd_wt
,client22mcif_rd_axid
,client32mcif_lat_fifo_depth
,client32mcif_rd_cdt_lat_fifo_pop
,client32mcif_rd_req_valid
,client32mcif_rd_req_ready
,client32mcif_rd_req_pd
,client32mcif_rd_wt
,client32mcif_rd_axid
,client42mcif_lat_fifo_depth
,client42mcif_rd_cdt_lat_fifo_pop
,client42mcif_rd_req_valid
,client42mcif_rd_req_ready
,client42mcif_rd_req_pd
,client42mcif_rd_wt
,client42mcif_rd_axid
,client52mcif_lat_fifo_depth
,client52mcif_rd_cdt_lat_fifo_pop
,client52mcif_rd_req_valid
,client52mcif_rd_req_ready
,client52mcif_rd_req_pd
,client52mcif_rd_wt
,client52mcif_rd_axid
,client62mcif_lat_fifo_depth
,client62mcif_rd_cdt_lat_fifo_pop
,client62mcif_rd_req_valid
,client62mcif_rd_req_ready
,client62mcif_rd_req_pd
,client62mcif_rd_wt
,client62mcif_rd_axid

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,reg2dp_rd_os_cnt
  ,cq_wr_pd //|> o
  ,cq_wr_pvld //|> o
  ,cq_wr_prdy //|> o
  ,cq_wr_thread_id //|> o
  ,mcif2noc_axi_ar_araddr //|> o
  ,mcif2noc_axi_ar_arready //|< i
  ,mcif2noc_axi_ar_arid //|> o
  ,mcif2noc_axi_ar_arlen //|> o
  ,mcif2noc_axi_ar_arvalid //|> o
);
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
//:my $i;
//:my $k=7;
//:for ($i=0;$i<$k;$i++) {
//: print ("input client${i}2mcif_rd_cdt_lat_fifo_pop;\n");
//: print ("input client${i}2mcif_rd_req_valid;\n");
//: print ("output client${i}2mcif_rd_req_ready;\n");
//: print qq(
//: input [32 +14:0] client${i}2mcif_rd_req_pd;
//: );
//: print ("input [7:0] client${i}2mcif_rd_wt;\n");
//: print ("input [3:0] client${i}2mcif_rd_axid;\n");
//: print ("input [7:0] client${i}2mcif_lat_fifo_depth;\n");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
input client02mcif_rd_cdt_lat_fifo_pop;
input client02mcif_rd_req_valid;
output client02mcif_rd_req_ready;

input [32 +14:0] client02mcif_rd_req_pd;
input [7:0] client02mcif_rd_wt;
input [3:0] client02mcif_rd_axid;
input [7:0] client02mcif_lat_fifo_depth;
input client12mcif_rd_cdt_lat_fifo_pop;
input client12mcif_rd_req_valid;
output client12mcif_rd_req_ready;

input [32 +14:0] client12mcif_rd_req_pd;
input [7:0] client12mcif_rd_wt;
input [3:0] client12mcif_rd_axid;
input [7:0] client12mcif_lat_fifo_depth;
input client22mcif_rd_cdt_lat_fifo_pop;
input client22mcif_rd_req_valid;
output client22mcif_rd_req_ready;

input [32 +14:0] client22mcif_rd_req_pd;
input [7:0] client22mcif_rd_wt;
input [3:0] client22mcif_rd_axid;
input [7:0] client22mcif_lat_fifo_depth;
input client32mcif_rd_cdt_lat_fifo_pop;
input client32mcif_rd_req_valid;
output client32mcif_rd_req_ready;

input [32 +14:0] client32mcif_rd_req_pd;
input [7:0] client32mcif_rd_wt;
input [3:0] client32mcif_rd_axid;
input [7:0] client32mcif_lat_fifo_depth;
input client42mcif_rd_cdt_lat_fifo_pop;
input client42mcif_rd_req_valid;
output client42mcif_rd_req_ready;

input [32 +14:0] client42mcif_rd_req_pd;
input [7:0] client42mcif_rd_wt;
input [3:0] client42mcif_rd_axid;
input [7:0] client42mcif_lat_fifo_depth;
input client52mcif_rd_cdt_lat_fifo_pop;
input client52mcif_rd_req_valid;
output client52mcif_rd_req_ready;

input [32 +14:0] client52mcif_rd_req_pd;
input [7:0] client52mcif_rd_wt;
input [3:0] client52mcif_rd_axid;
input [7:0] client52mcif_lat_fifo_depth;
input client62mcif_rd_cdt_lat_fifo_pop;
input client62mcif_rd_req_valid;
output client62mcif_rd_req_ready;

input [32 +14:0] client62mcif_rd_req_pd;
input [7:0] client62mcif_rd_wt;
input [3:0] client62mcif_rd_axid;
input [7:0] client62mcif_lat_fifo_depth;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output cq_wr_pvld; /* data valid */
input cq_wr_prdy; /* data return handshake */
output [3:0] cq_wr_thread_id;
output [6:0] cq_wr_pd;
output mcif2noc_axi_ar_arvalid; /* data valid */
input mcif2noc_axi_ar_arready; /* data return handshake */
output [7:0] mcif2noc_axi_ar_arid;
output [3:0] mcif2noc_axi_ar_arlen;
output [32 -1:0] mcif2noc_axi_ar_araddr;
input eg2ig_axi_vld;
input [7:0] reg2dp_rd_os_cnt;
wire [32 +10:0] arb2spt_req_pd;
wire arb2spt_req_ready;
wire arb2spt_req_valid;
//:my $i;
//:my $k=7;
//:for ($i=0;$i<$k;$i++) {
//: print qq(
//: wire [32 +10:0] bpt2arb_req${i}_pd;
//: );
//: print ("wire  bpt2arb_req${i}_ready;\n");
//: print ("wire  bpt2arb_req${i}_valid;\n");
//:}
//:my $i;
//:my $k=7;
//:for ($i=0;$i<$k;$i++) {
//: print("NV_NVDLA_NOCIF_DRAM_READ_IG_bpt u_bpt${i} (\n");
//: print (".nvdla_core_clk(nvdla_core_clk)\n");
//: print (",.nvdla_core_rstn(nvdla_core_rstn)\n");
//: print (",.dma2bpt_req_valid(client${i}2mcif_rd_req_valid)\n");
//: print (",.dma2bpt_req_ready(client${i}2mcif_rd_req_ready)\n");
//: print (",.dma2bpt_req_pd(client${i}2mcif_rd_req_pd)\n");
//: print (",.dma2bpt_cdt_lat_fifo_pop(client${i}2mcif_rd_cdt_lat_fifo_pop)\n");
//: print (",.bpt2arb_req_valid(bpt2arb_req${i}_valid)\n");
//: print (",.bpt2arb_req_ready(bpt2arb_req${i}_ready)\n");
//: print (",.bpt2arb_req_pd(bpt2arb_req${i}_pd)\n");
//: print (",.tieoff_axid(client${i}2mcif_rd_axid)\n");
//: print (",.tieoff_lat_fifo_depth(client${i}2mcif_lat_fifo_depth)\n");
//: print (");\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [32 +10:0] bpt2arb_req0_pd;
wire  bpt2arb_req0_ready;
wire  bpt2arb_req0_valid;

wire [32 +10:0] bpt2arb_req1_pd;
wire  bpt2arb_req1_ready;
wire  bpt2arb_req1_valid;

wire [32 +10:0] bpt2arb_req2_pd;
wire  bpt2arb_req2_ready;
wire  bpt2arb_req2_valid;

wire [32 +10:0] bpt2arb_req3_pd;
wire  bpt2arb_req3_ready;
wire  bpt2arb_req3_valid;

wire [32 +10:0] bpt2arb_req4_pd;
wire  bpt2arb_req4_ready;
wire  bpt2arb_req4_valid;

wire [32 +10:0] bpt2arb_req5_pd;
wire  bpt2arb_req5_ready;
wire  bpt2arb_req5_valid;

wire [32 +10:0] bpt2arb_req6_pd;
wire  bpt2arb_req6_ready;
wire  bpt2arb_req6_valid;
NV_NVDLA_NOCIF_DRAM_READ_IG_bpt u_bpt0 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.dma2bpt_req_valid(client02mcif_rd_req_valid)
,.dma2bpt_req_ready(client02mcif_rd_req_ready)
,.dma2bpt_req_pd(client02mcif_rd_req_pd)
,.dma2bpt_cdt_lat_fifo_pop(client02mcif_rd_cdt_lat_fifo_pop)
,.bpt2arb_req_valid(bpt2arb_req0_valid)
,.bpt2arb_req_ready(bpt2arb_req0_ready)
,.bpt2arb_req_pd(bpt2arb_req0_pd)
,.tieoff_axid(client02mcif_rd_axid)
,.tieoff_lat_fifo_depth(client02mcif_lat_fifo_depth)
);
NV_NVDLA_NOCIF_DRAM_READ_IG_bpt u_bpt1 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.dma2bpt_req_valid(client12mcif_rd_req_valid)
,.dma2bpt_req_ready(client12mcif_rd_req_ready)
,.dma2bpt_req_pd(client12mcif_rd_req_pd)
,.dma2bpt_cdt_lat_fifo_pop(client12mcif_rd_cdt_lat_fifo_pop)
,.bpt2arb_req_valid(bpt2arb_req1_valid)
,.bpt2arb_req_ready(bpt2arb_req1_ready)
,.bpt2arb_req_pd(bpt2arb_req1_pd)
,.tieoff_axid(client12mcif_rd_axid)
,.tieoff_lat_fifo_depth(client12mcif_lat_fifo_depth)
);
NV_NVDLA_NOCIF_DRAM_READ_IG_bpt u_bpt2 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.dma2bpt_req_valid(client22mcif_rd_req_valid)
,.dma2bpt_req_ready(client22mcif_rd_req_ready)
,.dma2bpt_req_pd(client22mcif_rd_req_pd)
,.dma2bpt_cdt_lat_fifo_pop(client22mcif_rd_cdt_lat_fifo_pop)
,.bpt2arb_req_valid(bpt2arb_req2_valid)
,.bpt2arb_req_ready(bpt2arb_req2_ready)
,.bpt2arb_req_pd(bpt2arb_req2_pd)
,.tieoff_axid(client22mcif_rd_axid)
,.tieoff_lat_fifo_depth(client22mcif_lat_fifo_depth)
);
NV_NVDLA_NOCIF_DRAM_READ_IG_bpt u_bpt3 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.dma2bpt_req_valid(client32mcif_rd_req_valid)
,.dma2bpt_req_ready(client32mcif_rd_req_ready)
,.dma2bpt_req_pd(client32mcif_rd_req_pd)
,.dma2bpt_cdt_lat_fifo_pop(client32mcif_rd_cdt_lat_fifo_pop)
,.bpt2arb_req_valid(bpt2arb_req3_valid)
,.bpt2arb_req_ready(bpt2arb_req3_ready)
,.bpt2arb_req_pd(bpt2arb_req3_pd)
,.tieoff_axid(client32mcif_rd_axid)
,.tieoff_lat_fifo_depth(client32mcif_lat_fifo_depth)
);
NV_NVDLA_NOCIF_DRAM_READ_IG_bpt u_bpt4 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.dma2bpt_req_valid(client42mcif_rd_req_valid)
,.dma2bpt_req_ready(client42mcif_rd_req_ready)
,.dma2bpt_req_pd(client42mcif_rd_req_pd)
,.dma2bpt_cdt_lat_fifo_pop(client42mcif_rd_cdt_lat_fifo_pop)
,.bpt2arb_req_valid(bpt2arb_req4_valid)
,.bpt2arb_req_ready(bpt2arb_req4_ready)
,.bpt2arb_req_pd(bpt2arb_req4_pd)
,.tieoff_axid(client42mcif_rd_axid)
,.tieoff_lat_fifo_depth(client42mcif_lat_fifo_depth)
);
NV_NVDLA_NOCIF_DRAM_READ_IG_bpt u_bpt5 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.dma2bpt_req_valid(client52mcif_rd_req_valid)
,.dma2bpt_req_ready(client52mcif_rd_req_ready)
,.dma2bpt_req_pd(client52mcif_rd_req_pd)
,.dma2bpt_cdt_lat_fifo_pop(client52mcif_rd_cdt_lat_fifo_pop)
,.bpt2arb_req_valid(bpt2arb_req5_valid)
,.bpt2arb_req_ready(bpt2arb_req5_ready)
,.bpt2arb_req_pd(bpt2arb_req5_pd)
,.tieoff_axid(client52mcif_rd_axid)
,.tieoff_lat_fifo_depth(client52mcif_lat_fifo_depth)
);
NV_NVDLA_NOCIF_DRAM_READ_IG_bpt u_bpt6 (
.nvdla_core_clk(nvdla_core_clk)
,.nvdla_core_rstn(nvdla_core_rstn)
,.dma2bpt_req_valid(client62mcif_rd_req_valid)
,.dma2bpt_req_ready(client62mcif_rd_req_ready)
,.dma2bpt_req_pd(client62mcif_rd_req_pd)
,.dma2bpt_cdt_lat_fifo_pop(client62mcif_rd_cdt_lat_fifo_pop)
,.bpt2arb_req_valid(bpt2arb_req6_valid)
,.bpt2arb_req_ready(bpt2arb_req6_ready)
,.bpt2arb_req_pd(bpt2arb_req6_pd)
,.tieoff_axid(client62mcif_rd_axid)
,.tieoff_lat_fifo_depth(client62mcif_lat_fifo_depth)
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [32 +10:0] spt2cvt_req_pd;
wire spt2cvt_req_valid;
wire spt2cvt_req_ready;
NV_NVDLA_NOCIF_DRAM_READ_IG_spt u_spt (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.arb2spt_req_valid (arb2spt_req_valid) //|< w
  ,.arb2spt_req_ready (arb2spt_req_ready) //|> w
  ,.arb2spt_req_pd (arb2spt_req_pd[32 +10:0]) //|< w
  ,.spt2cvt_req_valid (spt2cvt_req_valid) //|> w
  ,.spt2cvt_req_ready (spt2cvt_req_ready) //|< w
  ,.spt2cvt_req_pd (spt2cvt_req_pd[32 +10:0]) //|> w
  );
NV_NVDLA_NOCIF_DRAM_READ_IG_cvt u_cvt (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.spt2cvt_req_valid (spt2cvt_req_valid) //|< w
  ,.spt2cvt_req_ready (spt2cvt_req_ready) //|> w
  ,.spt2cvt_req_pd (spt2cvt_req_pd[32 +10:0]) //|< w
  ,.cq_wr_pvld (cq_wr_pvld) //|> o
  ,.cq_wr_prdy (cq_wr_prdy) //|< i
  ,.cq_wr_thread_id (cq_wr_thread_id[3:0]) //|> o
  ,.cq_wr_pd (cq_wr_pd[6:0]) //|> o
  ,.mcif2noc_axi_ar_arvalid (mcif2noc_axi_ar_arvalid) //|> o
  ,.mcif2noc_axi_ar_arready (mcif2noc_axi_ar_arready) //|< i
  ,.mcif2noc_axi_ar_arid (mcif2noc_axi_ar_arid[7:0]) //|> o
  ,.mcif2noc_axi_ar_arlen (mcif2noc_axi_ar_arlen[3:0]) //|> o
  ,.mcif2noc_axi_ar_araddr (mcif2noc_axi_ar_araddr[32 -1:0]) //|> o
  ,.reg2dp_rd_os_cnt (reg2dp_rd_os_cnt[7:0]) //|< i
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|< i
  );
NV_NVDLA_NOCIF_DRAM_READ_IG_arb u_arb (
   .nvdla_core_clk(nvdla_core_clk)
   ,.nvdla_core_rstn(nvdla_core_rstn)
//:my $k=7;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print(",.bpt2arb_req${i}_valid (bpt2arb_req${i}_valid)\n");
//:print(",.bpt2arb_req${i}_ready (bpt2arb_req${i}_ready)\n");
//:print(",.bpt2arb_req${i}_pd (bpt2arb_req${i}_pd)\n");
//:print(",.client${i}2mcif_rd_wt (client${i}2mcif_rd_wt)\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
,.bpt2arb_req0_valid (bpt2arb_req0_valid)
,.bpt2arb_req0_ready (bpt2arb_req0_ready)
,.bpt2arb_req0_pd (bpt2arb_req0_pd)
,.client02mcif_rd_wt (client02mcif_rd_wt)
,.bpt2arb_req1_valid (bpt2arb_req1_valid)
,.bpt2arb_req1_ready (bpt2arb_req1_ready)
,.bpt2arb_req1_pd (bpt2arb_req1_pd)
,.client12mcif_rd_wt (client12mcif_rd_wt)
,.bpt2arb_req2_valid (bpt2arb_req2_valid)
,.bpt2arb_req2_ready (bpt2arb_req2_ready)
,.bpt2arb_req2_pd (bpt2arb_req2_pd)
,.client22mcif_rd_wt (client22mcif_rd_wt)
,.bpt2arb_req3_valid (bpt2arb_req3_valid)
,.bpt2arb_req3_ready (bpt2arb_req3_ready)
,.bpt2arb_req3_pd (bpt2arb_req3_pd)
,.client32mcif_rd_wt (client32mcif_rd_wt)
,.bpt2arb_req4_valid (bpt2arb_req4_valid)
,.bpt2arb_req4_ready (bpt2arb_req4_ready)
,.bpt2arb_req4_pd (bpt2arb_req4_pd)
,.client42mcif_rd_wt (client42mcif_rd_wt)
,.bpt2arb_req5_valid (bpt2arb_req5_valid)
,.bpt2arb_req5_ready (bpt2arb_req5_ready)
,.bpt2arb_req5_pd (bpt2arb_req5_pd)
,.client52mcif_rd_wt (client52mcif_rd_wt)
,.bpt2arb_req6_valid (bpt2arb_req6_valid)
,.bpt2arb_req6_ready (bpt2arb_req6_ready)
,.bpt2arb_req6_pd (bpt2arb_req6_pd)
,.client62mcif_rd_wt (client62mcif_rd_wt)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.arb2spt_req_valid (arb2spt_req_valid) //|> w
  ,.arb2spt_req_ready (arb2spt_req_ready) //|< w
  ,.arb2spt_req_pd (arb2spt_req_pd[32 +10:0]) //|> w
);
endmodule // NV_NVDLA_NOCIF_READ_ig
