// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_partition_c.v
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
//    #define LARGE_MEMBUS
//#endif
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CSC.h
    //entry bits
    //atomC
    //in bytes, entry/8
    //CSC_ENTRY_HEX/2
    //CSC_ENTRY_HEX/4
    //CSC_ENTRY_HEX-1
    //atomK
    //atomK
    //atomK*2
    //atomK*4
//notice, for image case, first atom OP within one strip OP must fetch from entry align place, in the middle of an entry is not supported.
//thus, when atomC/atomK=4, stripe=4*atomK, feature data still keeps atomK*2
    `define CC_ATOMC_DIV_ATOMK_EQUAL_1
//batch keep 1
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC.h
`define DESIGNWARE_NOEXIST 1
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CBUF.h
    `define CBUF_BANK_RAM_CASE1
    `define CBUF_SUPPORT_READ_JUMPING
//ram case could be 0/1/2/3/4/5  0:1ram/bank; 1:1*2ram/bank; 2:2*1ram/bank; 3:2*2ram/bank  4:4*1ram/bank  5:4*2ram/bank
`define CDMA2CBUF_DEBUG_PRINT //open debug print
module NV_NVDLA_partition_c (
   accu2sc_credit_size //|< i
  ,accu2sc_credit_vld //|< i
  ,cdma_dat2mcif_rd_req_ready //|< i
  ,cdma_wt2mcif_rd_req_ready //|< i
  ,csb2cdma_req_pd //|< i
  ,csb2cdma_req_pvld //|< i
  ,csb2csc_req_pd //|< i
  ,csb2csc_req_pvld //|< i
  ,direct_reset_ //|< i
  ,dla_reset_rstn //|< i
  ,global_clk_ovr_on //|< i
  ,mcif2cdma_dat_rd_rsp_pd //|< i
  ,mcif2cdma_dat_rd_rsp_valid //|< i
  ,mcif2cdma_wt_rd_rsp_pd //|< i
  ,mcif2cdma_wt_rd_rsp_valid //|< i
  ,nvdla_clk_ovr_on //|< i
  ,nvdla_core_clk //|< i
  ,pwrbus_ram_pd //|< i
  ,test_mode //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,cdma2csb_resp_pd //|> o
  ,cdma2csb_resp_valid //|> o
  ,cdma_dat2glb_done_intr_pd //|> o
  ,cdma_dat2mcif_rd_req_pd //|> o
  ,cdma_dat2mcif_rd_req_valid //|> o
  ,cdma_wt2glb_done_intr_pd //|> o
  ,cdma_wt2mcif_rd_req_pd //|> o
  ,cdma_wt2mcif_rd_req_valid //|> o
  ,csb2cdma_req_prdy //|> o
  ,csb2csc_req_prdy //|> o
  ,csc2csb_resp_pd //|> o
  ,csc2csb_resp_valid //|> o
  ,mcif2cdma_dat_rd_rsp_ready //|> o
  ,mcif2cdma_wt_rd_rsp_ready //|> o
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,sc2mac_dat_a_data${i} //|> o   );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,sc2mac_dat_a_data0 //|> o   
,sc2mac_dat_a_data1 //|> o   
,sc2mac_dat_a_data2 //|> o   
,sc2mac_dat_a_data3 //|> o   
,sc2mac_dat_a_data4 //|> o   
,sc2mac_dat_a_data5 //|> o   
,sc2mac_dat_a_data6 //|> o   
,sc2mac_dat_a_data7 //|> o   
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_dat_a_mask //|> o
  ,sc2mac_dat_a_pd //|> o
  ,sc2mac_dat_a_pvld //|> o
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,sc2mac_dat_b_data${i} //|> o   );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,sc2mac_dat_b_data0 //|> o   
,sc2mac_dat_b_data1 //|> o   
,sc2mac_dat_b_data2 //|> o   
,sc2mac_dat_b_data3 //|> o   
,sc2mac_dat_b_data4 //|> o   
,sc2mac_dat_b_data5 //|> o   
,sc2mac_dat_b_data6 //|> o   
,sc2mac_dat_b_data7 //|> o   
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_dat_b_mask //|> o
  ,sc2mac_dat_b_pd //|> o
  ,sc2mac_dat_b_pvld //|> o
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,sc2mac_wt_a_data${i} //|> o   );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,sc2mac_wt_a_data0 //|> o   
,sc2mac_wt_a_data1 //|> o   
,sc2mac_wt_a_data2 //|> o   
,sc2mac_wt_a_data3 //|> o   
,sc2mac_wt_a_data4 //|> o   
,sc2mac_wt_a_data5 //|> o   
,sc2mac_wt_a_data6 //|> o   
,sc2mac_wt_a_data7 //|> o   
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_wt_a_mask //|> o
  ,sc2mac_wt_a_pvld //|> o
  ,sc2mac_wt_a_sel //|> o
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,sc2mac_wt_b_data${i} //|> o   );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,sc2mac_wt_b_data0 //|> o   
,sc2mac_wt_b_data1 //|> o   
,sc2mac_wt_b_data2 //|> o   
,sc2mac_wt_b_data3 //|> o   
,sc2mac_wt_b_data4 //|> o   
,sc2mac_wt_b_data5 //|> o   
,sc2mac_wt_b_data6 //|> o   
,sc2mac_wt_b_data7 //|> o   
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_wt_b_mask //|> o
  ,sc2mac_wt_b_pvld //|> o
  ,sc2mac_wt_b_sel //|> o
  );
//
// NV_NVDLA_partition_c_io.v
//
input test_mode;
input direct_reset_;
input global_clk_ovr_on;
input tmc2slcg_disable_clock_gating;
input accu2sc_credit_vld; /* data valid */
input [2:0] accu2sc_credit_size;
output cdma2csb_resp_valid; /* data valid */
output [33:0] cdma2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output [1:0] cdma_dat2glb_done_intr_pd;
output cdma_dat2mcif_rd_req_valid; /* data valid */
input cdma_dat2mcif_rd_req_ready; /* data return handshake */
output [32 +14:0] cdma_dat2mcif_rd_req_pd;
output [1:0] cdma_wt2glb_done_intr_pd;
output cdma_wt2mcif_rd_req_valid; /* data valid */
input cdma_wt2mcif_rd_req_ready; /* data return handshake */
output [32 +14:0] cdma_wt2mcif_rd_req_pd;
input csb2cdma_req_pvld; /* data valid */
output csb2cdma_req_prdy; /* data return handshake */
input [62:0] csb2cdma_req_pd;
input csb2csc_req_pvld; /* data valid */
output csb2csc_req_prdy; /* data return handshake */
input [62:0] csb2csc_req_pd;
output csc2csb_resp_valid; /* data valid */
output [33:0] csc2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
input mcif2cdma_dat_rd_rsp_valid; /* data valid */
output mcif2cdma_dat_rd_rsp_ready; /* data return handshake */
input [64 +(64/8/8)-1:0] mcif2cdma_dat_rd_rsp_pd;
input mcif2cdma_wt_rd_rsp_valid; /* data valid */
output mcif2cdma_wt_rd_rsp_ready; /* data return handshake */
input [64 +(64/8/8)-1:0] mcif2cdma_wt_rd_rsp_pd;
input [31:0] pwrbus_ram_pd;
output sc2mac_dat_a_pvld; /* data valid */
output [8 -1:0] sc2mac_dat_a_mask;
output [8:0] sc2mac_dat_a_pd;
output sc2mac_dat_b_pvld; /* data valid */
output [8 -1:0] sc2mac_dat_b_mask;
output [8:0] sc2mac_dat_b_pd;
output sc2mac_wt_a_pvld; /* data valid */
output [8 -1:0] sc2mac_wt_a_mask;
output [8/2-1:0] sc2mac_wt_a_sel;
output sc2mac_wt_b_pvld; /* data valid */
output [8 -1:0] sc2mac_wt_b_mask;
//: my $kk=8 -1;
//: foreach my $i (0..${kk}) {
//: print qq(
//: output [8 -1:0] sc2mac_dat_a_data${i};
//: output [8 -1:0] sc2mac_dat_b_data${i};
//: output [8 -1:0] sc2mac_wt_a_data${i};
//: output [8 -1:0] sc2mac_wt_b_data${i};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [8 -1:0] sc2mac_dat_a_data0;
output [8 -1:0] sc2mac_dat_b_data0;
output [8 -1:0] sc2mac_wt_a_data0;
output [8 -1:0] sc2mac_wt_b_data0;

output [8 -1:0] sc2mac_dat_a_data1;
output [8 -1:0] sc2mac_dat_b_data1;
output [8 -1:0] sc2mac_wt_a_data1;
output [8 -1:0] sc2mac_wt_b_data1;

output [8 -1:0] sc2mac_dat_a_data2;
output [8 -1:0] sc2mac_dat_b_data2;
output [8 -1:0] sc2mac_wt_a_data2;
output [8 -1:0] sc2mac_wt_b_data2;

output [8 -1:0] sc2mac_dat_a_data3;
output [8 -1:0] sc2mac_dat_b_data3;
output [8 -1:0] sc2mac_wt_a_data3;
output [8 -1:0] sc2mac_wt_b_data3;

output [8 -1:0] sc2mac_dat_a_data4;
output [8 -1:0] sc2mac_dat_b_data4;
output [8 -1:0] sc2mac_wt_a_data4;
output [8 -1:0] sc2mac_wt_b_data4;

output [8 -1:0] sc2mac_dat_a_data5;
output [8 -1:0] sc2mac_dat_b_data5;
output [8 -1:0] sc2mac_wt_a_data5;
output [8 -1:0] sc2mac_wt_b_data5;

output [8 -1:0] sc2mac_dat_a_data6;
output [8 -1:0] sc2mac_dat_b_data6;
output [8 -1:0] sc2mac_wt_a_data6;
output [8 -1:0] sc2mac_wt_b_data6;

output [8 -1:0] sc2mac_dat_a_data7;
output [8 -1:0] sc2mac_dat_b_data7;
output [8 -1:0] sc2mac_wt_a_data7;
output [8 -1:0] sc2mac_wt_b_data7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output [8/2-1:0] sc2mac_wt_b_sel;
input nvdla_core_clk;
input dla_reset_rstn;
input nvdla_clk_ovr_on;
//////////////////////////////////////////////////////
wire cdma2buf_dat_wr_en;
//: my $dmaif=64;
//: my $atmc=8*8;
//: if($dmaif < $atmc) {
//: my $k = int($atmc/$dmaif);
//: print qq(
//: wire [${k}-1:0] cdma2buf_dat_wr_sel;
//: wire [16:0] cdma2buf_dat_wr_addr;
//: wire [${dmaif}-1:0] cdma2buf_dat_wr_data;
//: );
//: } elsif($dmaif > $atmc) {
//: my $k = int(log(int($dmaif/$atmc))/log(2));
//: print qq(
//: wire [${k}-1:0] cdma2buf_dat_wr_mask;
//: );
//: foreach my $i (0..$k-1) {
//: print qq(
//: wire [16:0] cdma2buf_dat_wr_addr${i};
//: wire [${dmaif}-1:0] cdma2buf_dat_wr_data${i};
//: );
//: }
//: } else {
//: print qq(
//: wire [16:0] cdma2buf_dat_wr_addr;
//: wire [${dmaif}-1:0] cdma2buf_dat_wr_data;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [16:0] cdma2buf_dat_wr_addr;
wire [64-1:0] cdma2buf_dat_wr_data;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//wire [11:0] cdma2buf_dat_wr_addr;
//wire [1023:0] cdma2buf_dat_wr_data;
//wire [1:0] cdma2buf_dat_wr_hsel;
wire cdma2buf_wt_wr_en;
//: my $dmaif=64;
//: my $atmc=8*8;
//: if($dmaif < $atmc) {
//: my $k = int($atmc/$dmaif);
//: print qq(
//: wire [${k}-1:0] cdma2buf_wt_wr_sel ;
//: wire [16:0] cdma2buf_wt_wr_addr;
//: wire [${dmaif}-1:0] cdma2buf_wt_wr_data;
//: );
//: } elsif($dmaif > $atmc) {
//: my $k = int(log(int($dmaif/$atmc))/log(2));
//: print qq(
//: wire [${k}-1:0] cdma2buf_wt_wr_mask;
//: );
//: foreach my $i (0..$k-1) {
//: print qq(
//: wire [16:0] cdma2buf_wt_wr_addr${i};
//: wire [${dmaif}-1:0] cdma2buf_wt_wr_data${i};
//: );
//: }
//: } else {
//: print qq(
//: wire [16:0] cdma2buf_wt_wr_addr;
//: wire [${dmaif}-1:0] cdma2buf_wt_wr_data;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [16:0] cdma2buf_wt_wr_addr;
wire [64-1:0] cdma2buf_wt_wr_data;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//wire [11:0] cdma2buf_wt_wr_addr;
//wire [511:0] cdma2buf_wt_wr_data;
//wire cdma2buf_wt_wr_hsel;
wire [15 -1:0] cdma2sc_dat_entries;
wire cdma2sc_dat_pending_ack;
wire [13:0] cdma2sc_dat_slices;
wire cdma2sc_dat_updt;
wire [8:0] cdma2sc_wmb_entries;
wire [15 -1:0] cdma2sc_wt_entries;
wire [13:0] cdma2sc_wt_kernels;
wire cdma2sc_wt_pending_ack;
wire cdma2sc_wt_updt;
wire cdma_dla_clk_ovr_on_sync;
wire cdma_global_clk_ovr_on_sync;
wire csc_dla_clk_ovr_on_sync;
wire csc_global_clk_ovr_on_sync;
wire nvdla_core_rstn;
wire [14 -1:0] sc2buf_dat_rd_addr;
wire [64 -1:0] sc2buf_dat_rd_data;
wire sc2buf_dat_rd_en;
wire sc2buf_dat_rd_valid;
wire [7 -1:0] sc2buf_dat_rd_shift;
wire sc2buf_dat_rd_next1_en;
wire [14 -1:0] sc2buf_dat_rd_next1_addr;
`ifdef CBUF_WEIGHT_COMPRESSED
wire [14 -1:0] sc2buf_wmb_rd_addr;
wire [64 -1:0] sc2buf_wmb_rd_data;
wire sc2buf_wmb_rd_en;
wire sc2buf_wmb_rd_valid;
`endif
wire [14 -1:0] sc2buf_wt_rd_addr;
wire [64 -1:0] sc2buf_wt_rd_data;
wire sc2buf_wt_rd_en;
wire sc2buf_wt_rd_valid;
wire [15 -1:0] sc2cdma_dat_entries;
wire sc2cdma_dat_pending_req;
wire [13:0] sc2cdma_dat_slices;
wire sc2cdma_dat_updt;
wire [8:0] sc2cdma_wmb_entries;
wire [15 -1:0] sc2cdma_wt_entries;
wire [13:0] sc2cdma_wt_kernels;
wire sc2cdma_wt_pending_req;
wire sc2cdma_wt_updt;
////////////////////////////////////////////////////////////////////////
// NVDLA Partition C: Reset Sync //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_reset u_partition_c_reset (
   .dla_reset_rstn (dla_reset_rstn) //|< i
  ,.direct_reset_ (direct_reset_) //|< i
  ,.test_mode (test_mode) //|< i
  ,.synced_rstn (nvdla_core_rstn) //|> w
  ,.nvdla_clk (nvdla_core_clk) //|< i
  );
////////////////////////////////////////////////////////////////////////
// SLCG override
////////////////////////////////////////////////////////////////////////
NV_NVDLA_sync3d u_csc_dla_clk_ovr_on_sync (
   .clk (nvdla_core_clk)
  ,.sync_i (nvdla_clk_ovr_on)
  ,.sync_o (csc_dla_clk_ovr_on_sync)
  );
NV_NVDLA_sync3d u_cdma_dla_clk_ovr_on_sync (
   .clk (nvdla_core_clk)
  ,.sync_i (nvdla_clk_ovr_on)
  ,.sync_o (cdma_dla_clk_ovr_on_sync)
  );
//&Instance NV_NVDLA_sync3d u_dla_clk_ovr_on_sync;
//&Connect clk nvdla_core_clk;
//&Connect sync_i nvdla_clk_ovr_on;
//&Connect sync_o dla_clk_ovr_on_sync;
NV_NVDLA_sync3d_s u_global_csc_clk_ovr_on_sync (
   .clk (nvdla_core_clk)
  ,.prst (nvdla_core_rstn)
  ,.sync_i (global_clk_ovr_on)
  ,.sync_o (csc_global_clk_ovr_on_sync)
  );
NV_NVDLA_sync3d_s u_global_cdma_clk_ovr_on_sync (
   .clk (nvdla_core_clk)
  ,.prst (nvdla_core_rstn)
  ,.sync_i (global_clk_ovr_on)
  ,.sync_o (cdma_global_clk_ovr_on_sync)
  );
//&Instance NV_NVDLA_sync3d_s u_global_clk_ovr_on_sync;
//&Connect clk nvdla_core_clk;
//&Connect prst nvdla_core_rstn;
//&Connect sync_i global_clk_ovr_on;
//&Connect sync_o global_clk_ovr_on_sync;
////////////////////////////////////////////////////////////////////////
// NVDLA Partition C: Convolution DMA //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_cdma u_NV_NVDLA_cdma (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.cdma2csb_resp_valid (cdma2csb_resp_valid)
  ,.cdma2csb_resp_pd (cdma2csb_resp_pd)
  ,.cdma2sc_dat_pending_ack (cdma2sc_dat_pending_ack)
  ,.cdma2sc_wt_pending_ack (cdma2sc_wt_pending_ack)
  ,.cdma_dat2mcif_rd_req_valid (cdma_dat2mcif_rd_req_valid)
  ,.cdma_dat2mcif_rd_req_ready (cdma_dat2mcif_rd_req_ready)
  ,.cdma_dat2mcif_rd_req_pd (cdma_dat2mcif_rd_req_pd)
  ,.cdma_wt2mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid)
  ,.cdma_wt2mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready)
  ,.cdma_wt2mcif_rd_req_pd (cdma_wt2mcif_rd_req_pd)
  ,.mcif2cdma_dat_rd_rsp_valid (mcif2cdma_dat_rd_rsp_valid)
  ,.mcif2cdma_dat_rd_rsp_ready (mcif2cdma_dat_rd_rsp_ready)
  ,.mcif2cdma_dat_rd_rsp_pd (mcif2cdma_dat_rd_rsp_pd )
  ,.mcif2cdma_wt_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid)
  ,.mcif2cdma_wt_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready)
  ,.mcif2cdma_wt_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd)
  ,.cdma_dat2glb_done_intr_pd (cdma_dat2glb_done_intr_pd)
  ,.cdma_wt2glb_done_intr_pd (cdma_wt2glb_done_intr_pd)
  ,.csb2cdma_req_pvld (csb2cdma_req_pvld)
  ,.csb2cdma_req_prdy (csb2cdma_req_prdy)
  ,.csb2cdma_req_pd (csb2cdma_req_pd)
  ,.cdma2buf_dat_wr_en (cdma2buf_dat_wr_en)
//: my $dmaif=64;
//: my $atmc=8*8;
//: if($dmaif < $atmc) {
//: my $k = int(log(int($atmc/$dmaif))/log(2));
//: print qq(
//: ,.cdma2buf_dat_wr_addr (cdma2buf_dat_wr_addr)
//: ,.cdma2buf_dat_wr_sel (cdma2buf_dat_wr_sel)
//: ,.cdma2buf_dat_wr_data (cdma2buf_dat_wr_data)
//: );
//: } elsif($dmaif > $atmc) {
//: my $k = int(log(int($dmaif/$atmc))/log(2));
//: print qq(
//: ,. cdma2buf_dat_wr_mask (cdma2buf_dat_wr_mask )
//: );
//: foreach my $i (0..$k-1) {
//: print qq(
//: ,.cdma2buf_dat_wr_addr${i} (cdma2buf_dat_wr_addr${i} )
//: ,.cdma2buf_dat_wr_data${i} (cdma2buf_dat_wr_data${i} )
//: );
//: }
//: } else {
//: print qq(
//: ,.cdma2buf_dat_wr_addr (cdma2buf_dat_wr_addr)
//: ,.cdma2buf_dat_wr_data (cdma2buf_dat_wr_data)
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.cdma2buf_dat_wr_addr (cdma2buf_dat_wr_addr)
,.cdma2buf_dat_wr_data (cdma2buf_dat_wr_data)

//| eperl: generated_end (DO NOT EDIT ABOVE)
//,.cdma2buf_dat_wr_addr (cdma2buf_dat_wr_addr)
//,.cdma2buf_dat_wr_hsel (cdma2buf_dat_wr_hsel)
//,.cdma2buf_dat_wr_data (cdma2buf_dat_wr_data)
  ,.cdma2buf_wt_wr_en (cdma2buf_wt_wr_en)
//: my $dmaif=64;
//: my $atmc=8*8;
//: if($dmaif < $atmc) {
//: my $k = int(log(int($atmc/$dmaif))/log(2));
//: print qq(
//: ,.cdma2buf_wt_wr_addr (cdma2buf_wt_wr_addr)
//: ,.cdma2buf_wt_wr_sel (cdma2buf_wt_wr_sel)
//: ,.cdma2buf_wt_wr_data (cdma2buf_wt_wr_data)
//: );
//: } elsif($dmaif > $atmc) {
//: my $k = int(log(int($dmaif/$atmc))/log(2));
//: print qq(
//: ,.cdma2buf_wt_wr_mask (cdma2buf_wt_wr_mask)
//: );
//: foreach my $i (0..$k-1) {
//: print qq(
//: ,.cdma2buf_wt_wr_addr${i} (cdma2buf_wt_wr_addr${i})
//: ,.cdma2buf_wt_wr_data${i} (cdma2buf_wt_wr_data${i})
//: );
//: }
//: } else {
//: print qq(
//: ,.cdma2buf_wt_wr_addr (cdma2buf_wt_wr_addr)
//: ,.cdma2buf_wt_wr_data (cdma2buf_wt_wr_data)
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.cdma2buf_wt_wr_addr (cdma2buf_wt_wr_addr)
,.cdma2buf_wt_wr_data (cdma2buf_wt_wr_data)

//| eperl: generated_end (DO NOT EDIT ABOVE)
//,.cdma2buf_wt_wr_addr (cdma2buf_wt_wr_addr)
//,.cdma2buf_wt_wr_hsel (cdma2buf_wt_wr_hsel)
//,.cdma2buf_wt_wr_data (cdma2buf_wt_wr_data)
  ,.cdma2sc_dat_updt (cdma2sc_dat_updt)
  ,.cdma2sc_dat_entries (cdma2sc_dat_entries)
  ,.cdma2sc_dat_slices (cdma2sc_dat_slices)
  ,.sc2cdma_dat_updt (sc2cdma_dat_updt)
  ,.sc2cdma_dat_entries (sc2cdma_dat_entries)
  ,.sc2cdma_dat_slices (sc2cdma_dat_slices)
  ,.pwrbus_ram_pd (pwrbus_ram_pd)
  ,.sc2cdma_dat_pending_req (sc2cdma_dat_pending_req)
  ,.sc2cdma_wt_pending_req (sc2cdma_wt_pending_req)
  ,.cdma2sc_wt_updt (cdma2sc_wt_updt)
  ,.cdma2sc_wt_kernels (cdma2sc_wt_kernels)
  ,.cdma2sc_wt_entries (cdma2sc_wt_entries)
  ,.cdma2sc_wmb_entries (cdma2sc_wmb_entries)
  ,.sc2cdma_wt_updt (sc2cdma_wt_updt)
  ,.sc2cdma_wt_kernels (sc2cdma_wt_kernels)
  ,.sc2cdma_wt_entries (sc2cdma_wt_entries)
  ,.sc2cdma_wmb_entries (sc2cdma_wmb_entries)
  ,.dla_clk_ovr_on_sync (cdma_dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (cdma_global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition C: Convolution Buffer //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_cbuf u_NV_NVDLA_cbuf (
// .nvdla_core_clk (nvdla_core_clk)
// ,.nvdla_core_rstn (nvdla_core_rstn)
// ,.pwrbus_ram_pd (pwrbus_ram_pd)
// ,.cdma2buf_dat_wr_en (cdma2buf_dat_wr_en)
// //: my $dmaif=NVDLA_DMAIF_BW;
// //: my $atmc=NVDLA_MAC_ATOMIC_C_SIZE*NVDLA_BPE;
// //: if($dmaif < $atmc) {
// //:     my $k = int(log(int($atmc/$dmaif))/log(2));
// //:     print qq(
// //:       ,.cdma2buf_dat_wr_addr          (cdma2buf_dat_wr_addr)
// //:       ,.cdma2buf_dat_wr_hsel          (cdma2buf_dat_wr_sel) 
// //:       ,.cdma2buf_dat_wr_data          (cdma2buf_dat_wr_data)
// //:     );
// //: } elsif($dmaif > $atmc) {
// //:     my $k = int(log(int($dmaif/$atmc))/log(2));
// //:     print qq(
// //:          ,. cdma2buf_dat_wr_mask      (cdma2buf_dat_wr_mask   )
// //:     );
// //:     foreach my $i (0..$k-1) {
// //:         print qq(
// //:             ,.cdma2buf_dat_wr_addr${i}      (cdma2buf_dat_wr_addr${i}   )
// //:             ,.cdma2buf_dat_wr_data${i}      (cdma2buf_dat_wr_data${i}   )
// //:         );
// //:     }
// //: } else {
// //:     print qq(
// //:       ,.cdma2buf_dat_wr_addr          (cdma2buf_dat_wr_addr)
// //:       ,.cdma2buf_dat_wr_data          (cdma2buf_dat_wr_data)
// //:     );
// //: }
// //,.cdma2buf_dat_wr_addr          (cdma2buf_dat_wr_addr)
// //,.cdma2buf_dat_wr_hsel          (cdma2buf_dat_wr_hsel)
// //,.cdma2buf_dat_wr_data          (cdma2buf_dat_wr_data)
// ,.cdma2buf_wt_wr_en (cdma2buf_wt_wr_en)
// //: my $dmaif=NVDLA_DMAIF_BW;
// //: my $atmc=NVDLA_MAC_ATOMIC_C_SIZE*NVDLA_BPE;
// //: if($dmaif < $atmc) {
// //:     my $k = int(log(int($atmc/$dmaif))/log(2));
// //:     print qq(
// //:         ,.cdma2buf_wt_wr_addr           (cdma2buf_wt_wr_addr) 
// //:         ,.cdma2buf_wt_wr_hsel            (cdma2buf_wt_wr_sel)        
// //:         ,.cdma2buf_wt_wr_data           (cdma2buf_wt_wr_data)
// //:     );
// //: } elsif($dmaif > $atmc) {
// //:     my $k = int(log(int($dmaif/$atmc))/log(2));
// //:     print qq(
// //:         ,.cdma2buf_wt_wr_mask    (cdma2buf_wt_wr_mask)
// //:     );
// //:     foreach my $i (0..$k-1) {
// //:         print qq(
// //:            ,.cdma2buf_wt_wr_addr${i}    (cdma2buf_wt_wr_addr${i})
// //:            ,.cdma2buf_wt_wr_data${i}    (cdma2buf_wt_wr_data${i})
// //:         );
// //:     }
// //: } else {
// //:     print qq(
// //:         ,.cdma2buf_wt_wr_addr           (cdma2buf_wt_wr_addr) 
// //:         ,.cdma2buf_wt_wr_data           (cdma2buf_wt_wr_data)
// //:     );
// //: }
// //,.cdma2buf_wt_wr_addr           (cdma2buf_wt_wr_addr) 
// //,.cdma2buf_wt_wr_hsel           (cdma2buf_wt_wr_hsel)       
// //,.cdma2buf_wt_wr_data           (cdma2buf_wt_wr_data)
// ,.sc2buf_dat_rd_en (sc2buf_dat_rd_en)
// ,.sc2buf_dat_rd_addr (sc2buf_dat_rd_addr)
// ,.sc2buf_dat_rd_valid (sc2buf_dat_rd_valid)
// ,.sc2buf_dat_rd_data (sc2buf_dat_rd_data)
// ,.sc2buf_wt_rd_en (sc2buf_wt_rd_en)
// ,.sc2buf_wt_rd_addr (sc2buf_wt_rd_addr)
// ,.sc2buf_wt_rd_valid (sc2buf_wt_rd_valid)
// ,.sc2buf_wt_rd_data (sc2buf_wt_rd_data)
// ,.sc2buf_wmb_rd_en (sc2buf_wmb_rd_en)
// ,.sc2buf_wmb_rd_addr (sc2buf_wmb_rd_addr)
// ,.sc2buf_wmb_rd_valid (sc2buf_wmb_rd_valid)
// ,.sc2buf_wmb_rd_data (sc2buf_wmb_rd_data)
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.cdma2buf_wr_en0 (cdma2buf_dat_wr_en) //|< w
  ,.cdma2buf_wr_addr0 (cdma2buf_dat_wr_addr[14 -1:0]) //|< w
  ,.cdma2buf_wr_data0 (cdma2buf_dat_wr_data)//DorisL cdma2buf_dat_wr_data_new)   //|< w
  ,.cdma2buf_wr_en1 (cdma2buf_wt_wr_en) //|< w
  ,.cdma2buf_wr_addr1 (cdma2buf_wt_wr_addr[14 -1:0]) //|< w
  ,.cdma2buf_wr_data1 (cdma2buf_wt_wr_data) //|< w
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_4
  ,.cdma2buf_wr_sel0 (cdma2buf_dat_wr_sel) //|< w
  ,.cdma2buf_wr_sel1 (cdma2buf_wt_wr_sel) //|< w
`endif
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_2
  ,.cdma2buf_wr_sel0 (cdma2buf_dat_wr_sel) //|< w
  ,.cdma2buf_wr_sel1 (cdma2buf_wt_wr_sel) //|< w
`endif
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_1
  ,.cdma2buf_wr_sel0 ({1{1'b1}}) //|< w
  ,.cdma2buf_wr_sel1 ({1{1'b1}}) //|< w
`endif
  ,.sc2buf_dat_rd_en (sc2buf_dat_rd_en) //|< w
  ,.sc2buf_dat_rd_addr (sc2buf_dat_rd_addr[14 -1:0]) //|< w
  ,.sc2buf_dat_rd_valid (sc2buf_dat_rd_valid) //|> w
  ,.sc2buf_dat_rd_shift (sc2buf_dat_rd_shift)
  ,.sc2buf_dat_rd_next1_en (sc2buf_dat_rd_next1_en)
  ,.sc2buf_dat_rd_next1_addr (sc2buf_dat_rd_next1_addr)
  ,.sc2buf_dat_rd_data (sc2buf_dat_rd_data[64 -1:0]) //|> w
  ,.sc2buf_wt_rd_en (sc2buf_wt_rd_en) //|< w
  ,.sc2buf_wt_rd_addr (sc2buf_wt_rd_addr[14 -1:0]) //|< w
  ,.sc2buf_wt_rd_valid (sc2buf_wt_rd_valid) //|> w
  ,.sc2buf_wt_rd_data (sc2buf_wt_rd_data[64 -1:0]) //|> w
  `ifdef CBUF_WEIGHT_COMPRESSED
  ,.sc2buf_wmb_rd_en (sc2buf_wmb_rd_en) //|< w
  ,.sc2buf_wmb_rd_addr (sc2buf_wmb_rd_addr[14 -1:0]) //|< w
  ,.sc2buf_wmb_rd_valid (sc2buf_wmb_rd_valid) //|> w
  ,.sc2buf_wmb_rd_data (sc2buf_wmb_rd_data[64 -1:0]) //|> w
  `endif
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition C: Convolution Sequence Controller //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_csc u_NV_NVDLA_csc (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< w
  ,.sc2cdma_dat_pending_req (sc2cdma_dat_pending_req) //|> w
  ,.sc2cdma_wt_pending_req (sc2cdma_wt_pending_req) //|> w
  ,.accu2sc_credit_vld (accu2sc_credit_vld) //|< i
  ,.accu2sc_credit_size (accu2sc_credit_size[2:0]) //|< i
  ,.cdma2sc_dat_pending_ack (cdma2sc_dat_pending_ack) //|< w
  ,.cdma2sc_wt_pending_ack (cdma2sc_wt_pending_ack) //|< w
  ,.csb2csc_req_pvld (csb2csc_req_pvld) //|< i
  ,.csb2csc_req_prdy (csb2csc_req_prdy) //|> o
  ,.csb2csc_req_pd (csb2csc_req_pd[62:0]) //|< i
  ,.csc2csb_resp_valid (csc2csb_resp_valid) //|> o
  ,.csc2csb_resp_pd (csc2csb_resp_pd[33:0]) //|> o
  ,.cdma2sc_dat_updt (cdma2sc_dat_updt) //|< w
  ,.cdma2sc_dat_entries (cdma2sc_dat_entries[15 -1:0]) //|< w
  ,.cdma2sc_dat_slices (cdma2sc_dat_slices[13:0]) //|< w
  ,.sc2cdma_dat_updt (sc2cdma_dat_updt) //|> w
  ,.sc2cdma_dat_entries (sc2cdma_dat_entries[15 -1:0]) //|> w
  ,.sc2cdma_dat_slices (sc2cdma_dat_slices[13:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.sc2buf_dat_rd_en (sc2buf_dat_rd_en) //|> w
  ,.sc2buf_dat_rd_addr (sc2buf_dat_rd_addr[14 -1:0]) //|> w
  ,.sc2buf_dat_rd_valid (sc2buf_dat_rd_valid) //|< w
  ,.sc2buf_dat_rd_data (sc2buf_dat_rd_data[64 -1:0]) //|< w
  ,.sc2buf_dat_rd_shift (sc2buf_dat_rd_shift[7 -1:0])
  ,.sc2buf_dat_rd_next1_en (sc2buf_dat_rd_next1_en)
  ,.sc2buf_dat_rd_next1_addr (sc2buf_dat_rd_next1_addr)
  `ifdef CBUF_WEIGHT_COMPRESSED
  ,.sc2buf_wmb_rd_en (sc2buf_wmb_rd_en) //|> w
  ,.sc2buf_wmb_rd_addr (sc2buf_wmb_rd_addr[14 -1:0]) //|> w
  ,.sc2buf_wmb_rd_valid (sc2buf_wmb_rd_valid) //|< w
  ,.sc2buf_wmb_rd_data (sc2buf_wmb_rd_data[64 -1:0]) //|< w
  `endif
  ,.sc2buf_wt_rd_en (sc2buf_wt_rd_en) //|> w
  ,.sc2buf_wt_rd_addr (sc2buf_wt_rd_addr[14 -1:0]) //|> w
  ,.sc2buf_wt_rd_valid (sc2buf_wt_rd_valid) //|< w
  ,.sc2buf_wt_rd_data (sc2buf_wt_rd_data[64 -1:0]) //|< w
  ,.sc2mac_dat_a_pvld (sc2mac_dat_a_pvld) //|> o
  ,.sc2mac_dat_a_mask (sc2mac_dat_a_mask[8 -1:0]) //|> o
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_dat_a_data${i} (sc2mac_dat_a_data${i}[8 -1:0]) //|> o   )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_a_data0 (sc2mac_dat_a_data0[8 -1:0]) //|> o   
,.sc2mac_dat_a_data1 (sc2mac_dat_a_data1[8 -1:0]) //|> o   
,.sc2mac_dat_a_data2 (sc2mac_dat_a_data2[8 -1:0]) //|> o   
,.sc2mac_dat_a_data3 (sc2mac_dat_a_data3[8 -1:0]) //|> o   
,.sc2mac_dat_a_data4 (sc2mac_dat_a_data4[8 -1:0]) //|> o   
,.sc2mac_dat_a_data5 (sc2mac_dat_a_data5[8 -1:0]) //|> o   
,.sc2mac_dat_a_data6 (sc2mac_dat_a_data6[8 -1:0]) //|> o   
,.sc2mac_dat_a_data7 (sc2mac_dat_a_data7[8 -1:0]) //|> o   
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_a_pd (sc2mac_dat_a_pd[8:0]) //|> o
  ,.sc2mac_dat_b_pvld (sc2mac_dat_b_pvld) //|> w
  ,.sc2mac_dat_b_mask (sc2mac_dat_b_mask[8 -1:0]) //|> w
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_dat_b_data${i} (sc2mac_dat_b_data${i}[8 -1:0]) //|> o   )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_b_data0 (sc2mac_dat_b_data0[8 -1:0]) //|> o   
,.sc2mac_dat_b_data1 (sc2mac_dat_b_data1[8 -1:0]) //|> o   
,.sc2mac_dat_b_data2 (sc2mac_dat_b_data2[8 -1:0]) //|> o   
,.sc2mac_dat_b_data3 (sc2mac_dat_b_data3[8 -1:0]) //|> o   
,.sc2mac_dat_b_data4 (sc2mac_dat_b_data4[8 -1:0]) //|> o   
,.sc2mac_dat_b_data5 (sc2mac_dat_b_data5[8 -1:0]) //|> o   
,.sc2mac_dat_b_data6 (sc2mac_dat_b_data6[8 -1:0]) //|> o   
,.sc2mac_dat_b_data7 (sc2mac_dat_b_data7[8 -1:0]) //|> o   
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_b_pd (sc2mac_dat_b_pd[8:0]) //|> w
  ,.sc2mac_wt_a_pvld (sc2mac_wt_a_pvld) //|> o
  ,.sc2mac_wt_a_mask (sc2mac_wt_a_mask[8 -1:0]) //|> o
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_wt_a_data${i} (sc2mac_wt_a_data${i}[8 -1:0]) //|> o   )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_wt_a_data0 (sc2mac_wt_a_data0[8 -1:0]) //|> o   
,.sc2mac_wt_a_data1 (sc2mac_wt_a_data1[8 -1:0]) //|> o   
,.sc2mac_wt_a_data2 (sc2mac_wt_a_data2[8 -1:0]) //|> o   
,.sc2mac_wt_a_data3 (sc2mac_wt_a_data3[8 -1:0]) //|> o   
,.sc2mac_wt_a_data4 (sc2mac_wt_a_data4[8 -1:0]) //|> o   
,.sc2mac_wt_a_data5 (sc2mac_wt_a_data5[8 -1:0]) //|> o   
,.sc2mac_wt_a_data6 (sc2mac_wt_a_data6[8 -1:0]) //|> o   
,.sc2mac_wt_a_data7 (sc2mac_wt_a_data7[8 -1:0]) //|> o   
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_wt_a_sel (sc2mac_wt_a_sel[8/2 -1:0]) //|> o
  ,.sc2mac_wt_b_pvld (sc2mac_wt_b_pvld) //|> w
  ,.sc2mac_wt_b_mask (sc2mac_wt_b_mask[8 -1:0]) //|> w
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_wt_b_data${i} (sc2mac_wt_b_data${i}[8 -1:0]) //|> o   )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_wt_b_data0 (sc2mac_wt_b_data0[8 -1:0]) //|> o   
,.sc2mac_wt_b_data1 (sc2mac_wt_b_data1[8 -1:0]) //|> o   
,.sc2mac_wt_b_data2 (sc2mac_wt_b_data2[8 -1:0]) //|> o   
,.sc2mac_wt_b_data3 (sc2mac_wt_b_data3[8 -1:0]) //|> o   
,.sc2mac_wt_b_data4 (sc2mac_wt_b_data4[8 -1:0]) //|> o   
,.sc2mac_wt_b_data5 (sc2mac_wt_b_data5[8 -1:0]) //|> o   
,.sc2mac_wt_b_data6 (sc2mac_wt_b_data6[8 -1:0]) //|> o   
,.sc2mac_wt_b_data7 (sc2mac_wt_b_data7[8 -1:0]) //|> o   
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_wt_b_sel (sc2mac_wt_b_sel[8/2 -1:0]) //|> w
  ,.cdma2sc_wt_updt (cdma2sc_wt_updt)
  ,.cdma2sc_wt_kernels (cdma2sc_wt_kernels)
  ,.cdma2sc_wt_entries (cdma2sc_wt_entries)
  ,.cdma2sc_wmb_entries (cdma2sc_wmb_entries)
  ,.sc2cdma_wt_updt (sc2cdma_wt_updt)
  ,.sc2cdma_wt_kernels (sc2cdma_wt_kernels)
  ,.sc2cdma_wt_entries (sc2cdma_wt_entries)
  ,.sc2cdma_wmb_entries (sc2cdma_wmb_entries)
  ,.dla_clk_ovr_on_sync (csc_dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (csc_global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  );
////////////////////////////////////////////////////////////////////////
// Dangles/Contenders report //
////////////////////////////////////////////////////////////////////////
endmodule // NV_NVDLA_partition_c
