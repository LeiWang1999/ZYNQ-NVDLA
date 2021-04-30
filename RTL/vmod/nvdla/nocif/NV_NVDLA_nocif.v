// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_nocif.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
module NV_NVDLA_nocif (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,pwrbus_ram_pd
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print "  ,${client}2mcif_rd_cdt_lat_fifo_pop\n";
//: print "  ,${client}2mcif_rd_req_valid\n";
//: print "  ,${client}2mcif_rd_req_ready\n";
//: print "  ,${client}2mcif_rd_req_pd\n";
//: print "  ,mcif2${client}_rd_rsp_valid\n";
//: print "  ,mcif2${client}_rd_rsp_ready\n";
//: print "  ,mcif2${client}_rd_rsp_pd\n";
//: }
//: my @wdma_name = ("sdp", "pdp","cdp");
//: foreach my $client (@wdma_name) {
//: print "  ,${client}2mcif_wr_req_valid\n";
//: print "  ,${client}2mcif_wr_req_ready\n";
//: print "  ,${client}2mcif_wr_req_pd\n";
//: print "  ,mcif2${client}_wr_rsp_complete\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
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
  ,sdp2mcif_wr_req_valid
  ,sdp2mcif_wr_req_ready
  ,sdp2mcif_wr_req_pd
  ,mcif2sdp_wr_rsp_complete
  ,pdp2mcif_wr_req_valid
  ,pdp2mcif_wr_req_ready
  ,pdp2mcif_wr_req_pd
  ,mcif2pdp_wr_rsp_complete
  ,cdp2mcif_wr_req_valid
  ,cdp2mcif_wr_req_ready
  ,cdp2mcif_wr_req_pd
  ,mcif2cdp_wr_rsp_complete

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,csb2mcif_req_pd //|< i
  ,csb2mcif_req_pvld //|< i
  ,csb2mcif_req_prdy //|> o
  ,mcif2csb_resp_pd //|> o
  ,mcif2csb_resp_valid //|> o
  ,noc2mcif_axi_b_bid //|< i
  ,noc2mcif_axi_b_bvalid //|< i
  ,noc2mcif_axi_r_rdata //|< i
  ,noc2mcif_axi_r_rid //|< i
  ,noc2mcif_axi_r_rlast //|< i
  ,noc2mcif_axi_r_rvalid //|< i
  ,mcif2noc_axi_ar_arready //|< i
  ,mcif2noc_axi_aw_awready //|< i
  ,mcif2noc_axi_w_wready //|< i
  ,mcif2noc_axi_ar_araddr //|> o
  ,mcif2noc_axi_ar_arid //|> o
  ,mcif2noc_axi_ar_arlen //|> o
  ,mcif2noc_axi_ar_arvalid //|> o
  ,mcif2noc_axi_aw_awaddr //|> o
  ,mcif2noc_axi_aw_awid //|> o
  ,mcif2noc_axi_aw_awlen //|> o
  ,mcif2noc_axi_aw_awvalid //|> o
  ,mcif2noc_axi_w_wdata //|> o
  ,mcif2noc_axi_w_wlast //|> o
  ,mcif2noc_axi_w_wstrb //|> o
  ,mcif2noc_axi_w_wvalid //|> o
  ,noc2mcif_axi_b_bready //|> o
  ,noc2mcif_axi_r_rready //|> o
);
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print ("input  ${client}2mcif_rd_cdt_lat_fifo_pop;\n");
//: print ("input  ${client}2mcif_rd_req_valid;\n");
//: print ("output ${client}2mcif_rd_req_ready;\n");
//: print qq(input [47 -1:0] ${client}2mcif_rd_req_pd;\n);
//: print ("output mcif2${client}_rd_rsp_valid;\n");
//: print ("input  mcif2${client}_rd_rsp_ready;\n");
//: print qq(output [65 -1:0] mcif2${client}_rd_rsp_pd;\n);
//: }
//: my @wdma_name = ("sdp", "pdp","cdp");
//: foreach my $client (@wdma_name) {
//: print ("input  ${client}2mcif_wr_req_valid;\n");
//: print ("output ${client}2mcif_wr_req_ready;\n");
//: print qq(input [66 -1:0] ${client}2mcif_wr_req_pd;\n);
//: print ("output mcif2${client}_wr_rsp_complete;\n");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
input  cdma_dat2mcif_rd_cdt_lat_fifo_pop;
input  cdma_dat2mcif_rd_req_valid;
output cdma_dat2mcif_rd_req_ready;
input [47 -1:0] cdma_dat2mcif_rd_req_pd;
output mcif2cdma_dat_rd_rsp_valid;
input  mcif2cdma_dat_rd_rsp_ready;
output [65 -1:0] mcif2cdma_dat_rd_rsp_pd;
input  cdma_wt2mcif_rd_cdt_lat_fifo_pop;
input  cdma_wt2mcif_rd_req_valid;
output cdma_wt2mcif_rd_req_ready;
input [47 -1:0] cdma_wt2mcif_rd_req_pd;
output mcif2cdma_wt_rd_rsp_valid;
input  mcif2cdma_wt_rd_rsp_ready;
output [65 -1:0] mcif2cdma_wt_rd_rsp_pd;
input  sdp2mcif_rd_cdt_lat_fifo_pop;
input  sdp2mcif_rd_req_valid;
output sdp2mcif_rd_req_ready;
input [47 -1:0] sdp2mcif_rd_req_pd;
output mcif2sdp_rd_rsp_valid;
input  mcif2sdp_rd_rsp_ready;
output [65 -1:0] mcif2sdp_rd_rsp_pd;
input  sdp_b2mcif_rd_cdt_lat_fifo_pop;
input  sdp_b2mcif_rd_req_valid;
output sdp_b2mcif_rd_req_ready;
input [47 -1:0] sdp_b2mcif_rd_req_pd;
output mcif2sdp_b_rd_rsp_valid;
input  mcif2sdp_b_rd_rsp_ready;
output [65 -1:0] mcif2sdp_b_rd_rsp_pd;
input  sdp_n2mcif_rd_cdt_lat_fifo_pop;
input  sdp_n2mcif_rd_req_valid;
output sdp_n2mcif_rd_req_ready;
input [47 -1:0] sdp_n2mcif_rd_req_pd;
output mcif2sdp_n_rd_rsp_valid;
input  mcif2sdp_n_rd_rsp_ready;
output [65 -1:0] mcif2sdp_n_rd_rsp_pd;
input  pdp2mcif_rd_cdt_lat_fifo_pop;
input  pdp2mcif_rd_req_valid;
output pdp2mcif_rd_req_ready;
input [47 -1:0] pdp2mcif_rd_req_pd;
output mcif2pdp_rd_rsp_valid;
input  mcif2pdp_rd_rsp_ready;
output [65 -1:0] mcif2pdp_rd_rsp_pd;
input  cdp2mcif_rd_cdt_lat_fifo_pop;
input  cdp2mcif_rd_req_valid;
output cdp2mcif_rd_req_ready;
input [47 -1:0] cdp2mcif_rd_req_pd;
output mcif2cdp_rd_rsp_valid;
input  mcif2cdp_rd_rsp_ready;
output [65 -1:0] mcif2cdp_rd_rsp_pd;
input  sdp2mcif_wr_req_valid;
output sdp2mcif_wr_req_ready;
input [66 -1:0] sdp2mcif_wr_req_pd;
output mcif2sdp_wr_rsp_complete;
input  pdp2mcif_wr_req_valid;
output pdp2mcif_wr_req_ready;
input [66 -1:0] pdp2mcif_wr_req_pd;
output mcif2pdp_wr_rsp_complete;
input  cdp2mcif_wr_req_valid;
output cdp2mcif_wr_req_ready;
input [66 -1:0] cdp2mcif_wr_req_pd;
output mcif2cdp_wr_rsp_complete;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input csb2mcif_req_pvld; /* data valid */
output csb2mcif_req_prdy; /* data return handshake */
input [62:0] csb2mcif_req_pd;
output mcif2csb_resp_valid; /* data valid */
output [33:0] mcif2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output mcif2noc_axi_ar_arvalid; /* data valid */
input mcif2noc_axi_ar_arready; /* data return handshake */
output [7:0] mcif2noc_axi_ar_arid;
output [3:0] mcif2noc_axi_ar_arlen;
output [32 -1:0] mcif2noc_axi_ar_araddr;
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
input noc2mcif_axi_b_bvalid; /* data valid */
output noc2mcif_axi_b_bready; /* data return handshake */
input [7:0] noc2mcif_axi_b_bid;
input noc2mcif_axi_r_rvalid; /* data valid */
output noc2mcif_axi_r_rready; /* data return handshake */
input [7:0] noc2mcif_axi_r_rid;
input noc2mcif_axi_r_rlast;
input [64 -1:0] noc2mcif_axi_r_rdata;
  NV_NVDLA_mcif u_NV_NVDLA_mcif (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< o
  ,.cdma_dat2mcif_rd_cdt_lat_fifo_pop (cdma_dat2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.cdma_dat2mcif_rd_req_valid (cdma_dat2mcif_rd_req_valid) //|< i
  ,.cdma_dat2mcif_rd_req_ready (cdma_dat2mcif_rd_req_ready) //|> o
  ,.cdma_dat2mcif_rd_req_pd (cdma_dat2mcif_rd_req_pd ) //|< i
  ,.cdma_wt2mcif_rd_cdt_lat_fifo_pop (cdma_wt2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.cdma_wt2mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid) //|< i
  ,.cdma_wt2mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready) //|> o
  ,.cdma_wt2mcif_rd_req_pd (cdma_wt2mcif_rd_req_pd ) //|< i
  ,.cdp2mcif_rd_cdt_lat_fifo_pop (cdp2mcif_rd_cdt_lat_fifo_pop) //|< w
  ,.cdp2mcif_rd_req_valid (cdp2mcif_rd_req_valid) //|< w
  ,.cdp2mcif_rd_req_ready (cdp2mcif_rd_req_ready) //|> w
  ,.cdp2mcif_rd_req_pd (cdp2mcif_rd_req_pd ) //|< w
  ,.cdp2mcif_wr_req_valid (cdp2mcif_wr_req_valid) //|< w
  ,.cdp2mcif_wr_req_ready (cdp2mcif_wr_req_ready) //|> w
  ,.cdp2mcif_wr_req_pd (cdp2mcif_wr_req_pd ) //|< w
  ,.mcif2cdp_rd_rsp_valid (mcif2cdp_rd_rsp_valid) //|> w
  ,.mcif2cdp_rd_rsp_ready (mcif2cdp_rd_rsp_ready) //|< w
  ,.mcif2cdp_rd_rsp_pd (mcif2cdp_rd_rsp_pd ) //|> w
  ,.mcif2cdp_wr_rsp_complete (mcif2cdp_wr_rsp_complete) //|> w
  ,.csb2mcif_req_pvld (csb2mcif_req_pvld) //|< w
  ,.csb2mcif_req_prdy (csb2mcif_req_prdy) //|> w
  ,.csb2mcif_req_pd (csb2mcif_req_pd[62:0]) //|< w
  ,.mcif2cdma_dat_rd_rsp_valid (mcif2cdma_dat_rd_rsp_valid) //|> o
  ,.mcif2cdma_dat_rd_rsp_ready (mcif2cdma_dat_rd_rsp_ready) //|< i
  ,.mcif2cdma_dat_rd_rsp_pd (mcif2cdma_dat_rd_rsp_pd ) //|> o
  ,.mcif2cdma_wt_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid) //|> o
  ,.mcif2cdma_wt_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready) //|< i
  ,.mcif2cdma_wt_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd ) //|> o
  ,.mcif2csb_resp_valid (mcif2csb_resp_valid) //|> w
  ,.mcif2csb_resp_pd (mcif2csb_resp_pd[33:0]) //|> w
  ,.mcif2noc_axi_ar_arvalid (mcif2noc_axi_ar_arvalid) //|> o
  ,.mcif2noc_axi_ar_arready (mcif2noc_axi_ar_arready) //|< i
  ,.mcif2noc_axi_ar_arid (mcif2noc_axi_ar_arid[7:0]) //|> o
  ,.mcif2noc_axi_ar_arlen (mcif2noc_axi_ar_arlen[3:0]) //|> o
  ,.mcif2noc_axi_ar_araddr (mcif2noc_axi_ar_araddr ) //|> o
  ,.mcif2noc_axi_aw_awvalid (mcif2noc_axi_aw_awvalid) //|> o
  ,.mcif2noc_axi_aw_awready (mcif2noc_axi_aw_awready) //|< i
  ,.mcif2noc_axi_aw_awid (mcif2noc_axi_aw_awid[7:0]) //|> o
  ,.mcif2noc_axi_aw_awlen (mcif2noc_axi_aw_awlen[3:0]) //|> o
  ,.mcif2noc_axi_aw_awaddr (mcif2noc_axi_aw_awaddr ) //|> o
  ,.mcif2noc_axi_w_wvalid (mcif2noc_axi_w_wvalid) //|> o
  ,.mcif2noc_axi_w_wready (mcif2noc_axi_w_wready) //|< i
  ,.mcif2noc_axi_w_wdata (mcif2noc_axi_w_wdata ) //|> o
  ,.mcif2noc_axi_w_wstrb (mcif2noc_axi_w_wstrb ) //|> o
  ,.mcif2noc_axi_w_wlast (mcif2noc_axi_w_wlast) //|> o
  ,.mcif2pdp_rd_rsp_valid (mcif2pdp_rd_rsp_valid) //|> w
  ,.mcif2pdp_rd_rsp_ready (mcif2pdp_rd_rsp_ready) //|< w
  ,.mcif2pdp_rd_rsp_pd (mcif2pdp_rd_rsp_pd ) //|> w
  ,.mcif2pdp_wr_rsp_complete (mcif2pdp_wr_rsp_complete) //|> w
  ,.pdp2mcif_rd_cdt_lat_fifo_pop (pdp2mcif_rd_cdt_lat_fifo_pop) //|> w
  ,.pdp2mcif_rd_req_valid (pdp2mcif_rd_req_valid) //|> w
  ,.pdp2mcif_rd_req_ready (pdp2mcif_rd_req_ready) //|> w
  ,.pdp2mcif_rd_req_pd (pdp2mcif_rd_req_pd ) //|> w
  ,.pdp2mcif_wr_req_valid (pdp2mcif_wr_req_valid) //|> w
  ,.pdp2mcif_wr_req_ready (pdp2mcif_wr_req_ready) //|> w
  ,.pdp2mcif_wr_req_pd (pdp2mcif_wr_req_pd ) //|> w
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid) //|> o
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready) //|< i
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd ) //|> o
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid) //|> o
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready) //|< i
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd ) //|> o
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid) //|> o
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready) //|< i
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd ) //|> o
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete) //|> o
  ,.noc2mcif_axi_b_bvalid (noc2mcif_axi_b_bvalid) //|< i
  ,.noc2mcif_axi_b_bready (noc2mcif_axi_b_bready) //|> o
  ,.noc2mcif_axi_b_bid (noc2mcif_axi_b_bid[7:0]) //|< i
  ,.noc2mcif_axi_r_rvalid (noc2mcif_axi_r_rvalid) //|< i
  ,.noc2mcif_axi_r_rready (noc2mcif_axi_r_rready) //|> o
  ,.noc2mcif_axi_r_rid (noc2mcif_axi_r_rid[7:0]) //|< i
  ,.noc2mcif_axi_r_rlast (noc2mcif_axi_r_rlast) //|< i
  ,.noc2mcif_axi_r_rdata (noc2mcif_axi_r_rdata ) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid) //|< i
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready) //|> o
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd ) //|< i
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid) //|< i
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready) //|> o
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd ) //|< i
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid) //|< i
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready) //|> o
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd ) //|< i
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid) //|< i
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready) //|> o
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd ) //|< i
  );
endmodule
