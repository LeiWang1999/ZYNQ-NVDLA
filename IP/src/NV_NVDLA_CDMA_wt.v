// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDMA_wt.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDMA_define.h
//#define CDMA_SBUF_SDATA_BITS            256
//DorisL-S----------------
//
// #if ( NVDLA_MEMORY_ATOMIC_SIZE  ==  32 )
//     #define IMG_LARGE
// #endif
// #if ( NVDLA_MEMORY_ATOMIC_SIZE == 8 )
//     #define IMG_SMALL
// #endif
//DorisL-E----------------
//--------------------------------------------------
module NV_NVDLA_CDMA_wt (
   nvdla_core_clk //|< i
  ,nvdla_core_ng_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cdma_wt2mcif_rd_req_ready //|< i
  ,mcif2cdma_wt_rd_rsp_pd //|< i
  ,mcif2cdma_wt_rd_rsp_valid //|< i
  ,pwrbus_ram_pd //|< i
  ,reg2dp_arb_weight //|< i
  ,reg2dp_arb_wmb //|< i
  ,reg2dp_byte_per_kernel //|< i
  ,reg2dp_data_bank //|< i
  ,reg2dp_dma_en //|< i
  ,reg2dp_nan_to_zero //|< i
  ,reg2dp_op_en //|< i
  ,reg2dp_proc_precision //|< i
  ,reg2dp_skip_weight_rls //|< i
  ,reg2dp_weight_addr_high //|< i
  ,reg2dp_weight_addr_low //|< i
  ,reg2dp_weight_bank //|< i
  ,reg2dp_weight_bytes //|< i
  ,reg2dp_weight_format //|< i
  ,reg2dp_weight_kernel //|< i
  ,reg2dp_weight_ram_type //|< i
  ,reg2dp_weight_reuse //|< i
  ,reg2dp_wgs_addr_high //|< i
  ,reg2dp_wgs_addr_low //|< i
  ,reg2dp_wmb_addr_high //|< i
  ,reg2dp_wmb_addr_low //|< i
  ,reg2dp_wmb_bytes //|< i
  ,sc2cdma_wmb_entries //|< i
  ,sc2cdma_wt_entries //|< i
  ,sc2cdma_wt_kernels //|< i *
  ,sc2cdma_wt_pending_req //|< i
  ,sc2cdma_wt_updt //|< i
  ,status2dma_fsm_switch //|< i
  ,cdma2buf_wt_wr_en //|> o
//: my $dmaif=64;
//: my $atmc=8*8;
//: if($dmaif < $atmc) {
//: print qq(
//: ,cdma2buf_wt_wr_sel
//: ,cdma2buf_wt_wr_addr
//: ,cdma2buf_wt_wr_data
//: );
//: } elsif($dmaif > $atmc) {
//: my $k = int(log(int($dmaif/$atmc))/log(2));
//: print qq(
//: ,cdma2buf_wt_wr_mask
//: );
//: foreach my $i (0..$k-1) {
//: print qq(
//: ,cdma2buf_wt_wr_addr${i}
//: ,cdma2buf_wt_wr_data${i}
//: );
//: }
//: } else {
//: print qq(
//: ,cdma2buf_wt_wr_addr
//: ,cdma2buf_wt_wr_data
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,cdma2buf_wt_wr_addr
,cdma2buf_wt_wr_data

//| eperl: generated_end (DO NOT EDIT ABOVE)
//,cdma2buf_wt_wr_addr //|> o
//,cdma2buf_wt_wr_data //|> o
//,cdma2buf_wt_wr_hsel //|> o
  ,cdma2sc_wmb_entries //|> o
  ,cdma2sc_wt_entries //|> o
  ,cdma2sc_wt_kernels //|> o
  ,cdma2sc_wt_pending_ack //|> o
  ,cdma2sc_wt_updt //|> o
  ,cdma_wt2mcif_rd_req_pd //|> o
  ,cdma_wt2mcif_rd_req_valid //|> o
  ,dp2reg_inf_weight_num //|> o
  ,dp2reg_nan_weight_num //|> o
  ,dp2reg_wt_flush_done //|> o
  ,dp2reg_wt_rd_latency //|> o
  ,dp2reg_wt_rd_stall //|> o
  ,mcif2cdma_wt_rd_rsp_ready //|> o
  ,wt2status_state //|> o
  );
/////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
output cdma_wt2mcif_rd_req_valid;
input cdma_wt2mcif_rd_req_ready;
output [( 32 + 15 )-1:0] cdma_wt2mcif_rd_req_pd;
input mcif2cdma_wt_rd_rsp_valid;
output mcif2cdma_wt_rd_rsp_ready;
input [( 64 + (64/8/8) )-1:0] mcif2cdma_wt_rd_rsp_pd;
output cdma2buf_wt_wr_en;
//: my $dmaif=64;
//: my $atmc=8*8;
//: if($dmaif < $atmc) {
//: my $k = int($atmc/$dmaif);
//: print qq(
//: output [${k}-1:0] cdma2buf_wt_wr_sel ;
//: output [16:0] cdma2buf_wt_wr_addr;
//: output [${dmaif}-1:0] cdma2buf_wt_wr_data;
//: );
//: } elsif($dmaif > $atmc) {
//: my $k = int(log(int($dmaif/$atmc))/log(2));
//: print qq(
//: output [${k}-1:0] cdma2buf_wt_wr_mask;
//: );
//: foreach my $i (0..$k-1) {
//: print qq(
//: output [16:0] cdma2buf_wt_wr_addr${i};
//: output [${dmaif}-1:0] cdma2buf_wt_wr_data${i};
//: );
//: }
//: } else {
//: print qq(
//: output [16:0] cdma2buf_wt_wr_addr;
//: output [${dmaif}-1:0] cdma2buf_wt_wr_data;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [16:0] cdma2buf_wt_wr_addr;
output [64-1:0] cdma2buf_wt_wr_data;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input status2dma_fsm_switch;
output [1:0] wt2status_state;
output cdma2sc_wt_updt;
output [13:0] cdma2sc_wt_kernels;
output [14:0] cdma2sc_wt_entries;
output [11:0] cdma2sc_wmb_entries;
input sc2cdma_wt_updt;
input [13:0] sc2cdma_wt_kernels;
input [14:0] sc2cdma_wt_entries;
input [8:0] sc2cdma_wmb_entries;
input sc2cdma_wt_pending_req;
output cdma2sc_wt_pending_ack;
input nvdla_core_ng_clk;
input [3:0] reg2dp_arb_weight;
input [3:0] reg2dp_arb_wmb;
input [0:0] reg2dp_op_en;
input [1:0] reg2dp_proc_precision;
input [0:0] reg2dp_weight_reuse;
input [0:0] reg2dp_skip_weight_rls;
input [0:0] reg2dp_weight_format;
input [17:0] reg2dp_byte_per_kernel;
input [12:0] reg2dp_weight_kernel;
input [0:0] reg2dp_weight_ram_type;
//: my $atmm = 8;
//: my $atmbw = int(log(${atmm})/log(2));
//: print qq(
//: input [31-${atmbw}:0] reg2dp_weight_addr_low;
//: input [31-${atmbw}:0] reg2dp_wgs_addr_low;
//: input [31-${atmbw}:0] reg2dp_wmb_addr_low;
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [31-3:0] reg2dp_weight_addr_low;
input [31-3:0] reg2dp_wgs_addr_low;
input [31-3:0] reg2dp_wmb_addr_low;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input [31:0] reg2dp_weight_addr_high;
input [31:0] reg2dp_weight_bytes;
input [31:0] reg2dp_wgs_addr_high;
input [31:0] reg2dp_wmb_addr_high;
input [27:0] reg2dp_wmb_bytes;
input [4:0] reg2dp_data_bank;
input [4:0] reg2dp_weight_bank;
input [0:0] reg2dp_nan_to_zero;
input [0:0] reg2dp_dma_en;
output [31:0] dp2reg_nan_weight_num;
output [31:0] dp2reg_inf_weight_num;
output dp2reg_wt_flush_done;
output [31:0] dp2reg_wt_rd_stall;
output [31:0] dp2reg_wt_rd_latency;
/////////////////////////////////////////////////////
reg [18:0] byte_per_kernel;
reg [16:0] cdma2buf_wt_wr_addr;
reg cdma2buf_wt_wr_en;
//: my $dmaif=64;
//: my $atmc=8*8;
//: if($dmaif < $atmc) {
//: my $k = int(log(int($atmc/$dmaif))/log(2));
//: my $s = int($atmc/$dmaif);
//: print qq(
//: reg [${s}-1:0] cdma2buf_wt_wr_sel ;
//: wire [${k}-1:0] cdma2buf_wt_wr_sel_w;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

//| eperl: generated_end (DO NOT EDIT ABOVE)
//reg cdma2buf_wt_wr_sel;
reg [1:0] cur_state;
reg [1:0] dbg_dma_req_src_b0;
reg [1:0] dbg_dma_req_src_b1;
reg dbg_src_rd_ptr;
reg dbg_src_wr_ptr;
reg [31:0] dbg_wmb_kernel_bits;
reg [31:0] dbg_wt_kernel_bytes;
wire [3:0] dma_req_size;
wire [2:0] dma_req_size_out;
//: my $mask = (64/8/8);
//: my $atmm = (8 * 8);
//: print qq(
//: wire [${atmm}-1:0] wt_local_data_w;
//: reg [${atmm}-1:0] wt_local_data;
//: wire [${atmm}-1:0] wmb_local_data_w;
//: reg [${atmm}-1:0] wmb_local_data;
//: reg [${atmm}-1:0] wgs_local_data;
//: );
//: foreach my $i(0..$mask-1) {
//: print qq(
//: wire [${atmm}-1:0] dma_rsp_data_p${i};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [64-1:0] wt_local_data_w;
reg [64-1:0] wt_local_data;
wire [64-1:0] wmb_local_data_w;
reg [64-1:0] wmb_local_data;
reg [64-1:0] wgs_local_data;

wire [64-1:0] dma_rsp_data_p0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [64 -1:0] wt_cbuf_wr_data_ori_w;
wire [64 -1:0] wt_cbuf_wr_data_w;
reg [64 -1:0] cdma2buf_wt_wr_data;
wire [64 -1:0] wmb_cbuf_wr_data_w;
wire [64 -1:0] cdma2buf_wt_wr_data_w;
wire [3:0] dma_rsp_size;
reg [3:0] dma_rsp_size_cnt;
wire [31:0] dp2reg_wt_rd_latency=32'd0;
reg [31:0] dp2reg_wt_rd_stall;
reg [11:0] group;
reg [14:0] incr_wt_entries;
reg [5:0] incr_wt_kernels;
reg incr_wt_updt;
reg [4:0] last_data_bank;
reg last_skip_weight_rls;
reg [4:0] last_weight_bank;
reg layer_st_d1;
reg ltc_1_adv;
reg [10:0] ltc_1_cnt_dec;
reg [10:0] ltc_1_cnt_ext;
reg [10:0] ltc_1_cnt_inc;
reg [10:0] ltc_1_cnt_mod;
reg [10:0] ltc_1_cnt_new;
reg [10:0] ltc_1_cnt_nxt;
reg [8:0] ltc_1_cnt_cur;
wire ltc_1_dec;
wire ltc_1_inc;
reg ltc_2_adv;
reg [33:0] ltc_2_cnt_dec;
reg [33:0] ltc_2_cnt_ext;
reg [33:0] ltc_2_cnt_inc;
reg [33:0] ltc_2_cnt_mod;
reg [33:0] ltc_2_cnt_new;
reg [33:0] ltc_2_cnt_nxt;
reg ltc_2_dec;
reg ltc_2_inc;
reg [31:0] ltc_2_cnt_cur;
reg nan_pass;
reg [1:0] nxt_state;
reg [8:0] outs_dp2reg_wt_rd_latency;
reg pending_ack;
reg pending_req;
reg pending_req_d1;
reg [25:0] pre_wt_fetched_cnt;
reg [31:0] pre_wt_required_bytes;
reg required_valid;
reg [14:0] sc_wt_entries;
reg sc_wt_updt;
reg status_done;
reg [3:0] status_done_cnt;
reg [11:0] status_group_cnt;
reg stl_adv;
reg [31:0] stl_cnt_cur;
reg [33:0] stl_cnt_dec;
reg [33:0] stl_cnt_ext;
reg [33:0] stl_cnt_inc;
reg [33:0] stl_cnt_mod;
reg [33:0] stl_cnt_new;
reg [33:0] stl_cnt_nxt;
reg [5:0] weight_bank;
reg [6:0] weight_bank_end;
reg [1:0] wt2status_state;
////: my $bank_entry = NVDLA_CBUF_BANK_NUMBER * NVDLA_CBUF_BANK_DEPTH;
////: my $bank_entry_bw = int( log( $bank_entry)/log(2) );
////: my $dmaif=NVDLA_CDMA_DMAIF_BW;
////: my $atmc=NVDLA_MAC_ATOMIC_C_SIZE*NVDLA_CDMA_BPE;
////: my $k;
////: if($dmaif < $atmc) {
////:     $k = int(log(int($atmc/$dmaif))/log(2));
////: } else {
////:     $k = 0;
////: }
////: print qq(
////: reg     [${bank_entry_bw}+$k-1:0] wt_cbuf_flush_idx;//max value = half bank entry * 2^$k
////: );
reg [17:0] wt_cbuf_flush_idx;
reg [16:0] wt_cbuf_wr_idx;
reg [16:0] wt_data_avl;
reg [13:0] wt_data_onfly;
reg [16:0] wt_data_stored;
reg [25:0] wt_fetched_cnt;
reg [31:0] wt_fp16_inf_flag;
reg wt_fp16_inf_vld;
reg [31:0] wt_fp16_nan_flag;
reg wt_fp16_nan_vld;
reg wt_local_data_vld;
reg wt_rd_latency_cen;
reg wt_rd_latency_clr;
reg wt_rd_latency_dec;
reg wt_rd_latency_inc;
reg wt_rd_stall_cen;
reg wt_rd_stall_clr;
reg wt_rd_stall_inc;
reg wt_req_done_d2;
reg wt_req_done_d3;
reg wt_req_last_d2;
reg [3:0] wt_req_size_d1;
reg [3:0] wt_req_size_d2;
reg [3:0] wt_req_size_d3;
reg [2:0] wt_req_size_out_d2;
reg [2:0] wt_req_size_out_d3;
reg wt_req_stage_vld_d1;
reg wt_req_stage_vld_d2;
reg wt_req_vld_d3;
reg [31:0] wt_required_bytes;
wire arb_sp_out_vld;
wire arb_sp_out_rdy;
wire [16:0] cdma2buf_wt_wr_addr_w;
wire cdma2buf_wt_wr_en_w;
//wire cdma2buf_wt_wr_sel_w;
wire clear_all;
wire [5:0] data_bank_w;
wire [1:0] dbg_dma_req_src;
wire dbg_full_weight;
wire dbg_src_rd_ptr_en;
wire dbg_src_rd_ptr_w;
wire dbg_src_wr_ptr_en;
wire dbg_src_wr_ptr_w;
wire [31:0] dbg_wt_kernel_bytes_w;
wire [63:0] dma_rd_req_addr;
wire [32 +14:0] dma_rd_req_pd;
wire dma_rd_req_rdy;
wire [14:0] dma_rd_req_size;
wire dma_rd_req_type;
wire dma_rd_req_vld;
wire [64 -1:0] dma_rd_rsp_data;
wire [( 64 + (64/8/8) )-64 -1:0] dma_rd_rsp_mask;
wire [( 64 + (64/8/8) )-1:0] dma_rd_rsp_pd;
wire dma_rd_rsp_rdy;
wire dma_rd_rsp_vld;
wire [5:0] dma_req_fifo_data;
wire dma_req_fifo_ready;
wire dma_req_fifo_req;
wire [1:0] dma_req_src;
wire [5:0] dma_rsp_fifo_data;
wire dma_rsp_fifo_ready;
wire dma_rsp_fifo_req;
wire [3:0] dma_rsp_size_cnt_inc;
wire [3:0] dma_rsp_size_cnt_w;
wire [1:0] dma_rsp_src;
wire [31:0] dp2reg_inf_weight_num_inc;
wire [31:0] dp2reg_inf_weight_num_w;
wire [31:0] dp2reg_nan_weight_num_inc;
wire [31:0] dp2reg_nan_weight_num_w;
wire dp2reg_wt_rd_stall_dec;
wire fetch_done;
wire [10:0] group_op;
wire [11:0] group_w;
wire [25:0] incr_wt_cnt;
wire [14:0] incr_wt_entries_d0;
wire [14:0] incr_wt_entries_w;
wire [5:0] incr_wt_kernels_d0;
wire [5:0] incr_wt_kernels_w;
wire incr_wt_updt_d0;
wire inf_carry;
wire inf_reg_en;
wire is_compressed;
wire is_fp16;
wire is_int8;
wire is_nxt_running;
wire is_pending;
wire is_running;
wire layer_end;
wire layer_st;
wire mon_dma_rsp_size_cnt_inc;
wire mon_incr_wt_cnt;
wire mon_wt_cbuf_flush_idx_w;
wire mon_wt_data_avl_w;
wire mon_wt_data_onfly_w;
wire mon_wt_data_stored_w;
wire mon_wt_fetched_cnt_inc;
wire mon_wt_req_burst_cnt_dec;
wire mon_wt_req_sum;
wire mon_wt_required_bytes_w;
wire nan_carry;
wire nan_pass_w;
wire nan_reg_en;
wire need_pending;
wire [23:0] normal_bpg;
wire pending_req_end;
wire [25:0] pre_wt_fetched_cnt_w;
wire [31:0] pre_wt_required_bytes_w;
wire rd_req_rdyi;
wire required_valid_w;
wire [4:0] status_done_cnt_w;
wire status_done_w;
wire [11:0] status_group_cnt_inc;
wire [11:0] status_group_cnt_w;
wire status_last_group;
wire status_update;
wire [6:0] weight_bank_end_w;
wire [5:0] weight_bank_w;
wire [1:0] wt2status_state_w;
wire [17:0] wt_cbuf_flush_idx_w;
wire wt_cbuf_flush_vld_w;
wire [17:0] wt_cbuf_wr_idx_inc;
wire wt_cbuf_wr_idx_set;
wire [16:0] wt_cbuf_wr_idx_w;
wire wt_cbuf_wr_idx_wrap;
wire wt_cbuf_wr_vld_w;
wire [16:0] wt_data_avl_sub;
wire [16:0] wt_data_avl_w;
wire [3:0] wt_data_onfly_add;
wire wt_data_onfly_reg_en;
wire [3:0] wt_data_onfly_sub;
wire [13:0] wt_data_onfly_w;
wire [16:0] wt_data_stored_sub;
wire [16:0] wt_data_stored_w;
wire [25:0] wt_fetched_cnt_inc;
wire [25:0] wt_fetched_cnt_w;
wire [31:0] wt_fp16_exp_flag_w;
wire [31:0] wt_fp16_inf_flag_w;
wire [5:0] wt_fp16_inf_sum;
wire wt_fp16_inf_vld_w;
wire [31:0] wt_fp16_manti_flag_w;
wire [31:0] wt_fp16_nan_flag_w;
wire [5:0] wt_fp16_nan_sum;
wire wt_fp16_nan_vld_w;
//: my $mask = (64/8/8);
//: if($mask == 4) {
//: print qq(
//: wire [2:0] wt_local_data_cnt;
//: );
//: } else {
//: print qq(
//: wire [1:0] wt_local_data_cnt;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [1:0] wt_local_data_cnt;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//wire [2:0] wt_local_data_cnt;
wire wt_local_data_reg_en;
wire wt_local_data_vld_w;
//wire [511:0] wt_nan_mask;
//: my $atmm = 8;
//: my $atmbw = int(log(${atmm})/log(2));
//: print qq(
//: wire [64-${atmbw}-1:0] wt_req_addr_w;
//: reg [64-${atmbw}-1:0] wt_req_addr_d2;
//: reg [64-${atmbw}-1:0] wt_req_addr_d3;
//: wire [64-${atmbw}-1:0] dma_req_addr;
//: wire [64-${atmbw}-1-3:0] wt_req_addr_inc;
//: wire [64-${atmbw}-1:0] wmb_req_addr_w;
//: reg [64-${atmbw}-1:0] wmb_req_addr_d2;
//: reg [64-${atmbw}-1:0] wmb_req_addr_d3;
//: wire [64-${atmbw}-1-3:0] wmb_req_addr_inc;
//: wire [64-${atmbw}-1:0] wgs_req_addr_w;
//: wire [64-${atmbw}-1:0] wgs_req_addr_inc;
//: reg [64-${atmbw}-1:0] wgs_req_addr_d1;
//: wire [64-${atmbw}-1+9:0] arb_wrr_req_package_in_00;
//: wire [64-${atmbw}-1+9:0] arb_wrr_req_package_in_01;
//: wire [64-${atmbw}-1+9:0] arb_wrr_out_package_w;
//: reg [64-${atmbw}-1+9:0] arb_wrr_out_package;
//: reg [64-${atmbw}-1+9:0] arb_wrr_out_back_package;
//: reg [64-${atmbw}-1+9:0] arb_sp_req_package_in_00;
//: reg [64-${atmbw}-1+9:0] arb_sp_req_package_in_01;
//: );
//: my $atmm = 8;
//: my $k = int( log(${atmm}) / log(2) );
//: print qq(
//: wire [32-${k}-1:0] wt_req_burst_cnt_w;
//: reg [32-${k}-1:0] wt_req_burst_cnt_d1;
//: wire [32-${k}-1:0] wt_req_burst_cnt_dec;
//: wire [28-${k}-1:0] wmb_req_burst_cnt_w;
//: wire [28-${k}-1:0] wmb_req_burst_cnt_dec;
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [64-3-1:0] wt_req_addr_w;
reg [64-3-1:0] wt_req_addr_d2;
reg [64-3-1:0] wt_req_addr_d3;
wire [64-3-1:0] dma_req_addr;
wire [64-3-1-3:0] wt_req_addr_inc;
wire [64-3-1:0] wmb_req_addr_w;
reg [64-3-1:0] wmb_req_addr_d2;
reg [64-3-1:0] wmb_req_addr_d3;
wire [64-3-1-3:0] wmb_req_addr_inc;
wire [64-3-1:0] wgs_req_addr_w;
wire [64-3-1:0] wgs_req_addr_inc;
reg [64-3-1:0] wgs_req_addr_d1;
wire [64-3-1+9:0] arb_wrr_req_package_in_00;
wire [64-3-1+9:0] arb_wrr_req_package_in_01;
wire [64-3-1+9:0] arb_wrr_out_package_w;
reg [64-3-1+9:0] arb_wrr_out_package;
reg [64-3-1+9:0] arb_wrr_out_back_package;
reg [64-3-1+9:0] arb_sp_req_package_in_00;
reg [64-3-1+9:0] arb_sp_req_package_in_01;

wire [32-3-1:0] wt_req_burst_cnt_w;
reg [32-3-1:0] wt_req_burst_cnt_d1;
wire [32-3-1:0] wt_req_burst_cnt_dec;
wire [28-3-1:0] wmb_req_burst_cnt_w;
wire [28-3-1:0] wmb_req_burst_cnt_dec;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire wt_req_done_w;
wire wt_req_last_w;
wire wt_req_overflow;
wire wt_req_overflow_d3;
wire wt_req_rdy;
wire wt_req_reg_en;
wire wt_req_reg_en_d0;
wire wt_req_reg_en_d1;
wire wt_req_reg_en_d2;
wire [3:0] wt_req_size_addr_limit;
wire [2:0] wt_req_size_out_w;
wire [3:0] wt_req_size_w;
wire [1:0] wt_req_src_d3;
wire [16:0] wt_req_sum;
wire wt_req_vld_w;
wire [31:0] wt_required_bytes_w;
wire wt_required_en;
wire wt_rsp_valid;
wire wt_satisfied;
wire [31:0] dp2reg_nan_weight_num;
wire [31:0] dp2reg_inf_weight_num;
////////////////////////////////////////////////////////////////////////
// CDMA weight fetching logic FSM //
////////////////////////////////////////////////////////////////////////
//## fsm (1) defines
localparam WT_STATE_IDLE = 2'b00;
localparam WT_STATE_PEND = 2'b01;
localparam WT_STATE_BUSY = 2'b10;
localparam WT_STATE_DONE = 2'b11;
always @(*) begin
    nxt_state = cur_state;
    begin
        casez (cur_state)
        WT_STATE_IDLE: begin
            if ((reg2dp_op_en & need_pending)) begin
                nxt_state = WT_STATE_PEND;
            end
            else if ((reg2dp_op_en & reg2dp_weight_reuse & last_skip_weight_rls)) begin
                nxt_state = WT_STATE_DONE;
            end
            else if (reg2dp_op_en) begin
                nxt_state = WT_STATE_BUSY;
            end
        end
        WT_STATE_PEND: begin
            if ((pending_req_end)) begin
                nxt_state = WT_STATE_BUSY;
            end
        end
        WT_STATE_BUSY: begin
            if (fetch_done) begin
                nxt_state = WT_STATE_DONE;
            end
        end
        WT_STATE_DONE: begin
            if (status2dma_fsm_switch) begin
                nxt_state = WT_STATE_IDLE;
            end
        end
        endcase
    end
end
//: &eperl::flop("-nodeclare   -rval \"WT_STATE_IDLE\"   -d \"nxt_state\" -q cur_state");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cur_state <= WT_STATE_IDLE;
   end else begin
       cur_state <= nxt_state;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// FSM input signals //
////////////////////////////////////////////////////////////////////////
assign status_done_cnt_w[4:0] = layer_st ? 5'b0 :
                                (status_done & (status_done_cnt != 4'h8)) ? (status_done_cnt + 4'b1) : status_done_cnt;
assign fetch_done = status_done & (status_done_cnt == 4'h8);
assign need_pending = ((last_data_bank != reg2dp_data_bank) | (last_weight_bank != reg2dp_weight_bank));
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        status_done_cnt <= {4{1'b0}};
    end else begin
        if ((layer_st | is_running) == 1'b1) begin
            status_done_cnt <= status_done_cnt_w[3:0];
        end
    end
end
////////////////////////////////////////////////////////////////////////
// FSM output signals //
////////////////////////////////////////////////////////////////////////
assign layer_st = reg2dp_op_en && (cur_state == WT_STATE_IDLE);
assign layer_end = status2dma_fsm_switch;
assign is_running = (cur_state == WT_STATE_BUSY);
assign is_pending = (cur_state == WT_STATE_PEND);
assign clear_all = pending_ack & pending_req;
assign is_nxt_running = (nxt_state == WT_STATE_BUSY);
assign wt2status_state_w = (nxt_state == WT_STATE_PEND) ? 1 :
                           (nxt_state == WT_STATE_BUSY) ? 2 :
                           (nxt_state == WT_STATE_DONE) ? 3 :
                           0 ;
assign pending_req_end = pending_req_d1 & ~pending_req;
//: &eperl::flop("-nodeclare   -rval \"0\"   -d \"wt2status_state_w\" -q wt2status_state");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sc2cdma_wt_pending_req\" -q pending_req");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"pending_req\" -q pending_req_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"is_pending\" -q pending_ack");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt2status_state <= 'b0;
   end else begin
       wt2status_state <= wt2status_state_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pending_req <= 1'b0;
   end else begin
       pending_req <= sc2cdma_wt_pending_req;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pending_req_d1 <= 1'b0;
   end else begin
       pending_req_d1 <= pending_req;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pending_ack <= 1'b0;
   end else begin
       pending_ack <= is_pending;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign cdma2sc_wt_pending_ack = pending_ack;
////////////////////////////////////////////////////////////////////////
// registers to keep last layer status //
////////////////////////////////////////////////////////////////////////
//: &eperl::flop("-nodeclare   -rval \"{5{1'b1}}\"  -en \"layer_end\" -d \"reg2dp_data_bank\" -q last_data_bank");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b1}}\"  -en \"layer_end\" -d \"reg2dp_weight_bank\" -q last_weight_bank");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"layer_end\" -d \"reg2dp_skip_weight_rls\" -q last_skip_weight_rls");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"layer_st\" -q layer_st_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_data_bank <= {5{1'b1}};
   end else begin
       if ((layer_end) == 1'b1) begin
           last_data_bank <= reg2dp_data_bank;
       // VCS coverage off
       end else if ((layer_end) == 1'b0) begin
       end else begin
           last_data_bank <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_weight_bank <= {5{1'b1}};
   end else begin
       if ((layer_end) == 1'b1) begin
           last_weight_bank <= reg2dp_weight_bank;
       // VCS coverage off
       end else if ((layer_end) == 1'b0) begin
       end else begin
           last_weight_bank <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_skip_weight_rls <= 1'b0;
   end else begin
       if ((layer_end) == 1'b1) begin
           last_skip_weight_rls <= reg2dp_skip_weight_rls;
       // VCS coverage off
       end else if ((layer_end) == 1'b0) begin
       end else begin
           last_skip_weight_rls <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       layer_st_d1 <= 1'b0;
   end else begin
       layer_st_d1 <= layer_st;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// registers to calculate local values //
////////////////////////////////////////////////////////////////////////
//: &eperl::flop("-nodeclare  -norst -en \"layer_st\" -d \"reg2dp_byte_per_kernel + 1'b1\" -q byte_per_kernel");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk) begin
       if ((layer_st) == 1'b1) begin
           byte_per_kernel <= reg2dp_byte_per_kernel + 1'b1;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           byte_per_kernel <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign is_int8 = 1'b1;
assign is_fp16 = 1'b0;
//: my $atmk = 8;
//: my $atmkbw = int(log($atmk) / log(2));
//: print qq( assign group_op = {{($atmkbw-2){1'b0}}, reg2dp_weight_kernel[12:${atmkbw}]}; );
//| eperl: generated_beg (DO NOT EDIT BELOW)
 assign group_op = {{(3-2){1'b0}}, reg2dp_weight_kernel[12:3]}; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
assign group_w = group_op + 1'b1;
assign data_bank_w = reg2dp_data_bank + 1'b1;
assign weight_bank_w = reg2dp_weight_bank + 1'b1;
assign weight_bank_end_w = weight_bank_w + data_bank_w;
assign nan_pass_w = ~reg2dp_nan_to_zero | ~is_fp16;
assign is_compressed = 1'b0;
//: &eperl::flop("-nodeclare   -rval \"{12{1'b1}}\"  -en \"layer_st\" -d \"group_w\" -q group");
//: &eperl::flop("-nodeclare   -rval \"{6{1'b1}}\"  -en \"layer_st\" -d \"weight_bank_w\" -q weight_bank");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b1}}\"  -en \"layer_st\" -d \"weight_bank_end_w\" -q weight_bank_end");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"  -en \"layer_st\" -d \"nan_pass_w\" -q nan_pass");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       group <= {12{1'b1}};
   end else begin
       if ((layer_st) == 1'b1) begin
           group <= group_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           group <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       weight_bank <= {6{1'b1}};
   end else begin
       if ((layer_st) == 1'b1) begin
           weight_bank <= weight_bank_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           weight_bank <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       weight_bank_end <= {7{1'b1}};
   end else begin
       if ((layer_st) == 1'b1) begin
           weight_bank_end <= weight_bank_end_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           weight_bank_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       nan_pass <= 1'b1;
   end else begin
       if ((layer_st) == 1'b1) begin
           nan_pass <= nan_pass_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           nan_pass <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// generate address for weight data //
////////////////////////////////////////////////////////////////////////
localparam SRC_ID_WT = 2'b00;
localparam SRC_ID_WMB = 2'b01;
localparam SRC_ID_WGS = 2'b10;
/////////////////// stage 1 ///////////////////
assign wt_req_reg_en_d0 = wt_req_reg_en;
assign {mon_wt_req_burst_cnt_dec, wt_req_burst_cnt_dec} = wt_req_burst_cnt_d1 - {{25{1'b0}}, wt_req_size_d1};
//assign wt_req_burst_cnt_w = layer_st ? {reg2dp_weight_bytes, 2'b0} : wt_req_burst_cnt_dec;
//: my $atmm = 8;
//: my $k = int( log(${atmm}) / log(2) );
//: print qq( assign wt_req_burst_cnt_w = layer_st ? reg2dp_weight_bytes[31:${k}] : wt_req_burst_cnt_dec; );
//| eperl: generated_beg (DO NOT EDIT BELOW)
 assign wt_req_burst_cnt_w = layer_st ? reg2dp_weight_bytes[31:3] : wt_req_burst_cnt_dec; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
assign wt_req_size_addr_limit = layer_st ? (4'h8 - reg2dp_weight_addr_low[2:0]) : 4'h8;
assign wt_req_size_w = ( {{25{1'b0}}, wt_req_size_addr_limit} > wt_req_burst_cnt_w) ? wt_req_burst_cnt_w[3:0] : wt_req_size_addr_limit;
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"wt_req_reg_en_d0\" -d \"wt_req_size_w\" -q wt_req_size_d1");
//: &eperl::flop("-nodeclare   -rval \"{29{1'b0}}\"  -en \"wt_req_reg_en_d0\" -d \"wt_req_burst_cnt_w\" -q wt_req_burst_cnt_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"is_nxt_running\" -q wt_req_stage_vld_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_size_d1 <= {4{1'b0}};
   end else begin
       if ((wt_req_reg_en_d0) == 1'b1) begin
           wt_req_size_d1 <= wt_req_size_w;
       // VCS coverage off
       end else if ((wt_req_reg_en_d0) == 1'b0) begin
       end else begin
           wt_req_size_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_burst_cnt_d1 <= {29{1'b0}};
   end else begin
       if ((wt_req_reg_en_d0) == 1'b1) begin
           wt_req_burst_cnt_d1 <= wt_req_burst_cnt_w;
       // VCS coverage off
       end else if ((wt_req_reg_en_d0) == 1'b0) begin
       end else begin
           wt_req_burst_cnt_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_stage_vld_d1 <= 1'b0;
   end else begin
       wt_req_stage_vld_d1 <= is_nxt_running;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
/////////////////// stage 2 ///////////////////
assign wt_req_reg_en_d1 = wt_req_reg_en;
assign wt_req_last_w = wt_req_stage_vld_d1 && (wt_req_burst_cnt_d1 == {{25{1'b0}}, wt_req_size_d1});
//: my $atmm = 8;
//: my $atmbw = int(log(${atmm})/log(2));
//: print qq(
//: assign wt_req_addr_inc = wt_req_addr_d2[64-${atmbw}-1:3] + 1'b1;
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign wt_req_addr_inc = wt_req_addr_d2[64-3-1:3] + 1'b1;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign wt_req_addr_w = (~wt_req_stage_vld_d2) ? {reg2dp_weight_addr_high,reg2dp_weight_addr_low} : {wt_req_addr_inc, 3'b0};
assign wt_req_size_out_w = wt_req_size_d1[2:0] - 3'b1;
assign wt_req_done_w = layer_st ? 1'b0 : wt_req_last_d2 ? 1'b1 : wt_req_done_d2;
//: &eperl::flop("-nodeclare   -rval \"0\"          -en \"wt_req_reg_en_d1\" -d \"wt_req_addr_w\" -q wt_req_addr_d2");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"wt_req_reg_en_d1\" -d \"wt_req_size_d1\" -q wt_req_size_d2");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"wt_req_reg_en_d1\" -d \"wt_req_size_out_w\" -q wt_req_size_out_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"       -en \"wt_req_reg_en_d1\" -d \"wt_req_last_w\" -q wt_req_last_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"       -en \"wt_req_reg_en_d1\" -d \"wt_req_done_w\" -q wt_req_done_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wt_req_stage_vld_d1 & is_nxt_running\" -q wt_req_stage_vld_d2");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_addr_d2 <= 'b0;
   end else begin
       if ((wt_req_reg_en_d1) == 1'b1) begin
           wt_req_addr_d2 <= wt_req_addr_w;
       // VCS coverage off
       end else if ((wt_req_reg_en_d1) == 1'b0) begin
       end else begin
           wt_req_addr_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_size_d2 <= {4{1'b0}};
   end else begin
       if ((wt_req_reg_en_d1) == 1'b1) begin
           wt_req_size_d2 <= wt_req_size_d1;
       // VCS coverage off
       end else if ((wt_req_reg_en_d1) == 1'b0) begin
       end else begin
           wt_req_size_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_size_out_d2 <= {3{1'b0}};
   end else begin
       if ((wt_req_reg_en_d1) == 1'b1) begin
           wt_req_size_out_d2 <= wt_req_size_out_w;
       // VCS coverage off
       end else if ((wt_req_reg_en_d1) == 1'b0) begin
       end else begin
           wt_req_size_out_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_last_d2 <= 1'b0;
   end else begin
       if ((wt_req_reg_en_d1) == 1'b1) begin
           wt_req_last_d2 <= wt_req_last_w;
       // VCS coverage off
       end else if ((wt_req_reg_en_d1) == 1'b0) begin
       end else begin
           wt_req_last_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_done_d2 <= 1'b1;
   end else begin
       if ((wt_req_reg_en_d1) == 1'b1) begin
           wt_req_done_d2 <= wt_req_done_w;
       // VCS coverage off
       end else if ((wt_req_reg_en_d1) == 1'b0) begin
       end else begin
           wt_req_done_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_stage_vld_d2 <= 1'b0;
   end else begin
       wt_req_stage_vld_d2 <= wt_req_stage_vld_d1 & is_nxt_running;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
/////////////////// stage 3 ///////////////////
assign wt_req_reg_en_d2 = wt_req_reg_en;
assign wt_req_vld_w = is_nxt_running & wt_req_stage_vld_d2;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wt_req_vld_w\" -q wt_req_vld_d3");
//: &eperl::flop("-nodeclare   -rval \"0\"  -en \"wt_req_reg_en_d2\" -d \"wt_req_addr_d2\" -q wt_req_addr_d3");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"wt_req_reg_en_d2\" -d \"wt_req_size_d2\" -q wt_req_size_d3");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"wt_req_reg_en_d2\" -d \"wt_req_size_out_d2\" -q wt_req_size_out_d3");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"  -en \"wt_req_reg_en_d2\" -d \"(is_running & wt_req_done_d2)\" -q wt_req_done_d3");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_vld_d3 <= 1'b0;
   end else begin
       wt_req_vld_d3 <= wt_req_vld_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_addr_d3 <= 'b0;
   end else begin
       if ((wt_req_reg_en_d2) == 1'b1) begin
           wt_req_addr_d3 <= wt_req_addr_d2;
       // VCS coverage off
       end else if ((wt_req_reg_en_d2) == 1'b0) begin
       end else begin
           wt_req_addr_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_size_d3 <= {4{1'b0}};
   end else begin
       if ((wt_req_reg_en_d2) == 1'b1) begin
           wt_req_size_d3 <= wt_req_size_d2;
       // VCS coverage off
       end else if ((wt_req_reg_en_d2) == 1'b0) begin
       end else begin
           wt_req_size_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_size_out_d3 <= {3{1'b0}};
   end else begin
       if ((wt_req_reg_en_d2) == 1'b1) begin
           wt_req_size_out_d3 <= wt_req_size_out_d2;
       // VCS coverage off
       end else if ((wt_req_reg_en_d2) == 1'b0) begin
       end else begin
           wt_req_size_out_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_done_d3 <= 1'b1;
   end else begin
       if ((wt_req_reg_en_d2) == 1'b1) begin
           wt_req_done_d3 <= (is_running & wt_req_done_d2);
       // VCS coverage off
       end else if ((wt_req_reg_en_d2) == 1'b0) begin
       end else begin
           wt_req_done_d3 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign wt_req_src_d3 = SRC_ID_WT;
/////////////////// overflow control logic ///////////////////
assign {mon_wt_req_sum, wt_req_sum} = wt_data_onfly + wt_data_stored + wt_data_avl;
//: my $atmm8 = ((8*8)/8);
//: my $Cbuf_bank_size = 8 * 512;
//: my $cdma_addr_align = 8;
//: my $Cbuf_bank_fetch_bits = int( log($Cbuf_bank_size/$cdma_addr_align)/log(2) );
//: print qq(
//: assign wt_req_overflow = is_running && (wt_req_sum > ({weight_bank, ${Cbuf_bank_fetch_bits}'b0} + $atmm8));
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign wt_req_overflow = is_running && (wt_req_sum > ({weight_bank, 9'b0} + 8));

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign wt_req_overflow_d3 = wt_req_overflow;
/////////////////// pipeline control logic ///////////////////
assign wt_req_reg_en = layer_st | (is_running & (~wt_req_vld_d3 | wt_req_rdy));
assign arb_sp_out_rdy = dma_rd_req_rdy & dma_req_fifo_ready;
assign arb_sp_out_vld = wt_req_vld_d3 & ~wt_req_overflow_d3 & ~wt_req_done_d3;
//assign wt_req_rdy = arb_sp_out_rdy;
assign wt_req_rdy = arb_sp_out_rdy & arb_sp_out_vld;
assign dma_req_src = wt_req_src_d3;
assign dma_req_size = wt_req_size_d3;
assign dma_req_size_out = wt_req_size_out_d3;
assign dma_req_addr = wt_req_addr_d3;
////////////////////////////////////////////////////////////////////////
// CDMA WT read request interface //
////////////////////////////////////////////////////////////////////////
//==============
// DMA Interface
//==============
// rd Channel: Request
NV_NVDLA_DMAIF_rdreq NV_NVDLA_PDP_RDMA_rdreq(
  .nvdla_core_clk (nvdla_core_clk )
 ,.nvdla_core_rstn (nvdla_core_rstn )
 ,.reg2dp_src_ram_type (reg2dp_weight_ram_type)
 ,.mcif_rd_req_pd (cdma_wt2mcif_rd_req_pd )
 ,.mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid )
 ,.mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready )
 ,.dmaif_rd_req_pd (dma_rd_req_pd )
 ,.dmaif_rd_req_vld (dma_rd_req_vld )
 ,.dmaif_rd_req_rdy (dma_rd_req_rdy )
);
wire dmaif_rd_rsp_prdy;
wire dmaif_rd_rsp_pvld;
wire [( 64 + (64/8/8) )-1:0] dmaif_rd_rsp_pd;
// rd Channel: Response
NV_NVDLA_DMAIF_rdrsp NV_NVDLA_PDP_RDMA_rdrsp(
   .nvdla_core_clk (nvdla_core_clk )
  ,.nvdla_core_rstn (nvdla_core_rstn )
  ,.mcif_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd )
  ,.mcif_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid )
  ,.mcif_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready )
//,.dmaif_rd_rsp_pd (dma_rd_rsp_pd )
//,.dmaif_rd_rsp_pvld (dma_rd_rsp_vld )
//,.dmaif_rd_rsp_prdy (dma_rd_rsp_rdy )
  ,.dmaif_rd_rsp_pd (dmaif_rd_rsp_pd )
  ,.dmaif_rd_rsp_pvld (dmaif_rd_rsp_pvld )
  ,.dmaif_rd_rsp_prdy (dmaif_rd_rsp_prdy )
);
///////////////////////////////////////////
//DorisLei: adding a 8*atmm fifo here for data buffering.
//use case: Cbuf has empty entries, but empty entry number < 8*atmm
//continue reading 8*atmm data from memory and then Cbuf can be fully written
//: my $dmaif = 64;
//: my $atmm8 = 8 * (8 * 8);
//: my $fifo_depth = int( $atmm8/$dmaif );
//: my $fifo_width = ( 64 + (64/8/8) );
//: print " NV_NVDLA_CDMA_WT_8ATMM_fifo_${fifo_width}x${fifo_depth} u_8atmm_fifo(   \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 NV_NVDLA_CDMA_WT_8ATMM_fifo_65x8 u_8atmm_fifo(   

//| eperl: generated_end (DO NOT EDIT ABOVE)
     .nvdla_core_clk (nvdla_core_clk )
    ,.nvdla_core_rstn (nvdla_core_rstn )
    ,.lat_wr_prdy (dmaif_rd_rsp_prdy)
    ,.lat_wr_pvld (dmaif_rd_rsp_pvld)
    ,.lat_wr_pd (dmaif_rd_rsp_pd)
    ,.lat_rd_prdy (dma_rd_rsp_rdy )
    ,.lat_rd_pvld (dma_rd_rsp_vld )
    ,.lat_rd_pd (dma_rd_rsp_pd )
//,.atmm8_wr_prdy (dmaif_rd_rsp_prdy)
//,.atmm8_wr_pvld (dmaif_rd_rsp_pvld)
//,.atmm8_wr_pd (dmaif_rd_rsp_pd)
//,.atmm8_rd_prdy (dma_rd_rsp_rdy )
//,.atmm8_rd_pvld (dma_rd_rsp_vld )
//,.atmm8_rd_pd (dma_rd_rsp_pd )
    ,.pwrbus_ram_pd (32'd0)
    );
///////////////////////////////////////////
assign dma_rd_req_pd[32 -1:0] = dma_rd_req_addr[32 -1:0];
assign dma_rd_req_pd[32 +14:32] = dma_rd_req_size[14:0];
assign dma_rd_req_vld = arb_sp_out_vld & dma_req_fifo_ready;
//: my $atmm = 8;
//: my $atmbw = int(log(${atmm})/log(2));
//: print qq(
//: assign dma_rd_req_addr = {dma_req_addr, ${atmbw}'b0};
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dma_rd_req_addr = {dma_req_addr, 3'b0};

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dma_rd_req_size = {{12{1'b0}}, dma_req_size_out};
assign dma_rd_req_type = reg2dp_weight_ram_type;
// assign dma_rd_rsp_rdy = 1'b1;
///////////////////////////////////
//DorisLei redefine dma_rd_rsp_rdy to block reading process when cbuf is full
///////////////////////////////////
//: my $atmc=8;
//: my $dmaif=64 / 8;
//: if($dmaif < $atmc) {
//: my $k = $atmc/$dmaif - 1;
//: print qq(
//: reg [3:0] dmaif_within_atmc_cnt;
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn)
//: dmaif_within_atmc_cnt <= 4'd0;
//: else if(wt_cbuf_wr_vld_w) begin
//: if(dmaif_within_atmc_cnt == ${k})
//: dmaif_within_atmc_cnt <= 4'd0;
//: else
//: dmaif_within_atmc_cnt <= dmaif_within_atmc_cnt + 1'b1;
//: end
//: end
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [16:0] wt_wr_dmatx_cnt;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wt_wr_dmatx_cnt <= 17'd0;
    end else if(wt_cbuf_wr_vld_w & (!sc_wt_updt)) begin
//: my $atmc=8;
//: my $dmaif=64 / 8;
//: if($dmaif == $atmc) {
//: print qq(
//: wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + 1'b1;
//: );
//: } elsif($dmaif < $atmc) {
//: my $k = $atmc/$dmaif - 1;
//: print qq(
//: if(dmaif_within_atmc_cnt == ${k}) begin
//: wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + 1'b1;
//: end
//: );
//: } elsif($dmaif > $atmc) {
//: my $m = $dmaif/$atmc;
//: print qq(
//: wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + ${m};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + 1'b1;

//| eperl: generated_end (DO NOT EDIT ABOVE)
    end else if(wt_cbuf_wr_vld_w & sc_wt_updt) begin
//: my $atmc=8;
//: my $dmaif=64 / 8;
//: if($dmaif == $atmc) {
//: print qq(
//: wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + 1'b1 - sc_wt_entries;
//: );
//: } elsif($dmaif < $atmc) {
//: my $k = $atmc/$dmaif - 1;
//: print qq(
//: if(dmaif_within_atmc_cnt == ${k}) begin
//: wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + 1'b1 - sc_wt_entries;
//: end else begin
//: wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt - sc_wt_entries;
//: end
//: );
//: } elsif($dmaif > $atmc) {
//: my $m = $dmaif/$atmc;
//: print qq(
//: wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + ${m} - sc_wt_entries;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + 1'b1 - sc_wt_entries;

//| eperl: generated_end (DO NOT EDIT ABOVE)
    end else if(!wt_cbuf_wr_vld_w & sc_wt_updt) begin
        wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt - sc_wt_entries;
//end else if(wt_cbuf_wr_vld_w & sc_wt_updt) begin
// wt_wr_dmatx_cnt <= wt_wr_dmatx_cnt + 1'b1 - sc_wt_entries;
    end
end
//: my $bank_depth = int( log(512)/log(2) );
//: print qq(
//: assign dma_rd_rsp_rdy = wt_wr_dmatx_cnt < {weight_bank, ${bank_depth}'b0};
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dma_rd_rsp_rdy = wt_wr_dmatx_cnt < {weight_bank, 9'b0};

//| eperl: generated_end (DO NOT EDIT ABOVE)
NV_NVDLA_CDMA_WT_fifo u_fifo (
   .clk (nvdla_core_clk) //|< i
  ,.reset_ (nvdla_core_rstn) //|< i
  ,.wr_ready (dma_req_fifo_ready) //|> w
  ,.wr_req (dma_req_fifo_req) //|< r
  ,.wr_data (dma_req_fifo_data[5:0]) //|< r
  ,.rd_ready (dma_rsp_fifo_ready) //|< r
  ,.rd_req (dma_rsp_fifo_req) //|> w *
  ,.rd_data (dma_rsp_fifo_data[5:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  );
assign dma_req_fifo_req = arb_sp_out_vld & dma_rd_req_rdy;
assign dma_req_fifo_data = {dma_req_src, dma_req_size};
////////////////////////////////////////////////////////////////////////
// For verification/debug //
////////////////////////////////////////////////////////////////////////
assign dbg_src_rd_ptr_en = (cdma_wt2mcif_rd_req_valid & cdma_wt2mcif_rd_req_ready);
assign dbg_src_rd_ptr_w = ~layer_st & (dbg_src_rd_ptr ^ dbg_src_rd_ptr_en);
assign dbg_src_wr_ptr_en = (dma_rd_req_vld & dma_req_fifo_ready & dma_rd_req_rdy);
assign dbg_src_wr_ptr_w = ~layer_st & (dbg_src_wr_ptr ^ dbg_src_wr_ptr_en);
assign dbg_dma_req_src = dbg_src_rd_ptr ? dbg_dma_req_src_b1 : dbg_dma_req_src_b0;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dbg_src_rd_ptr_w\" -q dbg_src_rd_ptr");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dbg_src_wr_ptr_w\" -q dbg_src_wr_ptr");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"dbg_src_wr_ptr_en & ~dbg_src_wr_ptr\" -d \"dma_req_src\" -q dbg_dma_req_src_b0");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"dbg_src_wr_ptr_en & dbg_src_wr_ptr\" -d \"dma_req_src\" -q dbg_dma_req_src_b1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_src_rd_ptr <= 1'b0;
   end else begin
       dbg_src_rd_ptr <= dbg_src_rd_ptr_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_src_wr_ptr <= 1'b0;
   end else begin
       dbg_src_wr_ptr <= dbg_src_wr_ptr_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_dma_req_src_b0 <= {2{1'b0}};
   end else begin
       if ((dbg_src_wr_ptr_en & ~dbg_src_wr_ptr) == 1'b1) begin
           dbg_dma_req_src_b0 <= dma_req_src;
       // VCS coverage off
       end else if ((dbg_src_wr_ptr_en & ~dbg_src_wr_ptr) == 1'b0) begin
       end else begin
           dbg_dma_req_src_b0 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_dma_req_src_b1 <= {2{1'b0}};
   end else begin
       if ((dbg_src_wr_ptr_en & dbg_src_wr_ptr) == 1'b1) begin
           dbg_dma_req_src_b1 <= dma_req_src;
       // VCS coverage off
       end else if ((dbg_src_wr_ptr_en & dbg_src_wr_ptr) == 1'b0) begin
       end else begin
           dbg_dma_req_src_b1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// CDMA read response connection //
////////////////////////////////////////////////////////////////////////
assign dma_rd_rsp_data[64 -1:0] = dma_rd_rsp_pd[64 -1:0];
assign dma_rd_rsp_mask[( 64 + (64/8/8) )-64 -1:0] = dma_rd_rsp_pd[( 64 + (64/8/8) )-1:64];
assign {dma_rsp_src, dma_rsp_size} = dma_rsp_fifo_data;
assign {mon_dma_rsp_size_cnt_inc, dma_rsp_size_cnt_inc} = dma_rsp_size_cnt
//: my $mask = (64/8/8);
//: foreach my $i(0..$mask-1) {
//: print qq(
//: + dma_rd_rsp_mask[$i]
//: );
//: }
//: print qq( ; );
//| eperl: generated_beg (DO NOT EDIT BELOW)

+ dma_rd_rsp_mask[0]
 ; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dma_rsp_size_cnt_w = (dma_rsp_size_cnt_inc == dma_rsp_size) ? 4'b0 : dma_rsp_size_cnt_inc;
assign dma_rsp_fifo_ready = (dma_rd_rsp_vld & dma_rd_rsp_rdy & (dma_rsp_size_cnt_inc == dma_rsp_size));
assign wt_rsp_valid = (dma_rd_rsp_vld & dma_rd_rsp_rdy & (dma_rsp_src == SRC_ID_WT));
assign {
//: my $mask = (64/8/8);
//: if($mask > 1) {
//: foreach my $i(0..$mask-2) {
//: my $j = $mask -$i -1;
//: print qq( dma_rsp_data_p${j} , );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

//| eperl: generated_end (DO NOT EDIT ABOVE)
 dma_rsp_data_p0} = dma_rd_rsp_data;
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"dma_rd_rsp_vld & dma_rd_rsp_rdy\" -d \"dma_rsp_size_cnt_w\" -q dma_rsp_size_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dma_rsp_size_cnt <= {4{1'b0}};
   end else begin
       if ((dma_rd_rsp_vld & dma_rd_rsp_rdy) == 1'b1) begin
           dma_rsp_size_cnt <= dma_rsp_size_cnt_w;
       // VCS coverage off
       end else if ((dma_rd_rsp_vld & dma_rd_rsp_rdy) == 1'b0) begin
       end else begin
           dma_rsp_size_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// WT read data //
////////////////////////////////////////////////////////////////////////
assign wt_local_data_cnt = wt_local_data_vld
//: my $mask = (64/8/8);
//: foreach my $i(0..$mask-1) {
//: print qq(
//: + dma_rd_rsp_mask[$i]
//: );
//: }
//: print qq( ; );
//: my $mask = (64/8/8);
//: if($mask == 1) {
//: print qq(
//: assign wt_local_data_vld_w = 1'b0;
//: assign wt_local_data_reg_en = 1'b0;
//: assign wt_cbuf_wr_vld_w = wt_rsp_valid;
//: assign wt_local_data_w = 0;// bw
//: assign wt_cbuf_wr_data_ori_w = dma_rsp_data_p0;
//: );
//: } elsif($mask == 2) {
//: print qq(
//: assign wt_local_data_vld_w = wt_local_data_cnt[0];
//: assign wt_local_data_reg_en = wt_rsp_valid & wt_local_data_cnt[0];
//: assign wt_cbuf_wr_vld_w = wt_rsp_valid & wt_local_data_cnt[1];
//: assign wt_local_data_w = dma_rd_rsp_mask[1] ? dma_rsp_data_p1 : dma_rsp_data_p0;
//: assign wt_cbuf_wr_data_ori_w = wt_local_data_vld ? {dma_rsp_data_p0, wt_local_data} : dma_rd_rsp_data;
//: );
//: } elsif($mask == 4) {
//: print qq(
//: assign wt_local_data_vld_w = |wt_local_data_cnt[1:0];
//: assign wt_local_data_reg_en = wt_rsp_valid & wt_local_data_vld_w;
//: assign wt_cbuf_wr_vld_w = wt_rsp_valid & wt_local_data_cnt[2];
//: assign wt_local_data_w = dma_rd_rsp_mask[3] ? dma_rd_rsp_data ://
//: dma_rd_rsp_mask[2] ? {dma_rsp_data_p2, dma_rsp_data_p1, dma_rsp_data_p0}:
//: dma_rd_rsp_mask[1] ? {dma_rsp_data_p1, dma_rsp_data_p0} : dma_rsp_data_p0;
//: assign wt_cbuf_wr_data_ori_w = wt_local_data_vld ? {dma_rsp_data_p0, wt_local_data} : dma_rd_rsp_data;//
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

+ dma_rd_rsp_mask[0]
 ; 
assign wt_local_data_vld_w = 1'b0;
assign wt_local_data_reg_en = 1'b0;
assign wt_cbuf_wr_vld_w = wt_rsp_valid;
assign wt_local_data_w = 0;// bw
assign wt_cbuf_wr_data_ori_w = dma_rsp_data_p0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign wt_cbuf_wr_idx_inc = wt_cbuf_wr_idx + 1'b1;
assign wt_cbuf_wr_idx_set = (layer_st & ~(|wt_cbuf_wr_idx));
//: my $dmaif=64;
//: my $atmc=8*8;
//: my $k;
//: if($dmaif < $atmc) {
//: $k = int(log(int($atmc/$dmaif))/log(2));
//: } else {
//: $k = 0;
//: }
//:
//: my $bank_depth_bits = int( log(512)/log(2) + ${k});
//: print qq(
//: assign wt_cbuf_wr_idx_wrap = (wt_cbuf_wr_idx_inc == {2'd0, weight_bank_end, ${bank_depth_bits}'b0});
//: assign wt_cbuf_wr_idx_w = (clear_all | wt_cbuf_wr_idx_set | wt_cbuf_wr_idx_wrap) ? {2'd0, data_bank_w, ${bank_depth_bits}'b0} : wt_cbuf_wr_idx_inc[(1 + 16 ) -1:0];
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign wt_cbuf_wr_idx_wrap = (wt_cbuf_wr_idx_inc == {2'd0, weight_bank_end, 9'b0});
assign wt_cbuf_wr_idx_w = (clear_all | wt_cbuf_wr_idx_set | wt_cbuf_wr_idx_wrap) ? {2'd0, data_bank_w, 9'b0} : wt_cbuf_wr_idx_inc[(1 + 16 ) -1:0];

//| eperl: generated_end (DO NOT EDIT ABOVE)
//assign wt_cbuf_wr_data_w = nan_pass ? wt_cbuf_wr_data_ori_w : (wt_cbuf_wr_data_ori_w & wt_nan_mask);
assign wt_cbuf_wr_data_w = wt_cbuf_wr_data_ori_w;
//: &eperl::flop("-nodeclare  -norst -en \"wt_local_data_reg_en\" -d \"wt_local_data_w\" -q wt_local_data");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wt_rsp_valid\" -d \"wt_local_data_vld_w\" -q wt_local_data_vld");
//: &eperl::flop("-nodeclare   -rval \"{17{1'b0}}\"  -en \"wt_cbuf_wr_idx_set | clear_all | wt_cbuf_wr_vld_w\" -d \"wt_cbuf_wr_idx_w\" -q wt_cbuf_wr_idx");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk) begin
       if ((wt_local_data_reg_en) == 1'b1) begin
           wt_local_data <= wt_local_data_w;
       // VCS coverage off
       end else if ((wt_local_data_reg_en) == 1'b0) begin
       end else begin
           wt_local_data <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_local_data_vld <= 1'b0;
   end else begin
       if ((wt_rsp_valid) == 1'b1) begin
           wt_local_data_vld <= wt_local_data_vld_w;
       // VCS coverage off
       end else if ((wt_rsp_valid) == 1'b0) begin
       end else begin
           wt_local_data_vld <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_cbuf_wr_idx <= {17{1'b0}};
   end else begin
       if ((wt_cbuf_wr_idx_set | clear_all | wt_cbuf_wr_vld_w) == 1'b1) begin
           wt_cbuf_wr_idx <= wt_cbuf_wr_idx_w;
       // VCS coverage off
       end else if ((wt_cbuf_wr_idx_set | clear_all | wt_cbuf_wr_vld_w) == 1'b0) begin
       end else begin
           wt_cbuf_wr_idx <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// weight buffer flushing logic //
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// Non-SLCG clock domain //
////////////////////////////////////////////////////////////////////////
assign {mon_wt_cbuf_flush_idx_w, wt_cbuf_flush_idx_w} = wt_cbuf_flush_idx + 1'b1;
//: my $bank_entry = 32 * 512;
//: my $bank_entry_bw = int( log( $bank_entry)/log(2) );
//: my $dmaif=64;
//: my $atmc=8*8;
//: my $k;
//: if($dmaif < $atmc) {
//: $k = int(log(int($atmc/$dmaif))/log(2));
//: } else {
//: $k = 0;
//: }
//: print qq(
//: assign wt_cbuf_flush_vld_w = ~wt_cbuf_flush_idx[${bank_entry_bw}+$k-1];//max value = half bank entry * 2^$k
//: assign dp2reg_wt_flush_done = wt_cbuf_flush_idx[${bank_entry_bw}+$k-1];
//: );
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{18{1'b0}}\"  -en \"wt_cbuf_flush_vld_w\" -d \"wt_cbuf_flush_idx_w\" -q wt_cbuf_flush_idx");
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign wt_cbuf_flush_vld_w = ~wt_cbuf_flush_idx[14+0-1];//max value = half bank entry * 2^0
assign dp2reg_wt_flush_done = wt_cbuf_flush_idx[14+0-1];
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_cbuf_flush_idx <= {18{1'b0}};
   end else begin
       if ((wt_cbuf_flush_vld_w) == 1'b1) begin
           wt_cbuf_flush_idx <= wt_cbuf_flush_idx_w;
       // VCS coverage off
       end else if ((wt_cbuf_flush_vld_w) == 1'b0) begin
       end else begin
           wt_cbuf_flush_idx <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// WT and WMB write to convolution buffer //
////////////////////////////////////////////////////////////////////////
assign cdma2buf_wt_wr_en_w = wt_cbuf_wr_vld_w | wt_cbuf_flush_vld_w;
//: my $dmaif=64;
//: my $atmc=8*8;
//: my $half_bank_entry_num = 32 * 512 / 2;
//: if($dmaif < $atmc) {
//: my $k = int(log(int($atmc/$dmaif))/log(2));
//: print qq(
//: assign cdma2buf_wt_wr_addr_w = wt_cbuf_wr_vld_w ? wt_cbuf_wr_idx[(1 + 16 ) -1:${k}] :
//: ${half_bank_entry_num} + wt_cbuf_flush_idx[16:${k}];
//: assign cdma2buf_wt_wr_sel_w = wt_cbuf_wr_vld_w ? wt_cbuf_wr_idx[${k}-1:0] :
//: wt_cbuf_flush_idx[${k}-1:0];
//: assign cdma2buf_wt_wr_data_w = wt_cbuf_wr_vld_w ? wt_cbuf_wr_data_w :
//: 0;
//: );
//:
//: my $dmanum = int($atmc/$dmaif);
//: foreach my $s (0..${dmanum}-1) {
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk -rval \"1'b0\"  -en \"cdma2buf_wt_wr_en_w\" -d \"cdma2buf_wt_wr_sel_w==${k}'d${s}\" -q cdma2buf_wt_wr_sel[${s}]");
//: }
//: ## &eperl::flop("-nodeclare -clk nvdla_core_ng_clk -rval \"1'b0\"  -en \"cdma2buf_wt_wr_en_w\" -d \"cdma2buf_wt_wr_sel_w\" -q cdma2buf_wt_wr_sel");
//: } elsif($dmaif > $atmc) {
//: } else {
//: print qq(
//: assign cdma2buf_wt_wr_addr_w = wt_cbuf_wr_vld_w ? wt_cbuf_wr_idx : ${half_bank_entry_num} + wt_cbuf_flush_idx[16:0];
//: assign cdma2buf_wt_wr_data_w = wt_cbuf_wr_vld_w ? wt_cbuf_wr_data_w : 0;
//: );
//: }
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk -rval \"1'b0\"   -d \"cdma2buf_wt_wr_en_w\" -q cdma2buf_wt_wr_en");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk -rval \"{17{1'b0}}\"  -en \"cdma2buf_wt_wr_en_w\" -d \"cdma2buf_wt_wr_addr_w\" -q cdma2buf_wt_wr_addr");
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign cdma2buf_wt_wr_addr_w = wt_cbuf_wr_vld_w ? wt_cbuf_wr_idx : 8192 + wt_cbuf_flush_idx[16:0];
assign cdma2buf_wt_wr_data_w = wt_cbuf_wr_vld_w ? wt_cbuf_wr_data_w : 0;
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cdma2buf_wt_wr_en <= 1'b0;
   end else begin
       cdma2buf_wt_wr_en <= cdma2buf_wt_wr_en_w;
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cdma2buf_wt_wr_addr <= {17{1'b0}};
   end else begin
       if ((cdma2buf_wt_wr_en_w) == 1'b1) begin
           cdma2buf_wt_wr_addr <= cdma2buf_wt_wr_addr_w;
       // VCS coverage off
       end else if ((cdma2buf_wt_wr_en_w) == 1'b0) begin
       end else begin
           cdma2buf_wt_wr_addr <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// Non-SLCG clock domain end //
////////////////////////////////////////////////////////////////////////
//: my $dmaif=64;
//: &eperl::flop("-nodeclare   -rval \"{${dmaif}{1'b0}}\"  -en \"cdma2buf_wt_wr_en_w\" -d \"cdma2buf_wt_wr_data_w\" -q cdma2buf_wt_wr_data");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cdma2buf_wt_wr_data <= {64{1'b0}};
   end else begin
       if ((cdma2buf_wt_wr_en_w) == 1'b1) begin
           cdma2buf_wt_wr_data <= cdma2buf_wt_wr_data_w;
       // VCS coverage off
       end else if ((cdma2buf_wt_wr_en_w) == 1'b0) begin
       end else begin
           cdma2buf_wt_wr_data <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dp2reg_nan_weight_num = 32'b0;
assign dp2reg_inf_weight_num = 32'b0;
////////////////////////////////////////////////////////////////////////
// WT data status monitor //
////////////////////////////////////////////////////////////////////////
//================ Non-SLCG clock domain ================//
//sc2cdma_wt_kernels are useless
//retiming
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"1'b0\"   -d \"sc2cdma_wt_updt\" -q sc_wt_updt");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{15{1'b0}}\"  -en \"sc2cdma_wt_updt\" -d \"sc2cdma_wt_entries\" -q sc_wt_entries");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc_wt_updt <= 1'b0;
   end else begin
       sc_wt_updt <= sc2cdma_wt_updt;
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc_wt_entries <= {15{1'b0}};
   end else begin
       if ((sc2cdma_wt_updt) == 1'b1) begin
           sc_wt_entries <= sc2cdma_wt_entries;
       // VCS coverage off
       end else if ((sc2cdma_wt_updt) == 1'b0) begin
       end else begin
           sc_wt_entries <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//cation: the basic unit of data_stored, data_onfly and data_avl is atomic_m bytes, 32 bytes in Xavier
assign wt_data_onfly_add = (wt_req_reg_en_d2 & wt_req_stage_vld_d2 & ~wt_req_done_d2) ? wt_req_size_d2 : 4'b0;
//atom_m num per cbuf write, =dmaif/atom_m
//: my $dmaif = (64 / 8);
//: my $atmc=8;
//: my $atmm = 8;
//: my $atmm_dmaif = int($dmaif / $atmm);
//: my $atmm_atmc = int($atmc / $atmm);
//: print qq(
//: assign wt_data_onfly_sub = wt_cbuf_wr_vld_w ? 3'd${atmm_dmaif} : 3'b0;
//: );
//: if($atmm_atmc == 4) {
//: print qq(
//: assign wt_data_stored_sub = status_update ? {incr_wt_entries_w, 2'd0} : 17'b0;
//: assign wt_data_avl_sub = sc_wt_updt ? {sc_wt_entries, 2'b0} : 17'b0;
//: );
//: } elsif($atmm_atmc == 2) {
//: print qq(
//: assign wt_data_stored_sub = status_update ? {1'b0,incr_wt_entries_w, 1'd0} : 17'b0;
//: assign wt_data_avl_sub = sc_wt_updt ? {1'b0,sc_wt_entries, 1'b0} : 17'b0;
//: );
//: } elsif($atmm_atmc == 1) {
//: print qq(
//: assign wt_data_stored_sub = status_update ? {2'b0,incr_wt_entries_w} : 17'b0;
//: assign wt_data_avl_sub = sc_wt_updt ? {2'b0,sc_wt_entries} : 17'b0;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign wt_data_onfly_sub = wt_cbuf_wr_vld_w ? 3'd1 : 3'b0;

assign wt_data_stored_sub = status_update ? {2'b0,incr_wt_entries_w} : 17'b0;
assign wt_data_avl_sub = sc_wt_updt ? {2'b0,sc_wt_entries} : 17'b0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign {mon_wt_data_onfly_w, wt_data_onfly_w} = wt_data_onfly + wt_data_onfly_add - wt_data_onfly_sub;
//assign wt_data_stored_sub = status_update ? {incr_wt_entries_w, 2'b0} : 14'b0;
assign {mon_wt_data_stored_w, wt_data_stored_w} = wt_data_stored + wt_data_onfly_sub - wt_data_stored_sub;
//assign wt_data_avl_sub = sc_wt_updt ? {sc_wt_entries, 2'b0} : 14'b0;
assign {mon_wt_data_avl_w, wt_data_avl_w} = (clear_all) ? 17'b0 : wt_data_avl + wt_data_stored_sub - wt_data_avl_sub;
assign wt_data_onfly_reg_en = ((wt_req_reg_en_d2 & wt_req_stage_vld_d2) | wt_cbuf_wr_vld_w);
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{14{1'b0}}\"  -en \"wt_data_onfly_reg_en\" -d \"wt_data_onfly_w\" -q wt_data_onfly");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{17{1'b0}}\"  -en \"wt_cbuf_wr_vld_w | status_update\" -d \"wt_data_stored_w\" -q wt_data_stored");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{17{1'b0}}\"  -en \"status_update | sc_wt_updt | clear_all\" -d \"wt_data_avl_w\" -q wt_data_avl");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_data_onfly <= {14{1'b0}};
   end else begin
       if ((wt_data_onfly_reg_en) == 1'b1) begin
           wt_data_onfly <= wt_data_onfly_w;
       // VCS coverage off
       end else if ((wt_data_onfly_reg_en) == 1'b0) begin
       end else begin
           wt_data_onfly <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_data_stored <= {17{1'b0}};
   end else begin
       if ((wt_cbuf_wr_vld_w | status_update) == 1'b1) begin
           wt_data_stored <= wt_data_stored_w;
       // VCS coverage off
       end else if ((wt_cbuf_wr_vld_w | status_update) == 1'b0) begin
       end else begin
           wt_data_stored <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_data_avl <= {17{1'b0}};
   end else begin
       if ((status_update | sc_wt_updt | clear_all) == 1'b1) begin
           wt_data_avl <= wt_data_avl_w;
       // VCS coverage off
       end else if ((status_update | sc_wt_updt | clear_all) == 1'b0) begin
       end else begin
           wt_data_avl <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// status update logic //
////////////////////////////////////////////////////////////////////////
assign status_group_cnt_inc = status_group_cnt + 1'b1;
assign status_last_group = (status_group_cnt_inc == group);
assign status_group_cnt_w = layer_st ? 12'b0 : status_group_cnt_inc;
assign status_done_w = layer_st ? 1'b0 :
                       status_last_group ? 1'b1 : status_done;
//: my $atmk = 8;
//: my $atmkbw = int(log($atmk) / log(2));
//: print qq(
//: assign normal_bpg = {2'd0, byte_per_kernel, ${atmkbw}'b0};
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign normal_bpg = {2'd0, byte_per_kernel, 3'b0};

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign {mon_wt_required_bytes_w,
        wt_required_bytes_w} = layer_st ? 33'b0 :
                               status_last_group ? {1'b0, reg2dp_weight_bytes} :
                               pre_wt_required_bytes + normal_bpg;
assign wt_required_en = ~required_valid & required_valid_w;
assign pre_wt_required_bytes_w = (layer_st) ? 32'b0 : wt_required_bytes;
assign required_valid_w = is_running & ~status_update;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"required_valid_w\" -q required_valid");
//: &eperl::flop("-nodeclare   -rval \"{32{1'b0}}\"  -en \"layer_st | wt_required_en\" -d \"wt_required_bytes_w\" -q wt_required_bytes");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       required_valid <= 1'b0;
   end else begin
       required_valid <= required_valid_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_required_bytes <= {32{1'b0}};
   end else begin
       if ((layer_st | wt_required_en) == 1'b1) begin
           wt_required_bytes <= wt_required_bytes_w;
       // VCS coverage off
       end else if ((layer_st | wt_required_en) == 1'b0) begin
       end else begin
           wt_required_bytes <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////// caution: one in fetched_cnt refers to 64 bytes ////////
assign {mon_wt_fetched_cnt_inc, wt_fetched_cnt_inc} = wt_fetched_cnt + 1'b1;
assign wt_fetched_cnt_w = layer_st ? 26'b0 : wt_fetched_cnt_inc;
//: my $m = int(log(8)/log(2));
//: my $dmaif=64/8; ##byte number per dmaif tx
//: my $k = int(log($dmaif)/log(2));
//: my $atmc=8 * 8;
//: my $dmaifbw=64;
//: if($atmc > $dmaifbw) {
//: my $j = int( log( ${atmc}/${dmaifbw} )/log(2) );
//: print qq(
//: assign wt_satisfied = is_running & ({wt_fetched_cnt, ${k}'b0} >= wt_required_bytes) & ~(|wt_fetched_cnt[${j}-1:0]);
//: );
//: } else {
//: print qq(
//: assign wt_satisfied = is_running & ({3'd0, wt_fetched_cnt, ${k}'b0} >= wt_required_bytes); // wt_fetched_cnt[0]
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign wt_satisfied = is_running & ({3'd0, wt_fetched_cnt, 3'b0} >= wt_required_bytes); // wt_fetched_cnt[0]

//| eperl: generated_end (DO NOT EDIT ABOVE)
//assign wt_satisfied = is_running & ({wt_fetched_cnt, 6'b0} >= wt_required_bytes) & ~wt_fetched_cnt[0];
assign status_update = (~required_valid) ? 1'b0 : wt_satisfied;
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"layer_st | status_update\" -d \"status_group_cnt_w\" -q status_group_cnt");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"layer_st | status_update\" -d \"status_done_w\" -q status_done");
//: &eperl::flop("-nodeclare   -rval \"{32{1'b0}}\"  -en \"layer_st | status_update\" -d \"pre_wt_required_bytes_w\" -q pre_wt_required_bytes");
//: &eperl::flop("-nodeclare   -rval \"{26{1'b0}}\"  -en \"layer_st | wt_cbuf_wr_vld_w\" -d \"wt_fetched_cnt_w\" -q wt_fetched_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       status_group_cnt <= {12{1'b0}};
   end else begin
       if ((layer_st | status_update) == 1'b1) begin
           status_group_cnt <= status_group_cnt_w;
       // VCS coverage off
       end else if ((layer_st | status_update) == 1'b0) begin
       end else begin
           status_group_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       status_done <= 1'b0;
   end else begin
       if ((layer_st | status_update) == 1'b1) begin
           status_done <= status_done_w;
       // VCS coverage off
       end else if ((layer_st | status_update) == 1'b0) begin
       end else begin
           status_done <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pre_wt_required_bytes <= {32{1'b0}};
   end else begin
       if ((layer_st | status_update) == 1'b1) begin
           pre_wt_required_bytes <= pre_wt_required_bytes_w;
       // VCS coverage off
       end else if ((layer_st | status_update) == 1'b0) begin
       end else begin
           pre_wt_required_bytes <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_fetched_cnt <= {26{1'b0}};
   end else begin
       if ((layer_st | wt_cbuf_wr_vld_w) == 1'b1) begin
           wt_fetched_cnt <= wt_fetched_cnt_w;
       // VCS coverage off
       end else if ((layer_st | wt_cbuf_wr_vld_w) == 1'b0) begin
       end else begin
           wt_fetched_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// avaliable kernels monitor //
////////////////////////////////////////////////////////////////////////
// Avaliable kernel size is useless here. Discard the code;
////////////////////////////////////////////////////////////////////////
// CDMA WT communicate to CSC //
////////////////////////////////////////////////////////////////////////
assign pre_wt_fetched_cnt_w = status_last_group ? 26'b0 : wt_fetched_cnt;
assign {mon_incr_wt_cnt, incr_wt_cnt} = wt_fetched_cnt - pre_wt_fetched_cnt;
// dmaif vs atom_c
//: my $dmaif=64/8;
//: my $atmc=8;
//: if($dmaif == $atmc){
//: print qq(
//: assign incr_wt_entries_w = incr_wt_cnt[14:0];
//: );
//: } elsif($dmaif > $atmc) {
//: my $k = int(log($dmaif/$atmc)/log(2));
//: print qq(
//: assign incr_wt_entries_w = {incr_wt_cnt[15-${k}-1:0],{${k}{1'b0}}};
//: );
//: } elsif($dmaif < $atmc) {
//: my $k = int(log($atmc/$dmaif)/log(2));
//: print qq(
//: assign incr_wt_entries_w = {incr_wt_cnt[15+${k}-1:${k}]};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign incr_wt_entries_w = incr_wt_cnt[14:0];

//| eperl: generated_end (DO NOT EDIT ABOVE)
//assign incr_wt_entries_w = incr_wt_cnt[12 :1];
//: my $atmk = 8;
//: my $atmkbw = int(log($atmk)/log(2));
//: print qq(
//: assign incr_wt_kernels_w = (~status_last_group) ? 6'd${atmk} : (reg2dp_weight_kernel[${atmkbw}-1:0] + 1'b1);
//: );
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"status_update\" -q incr_wt_updt");
//: &eperl::flop("-nodeclare   -rval \"{26{1'b0}}\"  -en \"status_update\" -d \"pre_wt_fetched_cnt_w\" -q pre_wt_fetched_cnt");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"status_update\" -d \"incr_wt_entries_w\" -q incr_wt_entries");
//: &eperl::flop("-nodeclare   -rval \"{6{1'b0}}\"  -en \"status_update\" -d \"incr_wt_kernels_w\" -q incr_wt_kernels");
//: my $i;
//: my $j;
//: my $k;
//: my $name;
//: my $wid;
//: my $cbuf_wr_delay = 3;
//: my @list = ("wt_kernels", "wt_entries");
//: my @width = (6, 15);
//:
//: for($i = 0; $i < @list; $i ++) {
//: $name = $list[$i];
//: print "assign incr_${name}_d0 = incr_${name};\n";
//: }
//: print "assign incr_wt_updt_d0 = incr_wt_updt;\n";
//: print "\n\n";
//:
//: for($j = 1; $j <= $cbuf_wr_delay; $j ++) {
//: $k = $j - 1;
//: for($i = 0; $i < @list; $i ++) {
//: $name = $list[$i];
//: $wid = $width[$i];
//: &eperl::flop("-wid ${wid}   -rval \"'b0\"  -en \"incr_wt_updt_d${k}\" -d \"incr_${name}_d${k}\" -q incr_${name}_d${j}");
//: }
//: &eperl::flop("-wid 1   -rval \"1'b0\"   -d \"incr_wt_updt_d${k}\" -q incr_wt_updt_d${j}");
//: }
//: print "\n\n";
//:
//: $j = $cbuf_wr_delay;
//: print "assign cdma2sc_wt_kernels[5:0] = incr_wt_kernels_d${j};\n";
//: print "assign cdma2sc_wt_entries = incr_wt_entries_d${j};\n";
//: print "assign cdma2sc_wmb_entries = 12'b0;  \n";
//: print "assign cdma2sc_wt_updt = incr_wt_updt_d${j};\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign incr_wt_kernels_w = (~status_last_group) ? 6'd8 : (reg2dp_weight_kernel[3-1:0] + 1'b1);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_updt <= 1'b0;
   end else begin
       incr_wt_updt <= status_update;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pre_wt_fetched_cnt <= {26{1'b0}};
   end else begin
       if ((status_update) == 1'b1) begin
           pre_wt_fetched_cnt <= pre_wt_fetched_cnt_w;
       // VCS coverage off
       end else if ((status_update) == 1'b0) begin
       end else begin
           pre_wt_fetched_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_entries <= {15{1'b0}};
   end else begin
       if ((status_update) == 1'b1) begin
           incr_wt_entries <= incr_wt_entries_w;
       // VCS coverage off
       end else if ((status_update) == 1'b0) begin
       end else begin
           incr_wt_entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_kernels <= {6{1'b0}};
   end else begin
       if ((status_update) == 1'b1) begin
           incr_wt_kernels <= incr_wt_kernels_w;
       // VCS coverage off
       end else if ((status_update) == 1'b0) begin
       end else begin
           incr_wt_kernels <= 'bx;
       // VCS coverage on
       end
   end
end
assign incr_wt_kernels_d0 = incr_wt_kernels;
assign incr_wt_entries_d0 = incr_wt_entries;
assign incr_wt_updt_d0 = incr_wt_updt;


reg [5:0] incr_wt_kernels_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_kernels_d1 <= 'b0;
   end else begin
       if ((incr_wt_updt_d0) == 1'b1) begin
           incr_wt_kernels_d1 <= incr_wt_kernels_d0;
       // VCS coverage off
       end else if ((incr_wt_updt_d0) == 1'b0) begin
       end else begin
           incr_wt_kernels_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [14:0] incr_wt_entries_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_entries_d1 <= 'b0;
   end else begin
       if ((incr_wt_updt_d0) == 1'b1) begin
           incr_wt_entries_d1 <= incr_wt_entries_d0;
       // VCS coverage off
       end else if ((incr_wt_updt_d0) == 1'b0) begin
       end else begin
           incr_wt_entries_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  incr_wt_updt_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_updt_d1 <= 1'b0;
   end else begin
       incr_wt_updt_d1 <= incr_wt_updt_d0;
   end
end
reg [5:0] incr_wt_kernels_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_kernels_d2 <= 'b0;
   end else begin
       if ((incr_wt_updt_d1) == 1'b1) begin
           incr_wt_kernels_d2 <= incr_wt_kernels_d1;
       // VCS coverage off
       end else if ((incr_wt_updt_d1) == 1'b0) begin
       end else begin
           incr_wt_kernels_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [14:0] incr_wt_entries_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_entries_d2 <= 'b0;
   end else begin
       if ((incr_wt_updt_d1) == 1'b1) begin
           incr_wt_entries_d2 <= incr_wt_entries_d1;
       // VCS coverage off
       end else if ((incr_wt_updt_d1) == 1'b0) begin
       end else begin
           incr_wt_entries_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  incr_wt_updt_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_updt_d2 <= 1'b0;
   end else begin
       incr_wt_updt_d2 <= incr_wt_updt_d1;
   end
end
reg [5:0] incr_wt_kernels_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_kernels_d3 <= 'b0;
   end else begin
       if ((incr_wt_updt_d2) == 1'b1) begin
           incr_wt_kernels_d3 <= incr_wt_kernels_d2;
       // VCS coverage off
       end else if ((incr_wt_updt_d2) == 1'b0) begin
       end else begin
           incr_wt_kernels_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [14:0] incr_wt_entries_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_entries_d3 <= 'b0;
   end else begin
       if ((incr_wt_updt_d2) == 1'b1) begin
           incr_wt_entries_d3 <= incr_wt_entries_d2;
       // VCS coverage off
       end else if ((incr_wt_updt_d2) == 1'b0) begin
       end else begin
           incr_wt_entries_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  incr_wt_updt_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       incr_wt_updt_d3 <= 1'b0;
   end else begin
       incr_wt_updt_d3 <= incr_wt_updt_d2;
   end
end


assign cdma2sc_wt_kernels[5:0] = incr_wt_kernels_d3;
assign cdma2sc_wt_entries = incr_wt_entries_d3;
assign cdma2sc_wmb_entries = 12'b0;  
assign cdma2sc_wt_updt = incr_wt_updt_d3;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign cdma2sc_wt_kernels[13:6] = 8'b0;
`ifndef SYNTHESIS
assign dbg_wt_kernel_bytes_w[31:0] = layer_st ? 32'b0 : wt_required_bytes_w - wt_required_bytes;
//assign dbg_full_weight = (reg2dp_weight_bytes <= {weight_bank, 8'h0});
assign dbg_full_weight = (reg2dp_weight_bytes <= {weight_bank, 9'h0});
//: &eperl::flop("-nodeclare   -rval \"{32{1'b0}}\"  -en \"layer_st |  wt_required_en\" -d \"dbg_wt_kernel_bytes_w\" -q dbg_wt_kernel_bytes");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_wt_kernel_bytes <= {32{1'b0}};
   end else begin
       if ((layer_st |  wt_required_en) == 1'b1) begin
           dbg_wt_kernel_bytes <= dbg_wt_kernel_bytes_w;
       // VCS coverage off
       end else if ((layer_st |  wt_required_en) == 1'b0) begin
       end else begin
           dbg_wt_kernel_bytes <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
////////////////////////////////////////////////////////////////////////
// performance counting register //
////////////////////////////////////////////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wt_rd_stall_inc <= 1'b0;
    end else begin
        wt_rd_stall_inc <= dma_rd_req_vld & ~dma_rd_req_rdy & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wt_rd_stall_clr <= 1'b0;
    end else begin
        wt_rd_stall_clr <= status2dma_fsm_switch & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wt_rd_stall_cen <= 1'b0;
    end else begin
        wt_rd_stall_cen <= reg2dp_op_en & reg2dp_dma_en;
    end
end
assign dp2reg_wt_rd_stall_dec = 1'b0;
// stl adv logic
always @(*) begin
    stl_adv = wt_rd_stall_inc ^ dp2reg_wt_rd_stall_dec;
end
// stl cnt logic
always @(*) begin
// VCS sop_coverage_off start
    stl_cnt_ext[33:0] = {1'b0, 1'b0, stl_cnt_cur};
    stl_cnt_inc[33:0] = stl_cnt_cur + 1'b1; // spyglass disable W164b
    stl_cnt_dec[33:0] = stl_cnt_cur - 1'b1; // spyglass disable W164b
    stl_cnt_mod[33:0] = (wt_rd_stall_inc && !dp2reg_wt_rd_stall_dec)? stl_cnt_inc : (!wt_rd_stall_inc && dp2reg_wt_rd_stall_dec)? stl_cnt_dec : stl_cnt_ext;
    stl_cnt_new[33:0] = (stl_adv)? stl_cnt_mod[33:0] : stl_cnt_ext[33:0];
    stl_cnt_nxt[33:0] = (wt_rd_stall_clr)? 34'd0 : stl_cnt_new[33:0];
// VCS sop_coverage_off end
end
// stl flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        stl_cnt_cur[31:0] <= 0;
    end else begin
        if (wt_rd_stall_cen) begin
            stl_cnt_cur[31:0] <= stl_cnt_nxt[31:0];
        end
    end
end
// stl output logic
always @(*) begin
    dp2reg_wt_rd_stall[31:0] = stl_cnt_cur[31:0];
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wt_rd_latency_inc <= 1'b0;
    end else begin
        wt_rd_latency_inc <= dma_rd_req_vld & dma_rd_req_rdy & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wt_rd_latency_dec <= 1'b0;
    end else begin
        wt_rd_latency_dec <= dma_rsp_fifo_ready & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wt_rd_latency_clr <= 1'b0;
    end else begin
        wt_rd_latency_clr <= status2dma_fsm_switch;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wt_rd_latency_cen <= 1'b0;
    end else begin
        wt_rd_latency_cen <= reg2dp_op_en & reg2dp_dma_en;
    end
end
//
assign ltc_1_inc = (outs_dp2reg_wt_rd_latency!=511) & wt_rd_latency_inc;
assign ltc_1_dec = (outs_dp2reg_wt_rd_latency!=511) & wt_rd_latency_dec;
// ltc_1 adv logic
always @(*) begin
    ltc_1_adv = ltc_1_inc ^ ltc_1_dec;
end
// ltc_1 cnt logic
always @(*) begin
// VCS sop_coverage_off start
    ltc_1_cnt_ext[10:0] = {1'b0, 1'b0, ltc_1_cnt_cur};
    ltc_1_cnt_inc[10:0] = ltc_1_cnt_cur + 1'b1; // spyglass disable W164b
    ltc_1_cnt_dec[10:0] = ltc_1_cnt_cur - 1'b1; // spyglass disable W164b
    ltc_1_cnt_mod[10:0] = (ltc_1_inc && !ltc_1_dec)? ltc_1_cnt_inc : (!ltc_1_inc && ltc_1_dec)? ltc_1_cnt_dec : ltc_1_cnt_ext;
    ltc_1_cnt_new[10:0] = (ltc_1_adv)? ltc_1_cnt_mod[10:0] : ltc_1_cnt_ext[10:0];
    ltc_1_cnt_nxt[10:0] = (wt_rd_latency_clr)? 11'd0 : ltc_1_cnt_new[10:0];
// VCS sop_coverage_off end
end
// ltc_1 flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        ltc_1_cnt_cur[8:0] <= 0;
    end else begin
        if (wt_rd_latency_cen) begin
            ltc_1_cnt_cur[8:0] <= ltc_1_cnt_nxt[8:0];
        end
    end
end
// ltc_1 output logic
always @(*) begin
    outs_dp2reg_wt_rd_latency[8:0] = ltc_1_cnt_cur[8:0];
end
//////////////////////////////////////////////////////////////
///// functional point                                   /////
//////////////////////////////////////////////////////////////
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    reg funcpoint_cover_off;
    initial begin
        if ( $test$plusargs( "cover_off" ) ) begin
            funcpoint_cover_off = 1'b1;
        end else begin
            funcpoint_cover_off = 1'b0;
        end
    end
    property cdma_wt__cbuf_idx_wrap__0_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((wt_cbuf_wr_idx_set | clear_all | wt_cbuf_wr_vld_w) & wt_cbuf_wr_idx_wrap);
    endproperty
// Cover 0 : "((wt_cbuf_wr_idx_set | clear_all | wt_cbuf_wr_vld_w) & wt_cbuf_wr_idx_wrap)"
    FUNCPOINT_cdma_wt__cbuf_idx_wrap__0_COV : cover property (cdma_wt__cbuf_idx_wrap__0_cov);
  `endif
`endif
//VCS coverage on
////////////////////////////////////////////////////////////////////////
// Assertion //
////////////////////////////////////////////////////////////////////////
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,2,0,"No Xs allowed on cur_state") zzz_assert_no_x_1x (nvdla_core_clk, `ASSERT_RESET, 1'd1, cur_state); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_2x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | is_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_end))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_17x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(wt_req_reg_en_d0))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_20x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(wt_req_reg_en_d1))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_25x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(wt_req_reg_en_d2))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_53x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(dbg_src_wr_ptr_en & ~dbg_src_wr_ptr))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_54x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(dbg_src_wr_ptr_en & dbg_src_wr_ptr))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_55x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(dma_rd_rsp_vld & dma_rd_rsp_rdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_60x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(wt_rsp_valid))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_61x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(wt_cbuf_wr_idx_set | clear_all | wt_cbuf_wr_vld_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_66x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(wt_cbuf_flush_vld_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_67x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(cdma2buf_wt_wr_en_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_68x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(cdma2buf_wt_wr_en_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_69x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(cdma2buf_wt_wr_en_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_73x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(nan_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_74x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(inf_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_75x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(sc2cdma_wt_updt))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_76x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(sc2cdma_wt_updt))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_77x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(wt_data_onfly_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_78x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(wt_cbuf_wr_vld_w | status_update))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_79x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(status_update | sc_wt_updt | clear_all))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_93x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(wgs_data_onfly_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_95x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | wt_required_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_97x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | status_update))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_101x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | wt_cbuf_wr_vld_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_105x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(status_update))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_110x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(incr_wt_updt_d0))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_113x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(incr_wt_updt_d1))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_116x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(incr_wt_updt_d2))); // spyglass disable W504 SelfDeterminedExpr-ML 
// nv_assert_never #(0,0,"Config error! Data banks is more than 15!") zzz_assert_never_6x (nvdla_core_clk, `ASSERT_RESET, (reg2dp_op_en && (reg2dp_data_bank == 4'hf))); // spyglass disable W504 SelfDeterminedExpr-ML 
// nv_assert_never #(0,0,"Config error! Weight banks is more than 15!") zzz_assert_never_7x (nvdla_core_clk, `ASSERT_RESET, (reg2dp_op_en && (reg2dp_weight_bank == 4'hf))); // spyglass disable W504 SelfDeterminedExpr-ML 
// nv_assert_never #(0,0,"Config error! Sum of data & weight banks is more than 16 when weight uncompressed") zzz_assert_never_8x (nvdla_core_clk, `ASSERT_RESET, (reg2dp_op_en && ~is_compressed && (weight_bank_end_w > 16))); // spyglass disable W504 SelfDeterminedExpr-ML 
// nv_assert_never #(0,0,"Config error! Sum of data & weight banks is more than 15 when weight compressed!") zzz_assert_never_9x (nvdla_core_clk, `ASSERT_RESET, (reg2dp_op_en && is_compressed && (weight_bank_end_w > 15))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_req_burst_cnt_dec is overflow") zzz_assert_never_19x (nvdla_core_clk, `ASSERT_RESET, (reg2dp_op_en && mon_wt_req_burst_cnt_dec)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! FSM done when wt fetch is not!") zzz_assert_never_29x (nvdla_core_clk, `ASSERT_RESET, (is_running & ~is_nxt_running & ~wt_req_done_d3)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_data_onfly is not zero when idle") zzz_assert_never_30x (nvdla_core_clk, `ASSERT_RESET, (~is_running && (|wt_data_onfly))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_data_stored is not zero when idle") zzz_assert_never_31x (nvdla_core_clk, `ASSERT_RESET, (~is_running && (|wt_data_stored))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"response fifo pop error") zzz_assert_never_56x (nvdla_core_clk, `ASSERT_RESET, (dma_rsp_fifo_ready & ~dma_rsp_fifo_req)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"response size mismatch") zzz_assert_never_57x (nvdla_core_clk, `ASSERT_RESET, (dma_rd_rsp_vld & dma_rd_rsp_rdy & (dma_rsp_size_cnt_inc > dma_rsp_size))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! dma_rsp_size_cnt_inc is overflow") zzz_assert_never_58x (nvdla_core_clk, `ASSERT_RESET, (reg2dp_op_en & mon_dma_rsp_size_cnt_inc)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! dma_rsp_size_cnt_inc is out of range") zzz_assert_never_59x (nvdla_core_clk, `ASSERT_RESET, (reg2dp_op_en & (dma_rsp_size_cnt_inc > 8'h8))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"WT and FLUSH write hazard") zzz_assert_never_71x (nvdla_core_clk, `ASSERT_RESET, (wt_cbuf_wr_vld_w & wt_cbuf_flush_vld_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_data_onfly_w is overflow") zzz_assert_never_80x (nvdla_core_ng_clk, `ASSERT_RESET, (reg2dp_op_en & mon_wt_data_onfly_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_data_stored_w is overflow") zzz_assert_never_81x (nvdla_core_ng_clk, `ASSERT_RESET, (reg2dp_op_en & mon_wt_data_stored_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_data_onfly is not zero when idle") zzz_assert_never_82x (nvdla_core_ng_clk, `ASSERT_RESET, (~is_running & (|wt_data_onfly))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_data_stored is not zero when idle") zzz_assert_never_83x (nvdla_core_ng_clk, `ASSERT_RESET, (~is_running & (|wt_data_stored))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_data_avl_w is overflow") zzz_assert_never_84x (nvdla_core_ng_clk, `ASSERT_RESET, (reg2dp_op_en && mon_wt_data_avl_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wt_fetched_cnt_w is overflow") zzz_assert_never_103x (nvdla_core_clk, `ASSERT_RESET, ((layer_st | wt_cbuf_wr_vld_w) & mon_wt_fetched_cnt_inc)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Config error! Run out of weight buffer: uncompressed weight!") zzz_assert_never_121x (nvdla_core_clk, `ASSERT_RESET, (is_running & ~reg2dp_skip_weight_rls & ~dbg_full_weight & ~is_compressed & ~status_done & ((dbg_wt_kernel_bytes + 128) > {weight_bank, 15'b0}))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Config error! Run out of weight buffer: full weight!") zzz_assert_never_124x (nvdla_core_clk, `ASSERT_RESET, (is_running & reg2dp_skip_weight_rls & ~dbg_full_weight)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! Weight output update with zero kernels") zzz_assert_never_126x (nvdla_core_clk, `ASSERT_RESET, (cdma2sc_wt_updt & ~(|cdma2sc_wt_kernels))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"never: counter overflow beyond <ovr_cnt>") zzz_assert_never_127x (nvdla_core_clk, `ASSERT_RESET, (ltc_1_cnt_nxt > 511 && wt_rd_latency_cen)); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
endmodule // NV_NVDLA_CDMA_wt
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
module NV_NVDLA_CDMA_WT_8ATMM_fifo (
      nvdla_core_clk
    , nvdla_core_rstn
    , atmm8_wr_prdy
    , atmm8_wr_pvld
`ifdef FV_RAND_WR_PAUSE
    , atmm8_wr_pause
`endif
    , atmm8_wr_pd
    , atmm8_rd_prdy
    , atmm8_rd_pvld
    , atmm8_rd_pd
    , pwrbus_ram_pd
    );
// spyglass disable_block W401 -- clock is not input to module
input nvdla_core_clk;
input nvdla_core_rstn;
output atmm8_wr_prdy;
input atmm8_wr_pvld;
`ifdef FV_RAND_WR_PAUSE
input atmm8_wr_pause;
`endif
input [64:0] atmm8_wr_pd;
input atmm8_rd_prdy;
output atmm8_rd_pvld;
output [64:0] atmm8_rd_pd;
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
reg atmm8_wr_busy_int; // copy for internal use
assign atmm8_wr_prdy = !atmm8_wr_busy_int;
assign wr_reserving = atmm8_wr_pvld && !atmm8_wr_busy_int; // reserving write space?
reg wr_popping; // fwd: write side sees pop?
reg [3:0] atmm8_wr_count; // write-side count
wire [3:0] wr_count_next_wr_popping = wr_reserving ? atmm8_wr_count : (atmm8_wr_count - 1'd1); // spyglass disable W164a W484
wire [3:0] wr_count_next_no_wr_popping = wr_reserving ? (atmm8_wr_count + 1'd1) : atmm8_wr_count; // spyglass disable W164a W484
wire [3:0] wr_count_next = wr_popping ? wr_count_next_wr_popping :
                                               wr_count_next_no_wr_popping;
wire wr_count_next_no_wr_popping_is_8 = ( wr_count_next_no_wr_popping == 4'd8 );
wire wr_count_next_is_8 = wr_popping ? 1'b0 :
                                          wr_count_next_no_wr_popping_is_8;
wire [3:0] wr_limit_muxed; // muxed with simulation/emulation overrides
wire [3:0] wr_limit_reg = wr_limit_muxed;
`ifdef FV_RAND_WR_PAUSE
// VCS coverage off
wire atmm8_wr_busy_next = wr_count_next_is_8 || // busy next cycle?
                          (wr_limit_reg != 4'd0 && // check atmm8_wr_limit if != 0
                           wr_count_next >= wr_limit_reg) || atmm8_wr_pause;
// VCS coverage on
`else
// VCS coverage off
wire atmm8_wr_busy_next = wr_count_next_is_8 || // busy next cycle?
                          (wr_limit_reg != 4'd0 && // check atmm8_wr_limit if != 0
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
        atmm8_wr_busy_int <= 1'b0;
        atmm8_wr_count <= 4'd0;
    end else begin
 atmm8_wr_busy_int <= atmm8_wr_busy_next;
 if ( wr_reserving ^ wr_popping ) begin
     atmm8_wr_count <= wr_count_next;
        end
//synopsys translate_off
            else if ( !(wr_reserving ^ wr_popping) ) begin
        end else begin
            atmm8_wr_count <= {4{`x_or_0}};
        end
//synopsys translate_on
    end
end
wire wr_pushing = wr_reserving; // data pushed same cycle as atmm8_wr_pvld
//
// RAM
//
reg [2:0] atmm8_wr_adr; // current write address
wire [2:0] atmm8_rd_adr_p; // read address to use for ram
wire [64:0] atmm8_rd_pd_p; // read data directly out of ram
wire rd_enable;
wire ore;
wire [31 : 0] pwrbus_ram_pd;
// Adding parameter for fifogen to disable wr/rd contention assertion in ramgen.
// Fifogen handles this by ignoring the data on the ram data out for that cycle.
nv_ram_rwsp_8x65 #(`FORCE_CONTENTION_ASSERTION_RESET_ACTIVE) ram (
      .clk ( nvdla_core_clk )
    , .pwrbus_ram_pd ( pwrbus_ram_pd )
    , .wa ( atmm8_wr_adr )
    , .we ( wr_pushing )
    , .di ( atmm8_wr_pd )
    , .ra ( atmm8_rd_adr_p )
    , .re ( rd_enable )
    , .dout ( atmm8_rd_pd_p )
    , .ore ( ore )
    );
// next atmm8_wr_adr if wr_pushing=1
wire [2:0] wr_adr_next = atmm8_wr_adr + 1'd1; // spyglass disable W484
// spyglass disable_block W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        atmm8_wr_adr <= 3'd0;
    end else begin
        if ( wr_pushing ) begin
            atmm8_wr_adr <= wr_adr_next;
        end
//synopsys translate_off
            else if ( !(wr_pushing) ) begin
        end else begin
            atmm8_wr_adr <= {3{`x_or_0}};
        end
//synopsys translate_on
    end
end
// spyglass enable_block W484
wire rd_popping; // read side doing pop this cycle?
reg [2:0] atmm8_rd_adr; // current read address
// next read address
wire [2:0] rd_adr_next = atmm8_rd_adr + 1'd1; // spyglass disable W484
assign atmm8_rd_adr_p = rd_popping ? rd_adr_next : atmm8_rd_adr; // for ram
// spyglass disable_block W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        atmm8_rd_adr <= 3'd0;
    end else begin
        if ( rd_popping ) begin
     atmm8_rd_adr <= rd_adr_next;
        end
//synopsys translate_off
            else if ( !rd_popping ) begin
        end else begin
            atmm8_rd_adr <= {3{`x_or_0}};
        end
//synopsys translate_on
    end
end
// spyglass enable_block W484
//
// SYNCHRONOUS BOUNDARY
//
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        wr_popping <= 1'b0;
    end else begin
 wr_popping <= rd_popping;
    end
end
reg rd_pushing;
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        rd_pushing <= 1'b0;
    end else begin
 rd_pushing <= wr_pushing; // let data go into ram first
    end
end
//
// READ SIDE
//
reg atmm8_rd_pvld_p; // data out of fifo is valid
reg atmm8_rd_pvld_int; // internal copy of atmm8_rd_pvld
assign atmm8_rd_pvld = atmm8_rd_pvld_int;
assign rd_popping = atmm8_rd_pvld_p && !(atmm8_rd_pvld_int && !atmm8_rd_prdy);
reg [3:0] atmm8_rd_count_p; // read-side fifo count
// spyglass disable_block W164a W484
wire [3:0] rd_count_p_next_rd_popping = rd_pushing ? atmm8_rd_count_p :
                                                                (atmm8_rd_count_p - 1'd1);
wire [3:0] rd_count_p_next_no_rd_popping = rd_pushing ? (atmm8_rd_count_p + 1'd1) :
                                                                    atmm8_rd_count_p;
// spyglass enable_block W164a W484
wire [3:0] rd_count_p_next = rd_popping ? rd_count_p_next_rd_popping :
                                                     rd_count_p_next_no_rd_popping;
wire rd_count_p_next_rd_popping_not_0 = rd_count_p_next_rd_popping != 0;
wire rd_count_p_next_no_rd_popping_not_0 = rd_count_p_next_no_rd_popping != 0;
wire rd_count_p_next_not_0 = rd_popping ? rd_count_p_next_rd_popping_not_0 :
                                              rd_count_p_next_no_rd_popping_not_0;
assign rd_enable = ((rd_count_p_next_not_0) && ((~atmm8_rd_pvld_p) || rd_popping)); // anytime data's there and not stalled
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        atmm8_rd_count_p <= 4'd0;
        atmm8_rd_pvld_p <= 1'b0;
    end else begin
        if ( rd_pushing || rd_popping ) begin
     atmm8_rd_count_p <= rd_count_p_next;
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            atmm8_rd_count_p <= {4{`x_or_0}};
        end
//synopsys translate_on
        if ( rd_pushing || rd_popping ) begin
     atmm8_rd_pvld_p <= (rd_count_p_next_not_0);
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            atmm8_rd_pvld_p <= `x_or_0;
        end
//synopsys translate_on
    end
end
wire rd_req_next = (atmm8_rd_pvld_p || (atmm8_rd_pvld_int && !atmm8_rd_prdy)) ;
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        atmm8_rd_pvld_int <= 1'b0;
    end else begin
        atmm8_rd_pvld_int <= rd_req_next;
    end
end
assign atmm8_rd_pd = atmm8_rd_pd_p;
assign ore = rd_popping;
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
assign nvdla_core_clk_mgated_enable = ((wr_reserving || wr_pushing || rd_popping || wr_popping || (atmm8_wr_pvld && !atmm8_wr_busy_int) || (atmm8_wr_busy_int != atmm8_wr_busy_next)) || (rd_pushing || rd_popping || (atmm8_rd_pvld_int && atmm8_rd_prdy) || wr_pushing))
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
assign wr_limit_muxed = `EMU_FIFO_CFG.NV_NVDLA_CDMA_WT_8ATMM_fifo_wr_limit_override ? `EMU_FIFO_CFG.NV_NVDLA_CDMA_WT_8ATMM_fifo_wr_limit : 4'd0;
`else
// No Global Override for Emulation
//
assign wr_limit_muxed = 4'd0;
`endif // EMU_FIFO_CFG
`else // !EMU
`ifdef SYNTH_LEVEL1_COMPILE
// No Override for GCS Compiles
//
assign wr_limit_muxed = 4'd0;
`else
`ifdef SYNTHESIS
// No Override for RTL Synthesis
//
assign wr_limit_muxed = 4'd0;
`else
// RTL Simulation Plusarg Override
// VCS coverage off
reg wr_limit_override;
reg [3:0] wr_limit_override_value;
assign wr_limit_muxed = wr_limit_override ? wr_limit_override_value : 4'd0;
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
    if ( $test$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_wr_limit" ) ) begin
        wr_limit_override = 1;
        $value$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_wr_limit=%d", wr_limit_override_value);
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
    if ( $test$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_probability" ) ) begin
        $value$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_probability=%d", stall_probability);
    end else if ( $test$plusargs( "default_fifo_stall_probability" ) ) begin
        $value$plusargs( "default_fifo_stall_probability=%d", stall_probability);
    end
    if ( $test$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_cycles_min" ) ) begin
        $value$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_cycles_min=%d", stall_cycles_min);
    end else if ( $test$plusargs( "default_fifo_stall_cycles_min" ) ) begin
        $value$plusargs( "default_fifo_stall_cycles_min=%d", stall_cycles_min);
    end
    if ( $test$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_cycles_max" ) ) begin
        $value$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_cycles_max=%d", stall_cycles_max);
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
    if ( ! $test$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_probability" ) ) stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_probability;
    if ( ! $test$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_cycles_min" ) ) stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_cycles_min;
    if ( ! $test$plusargs( "NV_NVDLA_CDMA_WT_8ATMM_fifo_fifo_stall_cycles_max" ) ) stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_fifo_cycles_max;
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
            if ( atmm8_wr_pvld && !(!atmm8_wr_prdy)
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
    , .max ( {28'd0, (wr_limit_reg == 4'd0) ? 4'd8 : wr_limit_reg} )
    , .curr ( {28'd0, atmm8_wr_count} )
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
// set_boundary_optimization find(design, "NV_NVDLA_CDMA_WT_8ATMM_fifo") true
// synopsys dc_script_end
//| &Attachment -no_warn EndModulePrepend;
//| _attach_EndModulePrepend_1;
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
//| _attach_EndModulePrepend_2;
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
endmodule // NV_NVDLA_CDMA_WT_8ATMM_fifo
