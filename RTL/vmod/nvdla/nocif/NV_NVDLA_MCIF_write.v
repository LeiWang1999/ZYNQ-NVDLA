// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_write.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
module NV_NVDLA_MCIF_write (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,pwrbus_ram_pd
  ,reg2dp_wr_os_cnt
//: my @wdma_name = ("sdp", "pdp","cdp");
//: foreach my $client (@wdma_name) {
//: print "  ,reg2dp_wr_weight_${client}\n"
//: }
//: foreach my $client (@wdma_name) {
//: print "  ,${client}2mcif_wr_req_pd\n";
//: print "  ,${client}2mcif_wr_req_valid\n";
//: print "  ,${client}2mcif_wr_req_ready\n";
//: print "  ,mcif2${client}_wr_rsp_complete\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,reg2dp_wr_weight_sdp
  ,reg2dp_wr_weight_pdp
  ,reg2dp_wr_weight_cdp
  ,sdp2mcif_wr_req_pd
  ,sdp2mcif_wr_req_valid
  ,sdp2mcif_wr_req_ready
  ,mcif2sdp_wr_rsp_complete
  ,pdp2mcif_wr_req_pd
  ,pdp2mcif_wr_req_valid
  ,pdp2mcif_wr_req_ready
  ,mcif2pdp_wr_rsp_complete
  ,cdp2mcif_wr_req_pd
  ,cdp2mcif_wr_req_valid
  ,cdp2mcif_wr_req_ready
  ,mcif2cdp_wr_rsp_complete

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,noc2mcif_axi_b_bid //|< i
  ,noc2mcif_axi_b_bvalid //|< i
  ,noc2mcif_axi_b_bready //|> o
  ,mcif2noc_axi_aw_awaddr //|> o
  ,mcif2noc_axi_aw_awid //|> o
  ,mcif2noc_axi_aw_awlen //|> o
  ,mcif2noc_axi_aw_awvalid //|> o
  ,mcif2noc_axi_aw_awready //|< i
  ,mcif2noc_axi_w_wdata //|> o
  ,mcif2noc_axi_w_wlast //|> o
  ,mcif2noc_axi_w_wstrb //|> o
  ,mcif2noc_axi_w_wvalid //|> o
  ,mcif2noc_axi_w_wready //|< i
);
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
output mcif2noc_axi_aw_awvalid;
input mcif2noc_axi_aw_awready;
output [7:0] mcif2noc_axi_aw_awid;
output [3:0] mcif2noc_axi_aw_awlen;
output [32 -1:0] mcif2noc_axi_aw_awaddr;
output mcif2noc_axi_w_wvalid;
input mcif2noc_axi_w_wready;
output [64 -1:0] mcif2noc_axi_w_wdata;
output [8 -1:0] mcif2noc_axi_w_wstrb;
output mcif2noc_axi_w_wlast;
input noc2mcif_axi_b_bvalid;
output noc2mcif_axi_b_bready;
input [7:0] noc2mcif_axi_b_bid;
//: my @wdma_name = ("sdp", "pdp","cdp");
//: foreach my $client (@wdma_name) {
//: print qq(
//: input [66 -1:0] ${client}2mcif_wr_req_pd;
//: input ${client}2mcif_wr_req_valid;
//: output ${client}2mcif_wr_req_ready;
//: output mcif2${client}_wr_rsp_complete;
//: );
//: }
//: foreach my $client (@wdma_name) {
//: print "input  [7:0] reg2dp_wr_weight_${client};\n"
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [66 -1:0] sdp2mcif_wr_req_pd;
input sdp2mcif_wr_req_valid;
output sdp2mcif_wr_req_ready;
output mcif2sdp_wr_rsp_complete;

input [66 -1:0] pdp2mcif_wr_req_pd;
input pdp2mcif_wr_req_valid;
output pdp2mcif_wr_req_ready;
output mcif2pdp_wr_rsp_complete;

input [66 -1:0] cdp2mcif_wr_req_pd;
input cdp2mcif_wr_req_valid;
output cdp2mcif_wr_req_ready;
output mcif2cdp_wr_rsp_complete;
input  [7:0] reg2dp_wr_weight_sdp;
input  [7:0] reg2dp_wr_weight_pdp;
input  [7:0] reg2dp_wr_weight_cdp;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input [7:0] reg2dp_wr_os_cnt;
wire eg2ig_axi_vld;
wire [1:0] eg2ig_axi_len;
wire [2:0] cq_wr_thread_id;
wire [2:0] cq_wr_pd;
wire cq_wr_prdy;
wire cq_wr_pvld;
//:for(my $i=0;$i<5;$i++) {
//:print qq(
//:wire [2:0] cq_rd${i}_pd;
//:wire cq_rd${i}_pvld;
//:wire cq_rd${i}_prdy;
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [2:0] cq_rd0_pd;
wire cq_rd0_pvld;
wire cq_rd0_prdy;

wire [2:0] cq_rd1_pd;
wire cq_rd1_pvld;
wire cq_rd1_prdy;

wire [2:0] cq_rd2_pd;
wire cq_rd2_pvld;
wire cq_rd2_prdy;

wire [2:0] cq_rd3_pd;
wire cq_rd3_pvld;
wire cq_rd3_prdy;

wire [2:0] cq_rd4_pd;
wire cq_rd4_pvld;
wire cq_rd4_prdy;

//| eperl: generated_end (DO NOT EDIT ABOVE)
NV_NVDLA_MCIF_WRITE_ig u_ig (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd)
  ,.reg2dp_wr_os_cnt (reg2dp_wr_os_cnt)
//: my @wdma_name = ("sdp", "pdp","cdp");
//: foreach my $client (@wdma_name) {
//: print "  ,.reg2dp_wr_weight_${client}  (reg2dp_wr_weight_${client})\n";
//: }
//: foreach my $client (@wdma_name) {
//: print "  ,.${client}2mcif_wr_req_valid  (${client}2mcif_wr_req_valid)\n";
//: print "  ,.${client}2mcif_wr_req_ready  (${client}2mcif_wr_req_ready)\n";
//: print "  ,.${client}2mcif_wr_req_pd     (${client}2mcif_wr_req_pd)\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,.reg2dp_wr_weight_sdp  (reg2dp_wr_weight_sdp)
  ,.reg2dp_wr_weight_pdp  (reg2dp_wr_weight_pdp)
  ,.reg2dp_wr_weight_cdp  (reg2dp_wr_weight_cdp)
  ,.sdp2mcif_wr_req_valid  (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready  (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd     (sdp2mcif_wr_req_pd)
  ,.pdp2mcif_wr_req_valid  (pdp2mcif_wr_req_valid)
  ,.pdp2mcif_wr_req_ready  (pdp2mcif_wr_req_ready)
  ,.pdp2mcif_wr_req_pd     (pdp2mcif_wr_req_pd)
  ,.cdp2mcif_wr_req_valid  (cdp2mcif_wr_req_valid)
  ,.cdp2mcif_wr_req_ready  (cdp2mcif_wr_req_ready)
  ,.cdp2mcif_wr_req_pd     (cdp2mcif_wr_req_pd)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mcif2noc_axi_aw_awvalid (mcif2noc_axi_aw_awvalid) //|> o
  ,.mcif2noc_axi_aw_awready (mcif2noc_axi_aw_awready) //|< i
  ,.mcif2noc_axi_aw_awid (mcif2noc_axi_aw_awid[7:0]) //|> o
  ,.mcif2noc_axi_aw_awlen (mcif2noc_axi_aw_awlen[3:0]) //|> o
  ,.mcif2noc_axi_aw_awaddr (mcif2noc_axi_aw_awaddr) //|> o
  ,.mcif2noc_axi_w_wvalid (mcif2noc_axi_w_wvalid) //|> o
  ,.mcif2noc_axi_w_wready (mcif2noc_axi_w_wready) //|< i
  ,.mcif2noc_axi_w_wdata (mcif2noc_axi_w_wdata) //|> o
  ,.mcif2noc_axi_w_wstrb (mcif2noc_axi_w_wstrb) //|> o
  ,.mcif2noc_axi_w_wlast (mcif2noc_axi_w_wlast) //|> o
  ,.cq_wr_pvld (cq_wr_pvld) //|> w
  ,.cq_wr_prdy (cq_wr_prdy) //|< w
  ,.cq_wr_pd (cq_wr_pd[2:0]) //|> w
  ,.cq_wr_thread_id (cq_wr_thread_id[2:0]) //|> w
  ,.eg2ig_axi_len (eg2ig_axi_len[1:0]) //|< w
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|< w
);
NV_NVDLA_MCIF_WRITE_cq u_cq (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.cq_wr_prdy (cq_wr_prdy) //|> w
  ,.cq_wr_pvld (cq_wr_pvld) //|< w
  ,.cq_wr_pd (cq_wr_pd[2:0]) //|< w
  ,.cq_wr_thread_id (cq_wr_thread_id[2:0]) //|< w
//:for(my $i=0;$i<5;$i++) {
//:print"  ,.cq_rd${i}_pd     (cq_rd${i}_pd)\n";
//:print"  ,.cq_rd${i}_pvld   (cq_rd${i}_pvld)\n";
//:print"  ,.cq_rd${i}_prdy   (cq_rd${i}_prdy)\n";
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,.cq_rd0_pd     (cq_rd0_pd)
  ,.cq_rd0_pvld   (cq_rd0_pvld)
  ,.cq_rd0_prdy   (cq_rd0_prdy)
  ,.cq_rd1_pd     (cq_rd1_pd)
  ,.cq_rd1_pvld   (cq_rd1_pvld)
  ,.cq_rd1_prdy   (cq_rd1_prdy)
  ,.cq_rd2_pd     (cq_rd2_pd)
  ,.cq_rd2_pvld   (cq_rd2_pvld)
  ,.cq_rd2_prdy   (cq_rd2_prdy)
  ,.cq_rd3_pd     (cq_rd3_pd)
  ,.cq_rd3_pvld   (cq_rd3_pvld)
  ,.cq_rd3_prdy   (cq_rd3_prdy)
  ,.cq_rd4_pd     (cq_rd4_pd)
  ,.cq_rd4_pvld   (cq_rd4_pvld)
  ,.cq_rd4_prdy   (cq_rd4_prdy)

//| eperl: generated_end (DO NOT EDIT ABOVE)
);
NV_NVDLA_MCIF_WRITE_eg u_eg (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.eg2ig_axi_len (eg2ig_axi_len[1:0]) //|> w
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|> w
//:for(my $i=0;$i<5;$i++) {
//:print"  ,.cq_rd${i}_pd     (cq_rd${i}_pd)\n";
//:print"  ,.cq_rd${i}_pvld   (cq_rd${i}_pvld)\n";
//:print"  ,.cq_rd${i}_prdy   (cq_rd${i}_prdy)\n";
//:}
//: my @wdma_name = ("sdp", "pdp","cdp");
//: foreach my $client (@wdma_name) {
//: print "  ,.mcif2${client}_wr_rsp_complete (mcif2${client}_wr_rsp_complete)\n";
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,.cq_rd0_pd     (cq_rd0_pd)
  ,.cq_rd0_pvld   (cq_rd0_pvld)
  ,.cq_rd0_prdy   (cq_rd0_prdy)
  ,.cq_rd1_pd     (cq_rd1_pd)
  ,.cq_rd1_pvld   (cq_rd1_pvld)
  ,.cq_rd1_prdy   (cq_rd1_prdy)
  ,.cq_rd2_pd     (cq_rd2_pd)
  ,.cq_rd2_pvld   (cq_rd2_pvld)
  ,.cq_rd2_prdy   (cq_rd2_prdy)
  ,.cq_rd3_pd     (cq_rd3_pd)
  ,.cq_rd3_pvld   (cq_rd3_pvld)
  ,.cq_rd3_prdy   (cq_rd3_prdy)
  ,.cq_rd4_pd     (cq_rd4_pd)
  ,.cq_rd4_pvld   (cq_rd4_pvld)
  ,.cq_rd4_prdy   (cq_rd4_prdy)
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.mcif2pdp_wr_rsp_complete (mcif2pdp_wr_rsp_complete)
  ,.mcif2cdp_wr_rsp_complete (mcif2cdp_wr_rsp_complete)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.noc2mcif_axi_b_bvalid (noc2mcif_axi_b_bvalid) //|< i
  ,.noc2mcif_axi_b_bready (noc2mcif_axi_b_bready) //|> o
  ,.noc2mcif_axi_b_bid (noc2mcif_axi_b_bid[7:0]) //|< i
  );
endmodule
