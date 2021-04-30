// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CSC_wl.v
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
module NV_NVDLA_CSC_wl (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,sg2wl_pvld //|< i
  ,sg2wl_pd //|< i
  ,sc_state //|< i
  ,sg2wl_reuse_rls //|< i
  ,sc2cdma_wt_pending_req //|< i
  ,cdma2sc_wt_updt //|< i
  ,cdma2sc_wt_kernels //|< i *
  ,cdma2sc_wt_entries //|< i
  ,cdma2sc_wmb_entries //|< i
  ,sc2cdma_wt_updt //|> o
  ,sc2cdma_wt_kernels //|> o
  ,sc2cdma_wt_entries //|> o
  ,sc2cdma_wmb_entries //|> o
  ,sc2buf_wt_rd_en //|> o
  ,sc2buf_wt_rd_addr //|> o
  ,sc2buf_wt_rd_valid //|< i
  ,sc2buf_wt_rd_data //|< i
  `ifdef CBUF_WEIGHT_COMPRESSED
  ,sc2buf_wmb_rd_en //|> o
  ,sc2buf_wmb_rd_addr //|> o
  ,sc2buf_wmb_rd_valid //|< i
  ,sc2buf_wmb_rd_data //|< i
  `endif
  ,sc2mac_wt_a_pvld //|> o
  ,sc2mac_wt_a_mask //|> o
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq( ,sc2mac_wt_a_data${i} //|> o\n);
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
  ,sc2mac_wt_a_sel //|> o
  ,sc2mac_wt_b_pvld //|> o
  ,sc2mac_wt_b_mask //|> o
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq( ,sc2mac_wt_b_data${i} //|> o\n);
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
  ,sc2mac_wt_b_sel //|> o
  ,nvdla_core_ng_clk //|< i
  ,reg2dp_op_en //|< i
  ,reg2dp_in_precision //|< i *
  ,reg2dp_proc_precision //|< i
  ,reg2dp_y_extension //|< i
  ,reg2dp_weight_reuse //|< i *
  ,reg2dp_skip_weight_rls //|< i
  ,reg2dp_weight_format //|< i
  ,reg2dp_weight_bytes //|< i
  ,reg2dp_wmb_bytes //|< i
  ,reg2dp_data_bank //|< i
  ,reg2dp_weight_bank //|< i
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input sg2wl_pvld; /* data valid */
input [17:0] sg2wl_pd;
input [1:0] sc_state;
input sg2wl_reuse_rls;
input sc2cdma_wt_pending_req;
input cdma2sc_wt_updt; /* data valid */
input [13:0] cdma2sc_wt_kernels;
input [15 -1:0] cdma2sc_wt_entries;
input [8:0] cdma2sc_wmb_entries;
output sc2cdma_wt_updt; /* data valid */
output [13:0] sc2cdma_wt_kernels;
output [15 -1:0] sc2cdma_wt_entries;
output [8:0] sc2cdma_wmb_entries;
output sc2buf_wt_rd_en; /* data valid */
output [14 -1:0] sc2buf_wt_rd_addr;
input sc2buf_wt_rd_valid; /* data valid */
input [64 -1:0] sc2buf_wt_rd_data;
`ifdef CBUF_WEIGHT_COMPRESSED
output sc2buf_wmb_rd_en; /* data valid */
output [14 -1:0] sc2buf_wmb_rd_addr;
input sc2buf_wmb_rd_valid; /* data valid */
input [64 -1:0] sc2buf_wmb_rd_data;
`else
wire sc2buf_wmb_rd_valid=1'b0;
wire [64 -1:0] sc2buf_wmb_rd_data= {64{1'b0}};
`endif
output sc2mac_wt_a_pvld; /* data valid */
output sc2mac_wt_b_pvld; /* data valid */
output [8 -1:0] sc2mac_wt_a_mask;
output [8 -1:0] sc2mac_wt_b_mask;
output [8/2 -1:0] sc2mac_wt_a_sel;
output [8/2 -1:0] sc2mac_wt_b_sel;
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq(output [8 -1:0] sc2mac_wt_a_data${i};\n);
//: print qq(output [8 -1:0] sc2mac_wt_b_data${i};\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
output [8 -1:0] sc2mac_wt_a_data0;
output [8 -1:0] sc2mac_wt_b_data0;
output [8 -1:0] sc2mac_wt_a_data1;
output [8 -1:0] sc2mac_wt_b_data1;
output [8 -1:0] sc2mac_wt_a_data2;
output [8 -1:0] sc2mac_wt_b_data2;
output [8 -1:0] sc2mac_wt_a_data3;
output [8 -1:0] sc2mac_wt_b_data3;
output [8 -1:0] sc2mac_wt_a_data4;
output [8 -1:0] sc2mac_wt_b_data4;
output [8 -1:0] sc2mac_wt_a_data5;
output [8 -1:0] sc2mac_wt_b_data5;
output [8 -1:0] sc2mac_wt_a_data6;
output [8 -1:0] sc2mac_wt_b_data6;
output [8 -1:0] sc2mac_wt_a_data7;
output [8 -1:0] sc2mac_wt_b_data7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input nvdla_core_ng_clk;
input [0:0] reg2dp_op_en;
input [1:0] reg2dp_in_precision;
input [1:0] reg2dp_proc_precision;
input [1:0] reg2dp_y_extension;
input [0:0] reg2dp_weight_reuse;
input [0:0] reg2dp_skip_weight_rls;
input [0:0] reg2dp_weight_format;
input [31:0] reg2dp_weight_bytes;
input [27:0] reg2dp_wmb_bytes;
input [4:0] reg2dp_data_bank;
input [4:0] reg2dp_weight_bank;
reg [4:0] data_bank;
reg [64 -1:0] dec_input_data;
reg [8 -1:0] dec_input_mask;
reg [9:0] dec_input_mask_en;
reg dec_input_pipe_valid;
reg is_compressed_d1;
reg is_sg_running_d1;
reg [15 -1:0] last_weight_entries;
reg [8:0] last_wmb_entries;
reg [14 -1:0] sc2buf_wmb_rd_addr;
reg sc2buf_wmb_rd_en;
reg [14 -1:0] sc2buf_wt_rd_addr;
reg sc2buf_wt_rd_en;
reg [8:0] sc2cdma_wmb_entries;
reg [15 -1:0] sc2cdma_wt_entries;
reg sc2cdma_wt_updt;
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq(reg [8 -1:0] sc2mac_wt_a_data${i};\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [8 -1:0] sc2mac_wt_a_data0;
reg [8 -1:0] sc2mac_wt_a_data1;
reg [8 -1:0] sc2mac_wt_a_data2;
reg [8 -1:0] sc2mac_wt_a_data3;
reg [8 -1:0] sc2mac_wt_a_data4;
reg [8 -1:0] sc2mac_wt_a_data5;
reg [8 -1:0] sc2mac_wt_a_data6;
reg [8 -1:0] sc2mac_wt_a_data7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [8 -1:0] sc2mac_wt_a_mask;
reg sc2mac_wt_a_pvld;
reg [8/2 -1:0] sc2mac_wt_a_sel;
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq(reg [7:0] sc2mac_wt_b_data${i};\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [7:0] sc2mac_wt_b_data0;
reg [7:0] sc2mac_wt_b_data1;
reg [7:0] sc2mac_wt_b_data2;
reg [7:0] sc2mac_wt_b_data3;
reg [7:0] sc2mac_wt_b_data4;
reg [7:0] sc2mac_wt_b_data5;
reg [7:0] sc2mac_wt_b_data6;
reg [7:0] sc2mac_wt_b_data7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [8 -1:0] sc2mac_wt_b_mask;
reg sc2mac_wt_b_pvld;
reg [8/2 -1:0] sc2mac_wt_b_sel;
reg [4:0] stripe_cnt;
reg [2:0] sub_h_total;
reg [4:0] weight_bank;
reg [17:0] wl_in_pd_d1;
reg wl_in_pvld_d1;
reg [10:0] wmb_element_avl;
reg [10:0] wmb_element_avl_last;
reg [64 -1:0] wmb_emask_remain;
reg [64 -1:0] wmb_emask_remain_last;
reg [8:0] wmb_entry_avl;
reg [8:0] wmb_entry_end;
reg [8:0] wmb_entry_st;
reg wmb_pipe_valid_d1;
reg [14 -1:0] wmb_req_addr;
reg [14 -1:0] wmb_req_addr_last;
reg wmb_req_channel_end_d1;
reg [1:0] wmb_req_cur_sub_h_d1;
reg [7:0] wmb_req_element_d1;
reg wmb_req_group_end_d1;
reg [6:0] wmb_req_ori_element_d1;
reg wmb_req_rls_d1;
reg [8:0] wmb_req_rls_entries_d1;
reg wmb_req_stripe_end_d1;
reg [8:0] wmb_rls_cnt;
reg wmb_rls_cnt_vld;
reg [9:0] wmb_rsp_bit_remain;
reg [9:0] wmb_rsp_bit_remain_last;
reg [7:0] wt_byte_avl;
reg [7:0] wt_byte_avl_last;
reg [64 -1:0] wt_data_remain;
reg [64 -1:0] wt_data_remain_last;
reg [15 -1:0] wt_entry_avl;
reg [15 -1:0] wt_entry_end;
reg [15 -1:0] wt_entry_st;
reg [14 -1:0] wt_req_addr;
reg [14 -1:0] wt_req_addr_last;
reg [7:0] wt_req_bytes_d1;
reg wt_req_channel_end;
reg wt_req_channel_end_d1;
reg [1:0] wt_req_cur_sub_h;
reg [8 -1:0] wt_req_emask;
reg wt_req_group_end;
reg wt_req_group_end_d1;
reg [8 -1:0] wt_req_mask_d1;
reg wt_req_mask_en_d1;
reg [6:0] wt_req_ori_element;
reg [6:0] wt_req_ori_sft_3;
reg wt_req_pipe_valid;
reg wt_req_pipe_valid_d1;
reg wt_req_rls;
reg wt_req_rls_d1;
reg wt_req_stripe_end;
reg wt_req_stripe_end_d1;
reg [8:0] wt_req_wmb_rls_entries;
reg [8:0] wt_req_wmb_rls_entries_d1;
reg [15 -1:0] wt_req_wt_rls_entries_d1;
reg [15 -1:0] wt_rls_cnt;
reg wt_rls_cnt_vld;
reg [6:0] wt_rsp_byte_remain;
reg [6:0] wt_rsp_byte_remain_last;
reg wt_rsp_last_stripe_end;
reg [8 -1:0] wt_rsp_sel_d1;
wire addr_init;
wire cbuf_reset;
wire [4:0] data_bank_w;
wire [64 -1:0] dbg_csc_wt_a;
wire [64 -1:0] dbg_csc_wt_b;
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq(wire [8 -1:0] dbg_csc_wt_a_${i};\n);
//: print qq(wire [8 -1:0] dbg_csc_wt_b_${i};\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [8 -1:0] dbg_csc_wt_a_0;
wire [8 -1:0] dbg_csc_wt_b_0;
wire [8 -1:0] dbg_csc_wt_a_1;
wire [8 -1:0] dbg_csc_wt_b_1;
wire [8 -1:0] dbg_csc_wt_a_2;
wire [8 -1:0] dbg_csc_wt_b_2;
wire [8 -1:0] dbg_csc_wt_a_3;
wire [8 -1:0] dbg_csc_wt_b_3;
wire [8 -1:0] dbg_csc_wt_a_4;
wire [8 -1:0] dbg_csc_wt_b_4;
wire [8 -1:0] dbg_csc_wt_a_5;
wire [8 -1:0] dbg_csc_wt_b_5;
wire [8 -1:0] dbg_csc_wt_a_6;
wire [8 -1:0] dbg_csc_wt_b_6;
wire [8 -1:0] dbg_csc_wt_a_7;
wire [8 -1:0] dbg_csc_wt_b_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8 -1:0] dec_input_sel;
wire is_compressed;
wire is_sg_done;
wire is_sg_idle;
wire is_sg_pending;
wire is_sg_running;
wire is_stripe_end;
wire is_wr_req_addr_wrap;
wire is_wt_entry_end_wrap;
wire is_wt_entry_st_wrap;
wire [8:0] last_wmb_entries_w;
wire layer_st;
wire mon_data_bank_w;
wire mon_stripe_cnt_inc;
wire mon_stripe_length;
wire [2:0] mon_sub_h_total_w;
wire mon_weight_bank_w;
wire mon_wmb_element_avl_inc;
wire mon_wmb_entry_avl_w;
wire mon_wmb_entry_end_inc;
wire mon_wmb_entry_st_inc;
wire mon_wmb_req_addr_inc;
wire mon_wmb_req_element;
wire mon_wmb_rls_cnt_inc;
wire [1:0] mon_wmb_rsp_bit_remain_w;
wire mon_wmb_shift_remain;
wire mon_wt_byte_avl_inc;
wire mon_wt_entry_avl_w;
wire mon_wt_entry_end_inc_wrap;
wire mon_wt_entry_st_inc_wrap;
wire mon_wt_req_addr_inc;
wire mon_wt_req_addr_out;
wire mon_wt_rls_cnt_inc;
wire [1:0] mon_wt_rsp_byte_remain_w;
wire mon_wt_shift_remain;
wire reuse_rls;
wire [8 -1:0] sc2mac_out_a_mask;
wire [8/2 -1:0] sc2mac_out_a_sel_w;
wire [8 -1:0] sc2mac_out_b_mask;
wire [8/2 -1:0] sc2mac_out_b_sel_w;
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq(wire [8 -1:0] sc2mac_out_data${i};\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [8 -1:0] sc2mac_out_data0;
wire [8 -1:0] sc2mac_out_data1;
wire [8 -1:0] sc2mac_out_data2;
wire [8 -1:0] sc2mac_out_data3;
wire [8 -1:0] sc2mac_out_data4;
wire [8 -1:0] sc2mac_out_data5;
wire [8 -1:0] sc2mac_out_data6;
wire [8 -1:0] sc2mac_out_data7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8 -1:0] sc2mac_out_mask;
wire sc2mac_out_pvld;
wire [8 -1:0] sc2mac_out_sel;
wire sc2mac_wt_a_pvld_w;
wire sc2mac_wt_b_pvld_w;
wire [4:0] stripe_cnt_inc;
wire stripe_cnt_reg_en;
wire [4:0] stripe_cnt_w;
wire [4:0] stripe_length;
wire [8 -1:0] sub_h_mask_1;
wire [8 -1:0] sub_h_mask_2;
wire [8 -1:0] sub_h_mask_3;
wire [2:0] sub_h_total_w;
wire sub_rls;
wire [8:0] sub_rls_wmb_entries;
wire [15 -1:0] sub_rls_wt_entries;
wire [4:0] weight_bank_w;
wire wl_channel_end;
wire [1:0] wl_cur_sub_h;
wire wl_group_end;
wire [17:0] wl_in_pd;
wire [17:0] wl_in_pd_d0;
wire wl_in_pvld;
wire wl_in_pvld_d0;
wire [5:0] wl_kernel_size;
wire [17:0] wl_pd;
wire wl_pvld;
wire [6:0] wl_weight_size;
wire wl_wt_release;
wire [10:0] wmb_element_avl_add;
wire [10:0] wmb_element_avl_inc;
wire wmb_element_avl_last_reg_en;
wire wmb_element_avl_reg_en;
wire [7:0] wmb_element_avl_sub;
wire [10:0] wmb_element_avl_w;
wire [8 -1:0] wmb_emask_rd_ls;
wire [64 -1:0] wmb_emask_rd_rs;
wire wmb_emask_remain_last_reg_en;
wire wmb_emask_remain_reg_en;
wire [64 -1:0] wmb_emask_remain_rs;
wire [64 -1:0] wmb_emask_remain_w;
wire [8:0] wmb_entry_avl_add;
wire [8:0] wmb_entry_avl_sub;
wire [8:0] wmb_entry_avl_w;
wire [8:0] wmb_entry_end_inc;
wire [8:0] wmb_entry_end_w;
wire [8:0] wmb_entry_st_inc;
wire [8:0] wmb_entry_st_w;
wire wmb_pipe_valid;
wire [14 -1:0] wmb_req_addr_inc;
wire wmb_req_addr_last_reg_en;
wire wmb_req_addr_reg_en;
wire [14 -1:0] wmb_req_addr_w;
wire [7:0] wmb_req_cycle_element;
wire wmb_req_d1_channel_end;
wire [1:0] wmb_req_d1_cur_sub_h;
wire [7:0] wmb_req_d1_element;
wire wmb_req_d1_group_end;
wire [6:0] wmb_req_d1_ori_element;
wire wmb_req_d1_rls;
wire [8:0] wmb_req_d1_rls_entries;
wire wmb_req_d1_stripe_end;
wire [7:0] wmb_req_element;
wire [6:0] wmb_req_ori_element;
wire [30:0] wmb_req_pipe_pd;
wire wmb_req_pipe_pvld;
wire wmb_req_valid;
wire [8:0] wmb_rls_cnt_inc;
wire wmb_rls_cnt_reg_en;
wire wmb_rls_cnt_vld_w;
wire [8:0] wmb_rls_cnt_w;
wire [8:0] wmb_rls_entries;
wire [10:0] wmb_rsp_bit_remain_add;
wire wmb_rsp_bit_remain_last_reg_en;
wire [7:0] wmb_rsp_bit_remain_sub;
wire [9:0] wmb_rsp_bit_remain_w;
wire wmb_rsp_channel_end;
wire [1:0] wmb_rsp_cur_sub_h;
wire [7:0] wmb_rsp_element;
wire [8 -1:0] wmb_rsp_emask;
wire [8 -1:0] wmb_rsp_emask_in;
wire wmb_rsp_group_end;
wire [6:0] wmb_rsp_ori_element;
wire [6:0] wmb_rsp_ori_sft_3;
wire [30:0] wmb_rsp_pipe_pd;
wire [30:0] wmb_rsp_pipe_pd_d0;
wire wmb_rsp_pipe_pvld;
wire wmb_rsp_pipe_pvld_d0;
wire wmb_rsp_rls;
wire [8:0] wmb_rsp_rls_entries;
wire wmb_rsp_stripe_end;
wire [8 -1:0] wmb_rsp_vld_s;
wire [7:0] wmb_shift_remain;
wire [7:0] wt_byte_avl_add;
wire [7:0] wt_byte_avl_inc;
wire [7:0] wt_byte_avl_sub;
wire [7:0] wt_byte_avl_w;
wire wt_byte_last_reg_en;
wire [64 -1:0] wt_data_input_ls;
wire [64 -1:0] wt_data_input_rs;
wire [64 -1:0] wt_data_input_sft;
wire wt_data_remain_last_reg_en;
wire [64 -1:0] wt_data_remain_masked;
wire wt_data_remain_reg_en;
wire [64 -1:0] wt_data_remain_rs;
wire [64 -1:0] wt_data_remain_w;
wire [15 -1:0] wt_entry_avl_add;
wire [15 -1:0] wt_entry_avl_sub;
wire [15 -1:0] wt_entry_avl_w;
wire [15 -1:0] wt_entry_end_inc;
wire [15 -1:0] wt_entry_end_inc_wrap;
wire [15 -1:0] wt_entry_end_w;
wire [15 -1:0] wt_entry_st_inc;
wire [15 -1:0] wt_entry_st_inc_wrap;
wire [15 -1:0] wt_entry_st_w;
wire mon_wt_entry_end_inc;
wire mon_wt_entry_st_inc;
wire [14 -1:0] wt_req_addr_inc;
wire [14 -1:0] wt_req_addr_inc_wrap;
wire wt_req_addr_last_reg_en;
wire [14 -1:0] wt_req_addr_out;
wire wt_req_addr_reg_en;
wire [14 -1:0] wt_req_addr_w;
wire [8 -1:0] wt_req_bmask;
wire [7:0] wt_req_bytes;
wire [7:0] wt_req_d1_bytes;
wire wt_req_d1_channel_end;
wire wt_req_d1_group_end;
wire wt_req_d1_rls;
wire wt_req_d1_stripe_end;
wire [8:0] wt_req_d1_wmb_rls_entries;
wire [15 -1:0] wt_req_d1_wt_rls_entries;
wire [8 -1:0] wt_req_emask_p0;
wire [8 -1:0] wt_req_emask_p1;
wire [8 -1:0] wt_req_emask_p2;
wire [8 -1:0] wt_req_emask_p3;
wire wt_req_mask_en;
wire [8 -1:0] wt_req_mask_w;
wire [6:0] wt_req_ori_sft_1;
wire [6:0] wt_req_ori_sft_2;
wire [35:0] wt_req_pipe_pd;
wire wt_req_pipe_pvld;
wire wt_req_valid;
wire [8 -1:0] wt_req_vld_bit;
wire wt_rls;
wire [15 -1:0] wt_rls_cnt_inc;
wire wt_rls_cnt_reg_en;
wire wt_rls_cnt_vld_w;
wire [15 -1:0] wt_rls_cnt_w;
wire [15 -1:0] wt_rls_entries;
wire wt_rls_updt;
wire [8:0] wt_rls_wmb_entries;
wire [15 -1:0] wt_rls_wt_entries;
wire [7:0] wt_rsp_byte_remain_add;
wire wt_rsp_byte_remain_en;
wire wt_rsp_byte_remain_last_en;
wire [6:0] wt_rsp_byte_remain_w;
wire [7:0] wt_rsp_bytes;
wire wt_rsp_channel_end;
wire [64 -1:0] wt_rsp_data;
wire wt_rsp_group_end;
wire [8 -1:0] wt_rsp_mask;
wire [8 -1:0] wt_rsp_mask_d0;
wire [8 -1:0] wt_rsp_mask_d1_w;
wire wt_rsp_mask_en;
wire wt_rsp_mask_en_d0;
wire [35:0] wt_rsp_pipe_pd;
wire [35:0] wt_rsp_pipe_pd_d0;
wire wt_rsp_pipe_pvld;
wire wt_rsp_pipe_pvld_d0;
wire wt_rsp_rls;
wire [8 -1:0] wt_rsp_sel_w;
wire wt_rsp_stripe_end;
wire [8:0] wt_rsp_wmb_rls_entries;
wire [15 -1:0] wt_rsp_wt_rls_entries;
wire [7:0] wt_shift_remain;
/////////////////////////////////////////////////////////////////////////////////////////////
// Pipeline of Weight loader, for both compressed weight and uncompressed weight
//
// input_package--------------
// | |
// WMB_request |
// | |
// conv_buffer |
// | |
// WMB_data ---------> weight_request
// | |
// | conv_buffer
// | |
// | weight_data
// | |
// | weight_data
// | |
// |------------> weight_decompressor
// |
// weight_to_MAC_cell
//
/////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
///// status from sequence generator                     /////
//////////////////////////////////////////////////////////////
assign is_sg_idle = (sc_state == 0 );
assign is_sg_pending = (sc_state == 1 );
assign is_sg_running = (sc_state == 2 );
assign is_sg_done = (sc_state == 3 );
assign addr_init = is_sg_running & ~is_sg_running_d1;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"is_sg_running\" -q is_sg_running_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_sg_running_d1 <= 1'b0;
   end else begin
       is_sg_running_d1 <= is_sg_running;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// input signals from registers                       /////
//////////////////////////////////////////////////////////////
assign layer_st = reg2dp_op_en & is_sg_idle;
assign {mon_data_bank_w,data_bank_w} = reg2dp_data_bank + 1'b1;
assign {mon_weight_bank_w,weight_bank_w} = reg2dp_weight_bank + 1'b1;
//assign is_int8 = (reg2dp_proc_precision == 2'h0 );
assign is_compressed = (reg2dp_weight_format == 1'h1 );
assign {sub_h_total_w,mon_sub_h_total_w} = (6'h9 << reg2dp_y_extension);
assign last_wmb_entries_w = is_compressed_d1 ? reg2dp_wmb_bytes[8+3 :3] : 9'b0;
//: my $kk=15;
//: my $jj=3;
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"layer_st\" -d \"data_bank_w\" -q data_bank");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"layer_st\" -d \"weight_bank_w\" -q weight_bank");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"is_sg_done & reg2dp_skip_weight_rls\" -d \"reg2dp_weight_bytes[${kk}-1+${jj}:${jj}]\" -q last_weight_entries");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"is_sg_done & reg2dp_skip_weight_rls\" -d \"last_wmb_entries_w\" -q last_wmb_entries");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"layer_st\" -d \"is_compressed\" -q is_compressed_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_bank <= {5{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           data_bank <= data_bank_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           data_bank <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       weight_bank <= {5{1'b0}};
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
       last_weight_entries <= {15{1'b0}};
   end else begin
       if ((is_sg_done & reg2dp_skip_weight_rls) == 1'b1) begin
           last_weight_entries <= reg2dp_weight_bytes[15-1+3:3];
       // VCS coverage off
       end else if ((is_sg_done & reg2dp_skip_weight_rls) == 1'b0) begin
       end else begin
           last_weight_entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_wmb_entries <= {9{1'b0}};
   end else begin
       if ((is_sg_done & reg2dp_skip_weight_rls) == 1'b1) begin
           last_wmb_entries <= last_wmb_entries_w;
       // VCS coverage off
       end else if ((is_sg_done & reg2dp_skip_weight_rls) == 1'b0) begin
       end else begin
           last_wmb_entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_compressed_d1 <= 1'b0;
   end else begin
       if ((layer_st) == 1'b1) begin
           is_compressed_d1 <= is_compressed;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           is_compressed_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//Now it's a valid test case
//////////////////////////////////////////////////////////////
///// cbuf status management                             /////
//////////////////////////////////////////////////////////////
assign cbuf_reset = sc2cdma_wt_pending_req;
//////////////////////////////////// calculate avaliable kernels ////////////////////////////////////
//Avaliable kernel size is useless here. Discard the code
//////////////////////////////////// calculate avaliable weight entries ////////////////////////////////////
//================ Non-SLCG clock domain ================//
assign wt_entry_avl_add = cdma2sc_wt_updt ? cdma2sc_wt_entries : {15{1'b0}};
assign wt_entry_avl_sub = wt_rls ? wt_rls_wt_entries : {15{1'b0}};
assign {mon_wt_entry_avl_w,wt_entry_avl_w} = (cbuf_reset) ? {15{1'b0}} : wt_entry_avl + wt_entry_avl_add - wt_entry_avl_sub;
//////////////////////////////////// calculate avaliable wmb entries ////////////////////////////////////
assign wmb_entry_avl_add = cdma2sc_wt_updt ? cdma2sc_wmb_entries : 9'b0;
assign wmb_entry_avl_sub = wt_rls ? wt_rls_wmb_entries : 9'b0;
assign {mon_wmb_entry_avl_w,wmb_entry_avl_w} = (cbuf_reset) ? 10'b0 : wmb_entry_avl + wmb_entry_avl_add - wmb_entry_avl_sub;
//////////////////////////////////// calculate weight entries start offset ////////////////////////////////////
assign {mon_wt_entry_st_inc,wt_entry_st_inc} = wt_entry_st + wt_rls_wt_entries;
assign {mon_wt_entry_st_inc_wrap,wt_entry_st_inc_wrap} = wt_entry_st_inc[15 -1:0] - {weight_bank, {9{1'b0}}};
assign is_wt_entry_st_wrap = (wt_entry_st_inc >= {1'b0, weight_bank, {9{1'b0}}});
assign wt_entry_st_w = (cbuf_reset) ? {15{1'b0}} :
                       (~wt_rls) ? wt_entry_st :
                       is_wt_entry_st_wrap ? wt_entry_st_inc_wrap :
                       wt_entry_st_inc[15 -1:0];
//////////////////////////////////// calculate weight entries end offset ////////////////////////////////////
assign {mon_wt_entry_end_inc,wt_entry_end_inc} = wt_entry_end + cdma2sc_wt_entries;
assign {mon_wt_entry_end_inc_wrap,wt_entry_end_inc_wrap} = wt_entry_end_inc[15 -1:0] - {weight_bank, {9{1'b0}}};
assign is_wt_entry_end_wrap = (wt_entry_end_inc >= {1'b0, weight_bank, {9{1'b0}}});
assign wt_entry_end_w = (cbuf_reset) ? {15{1'b0}} : is_wt_entry_end_wrap ? wt_entry_end_inc_wrap : wt_entry_end_inc[15 -1:0];
//////////////////////////////////// calculate wmb entries start offset ////////////////////////////////////
assign {mon_wmb_entry_st_inc,wmb_entry_st_inc} = wmb_entry_st + wt_rls_wmb_entries;
assign wmb_entry_st_w = (cbuf_reset) ? 9'b0 : (~wt_rls) ? wmb_entry_st : wmb_entry_st_inc[8:0];
//////////////////////////////////// calculate wmb entries end offset ////////////////////////////////////
assign {mon_wmb_entry_end_inc,wmb_entry_end_inc} = wmb_entry_end + cdma2sc_wmb_entries;
assign wmb_entry_end_w = (cbuf_reset) ? 9'b0 : wmb_entry_end_inc[8:0];
//////////////////////////////////// registers and assertions ////////////////////////////////////
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{12{1'b0}}\"  -en \"cdma2sc_wt_updt | wt_rls | cbuf_reset\" -d \"wt_entry_avl_w\" -q wt_entry_avl");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{9{1'b0}}\"  -en \"cdma2sc_wt_updt | wt_rls | cbuf_reset\" -d \"wmb_entry_avl_w\" -q wmb_entry_avl");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{12{1'b0}}\"  -en \"cbuf_reset | wt_rls\" -d \"wt_entry_st_w\" -q wt_entry_st");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{12{1'b0}}\"  -en \"cbuf_reset | cdma2sc_wt_updt\" -d \"wt_entry_end_w\" -q wt_entry_end");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{9{1'b0}}\"  -en \"cbuf_reset | wt_rls\" -d \"wmb_entry_st_w\" -q wmb_entry_st");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{9{1'b0}}\"  -en \"cbuf_reset | cdma2sc_wt_updt\" -d \"wmb_entry_end_w\" -q wmb_entry_end");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_entry_avl <= {12{1'b0}};
   end else begin
       if ((cdma2sc_wt_updt | wt_rls | cbuf_reset) == 1'b1) begin
           wt_entry_avl <= wt_entry_avl_w;
       // VCS coverage off
       end else if ((cdma2sc_wt_updt | wt_rls | cbuf_reset) == 1'b0) begin
       end else begin
           wt_entry_avl <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_entry_avl <= {9{1'b0}};
   end else begin
       if ((cdma2sc_wt_updt | wt_rls | cbuf_reset) == 1'b1) begin
           wmb_entry_avl <= wmb_entry_avl_w;
       // VCS coverage off
       end else if ((cdma2sc_wt_updt | wt_rls | cbuf_reset) == 1'b0) begin
       end else begin
           wmb_entry_avl <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_entry_st <= {12{1'b0}};
   end else begin
       if ((cbuf_reset | wt_rls) == 1'b1) begin
           wt_entry_st <= wt_entry_st_w;
       // VCS coverage off
       end else if ((cbuf_reset | wt_rls) == 1'b0) begin
       end else begin
           wt_entry_st <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_entry_end <= {12{1'b0}};
   end else begin
       if ((cbuf_reset | cdma2sc_wt_updt) == 1'b1) begin
           wt_entry_end <= wt_entry_end_w;
       // VCS coverage off
       end else if ((cbuf_reset | cdma2sc_wt_updt) == 1'b0) begin
       end else begin
           wt_entry_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_entry_st <= {9{1'b0}};
   end else begin
       if ((cbuf_reset | wt_rls) == 1'b1) begin
           wmb_entry_st <= wmb_entry_st_w;
       // VCS coverage off
       end else if ((cbuf_reset | wt_rls) == 1'b0) begin
       end else begin
           wmb_entry_st <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_entry_end <= {9{1'b0}};
   end else begin
       if ((cbuf_reset | cdma2sc_wt_updt) == 1'b1) begin
           wmb_entry_end <= wmb_entry_end_w;
       // VCS coverage off
       end else if ((cbuf_reset | cdma2sc_wt_updt) == 1'b0) begin
       end else begin
           wmb_entry_end <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//================ Non-SLCG clock domain end ================//
//////////////////////////////////////////////////////////////
///// cbuf status update                                 /////
//////////////////////////////////////////////////////////////
assign sub_rls = (wt_rsp_pipe_pvld & wt_rsp_rls);
assign sub_rls_wt_entries = wt_rsp_wt_rls_entries;
assign sub_rls_wmb_entries = wt_rsp_wmb_rls_entries;
assign reuse_rls = sg2wl_reuse_rls;
assign wt_rls = reuse_rls | sub_rls;
assign wt_rls_wt_entries = reuse_rls ? last_weight_entries : sub_rls_wt_entries;
assign wt_rls_wmb_entries = reuse_rls ? last_wmb_entries : sub_rls_wmb_entries;
assign wt_rls_updt = wt_rls;
//: my $kk=15;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wt_rls_updt\" -q sc2cdma_wt_updt");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wt_rls_updt\" -d \"wt_rls_wt_entries\" -q sc2cdma_wt_entries");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"wt_rls_updt\" -d \"wt_rls_wmb_entries\" -q sc2cdma_wmb_entries");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2cdma_wt_updt <= 1'b0;
   end else begin
       sc2cdma_wt_updt <= wt_rls_updt;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2cdma_wt_entries <= {15{1'b0}};
   end else begin
       if ((wt_rls_updt) == 1'b1) begin
           sc2cdma_wt_entries <= wt_rls_wt_entries;
       // VCS coverage off
       end else if ((wt_rls_updt) == 1'b0) begin
       end else begin
           sc2cdma_wt_entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2cdma_wmb_entries <= {9{1'b0}};
   end else begin
       if ((wt_rls_updt) == 1'b1) begin
           sc2cdma_wmb_entries <= wt_rls_wmb_entries;
       // VCS coverage off
       end else if ((wt_rls_updt) == 1'b0) begin
       end else begin
           sc2cdma_wmb_entries <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//sc2cmda_wt_kernels is useless
assign sc2cdma_wt_kernels = 14'b0;
//////////////////////////////////////////////////////////////
///// input data package                                 /////
//////////////////////////////////////////////////////////////
//: my $pipe_depth = 5 -4;
//: my $i;
//: my $j;
//: if($pipe_depth == 0) {
//: print "assign wl_in_pvld = sg2wl_pvld;\n";
//: print "assign wl_in_pd = sg2wl_pd;\n";
//: } else {
//: print "assign wl_in_pvld_d0 = sg2wl_pvld;\n";
//: print "assign wl_in_pd_d0 = sg2wl_pd;\n\n";
//: for($i = 0; $i < $pipe_depth; $i ++) {
//: $j = $i + 1;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"        -d \"wl_in_pvld_d${i}\" -q wl_in_pvld_d${j}");
//: &eperl::flop("-nodeclare   -rval \"{18{1'b0}}\"  -en \"wl_in_pvld_d${i}\" -d \"wl_in_pd_d${i}\" -q wl_in_pd_d${j}");
//: }
//: print "assign wl_in_pvld = wl_in_pvld_d${i};\n";
//: print "assign wl_in_pd = wl_in_pd_d${i};\n\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign wl_in_pvld_d0 = sg2wl_pvld;
assign wl_in_pd_d0 = sg2wl_pd;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wl_in_pvld_d1 <= 1'b0;
   end else begin
       wl_in_pvld_d1 <= wl_in_pvld_d0;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wl_in_pd_d1 <= {18{1'b0}};
   end else begin
       if ((wl_in_pvld_d0) == 1'b1) begin
           wl_in_pd_d1 <= wl_in_pd_d0;
       // VCS coverage off
       end else if ((wl_in_pvld_d0) == 1'b0) begin
       end else begin
           wl_in_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
assign wl_in_pvld = wl_in_pvld_d1;
assign wl_in_pd = wl_in_pd_d1;


//| eperl: generated_end (DO NOT EDIT ABOVE)
assign wl_pvld = wl_in_pvld;
assign wl_pd = wl_in_pd;
// PKT_UNPACK_WIRE( csc_wt_pkg , wl_ , wl_pd )
assign wl_weight_size[6:0] = wl_pd[6:0];
assign wl_kernel_size[5:0] = wl_pd[12:7];
assign wl_cur_sub_h[1:0] = wl_pd[14:13];
assign wl_channel_end = wl_pd[15];
assign wl_group_end = wl_pd[16];
assign wl_wt_release = wl_pd[17];
//////////////////////////////////////////////////////////////
///// generate wmb read request                          /////
//////////////////////////////////////////////////////////////
//////////////////////////////////// generate wmb_pipe_valid siganal ////////////////////////////////////
assign {mon_stripe_cnt_inc,stripe_cnt_inc} = stripe_cnt + 1'b1;
assign stripe_cnt_w = layer_st ? 5'b0 : is_stripe_end ? 5'b0 : stripe_cnt_inc;
assign {mon_stripe_length,stripe_length} = wl_kernel_size[5:0];
assign is_stripe_end = (stripe_cnt_inc == stripe_length);
//assign is_stripe_st = wl_pvld;
assign stripe_cnt_reg_en = layer_st | wmb_pipe_valid;
assign wmb_pipe_valid = wl_pvld ? 1'b1 : ~(|stripe_cnt) ? 1'b0 : wmb_pipe_valid_d1;
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"stripe_cnt_reg_en\" -d \"stripe_cnt_w\" -q stripe_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       stripe_cnt <= {5{1'b0}};
   end else begin
       if ((stripe_cnt_reg_en) == 1'b1) begin
           stripe_cnt <= stripe_cnt_w;
       // VCS coverage off
       end else if ((stripe_cnt_reg_en) == 1'b0) begin
       end else begin
           stripe_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate wmb_req_valid siganal ////////////////////////////////////
assign wmb_element_avl_add = ~wmb_req_valid ? 11'b0 : 11'h40;
assign wmb_element_avl_sub = wmb_pipe_valid ? wmb_req_element : 8'h0;
assign {mon_wmb_element_avl_inc,wmb_element_avl_inc} = wmb_element_avl + wmb_element_avl_add - wmb_element_avl_sub;
assign wmb_element_avl_w = layer_st ? 11'b0 : (is_stripe_end & ~wl_group_end & wl_channel_end) ? wmb_element_avl_last : wmb_element_avl_inc;
assign wmb_req_ori_element = wl_weight_size;
assign wmb_req_cycle_element = {1'b0, wl_weight_size};
assign {mon_wmb_req_element,wmb_req_element} = (wl_cur_sub_h == 2'h0) ? {1'b0, wmb_req_cycle_element} :
                                          (wl_cur_sub_h == 2'h1) ? {1'b0, wmb_req_cycle_element[6:0], 1'b0} :
                                          (wl_cur_sub_h == 2'h2) ? ({wmb_req_cycle_element[6:0], 1'b0} + wmb_req_cycle_element):
                                          {1'b0, wmb_req_cycle_element[5:0], 2'b0};
assign wmb_req_valid = wmb_pipe_valid & is_compressed_d1 & (wmb_element_avl < {{3{1'b0}}, wmb_req_element});
assign wmb_element_avl_reg_en = layer_st | (wmb_pipe_valid & is_compressed_d1);
assign wmb_element_avl_last_reg_en = layer_st | (wmb_pipe_valid & is_compressed_d1 & is_stripe_end & wl_group_end);
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"wmb_element_avl_reg_en\" -d \"wmb_element_avl_w\" -q wmb_element_avl");
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"wmb_element_avl_last_reg_en\" -d \"wmb_element_avl_w\" -q wmb_element_avl_last");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_element_avl <= {11{1'b0}};
   end else begin
       if ((wmb_element_avl_reg_en) == 1'b1) begin
           wmb_element_avl <= wmb_element_avl_w;
       // VCS coverage off
       end else if ((wmb_element_avl_reg_en) == 1'b0) begin
       end else begin
           wmb_element_avl <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_element_avl_last <= {11{1'b0}};
   end else begin
       if ((wmb_element_avl_last_reg_en) == 1'b1) begin
           wmb_element_avl_last <= wmb_element_avl_w;
       // VCS coverage off
       end else if ((wmb_element_avl_last_reg_en) == 1'b0) begin
       end else begin
           wmb_element_avl_last <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate wmb read address ////////////////////////////////////
assign {mon_wmb_req_addr_inc,wmb_req_addr_inc} = wmb_req_addr + 1'b1;
assign wmb_req_addr_w = addr_init ? {{14 -9{1'b0}},wmb_entry_st_w} :
                        (is_stripe_end & wl_channel_end & ~wl_group_end) ? wmb_req_addr_last :
                        wmb_req_valid ? wmb_req_addr_inc :
                        wmb_req_addr;
assign wmb_req_addr_reg_en = is_compressed_d1 & (addr_init | wmb_req_valid | (wmb_pipe_valid & is_stripe_end & wl_channel_end));
assign wmb_req_addr_last_reg_en = is_compressed_d1 & (addr_init | (wmb_pipe_valid & is_stripe_end & wl_group_end));
//: my $kk=14;
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wmb_req_addr_reg_en\" -d \"wmb_req_addr_w\" -q wmb_req_addr");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wmb_req_addr_last_reg_en\" -d \"wmb_req_addr_w\" -q wmb_req_addr_last");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_addr <= {14{1'b0}};
   end else begin
       if ((wmb_req_addr_reg_en) == 1'b1) begin
           wmb_req_addr <= wmb_req_addr_w;
       // VCS coverage off
       end else if ((wmb_req_addr_reg_en) == 1'b0) begin
       end else begin
           wmb_req_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_addr_last <= {14{1'b0}};
   end else begin
       if ((wmb_req_addr_last_reg_en) == 1'b1) begin
           wmb_req_addr_last <= wmb_req_addr_w;
       // VCS coverage off
       end else if ((wmb_req_addr_last_reg_en) == 1'b0) begin
       end else begin
           wmb_req_addr_last <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// wmb entries counter for release ////////////////////////////////////
assign wmb_rls_cnt_vld_w = (layer_st | (wl_group_end & is_stripe_end)) ? 1'b0 : (wl_channel_end & is_stripe_end) ? 1'b1 : wmb_rls_cnt_vld;
assign {mon_wmb_rls_cnt_inc,wmb_rls_cnt_inc} = wmb_rls_cnt + 1'b1;
assign wmb_rls_cnt_w = layer_st ? 9'b0 : (is_stripe_end & wl_group_end) ? 9'b0 : wmb_rls_cnt_inc;
assign wmb_rls_cnt_reg_en = layer_st |
                            (is_compressed_d1 & wmb_pipe_valid & is_stripe_end & wl_group_end) |
                            (is_compressed_d1 & wmb_req_valid & ~wmb_rls_cnt_vld);
assign wmb_rls_entries = (wmb_rls_cnt_vld | ~wmb_req_valid) ? wmb_rls_cnt : wmb_rls_cnt_inc;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wmb_rls_cnt_vld_w\" -q wmb_rls_cnt_vld");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"wmb_rls_cnt_reg_en\" -d \"wmb_rls_cnt_w\" -q wmb_rls_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rls_cnt_vld <= 1'b0;
   end else begin
       wmb_rls_cnt_vld <= wmb_rls_cnt_vld_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rls_cnt <= {9{1'b0}};
   end else begin
       if ((wmb_rls_cnt_reg_en) == 1'b1) begin
           wmb_rls_cnt <= wmb_rls_cnt_w;
       // VCS coverage off
       end else if ((wmb_rls_cnt_reg_en) == 1'b0) begin
       end else begin
           wmb_rls_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// send wmb read request ////////////////////////////////////
//: my $kk=14;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wmb_req_valid\" -q sc2buf_wmb_rd_en");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wmb_req_valid\" -d \"wmb_req_addr\" -q sc2buf_wmb_rd_addr");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wmb_pipe_valid\" -q wmb_pipe_valid_d1");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"wmb_pipe_valid\" -d \"wmb_req_ori_element\" -q wmb_req_ori_element_d1");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"wmb_pipe_valid\" -d \"wmb_req_element\" -q wmb_req_element_d1");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"wmb_pipe_valid & wl_wt_release & is_stripe_end\" -d \"wmb_rls_entries\" -q wmb_req_rls_entries_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wmb_pipe_valid\" -d \"is_stripe_end\" -q wmb_req_stripe_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wmb_pipe_valid\" -d \"wl_channel_end & is_stripe_end\" -q wmb_req_channel_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wmb_pipe_valid\" -d \"wl_group_end & is_stripe_end\" -q wmb_req_group_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wmb_pipe_valid\" -d \"wl_wt_release & is_stripe_end\" -q wmb_req_rls_d1");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"wmb_pipe_valid\" -d \"wl_cur_sub_h\" -q wmb_req_cur_sub_h_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_wmb_rd_en <= 1'b0;
   end else begin
       sc2buf_wmb_rd_en <= wmb_req_valid;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_wmb_rd_addr <= {14{1'b0}};
   end else begin
       if ((wmb_req_valid) == 1'b1) begin
           sc2buf_wmb_rd_addr <= wmb_req_addr;
       // VCS coverage off
       end else if ((wmb_req_valid) == 1'b0) begin
       end else begin
           sc2buf_wmb_rd_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_pipe_valid_d1 <= 1'b0;
   end else begin
       wmb_pipe_valid_d1 <= wmb_pipe_valid;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_ori_element_d1 <= {7{1'b0}};
   end else begin
       if ((wmb_pipe_valid) == 1'b1) begin
           wmb_req_ori_element_d1 <= wmb_req_ori_element;
       // VCS coverage off
       end else if ((wmb_pipe_valid) == 1'b0) begin
       end else begin
           wmb_req_ori_element_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_element_d1 <= {8{1'b0}};
   end else begin
       if ((wmb_pipe_valid) == 1'b1) begin
           wmb_req_element_d1 <= wmb_req_element;
       // VCS coverage off
       end else if ((wmb_pipe_valid) == 1'b0) begin
       end else begin
           wmb_req_element_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_rls_entries_d1 <= {9{1'b0}};
   end else begin
       if ((wmb_pipe_valid & wl_wt_release & is_stripe_end) == 1'b1) begin
           wmb_req_rls_entries_d1 <= wmb_rls_entries;
       // VCS coverage off
       end else if ((wmb_pipe_valid & wl_wt_release & is_stripe_end) == 1'b0) begin
       end else begin
           wmb_req_rls_entries_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_stripe_end_d1 <= 1'b0;
   end else begin
       if ((wmb_pipe_valid) == 1'b1) begin
           wmb_req_stripe_end_d1 <= is_stripe_end;
       // VCS coverage off
       end else if ((wmb_pipe_valid) == 1'b0) begin
       end else begin
           wmb_req_stripe_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_channel_end_d1 <= 1'b0;
   end else begin
       if ((wmb_pipe_valid) == 1'b1) begin
           wmb_req_channel_end_d1 <= wl_channel_end & is_stripe_end;
       // VCS coverage off
       end else if ((wmb_pipe_valid) == 1'b0) begin
       end else begin
           wmb_req_channel_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_group_end_d1 <= 1'b0;
   end else begin
       if ((wmb_pipe_valid) == 1'b1) begin
           wmb_req_group_end_d1 <= wl_group_end & is_stripe_end;
       // VCS coverage off
       end else if ((wmb_pipe_valid) == 1'b0) begin
       end else begin
           wmb_req_group_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_rls_d1 <= 1'b0;
   end else begin
       if ((wmb_pipe_valid) == 1'b1) begin
           wmb_req_rls_d1 <= wl_wt_release & is_stripe_end;
       // VCS coverage off
       end else if ((wmb_pipe_valid) == 1'b0) begin
       end else begin
           wmb_req_rls_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_req_cur_sub_h_d1 <= {2{1'b0}};
   end else begin
       if ((wmb_pipe_valid) == 1'b1) begin
           wmb_req_cur_sub_h_d1 <= wl_cur_sub_h;
       // VCS coverage off
       end else if ((wmb_pipe_valid) == 1'b0) begin
       end else begin
           wmb_req_cur_sub_h_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// sideband pipeline for wmb read                     /////
//////////////////////////////////////////////////////////////
assign wmb_req_pipe_pvld = wmb_pipe_valid_d1;
assign wmb_req_d1_stripe_end = wmb_req_stripe_end_d1;
assign wmb_req_d1_channel_end = wmb_req_channel_end_d1;
assign wmb_req_d1_group_end = wmb_req_group_end_d1;
assign wmb_req_d1_rls = wmb_req_rls_d1;
assign wmb_req_d1_cur_sub_h = wmb_req_cur_sub_h_d1;
assign wmb_req_d1_element = wmb_req_element_d1;
assign wmb_req_d1_ori_element = wmb_req_ori_element_d1;
assign wmb_req_d1_rls_entries = wmb_req_rls_entries_d1;
// PKT_PACK_WIRE( csc_wmb_req_pkg , wmb_req_d1_ , wmb_req_pipe_pd )
assign wmb_req_pipe_pd[6:0] = wmb_req_d1_ori_element[6:0];
assign wmb_req_pipe_pd[14:7] = wmb_req_d1_element[7:0];
assign wmb_req_pipe_pd[23:15] = wmb_req_d1_rls_entries[8:0];
assign wmb_req_pipe_pd[24] = wmb_req_d1_stripe_end ;
assign wmb_req_pipe_pd[25] = wmb_req_d1_channel_end ;
assign wmb_req_pipe_pd[26] = wmb_req_d1_group_end ;
assign wmb_req_pipe_pd[27] = wmb_req_d1_rls ;
assign wmb_req_pipe_pd[28] = 1'b0 ;
assign wmb_req_pipe_pd[30:29] = wmb_req_d1_cur_sub_h[1:0];
//: my $pipe_depth = 6;
//: my $i;
//: my $j;
//: if($pipe_depth == 0) {
//: print "assign wmb_rsp_pipe_pvld = wmb_req_pipe_pvld;\n";
//: print "assign wmb_rsp_pipe_pd = wmb_req_pipe_pd;\n\n";
//: } else {
//: print "assign wmb_rsp_pipe_pvld_d0 = wmb_req_pipe_pvld;\n";
//: print "assign wmb_rsp_pipe_pd_d0 = wmb_req_pipe_pd;\n\n";
//: for($i = 0; $i < $pipe_depth; $i ++) {
//: $j = $i + 1;
//: &eperl::flop("-wid 1    -rval \"1'b0\"       -d \"wmb_rsp_pipe_pvld_d${i}\"  -q wmb_rsp_pipe_pvld_d${j}");
//: &eperl::flop("-wid 31   -rval \"{31{1'b0}}\" -en \"wmb_rsp_pipe_pvld_d${i}\" -d \"wmb_rsp_pipe_pd_d${i}\" -q wmb_rsp_pipe_pd_d${j}");
//: }
//: print "assign wmb_rsp_pipe_pvld = wmb_rsp_pipe_pvld_d${i};\n";
//: print "assign wmb_rsp_pipe_pd = wmb_rsp_pipe_pd_d${i};\n\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign wmb_rsp_pipe_pvld_d0 = wmb_req_pipe_pvld;
assign wmb_rsp_pipe_pd_d0 = wmb_req_pipe_pd;

reg  wmb_rsp_pipe_pvld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pvld_d1 <= 1'b0;
   end else begin
       wmb_rsp_pipe_pvld_d1 <= wmb_rsp_pipe_pvld_d0;
   end
end
reg [30:0] wmb_rsp_pipe_pd_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pd_d1 <= {31{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld_d0) == 1'b1) begin
           wmb_rsp_pipe_pd_d1 <= wmb_rsp_pipe_pd_d0;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld_d0) == 1'b0) begin
       end else begin
           wmb_rsp_pipe_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wmb_rsp_pipe_pvld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pvld_d2 <= 1'b0;
   end else begin
       wmb_rsp_pipe_pvld_d2 <= wmb_rsp_pipe_pvld_d1;
   end
end
reg [30:0] wmb_rsp_pipe_pd_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pd_d2 <= {31{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld_d1) == 1'b1) begin
           wmb_rsp_pipe_pd_d2 <= wmb_rsp_pipe_pd_d1;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld_d1) == 1'b0) begin
       end else begin
           wmb_rsp_pipe_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wmb_rsp_pipe_pvld_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pvld_d3 <= 1'b0;
   end else begin
       wmb_rsp_pipe_pvld_d3 <= wmb_rsp_pipe_pvld_d2;
   end
end
reg [30:0] wmb_rsp_pipe_pd_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pd_d3 <= {31{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld_d2) == 1'b1) begin
           wmb_rsp_pipe_pd_d3 <= wmb_rsp_pipe_pd_d2;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld_d2) == 1'b0) begin
       end else begin
           wmb_rsp_pipe_pd_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wmb_rsp_pipe_pvld_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pvld_d4 <= 1'b0;
   end else begin
       wmb_rsp_pipe_pvld_d4 <= wmb_rsp_pipe_pvld_d3;
   end
end
reg [30:0] wmb_rsp_pipe_pd_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pd_d4 <= {31{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld_d3) == 1'b1) begin
           wmb_rsp_pipe_pd_d4 <= wmb_rsp_pipe_pd_d3;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld_d3) == 1'b0) begin
       end else begin
           wmb_rsp_pipe_pd_d4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wmb_rsp_pipe_pvld_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pvld_d5 <= 1'b0;
   end else begin
       wmb_rsp_pipe_pvld_d5 <= wmb_rsp_pipe_pvld_d4;
   end
end
reg [30:0] wmb_rsp_pipe_pd_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pd_d5 <= {31{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld_d4) == 1'b1) begin
           wmb_rsp_pipe_pd_d5 <= wmb_rsp_pipe_pd_d4;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld_d4) == 1'b0) begin
       end else begin
           wmb_rsp_pipe_pd_d5 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wmb_rsp_pipe_pvld_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pvld_d6 <= 1'b0;
   end else begin
       wmb_rsp_pipe_pvld_d6 <= wmb_rsp_pipe_pvld_d5;
   end
end
reg [30:0] wmb_rsp_pipe_pd_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_pipe_pd_d6 <= {31{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld_d5) == 1'b1) begin
           wmb_rsp_pipe_pd_d6 <= wmb_rsp_pipe_pd_d5;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld_d5) == 1'b0) begin
       end else begin
           wmb_rsp_pipe_pd_d6 <= 'bx;
       // VCS coverage on
       end
   end
end
assign wmb_rsp_pipe_pvld = wmb_rsp_pipe_pvld_d6;
assign wmb_rsp_pipe_pd = wmb_rsp_pipe_pd_d6;


//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// wmb data process                                   /////
//////////////////////////////////////////////////////////////
// PKT_UNPACK_WIRE( csc_wmb_req_pkg , wmb_rsp_ , wmb_rsp_pipe_pd )
assign wmb_rsp_ori_element[6:0] = wmb_rsp_pipe_pd[6:0];
assign wmb_rsp_element[7:0] = wmb_rsp_pipe_pd[14:7];
assign wmb_rsp_rls_entries[8:0] = wmb_rsp_pipe_pd[23:15];
assign wmb_rsp_stripe_end = wmb_rsp_pipe_pd[24];
assign wmb_rsp_channel_end = wmb_rsp_pipe_pd[25];
assign wmb_rsp_group_end = wmb_rsp_pipe_pd[26];
assign wmb_rsp_rls = wmb_rsp_pipe_pd[27];
assign wmb_rsp_cur_sub_h[1:0] = wmb_rsp_pipe_pd[30:29];
//////////////////////////////////// wmb remain counter ////////////////////////////////////
assign wmb_rsp_bit_remain_add = sc2buf_wmb_rd_valid ? 11'h40 : 11'h0;
assign wmb_rsp_bit_remain_sub = wmb_rsp_pipe_pvld ? wmb_rsp_element : 8'b0;
//how many mask bits is stored currently
assign {mon_wmb_rsp_bit_remain_w,wmb_rsp_bit_remain_w} = (layer_st) ? 11'b0 :
                               (wmb_rsp_channel_end & ~wmb_rsp_group_end) ? {2'b0, wmb_rsp_bit_remain_last} :
                               wmb_rsp_bit_remain + wmb_rsp_bit_remain_add - wmb_rsp_bit_remain_sub;
assign wmb_rsp_bit_remain_last_reg_en = layer_st | (wmb_rsp_pipe_pvld & wmb_rsp_group_end & is_compressed_d1);
//: &eperl::flop("-nodeclare   -rval \"{10{1'b0}}\"  -en \"layer_st | (wmb_rsp_pipe_pvld & is_compressed_d1)\" -d \"wmb_rsp_bit_remain_w\" -q wmb_rsp_bit_remain");
//: &eperl::flop("-nodeclare   -rval \"{10{1'b0}}\"  -en \"wmb_rsp_bit_remain_last_reg_en\" -d \"wmb_rsp_bit_remain_w\" -q wmb_rsp_bit_remain_last");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_bit_remain <= {10{1'b0}};
   end else begin
       if ((layer_st | (wmb_rsp_pipe_pvld & is_compressed_d1)) == 1'b1) begin
           wmb_rsp_bit_remain <= wmb_rsp_bit_remain_w;
       // VCS coverage off
       end else if ((layer_st | (wmb_rsp_pipe_pvld & is_compressed_d1)) == 1'b0) begin
       end else begin
           wmb_rsp_bit_remain <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_rsp_bit_remain_last <= {10{1'b0}};
   end else begin
       if ((wmb_rsp_bit_remain_last_reg_en) == 1'b1) begin
           wmb_rsp_bit_remain_last <= wmb_rsp_bit_remain_w;
       // VCS coverage off
       end else if ((wmb_rsp_bit_remain_last_reg_en) == 1'b0) begin
       end else begin
           wmb_rsp_bit_remain_last <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate element mask for both compressed and compressed case ////////////////////////////////////
//emask for element mask, NOT byte mask
assign wmb_emask_rd_ls = ~sc2buf_wmb_rd_valid ? {8{1'b0}} : (sc2buf_wmb_rd_data[8 -1:0] << wmb_rsp_bit_remain[6:0]);
assign wmb_rsp_emask_in = (wmb_emask_rd_ls | wmb_emask_remain[8 -1:0] | {8{~is_compressed_d1}}); //wmb for current atomic op
assign wmb_rsp_vld_s = ~({8{1'b1}} << wmb_rsp_element);
assign wmb_rsp_emask = wmb_rsp_emask_in[8 -1:0] & wmb_rsp_vld_s; //the mask needed
//: my $kk=8;
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_emask\" -q wt_req_emask");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_emask <= {8{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_emask <= wmb_rsp_emask;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_emask <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate local remain masks ////////////////////////////////////
assign {mon_wmb_shift_remain,wmb_shift_remain} = wmb_rsp_element - wmb_rsp_bit_remain[6:0];
assign wmb_emask_rd_rs = (sc2buf_wmb_rd_data >> wmb_shift_remain); //read 1 entry wmb and be partial used
assign wmb_emask_remain_rs = (wmb_emask_remain >> wmb_rsp_element); //remain wmb and partial used
//all wmb remain, no more than 1 entry
assign wmb_emask_remain_w = layer_st ? {64{1'b0}} :
                            (wmb_rsp_channel_end & ~wmb_rsp_group_end) ? wmb_emask_remain_last :
                            sc2buf_wmb_rd_valid ? wmb_emask_rd_rs :
                            wmb_emask_remain_rs;
assign wmb_emask_remain_reg_en = layer_st | (wmb_rsp_pipe_pvld & is_compressed_d1);
assign wmb_emask_remain_last_reg_en = layer_st | (wmb_rsp_pipe_pvld & wmb_rsp_group_end & is_compressed_d1);
assign wmb_rsp_ori_sft_3 = {wmb_rsp_ori_element[4:0], 1'b0} + wmb_rsp_ori_element[4:0];
//: my $kk=64;
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wmb_emask_remain_reg_en\" -d \"wmb_emask_remain_w\" -q wmb_emask_remain");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wmb_emask_remain_last_reg_en\" -d \"wmb_emask_remain_w\" -q wmb_emask_remain_last");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_emask_remain <= {64{1'b0}};
   end else begin
       if ((wmb_emask_remain_reg_en) == 1'b1) begin
           wmb_emask_remain <= wmb_emask_remain_w;
       // VCS coverage off
       end else if ((wmb_emask_remain_reg_en) == 1'b0) begin
       end else begin
           wmb_emask_remain <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wmb_emask_remain_last <= {64{1'b0}};
   end else begin
       if ((wmb_emask_remain_last_reg_en) == 1'b1) begin
           wmb_emask_remain_last <= wmb_emask_remain_w;
       // VCS coverage off
       end else if ((wmb_emask_remain_last_reg_en) == 1'b0) begin
       end else begin
           wmb_emask_remain_last <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// registers for pipeline ////////////////////////////////////
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wmb_rsp_pipe_pvld\" -q wt_req_pipe_valid");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_ori_element\" -q wt_req_ori_element");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_stripe_end\" -q wt_req_stripe_end");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_channel_end\" -q wt_req_channel_end");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_group_end\" -q wt_req_group_end");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_rls\" -q wt_req_rls");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_rls_entries\" -q wt_req_wmb_rls_entries");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_cur_sub_h\" -q wt_req_cur_sub_h");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"wmb_rsp_pipe_pvld\" -d \"wmb_rsp_ori_sft_3\" -q wt_req_ori_sft_3");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_pipe_valid <= 1'b0;
   end else begin
       wt_req_pipe_valid <= wmb_rsp_pipe_pvld;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_ori_element <= {7{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_ori_element <= wmb_rsp_ori_element;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_ori_element <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_stripe_end <= 1'b0;
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_stripe_end <= wmb_rsp_stripe_end;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_stripe_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_channel_end <= 1'b0;
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_channel_end <= wmb_rsp_channel_end;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_channel_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_group_end <= 1'b0;
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_group_end <= wmb_rsp_group_end;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_group_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_rls <= 1'b0;
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_rls <= wmb_rsp_rls;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_rls <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_wmb_rls_entries <= {9{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_wmb_rls_entries <= wmb_rsp_rls_entries;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_wmb_rls_entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_cur_sub_h <= {2{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_cur_sub_h <= wmb_rsp_cur_sub_h;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_cur_sub_h <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_ori_sft_3 <= {7{1'b0}};
   end else begin
       if ((wmb_rsp_pipe_pvld) == 1'b1) begin
           wt_req_ori_sft_3 <= wmb_rsp_ori_sft_3;
       // VCS coverage off
       end else if ((wmb_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_req_ori_sft_3 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// weight data request generate                       /////
//////////////////////////////////////////////////////////////
//////////////////////////////////// generate mask sum ////////////////////////////////////
////CAUSION! wt_req_bmask is byte mask, not elemnet mask!////
assign wt_req_bmask = wt_req_emask;
//: print "assign wt_req_bytes =  \n";
//: my $j=int(8/4);
//: for(my $i=0; $i<$j; $i++){
//: print "wt_req_bmask[4*${i}+0] + wt_req_bmask[4*${i}+1] + wt_req_bmask[4*${i}+2] + wt_req_bmask[4*${i}+3] + \n";
//: }
//: print "1'b0; \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign wt_req_bytes =  
wt_req_bmask[4*0+0] + wt_req_bmask[4*0+1] + wt_req_bmask[4*0+2] + wt_req_bmask[4*0+3] + 
wt_req_bmask[4*1+0] + wt_req_bmask[4*1+1] + wt_req_bmask[4*1+2] + wt_req_bmask[4*1+3] + 
1'b0; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate element mask for decoding////////////////////////////////////
//valid bit for each sub h line
assign wt_req_vld_bit = ~({8{1'b1}} << wt_req_ori_element);
//valid bit to select sub h line
//: my $kk=8;
//: print qq(
//: assign sub_h_mask_1 = (wt_req_cur_sub_h >= 2'h1) ? {${kk}{1'b1}} : {${kk}{1'h0}};
//: assign sub_h_mask_2 = (wt_req_cur_sub_h >= 2'h2) ? {${kk}{1'b1}} : {${kk}{1'h0}};
//: assign sub_h_mask_3 = (wt_req_cur_sub_h == 2'h3) ? {${kk}{1'b1}} : {${kk}{1'h0}};
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign sub_h_mask_1 = (wt_req_cur_sub_h >= 2'h1) ? {8{1'b1}} : {8{1'h0}};
assign sub_h_mask_2 = (wt_req_cur_sub_h >= 2'h2) ? {8{1'b1}} : {8{1'h0}};
assign sub_h_mask_3 = (wt_req_cur_sub_h == 2'h3) ? {8{1'b1}} : {8{1'h0}};

//| eperl: generated_end (DO NOT EDIT ABOVE)
//element number to be shifted
assign wt_req_ori_sft_1 = wt_req_ori_element;
assign wt_req_ori_sft_2 = {wt_req_ori_element[5:0], 1'b0};
assign wt_req_emask_p0 = wt_req_emask[8 -1:0] & wt_req_vld_bit;
assign wt_req_emask_p1 = (wt_req_emask[8 -1:0] >> wt_req_ori_sft_1) & wt_req_vld_bit & sub_h_mask_1;
assign wt_req_emask_p2 = (wt_req_emask[8 -1:0] >> wt_req_ori_sft_2) & wt_req_vld_bit & sub_h_mask_2;
assign wt_req_emask_p3 = (wt_req_emask[8 -1:0] >> wt_req_ori_sft_3) & wt_req_vld_bit & sub_h_mask_3;
//Caution! Must reset wt_req_mask to all zero when layer started
//other width wt_req_mask_en may gate wt_rsp_mask_d1_w improperly!
assign wt_req_mask_w = layer_st ? {8{1'b0}} :
                       (sub_h_total == 3'h1) ? {wt_req_emask_p0} :
                       (sub_h_total == 3'h2) ? {wt_req_emask_p1[8/2-1:0], wt_req_emask_p0[8/2-1:0]} :
                       {wt_req_emask_p3[8/4-1:0], wt_req_emask_p2[8/4-1:0], wt_req_emask_p1[8/4-1:0], wt_req_emask_p0[8/4-1:0]};
//assign wt_req_mask_w = layer_st ? {8{1'b0}} : wt_req_emask_p0; //need update for image 
assign wt_req_mask_en = wt_req_pipe_valid & (wt_req_mask_w != wt_req_mask_d1);
//////////////////////////////////// generate weight read request ////////////////////////////////////
assign wt_req_valid = wt_req_pipe_valid & (wt_byte_avl < wt_req_bytes);
//////////////////////////////////// generate weight avaliable bytes ////////////////////////////////////
assign wt_byte_avl_add = ~wt_req_valid ? 8'b0 : 7'h8;
assign wt_byte_avl_sub = wt_req_bytes;
assign {mon_wt_byte_avl_inc,wt_byte_avl_inc} = wt_byte_avl + wt_byte_avl_add - wt_byte_avl_sub;
assign wt_byte_avl_w = layer_st ? 8'b0 : ( ~wt_req_group_end & wt_req_channel_end) ? wt_byte_avl_last : wt_byte_avl_inc;
assign wt_byte_last_reg_en = layer_st | (wt_req_pipe_valid & wt_req_stripe_end & wt_req_group_end);
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"layer_st | wt_req_pipe_valid\" -d \"wt_byte_avl_w\" -q wt_byte_avl");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"wt_byte_last_reg_en\" -d \"wt_byte_avl_w\" -q wt_byte_avl_last");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_byte_avl <= {8{1'b0}};
   end else begin
       if ((layer_st | wt_req_pipe_valid) == 1'b1) begin
           wt_byte_avl <= wt_byte_avl_w;
       // VCS coverage off
       end else if ((layer_st | wt_req_pipe_valid) == 1'b0) begin
       end else begin
           wt_byte_avl <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_byte_avl_last <= {8{1'b0}};
   end else begin
       if ((wt_byte_last_reg_en) == 1'b1) begin
           wt_byte_avl_last <= wt_byte_avl_w;
       // VCS coverage off
       end else if ((wt_byte_last_reg_en) == 1'b0) begin
       end else begin
           wt_byte_avl_last <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate weight read address ////////////////////////////////////
assign {mon_wt_req_addr_inc,wt_req_addr_inc} = wt_req_addr + 1'b1;
assign is_wr_req_addr_wrap = (wt_req_addr_inc == {weight_bank, {9{1'b0}}});
assign wt_req_addr_inc_wrap = is_wr_req_addr_wrap ? {14{1'b0}} : wt_req_addr_inc;
assign wt_req_addr_w = addr_init ? wt_entry_st_w[14 -1:0] :
                       (wt_req_channel_end & ~wt_req_group_end) ? wt_req_addr_last :
                       wt_req_valid ? wt_req_addr_inc_wrap :
                       wt_req_addr;
assign wt_req_addr_reg_en = addr_init | wt_req_valid | (wt_req_pipe_valid & wt_req_channel_end);
assign wt_req_addr_last_reg_en = addr_init | (wt_req_pipe_valid & wt_req_pipe_valid & wt_req_group_end);
assign {mon_wt_req_addr_out,wt_req_addr_out} = wt_req_addr + {data_bank, {9{1'b0}}};
//: my $kk=14;
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wt_req_addr_reg_en\" -d \"wt_req_addr_w\" -q wt_req_addr");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wt_req_addr_last_reg_en\" -d \"wt_req_addr_w\" -q wt_req_addr_last");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_addr <= {14{1'b0}};
   end else begin
       if ((wt_req_addr_reg_en) == 1'b1) begin
           wt_req_addr <= wt_req_addr_w;
       // VCS coverage off
       end else if ((wt_req_addr_reg_en) == 1'b0) begin
       end else begin
           wt_req_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_addr_last <= {14{1'b0}};
   end else begin
       if ((wt_req_addr_last_reg_en) == 1'b1) begin
           wt_req_addr_last <= wt_req_addr_w;
       // VCS coverage off
       end else if ((wt_req_addr_last_reg_en) == 1'b0) begin
       end else begin
           wt_req_addr_last <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// weight entries counter for release ////////////////////////////////////
assign wt_rls_cnt_vld_w = (layer_st | wt_req_group_end) ? 1'b0 : wt_req_channel_end ? 1'b1 : wt_rls_cnt_vld;
assign {mon_wt_rls_cnt_inc,wt_rls_cnt_inc} = wt_rls_cnt + 1'b1;
assign wt_rls_cnt_w = layer_st ? {15{1'b0}} : wt_req_group_end ? {15{1'b0}} : wt_rls_cnt_inc;
assign wt_rls_cnt_reg_en = layer_st | (wt_req_pipe_valid & wt_req_group_end) | (~wt_rls_cnt_vld & wt_req_valid);
assign wt_rls_entries = (wt_rls_cnt_vld | ~wt_req_valid) ? wt_rls_cnt : wt_rls_cnt_inc;
//: my $kk=15;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wt_rls_cnt_vld_w\" -q wt_rls_cnt_vld");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wt_rls_cnt_reg_en\" -d \"wt_rls_cnt_w\" -q wt_rls_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rls_cnt_vld <= 1'b0;
   end else begin
       wt_rls_cnt_vld <= wt_rls_cnt_vld_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rls_cnt <= {15{1'b0}};
   end else begin
       if ((wt_rls_cnt_reg_en) == 1'b1) begin
           wt_rls_cnt <= wt_rls_cnt_w;
       // VCS coverage off
       end else if ((wt_rls_cnt_reg_en) == 1'b0) begin
       end else begin
           wt_rls_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// send weight read request ////////////////////////////////////
//: my $kk=14;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wt_req_valid\" -q sc2buf_wt_rd_en");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wt_req_valid\" -d \"wt_req_addr_out\" -q sc2buf_wt_rd_addr");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wt_req_pipe_valid\" -q wt_req_pipe_valid_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wt_req_pipe_valid\" -d \"wt_req_stripe_end\" -q wt_req_stripe_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wt_req_pipe_valid\" -d \"wt_req_channel_end\" -q wt_req_channel_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wt_req_pipe_valid\" -d \"wt_req_group_end\" -q wt_req_group_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"wt_req_pipe_valid\" -d \"wt_req_rls\" -q wt_req_rls_d1");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"wt_req_pipe_valid\" -d \"wt_req_bytes\" -q wt_req_bytes_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_wt_rd_en <= 1'b0;
   end else begin
       sc2buf_wt_rd_en <= wt_req_valid;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_wt_rd_addr <= {14{1'b0}};
   end else begin
       if ((wt_req_valid) == 1'b1) begin
           sc2buf_wt_rd_addr <= wt_req_addr_out;
       // VCS coverage off
       end else if ((wt_req_valid) == 1'b0) begin
       end else begin
           sc2buf_wt_rd_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_pipe_valid_d1 <= 1'b0;
   end else begin
       wt_req_pipe_valid_d1 <= wt_req_pipe_valid;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_stripe_end_d1 <= 1'b0;
   end else begin
       if ((wt_req_pipe_valid) == 1'b1) begin
           wt_req_stripe_end_d1 <= wt_req_stripe_end;
       // VCS coverage off
       end else if ((wt_req_pipe_valid) == 1'b0) begin
       end else begin
           wt_req_stripe_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_channel_end_d1 <= 1'b0;
   end else begin
       if ((wt_req_pipe_valid) == 1'b1) begin
           wt_req_channel_end_d1 <= wt_req_channel_end;
       // VCS coverage off
       end else if ((wt_req_pipe_valid) == 1'b0) begin
       end else begin
           wt_req_channel_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_group_end_d1 <= 1'b0;
   end else begin
       if ((wt_req_pipe_valid) == 1'b1) begin
           wt_req_group_end_d1 <= wt_req_group_end;
       // VCS coverage off
       end else if ((wt_req_pipe_valid) == 1'b0) begin
       end else begin
           wt_req_group_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_rls_d1 <= 1'b0;
   end else begin
       if ((wt_req_pipe_valid) == 1'b1) begin
           wt_req_rls_d1 <= wt_req_rls;
       // VCS coverage off
       end else if ((wt_req_pipe_valid) == 1'b0) begin
       end else begin
           wt_req_rls_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_bytes_d1 <= {8{1'b0}};
   end else begin
       if ((wt_req_pipe_valid) == 1'b1) begin
           wt_req_bytes_d1 <= wt_req_bytes;
       // VCS coverage off
       end else if ((wt_req_pipe_valid) == 1'b0) begin
       end else begin
           wt_req_bytes_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//Caution! Here wt_req_mask is still element mask
//: my $kk=8;
//: my $jj=15;
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"layer_st | wt_req_pipe_valid\" -d \"wt_req_mask_w\" -q wt_req_mask_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wt_req_mask_en\" -q wt_req_mask_en_d1");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"wt_req_pipe_valid\" -d \"wt_req_wmb_rls_entries\" -q wt_req_wmb_rls_entries_d1");
//: &eperl::flop("-nodeclare   -rval \"{${jj}{1'b0}}\"  -en \"wt_req_pipe_valid & wt_req_rls\" -d \"wt_rls_entries\" -q wt_req_wt_rls_entries_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_mask_d1 <= {8{1'b0}};
   end else begin
       if ((layer_st | wt_req_pipe_valid) == 1'b1) begin
           wt_req_mask_d1 <= wt_req_mask_w;
       // VCS coverage off
       end else if ((layer_st | wt_req_pipe_valid) == 1'b0) begin
       end else begin
           wt_req_mask_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_mask_en_d1 <= 1'b0;
   end else begin
       wt_req_mask_en_d1 <= wt_req_mask_en;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_wmb_rls_entries_d1 <= {9{1'b0}};
   end else begin
       if ((wt_req_pipe_valid) == 1'b1) begin
           wt_req_wmb_rls_entries_d1 <= wt_req_wmb_rls_entries;
       // VCS coverage off
       end else if ((wt_req_pipe_valid) == 1'b0) begin
       end else begin
           wt_req_wmb_rls_entries_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_req_wt_rls_entries_d1 <= {15{1'b0}};
   end else begin
       if ((wt_req_pipe_valid & wt_req_rls) == 1'b1) begin
           wt_req_wt_rls_entries_d1 <= wt_rls_entries;
       // VCS coverage off
       end else if ((wt_req_pipe_valid & wt_req_rls) == 1'b0) begin
       end else begin
           wt_req_wt_rls_entries_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// sideband pipeline for wmb read                     /////
//////////////////////////////////////////////////////////////
assign wt_req_pipe_pvld = wt_req_pipe_valid_d1;
assign wt_req_d1_stripe_end = wt_req_stripe_end_d1;
assign wt_req_d1_channel_end = wt_req_channel_end_d1;
assign wt_req_d1_group_end = wt_req_group_end_d1;
assign wt_req_d1_rls = wt_req_rls_d1;
assign wt_req_d1_bytes = wt_req_bytes_d1;
assign wt_req_d1_wmb_rls_entries = wt_req_wmb_rls_entries_d1;
assign wt_req_d1_wt_rls_entries = wt_req_wt_rls_entries_d1;
// PKT_PACK_WIRE( csc_wt_req_pkg , wt_req_d1_ , wt_req_pipe_pd )
assign wt_req_pipe_pd[7:0] = wt_req_d1_bytes[7:0];
assign wt_req_pipe_pd[16:8] = wt_req_d1_wmb_rls_entries[8:0];
assign wt_req_pipe_pd[31:17] = wt_req_d1_wt_rls_entries[14:0];
assign wt_req_pipe_pd[32] = wt_req_d1_stripe_end ;
assign wt_req_pipe_pd[33] = wt_req_d1_channel_end ;
assign wt_req_pipe_pd[34] = wt_req_d1_group_end ;
assign wt_req_pipe_pd[35] = wt_req_d1_rls ;
//: my $pipe_depth = 6;
//: my $i;
//: my $j;
//: my $kk=8;
//: if($pipe_depth == 0) {
//: print "assign wt_rsp_pipe_pvld = wt_req_pipe_pvld;\n";
//: print "assign wt_rsp_pipe_pd = wt_req_pipe_pd;\n";
//: print "assign wt_rsp_mask_en = wt_req_mask_en_d1;\n";
//: print "assign wt_rsp_mask = wt_req_mask_d1;\n\n\n\n";
//: } else {
//: print "assign wt_rsp_pipe_pvld_d0 = wt_req_pipe_pvld;\n";
//: print "assign wt_rsp_pipe_pd_d0 = wt_req_pipe_pd;\n";
//: print "assign wt_rsp_mask_en_d0 = wt_req_mask_en_d1;\n";
//: print "assign wt_rsp_mask_d0 = wt_req_mask_d1;\n\n";
//: for($i = 0; $i < $pipe_depth; $i ++) {
//: $j = $i + 1;
//: &eperl::flop("-wid 1   -rval \"1'b0\"           -d \"wt_rsp_pipe_pvld_d${i}\"   -q wt_rsp_pipe_pvld_d${j}");
//: &eperl::flop("-wid 36  -rval \"{36{1'b0}}\"     -en \"wt_rsp_pipe_pvld_d${i}\"  -d \"wt_rsp_pipe_pd_d${i}\" -q wt_rsp_pipe_pd_d${j}");
//: &eperl::flop("-wid 1   -rval \"1'b0\"           -d \"wt_rsp_mask_en_d${i}\"     -q wt_rsp_mask_en_d${j}");
//: &eperl::flop("-wid ${kk} -rval \"{${kk}{1'b0}}\"    -en \"wt_rsp_mask_en_d${i}\"    -d \"wt_rsp_mask_d${i}\" -q wt_rsp_mask_d${j}");
//: }
//: print "assign wt_rsp_pipe_pvld = wt_rsp_pipe_pvld_d${i};\n";
//: print "assign wt_rsp_pipe_pd = wt_rsp_pipe_pd_d${i};\n\n";
//: print "assign wt_rsp_mask_en = wt_rsp_mask_en_d${i};\n";
//: print "assign wt_rsp_mask = wt_rsp_mask_d${i};\n\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign wt_rsp_pipe_pvld_d0 = wt_req_pipe_pvld;
assign wt_rsp_pipe_pd_d0 = wt_req_pipe_pd;
assign wt_rsp_mask_en_d0 = wt_req_mask_en_d1;
assign wt_rsp_mask_d0 = wt_req_mask_d1;

reg  wt_rsp_pipe_pvld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pvld_d1 <= 1'b0;
   end else begin
       wt_rsp_pipe_pvld_d1 <= wt_rsp_pipe_pvld_d0;
   end
end
reg [35:0] wt_rsp_pipe_pd_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pd_d1 <= {36{1'b0}};
   end else begin
       if ((wt_rsp_pipe_pvld_d0) == 1'b1) begin
           wt_rsp_pipe_pd_d1 <= wt_rsp_pipe_pd_d0;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld_d0) == 1'b0) begin
       end else begin
           wt_rsp_pipe_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_mask_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_en_d1 <= 1'b0;
   end else begin
       wt_rsp_mask_en_d1 <= wt_rsp_mask_en_d0;
   end
end
reg [7:0] wt_rsp_mask_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_d1 <= {8{1'b0}};
   end else begin
       if ((wt_rsp_mask_en_d0) == 1'b1) begin
           wt_rsp_mask_d1 <= wt_rsp_mask_d0;
       // VCS coverage off
       end else if ((wt_rsp_mask_en_d0) == 1'b0) begin
       end else begin
           wt_rsp_mask_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_pipe_pvld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pvld_d2 <= 1'b0;
   end else begin
       wt_rsp_pipe_pvld_d2 <= wt_rsp_pipe_pvld_d1;
   end
end
reg [35:0] wt_rsp_pipe_pd_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pd_d2 <= {36{1'b0}};
   end else begin
       if ((wt_rsp_pipe_pvld_d1) == 1'b1) begin
           wt_rsp_pipe_pd_d2 <= wt_rsp_pipe_pd_d1;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld_d1) == 1'b0) begin
       end else begin
           wt_rsp_pipe_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_mask_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_en_d2 <= 1'b0;
   end else begin
       wt_rsp_mask_en_d2 <= wt_rsp_mask_en_d1;
   end
end
reg [7:0] wt_rsp_mask_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_d2 <= {8{1'b0}};
   end else begin
       if ((wt_rsp_mask_en_d1) == 1'b1) begin
           wt_rsp_mask_d2 <= wt_rsp_mask_d1;
       // VCS coverage off
       end else if ((wt_rsp_mask_en_d1) == 1'b0) begin
       end else begin
           wt_rsp_mask_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_pipe_pvld_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pvld_d3 <= 1'b0;
   end else begin
       wt_rsp_pipe_pvld_d3 <= wt_rsp_pipe_pvld_d2;
   end
end
reg [35:0] wt_rsp_pipe_pd_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pd_d3 <= {36{1'b0}};
   end else begin
       if ((wt_rsp_pipe_pvld_d2) == 1'b1) begin
           wt_rsp_pipe_pd_d3 <= wt_rsp_pipe_pd_d2;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld_d2) == 1'b0) begin
       end else begin
           wt_rsp_pipe_pd_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_mask_en_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_en_d3 <= 1'b0;
   end else begin
       wt_rsp_mask_en_d3 <= wt_rsp_mask_en_d2;
   end
end
reg [7:0] wt_rsp_mask_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_d3 <= {8{1'b0}};
   end else begin
       if ((wt_rsp_mask_en_d2) == 1'b1) begin
           wt_rsp_mask_d3 <= wt_rsp_mask_d2;
       // VCS coverage off
       end else if ((wt_rsp_mask_en_d2) == 1'b0) begin
       end else begin
           wt_rsp_mask_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_pipe_pvld_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pvld_d4 <= 1'b0;
   end else begin
       wt_rsp_pipe_pvld_d4 <= wt_rsp_pipe_pvld_d3;
   end
end
reg [35:0] wt_rsp_pipe_pd_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pd_d4 <= {36{1'b0}};
   end else begin
       if ((wt_rsp_pipe_pvld_d3) == 1'b1) begin
           wt_rsp_pipe_pd_d4 <= wt_rsp_pipe_pd_d3;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld_d3) == 1'b0) begin
       end else begin
           wt_rsp_pipe_pd_d4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_mask_en_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_en_d4 <= 1'b0;
   end else begin
       wt_rsp_mask_en_d4 <= wt_rsp_mask_en_d3;
   end
end
reg [7:0] wt_rsp_mask_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_d4 <= {8{1'b0}};
   end else begin
       if ((wt_rsp_mask_en_d3) == 1'b1) begin
           wt_rsp_mask_d4 <= wt_rsp_mask_d3;
       // VCS coverage off
       end else if ((wt_rsp_mask_en_d3) == 1'b0) begin
       end else begin
           wt_rsp_mask_d4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_pipe_pvld_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pvld_d5 <= 1'b0;
   end else begin
       wt_rsp_pipe_pvld_d5 <= wt_rsp_pipe_pvld_d4;
   end
end
reg [35:0] wt_rsp_pipe_pd_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pd_d5 <= {36{1'b0}};
   end else begin
       if ((wt_rsp_pipe_pvld_d4) == 1'b1) begin
           wt_rsp_pipe_pd_d5 <= wt_rsp_pipe_pd_d4;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld_d4) == 1'b0) begin
       end else begin
           wt_rsp_pipe_pd_d5 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_mask_en_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_en_d5 <= 1'b0;
   end else begin
       wt_rsp_mask_en_d5 <= wt_rsp_mask_en_d4;
   end
end
reg [7:0] wt_rsp_mask_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_d5 <= {8{1'b0}};
   end else begin
       if ((wt_rsp_mask_en_d4) == 1'b1) begin
           wt_rsp_mask_d5 <= wt_rsp_mask_d4;
       // VCS coverage off
       end else if ((wt_rsp_mask_en_d4) == 1'b0) begin
       end else begin
           wt_rsp_mask_d5 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_pipe_pvld_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pvld_d6 <= 1'b0;
   end else begin
       wt_rsp_pipe_pvld_d6 <= wt_rsp_pipe_pvld_d5;
   end
end
reg [35:0] wt_rsp_pipe_pd_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_pipe_pd_d6 <= {36{1'b0}};
   end else begin
       if ((wt_rsp_pipe_pvld_d5) == 1'b1) begin
           wt_rsp_pipe_pd_d6 <= wt_rsp_pipe_pd_d5;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld_d5) == 1'b0) begin
       end else begin
           wt_rsp_pipe_pd_d6 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  wt_rsp_mask_en_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_en_d6 <= 1'b0;
   end else begin
       wt_rsp_mask_en_d6 <= wt_rsp_mask_en_d5;
   end
end
reg [7:0] wt_rsp_mask_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_mask_d6 <= {8{1'b0}};
   end else begin
       if ((wt_rsp_mask_en_d5) == 1'b1) begin
           wt_rsp_mask_d6 <= wt_rsp_mask_d5;
       // VCS coverage off
       end else if ((wt_rsp_mask_en_d5) == 1'b0) begin
       end else begin
           wt_rsp_mask_d6 <= 'bx;
       // VCS coverage on
       end
   end
end
assign wt_rsp_pipe_pvld = wt_rsp_pipe_pvld_d6;
assign wt_rsp_pipe_pd = wt_rsp_pipe_pd_d6;

assign wt_rsp_mask_en = wt_rsp_mask_en_d6;
assign wt_rsp_mask = wt_rsp_mask_d6;


//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// weight data process                                /////
//////////////////////////////////////////////////////////////
// PKT_UNPACK_WIRE( csc_wt_req_pkg , wt_rsp_ , wt_rsp_pipe_pd )
assign wt_rsp_bytes[7:0] = wt_rsp_pipe_pd[7:0];
assign wt_rsp_wmb_rls_entries[8:0] = wt_rsp_pipe_pd[16:8];
assign wt_rsp_wt_rls_entries[14:0] = wt_rsp_pipe_pd[31:17];
assign wt_rsp_stripe_end = wt_rsp_pipe_pd[32];
assign wt_rsp_channel_end = wt_rsp_pipe_pd[33];
assign wt_rsp_group_end = wt_rsp_pipe_pd[34];
assign wt_rsp_rls = wt_rsp_pipe_pd[35];
//////////////////////////////////// generate byte mask for decoding ////////////////////////////////////
assign wt_rsp_mask_d1_w = wt_rsp_mask ;
//////////////////////////////////// weight remain counter ////////////////////////////////////
assign wt_rsp_byte_remain_add = sc2buf_wt_rd_valid ? 7'h8 : 8'h0;
assign {mon_wt_rsp_byte_remain_w,wt_rsp_byte_remain_w} = (layer_st) ? 8'b0 :
                               (wt_rsp_channel_end & ~wt_rsp_group_end) ? {2'b0, wt_rsp_byte_remain_last} :
                               wt_rsp_byte_remain + wt_rsp_byte_remain_add - wt_rsp_bytes;
assign wt_rsp_byte_remain_en = layer_st | wt_rsp_pipe_pvld;
assign wt_rsp_byte_remain_last_en = layer_st | (wt_rsp_pipe_pvld & wt_rsp_group_end);
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"wt_rsp_byte_remain_en\" -d \"wt_rsp_byte_remain_w\" -q wt_rsp_byte_remain");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"wt_rsp_byte_remain_last_en\" -d \"wt_rsp_byte_remain_w\" -q wt_rsp_byte_remain_last");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_byte_remain <= {7{1'b0}};
   end else begin
       if ((wt_rsp_byte_remain_en) == 1'b1) begin
           wt_rsp_byte_remain <= wt_rsp_byte_remain_w;
       // VCS coverage off
       end else if ((wt_rsp_byte_remain_en) == 1'b0) begin
       end else begin
           wt_rsp_byte_remain <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_byte_remain_last <= {7{1'b0}};
   end else begin
       if ((wt_rsp_byte_remain_last_en) == 1'b1) begin
           wt_rsp_byte_remain_last <= wt_rsp_byte_remain_w;
       // VCS coverage off
       end else if ((wt_rsp_byte_remain_last_en) == 1'b0) begin
       end else begin
           wt_rsp_byte_remain_last <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate local remain bytes ////////////////////////////////////
assign {mon_wt_shift_remain,wt_shift_remain} = wt_rsp_bytes - wt_rsp_byte_remain[6:0];
assign wt_data_input_rs = (sc2buf_wt_rd_data[64 -1:0] >> {wt_shift_remain, 3'b0});
assign wt_data_remain_masked = ~(|wt_rsp_byte_remain) ? {64{1'b0}}: wt_data_remain;
assign wt_data_remain_rs = (wt_data_remain >> {wt_rsp_bytes, 3'b0});
//weight data local remain, 1 entry at most
assign wt_data_remain_w = layer_st ? {64{1'b0}} :
                          (wt_rsp_channel_end & ~wt_rsp_group_end & (|wt_rsp_byte_remain_last)) ? wt_data_remain_last :
                          sc2buf_wt_rd_valid ? wt_data_input_rs :
                          wt_data_remain_rs;
assign wt_data_remain_reg_en = layer_st | (wt_rsp_pipe_pvld & (|wt_rsp_byte_remain_w));
assign wt_data_remain_last_reg_en = layer_st | (wt_rsp_pipe_pvld & wt_rsp_group_end & (|wt_rsp_byte_remain_w));
assign wt_data_input_ls = (sc2buf_wt_rd_data << {wt_rsp_byte_remain[6:0], 3'b0});
assign wt_data_input_sft = (sc2buf_wt_rd_valid) ? wt_data_input_ls : {64{1'b0}};
//: &eperl::flop("-nodeclare  -norst -en \"wt_data_remain_reg_en\" -d \"wt_data_remain_w\" -q wt_data_remain");
//: &eperl::flop("-nodeclare  -norst -en \"wt_data_remain_last_reg_en\" -d \"wt_data_remain_w\" -q wt_data_remain_last");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk) begin
       if ((wt_data_remain_reg_en) == 1'b1) begin
           wt_data_remain <= wt_data_remain_w;
       // VCS coverage off
       end else if ((wt_data_remain_reg_en) == 1'b0) begin
       end else begin
           wt_data_remain <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_data_remain_last_reg_en) == 1'b1) begin
           wt_data_remain_last <= wt_data_remain_w;
       // VCS coverage off
       end else if ((wt_data_remain_last_reg_en) == 1'b0) begin
       end else begin
           wt_data_remain_last <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate bytes for decoding ////////////////////////////////////
assign wt_rsp_data = (wt_data_input_sft | wt_data_remain_masked);
//: my $kk=64;
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wt_rsp_pipe_pvld\" -d \"wt_rsp_data\" -q dec_input_data");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dec_input_data <= {64{1'b0}};
   end else begin
       if ((wt_rsp_pipe_pvld) == 1'b1) begin
           dec_input_data <= wt_rsp_data;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           dec_input_data <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////// generate select signal ////////////////////////////////////
assign wt_rsp_sel_w = wt_rsp_last_stripe_end ? {{(8 -1){1'h0}},1'h1} : {wt_rsp_sel_d1[8 -2:0], wt_rsp_sel_d1[8 -1]};
//: &eperl::flop("-nodeclare   -rval \"1'b1\"  -en \"wt_rsp_pipe_pvld\" -d \"wt_rsp_stripe_end\" -q wt_rsp_last_stripe_end");
//: &eperl::flop("-nodeclare   -rval \"'h1\"  -en \"wt_rsp_pipe_pvld\" -d \"wt_rsp_sel_w\" -q wt_rsp_sel_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_last_stripe_end <= 1'b1;
   end else begin
       if ((wt_rsp_pipe_pvld) == 1'b1) begin
           wt_rsp_last_stripe_end <= wt_rsp_stripe_end;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_rsp_last_stripe_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_rsp_sel_d1 <= 'h1;
   end else begin
       if ((wt_rsp_pipe_pvld) == 1'b1) begin
           wt_rsp_sel_d1 <= wt_rsp_sel_w;
       // VCS coverage off
       end else if ((wt_rsp_pipe_pvld) == 1'b0) begin
       end else begin
           wt_rsp_sel_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dec_input_sel = wt_rsp_sel_d1;
//////////////////////////////////// prepare other signals ////////////////////////////////////
//: my $kk=8;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"wt_rsp_pipe_pvld\" -q dec_input_pipe_valid");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"wt_rsp_mask_en\" -d \"wt_rsp_mask_d1_w\" -q dec_input_mask");
//: &eperl::flop("-nodeclare   -rval \"{10{1'b0}}\"   -d \"{10{wt_rsp_mask_en}}\" -q dec_input_mask_en");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dec_input_pipe_valid <= 1'b0;
   end else begin
       dec_input_pipe_valid <= wt_rsp_pipe_pvld;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dec_input_mask <= {8{1'b0}};
   end else begin
       if ((wt_rsp_mask_en) == 1'b1) begin
           dec_input_mask <= wt_rsp_mask_d1_w;
       // VCS coverage off
       end else if ((wt_rsp_mask_en) == 1'b0) begin
       end else begin
           dec_input_mask <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dec_input_mask_en <= {10{1'b0}};
   end else begin
       dec_input_mask_en <= {10{wt_rsp_mask_en}};
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
NV_NVDLA_CSC_WL_dec u_dec (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.input_data (dec_input_data[8*8 -1:0]) //|< r
  ,.input_mask (dec_input_mask[8 -1:0]) //|< r
  ,.input_mask_en (dec_input_mask_en[9:0]) //|< r
  ,.input_pipe_valid (dec_input_pipe_valid) //|< r
  ,.input_sel (dec_input_sel[8 -1:0]) //|< w
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq(,.output_data${i} (sc2mac_out_data${i}) //|> w\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
,.output_data0 (sc2mac_out_data0) //|> w
,.output_data1 (sc2mac_out_data1) //|> w
,.output_data2 (sc2mac_out_data2) //|> w
,.output_data3 (sc2mac_out_data3) //|> w
,.output_data4 (sc2mac_out_data4) //|> w
,.output_data5 (sc2mac_out_data5) //|> w
,.output_data6 (sc2mac_out_data6) //|> w
,.output_data7 (sc2mac_out_data7) //|> w

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.output_mask (sc2mac_out_mask[8 -1:0]) //|> w
  ,.output_pvld (sc2mac_out_pvld) //|> w
  ,.output_sel (sc2mac_out_sel[8 -1:0]) //|> w
  ,.is_fp16 (1'b0) //|< i
  ,.is_int8 (1'b1) //|< i
  );
//////////////////////////////////////////////////////////////
///// registers for retiming                             /////
//////////////////////////////////////////////////////////////
assign sc2mac_out_a_sel_w = {8/2{sc2mac_out_pvld}} & sc2mac_out_sel[8/2 -1:0];
assign sc2mac_out_b_sel_w = {8/2{sc2mac_out_pvld}} & sc2mac_out_sel[8 -1:8/2];
assign sc2mac_wt_a_pvld_w = (|sc2mac_out_a_sel_w);
assign sc2mac_wt_b_pvld_w = (|sc2mac_out_b_sel_w);
assign sc2mac_out_a_mask = sc2mac_out_mask & {8{sc2mac_wt_a_pvld_w}};
assign sc2mac_out_b_mask = sc2mac_out_mask & {8{sc2mac_wt_b_pvld_w}};
//: my $kk=8;
//: my $jj=8/2;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sc2mac_wt_a_pvld_w\" -q sc2mac_wt_a_pvld");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sc2mac_wt_b_pvld_w\" -q sc2mac_wt_b_pvld");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"sc2mac_wt_a_pvld_w | sc2mac_wt_a_pvld\" -d \"sc2mac_out_a_mask\" -q sc2mac_wt_a_mask");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"sc2mac_wt_b_pvld_w | sc2mac_wt_b_pvld\" -d \"sc2mac_out_b_mask\" -q sc2mac_wt_b_mask");
//: &eperl::flop("-nodeclare   -rval \"{${jj}{1'b0}}\"  -en \"sc2mac_wt_a_pvld_w | sc2mac_wt_a_pvld\" -d \"sc2mac_out_a_sel_w\" -q sc2mac_wt_a_sel");
//: &eperl::flop("-nodeclare   -rval \"{${jj}{1'b0}}\"  -en \"sc2mac_wt_b_pvld_w | sc2mac_wt_b_pvld\" -d \"sc2mac_out_b_sel_w\" -q sc2mac_wt_b_sel");
//: for(my $i = 0; $i < 8; $i ++) {
//: &eperl::flop("-nodeclare  -norst -en \"sc2mac_out_a_mask[${i}]\" -d \"sc2mac_out_data${i}\" -q sc2mac_wt_a_data${i}");
//: }
//: print "\n\n";
//:
//: for(my $i = 0; $i < 8; $i ++) {
//: &eperl::flop("-nodeclare  -norst -en \"sc2mac_out_b_mask[${i}]\" -d \"sc2mac_out_data${i}\" -q sc2mac_wt_b_data${i}");
//: }
//: print "\n\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_a_pvld <= 1'b0;
   end else begin
       sc2mac_wt_a_pvld <= sc2mac_wt_a_pvld_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_b_pvld <= 1'b0;
   end else begin
       sc2mac_wt_b_pvld <= sc2mac_wt_b_pvld_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_a_mask <= {8{1'b0}};
   end else begin
       if ((sc2mac_wt_a_pvld_w | sc2mac_wt_a_pvld) == 1'b1) begin
           sc2mac_wt_a_mask <= sc2mac_out_a_mask;
       // VCS coverage off
       end else if ((sc2mac_wt_a_pvld_w | sc2mac_wt_a_pvld) == 1'b0) begin
       end else begin
           sc2mac_wt_a_mask <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_b_mask <= {8{1'b0}};
   end else begin
       if ((sc2mac_wt_b_pvld_w | sc2mac_wt_b_pvld) == 1'b1) begin
           sc2mac_wt_b_mask <= sc2mac_out_b_mask;
       // VCS coverage off
       end else if ((sc2mac_wt_b_pvld_w | sc2mac_wt_b_pvld) == 1'b0) begin
       end else begin
           sc2mac_wt_b_mask <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_a_sel <= {4{1'b0}};
   end else begin
       if ((sc2mac_wt_a_pvld_w | sc2mac_wt_a_pvld) == 1'b1) begin
           sc2mac_wt_a_sel <= sc2mac_out_a_sel_w;
       // VCS coverage off
       end else if ((sc2mac_wt_a_pvld_w | sc2mac_wt_a_pvld) == 1'b0) begin
       end else begin
           sc2mac_wt_a_sel <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_b_sel <= {4{1'b0}};
   end else begin
       if ((sc2mac_wt_b_pvld_w | sc2mac_wt_b_pvld) == 1'b1) begin
           sc2mac_wt_b_sel <= sc2mac_out_b_sel_w;
       // VCS coverage off
       end else if ((sc2mac_wt_b_pvld_w | sc2mac_wt_b_pvld) == 1'b0) begin
       end else begin
           sc2mac_wt_b_sel <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_a_mask[0]) == 1'b1) begin
           sc2mac_wt_a_data0 <= sc2mac_out_data0;
       // VCS coverage off
       end else if ((sc2mac_out_a_mask[0]) == 1'b0) begin
       end else begin
           sc2mac_wt_a_data0 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_a_mask[1]) == 1'b1) begin
           sc2mac_wt_a_data1 <= sc2mac_out_data1;
       // VCS coverage off
       end else if ((sc2mac_out_a_mask[1]) == 1'b0) begin
       end else begin
           sc2mac_wt_a_data1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_a_mask[2]) == 1'b1) begin
           sc2mac_wt_a_data2 <= sc2mac_out_data2;
       // VCS coverage off
       end else if ((sc2mac_out_a_mask[2]) == 1'b0) begin
       end else begin
           sc2mac_wt_a_data2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_a_mask[3]) == 1'b1) begin
           sc2mac_wt_a_data3 <= sc2mac_out_data3;
       // VCS coverage off
       end else if ((sc2mac_out_a_mask[3]) == 1'b0) begin
       end else begin
           sc2mac_wt_a_data3 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_a_mask[4]) == 1'b1) begin
           sc2mac_wt_a_data4 <= sc2mac_out_data4;
       // VCS coverage off
       end else if ((sc2mac_out_a_mask[4]) == 1'b0) begin
       end else begin
           sc2mac_wt_a_data4 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_a_mask[5]) == 1'b1) begin
           sc2mac_wt_a_data5 <= sc2mac_out_data5;
       // VCS coverage off
       end else if ((sc2mac_out_a_mask[5]) == 1'b0) begin
       end else begin
           sc2mac_wt_a_data5 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_a_mask[6]) == 1'b1) begin
           sc2mac_wt_a_data6 <= sc2mac_out_data6;
       // VCS coverage off
       end else if ((sc2mac_out_a_mask[6]) == 1'b0) begin
       end else begin
           sc2mac_wt_a_data6 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_a_mask[7]) == 1'b1) begin
           sc2mac_wt_a_data7 <= sc2mac_out_data7;
       // VCS coverage off
       end else if ((sc2mac_out_a_mask[7]) == 1'b0) begin
       end else begin
           sc2mac_wt_a_data7 <= 'bx;
       // VCS coverage on
       end
end


always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_b_mask[0]) == 1'b1) begin
           sc2mac_wt_b_data0 <= sc2mac_out_data0;
       // VCS coverage off
       end else if ((sc2mac_out_b_mask[0]) == 1'b0) begin
       end else begin
           sc2mac_wt_b_data0 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_b_mask[1]) == 1'b1) begin
           sc2mac_wt_b_data1 <= sc2mac_out_data1;
       // VCS coverage off
       end else if ((sc2mac_out_b_mask[1]) == 1'b0) begin
       end else begin
           sc2mac_wt_b_data1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_b_mask[2]) == 1'b1) begin
           sc2mac_wt_b_data2 <= sc2mac_out_data2;
       // VCS coverage off
       end else if ((sc2mac_out_b_mask[2]) == 1'b0) begin
       end else begin
           sc2mac_wt_b_data2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_b_mask[3]) == 1'b1) begin
           sc2mac_wt_b_data3 <= sc2mac_out_data3;
       // VCS coverage off
       end else if ((sc2mac_out_b_mask[3]) == 1'b0) begin
       end else begin
           sc2mac_wt_b_data3 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_b_mask[4]) == 1'b1) begin
           sc2mac_wt_b_data4 <= sc2mac_out_data4;
       // VCS coverage off
       end else if ((sc2mac_out_b_mask[4]) == 1'b0) begin
       end else begin
           sc2mac_wt_b_data4 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_b_mask[5]) == 1'b1) begin
           sc2mac_wt_b_data5 <= sc2mac_out_data5;
       // VCS coverage off
       end else if ((sc2mac_out_b_mask[5]) == 1'b0) begin
       end else begin
           sc2mac_wt_b_data5 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_b_mask[6]) == 1'b1) begin
           sc2mac_wt_b_data6 <= sc2mac_out_data6;
       // VCS coverage off
       end else if ((sc2mac_out_b_mask[6]) == 1'b0) begin
       end else begin
           sc2mac_wt_b_data6 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sc2mac_out_b_mask[7]) == 1'b1) begin
           sc2mac_wt_b_data7 <= sc2mac_out_data7;
       // VCS coverage off
       end else if ((sc2mac_out_b_mask[7]) == 1'b0) begin
       end else begin
           sc2mac_wt_b_data7 <= 'bx;
       // VCS coverage on
       end
end



//| eperl: generated_end (DO NOT EDIT ABOVE)
`ifndef SYNTHESIS
//: my $kk=8;
//: for(my $i = 0; $i < ${kk}; $i ++) {
//: print "assign dbg_csc_wt_a_${i} = sc2mac_wt_a_mask[${i}] ? sc2mac_wt_a_data${i} : 8'h0;\n";
//: }
//: for(my $i = 0; $i < ${kk}; $i ++) {
//: print "assign dbg_csc_wt_b_${i} = sc2mac_wt_b_mask[${i}] ? sc2mac_wt_b_data${i} : 8'h0;\n";
//: }
//: print "assign dbg_csc_wt_a = {";
//: for(my $i = ${kk}-1; $i >= 0; $i --) {
//: print "dbg_csc_wt_a_${i}";
//: if($i != 0) {
//: print ", ";
//: } else {
//: print "};\n";
//: }
//: }
//: my $kk=8 -1;
//: print "assign dbg_csc_wt_b = {";
//: for(my $i = ${kk}; $i >= 0; $i --) {
//: print "dbg_csc_wt_b_${i}";
//: if($i != 0) {
//: print ", ";
//: } else {
//: print "};\n";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign dbg_csc_wt_a_0 = sc2mac_wt_a_mask[0] ? sc2mac_wt_a_data0 : 8'h0;
assign dbg_csc_wt_a_1 = sc2mac_wt_a_mask[1] ? sc2mac_wt_a_data1 : 8'h0;
assign dbg_csc_wt_a_2 = sc2mac_wt_a_mask[2] ? sc2mac_wt_a_data2 : 8'h0;
assign dbg_csc_wt_a_3 = sc2mac_wt_a_mask[3] ? sc2mac_wt_a_data3 : 8'h0;
assign dbg_csc_wt_a_4 = sc2mac_wt_a_mask[4] ? sc2mac_wt_a_data4 : 8'h0;
assign dbg_csc_wt_a_5 = sc2mac_wt_a_mask[5] ? sc2mac_wt_a_data5 : 8'h0;
assign dbg_csc_wt_a_6 = sc2mac_wt_a_mask[6] ? sc2mac_wt_a_data6 : 8'h0;
assign dbg_csc_wt_a_7 = sc2mac_wt_a_mask[7] ? sc2mac_wt_a_data7 : 8'h0;
assign dbg_csc_wt_b_0 = sc2mac_wt_b_mask[0] ? sc2mac_wt_b_data0 : 8'h0;
assign dbg_csc_wt_b_1 = sc2mac_wt_b_mask[1] ? sc2mac_wt_b_data1 : 8'h0;
assign dbg_csc_wt_b_2 = sc2mac_wt_b_mask[2] ? sc2mac_wt_b_data2 : 8'h0;
assign dbg_csc_wt_b_3 = sc2mac_wt_b_mask[3] ? sc2mac_wt_b_data3 : 8'h0;
assign dbg_csc_wt_b_4 = sc2mac_wt_b_mask[4] ? sc2mac_wt_b_data4 : 8'h0;
assign dbg_csc_wt_b_5 = sc2mac_wt_b_mask[5] ? sc2mac_wt_b_data5 : 8'h0;
assign dbg_csc_wt_b_6 = sc2mac_wt_b_mask[6] ? sc2mac_wt_b_data6 : 8'h0;
assign dbg_csc_wt_b_7 = sc2mac_wt_b_mask[7] ? sc2mac_wt_b_data7 : 8'h0;
assign dbg_csc_wt_a = {dbg_csc_wt_a_7, dbg_csc_wt_a_6, dbg_csc_wt_a_5, dbg_csc_wt_a_4, dbg_csc_wt_a_3, dbg_csc_wt_a_2, dbg_csc_wt_a_1, dbg_csc_wt_a_0};
assign dbg_csc_wt_b = {dbg_csc_wt_b_7, dbg_csc_wt_b_6, dbg_csc_wt_b_5, dbg_csc_wt_b_4, dbg_csc_wt_b_3, dbg_csc_wt_b_2, dbg_csc_wt_b_1, dbg_csc_wt_b_0};

//| eperl: generated_end (DO NOT EDIT ABOVE)
`ifdef NVDLA_PRINT_WL
always @ (posedge nvdla_core_clk)
begin
    if(layer_st)
    begin
        $display("[NVDLA WL] layer start");
    end
end
always @ (posedge nvdla_core_clk)
begin
    if(sc2mac_wt_a_pvld)
    begin
        $display("[NVDLA WL] sc2mac_wt = %01024h", dbg_csc_wt_a);
    end
    else if (sc2mac_wt_b_pvld)
    begin
        $display("[NVDLA WL] sc2mac_wt = %01024h", dbg_csc_wt_b);
    end
end
`endif
`endif
endmodule // NV_NVDLA_CSC_wl
