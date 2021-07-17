// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_READ_ig.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
`include "NV_NVDLA_MCIF_define.vh"
module NV_NVDLA_MCIF_READ_ig (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd
  ,reg2dp_rd_os_cnt
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print("  ,reg2dp_rd_weight_${client}\n");
//: }
//: foreach my $client (@rdma_name) {
//: print ("  ,${client}2mcif_rd_cdt_lat_fifo_pop\n");
//: print ("  ,${client}2mcif_rd_req_valid\n");
//: print ("  ,${client}2mcif_rd_req_ready\n");
//: print ("  ,${client}2mcif_rd_req_pd\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,reg2dp_rd_weight_cdma_dat
  ,reg2dp_rd_weight_cdma_wt
  ,reg2dp_rd_weight_sdp
  ,reg2dp_rd_weight_sdp_b
  ,reg2dp_rd_weight_sdp_n
  ,reg2dp_rd_weight_pdp
  ,reg2dp_rd_weight_cdp
  ,cdma_dat2mcif_rd_cdt_lat_fifo_pop
  ,cdma_dat2mcif_rd_req_valid
  ,cdma_dat2mcif_rd_req_ready
  ,cdma_dat2mcif_rd_req_pd
  ,cdma_wt2mcif_rd_cdt_lat_fifo_pop
  ,cdma_wt2mcif_rd_req_valid
  ,cdma_wt2mcif_rd_req_ready
  ,cdma_wt2mcif_rd_req_pd
  ,sdp2mcif_rd_cdt_lat_fifo_pop
  ,sdp2mcif_rd_req_valid
  ,sdp2mcif_rd_req_ready
  ,sdp2mcif_rd_req_pd
  ,sdp_b2mcif_rd_cdt_lat_fifo_pop
  ,sdp_b2mcif_rd_req_valid
  ,sdp_b2mcif_rd_req_ready
  ,sdp_b2mcif_rd_req_pd
  ,sdp_n2mcif_rd_cdt_lat_fifo_pop
  ,sdp_n2mcif_rd_req_valid
  ,sdp_n2mcif_rd_req_ready
  ,sdp_n2mcif_rd_req_pd
  ,pdp2mcif_rd_cdt_lat_fifo_pop
  ,pdp2mcif_rd_req_valid
  ,pdp2mcif_rd_req_ready
  ,pdp2mcif_rd_req_pd
  ,cdp2mcif_rd_cdt_lat_fifo_pop
  ,cdp2mcif_rd_req_valid
  ,cdp2mcif_rd_req_ready
  ,cdp2mcif_rd_req_pd

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,eg2ig_axi_vld
  ,mcif2noc_axi_ar_araddr //|> o
  ,mcif2noc_axi_ar_arready //|< i
  ,mcif2noc_axi_ar_arid //|> o
  ,mcif2noc_axi_ar_arlen //|> o
  ,mcif2noc_axi_ar_arvalid //|> o
);
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input [7:0] reg2dp_rd_os_cnt;
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print("input  [7:0] reg2dp_rd_weight_${client};\n");
//: }
//: foreach my $client (@rdma_name) {
//: print ("input  ${client}2mcif_rd_cdt_lat_fifo_pop;\n");
//: print ("input  ${client}2mcif_rd_req_valid;\n");
//: print ("output ${client}2mcif_rd_req_ready;\n");
//: print qq(input [47 -1:0] ${client}2mcif_rd_req_pd;\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
input  [7:0] reg2dp_rd_weight_cdma_dat;
input  [7:0] reg2dp_rd_weight_cdma_wt;
input  [7:0] reg2dp_rd_weight_sdp;
input  [7:0] reg2dp_rd_weight_sdp_b;
input  [7:0] reg2dp_rd_weight_sdp_n;
input  [7:0] reg2dp_rd_weight_pdp;
input  [7:0] reg2dp_rd_weight_cdp;
input  cdma_dat2mcif_rd_cdt_lat_fifo_pop;
input  cdma_dat2mcif_rd_req_valid;
output cdma_dat2mcif_rd_req_ready;
input [47 -1:0] cdma_dat2mcif_rd_req_pd;
input  cdma_wt2mcif_rd_cdt_lat_fifo_pop;
input  cdma_wt2mcif_rd_req_valid;
output cdma_wt2mcif_rd_req_ready;
input [47 -1:0] cdma_wt2mcif_rd_req_pd;
input  sdp2mcif_rd_cdt_lat_fifo_pop;
input  sdp2mcif_rd_req_valid;
output sdp2mcif_rd_req_ready;
input [47 -1:0] sdp2mcif_rd_req_pd;
input  sdp_b2mcif_rd_cdt_lat_fifo_pop;
input  sdp_b2mcif_rd_req_valid;
output sdp_b2mcif_rd_req_ready;
input [47 -1:0] sdp_b2mcif_rd_req_pd;
input  sdp_n2mcif_rd_cdt_lat_fifo_pop;
input  sdp_n2mcif_rd_req_valid;
output sdp_n2mcif_rd_req_ready;
input [47 -1:0] sdp_n2mcif_rd_req_pd;
input  pdp2mcif_rd_cdt_lat_fifo_pop;
input  pdp2mcif_rd_req_valid;
output pdp2mcif_rd_req_ready;
input [47 -1:0] pdp2mcif_rd_req_pd;
input  cdp2mcif_rd_cdt_lat_fifo_pop;
input  cdp2mcif_rd_req_valid;
output cdp2mcif_rd_req_ready;
input [47 -1:0] cdp2mcif_rd_req_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output mcif2noc_axi_ar_arvalid;
input mcif2noc_axi_ar_arready;
output [7:0] mcif2noc_axi_ar_arid;
output [3:0] mcif2noc_axi_ar_arlen;
output [32 -1:0] mcif2noc_axi_ar_araddr;
input eg2ig_axi_vld;
//:for (my $i=0;$i<7;$i++) {
//: print qq(wire [32 +10:0] bpt2arb_req${i}_pd;\n);
//: print ("wire  bpt2arb_req${i}_ready;\n");
//: print ("wire  bpt2arb_req${i}_valid;\n");
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

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [32 +10:0] arb2spt_req_pd;
wire arb2spt_req_ready;
wire arb2spt_req_valid;
wire [32 +10:0] spt2cvt_req_pd;
wire spt2cvt_req_valid;
wire spt2cvt_req_ready;
//---------------------read_bpt inst--------------------------------//
//: my $i = 0;
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print("NV_NVDLA_MCIF_READ_IG_bpt u_bpt${i} (\n");
//: print ("   .nvdla_core_clk(nvdla_core_clk)\n");
//: print ("  ,.nvdla_core_rstn(nvdla_core_rstn)\n");
//: print ("  ,.dma2bpt_cdt_lat_fifo_pop(${client}2mcif_rd_cdt_lat_fifo_pop)\n");
//: print ("  ,.dma2bpt_req_valid(${client}2mcif_rd_req_valid)\n");
//: print ("  ,.dma2bpt_req_ready(${client}2mcif_rd_req_ready)\n");
//: print ("  ,.dma2bpt_req_pd(${client}2mcif_rd_req_pd)\n");
//: print ("  ,.bpt2arb_req_valid(bpt2arb_req${i}_valid)\n");
//: print ("  ,.bpt2arb_req_ready(bpt2arb_req${i}_ready)\n");
//: print ("  ,.bpt2arb_req_pd(bpt2arb_req${i}_pd)\n");
//: print ("  ,.tieoff_axid(`tieoff_axid_${client})\n");
//: print ("  ,.tieoff_lat_fifo_depth(`tieoff_depth_${client})\n");
//: print (");\n");
//: $i++;
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
NV_NVDLA_MCIF_READ_IG_bpt u_bpt0 (
   .nvdla_core_clk(nvdla_core_clk)
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.dma2bpt_cdt_lat_fifo_pop(cdma_dat2mcif_rd_cdt_lat_fifo_pop)
  ,.dma2bpt_req_valid(cdma_dat2mcif_rd_req_valid)
  ,.dma2bpt_req_ready(cdma_dat2mcif_rd_req_ready)
  ,.dma2bpt_req_pd(cdma_dat2mcif_rd_req_pd)
  ,.bpt2arb_req_valid(bpt2arb_req0_valid)
  ,.bpt2arb_req_ready(bpt2arb_req0_ready)
  ,.bpt2arb_req_pd(bpt2arb_req0_pd)
  ,.tieoff_axid(`tieoff_axid_cdma_dat)
  ,.tieoff_lat_fifo_depth(`tieoff_depth_cdma_dat)
);
NV_NVDLA_MCIF_READ_IG_bpt u_bpt1 (
   .nvdla_core_clk(nvdla_core_clk)
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.dma2bpt_cdt_lat_fifo_pop(cdma_wt2mcif_rd_cdt_lat_fifo_pop)
  ,.dma2bpt_req_valid(cdma_wt2mcif_rd_req_valid)
  ,.dma2bpt_req_ready(cdma_wt2mcif_rd_req_ready)
  ,.dma2bpt_req_pd(cdma_wt2mcif_rd_req_pd)
  ,.bpt2arb_req_valid(bpt2arb_req1_valid)
  ,.bpt2arb_req_ready(bpt2arb_req1_ready)
  ,.bpt2arb_req_pd(bpt2arb_req1_pd)
  ,.tieoff_axid(`tieoff_axid_cdma_wt)
  ,.tieoff_lat_fifo_depth(`tieoff_depth_cdma_wt)
);
NV_NVDLA_MCIF_READ_IG_bpt u_bpt2 (
   .nvdla_core_clk(nvdla_core_clk)
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.dma2bpt_cdt_lat_fifo_pop(sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.dma2bpt_req_valid(sdp2mcif_rd_req_valid)
  ,.dma2bpt_req_ready(sdp2mcif_rd_req_ready)
  ,.dma2bpt_req_pd(sdp2mcif_rd_req_pd)
  ,.bpt2arb_req_valid(bpt2arb_req2_valid)
  ,.bpt2arb_req_ready(bpt2arb_req2_ready)
  ,.bpt2arb_req_pd(bpt2arb_req2_pd)
  ,.tieoff_axid(`tieoff_axid_sdp)
  ,.tieoff_lat_fifo_depth(`tieoff_depth_sdp)
);
NV_NVDLA_MCIF_READ_IG_bpt u_bpt3 (
   .nvdla_core_clk(nvdla_core_clk)
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.dma2bpt_cdt_lat_fifo_pop(sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.dma2bpt_req_valid(sdp_b2mcif_rd_req_valid)
  ,.dma2bpt_req_ready(sdp_b2mcif_rd_req_ready)
  ,.dma2bpt_req_pd(sdp_b2mcif_rd_req_pd)
  ,.bpt2arb_req_valid(bpt2arb_req3_valid)
  ,.bpt2arb_req_ready(bpt2arb_req3_ready)
  ,.bpt2arb_req_pd(bpt2arb_req3_pd)
  ,.tieoff_axid(`tieoff_axid_sdp_b)
  ,.tieoff_lat_fifo_depth(`tieoff_depth_sdp_b)
);
NV_NVDLA_MCIF_READ_IG_bpt u_bpt4 (
   .nvdla_core_clk(nvdla_core_clk)
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.dma2bpt_cdt_lat_fifo_pop(sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.dma2bpt_req_valid(sdp_n2mcif_rd_req_valid)
  ,.dma2bpt_req_ready(sdp_n2mcif_rd_req_ready)
  ,.dma2bpt_req_pd(sdp_n2mcif_rd_req_pd)
  ,.bpt2arb_req_valid(bpt2arb_req4_valid)
  ,.bpt2arb_req_ready(bpt2arb_req4_ready)
  ,.bpt2arb_req_pd(bpt2arb_req4_pd)
  ,.tieoff_axid(`tieoff_axid_sdp_n)
  ,.tieoff_lat_fifo_depth(`tieoff_depth_sdp_n)
);
NV_NVDLA_MCIF_READ_IG_bpt u_bpt5 (
   .nvdla_core_clk(nvdla_core_clk)
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.dma2bpt_cdt_lat_fifo_pop(pdp2mcif_rd_cdt_lat_fifo_pop)
  ,.dma2bpt_req_valid(pdp2mcif_rd_req_valid)
  ,.dma2bpt_req_ready(pdp2mcif_rd_req_ready)
  ,.dma2bpt_req_pd(pdp2mcif_rd_req_pd)
  ,.bpt2arb_req_valid(bpt2arb_req5_valid)
  ,.bpt2arb_req_ready(bpt2arb_req5_ready)
  ,.bpt2arb_req_pd(bpt2arb_req5_pd)
  ,.tieoff_axid(`tieoff_axid_pdp)
  ,.tieoff_lat_fifo_depth(`tieoff_depth_pdp)
);
NV_NVDLA_MCIF_READ_IG_bpt u_bpt6 (
   .nvdla_core_clk(nvdla_core_clk)
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.dma2bpt_cdt_lat_fifo_pop(cdp2mcif_rd_cdt_lat_fifo_pop)
  ,.dma2bpt_req_valid(cdp2mcif_rd_req_valid)
  ,.dma2bpt_req_ready(cdp2mcif_rd_req_ready)
  ,.dma2bpt_req_pd(cdp2mcif_rd_req_pd)
  ,.bpt2arb_req_valid(bpt2arb_req6_valid)
  ,.bpt2arb_req_ready(bpt2arb_req6_ready)
  ,.bpt2arb_req_pd(bpt2arb_req6_pd)
  ,.tieoff_axid(`tieoff_axid_cdp)
  ,.tieoff_lat_fifo_depth(`tieoff_depth_cdp)
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
NV_NVDLA_MCIF_READ_IG_arb u_arb (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//: my $i = 0;
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print("  ,.reg2dp_rd_weight${i}(reg2dp_rd_weight_${client})\n");
//: $i++;
//: }
//: $i = 0;
//: foreach my $client (@rdma_name) {
//: print("  ,.bpt2arb_req${i}_valid(bpt2arb_req${i}_valid)\n");
//: print("  ,.bpt2arb_req${i}_ready(bpt2arb_req${i}_ready)\n");
//: print("  ,.bpt2arb_req${i}_pd(bpt2arb_req${i}_pd)\n");
//: $i++;
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,.reg2dp_rd_weight0(reg2dp_rd_weight_cdma_dat)
  ,.reg2dp_rd_weight1(reg2dp_rd_weight_cdma_wt)
  ,.reg2dp_rd_weight2(reg2dp_rd_weight_sdp)
  ,.reg2dp_rd_weight3(reg2dp_rd_weight_sdp_b)
  ,.reg2dp_rd_weight4(reg2dp_rd_weight_sdp_n)
  ,.reg2dp_rd_weight5(reg2dp_rd_weight_pdp)
  ,.reg2dp_rd_weight6(reg2dp_rd_weight_cdp)
  ,.bpt2arb_req0_valid(bpt2arb_req0_valid)
  ,.bpt2arb_req0_ready(bpt2arb_req0_ready)
  ,.bpt2arb_req0_pd(bpt2arb_req0_pd)
  ,.bpt2arb_req1_valid(bpt2arb_req1_valid)
  ,.bpt2arb_req1_ready(bpt2arb_req1_ready)
  ,.bpt2arb_req1_pd(bpt2arb_req1_pd)
  ,.bpt2arb_req2_valid(bpt2arb_req2_valid)
  ,.bpt2arb_req2_ready(bpt2arb_req2_ready)
  ,.bpt2arb_req2_pd(bpt2arb_req2_pd)
  ,.bpt2arb_req3_valid(bpt2arb_req3_valid)
  ,.bpt2arb_req3_ready(bpt2arb_req3_ready)
  ,.bpt2arb_req3_pd(bpt2arb_req3_pd)
  ,.bpt2arb_req4_valid(bpt2arb_req4_valid)
  ,.bpt2arb_req4_ready(bpt2arb_req4_ready)
  ,.bpt2arb_req4_pd(bpt2arb_req4_pd)
  ,.bpt2arb_req5_valid(bpt2arb_req5_valid)
  ,.bpt2arb_req5_ready(bpt2arb_req5_ready)
  ,.bpt2arb_req5_pd(bpt2arb_req5_pd)
  ,.bpt2arb_req6_valid(bpt2arb_req6_valid)
  ,.bpt2arb_req6_ready(bpt2arb_req6_ready)
  ,.bpt2arb_req6_pd(bpt2arb_req6_pd)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.arb2spt_req_valid (arb2spt_req_valid) //|> w
  ,.arb2spt_req_ready (arb2spt_req_ready) //|< w
  ,.arb2spt_req_pd (arb2spt_req_pd) //|> w
);
/*
NV_NVDLA_MCIF_READ_IG_spt u_spt (
   .nvdla_core_clk            (nvdla_core_clk)                 //|< i
  ,.nvdla_core_rstn           (nvdla_core_rstn)                //|< i
  ,.arb2spt_req_valid         (arb2spt_req_valid)              //|< w
  ,.arb2spt_req_ready         (arb2spt_req_ready)              //|> w
  ,.arb2spt_req_pd            (arb2spt_req_pd)                 //|< w
  ,.spt2cvt_req_valid         (spt2cvt_req_valid)              //|> w
  ,.spt2cvt_req_ready         (spt2cvt_req_ready)              //|< w
  ,.spt2cvt_req_pd            (spt2cvt_req_pd)                 //|> w
  );
*/
NV_NVDLA_MCIF_READ_IG_cvt u_cvt (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.reg2dp_rd_os_cnt (reg2dp_rd_os_cnt[7:0]) //|< i
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|< i
  ,.spt2cvt_req_valid (arb2spt_req_valid) //|< w
  ,.spt2cvt_req_ready (arb2spt_req_ready) //|> w
  ,.spt2cvt_req_pd (arb2spt_req_pd) //|< w
  ,.mcif2noc_axi_ar_arvalid (mcif2noc_axi_ar_arvalid) //|> o
  ,.mcif2noc_axi_ar_arready (mcif2noc_axi_ar_arready) //|< i
  ,.mcif2noc_axi_ar_arid (mcif2noc_axi_ar_arid[7:0]) //|> o
  ,.mcif2noc_axi_ar_arlen (mcif2noc_axi_ar_arlen[3:0]) //|> o
  ,.mcif2noc_axi_ar_araddr (mcif2noc_axi_ar_araddr) //|> o
  );
endmodule
