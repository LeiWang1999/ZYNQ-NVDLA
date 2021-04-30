// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_read.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
module NV_NVDLA_MCIF_read (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,pwrbus_ram_pd
  ,reg2dp_rd_os_cnt
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print("  ,reg2dp_rd_weight_${client}\n"),
//: }
//: foreach my $client (@rdma_name) {
//: print("  ,${client}2mcif_rd_cdt_lat_fifo_pop\n");
//: print("  ,${client}2mcif_rd_req_valid\n");
//: print("  ,${client}2mcif_rd_req_ready\n");
//: print("  ,${client}2mcif_rd_req_pd\n");
//: print("  ,mcif2${client}_rd_rsp_valid\n");
//: print("  ,mcif2${client}_rd_rsp_ready\n");
//: print("  ,mcif2${client}_rd_rsp_pd\n"),
//: }
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
  ,mcif2cdma_dat_rd_rsp_valid
  ,mcif2cdma_dat_rd_rsp_ready
  ,mcif2cdma_dat_rd_rsp_pd
  ,cdma_wt2mcif_rd_cdt_lat_fifo_pop
  ,cdma_wt2mcif_rd_req_valid
  ,cdma_wt2mcif_rd_req_ready
  ,cdma_wt2mcif_rd_req_pd
  ,mcif2cdma_wt_rd_rsp_valid
  ,mcif2cdma_wt_rd_rsp_ready
  ,mcif2cdma_wt_rd_rsp_pd
  ,sdp2mcif_rd_cdt_lat_fifo_pop
  ,sdp2mcif_rd_req_valid
  ,sdp2mcif_rd_req_ready
  ,sdp2mcif_rd_req_pd
  ,mcif2sdp_rd_rsp_valid
  ,mcif2sdp_rd_rsp_ready
  ,mcif2sdp_rd_rsp_pd
  ,sdp_b2mcif_rd_cdt_lat_fifo_pop
  ,sdp_b2mcif_rd_req_valid
  ,sdp_b2mcif_rd_req_ready
  ,sdp_b2mcif_rd_req_pd
  ,mcif2sdp_b_rd_rsp_valid
  ,mcif2sdp_b_rd_rsp_ready
  ,mcif2sdp_b_rd_rsp_pd
  ,sdp_n2mcif_rd_cdt_lat_fifo_pop
  ,sdp_n2mcif_rd_req_valid
  ,sdp_n2mcif_rd_req_ready
  ,sdp_n2mcif_rd_req_pd
  ,mcif2sdp_n_rd_rsp_valid
  ,mcif2sdp_n_rd_rsp_ready
  ,mcif2sdp_n_rd_rsp_pd
  ,pdp2mcif_rd_cdt_lat_fifo_pop
  ,pdp2mcif_rd_req_valid
  ,pdp2mcif_rd_req_ready
  ,pdp2mcif_rd_req_pd
  ,mcif2pdp_rd_rsp_valid
  ,mcif2pdp_rd_rsp_ready
  ,mcif2pdp_rd_rsp_pd
  ,cdp2mcif_rd_cdt_lat_fifo_pop
  ,cdp2mcif_rd_req_valid
  ,cdp2mcif_rd_req_ready
  ,cdp2mcif_rd_req_pd
  ,mcif2cdp_rd_rsp_valid
  ,mcif2cdp_rd_rsp_ready
  ,mcif2cdp_rd_rsp_pd

//| eperl: generated_end (DO NOT EDIT ABOVE)
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
input [31:0] pwrbus_ram_pd;
input [7:0] reg2dp_rd_os_cnt;
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print "input  [7:0] reg2dp_rd_weight_${client};\n";
//: }
//: foreach my $client (@rdma_name) {
//: print("input ${client}2mcif_rd_cdt_lat_fifo_pop;\n");
//: print("input ${client}2mcif_rd_req_valid;\n");
//: print("output ${client}2mcif_rd_req_ready;\n");
//: print qq(input [47 -1:0] ${client}2mcif_rd_req_pd;\n);
//: print("output mcif2${client}_rd_rsp_valid;\n");
//: print("input mcif2${client}_rd_rsp_ready;\n");
//: print qq(output [65 -1:0] mcif2${client}_rd_rsp_pd;\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
input  [7:0] reg2dp_rd_weight_cdma_dat;
input  [7:0] reg2dp_rd_weight_cdma_wt;
input  [7:0] reg2dp_rd_weight_sdp;
input  [7:0] reg2dp_rd_weight_sdp_b;
input  [7:0] reg2dp_rd_weight_sdp_n;
input  [7:0] reg2dp_rd_weight_pdp;
input  [7:0] reg2dp_rd_weight_cdp;
input cdma_dat2mcif_rd_cdt_lat_fifo_pop;
input cdma_dat2mcif_rd_req_valid;
output cdma_dat2mcif_rd_req_ready;
input [47 -1:0] cdma_dat2mcif_rd_req_pd;
output mcif2cdma_dat_rd_rsp_valid;
input mcif2cdma_dat_rd_rsp_ready;
output [65 -1:0] mcif2cdma_dat_rd_rsp_pd;
input cdma_wt2mcif_rd_cdt_lat_fifo_pop;
input cdma_wt2mcif_rd_req_valid;
output cdma_wt2mcif_rd_req_ready;
input [47 -1:0] cdma_wt2mcif_rd_req_pd;
output mcif2cdma_wt_rd_rsp_valid;
input mcif2cdma_wt_rd_rsp_ready;
output [65 -1:0] mcif2cdma_wt_rd_rsp_pd;
input sdp2mcif_rd_cdt_lat_fifo_pop;
input sdp2mcif_rd_req_valid;
output sdp2mcif_rd_req_ready;
input [47 -1:0] sdp2mcif_rd_req_pd;
output mcif2sdp_rd_rsp_valid;
input mcif2sdp_rd_rsp_ready;
output [65 -1:0] mcif2sdp_rd_rsp_pd;
input sdp_b2mcif_rd_cdt_lat_fifo_pop;
input sdp_b2mcif_rd_req_valid;
output sdp_b2mcif_rd_req_ready;
input [47 -1:0] sdp_b2mcif_rd_req_pd;
output mcif2sdp_b_rd_rsp_valid;
input mcif2sdp_b_rd_rsp_ready;
output [65 -1:0] mcif2sdp_b_rd_rsp_pd;
input sdp_n2mcif_rd_cdt_lat_fifo_pop;
input sdp_n2mcif_rd_req_valid;
output sdp_n2mcif_rd_req_ready;
input [47 -1:0] sdp_n2mcif_rd_req_pd;
output mcif2sdp_n_rd_rsp_valid;
input mcif2sdp_n_rd_rsp_ready;
output [65 -1:0] mcif2sdp_n_rd_rsp_pd;
input pdp2mcif_rd_cdt_lat_fifo_pop;
input pdp2mcif_rd_req_valid;
output pdp2mcif_rd_req_ready;
input [47 -1:0] pdp2mcif_rd_req_pd;
output mcif2pdp_rd_rsp_valid;
input mcif2pdp_rd_rsp_ready;
output [65 -1:0] mcif2pdp_rd_rsp_pd;
input cdp2mcif_rd_cdt_lat_fifo_pop;
input cdp2mcif_rd_req_valid;
output cdp2mcif_rd_req_ready;
input [47 -1:0] cdp2mcif_rd_req_pd;
output mcif2cdp_rd_rsp_valid;
input mcif2cdp_rd_rsp_ready;
output [65 -1:0] mcif2cdp_rd_rsp_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input noc2mcif_axi_r_rvalid;
output noc2mcif_axi_r_rready;
input [7:0] noc2mcif_axi_r_rid;
input noc2mcif_axi_r_rlast;
input [64 -1:0] noc2mcif_axi_r_rdata;
output mcif2noc_axi_ar_arvalid;
input mcif2noc_axi_ar_arready;
output [7:0] mcif2noc_axi_ar_arid;
output [3:0] mcif2noc_axi_ar_arlen;
output [32 -1:0] mcif2noc_axi_ar_araddr;
wire eg2ig_axi_vld;
NV_NVDLA_MCIF_READ_ig u_ig (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.reg2dp_rd_os_cnt (reg2dp_rd_os_cnt)
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print("  ,.reg2dp_rd_weight_${client} (reg2dp_rd_weight_${client})\n");
//: }
//: foreach my $client (@rdma_name) {
//: print (" ,.${client}2mcif_rd_cdt_lat_fifo_pop (${client}2mcif_rd_cdt_lat_fifo_pop)\n");
//: print (" ,.${client}2mcif_rd_req_valid (${client}2mcif_rd_req_valid)\n");
//: print (" ,.${client}2mcif_rd_req_ready (${client}2mcif_rd_req_ready)\n");
//: print (" ,.${client}2mcif_rd_req_pd    (${client}2mcif_rd_req_pd)\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,.reg2dp_rd_weight_cdma_dat (reg2dp_rd_weight_cdma_dat)
  ,.reg2dp_rd_weight_cdma_wt (reg2dp_rd_weight_cdma_wt)
  ,.reg2dp_rd_weight_sdp (reg2dp_rd_weight_sdp)
  ,.reg2dp_rd_weight_sdp_b (reg2dp_rd_weight_sdp_b)
  ,.reg2dp_rd_weight_sdp_n (reg2dp_rd_weight_sdp_n)
  ,.reg2dp_rd_weight_pdp (reg2dp_rd_weight_pdp)
  ,.reg2dp_rd_weight_cdp (reg2dp_rd_weight_cdp)
 ,.cdma_dat2mcif_rd_cdt_lat_fifo_pop (cdma_dat2mcif_rd_cdt_lat_fifo_pop)
 ,.cdma_dat2mcif_rd_req_valid (cdma_dat2mcif_rd_req_valid)
 ,.cdma_dat2mcif_rd_req_ready (cdma_dat2mcif_rd_req_ready)
 ,.cdma_dat2mcif_rd_req_pd    (cdma_dat2mcif_rd_req_pd)
 ,.cdma_wt2mcif_rd_cdt_lat_fifo_pop (cdma_wt2mcif_rd_cdt_lat_fifo_pop)
 ,.cdma_wt2mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid)
 ,.cdma_wt2mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready)
 ,.cdma_wt2mcif_rd_req_pd    (cdma_wt2mcif_rd_req_pd)
 ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
 ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
 ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
 ,.sdp2mcif_rd_req_pd    (sdp2mcif_rd_req_pd)
 ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
 ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
 ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
 ,.sdp_b2mcif_rd_req_pd    (sdp_b2mcif_rd_req_pd)
 ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
 ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
 ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
 ,.sdp_n2mcif_rd_req_pd    (sdp_n2mcif_rd_req_pd)
 ,.pdp2mcif_rd_cdt_lat_fifo_pop (pdp2mcif_rd_cdt_lat_fifo_pop)
 ,.pdp2mcif_rd_req_valid (pdp2mcif_rd_req_valid)
 ,.pdp2mcif_rd_req_ready (pdp2mcif_rd_req_ready)
 ,.pdp2mcif_rd_req_pd    (pdp2mcif_rd_req_pd)
 ,.cdp2mcif_rd_cdt_lat_fifo_pop (cdp2mcif_rd_cdt_lat_fifo_pop)
 ,.cdp2mcif_rd_req_valid (cdp2mcif_rd_req_valid)
 ,.cdp2mcif_rd_req_ready (cdp2mcif_rd_req_ready)
 ,.cdp2mcif_rd_req_pd    (cdp2mcif_rd_req_pd)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mcif2noc_axi_ar_arvalid (mcif2noc_axi_ar_arvalid) //|> o
  ,.mcif2noc_axi_ar_arready (mcif2noc_axi_ar_arready) //|< i
  ,.mcif2noc_axi_ar_arid (mcif2noc_axi_ar_arid[7:0]) //|> o
  ,.mcif2noc_axi_ar_arlen (mcif2noc_axi_ar_arlen[3:0]) //|> o
  ,.mcif2noc_axi_ar_araddr (mcif2noc_axi_ar_araddr) //|> o
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|> w
);
NV_NVDLA_MCIF_READ_eg u_eg (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|> w
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print(" ,.mcif2${client}_rd_rsp_valid(mcif2${client}_rd_rsp_valid)\n");
//: print(" ,.mcif2${client}_rd_rsp_ready(mcif2${client}_rd_rsp_ready)\n");
//: print(" ,.mcif2${client}_rd_rsp_pd(mcif2${client}_rd_rsp_pd)\n");
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
 ,.mcif2cdma_dat_rd_rsp_valid(mcif2cdma_dat_rd_rsp_valid)
 ,.mcif2cdma_dat_rd_rsp_ready(mcif2cdma_dat_rd_rsp_ready)
 ,.mcif2cdma_dat_rd_rsp_pd(mcif2cdma_dat_rd_rsp_pd)
 ,.mcif2cdma_wt_rd_rsp_valid(mcif2cdma_wt_rd_rsp_valid)
 ,.mcif2cdma_wt_rd_rsp_ready(mcif2cdma_wt_rd_rsp_ready)
 ,.mcif2cdma_wt_rd_rsp_pd(mcif2cdma_wt_rd_rsp_pd)
 ,.mcif2sdp_rd_rsp_valid(mcif2sdp_rd_rsp_valid)
 ,.mcif2sdp_rd_rsp_ready(mcif2sdp_rd_rsp_ready)
 ,.mcif2sdp_rd_rsp_pd(mcif2sdp_rd_rsp_pd)
 ,.mcif2sdp_b_rd_rsp_valid(mcif2sdp_b_rd_rsp_valid)
 ,.mcif2sdp_b_rd_rsp_ready(mcif2sdp_b_rd_rsp_ready)
 ,.mcif2sdp_b_rd_rsp_pd(mcif2sdp_b_rd_rsp_pd)
 ,.mcif2sdp_n_rd_rsp_valid(mcif2sdp_n_rd_rsp_valid)
 ,.mcif2sdp_n_rd_rsp_ready(mcif2sdp_n_rd_rsp_ready)
 ,.mcif2sdp_n_rd_rsp_pd(mcif2sdp_n_rd_rsp_pd)
 ,.mcif2pdp_rd_rsp_valid(mcif2pdp_rd_rsp_valid)
 ,.mcif2pdp_rd_rsp_ready(mcif2pdp_rd_rsp_ready)
 ,.mcif2pdp_rd_rsp_pd(mcif2pdp_rd_rsp_pd)
 ,.mcif2cdp_rd_rsp_valid(mcif2cdp_rd_rsp_valid)
 ,.mcif2cdp_rd_rsp_ready(mcif2cdp_rd_rsp_ready)
 ,.mcif2cdp_rd_rsp_pd(mcif2cdp_rd_rsp_pd)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.noc2mcif_axi_r_rvalid (noc2mcif_axi_r_rvalid) //|< i
  ,.noc2mcif_axi_r_rready (noc2mcif_axi_r_rready) //|> o
  ,.noc2mcif_axi_r_rid (noc2mcif_axi_r_rid[7:0]) //|< i
  ,.noc2mcif_axi_r_rlast (noc2mcif_axi_r_rlast) //|< i
  ,.noc2mcif_axi_r_rdata (noc2mcif_axi_r_rdata) //|< i
  );
endmodule
