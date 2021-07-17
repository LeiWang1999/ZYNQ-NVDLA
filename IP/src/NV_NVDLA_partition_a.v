// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_partition_a.v
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
`include "NV_HWACC_NVDLA_tick_defines.vh"
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC.h
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC.h
`define DESIGNWARE_NOEXIST 1
module NV_NVDLA_partition_a (
   cacc2sdp_ready
  ,csb2cacc_req_pvld
  ,csb2cacc_req_prdy
  ,csb2cacc_req_pd
  ,cacc2csb_resp_pd
  ,cacc2csb_resp_valid
  ,cacc2glb_done_intr_pd
  ,direct_reset_
  ,dla_reset_rstn
  ,global_clk_ovr_on
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,mac_a2accu_data${i} )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,mac_a2accu_data0 
,mac_a2accu_data1 
,mac_a2accu_data2 
,mac_a2accu_data3 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,mac_a2accu_mask
  ,mac_a2accu_mode
  ,mac_a2accu_pd
  ,mac_a2accu_pvld
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,mac_b2accu_data${i} )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,mac_b2accu_data0 
,mac_b2accu_data1 
,mac_b2accu_data2 
,mac_b2accu_data3 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,mac_b2accu_mask
  ,mac_b2accu_mode
  ,mac_b2accu_pd
  ,mac_b2accu_pvld
  ,nvdla_clk_ovr_on
  ,nvdla_core_clk
  ,pwrbus_ram_pd
  ,test_mode
  ,tmc2slcg_disable_clock_gating
  ,accu2sc_credit_size
  ,accu2sc_credit_vld
  ,cacc2sdp_pd
  ,cacc2sdp_valid
  );
//
// NV_NVDLA_partition_a_io.v
//
input test_mode;
input direct_reset_;
input global_clk_ovr_on;
input tmc2slcg_disable_clock_gating;
output accu2sc_credit_vld; /* data valid */
output [2:0] accu2sc_credit_size;
output cacc2csb_resp_valid; /* data valid */
output [33:0] cacc2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output [1:0] cacc2glb_done_intr_pd;
input csb2cacc_req_pvld; /* data valid */
output csb2cacc_req_prdy; /* data return handshake */
input [62:0] csb2cacc_req_pd;
output cacc2sdp_valid; /* data valid */
input cacc2sdp_ready; /* data return handshake */
output [32*1 +2 -1:0] cacc2sdp_pd;
input mac_a2accu_pvld; /* data valid */
input [8/2 -1:0] mac_a2accu_mask;
input mac_a2accu_mode;
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: input [19 -1:0] mac_a2accu_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [19 -1:0] mac_a2accu_data0; 
input [19 -1:0] mac_a2accu_data1; 
input [19 -1:0] mac_a2accu_data2; 
input [19 -1:0] mac_a2accu_data3; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8:0] mac_a2accu_pd;
input mac_b2accu_pvld; /* data valid */
input [8/2 -1:0] mac_b2accu_mask;
input mac_b2accu_mode;
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: input [19 -1:0] mac_b2accu_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [19 -1:0] mac_b2accu_data0; 
input [19 -1:0] mac_b2accu_data1; 
input [19 -1:0] mac_b2accu_data2; 
input [19 -1:0] mac_b2accu_data3; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8:0] mac_b2accu_pd;
input [31:0] pwrbus_ram_pd;
//input la_r_clk;
//input larstn;
input nvdla_core_clk;
input dla_reset_rstn;
input nvdla_clk_ovr_on;
wire dla_clk_ovr_on_sync;
wire global_clk_ovr_on_sync;
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: wire [19 -1:0] mac_b2accu_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [19 -1:0] mac_b2accu_data0; 
wire [19 -1:0] mac_b2accu_data1; 
wire [19 -1:0] mac_b2accu_data2; 
wire [19 -1:0] mac_b2accu_data3; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8/2 -1:0] mac_b2accu_mask;
wire mac_b2accu_mode;
wire [8:0] mac_b2accu_pd;
wire mac_b2accu_pvld;
wire nvdla_core_rstn;
////////////////////////////////////////////////////////////////////////
// NVDLA Partition M: Reset Syncer //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_reset u_partition_a_reset (
   .dla_reset_rstn (dla_reset_rstn) //|< i
  ,.direct_reset_ (direct_reset_) //|< i
  ,.test_mode (test_mode) //|< i
  ,.synced_rstn (nvdla_core_rstn) //|> w
  ,.nvdla_clk (nvdla_core_clk) //|< i
  );
////////////////////////////////////////////////////////////////////////
// SLCG override
////////////////////////////////////////////////////////////////////////
NV_NVDLA_sync3d u_dla_clk_ovr_on_sync (
   .clk (nvdla_core_clk) //|< i
  ,.sync_i (nvdla_clk_ovr_on) //|< i
  ,.sync_o (dla_clk_ovr_on_sync) //|> w
  );
NV_NVDLA_sync3d_s u_global_clk_ovr_on_sync (
   .clk (nvdla_core_clk) //|< i
  ,.prst (nvdla_core_rstn) //|< w
  ,.sync_i (global_clk_ovr_on) //|< i
  ,.sync_o (global_clk_ovr_on_sync) //|> w
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition A: Convolution Accumulator //
////////////////////////////////////////////////////////////////////////
//stepheng, modify for cacc verification
NV_NVDLA_cacc u_NV_NVDLA_cacc (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd)
  ,.csb2cacc_req_pvld (csb2cacc_req_pvld)
  ,.csb2cacc_req_prdy (csb2cacc_req_prdy)
  ,.csb2cacc_req_pd (csb2cacc_req_pd)
  ,.cacc2csb_resp_valid (cacc2csb_resp_valid)
  ,.cacc2csb_resp_pd (cacc2csb_resp_pd)
  ,.cacc2glb_done_intr_pd (cacc2glb_done_intr_pd)
  ,.mac_a2accu_pvld (mac_a2accu_pvld) //|< i
  ,.mac_a2accu_mask (mac_a2accu_mask[8/2 -1:0]) //|< i
  ,.mac_a2accu_mode (mac_a2accu_mode) //|< i
//:for(my $i=0; $i<8/2; $i++){
//: print ",.mac_a2accu_data${i}              (mac_a2accu_data${i}) \n"; #//|< i
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
,.mac_a2accu_data0              (mac_a2accu_data0) 
,.mac_a2accu_data1              (mac_a2accu_data1) 
,.mac_a2accu_data2              (mac_a2accu_data2) 
,.mac_a2accu_data3              (mac_a2accu_data3) 

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac_a2accu_pd (mac_a2accu_pd[8:0]) //|< i
  ,.mac_b2accu_pvld (mac_b2accu_pvld) //|< w
  ,.mac_b2accu_mask (mac_b2accu_mask[8/2 -1:0]) //|< w
  ,.mac_b2accu_mode (mac_b2accu_mode) //|< w
//:for(my $i=0; $i<8/2; $i++){
//: print ",.mac_b2accu_data${i}              (mac_b2accu_data${i}) \n"; #//|< i
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
,.mac_b2accu_data0              (mac_b2accu_data0) 
,.mac_b2accu_data1              (mac_b2accu_data1) 
,.mac_b2accu_data2              (mac_b2accu_data2) 
,.mac_b2accu_data3              (mac_b2accu_data3) 

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac_b2accu_pd (mac_b2accu_pd[8:0]) //|< w
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd)
  ,.accu2sc_credit_vld (accu2sc_credit_vld)
  ,.accu2sc_credit_size (accu2sc_credit_size)
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition A: OBS //
////////////////////////////////////////////////////////////////////////
//&Instance NV_NVDLA_A_obs;
////////////////////////////////////////////////////////////////////////
// Dangles/Contenders report //
////////////////////////////////////////////////////////////////////////
//|
//|
//|
//|
endmodule // NV_NVDLA_partition_a
