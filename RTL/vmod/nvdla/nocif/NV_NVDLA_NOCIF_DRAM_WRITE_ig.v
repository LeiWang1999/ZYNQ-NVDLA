// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_NOCIF_DRAM_WRITE_ig.v
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
module NV_NVDLA_NOCIF_DRAM_WRITE_ig (
  nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd
  ,reg2dp_wr_os_cnt
//:my $k=3;
//:my $i;
//:for($i=0;$i<$k;$i++) {
//:print qq(
//:,client${i}2mcif_wr_req_pd
//:,client${i}2mcif_wr_req_valid
//:,client${i}2mcif_wr_req_ready
//:,client${i}2mcif_wr_wt
//:,client${i}2mcif_wr_axid
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

,client02mcif_wr_req_pd
,client02mcif_wr_req_valid
,client02mcif_wr_req_ready
,client02mcif_wr_wt
,client02mcif_wr_axid

,client12mcif_wr_req_pd
,client12mcif_wr_req_valid
,client12mcif_wr_req_ready
,client12mcif_wr_wt
,client12mcif_wr_axid

,client22mcif_wr_req_pd
,client22mcif_wr_req_valid
,client22mcif_wr_req_ready
,client22mcif_wr_wt
,client22mcif_wr_axid

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,cq_wr_pvld
  ,cq_wr_prdy
  ,cq_wr_thread_id
  ,cq_wr_pd
  ,mcif2noc_axi_aw_awvalid
  ,mcif2noc_axi_aw_awready
  ,mcif2noc_axi_aw_awid
  ,mcif2noc_axi_aw_awlen
  ,mcif2noc_axi_aw_awaddr
  ,mcif2noc_axi_w_wvalid
  ,mcif2noc_axi_w_wready
  ,mcif2noc_axi_w_wdata
  ,mcif2noc_axi_w_wstrb
  ,mcif2noc_axi_w_wlast
  ,eg2ig_axi_len
  ,eg2ig_axi_vld
  );
//:my $i;
//:for($i=0;$i<3;$i++) {
//:print qq(
//:input client${i}2mcif_wr_req_valid;
//:output client${i}2mcif_wr_req_ready;
//:input [64 +(( 64 )/8/8):0] client${i}2mcif_wr_req_pd;
//:input [7:0] client${i}2mcif_wr_wt;
//:input [3:0] client${i}2mcif_wr_axid;
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

input client02mcif_wr_req_valid;
output client02mcif_wr_req_ready;
input [64 +(( 64 )/8/8):0] client02mcif_wr_req_pd;
input [7:0] client02mcif_wr_wt;
input [3:0] client02mcif_wr_axid;

input client12mcif_wr_req_valid;
output client12mcif_wr_req_ready;
input [64 +(( 64 )/8/8):0] client12mcif_wr_req_pd;
input [7:0] client12mcif_wr_wt;
input [3:0] client12mcif_wr_axid;

input client22mcif_wr_req_valid;
output client22mcif_wr_req_ready;
input [64 +(( 64 )/8/8):0] client22mcif_wr_req_pd;
input [7:0] client22mcif_wr_wt;
input [3:0] client22mcif_wr_axid;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input [7:0] reg2dp_wr_os_cnt;
input [1:0] eg2ig_axi_len;
input eg2ig_axi_vld;
output cq_wr_pvld; /* data valid */
input cq_wr_prdy; /* data return handshake */
output [3:0] cq_wr_thread_id;
output [2:0] cq_wr_pd;
output mcif2noc_axi_aw_awvalid; /* data valid */
input mcif2noc_axi_aw_awready; /* data return handshake */
output [7:0] mcif2noc_axi_aw_awid;
output [3:0] mcif2noc_axi_aw_awlen;
output [32 -1:0] mcif2noc_axi_aw_awaddr;
output mcif2noc_axi_w_wvalid; /* data valid */
input mcif2noc_axi_w_wready; /* data return handshake */
output [64 -1:0] mcif2noc_axi_w_wdata;
output [64/8-1:0] mcif2noc_axi_w_wstrb;
output mcif2noc_axi_w_wlast;
//:my $i;
//:for($i=0;$i<3;$i++) {
//:print qq(
//:wire bpt2arb_cmd${i}_valid;
//:wire bpt2arb_cmd${i}_ready;
//:wire [32 +12:0] bpt2arb_cmd${i}_pd;
//:wire bpt2arb_dat${i}_valid;
//:wire bpt2arb_dat${i}_ready;
//:wire [64 +1:0] bpt2arb_dat${i}_pd;
//:NV_NVDLA_NOCIF_DRAM_WRITE_IG_bpt u_bpt${i} (
//:.nvdla_core_clk (nvdla_core_clk)
//:,.nvdla_core_rstn (nvdla_core_rstn)
//:,.dma2bpt_req_valid (client${i}2mcif_wr_req_valid)
//:,.dma2bpt_req_ready (client${i}2mcif_wr_req_ready)
//:,.dma2bpt_req_pd (client${i}2mcif_wr_req_pd)
//:,.bpt2arb_cmd_valid (bpt2arb_cmd${i}_valid)
//:,.bpt2arb_cmd_ready (bpt2arb_cmd${i}_ready)
//:,.bpt2arb_cmd_pd (bpt2arb_cmd${i}_pd)
//:,.bpt2arb_dat_valid (bpt2arb_dat${i}_valid)
//:,.bpt2arb_dat_ready (bpt2arb_dat${i}_ready)
//:,.bpt2arb_dat_pd (bpt2arb_dat${i}_pd)
//:,.pwrbus_ram_pd (pwrbus_ram_pd)
//:,.axid (client${i}2mcif_wr_axid)
//:);
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire bpt2arb_cmd0_valid;
wire bpt2arb_cmd0_ready;
wire [32 +12:0] bpt2arb_cmd0_pd;
wire bpt2arb_dat0_valid;
wire bpt2arb_dat0_ready;
wire [64 +1:0] bpt2arb_dat0_pd;
NV_NVDLA_NOCIF_DRAM_WRITE_IG_bpt u_bpt0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma2bpt_req_valid (client02mcif_wr_req_valid)
,.dma2bpt_req_ready (client02mcif_wr_req_ready)
,.dma2bpt_req_pd (client02mcif_wr_req_pd)
,.bpt2arb_cmd_valid (bpt2arb_cmd0_valid)
,.bpt2arb_cmd_ready (bpt2arb_cmd0_ready)
,.bpt2arb_cmd_pd (bpt2arb_cmd0_pd)
,.bpt2arb_dat_valid (bpt2arb_dat0_valid)
,.bpt2arb_dat_ready (bpt2arb_dat0_ready)
,.bpt2arb_dat_pd (bpt2arb_dat0_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd)
,.axid (client02mcif_wr_axid)
);

wire bpt2arb_cmd1_valid;
wire bpt2arb_cmd1_ready;
wire [32 +12:0] bpt2arb_cmd1_pd;
wire bpt2arb_dat1_valid;
wire bpt2arb_dat1_ready;
wire [64 +1:0] bpt2arb_dat1_pd;
NV_NVDLA_NOCIF_DRAM_WRITE_IG_bpt u_bpt1 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma2bpt_req_valid (client12mcif_wr_req_valid)
,.dma2bpt_req_ready (client12mcif_wr_req_ready)
,.dma2bpt_req_pd (client12mcif_wr_req_pd)
,.bpt2arb_cmd_valid (bpt2arb_cmd1_valid)
,.bpt2arb_cmd_ready (bpt2arb_cmd1_ready)
,.bpt2arb_cmd_pd (bpt2arb_cmd1_pd)
,.bpt2arb_dat_valid (bpt2arb_dat1_valid)
,.bpt2arb_dat_ready (bpt2arb_dat1_ready)
,.bpt2arb_dat_pd (bpt2arb_dat1_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd)
,.axid (client12mcif_wr_axid)
);

wire bpt2arb_cmd2_valid;
wire bpt2arb_cmd2_ready;
wire [32 +12:0] bpt2arb_cmd2_pd;
wire bpt2arb_dat2_valid;
wire bpt2arb_dat2_ready;
wire [64 +1:0] bpt2arb_dat2_pd;
NV_NVDLA_NOCIF_DRAM_WRITE_IG_bpt u_bpt2 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma2bpt_req_valid (client22mcif_wr_req_valid)
,.dma2bpt_req_ready (client22mcif_wr_req_ready)
,.dma2bpt_req_pd (client22mcif_wr_req_pd)
,.bpt2arb_cmd_valid (bpt2arb_cmd2_valid)
,.bpt2arb_cmd_ready (bpt2arb_cmd2_ready)
,.bpt2arb_cmd_pd (bpt2arb_cmd2_pd)
,.bpt2arb_dat_valid (bpt2arb_dat2_valid)
,.bpt2arb_dat_ready (bpt2arb_dat2_ready)
,.bpt2arb_dat_pd (bpt2arb_dat2_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd)
,.axid (client22mcif_wr_axid)
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [32 +12:0] arb2spt_cmd_pd;
wire [64 +1:0] arb2spt_dat_pd;
wire arb2spt_cmd_valid, arb2spt_cmd_ready;
wire spt2cvt_cmd_valid, spt2cvt_cmd_ready;
NV_NVDLA_NOCIF_DRAM_WRITE_IG_arb u_arb (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//:my $i;
//:for($i=0;$i<3;$i++) {
//:print qq(
//:,.bpt2arb_cmd${i}_valid (bpt2arb_cmd${i}_valid)
//:,.bpt2arb_cmd${i}_ready (bpt2arb_cmd${i}_ready)
//:,.bpt2arb_cmd${i}_pd (bpt2arb_cmd${i}_pd)
//:,.bpt2arb_dat${i}_valid (bpt2arb_dat${i}_valid)
//:,.bpt2arb_dat${i}_ready (bpt2arb_dat${i}_ready)
//:,.bpt2arb_dat${i}_pd (bpt2arb_dat${i}_pd)
//:,.client${i}2mcif_wr_wt (client${i}2mcif_wr_wt)
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.bpt2arb_cmd0_valid (bpt2arb_cmd0_valid)
,.bpt2arb_cmd0_ready (bpt2arb_cmd0_ready)
,.bpt2arb_cmd0_pd (bpt2arb_cmd0_pd)
,.bpt2arb_dat0_valid (bpt2arb_dat0_valid)
,.bpt2arb_dat0_ready (bpt2arb_dat0_ready)
,.bpt2arb_dat0_pd (bpt2arb_dat0_pd)
,.client02mcif_wr_wt (client02mcif_wr_wt)

,.bpt2arb_cmd1_valid (bpt2arb_cmd1_valid)
,.bpt2arb_cmd1_ready (bpt2arb_cmd1_ready)
,.bpt2arb_cmd1_pd (bpt2arb_cmd1_pd)
,.bpt2arb_dat1_valid (bpt2arb_dat1_valid)
,.bpt2arb_dat1_ready (bpt2arb_dat1_ready)
,.bpt2arb_dat1_pd (bpt2arb_dat1_pd)
,.client12mcif_wr_wt (client12mcif_wr_wt)

,.bpt2arb_cmd2_valid (bpt2arb_cmd2_valid)
,.bpt2arb_cmd2_ready (bpt2arb_cmd2_ready)
,.bpt2arb_cmd2_pd (bpt2arb_cmd2_pd)
,.bpt2arb_dat2_valid (bpt2arb_dat2_valid)
,.bpt2arb_dat2_ready (bpt2arb_dat2_ready)
,.bpt2arb_dat2_pd (bpt2arb_dat2_pd)
,.client22mcif_wr_wt (client22mcif_wr_wt)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.arb2spt_cmd_valid (arb2spt_cmd_valid) //|> w
  ,.arb2spt_cmd_ready (arb2spt_cmd_ready) //|< w
  ,.arb2spt_cmd_pd (arb2spt_cmd_pd[32 +12:0]) //|> w
  ,.arb2spt_dat_valid (arb2spt_dat_valid) //|> w
  ,.arb2spt_dat_ready (arb2spt_dat_ready) //|< w
  ,.arb2spt_dat_pd (arb2spt_dat_pd[64 +1:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|<
);
wire [32 +12:0] spt2cvt_cmd_pd;
wire [64 +1:0] spt2cvt_dat_pd;
NV_NVDLA_NOCIF_DRAM_WRITE_IG_spt u_spt (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.arb2spt_cmd_valid (arb2spt_cmd_valid) //|< w
  ,.arb2spt_cmd_ready (arb2spt_cmd_ready) //|> w
  ,.arb2spt_cmd_pd (arb2spt_cmd_pd[32 +12:0]) //|< w
  ,.arb2spt_dat_valid (arb2spt_dat_valid) //|< w
  ,.arb2spt_dat_ready (arb2spt_dat_ready) //|> w
  ,.arb2spt_dat_pd (arb2spt_dat_pd[64 +1:0]) //|< w
  ,.spt2cvt_cmd_valid (spt2cvt_cmd_valid) //|> w
  ,.spt2cvt_cmd_ready (spt2cvt_cmd_ready) //|< w
  ,.spt2cvt_cmd_pd (spt2cvt_cmd_pd[32 +12:0]) //|> w
  ,.spt2cvt_dat_valid (spt2cvt_dat_valid) //|> w
  ,.spt2cvt_dat_ready (spt2cvt_dat_ready) //|< w
  ,.spt2cvt_dat_pd (spt2cvt_dat_pd[64 +1:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  );
NV_NVDLA_NOCIF_DRAM_WRITE_IG_cvt u_cvt (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.spt2cvt_cmd_valid (spt2cvt_cmd_valid) //|< w
  ,.spt2cvt_cmd_ready (spt2cvt_cmd_ready) //|> w
  ,.spt2cvt_cmd_pd (spt2cvt_cmd_pd[32 +12:0]) //|< w
  ,.spt2cvt_dat_valid (spt2cvt_dat_valid) //|< w
  ,.spt2cvt_dat_ready (spt2cvt_dat_ready) //|> w
  ,.spt2cvt_dat_pd (spt2cvt_dat_pd[64 +1:0]) //|< w
  ,.cq_wr_pvld (cq_wr_pvld) //|> o
  ,.cq_wr_prdy (cq_wr_prdy) //|< i
  ,.cq_wr_thread_id (cq_wr_thread_id[3:0]) //|> o
  ,.cq_wr_pd (cq_wr_pd[2:0]) //|> o
  ,.mcif2noc_axi_aw_awvalid (mcif2noc_axi_aw_awvalid) //|> o
  ,.mcif2noc_axi_aw_awready (mcif2noc_axi_aw_awready) //|< i
  ,.mcif2noc_axi_aw_awid (mcif2noc_axi_aw_awid[7:0]) //|> o
  ,.mcif2noc_axi_aw_awlen (mcif2noc_axi_aw_awlen[3:0]) //|> o
  ,.mcif2noc_axi_aw_awaddr (mcif2noc_axi_aw_awaddr[32 -1:0]) //|> o
  ,.mcif2noc_axi_w_wvalid (mcif2noc_axi_w_wvalid) //|> o
  ,.mcif2noc_axi_w_wready (mcif2noc_axi_w_wready) //|< i
  ,.mcif2noc_axi_w_wdata (mcif2noc_axi_w_wdata[64 -1:0]) //|> o
  ,.mcif2noc_axi_w_wstrb (mcif2noc_axi_w_wstrb[64/8-1:0]) //|> o
  ,.mcif2noc_axi_w_wlast (mcif2noc_axi_w_wlast) //|> o
  ,.eg2ig_axi_len (eg2ig_axi_len[1:0]) //|< i
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|< i
  ,.reg2dp_wr_os_cnt (reg2dp_wr_os_cnt[7:0]) //|< i
  );
endmodule
