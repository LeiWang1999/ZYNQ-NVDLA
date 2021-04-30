// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_READ_eg.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
`include "NV_NVDLA_MCIF_define.vh"
`include "simulate_x_tick.vh"
module NV_NVDLA_MCIF_READ_eg (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,eg2ig_axi_vld //|> o
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print"  ,mcif2${client}_rd_rsp_pd    \n";
//: print"  ,mcif2${client}_rd_rsp_valid \n";
//: print"  ,mcif2${client}_rd_rsp_ready \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,mcif2cdma_dat_rd_rsp_pd    
  ,mcif2cdma_dat_rd_rsp_valid 
  ,mcif2cdma_dat_rd_rsp_ready 
  ,mcif2cdma_wt_rd_rsp_pd    
  ,mcif2cdma_wt_rd_rsp_valid 
  ,mcif2cdma_wt_rd_rsp_ready 
  ,mcif2sdp_rd_rsp_pd    
  ,mcif2sdp_rd_rsp_valid 
  ,mcif2sdp_rd_rsp_ready 
  ,mcif2sdp_b_rd_rsp_pd    
  ,mcif2sdp_b_rd_rsp_valid 
  ,mcif2sdp_b_rd_rsp_ready 
  ,mcif2sdp_n_rd_rsp_pd    
  ,mcif2sdp_n_rd_rsp_valid 
  ,mcif2sdp_n_rd_rsp_ready 
  ,mcif2pdp_rd_rsp_pd    
  ,mcif2pdp_rd_rsp_valid 
  ,mcif2pdp_rd_rsp_ready 
  ,mcif2cdp_rd_rsp_pd    
  ,mcif2cdp_rd_rsp_valid 
  ,mcif2cdp_rd_rsp_ready 

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,noc2mcif_axi_r_rdata //|< i
  ,noc2mcif_axi_r_rid //|< i
  ,noc2mcif_axi_r_rlast //|< i
  ,noc2mcif_axi_r_rvalid //|< i
  ,noc2mcif_axi_r_rready //|> o
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
output eg2ig_axi_vld;
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print qq(
//: output mcif2${client}_rd_rsp_valid;
//: input mcif2${client}_rd_rsp_ready;
//: output [65 -1:0] mcif2${client}_rd_rsp_pd;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output mcif2cdma_dat_rd_rsp_valid;
input mcif2cdma_dat_rd_rsp_ready;
output [65 -1:0] mcif2cdma_dat_rd_rsp_pd;

output mcif2cdma_wt_rd_rsp_valid;
input mcif2cdma_wt_rd_rsp_ready;
output [65 -1:0] mcif2cdma_wt_rd_rsp_pd;

output mcif2sdp_rd_rsp_valid;
input mcif2sdp_rd_rsp_ready;
output [65 -1:0] mcif2sdp_rd_rsp_pd;

output mcif2sdp_b_rd_rsp_valid;
input mcif2sdp_b_rd_rsp_ready;
output [65 -1:0] mcif2sdp_b_rd_rsp_pd;

output mcif2sdp_n_rd_rsp_valid;
input mcif2sdp_n_rd_rsp_ready;
output [65 -1:0] mcif2sdp_n_rd_rsp_pd;

output mcif2pdp_rd_rsp_valid;
input mcif2pdp_rd_rsp_ready;
output [65 -1:0] mcif2pdp_rd_rsp_pd;

output mcif2cdp_rd_rsp_valid;
input mcif2cdp_rd_rsp_ready;
output [65 -1:0] mcif2cdp_rd_rsp_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input noc2mcif_axi_r_rvalid;
output noc2mcif_axi_r_rready;
input [7:0] noc2mcif_axi_r_rid;
input noc2mcif_axi_r_rlast;
input [64 -1:0] noc2mcif_axi_r_rdata;
wire [64 +3:0] noc2mcif_axi_r_pd;
wire [3:0] ipipe_axi_axid;
wire [64 -1:0] ipipe_axi_data;
wire [64 +3:0] ipipe_axi_pd;
wire ipipe_axi_rdy;
wire ipipe_axi_vld;
//: for(my $i=0;$i<7;$i++) {
//: print qq(
//: wire [64 -1:0] rq${i}_rd_pd;
//: wire rq${i}_rd_prdy;
//: wire rq${i}_rd_pvld;
//: wire [64 -1:0] rq${i}_wr_pd;
//: wire rq${i}_wr_prdy;
//: wire rq${i}_wr_pvld;
//: );
//: }
//: for(my $i=0;$i<7;$i++) {
//: print qq(
//: wire [65 -1:0] dma${i}_pd;
//: wire [64 -1:0] dma${i}_data;
//: wire [1 -1:0] dma${i}_mask;
//: wire dma${i}_rdy;
//: wire dma${i}_vld;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [64 -1:0] rq0_rd_pd;
wire rq0_rd_prdy;
wire rq0_rd_pvld;
wire [64 -1:0] rq0_wr_pd;
wire rq0_wr_prdy;
wire rq0_wr_pvld;

wire [64 -1:0] rq1_rd_pd;
wire rq1_rd_prdy;
wire rq1_rd_pvld;
wire [64 -1:0] rq1_wr_pd;
wire rq1_wr_prdy;
wire rq1_wr_pvld;

wire [64 -1:0] rq2_rd_pd;
wire rq2_rd_prdy;
wire rq2_rd_pvld;
wire [64 -1:0] rq2_wr_pd;
wire rq2_wr_prdy;
wire rq2_wr_pvld;

wire [64 -1:0] rq3_rd_pd;
wire rq3_rd_prdy;
wire rq3_rd_pvld;
wire [64 -1:0] rq3_wr_pd;
wire rq3_wr_prdy;
wire rq3_wr_pvld;

wire [64 -1:0] rq4_rd_pd;
wire rq4_rd_prdy;
wire rq4_rd_pvld;
wire [64 -1:0] rq4_wr_pd;
wire rq4_wr_prdy;
wire rq4_wr_pvld;

wire [64 -1:0] rq5_rd_pd;
wire rq5_rd_prdy;
wire rq5_rd_pvld;
wire [64 -1:0] rq5_wr_pd;
wire rq5_wr_prdy;
wire rq5_wr_pvld;

wire [64 -1:0] rq6_rd_pd;
wire rq6_rd_prdy;
wire rq6_rd_pvld;
wire [64 -1:0] rq6_wr_pd;
wire rq6_wr_prdy;
wire rq6_wr_pvld;

wire [65 -1:0] dma0_pd;
wire [64 -1:0] dma0_data;
wire [1 -1:0] dma0_mask;
wire dma0_rdy;
wire dma0_vld;

wire [65 -1:0] dma1_pd;
wire [64 -1:0] dma1_data;
wire [1 -1:0] dma1_mask;
wire dma1_rdy;
wire dma1_vld;

wire [65 -1:0] dma2_pd;
wire [64 -1:0] dma2_data;
wire [1 -1:0] dma2_mask;
wire dma2_rdy;
wire dma2_vld;

wire [65 -1:0] dma3_pd;
wire [64 -1:0] dma3_data;
wire [1 -1:0] dma3_mask;
wire dma3_rdy;
wire dma3_vld;

wire [65 -1:0] dma4_pd;
wire [64 -1:0] dma4_data;
wire [1 -1:0] dma4_mask;
wire dma4_rdy;
wire dma4_vld;

wire [65 -1:0] dma5_pd;
wire [64 -1:0] dma5_data;
wire [1 -1:0] dma5_mask;
wire dma5_rdy;
wire dma5_vld;

wire [65 -1:0] dma6_pd;
wire [64 -1:0] dma6_data;
wire [1 -1:0] dma6_mask;
wire dma6_rdy;
wire dma6_vld;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign noc2mcif_axi_r_pd = {noc2mcif_axi_r_rid[3:0],noc2mcif_axi_r_rdata};
NV_NVDLA_MCIF_READ_EG_pipe_pr pipe_pr (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.noc2mcif_axi_r_pd (noc2mcif_axi_r_pd) //|< w
  ,.noc2mcif_axi_r_rvalid (noc2mcif_axi_r_rvalid) //|< i
  ,.noc2mcif_axi_r_rready (noc2mcif_axi_r_rready) //|> o
  ,.ipipe_axi_pd (ipipe_axi_pd) //|> w
  ,.ipipe_axi_vld (ipipe_axi_vld) //|> w
  ,.ipipe_axi_rdy (ipipe_axi_rdy) //|< w
  );
assign eg2ig_axi_vld = ipipe_axi_vld & ipipe_axi_rdy;
assign {ipipe_axi_axid,ipipe_axi_data} = ipipe_axi_pd;
//: print "assign ipipe_axi_rdy = (rq0_wr_pvld & rq0_wr_prdy) ";
//: for(my $i=1;$i<7;$i++) {
//: print "| (rq${i}_wr_pvld & rq${i}_wr_prdy)";
//: }
//: print ";\n";
//: print "\n";
//: my $i = 0;
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print qq (
//: assign rq${i}_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == `tieoff_axid_${client});
//: assign rq${i}_wr_pd = ipipe_axi_data;
//:
//: NV_NVDLA_MCIF_READ_EG_lat_fifo lat_fifo${i} (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
//: ,.rq_wr_prdy (rq${i}_wr_prdy)
//: ,.rq_wr_pvld (rq${i}_wr_pvld)
//: ,.rq_wr_pd (rq${i}_wr_pd)
//: ,.rq_rd_prdy (rq${i}_rd_prdy)
//: ,.rq_rd_pvld (rq${i}_rd_pvld)
//: ,.rq_rd_pd (rq${i}_rd_pd)
//: );
//: );
//: $i++;
//: }
//: for(my $i=0;$i<7;$i++) {
//: print qq (
//: assign rq${i}_rd_prdy = dma${i}_rdy;
//: assign dma${i}_vld = rq${i}_rd_pvld;
//: assign dma${i}_mask = rq${i}_rd_pvld;
//: assign dma${i}_data = rq${i}_rd_pd;
//: assign dma${i}_pd = {dma${i}_mask,dma${i}_data};
//: );
//: }
//: my $i = 0;
//: my @rdma_name = ("cdma_dat","cdma_wt","sdp", "sdp_b","sdp_n","pdp","cdp");
//: foreach my $client (@rdma_name) {
//: print qq (
//: NV_NVDLA_MCIF_READ_EG_OUT_pipe pipe_p${i} (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.dma_pd (dma${i}_pd)
//: ,.dma_vld (dma${i}_vld)
//: ,.dma_rdy (dma${i}_rdy)
//: ,.mcif_rd_rsp_ready (mcif2${client}_rd_rsp_ready)
//: ,.mcif_rd_rsp_pd (mcif2${client}_rd_rsp_pd)
//: ,.mcif_rd_rsp_valid (mcif2${client}_rd_rsp_valid)
//: );
//: );
//: $i++;
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign ipipe_axi_rdy = (rq0_wr_pvld & rq0_wr_prdy) | (rq1_wr_pvld & rq1_wr_prdy)| (rq2_wr_pvld & rq2_wr_prdy)| (rq3_wr_pvld & rq3_wr_prdy)| (rq4_wr_pvld & rq4_wr_prdy)| (rq5_wr_pvld & rq5_wr_prdy)| (rq6_wr_pvld & rq6_wr_prdy);


assign rq0_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == `tieoff_axid_cdma_dat);
assign rq0_wr_pd = ipipe_axi_data;

NV_NVDLA_MCIF_READ_EG_lat_fifo lat_fifo0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
,.rq_wr_prdy (rq0_wr_prdy)
,.rq_wr_pvld (rq0_wr_pvld)
,.rq_wr_pd (rq0_wr_pd)
,.rq_rd_prdy (rq0_rd_prdy)
,.rq_rd_pvld (rq0_rd_pvld)
,.rq_rd_pd (rq0_rd_pd)
);

assign rq1_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == `tieoff_axid_cdma_wt);
assign rq1_wr_pd = ipipe_axi_data;

NV_NVDLA_MCIF_READ_EG_lat_fifo lat_fifo1 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
,.rq_wr_prdy (rq1_wr_prdy)
,.rq_wr_pvld (rq1_wr_pvld)
,.rq_wr_pd (rq1_wr_pd)
,.rq_rd_prdy (rq1_rd_prdy)
,.rq_rd_pvld (rq1_rd_pvld)
,.rq_rd_pd (rq1_rd_pd)
);

assign rq2_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == `tieoff_axid_sdp);
assign rq2_wr_pd = ipipe_axi_data;

NV_NVDLA_MCIF_READ_EG_lat_fifo lat_fifo2 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
,.rq_wr_prdy (rq2_wr_prdy)
,.rq_wr_pvld (rq2_wr_pvld)
,.rq_wr_pd (rq2_wr_pd)
,.rq_rd_prdy (rq2_rd_prdy)
,.rq_rd_pvld (rq2_rd_pvld)
,.rq_rd_pd (rq2_rd_pd)
);

assign rq3_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == `tieoff_axid_sdp_b);
assign rq3_wr_pd = ipipe_axi_data;

NV_NVDLA_MCIF_READ_EG_lat_fifo lat_fifo3 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
,.rq_wr_prdy (rq3_wr_prdy)
,.rq_wr_pvld (rq3_wr_pvld)
,.rq_wr_pd (rq3_wr_pd)
,.rq_rd_prdy (rq3_rd_prdy)
,.rq_rd_pvld (rq3_rd_pvld)
,.rq_rd_pd (rq3_rd_pd)
);

assign rq4_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == `tieoff_axid_sdp_n);
assign rq4_wr_pd = ipipe_axi_data;

NV_NVDLA_MCIF_READ_EG_lat_fifo lat_fifo4 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
,.rq_wr_prdy (rq4_wr_prdy)
,.rq_wr_pvld (rq4_wr_pvld)
,.rq_wr_pd (rq4_wr_pd)
,.rq_rd_prdy (rq4_rd_prdy)
,.rq_rd_pvld (rq4_rd_pvld)
,.rq_rd_pd (rq4_rd_pd)
);

assign rq5_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == `tieoff_axid_pdp);
assign rq5_wr_pd = ipipe_axi_data;

NV_NVDLA_MCIF_READ_EG_lat_fifo lat_fifo5 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
,.rq_wr_prdy (rq5_wr_prdy)
,.rq_wr_pvld (rq5_wr_pvld)
,.rq_wr_pd (rq5_wr_pd)
,.rq_rd_prdy (rq5_rd_prdy)
,.rq_rd_pvld (rq5_rd_pvld)
,.rq_rd_pd (rq5_rd_pd)
);

assign rq6_wr_pvld = ipipe_axi_vld & (ipipe_axi_axid == `tieoff_axid_cdp);
assign rq6_wr_pd = ipipe_axi_data;

NV_NVDLA_MCIF_READ_EG_lat_fifo lat_fifo6 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
,.rq_wr_prdy (rq6_wr_prdy)
,.rq_wr_pvld (rq6_wr_pvld)
,.rq_wr_pd (rq6_wr_pd)
,.rq_rd_prdy (rq6_rd_prdy)
,.rq_rd_pvld (rq6_rd_pvld)
,.rq_rd_pd (rq6_rd_pd)
);

assign rq0_rd_prdy = dma0_rdy;
assign dma0_vld = rq0_rd_pvld;
assign dma0_mask = rq0_rd_pvld;
assign dma0_data = rq0_rd_pd;
assign dma0_pd = {dma0_mask,dma0_data};

assign rq1_rd_prdy = dma1_rdy;
assign dma1_vld = rq1_rd_pvld;
assign dma1_mask = rq1_rd_pvld;
assign dma1_data = rq1_rd_pd;
assign dma1_pd = {dma1_mask,dma1_data};

assign rq2_rd_prdy = dma2_rdy;
assign dma2_vld = rq2_rd_pvld;
assign dma2_mask = rq2_rd_pvld;
assign dma2_data = rq2_rd_pd;
assign dma2_pd = {dma2_mask,dma2_data};

assign rq3_rd_prdy = dma3_rdy;
assign dma3_vld = rq3_rd_pvld;
assign dma3_mask = rq3_rd_pvld;
assign dma3_data = rq3_rd_pd;
assign dma3_pd = {dma3_mask,dma3_data};

assign rq4_rd_prdy = dma4_rdy;
assign dma4_vld = rq4_rd_pvld;
assign dma4_mask = rq4_rd_pvld;
assign dma4_data = rq4_rd_pd;
assign dma4_pd = {dma4_mask,dma4_data};

assign rq5_rd_prdy = dma5_rdy;
assign dma5_vld = rq5_rd_pvld;
assign dma5_mask = rq5_rd_pvld;
assign dma5_data = rq5_rd_pd;
assign dma5_pd = {dma5_mask,dma5_data};

assign rq6_rd_prdy = dma6_rdy;
assign dma6_vld = rq6_rd_pvld;
assign dma6_mask = rq6_rd_pvld;
assign dma6_data = rq6_rd_pd;
assign dma6_pd = {dma6_mask,dma6_data};

NV_NVDLA_MCIF_READ_EG_OUT_pipe pipe_p0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma_pd (dma0_pd)
,.dma_vld (dma0_vld)
,.dma_rdy (dma0_rdy)
,.mcif_rd_rsp_ready (mcif2cdma_dat_rd_rsp_ready)
,.mcif_rd_rsp_pd (mcif2cdma_dat_rd_rsp_pd)
,.mcif_rd_rsp_valid (mcif2cdma_dat_rd_rsp_valid)
);

NV_NVDLA_MCIF_READ_EG_OUT_pipe pipe_p1 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma_pd (dma1_pd)
,.dma_vld (dma1_vld)
,.dma_rdy (dma1_rdy)
,.mcif_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready)
,.mcif_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd)
,.mcif_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid)
);

NV_NVDLA_MCIF_READ_EG_OUT_pipe pipe_p2 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma_pd (dma2_pd)
,.dma_vld (dma2_vld)
,.dma_rdy (dma2_rdy)
,.mcif_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
,.mcif_rd_rsp_pd (mcif2sdp_rd_rsp_pd)
,.mcif_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
);

NV_NVDLA_MCIF_READ_EG_OUT_pipe pipe_p3 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma_pd (dma3_pd)
,.dma_vld (dma3_vld)
,.dma_rdy (dma3_rdy)
,.mcif_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
,.mcif_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd)
,.mcif_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
);

NV_NVDLA_MCIF_READ_EG_OUT_pipe pipe_p4 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma_pd (dma4_pd)
,.dma_vld (dma4_vld)
,.dma_rdy (dma4_rdy)
,.mcif_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
,.mcif_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd)
,.mcif_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
);

NV_NVDLA_MCIF_READ_EG_OUT_pipe pipe_p5 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma_pd (dma5_pd)
,.dma_vld (dma5_vld)
,.dma_rdy (dma5_rdy)
,.mcif_rd_rsp_ready (mcif2pdp_rd_rsp_ready)
,.mcif_rd_rsp_pd (mcif2pdp_rd_rsp_pd)
,.mcif_rd_rsp_valid (mcif2pdp_rd_rsp_valid)
);

NV_NVDLA_MCIF_READ_EG_OUT_pipe pipe_p6 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dma_pd (dma6_pd)
,.dma_vld (dma6_vld)
,.dma_rdy (dma6_rdy)
,.mcif_rd_rsp_ready (mcif2cdp_rd_rsp_ready)
,.mcif_rd_rsp_pd (mcif2cdp_rd_rsp_pd)
,.mcif_rd_rsp_valid (mcif2cdp_rd_rsp_valid)
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_READ_eg
// **************************************************************************************************************
// Generated by ::pipe -m -rand none -bc -is ipipe_axi_pd (ipipe_axi_vld,ipipe_axi_rdy) <= noc2mcif_axi_r_pd[515:0] (noc2mcif_axi_r_rvalid,noc2mcif_axi_r_rready)
// **************************************************************************************************************
module NV_NVDLA_MCIF_READ_EG_pipe_pr (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,noc2mcif_axi_r_pd
  ,noc2mcif_axi_r_rvalid
  ,noc2mcif_axi_r_rready
  ,ipipe_axi_pd
  ,ipipe_axi_vld
  ,ipipe_axi_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [64 +3:0] noc2mcif_axi_r_pd;
input noc2mcif_axi_r_rvalid;
output noc2mcif_axi_r_rready;
output [64 +3:0] ipipe_axi_pd;
output ipipe_axi_vld;
input ipipe_axi_rdy;
//: my $k = 64 +4;
//: &eperl::pipe(" -wid $k -is -do ipipe_axi_pd -vo ipipe_axi_vld -ri ipipe_axi_rdy -di noc2mcif_axi_r_pd -vi noc2mcif_axi_r_rvalid -ro noc2mcif_axi_r_rready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg noc2mcif_axi_r_rready;
reg skid_flop_noc2mcif_axi_r_rready;
reg skid_flop_noc2mcif_axi_r_rvalid;
reg [68-1:0] skid_flop_noc2mcif_axi_r_pd;
reg pipe_skid_noc2mcif_axi_r_rvalid;
reg [68-1:0] pipe_skid_noc2mcif_axi_r_pd;
// Wire
wire skid_noc2mcif_axi_r_rvalid;
wire [68-1:0] skid_noc2mcif_axi_r_pd;
wire skid_noc2mcif_axi_r_rready;
wire pipe_skid_noc2mcif_axi_r_rready;
wire ipipe_axi_vld;
wire [68-1:0] ipipe_axi_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       noc2mcif_axi_r_rready <= 1'b1;
       skid_flop_noc2mcif_axi_r_rready <= 1'b1;
   end else begin
       noc2mcif_axi_r_rready <= skid_noc2mcif_axi_r_rready;
       skid_flop_noc2mcif_axi_r_rready <= skid_noc2mcif_axi_r_rready;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_noc2mcif_axi_r_rvalid <= 1'b0;
    end else begin
        if (skid_flop_noc2mcif_axi_r_rready) begin
            skid_flop_noc2mcif_axi_r_rvalid <= noc2mcif_axi_r_rvalid;
        end
   end
end
assign skid_noc2mcif_axi_r_rvalid = (skid_flop_noc2mcif_axi_r_rready) ? noc2mcif_axi_r_rvalid : skid_flop_noc2mcif_axi_r_rvalid;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_noc2mcif_axi_r_rready & noc2mcif_axi_r_rvalid) begin
        skid_flop_noc2mcif_axi_r_pd[68-1:0] <= noc2mcif_axi_r_pd[68-1:0];
    end
end
assign skid_noc2mcif_axi_r_pd[68-1:0] = (skid_flop_noc2mcif_axi_r_rready) ? noc2mcif_axi_r_pd[68-1:0] : skid_flop_noc2mcif_axi_r_pd[68-1:0];


// PIPE READY
assign skid_noc2mcif_axi_r_rready = pipe_skid_noc2mcif_axi_r_rready || !pipe_skid_noc2mcif_axi_r_rvalid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_noc2mcif_axi_r_rvalid <= 1'b0;
    end else begin
        if (skid_noc2mcif_axi_r_rready) begin
            pipe_skid_noc2mcif_axi_r_rvalid <= skid_noc2mcif_axi_r_rvalid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_noc2mcif_axi_r_rready && skid_noc2mcif_axi_r_rvalid) begin
        pipe_skid_noc2mcif_axi_r_pd[68-1:0] <= skid_noc2mcif_axi_r_pd[68-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_noc2mcif_axi_r_rready = ipipe_axi_rdy;
assign ipipe_axi_vld = pipe_skid_noc2mcif_axi_r_rvalid;
assign ipipe_axi_pd = pipe_skid_noc2mcif_axi_r_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_READ_EG_pipe_pr
module NV_NVDLA_MCIF_READ_EG_OUT_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dma_pd
  ,dma_vld
  ,dma_rdy
  ,mcif_rd_rsp_ready
  ,mcif_rd_rsp_pd
  ,mcif_rd_rsp_valid
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [65 -1:0] dma_pd;
input dma_vld;
output dma_rdy;
output [65 -1:0] mcif_rd_rsp_pd;
output mcif_rd_rsp_valid;
input mcif_rd_rsp_ready;
//: my $k = 65;
//: &eperl::pipe(" -wid $k -do mcif_rd_rsp_pd -vo mcif_rd_rsp_valid -ri mcif_rd_rsp_ready -di dma_pd -vi dma_vld -ro dma_rdy ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg pipe_dma_vld;
reg [65-1:0] pipe_dma_pd;
// Wire
wire dma_rdy;
wire pipe_dma_rdy;
wire mcif_rd_rsp_valid;
wire [65-1:0] mcif_rd_rsp_pd;
// Code
// PIPE READY
assign dma_rdy = pipe_dma_rdy || !pipe_dma_vld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_dma_vld <= 1'b0;
    end else begin
        if (dma_rdy) begin
            pipe_dma_vld <= dma_vld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (dma_rdy && dma_vld) begin
        pipe_dma_pd[65-1:0] <= dma_pd[65-1:0];
    end
end


// PIPE OUTPUT
assign pipe_dma_rdy = mcif_rd_rsp_ready;
assign mcif_rd_rsp_valid = pipe_dma_vld;
assign mcif_rd_rsp_pd = pipe_dma_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
module NV_NVDLA_MCIF_READ_EG_lat_fifo (
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
input [63:0] rq_wr_pd;
input rq_rd_prdy;
output rq_rd_pvld;
output [63:0] rq_rd_pd;
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
wire [63:0] rq_rd_pd; // read data out of ram
wire [31 : 0] pwrbus_ram_pd;
// Adding parameter for fifogen to disable wr/rd contention assertion in ramgen.
// Fifogen handles this by ignoring the data on the ram data out for that cycle.
NV_NVDLA_MCIF_READ_EG_lat_fifo_flopram_rwsa_4x64 ram (
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
assign wr_limit_muxed = `EMU_FIFO_CFG.NV_NVDLA_MCIF_READ_EG_lat_fifo_wr_limit_override ? `EMU_FIFO_CFG.NV_NVDLA_MCIF_READ_EG_lat_fifo_wr_limit : 3'd0;
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
    if ( $test$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_wr_limit" ) ) begin
        wr_limit_override = 1;
        $value$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_wr_limit=%d", wr_limit_override_value);
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
    if ( $test$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_probability" ) ) begin
        $value$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_probability=%d", stall_probability);
    end else if ( $test$plusargs( "default_fifo_stall_probability" ) ) begin
        $value$plusargs( "default_fifo_stall_probability=%d", stall_probability);
    end
    if ( $test$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_cycles_min" ) ) begin
        $value$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_cycles_min=%d", stall_cycles_min);
    end else if ( $test$plusargs( "default_fifo_stall_cycles_min" ) ) begin
        $value$plusargs( "default_fifo_stall_cycles_min=%d", stall_cycles_min);
    end
    if ( $test$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_cycles_max" ) ) begin
        $value$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_cycles_max=%d", stall_cycles_max);
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
    if ( ! $test$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_probability" ) ) stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_probability;
    if ( ! $test$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_cycles_min" ) ) stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_cycles_min;
    if ( ! $test$plusargs( "NV_NVDLA_MCIF_READ_EG_lat_fifo_fifo_stall_cycles_max" ) ) stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_cycles_max;
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
// set_boundary_optimization find(design, "NV_NVDLA_MCIF_READ_EG_lat_fifo") true
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
endmodule // NV_NVDLA_MCIF_READ_EG_lat_fifo
//
// Flop-Based RAM
//
module NV_NVDLA_MCIF_READ_EG_lat_fifo_flopram_rwsa_4x64 (
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
input [63:0] di;
input we;
input [1:0] wa;
input [1:0] ra;
output [63:0] dout;
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
reg [63:0] Di0_vmw;
always @( posedge clk ) begin
    Wa0_vmw <= wa;
    we0_vmw <= we;
    Di0_vmw <= di;
end
vmw_NV_NVDLA_MCIF_READ_EG_lat_fifo_flopram_rwsa_4x64 emu_ram (
     .Wa0( Wa0_vmw )
   , .we0( we0_vmw )
   , .Di0( Di0_vmw )
   , .Ra0( ra )
   , .Do0( dout )
   );
`else
reg [63:0] ram_ff0;
reg [63:0] ram_ff1;
reg [63:0] ram_ff2;
reg [63:0] ram_ff3;
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
reg [63:0] dout;
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
endmodule // NV_NVDLA_MCIF_READ_EG_lat_fifo_flopram_rwsa_4x64
// emulation model of flopram guts
//
`ifdef EMU
module vmw_NV_NVDLA_MCIF_READ_EG_lat_fifo_flopram_rwsa_4x64 (
   Wa0, we0, Di0,
   Ra0, Do0
   );
input [1:0] Wa0;
input we0;
input [63:0] Di0;
input [1:0] Ra0;
output [63:0] Do0;
// Only visible during Spyglass to avoid blackboxes.
`ifdef SPYGLASS_FLOPRAM
assign Do0 = 64'd0;
wire dummy = 1'b0 | (|Wa0) | (|we0) | (|Di0) | (|Ra0);
`endif
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg [63:0] mem[3:0];
// expand mem for debug ease
`ifdef EMU_EXPAND_FLOPRAM_MEM
wire [63:0] Q0 = mem[0];
wire [63:0] Q1 = mem[1];
wire [63:0] Q2 = mem[2];
wire [63:0] Q3 = mem[3];
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
endmodule // vmw_NV_NVDLA_MCIF_READ_EG_lat_fifo_flopram_rwsa_4x64
`endif // EMU
