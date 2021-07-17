// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CSC_dl.v
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
// File Name: NV_NVDLA_CBUF.h
    `define CBUF_BANK_RAM_CASE1
    `define CBUF_SUPPORT_READ_JUMPING
//ram case could be 0/1/2/3/4/5  0:1ram/bank; 1:1*2ram/bank; 2:2*1ram/bank; 3:2*2ram/bank  4:4*1ram/bank  5:4*2ram/bank
`define CDMA2CBUF_DEBUG_PRINT //open debug print
module NV_NVDLA_CSC_dl (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,sg2dl_pvld //|< i
  ,sg2dl_pd //|< i
  ,sc_state //|< i
  ,sg2dl_reuse_rls //|< i
  ,sc2cdma_dat_pending_req //|< i
  ,cdma2sc_dat_updt //|< i
  ,cdma2sc_dat_entries //|< i
  ,cdma2sc_dat_slices //|< i
  ,sc2cdma_dat_updt //|> o
  ,sc2cdma_dat_entries //|> o
  ,sc2cdma_dat_slices //|> o
  ,sc2buf_dat_rd_en //|> o
  ,sc2buf_dat_rd_addr //|> o
  ,sc2buf_dat_rd_valid //|< i
  ,sc2buf_dat_rd_data //|< i
  ,sc2buf_dat_rd_shift //|> o
  ,sc2buf_dat_rd_next1_en //|> o
  ,sc2buf_dat_rd_next1_addr //|> o
  ,sc2mac_dat_a_pvld //|> o
  ,sc2mac_dat_a_mask //|> o
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,sc2mac_dat_a_data${i} //|> o )
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
  ,sc2mac_dat_a_pd //|> o
  ,sc2mac_dat_b_pvld //|> o
  ,sc2mac_dat_b_mask //|> o
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,sc2mac_dat_b_data${i} //|> o )
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
  ,sc2mac_dat_b_pd //|> o
  ,nvdla_core_ng_clk //|< i
  ,nvdla_wg_clk //|< i
  ,reg2dp_op_en //|< i
  ,reg2dp_conv_mode //|< i
  ,reg2dp_batches //|< i
  ,reg2dp_proc_precision //|< i
  ,reg2dp_datain_format //|< i
  ,reg2dp_skip_data_rls //|< i
  ,reg2dp_datain_channel_ext //|< i
  ,reg2dp_datain_height_ext //|< i
  ,reg2dp_datain_width_ext //|< i
  ,reg2dp_y_extension //|< i
  ,reg2dp_weight_channel_ext //|< i
  ,reg2dp_entries //|< i
  ,reg2dp_dataout_width //|< i
  ,reg2dp_rls_slices //|< i
  ,reg2dp_conv_x_stride_ext //|< i
  ,reg2dp_conv_y_stride_ext //|< i
  ,reg2dp_x_dilation_ext //|< i
  ,reg2dp_y_dilation_ext //|< i
  ,reg2dp_pad_left //|< i
  ,reg2dp_pad_top //|< i
  ,reg2dp_pad_value //|< i
  ,reg2dp_data_bank //|< i
  ,reg2dp_pra_truncate //|< i
  ,slcg_wg_en //|> o
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input sg2dl_pvld; /* data valid */
input [30:0] sg2dl_pd;
input [1:0] sc_state;
input sg2dl_reuse_rls;
input sc2cdma_dat_pending_req;
input cdma2sc_dat_updt; /* data valid */
input [15 -1:0] cdma2sc_dat_entries;
input [13:0] cdma2sc_dat_slices;
output sc2cdma_dat_updt; /* data valid */
output [15 -1:0] sc2cdma_dat_entries;
output [13:0] sc2cdma_dat_slices;
output sc2buf_dat_rd_en; /* data valid */
output [14 -1:0] sc2buf_dat_rd_addr;
input sc2buf_dat_rd_valid; /* data valid */
input [64 -1:0] sc2buf_dat_rd_data;
output [7 -1:0] sc2buf_dat_rd_shift;
output sc2buf_dat_rd_next1_en;
output [14 -1:0] sc2buf_dat_rd_next1_addr;
output sc2mac_dat_a_pvld; /* data valid */
output [8 -1:0] sc2mac_dat_a_mask;
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: output [8 -1:0] sc2mac_dat_a_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [8 -1:0] sc2mac_dat_a_data0; 
output [8 -1:0] sc2mac_dat_a_data1; 
output [8 -1:0] sc2mac_dat_a_data2; 
output [8 -1:0] sc2mac_dat_a_data3; 
output [8 -1:0] sc2mac_dat_a_data4; 
output [8 -1:0] sc2mac_dat_a_data5; 
output [8 -1:0] sc2mac_dat_a_data6; 
output [8 -1:0] sc2mac_dat_a_data7; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
output [8:0] sc2mac_dat_a_pd;
output sc2mac_dat_b_pvld; /* data valid */
output [8 -1:0] sc2mac_dat_b_mask;
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: output [8 -1:0] sc2mac_dat_b_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [8 -1:0] sc2mac_dat_b_data0; 
output [8 -1:0] sc2mac_dat_b_data1; 
output [8 -1:0] sc2mac_dat_b_data2; 
output [8 -1:0] sc2mac_dat_b_data3; 
output [8 -1:0] sc2mac_dat_b_data4; 
output [8 -1:0] sc2mac_dat_b_data5; 
output [8 -1:0] sc2mac_dat_b_data6; 
output [8 -1:0] sc2mac_dat_b_data7; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
output [8:0] sc2mac_dat_b_pd;
input nvdla_core_ng_clk;
input nvdla_wg_clk;
input [0:0] reg2dp_op_en;
input [0:0] reg2dp_conv_mode;
input [4:0] reg2dp_batches;
input [1:0] reg2dp_proc_precision;
input [0:0] reg2dp_datain_format;
input [0:0] reg2dp_skip_data_rls;
input [12:0] reg2dp_datain_channel_ext;
input [12:0] reg2dp_datain_height_ext;
input [12:0] reg2dp_datain_width_ext;
input [1:0] reg2dp_y_extension;
input [12:0] reg2dp_weight_channel_ext;
input [13:0] reg2dp_entries;
input [12:0] reg2dp_dataout_width;
input [11:0] reg2dp_rls_slices;
input [2:0] reg2dp_conv_x_stride_ext;
input [2:0] reg2dp_conv_y_stride_ext;
input [4:0] reg2dp_x_dilation_ext;
input [4:0] reg2dp_y_dilation_ext;
input [4:0] reg2dp_pad_left;
input [4:0] reg2dp_pad_top;
input [15:0] reg2dp_pad_value;
input [4:0] reg2dp_data_bank;
input [1:0] reg2dp_pra_truncate;
output slcg_wg_en;
reg [4:0] batch_cmp;
reg [4:0] batch_cnt;
reg [14 -1:0] c_bias;
reg [14 -1:0] c_bias_d1;
reg [3:0] conv_x_stride;
reg [3:0] conv_y_stride;
reg [15 -1:0] dat_entry_avl;
reg [15 -1:0] dat_entry_end;
reg [15 -1:0] dat_entry_st;
reg dat_exec_valid_d1;
reg dat_exec_valid_d2;
reg dat_l0c0_dummy;
reg [64 -1:0] dat_l0c0;
reg dat_l0c1_dummy;
reg [64 -1:0] dat_l0c1;
reg dat_l1c0_dummy;
reg [64 -1:0] dat_l1c0;
reg dat_l1c1_dummy;
reg [64 -1:0] dat_l1c1;
reg dat_l2c0_dummy;
reg [64 -1:0] dat_l2c0;
reg dat_l2c1_dummy;
reg [64 -1:0] dat_l2c1;
reg dat_l3c0_dummy;
reg [64 -1:0] dat_l3c0;
reg dat_l3c1_dummy;
reg [64 -1:0] dat_l3c1;
reg [64 -1:0] dat_out_bypass_data;
reg [8 -1:0] dat_out_bypass_mask;
reg [8:0] dat_out_flag;
reg dat_out_pvld;
reg dat_pipe_local_valid;
reg dat_pipe_valid_d1;
reg dat_pipe_valid_d2;
reg [7:0] dat_req_bytes_d1;
reg [7:0] dat_req_bytes_d2;
reg dat_req_ch_end_d1;
reg dat_req_ch_end_d2;
reg [1:0] dat_req_cur_sub_h_d1;
reg [1:0] dat_req_cur_sub_h_d2;
reg dat_req_dummy_d1;
reg dat_req_dummy_d2;
reg [8:0] dat_req_flag_d1;
reg [8:0] dat_req_flag_d2;
reg dat_req_rls_d1;
reg dat_req_rls_d2;
reg dat_req_sub_c_d1;
reg dat_req_sub_c_d2;
reg [14 -1:0] dat_req_sub_h_0_addr;
reg [14 -1:0] dat_req_sub_h_1_addr;
reg [14 -1:0] dat_req_sub_h_2_addr;
reg [14 -1:0] dat_req_sub_h_3_addr;
reg [1:0] dat_req_sub_h_d1;
reg [1:0] dat_req_sub_h_d2;
reg [1:0] dat_req_sub_w_d1;
reg [1:0] dat_req_sub_w_d2;
reg dat_req_sub_w_st_d1;
reg dat_req_sub_w_st_d2;
reg dat_req_valid_d1;
wire [64 -1:0] dat_rsp_l0_sft;
reg [64 -1:0] dat_rsp_l0_sft_d1;
reg [64 -1:0] dat_rsp_l0_sft_d2;
reg [64 -1:0] dat_rsp_l0_sft_d3;
wire [64 -1:0] dat_rsp_l1_sft;
reg [64 -1:0] dat_rsp_l1_sft_d2;
reg [64 -1:0] dat_rsp_l1_sft_d3;
wire [64 -1:0] dat_rsp_l2_sft;
reg [64 -1:0] dat_rsp_l2_sft_d3;
wire [64 -1:0] dat_rsp_l3_sft;
reg [26:0] dat_rsp_pd_d1;
reg [26:0] dat_rsp_pd_d2;
reg [26:0] dat_rsp_pd_d3;
reg [26:0] dat_rsp_pd_d4;
reg [3:0] dat_rsp_pra_en_d1;
reg dat_rsp_pvld_d1;
reg dat_rsp_pvld_d2;
reg dat_rsp_pvld_d3;
reg dat_rsp_pvld_d4;
reg [255:0] dat_rsp_wg_ch0_d1;
reg [255:0] dat_rsp_wg_ch1_d1;
reg [255:0] dat_rsp_wg_ch2_d1;
reg [255:0] dat_rsp_wg_ch3_d1;
reg [13:0] dat_slice_avl;
reg [4:0] data_bank;
reg [5:0] data_batch;
reg [10:0] datain_c_cnt;
reg [10:0] datain_channel_cmp;
reg [13:0] datain_h_cnt;
reg [13:0] datain_h_ori;
reg [12:0] datain_height_cmp;
reg [13:0] datain_w_cnt;
reg [13:0] datain_w_ori;
reg [13:0] datain_width;
reg [12:0] datain_width_cmp;
reg [12:0] dataout_w_cnt;
reg [12:0] dataout_w_ori;
reg [12:0] dataout_width_cmp;
reg [8:0] dl_out_flag;
reg [8 -1:0] dl_out_mask;
reg dl_out_pvld;
reg dl_out_pvld_d1;
reg [30:0] dl_pd_d1;
reg [30:0] dl_pd_d2;
reg [30:0] dl_pd_d3;
reg [30:0] dl_pd_d4;
reg dl_pvld_d1;
reg dl_pvld_d2;
reg dl_pvld_d3;
reg dl_pvld_d4;
reg [15 -1:0] entries;
reg [15 -1:0] entries_batch;
reg [15 -1:0] entries_cmp;
reg [14 -1:0] h_bias_0_d1;
reg [14 -1:0] h_bias_0_stride;
reg [14 -1:0] h_bias_1_d1;
reg [14 -1:0] h_bias_1_stride;
reg [14 -1:0] h_bias_2_d1;
reg [14 -1:0] h_bias_2_stride;
reg [14 -1:0] h_bias_3_d1;
reg [14 -1:0] h_bias_3_stride;
reg [13:0] h_offset_slice;
reg [33:0] is_img_d1;
reg is_sg_running_d1;
reg [21:0] is_winograd_d1;
reg [15 -1:0] last_entries;
reg [13:0] last_slices;
reg layer_st_d1;
reg [15:0] pad_value;
reg [11:0] pixel_ch_stride;
reg pixel_force_clr_d1;
reg pixel_force_fetch_d1;
reg [15:0] pixel_w_ch_ori;
reg [15:0] pixel_w_cnt;
reg [15:0] pixel_w_ori;
reg [6:0] pixel_x_add;
reg [6:0] pixel_x_byte_stride;
reg [5:0] pixel_x_init;
reg [6:0] pixel_x_init_offset;
reg pixel_x_stride_odd;
reg [7:0] pra_precision;
reg [7:0] pra_truncate;
reg [15 -1:0] rls_entries;
reg [13:0] rls_slices;
reg [7:0] rsp_sft_cnt_l0;
reg [7:0] rsp_sft_cnt_l0_ori;
reg [7:0] rsp_sft_cnt_l1;
reg [7:0] rsp_sft_cnt_l1_ori;
reg [7:0] rsp_sft_cnt_l2;
reg [7:0] rsp_sft_cnt_l2_ori;
reg [7:0] rsp_sft_cnt_l3;
reg [7:0] rsp_sft_cnt_l3_ori;
reg [14 -1:0] sc2buf_dat_rd_addr;
reg [14 -1:0] sc2buf_dat_rd_next1_addr;
reg sc2buf_dat_rd_en;
reg [15 -1:0] sc2cdma_dat_entries;
reg [13:0] sc2cdma_dat_slices;
reg sc2cdma_dat_updt;
reg [8 -1:0] sc2mac_dat_a_mask;
reg [8:0] sc2mac_dat_a_pd;
reg sc2mac_dat_a_pvld;
reg [8 -1:0] sc2mac_dat_b_mask;
reg [8:0] sc2mac_dat_b_pd;
reg sc2mac_dat_b_pvld;
reg slcg_wg_en_d1;
reg slcg_wg_en_d2;
reg slcg_wg_en_d3;
reg [13:0] slice_left;
reg [6:0] stripe_cnt;
reg [2:0] sub_h_cmp_g0;
reg [2:0] sub_h_cmp_g1;
reg [1:0] sub_h_cnt;
reg [2:0] sub_h_total_g0;
reg [2:0] sub_h_total_g1;
reg [2:0] sub_h_total_g10;
reg [2:0] sub_h_total_g11;
reg [1:0] sub_h_total_g2;
reg [2:0] sub_h_total_g3;
reg [2:0] sub_h_total_g4;
reg [2:0] sub_h_total_g5;
reg [2:0] sub_h_total_g6;
reg [2:0] sub_h_total_g7;
reg [2:0] sub_h_total_g8;
reg [2:0] sub_h_total_g9;
reg [14 -1:0] w_bias_d1;
reg [5:0] x_dilate;
reg [5:0] y_dilate;
wire [4:0] batch_cmp_w;
wire [4:0] batch_cnt_w;
wire [14 -1:0] c_bias_add;
wire c_bias_d1_reg_en;
wire c_bias_reg_en;
wire [14 -1:0] c_bias_w;
wire cbuf_reset;
wire [3:0] conv_x_stride_w;
wire [3:0] conv_y_stride_w;
wire dat_conv_req_dummy;
wire dat_dummy_l0_en;
wire dat_dummy_l1_en;
wire dat_dummy_l2_en;
wire dat_dummy_l3_en;
wire [15 -1:0] dat_entry_avl_add;
wire [15 -1:0] dat_entry_avl_sub;
wire [15 -1:0] dat_entry_avl_w;
wire [15 -1:0] dat_entry_end_inc;
wire [15 -1:0] dat_entry_end_inc_wrap;
wire [15 -1:0] dat_entry_end_w;
wire [15 -1:0] dat_entry_st_inc;
wire [15 -1:0] dat_entry_st_inc_wrap;
wire [15 -1:0] dat_entry_st_w;
wire mon_dat_entry_end_inc;
wire mon_dat_entry_st_inc;
wire dat_exec_valid;
wire dat_img_req_dummy;
wire dat_img_req_skip;
wire dat_l0_set;
wire dat_l0c0_dummy_w;
wire dat_l0c0_en;
wire dat_l0c1_dummy_w;
wire dat_l0c1_en;
wire dat_l1_set;
wire dat_l1c0_dummy_w;
wire dat_l1c0_en;
wire dat_l1c0_hi_en;
wire dat_l1c1_dummy_w;
wire dat_l1c1_en;
wire dat_l1c1_hi_en;
wire dat_l2_set;
wire dat_l2c0_dummy_w;
wire dat_l2c0_en;
wire dat_l2c1_dummy_w;
wire dat_l2c1_en;
wire dat_l3_set;
wire dat_l3c0_dummy_w;
wire dat_l3c0_en;
wire dat_l3c1_dummy_w;
wire dat_l3c1_en;
wire [64 -1:0] dat_out_bypass_data_w;
wire [8 -1:0] dat_out_bypass_mask_w;
wire dat_out_bypass_p0_vld_w;
wire [64 -1:0] dat_out_data;
wire [8:0] dat_out_flag_l0;
wire [8:0] dat_out_flag_w;
wire [8 -1:0] dat_out_mask;
wire dat_out_pvld_l0;
wire dat_out_pvld_w;
wire [64 -1:0] dat_out_wg_8b;
wire [64 -1:0] dat_out_wg_data;
wire [8 -1:0] dat_out_wg_mask;
wire [8 -1:0] dat_out_wg_mask_int8;
wire dat_pipe_local_valid_w;
wire dat_pipe_valid;
wire [64 -1:0] dat_pra_dat;
wire [255:0] dat_pra_dat_ch0;
wire [255:0] dat_pra_dat_ch1;
wire [255:0] dat_pra_dat_ch2;
wire [255:0] dat_pra_dat_ch3;
wire [14 -1:0] dat_req_addr_last;
wire [14:0] dat_req_addr_sum;
wire [14 -1:0] dat_req_addr_w;
wire [14 -1:0] dat_req_addr_wrap;
wire [14 -1:0] dat_req_base_d1;
wire mon_dat_req_addr_sum;
wire [4:0] dat_req_batch_index;
wire [7:0] dat_req_bytes;
wire dat_req_channel_end;
wire dat_req_dummy;
wire dat_req_exec_dummy;
wire dat_req_exec_pvld;
wire [1:0] dat_req_exec_sub_h;
wire [8:0] dat_req_flag_w;
wire dat_req_layer_end;
wire [7:0] dat_req_pipe_bytes;
wire dat_req_pipe_ch_end;
wire [1:0] dat_req_pipe_cur_sub_h;
wire dat_req_pipe_dummy;
wire [8:0] dat_req_pipe_flag;
wire [28:0] dat_req_pipe_pd;
wire dat_req_pipe_pvld;
wire dat_req_pipe_rls;
wire dat_req_pipe_sub_c;
wire [1:0] dat_req_pipe_sub_h;
wire [1:0] dat_req_pipe_sub_w;
wire dat_req_pipe_sub_w_st;
wire dat_req_skip;
wire dat_req_stripe_end;
wire dat_req_stripe_st;
wire dat_req_sub_c_w;
wire dat_req_sub_h_0_addr_en;
wire dat_req_sub_h_1_addr_en;
wire dat_req_sub_h_2_addr_en;
wire dat_req_sub_h_3_addr_en;
wire dat_req_sub_w_st_en;
wire [1:0] dat_req_sub_w_w;
wire dat_req_valid;
wire dat_rls;
wire [4:0] dat_rsp_batch_index;
wire [7:0] dat_rsp_bytes;
wire dat_rsp_ch_end;
wire dat_rsp_channel_end;
wire [64 -1:0] dat_rsp_conv;
wire [64 -1:0] dat_rsp_conv_8b;
wire [8 -1:0] dat_rsp_cur_h_e2_mask_8b;
wire [8 -1:0] dat_rsp_cur_h_e4_mask_8b;
wire [8 -1:0] dat_rsp_cur_h_mask_p1;
wire [31:0] dat_rsp_cur_h_mask_p2;
wire [31:0] dat_rsp_cur_h_mask_p3;
wire [1:0] dat_rsp_cur_sub_h;
wire [64 -1:0] dat_rsp_data_w;
wire dat_rsp_exec_dummy;
wire dat_rsp_exec_dummy_d0;
wire dat_rsp_exec_pvld;
wire dat_rsp_exec_pvld_d0;
wire [1:0] dat_rsp_exec_sub_h;
wire [1:0] dat_rsp_exec_sub_h_d0;
wire [8:0] dat_rsp_flag;
wire [64 -1:0] dat_rsp_img;
wire [64 -1:0] dat_rsp_img_8b;
wire dat_rsp_l0_block_end;
wire [8:0] dat_rsp_l0_flag;
wire dat_rsp_l0_pvld;
wire [64*2 -1:0] dat_rsp_l0_sft_in;
wire dat_rsp_l0_stripe_end;
wire dat_rsp_l0_sub_c;
wire [64 -1:0] dat_rsp_l0c0;
wire [64 -1:0] dat_rsp_l0c1;
wire dat_rsp_l1_block_end;
wire [8:0] dat_rsp_l1_flag;
wire dat_rsp_l1_pvld;
wire [64*2 -1:0] dat_rsp_l1_sft_in;
wire dat_rsp_l1_stripe_end;
wire dat_rsp_l1_sub_c;
wire [64 -1:0] dat_rsp_l1c0;
wire [64 -1:0] dat_rsp_l1c1;
wire dat_rsp_l2_block_end;
wire [8:0] dat_rsp_l2_flag;
wire dat_rsp_l2_pvld;
wire [64*2 -1:0] dat_rsp_l2_sft_in;
wire dat_rsp_l2_stripe_end;
wire dat_rsp_l2_sub_c;
wire [64 -1:0] dat_rsp_l2c0;
wire [64 -1:0] dat_rsp_l2c1;
wire dat_rsp_l3_block_end;
wire [8:0] dat_rsp_l3_flag;
wire dat_rsp_l3_pvld;
wire [64*2 -1:0] dat_rsp_l3_sft_in;
wire dat_rsp_l3_stripe_end;
wire dat_rsp_l3_sub_c;
wire [64 -1:0] dat_rsp_l3c0;
wire [64 -1:0] dat_rsp_l3c1;
wire dat_rsp_layer_end;
wire [8 -1:0] dat_rsp_mask_8b;
wire [8 -1:0] dat_rsp_mask_val_int8;
wire [8 -1:0] dat_rsp_mask_w;
wire [8 -1:0] dat_rsp_ori_mask;
wire dat_rsp_p0_vld_w;
wire dat_rsp_p1_vld_w;
wire [64 -1:0] dat_rsp_pad_value;
wire [26:0] dat_rsp_pd;
wire [26:0] dat_rsp_pd_d0;
wire [7:0] dat_rsp_pipe_bytes;
wire dat_rsp_pipe_ch_end;
wire [1:0] dat_rsp_pipe_cur_sub_h;
wire dat_rsp_pipe_dummy;
wire [8:0] dat_rsp_pipe_flag;
wire [28:0] dat_rsp_pipe_pd;
wire [28:0] dat_rsp_pipe_pd_d0;
wire dat_rsp_pipe_pvld;
wire dat_rsp_pipe_pvld_d0;
wire dat_rsp_pipe_rls;
wire dat_rsp_pipe_sub_c;
wire [1:0] dat_rsp_pipe_sub_h;
wire [1:0] dat_rsp_pipe_sub_w;
wire dat_rsp_pipe_sub_w_st;
wire dat_rsp_pra_en;
wire dat_rsp_pvld;
wire dat_rsp_pvld_d0;
wire dat_rsp_rls;
wire dat_rsp_stripe_end;
wire dat_rsp_stripe_st;
wire dat_rsp_sub_c;
wire [1:0] dat_rsp_sub_h;
wire [1:0] dat_rsp_sub_w;
wire [64 -1:0] dat_rsp_wg;
wire [255:0] dat_rsp_wg_ch0;
wire [255:0] dat_rsp_wg_ch1;
wire [255:0] dat_rsp_wg_ch2;
wire [255:0] dat_rsp_wg_ch3;
wire [64 -1:0] dat_rsp_wg_lb;
wire [64 -1:0] dat_rsp_wg_lt;
wire [64 -1:0] dat_rsp_wg_rb;
wire [64 -1:0] dat_rsp_wg_rt;
wire dat_rsp_wg_sel_8b_hi;
wire dat_rsp_wg_sel_8b_lo;
wire dat_rsp_wg_sel_lb;
wire dat_rsp_wg_sel_lt;
wire dat_rsp_wg_sel_rb;
wire dat_rsp_wg_sel_rt;
wire [13:0] dat_slice_avl_add;
wire [13:0] dat_slice_avl_sub;
wire [13:0] dat_slice_avl_w;
wire [2303:0] dat_wg;
wire [255:0] dat_wg_8b_ch0;
wire [255:0] dat_wg_8b_ch1;
wire [255:0] dat_wg_8b_ch2;
wire [255:0] dat_wg_8b_ch3;
wire [255:0] dat_wg_8b_ch4;
wire [255:0] dat_wg_8b_ch5;
wire [255:0] dat_wg_8b_ch6;
wire [255:0] dat_wg_8b_ch7;
wire dat_wg_adv;
wire dat_wg_req_dummy;
wire dat_wg_req_skip;
wire [4:0] data_bank_w;
wire [5:0] data_batch_w;
wire [10:0] datain_c_cnt_inc;
wire datain_c_cnt_reg_en;
wire [10:0] datain_c_cnt_w;
wire [10:0] datain_channel_cmp_w;
wire [13:0] datain_h_cnt_inc;
wire datain_h_cnt_reg_en;
wire [13:0] datain_h_cnt_st;
wire [13:0] datain_h_cnt_w;
wire [13:0] datain_h_cur;
wire datain_h_ori_reg_en;
wire [12:0] datain_height_cmp_w;
wire [13:0] datain_w_cnt_inc;
wire datain_w_cnt_reg_en;
wire [13:0] datain_w_cnt_st;
wire [13:0] datain_w_cnt_w;
wire [13:0] datain_w_cur;
wire datain_w_ori_reg_en;
wire [12:0] datain_width_cmp_w;
wire [13:0] datain_width_w;
wire [2:0] dataout_w_add;
wire [12:0] dataout_w_cnt_inc;
wire dataout_w_cnt_reg_en;
wire [12:0] dataout_w_cnt_w;
wire [12:0] dataout_w_init;
wire dataout_w_ori_reg_en;
wire [12:0] dataout_width_cmp_w;
wire [64 -1:0] dbg_csc_dat;
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: wire [8 -1:0] dbg_csc_dat_${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [8 -1:0] dbg_csc_dat_0; 
wire [8 -1:0] dbg_csc_dat_1; 
wire [8 -1:0] dbg_csc_dat_2; 
wire [8 -1:0] dbg_csc_dat_3; 
wire [8 -1:0] dbg_csc_dat_4; 
wire [8 -1:0] dbg_csc_dat_5; 
wire [8 -1:0] dbg_csc_dat_6; 
wire [8 -1:0] dbg_csc_dat_7; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
wire dl_block_end;
wire dl_channel_end;
wire [6:0] dl_channel_size;
wire [1:0] dl_cur_sub_h;
wire dl_dat_release;
wire dl_group_end;
wire [4:0] dl_h_offset;
wire [9:0] dl_h_offset_ext;
wire [30:0] dl_in_pd;
wire [30:0] dl_in_pd_d0;
wire dl_in_pvld;
wire dl_in_pvld_d0;
wire dl_layer_end;
wire [30:0] dl_pd;
wire [30:0] dl_pd_d0;
wire dl_pvld;
wire dl_pvld_d0;
wire [6:0] dl_stripe_length;
wire [4:0] dl_w_offset;
wire [9:0] dl_w_offset_ext;
wire [15 -1:0] entries_batch_w;
wire [15 -1:0] entries_single_w;
wire [15 -1:0] entries_w;
wire [14 -1:0] h_bias_0_stride_w;
wire [14 -1:0] h_bias_0_w;
wire [14 -1:0] h_bias_1_stride_w;
wire [14 -1:0] h_bias_1_w;
wire [14 -1:0] h_bias_2_w;
wire [14 -1:0] h_bias_3_w;
wire [14 -1:0] h_bias_d1;
wire [1:0] h_bias_reg_en;
wire [13:0] h_offset_slice_w;
wire is_batch_end;
wire is_conv;
wire is_dat_entry_end_wrap;
wire is_dat_entry_st_wrap;
wire is_dat_req_addr_wrap;
wire is_img;
wire is_last_channel;
wire is_pixel;
wire is_running_first;
wire is_sg_done;
wire is_sg_idle;
wire is_sg_running;
wire is_stripe_end;
wire is_stripe_equal;
wire is_sub_h_end;
wire is_w_end;
wire is_w_end_ahead;
wire is_winograd;
wire layer_st;
wire mon_batch_cnt_w;
wire mon_c_bias_w;
wire mon_dat_entry_avl_w;
wire mon_dat_entry_end_inc_wrap;
wire mon_dat_entry_st_inc_wrap;
wire [3:0] mon_dat_out_pra_vld;
wire [1:0] mon_dat_req_addr_wrap;
wire [64 -1:0] mon_dat_rsp_l0_sft;
wire [64 -1:0] mon_dat_rsp_l1_sft;
wire [64 -1:0] mon_dat_rsp_l2_sft;
wire [64 -1:0] mon_dat_rsp_l3_sft;
wire [3:0] mon_dat_rsp_pra_rdy;
wire mon_dat_slice_avl_w;
wire mon_data_bank_w;
wire mon_datain_c_cnt_inc;
wire mon_datain_h_cnt_inc;
wire mon_datain_h_cur;
wire mon_datain_w_cnt_inc;
wire mon_datain_w_cur;
wire mon_dataout_w_cnt_inc;
wire [5:0] mon_entries_batch_w;
wire mon_entries_single_w;
wire mon_entries_w;
wire [5:0] mon_h_bias_0_stride_w;
wire [14 -1:0] mon_h_bias_0_w;
wire [12:0] mon_h_bias_1_stride_w;
wire [4:0] mon_h_bias_1_w;
wire [4:0] mon_h_bias_2_w;
wire [1:0] mon_h_bias_3_w;
wire mon_h_bias_d1;
wire mon_pixel_w_cnt_w;
wire [1:0] mon_pixel_x_init_w;
wire mon_rls_slices_w;
wire mon_rsp_sft_cnt_l0_w;
wire mon_rsp_sft_cnt_l1_w;
wire mon_rsp_sft_cnt_l2_w;
wire mon_rsp_sft_cnt_l3_w;
wire [13:0] mon_slice_entries_w;
wire [1:0] mon_slice_left_w;
wire mon_stripe_cnt_inc;
wire [2:0] mon_sub_h_total_w;
wire pixel_ch_ori_reg_en;
wire [11:0] pixel_ch_stride_w;
wire pixel_force_clr;
wire pixel_force_fetch;
wire pixel_w_cnt_reg_en;
wire [15:0] pixel_w_cnt_w;
wire [14:0] pixel_w_cur;
wire pixel_w_ori_reg_en;
wire [7:0] pixel_x_add_w;
wire [6:0] pixel_x_byte_stride_w;
wire [6:0] pixel_x_cnt_add;
wire [6:0] pixel_x_init_offset_w;
wire [5:0] pixel_x_init_w;
wire [5:0] pixel_x_stride_w;
wire [1:0] pra_precision_0;
wire [1:0] pra_precision_1;
wire [1:0] pra_precision_2;
wire [1:0] pra_precision_3;
wire [1:0] pra_truncate_0;
wire [1:0] pra_truncate_1;
wire [1:0] pra_truncate_2;
wire [1:0] pra_truncate_3;
wire [1:0] pra_truncate_w;
wire reuse_rls;
wire [13:0] rls_slices_w;
wire rsp_sft_cnt_l0_en;
wire [7:0] rsp_sft_cnt_l0_inc;
wire rsp_sft_cnt_l0_ori_en;
wire [7:0] rsp_sft_cnt_l0_sub;
wire [7:0] rsp_sft_cnt_l0_w;
wire rsp_sft_cnt_l1_en;
wire [7:0] rsp_sft_cnt_l1_inc;
wire rsp_sft_cnt_l1_ori_en;
wire [7:0] rsp_sft_cnt_l1_sub;
wire [7:0] rsp_sft_cnt_l1_w;
wire rsp_sft_cnt_l2_en;
wire [7:0] rsp_sft_cnt_l2_inc;
wire rsp_sft_cnt_l2_ori_en;
wire [7:0] rsp_sft_cnt_l2_sub;
wire [7:0] rsp_sft_cnt_l2_w;
wire rsp_sft_cnt_l3_en;
wire [7:0] rsp_sft_cnt_l3_inc;
wire rsp_sft_cnt_l3_ori_en;
wire [7:0] rsp_sft_cnt_l3_sub;
wire [7:0] rsp_sft_cnt_l3_w;
wire rsp_sft_l1_sel_1;
wire rsp_sft_l1_sel_2;
wire rsp_sft_l1_sel_3;
wire rsp_sft_l2_sel_1;
wire rsp_sft_l2_sel_2;
wire rsp_sft_l2_sel_3;
wire rsp_sft_l3_sel_1;
wire rsp_sft_l3_sel_2;
wire rsp_sft_l3_sel_3;
wire sc2buf_dat_rd_en_w;
wire [15 -1:0] sc2cdma_dat_entries_w;
wire [13:0] sc2cdma_dat_slices_w;
wire [8:0] sc2mac_dat_pd_w;
wire slcg_wg_en_w;
wire [15 -1:0] slice_entries_w;
wire [13:0] slice_left_w;
wire [13:0] slices_oprand;
wire [6:0] stripe_cnt_inc;
wire stripe_cnt_reg_en;
wire [6:0] stripe_cnt_w;
wire [2:0] sub_h_cmp_w;
wire [2:0] sub_h_cnt_inc;
wire sub_h_cnt_reg_en;
wire [1:0] sub_h_cnt_w;
wire [2:0] sub_h_total_w;
wire sub_rls;
wire [14:0] w_bias_int8;
wire w_bias_reg_en;
wire [13:0] w_bias_w;
wire [5:0] x_dilate_w;
wire [5:0] y_dilate_w;
/////////////////////////////////////////////////////////////////////////////////////////////
// Pipeline of Weight loader, for both compressed weight and uncompressed weight
//
// input_package
// |
// data request
// |
// conv_buffer
// |
// feature data---> data relase
// | |
// REG PRA
// | |
// REGISTER
// |
// MAC
//
/////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
///// status from sequence generator                     /////
//////////////////////////////////////////////////////////////
assign is_sg_idle = (sc_state == 0 );
assign is_sg_running = (sc_state == 2 );
assign is_sg_done = (sc_state == 3 );
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
assign is_pixel = (reg2dp_datain_format == 1'h1 );
`ifdef NVDLA_WINOGRAD_ENABLE
assign is_winograd = (reg2dp_conv_mode == 1'h1 );
`else
assign is_winograd = 1'b0;
`endif
assign is_conv = (reg2dp_conv_mode == 1'h0 );
assign is_img = is_conv & is_pixel;
assign {mon_data_bank_w, data_bank_w} = reg2dp_data_bank + 1'b1;
`ifdef NVDLA_BATCH_ENABLE
assign data_batch_w = (is_winograd | is_img) ? 6'b1 : reg2dp_batches + 1'b1;
assign batch_cmp_w = (is_winograd | is_img) ? 5'b0 : reg2dp_batches;
`else
assign data_batch_w = 6'b1;
assign batch_cmp_w = 5'b0;
`endif
//assign is_int8 = (reg2dp_proc_precision == 2'h0 );
//assign is_fp16 = (reg2dp_proc_precision == 2'h2 );
assign datain_width_w = is_winograd ? ({2'b0, reg2dp_datain_width_ext[12:2]} + 1'b1) : reg2dp_datain_width_ext + 1'b1;
assign datain_width_cmp_w = reg2dp_datain_width_ext;
assign datain_height_cmp_w = reg2dp_datain_height_ext;
assign datain_channel_cmp_w = is_winograd ? reg2dp_weight_channel_ext[12:2] : {{3 -2{1'b0}}, reg2dp_weight_channel_ext[12:3]};
//y_ex=0,sub_h_total=1;y_ex=1,sub_h_total=2; y_ext=2,sub_h_total=4; non_image, sub_h_total=1;
//sub_h_total means how many h lines are used in post-extention
assign {sub_h_total_w, mon_sub_h_total_w} = is_img ? (6'h9 << reg2dp_y_extension) : 6'h8;
assign sub_h_cmp_w = is_img ? sub_h_total_w : is_winograd ? 3'h2 : 3'h1;
assign dataout_w_init[12:0] = sub_h_cmp_w - 1'b1;
assign conv_x_stride_w = (is_winograd) ? 4'b1 : reg2dp_conv_x_stride_ext + 1'b1;
assign pixel_x_stride_w = (reg2dp_datain_channel_ext[1:0] == 2'h3) ? {conv_x_stride_w, 2'b0} : //*4, after pre_extension
                          (reg2dp_datain_channel_ext[1:0] == 2'h2) ? ({conv_x_stride_w, 1'b0} + conv_x_stride_w) : //*3
                          {2'b0, conv_x_stride_w}; //*1
//: my $kk=3;
//: if ($kk=6) {
//: print qq (
//: assign {mon_pixel_x_init_w,pixel_x_init_w} = (reg2dp_y_extension == 2'h2) ? ({pixel_x_stride_w, 1'b0} + pixel_x_stride_w + reg2dp_weight_channel_ext[5:0]) :
//: (reg2dp_y_extension == 2'h1) ? (pixel_x_stride_w + reg2dp_weight_channel_ext[5:0]):
//: (reg2dp_weight_channel_ext >= 7'h08) ? {3{1'b1}}: //cut by atomC
//: {reg2dp_weight_channel_ext[3 -1:0]};
//: )
//: }
//: else {
//: print qq(
//: assign {mon_pixel_x_init_w,pixel_x_init_w} = (reg2dp_y_extension == 2'h2) ? ({pixel_x_stride_w, 1'b0} + pixel_x_stride_w + reg2dp_weight_channel_ext[5:0]) :
//: (reg2dp_y_extension == 2'h1) ? (pixel_x_stride_w + reg2dp_weight_channel_ext[5:0]):
//: (reg2dp_weight_channel_ext >= 7'h08) ? {3{1'b1}}: //cut by atomC
//: {{6-3{1'b0}},reg2dp_weight_channel_ext[3 -1:0]};
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign {mon_pixel_x_init_w,pixel_x_init_w} = (reg2dp_y_extension == 2'h2) ? ({pixel_x_stride_w, 1'b0} + pixel_x_stride_w + reg2dp_weight_channel_ext[5:0]) :
(reg2dp_y_extension == 2'h1) ? (pixel_x_stride_w + reg2dp_weight_channel_ext[5:0]):
(reg2dp_weight_channel_ext >= 7'h08) ? {3{1'b1}}: //cut by atomC
{reg2dp_weight_channel_ext[3 -1:0]};

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign pixel_x_init_offset_w = (reg2dp_weight_channel_ext[3 -1:0] + 1'b1);
assign pixel_x_add_w = (reg2dp_y_extension == 2'h2) ? {pixel_x_stride_w, 2'b0} : //*4, after post_extension
                       (reg2dp_y_extension == 2'h1) ? {1'b0, pixel_x_stride_w, 1'b0} : //*2
                       {2'b0, pixel_x_stride_w};
assign pixel_x_byte_stride_w = {1'b0, pixel_x_stride_w};
//: my $kk=3;
//: if($kk=5) {
//: print qq(
//: `ifdef CC_ATOMC_DIV_ATOMK_EQUAL_1
//: assign pixel_ch_stride_w = {pixel_x_stride_w, {3 +1{1'b0}}}; //stick to 2*atomK  no matter which config.  
//: `endif
//: `ifdef CC_ATOMC_DIV_ATOMK_EQUAL_2
//: assign pixel_ch_stride_w = {pixel_x_stride_w, {3 +1{1'b0}}}; //stick to 2*atomK  no matter which config.  
//: `endif
//: `ifdef CC_ATOMC_DIV_ATOMK_EQUAL_4
//: assign pixel_ch_stride_w = {pixel_x_stride_w, {3 +2{1'b0}}}; //stick to 4*atomK  no matter which config.  
//: `endif
//: )
//: }
//: else {
//: print qq(
//: `ifdef CC_ATOMC_DIV_ATOMK_EQUAL_1
//: assign pixel_ch_stride_w = {{5-3{1'b0}},pixel_x_stride_w, {3 +1{1'b0}}}; //stick to 2*atomK  no matter which config.  
//: `endif
//: `ifdef CC_ATOMC_DIV_ATOMK_EQUAL_2
//: assign pixel_ch_stride_w = {{5-3{1'b0}},pixel_x_stride_w, {3 +1{1'b0}}}; //stick to 2*atomK  no matter which config.  
//: `endif
//: `ifdef CC_ATOMC_DIV_ATOMK_EQUAL_4
//: assign pixel_ch_stride_w = {{5-3{1'b0}},pixel_x_stride_w, {3 +2{1'b0}}}; //stick to 4*atomK  no matter which config.  
//: `endif
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_1
assign pixel_ch_stride_w = {pixel_x_stride_w, {3 +1{1'b0}}}; //stick to 2*atomK  no matter which config.  
`endif
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_2
assign pixel_ch_stride_w = {pixel_x_stride_w, {3 +1{1'b0}}}; //stick to 2*atomK  no matter which config.  
`endif
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_4
assign pixel_ch_stride_w = {pixel_x_stride_w, {3 +2{1'b0}}}; //stick to 4*atomK  no matter which config.  
`endif

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign conv_y_stride_w = (is_winograd) ? 4'b1 : reg2dp_conv_y_stride_ext + 1'b1;
assign x_dilate_w = (is_winograd | is_img) ? 6'b1 : reg2dp_x_dilation_ext + 1'b1;
assign y_dilate_w = (is_winograd | is_img) ? 6'b1 : reg2dp_y_dilation_ext + 1'b1;
//reg2dp_entries means entry per slice
assign {mon_entries_single_w,entries_single_w} = (reg2dp_entries + 1'b1);
assign {mon_entries_batch_w,entries_batch_w} = entries_single_w * data_batch_w;
assign {mon_entries_w,entries_w} = (is_winograd) ? ({reg2dp_entries[12:0], 2'b0} + 3'h4) : entries_single_w;
assign h_offset_slice_w[11:0] = data_batch_w * y_dilate_w;
assign h_offset_slice_w[13:12] = 2'b0;
assign {mon_h_bias_0_stride_w,h_bias_0_stride_w} = entries * data_batch;
assign {mon_h_bias_1_stride_w,h_bias_1_stride_w} = entries * h_offset_slice;
assign {mon_rls_slices_w,rls_slices_w} = reg2dp_rls_slices + 1'b1;
assign {mon_slice_left_w,slice_left_w} = reg2dp_skip_data_rls ? (reg2dp_datain_height_ext + 1'b1) : reg2dp_datain_height_ext - reg2dp_rls_slices;
assign slices_oprand = layer_st_d1 ? rls_slices : slice_left;
assign {mon_slice_entries_w,slice_entries_w} = entries_batch * slices_oprand;
assign dataout_width_cmp_w = reg2dp_dataout_width;
assign pra_truncate_w = (reg2dp_pra_truncate == 2'h3) ? 2'h2 : reg2dp_pra_truncate;
//: my $kk=15;
//: my $jj=14;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"layer_st\" -q layer_st_d1");
//: &eperl::flop("-nodeclare   -rval \"{22{1'b0}}\"  -en \"layer_st\" -d \"{22{is_winograd}}\" -q is_winograd_d1");
//: &eperl::flop("-nodeclare   -rval \"{34{1'b0}}\"  -en \"layer_st\" -d \"{34{is_img}}\" -q is_img_d1");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"layer_st\" -d \"data_bank_w\" -q data_bank");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"layer_st\" -d \"datain_width_w\" -q datain_width");
//: &eperl::flop("-nodeclare   -rval \"{13{1'b0}}\"  -en \"layer_st\" -d \"datain_width_cmp_w\" -q datain_width_cmp");
//: &eperl::flop("-nodeclare   -rval \"{13{1'b0}}\"  -en \"layer_st\" -d \"datain_height_cmp_w\" -q datain_height_cmp");
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"layer_st\" -d \"datain_channel_cmp_w\" -q datain_channel_cmp");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g0");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g1");
//: &eperl::flop("-nodeclare   -rval \"2'h1\"  -en \"layer_st\" -d \"sub_h_total_w[2:1]\" -q sub_h_total_g2");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g3");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g4");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g5");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g6");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g7");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g8");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g9");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g10");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_total_w\" -q sub_h_total_g11");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_cmp_w\" -q sub_h_cmp_g0");
//: &eperl::flop("-nodeclare   -rval \"3'h1\"  -en \"layer_st\" -d \"sub_h_cmp_w\" -q sub_h_cmp_g1");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"layer_st\" -d \"conv_x_stride_w\" -q conv_x_stride");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"layer_st\" -d \"conv_y_stride_w\" -q conv_y_stride");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"layer_st\" -d \"pixel_x_stride_w[0]\" -q pixel_x_stride_odd");
//: &eperl::flop("-nodeclare   -rval \"{6{1'b0}}\"  -en \"layer_st\" -d \"data_batch_w\" -q data_batch");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"layer_st\" -d \"batch_cmp_w\" -q batch_cmp");
//: &eperl::flop("-nodeclare   -rval \"{6{1'b0}}\"  -en \"layer_st\" -d \"pixel_x_init_w\" -q pixel_x_init");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"layer_st\" -d \"pixel_x_init_offset_w\" -q pixel_x_init_offset");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"layer_st\" -d \"pixel_x_add_w[6:0]\" -q pixel_x_add");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"layer_st\" -d \"pixel_x_byte_stride_w\" -q pixel_x_byte_stride");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"layer_st\" -d \"pixel_ch_stride_w\" -q pixel_ch_stride");
//: &eperl::flop("-nodeclare   -rval \"{6{1'b0}}\"  -en \"layer_st\" -d \"x_dilate_w\" -q x_dilate");
//: &eperl::flop("-nodeclare   -rval \"{6{1'b0}}\"  -en \"layer_st\" -d \"y_dilate_w\" -q y_dilate");
//: &eperl::flop("-nodeclare   -rval \"{16{1'b0}}\"  -en \"layer_st\" -d \"reg2dp_pad_value\" -q pad_value");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"layer_st\" -d \"entries_w\" -q entries");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"layer_st\" -d \"entries_batch_w\" -q entries_batch");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"layer_st\" -d \"{1'h0,reg2dp_entries}\" -q entries_cmp");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"layer_st\" -d \"h_offset_slice_w\" -q h_offset_slice");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"layer_st_d1\" -d \"h_bias_0_stride_w\" -q h_bias_0_stride");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"layer_st_d1\" -d \"h_bias_1_stride_w\" -q h_bias_1_stride");
//: &eperl::flop("-nodeclare   -rval \"{${jj}{1'b0}}\"  -en \"layer_st_d1\" -d \"entries[${jj}-1:0]\" -q h_bias_2_stride");
//: &eperl::flop("-nodeclare   -rval \"{${jj}{1'b0}}\"  -en \"layer_st_d1\" -d \"entries[${jj}-1:0]\" -q h_bias_3_stride");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"layer_st\" -d \"rls_slices_w\" -q rls_slices");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"layer_st_d1\" -d \"slice_entries_w\" -q rls_entries");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"layer_st\" -d \"slice_left_w[13:0]\" -q slice_left");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"is_sg_done\" -d \"slice_left\" -q last_slices");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"is_sg_done\" -d \"slice_entries_w\" -q last_entries");
//: &eperl::flop("-nodeclare   -rval \"{13{1'b0}}\"  -en \"layer_st\" -d \"dataout_width_cmp_w\" -q dataout_width_cmp");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"layer_st\" -d \"{4{pra_truncate_w}}\" -q pra_truncate");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"layer_st\" -d \"{4{reg2dp_proc_precision}}\" -q pra_precision");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       layer_st_d1 <= 1'b0;
   end else begin
       layer_st_d1 <= layer_st;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_winograd_d1 <= {22{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           is_winograd_d1 <= {22{is_winograd}};
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           is_winograd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_img_d1 <= {34{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           is_img_d1 <= {34{is_img}};
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           is_img_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
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
       datain_width <= {14{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           datain_width <= datain_width_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           datain_width <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       datain_width_cmp <= {13{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           datain_width_cmp <= datain_width_cmp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           datain_width_cmp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       datain_height_cmp <= {13{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           datain_height_cmp <= datain_height_cmp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           datain_height_cmp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       datain_channel_cmp <= {11{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           datain_channel_cmp <= datain_channel_cmp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           datain_channel_cmp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g0 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g0 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g0 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g1 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g1 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g2 <= 2'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g2 <= sub_h_total_w[2:1];
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g3 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g3 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g4 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g4 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g4 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g5 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g5 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g5 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g6 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g6 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g6 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g7 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g7 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g7 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g8 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g8 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g8 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g9 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g9 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g9 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g10 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g10 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g10 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_total_g11 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_total_g11 <= sub_h_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_total_g11 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_cmp_g0 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_cmp_g0 <= sub_h_cmp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_cmp_g0 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_cmp_g1 <= 3'h1;
   end else begin
       if ((layer_st) == 1'b1) begin
           sub_h_cmp_g1 <= sub_h_cmp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           sub_h_cmp_g1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       conv_x_stride <= {4{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           conv_x_stride <= conv_x_stride_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           conv_x_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       conv_y_stride <= {4{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           conv_y_stride <= conv_y_stride_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           conv_y_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_x_stride_odd <= 1'b0;
   end else begin
       if ((layer_st) == 1'b1) begin
           pixel_x_stride_odd <= pixel_x_stride_w[0];
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pixel_x_stride_odd <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_batch <= {6{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           data_batch <= data_batch_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           data_batch <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       batch_cmp <= {5{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           batch_cmp <= batch_cmp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           batch_cmp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_x_init <= {6{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           pixel_x_init <= pixel_x_init_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pixel_x_init <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_x_init_offset <= {7{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           pixel_x_init_offset <= pixel_x_init_offset_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pixel_x_init_offset <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_x_add <= {7{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           pixel_x_add <= pixel_x_add_w[6:0];
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pixel_x_add <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_x_byte_stride <= {7{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           pixel_x_byte_stride <= pixel_x_byte_stride_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pixel_x_byte_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_ch_stride <= {12{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           pixel_ch_stride <= pixel_ch_stride_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pixel_ch_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       x_dilate <= {6{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           x_dilate <= x_dilate_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           x_dilate <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       y_dilate <= {6{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           y_dilate <= y_dilate_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           y_dilate <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pad_value <= {16{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           pad_value <= reg2dp_pad_value;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pad_value <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       entries <= {15{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           entries <= entries_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       entries_batch <= {15{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           entries_batch <= entries_batch_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           entries_batch <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       entries_cmp <= {15{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           entries_cmp <= {1'h0,reg2dp_entries};
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           entries_cmp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_offset_slice <= {14{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           h_offset_slice <= h_offset_slice_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           h_offset_slice <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_bias_0_stride <= {12{1'b0}};
   end else begin
       if ((layer_st_d1) == 1'b1) begin
           h_bias_0_stride <= h_bias_0_stride_w;
       // VCS coverage off
       end else if ((layer_st_d1) == 1'b0) begin
       end else begin
           h_bias_0_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_bias_1_stride <= {12{1'b0}};
   end else begin
       if ((layer_st_d1) == 1'b1) begin
           h_bias_1_stride <= h_bias_1_stride_w;
       // VCS coverage off
       end else if ((layer_st_d1) == 1'b0) begin
       end else begin
           h_bias_1_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_bias_2_stride <= {14{1'b0}};
   end else begin
       if ((layer_st_d1) == 1'b1) begin
           h_bias_2_stride <= entries[14-1:0];
       // VCS coverage off
       end else if ((layer_st_d1) == 1'b0) begin
       end else begin
           h_bias_2_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_bias_3_stride <= {14{1'b0}};
   end else begin
       if ((layer_st_d1) == 1'b1) begin
           h_bias_3_stride <= entries[14-1:0];
       // VCS coverage off
       end else if ((layer_st_d1) == 1'b0) begin
       end else begin
           h_bias_3_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rls_slices <= {14{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           rls_slices <= rls_slices_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           rls_slices <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rls_entries <= {15{1'b0}};
   end else begin
       if ((layer_st_d1) == 1'b1) begin
           rls_entries <= slice_entries_w;
       // VCS coverage off
       end else if ((layer_st_d1) == 1'b0) begin
       end else begin
           rls_entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slice_left <= {14{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           slice_left <= slice_left_w[13:0];
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           slice_left <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_slices <= {14{1'b0}};
   end else begin
       if ((is_sg_done) == 1'b1) begin
           last_slices <= slice_left;
       // VCS coverage off
       end else if ((is_sg_done) == 1'b0) begin
       end else begin
           last_slices <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_entries <= {15{1'b0}};
   end else begin
       if ((is_sg_done) == 1'b1) begin
           last_entries <= slice_entries_w;
       // VCS coverage off
       end else if ((is_sg_done) == 1'b0) begin
       end else begin
           last_entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dataout_width_cmp <= {13{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           dataout_width_cmp <= dataout_width_cmp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           dataout_width_cmp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pra_truncate <= {8{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           pra_truncate <= {4{pra_truncate_w}};
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pra_truncate <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pra_precision <= {8{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           pra_precision <= {4{reg2dp_proc_precision}};
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           pra_precision <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// SLCG control signal //
////////////////////////////////////////////////////////////////////////
assign slcg_wg_en_w = reg2dp_op_en & is_winograd;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"slcg_wg_en_w\" -q slcg_wg_en_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"slcg_wg_en_d1\" -q slcg_wg_en_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"slcg_wg_en_d2\" -q slcg_wg_en_d3");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_wg_en_d1 <= 1'b0;
   end else begin
       slcg_wg_en_d1 <= slcg_wg_en_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_wg_en_d2 <= 1'b0;
   end else begin
       slcg_wg_en_d2 <= slcg_wg_en_d1;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_wg_en_d3 <= 1'b0;
   end else begin
       slcg_wg_en_d3 <= slcg_wg_en_d2;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign slcg_wg_en = slcg_wg_en_d3;
//////////////////////////////////////////////////////////////
///// cbuf status management                             /////
//////////////////////////////////////////////////////////////
//================ Non-SLCG clock domain ================//
assign cbuf_reset = sc2cdma_dat_pending_req;
assign is_running_first = is_sg_running & ~is_sg_running_d1;
//////////////////////////////////// calculate how many avaliable dat slices in cbuf////////////////////////////////////
assign dat_slice_avl_add = cdma2sc_dat_updt ? cdma2sc_dat_slices : 14'b0;
assign dat_slice_avl_sub = dat_rls ? sc2cdma_dat_slices_w : 14'b0;
assign {mon_dat_slice_avl_w, dat_slice_avl_w} = (cbuf_reset) ? 14'b0 : dat_slice_avl + dat_slice_avl_add - dat_slice_avl_sub;
//////////////////////////////////// calculate how many avaliable dat entries in cbuf////////////////////////////////////
assign dat_entry_avl_add = cdma2sc_dat_updt ? cdma2sc_dat_entries :{15{1'b0}};
assign dat_entry_avl_sub = dat_rls ? sc2cdma_dat_entries_w : {15{1'b0}};
assign {mon_dat_entry_avl_w,dat_entry_avl_w} = (cbuf_reset) ? {15{1'b0}} : dat_entry_avl + dat_entry_avl_add - dat_entry_avl_sub;
//////////////////////////////////// calculate avilable data entries start offset in cbuf banks ////////////////////////////////////
// data_bank is the highest bank for storing data
assign {mon_dat_entry_st_inc,dat_entry_st_inc} = dat_entry_st + dat_entry_avl_sub;
assign {mon_dat_entry_st_inc_wrap, dat_entry_st_inc_wrap} = dat_entry_st_inc - {data_bank, {9{1'b0}} };
assign is_dat_entry_st_wrap = (dat_entry_st_inc >= {1'b0, data_bank, {9{1'b0}} });
assign dat_entry_st_w = (cbuf_reset) ? {15{1'b0}} : is_dat_entry_st_wrap ? dat_entry_st_inc_wrap : dat_entry_st_inc[15 -1:0];
//////////////////////////////////// calculate avilable data entries end offset in cbuf banks////////////////////////////////////
assign {mon_dat_entry_end_inc,dat_entry_end_inc} = dat_entry_end + dat_entry_avl_add;
assign {mon_dat_entry_end_inc_wrap,dat_entry_end_inc_wrap} = dat_entry_end_inc - {data_bank, {9{1'b0}} };
assign is_dat_entry_end_wrap = (dat_entry_end_inc >= {1'b0, data_bank, {9{1'b0}} });
assign dat_entry_end_w = (cbuf_reset) ? {15{1'b0}} : is_dat_entry_end_wrap ? dat_entry_end_inc_wrap : dat_entry_end_inc[15 -1:0];
//////////////////////////////////// registers and assertions ////////////////////////////////////
//: my $kk= 15;
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{14{1'b0}}\"  -en \"cdma2sc_dat_updt | dat_rls | cbuf_reset\" -d \"dat_slice_avl_w\" -q dat_slice_avl");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{${kk}{1'b0}}\"  -en \"cdma2sc_dat_updt | dat_rls | cbuf_reset\" -d \"dat_entry_avl_w\" -q dat_entry_avl");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{${kk}{1'b0}}\"  -en \"cbuf_reset | dat_rls\" -d \"dat_entry_st_w\" -q dat_entry_st");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{${kk}{1'b0}}\"  -en \"cbuf_reset | cdma2sc_dat_updt\" -d \"dat_entry_end_w\" -q dat_entry_end");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_slice_avl <= {14{1'b0}};
   end else begin
       if ((cdma2sc_dat_updt | dat_rls | cbuf_reset) == 1'b1) begin
           dat_slice_avl <= dat_slice_avl_w;
       // VCS coverage off
       end else if ((cdma2sc_dat_updt | dat_rls | cbuf_reset) == 1'b0) begin
       end else begin
           dat_slice_avl <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_entry_avl <= {15{1'b0}};
   end else begin
       if ((cdma2sc_dat_updt | dat_rls | cbuf_reset) == 1'b1) begin
           dat_entry_avl <= dat_entry_avl_w;
       // VCS coverage off
       end else if ((cdma2sc_dat_updt | dat_rls | cbuf_reset) == 1'b0) begin
       end else begin
           dat_entry_avl <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_entry_st <= {15{1'b0}};
   end else begin
       if ((cbuf_reset | dat_rls) == 1'b1) begin
           dat_entry_st <= dat_entry_st_w;
       // VCS coverage off
       end else if ((cbuf_reset | dat_rls) == 1'b0) begin
       end else begin
           dat_entry_st <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_entry_end <= {15{1'b0}};
   end else begin
       if ((cbuf_reset | cdma2sc_dat_updt) == 1'b1) begin
           dat_entry_end <= dat_entry_end_w;
       // VCS coverage off
       end else if ((cbuf_reset | cdma2sc_dat_updt) == 1'b0) begin
       end else begin
           dat_entry_end <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//================ Non-SLCG clock domain end ================//
//////////////////////////////////////////////////////////////
///// cbuf status update                                 /////
//////////////////////////////////////////////////////////////
assign sub_rls = (dat_rsp_pvld & dat_rsp_rls);
assign reuse_rls = sg2dl_reuse_rls;
assign dat_rls = (reuse_rls & (|last_slices)) | (sub_rls & (|rls_slices));
assign sc2cdma_dat_slices_w = sub_rls ? rls_slices : last_slices;
assign sc2cdma_dat_entries_w = sub_rls ? rls_entries : last_entries;
//: my $kk=15;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_rls\" -q sc2cdma_dat_updt");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"dat_rls\" -d \"sc2cdma_dat_slices_w[13:0]\" -q sc2cdma_dat_slices");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"dat_rls\" -d \"sc2cdma_dat_entries_w\" -q sc2cdma_dat_entries");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2cdma_dat_updt <= 1'b0;
   end else begin
       sc2cdma_dat_updt <= dat_rls;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2cdma_dat_slices <= {14{1'b0}};
   end else begin
       if ((dat_rls) == 1'b1) begin
           sc2cdma_dat_slices <= sc2cdma_dat_slices_w[13:0];
       // VCS coverage off
       end else if ((dat_rls) == 1'b0) begin
       end else begin
           sc2cdma_dat_slices <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2cdma_dat_entries <= {15{1'b0}};
   end else begin
       if ((dat_rls) == 1'b1) begin
           sc2cdma_dat_entries <= sc2cdma_dat_entries_w;
       // VCS coverage off
       end else if ((dat_rls) == 1'b0) begin
       end else begin
           sc2cdma_dat_entries <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// input sg2dl package                                 /////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
///// generate data read sequence                        /////
//////////////////////////////////////////////////////////////
//: my $total_depth = 0 + 5;
//: my $wg_depth = 0;
//:
//: print "assign dl_in_pvld_d0 = sg2dl_pvld;\n";
//: print "assign dl_in_pd_d0 = sg2dl_pd;\n\n";
//:
//: for(my $i = 0; $i < $total_depth; $i ++) {
//: my $j = $i + 1;
//: &eperl::flop("-wid 1    -rval \"1'b0\"                                 -d \"dl_in_pvld_d${i}\" -q dl_in_pvld_d${j}");
//: &eperl::flop("-wid 31   -rval \"{31{1'b0}}\"  -en \"dl_in_pvld_d${i}\" -d \"dl_in_pd_d${i}\"   -q dl_in_pd_d${j}");
//: }
//:
//: my $d0 = $total_depth;
//: my $d1 = $wg_depth;
//:
//: print "assign dl_in_pvld = (is_winograd_d1[0]) ? dl_in_pvld_d${d1} : dl_in_pvld_d${d0};\n";
//: print "assign dl_in_pd = (is_winograd_d1[1]) ? dl_in_pd_d${d1} : dl_in_pd_d${d0};\n\n";
//: my $pipe_depth = 4;
//: my $i;
//: my $j;
//: print "assign dl_pvld_d0 = dl_in_pvld;\n";
//: print "assign dl_pd_d0 = dl_in_pd;\n\n";
//: for($i = 0; $i < $pipe_depth; $i ++) {
//: $j = $i + 1;
//: &eperl::flop("-nodeclare -rval \"1'b0\"                              -d \"dl_pvld_d${i}\"   -q dl_pvld_d${j}");
//: &eperl::flop("-nodeclare -rval \"{31{1'b0}}\"  -en \"dl_pvld_d${i}\" -d \"dl_pd_d${i}\"     -q dl_pd_d${j}");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign dl_in_pvld_d0 = sg2dl_pvld;
assign dl_in_pd_d0 = sg2dl_pd;

reg  dl_in_pvld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pvld_d1 <= 1'b0;
   end else begin
       dl_in_pvld_d1 <= dl_in_pvld_d0;
   end
end
reg [30:0] dl_in_pd_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pd_d1 <= {31{1'b0}};
   end else begin
       if ((dl_in_pvld_d0) == 1'b1) begin
           dl_in_pd_d1 <= dl_in_pd_d0;
       // VCS coverage off
       end else if ((dl_in_pvld_d0) == 1'b0) begin
       end else begin
           dl_in_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dl_in_pvld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pvld_d2 <= 1'b0;
   end else begin
       dl_in_pvld_d2 <= dl_in_pvld_d1;
   end
end
reg [30:0] dl_in_pd_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pd_d2 <= {31{1'b0}};
   end else begin
       if ((dl_in_pvld_d1) == 1'b1) begin
           dl_in_pd_d2 <= dl_in_pd_d1;
       // VCS coverage off
       end else if ((dl_in_pvld_d1) == 1'b0) begin
       end else begin
           dl_in_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dl_in_pvld_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pvld_d3 <= 1'b0;
   end else begin
       dl_in_pvld_d3 <= dl_in_pvld_d2;
   end
end
reg [30:0] dl_in_pd_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pd_d3 <= {31{1'b0}};
   end else begin
       if ((dl_in_pvld_d2) == 1'b1) begin
           dl_in_pd_d3 <= dl_in_pd_d2;
       // VCS coverage off
       end else if ((dl_in_pvld_d2) == 1'b0) begin
       end else begin
           dl_in_pd_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dl_in_pvld_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pvld_d4 <= 1'b0;
   end else begin
       dl_in_pvld_d4 <= dl_in_pvld_d3;
   end
end
reg [30:0] dl_in_pd_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pd_d4 <= {31{1'b0}};
   end else begin
       if ((dl_in_pvld_d3) == 1'b1) begin
           dl_in_pd_d4 <= dl_in_pd_d3;
       // VCS coverage off
       end else if ((dl_in_pvld_d3) == 1'b0) begin
       end else begin
           dl_in_pd_d4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dl_in_pvld_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pvld_d5 <= 1'b0;
   end else begin
       dl_in_pvld_d5 <= dl_in_pvld_d4;
   end
end
reg [30:0] dl_in_pd_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_in_pd_d5 <= {31{1'b0}};
   end else begin
       if ((dl_in_pvld_d4) == 1'b1) begin
           dl_in_pd_d5 <= dl_in_pd_d4;
       // VCS coverage off
       end else if ((dl_in_pvld_d4) == 1'b0) begin
       end else begin
           dl_in_pd_d5 <= 'bx;
       // VCS coverage on
       end
   end
end
assign dl_in_pvld = (is_winograd_d1[0]) ? dl_in_pvld_d0 : dl_in_pvld_d5;
assign dl_in_pd = (is_winograd_d1[1]) ? dl_in_pd_d0 : dl_in_pd_d5;

assign dl_pvld_d0 = dl_in_pvld;
assign dl_pd_d0 = dl_in_pd;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_pvld_d1 <= 1'b0;
   end else begin
       dl_pvld_d1 <= dl_pvld_d0;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_pd_d1 <= {31{1'b0}};
   end else begin
       if ((dl_pvld_d0) == 1'b1) begin
           dl_pd_d1 <= dl_pd_d0;
       // VCS coverage off
       end else if ((dl_pvld_d0) == 1'b0) begin
       end else begin
           dl_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_pvld_d2 <= 1'b0;
   end else begin
       dl_pvld_d2 <= dl_pvld_d1;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_pd_d2 <= {31{1'b0}};
   end else begin
       if ((dl_pvld_d1) == 1'b1) begin
           dl_pd_d2 <= dl_pd_d1;
       // VCS coverage off
       end else if ((dl_pvld_d1) == 1'b0) begin
       end else begin
           dl_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_pvld_d3 <= 1'b0;
   end else begin
       dl_pvld_d3 <= dl_pvld_d2;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_pd_d3 <= {31{1'b0}};
   end else begin
       if ((dl_pvld_d2) == 1'b1) begin
           dl_pd_d3 <= dl_pd_d2;
       // VCS coverage off
       end else if ((dl_pvld_d2) == 1'b0) begin
       end else begin
           dl_pd_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_pvld_d4 <= 1'b0;
   end else begin
       dl_pvld_d4 <= dl_pvld_d3;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_pd_d4 <= {31{1'b0}};
   end else begin
       if ((dl_pvld_d3) == 1'b1) begin
           dl_pd_d4 <= dl_pd_d3;
       // VCS coverage off
       end else if ((dl_pvld_d3) == 1'b0) begin
       end else begin
           dl_pd_d4 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dl_pvld = (sub_h_total_g0[2] & dl_pvld_d1) |
                 (sub_h_total_g0[1] & dl_pvld_d3) |
                 (sub_h_total_g0[0] & dl_pvld_d4);
assign dl_pd = ({31 {sub_h_total_g1[2]}} & dl_pd_d1) |
               ({31 {sub_h_total_g1[1]}} & dl_pd_d3) |
               ({31 {sub_h_total_g1[0]}} & dl_pd_d4);
// PKT_UNPACK_WIRE( csc_dat_pkg , dl_ , dl_pd )
assign dl_w_offset[4:0] = dl_pd[4:0]; //this is weight offset
assign dl_h_offset[4:0] = dl_pd[9:5]; //weight offset
assign dl_channel_size[6:0] = dl_pd[16:10];
assign dl_stripe_length[6:0]= dl_pd[23:17];
assign dl_cur_sub_h[1:0] = dl_pd[25:24];
assign dl_block_end = dl_pd[26];
assign dl_channel_end = dl_pd[27];
assign dl_group_end = dl_pd[28];
assign dl_layer_end = dl_pd[29];
assign dl_dat_release = dl_pd[30];
////////////////////////// batch up counter //////////////////////////
assign {mon_batch_cnt_w,batch_cnt_w} = layer_st ? 6'b0 : is_batch_end ? 6'b0 : batch_cnt + 1'b1;
assign is_batch_end = (batch_cnt == batch_cmp);
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"layer_st | dat_exec_valid\" -d \"batch_cnt_w\" -q batch_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       batch_cnt <= {5{1'b0}};
   end else begin
       if ((layer_st | dat_exec_valid) == 1'b1) begin
           batch_cnt <= batch_cnt_w;
       // VCS coverage off
       end else if ((layer_st | dat_exec_valid) == 1'b0) begin
       end else begin
           batch_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// sub height up counter //////////////////////////
assign sub_h_cnt_inc = sub_h_cnt + 1'b1;
assign sub_h_cnt_w = (layer_st | is_sub_h_end) ? 2'b0 : sub_h_cnt_inc[1:0];
assign is_sub_h_end = (sub_h_cnt_inc == sub_h_cmp_g0);
assign sub_h_cnt_reg_en = layer_st | ((is_winograd_d1[2] | (|reg2dp_y_extension)) & dat_exec_valid);
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"sub_h_cnt_reg_en\" -d \"sub_h_cnt_w\" -q sub_h_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sub_h_cnt <= {2{1'b0}};
   end else begin
       if ((sub_h_cnt_reg_en) == 1'b1) begin
           sub_h_cnt <= sub_h_cnt_w;
       // VCS coverage off
       end else if ((sub_h_cnt_reg_en) == 1'b0) begin
       end else begin
           sub_h_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// stripe up counter //////////////////////////
assign {mon_stripe_cnt_inc,stripe_cnt_inc} = stripe_cnt + 1'b1;
assign stripe_cnt_w = layer_st ? 7'b0 :
                      (is_stripe_equal & ~is_sub_h_end) ? stripe_cnt :
                      is_stripe_end ? 7'b0 :
                      stripe_cnt_inc;
assign is_stripe_equal = is_batch_end & (stripe_cnt_inc == dl_stripe_length);
assign is_stripe_end = is_stripe_equal & is_sub_h_end;
assign stripe_cnt_reg_en = layer_st | (dat_exec_valid & is_batch_end);
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"stripe_cnt_reg_en\" -d \"stripe_cnt_w\" -q stripe_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       stripe_cnt <= {7{1'b0}};
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
////////////////////////// pipe valid generator //////////////////////////
assign dat_pipe_local_valid_w = (dat_pipe_valid & is_stripe_equal) ? 1'b0 : dl_pvld ? 1'b1 : dat_pipe_local_valid;
assign dat_pipe_valid = dl_pvld | dat_pipe_local_valid;
assign dat_exec_valid = dl_pvld ? 1'b1 : (~(|stripe_cnt) & ~(|sub_h_cnt) & ~(|batch_cnt)) ? 1'b0 : dat_exec_valid_d1;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_pipe_local_valid_w\" -q dat_pipe_local_valid");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_pipe_valid\" -q dat_pipe_valid_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_exec_valid\" -q dat_exec_valid_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_pipe_local_valid <= 1'b0;
   end else begin
       dat_pipe_local_valid <= dat_pipe_local_valid_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_pipe_valid_d1 <= 1'b0;
   end else begin
       dat_pipe_valid_d1 <= dat_pipe_valid;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_exec_valid_d1 <= 1'b0;
   end else begin
       dat_exec_valid_d1 <= dat_exec_valid;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// request bytes //////////////////////////
assign dat_req_bytes = {1'b0, dl_channel_size};
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"dat_exec_valid\" -d \"dat_req_bytes\" -q dat_req_bytes_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_bytes_d1 <= {8{1'b0}};
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_bytes_d1 <= dat_req_bytes;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_bytes_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// output width coordinate counter //////////////////////////
// sub_h T, output will compute sub_h point in w direction
assign dataout_w_add = sub_h_cmp_g1;
assign {mon_dataout_w_cnt_inc,dataout_w_cnt_inc} = dataout_w_cnt + dataout_w_add;
assign is_w_end = is_batch_end & is_sub_h_end & (dataout_w_cnt >= dataout_width_cmp);
assign is_w_end_ahead = is_batch_end & (dataout_w_cnt >= dataout_width_cmp);
assign dataout_w_cnt_w = layer_st ? dataout_w_init :
                         (is_stripe_end & ~dl_channel_end) ? dataout_w_ori :
                         is_w_end ? dataout_w_init :
                         dataout_w_cnt_inc;
assign dataout_w_cnt_reg_en = layer_st | (dat_exec_valid & is_batch_end & is_sub_h_end);
assign dataout_w_ori_reg_en = layer_st | (dat_exec_valid & is_stripe_end & dl_channel_end);
//: &eperl::flop("-nodeclare   -rval \"{13{1'b0}}\"  -en \"dataout_w_cnt_reg_en\" -d \"dataout_w_cnt_w\" -q dataout_w_cnt");
//: &eperl::flop("-nodeclare   -rval \"{13{1'b0}}\"  -en \"dataout_w_ori_reg_en\" -d \"dataout_w_cnt_w\" -q dataout_w_ori");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dataout_w_cnt <= {13{1'b0}};
   end else begin
       if ((dataout_w_cnt_reg_en) == 1'b1) begin
           dataout_w_cnt <= dataout_w_cnt_w;
       // VCS coverage off
       end else if ((dataout_w_cnt_reg_en) == 1'b0) begin
       end else begin
           dataout_w_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dataout_w_ori <= {13{1'b0}};
   end else begin
       if ((dataout_w_ori_reg_en) == 1'b1) begin
           dataout_w_ori <= dataout_w_cnt_w;
       // VCS coverage off
       end else if ((dataout_w_ori_reg_en) == 1'b0) begin
       end else begin
           dataout_w_ori <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// input channel coordinate counter, only feature  //////////////////////////
assign {mon_datain_c_cnt_inc,datain_c_cnt_inc} = datain_c_cnt + 1'b1;
assign is_last_channel = (datain_c_cnt == datain_channel_cmp);
assign datain_c_cnt_w = layer_st ? 11'b0 : dl_channel_end ? 11'b0 : datain_c_cnt_inc;
assign datain_c_cnt_reg_en = layer_st | (dat_exec_valid & is_stripe_end & dl_block_end);
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"datain_c_cnt_reg_en\" -d \"datain_c_cnt_w\" -q datain_c_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       datain_c_cnt <= {11{1'b0}};
   end else begin
       if ((datain_c_cnt_reg_en) == 1'b1) begin
           datain_c_cnt <= datain_c_cnt_w;
       // VCS coverage off
       end else if ((datain_c_cnt_reg_en) == 1'b0) begin
       end else begin
           datain_c_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// input width coordinate counter, feature/image dedicated counter //////////////////////////
assign datain_w_cnt_st = (is_img) ? 14'b0 : (is_winograd) ? 14'h2 : 13'b0 - reg2dp_pad_left;
assign {mon_datain_w_cnt_inc,datain_w_cnt_inc} = (is_winograd_d1[3]) ? (datain_w_cnt + 2'h2) : (datain_w_cnt + conv_x_stride);
//full data cube w counter,start form negtive, only for feature data. non-image, by element
assign datain_w_cnt_w = layer_st ? datain_w_cnt_st :
                        (is_stripe_end & ~dl_channel_end) ? datain_w_ori :
                        is_w_end ? datain_w_cnt_st :
                        datain_w_cnt_inc;
assign dl_w_offset_ext = dl_w_offset * x_dilate;
assign {mon_datain_w_cur,datain_w_cur} = datain_w_cnt + dl_w_offset_ext; //by element
assign datain_w_cnt_reg_en = layer_st | (dat_exec_valid & is_batch_end & is_sub_h_end & ~is_img_d1[0]);
assign datain_w_ori_reg_en = layer_st | (dat_exec_valid & is_stripe_end & dl_channel_end & ~is_img_d1[1]);
//notice:after sub_h T, pixel_x_add elements in W direction is used by CMAC
assign pixel_x_cnt_add = (is_sub_h_end) ? pixel_x_add : 6'b0;
//assign {mon_pixel_w_cnt_w,pixel_w_cnt_w} = (layer_st_d1) ? {{11{1'b0}}, pixel_x_init} :
// (is_stripe_end & dl_block_end & dl_channel_end & is_w_end) ? {{11{1'b0}}, pixel_x_init} :
// (is_stripe_end & dl_block_end & dl_channel_end & ~is_w_end) ? (pixel_w_ch_ori + pixel_ch_stride) :
// (is_stripe_end & dl_block_end & ~dl_channel_end) ? (pixel_w_ch_ori + pixel_x_init_offset) :
// (is_stripe_end & ~dl_block_end) ? {1'b0, pixel_w_ori} :
// (pixel_w_cnt + pixel_x_cnt_add);
//channel count.
wire [12:0] total_channel_op = (reg2dp_weight_channel_ext[3 -1:0]=={3{1'b0}}) ?
                        reg2dp_weight_channel_ext[12:3] : reg2dp_weight_channel_ext[12:3]+1'b1;
reg [12:0] channel_op_cnt;
wire mon_channel_op_cnt_nxt;
wire [12:0] channel_op_cnt_nxt;
assign {mon_channel_op_cnt_nxt, channel_op_cnt_nxt} = dl_channel_end&is_stripe_end ? 13'h2 :
                                                        dl_block_end&is_stripe_end ? channel_op_cnt + 1'b1 :
                                                        channel_op_cnt;
//: &eperl::flop("-q channel_op_cnt  -d \"channel_op_cnt_nxt\"  -wid 13  -rval \"13'h2\" -nodeclare ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       channel_op_cnt <= 13'h2;
   end else begin
       channel_op_cnt <= channel_op_cnt_nxt;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire next_is_last_channel = (channel_op_cnt >= total_channel_op);
//notice, after pre-extention, image weight w_total <=128
assign {mon_pixel_w_cnt_w,pixel_w_cnt_w} = (layer_st_d1) ? {{11{1'b0}}, pixel_x_init} :
                        (is_stripe_end & dl_block_end & dl_channel_end & is_w_end) ? {{11{1'b0}}, pixel_x_init} :
                        (is_stripe_end & dl_block_end & dl_channel_end & ~is_w_end) ? (pixel_w_ch_ori + pixel_ch_stride) :
//(is_stripe_end & dl_block_end & ~dl_channel_end) ? (pixel_w_ori + dl_in_pd_d0[16:10]) :
                        (is_stripe_end & dl_block_end & next_is_last_channel) ? (pixel_w_ori + pixel_x_init_offset) :
                        (is_stripe_end & dl_block_end & ~next_is_last_channel) ? (pixel_w_ori + 8'h08  ) :
                        (is_stripe_end & ~dl_block_end) ? {1'b0, pixel_w_ori} :
                        (pixel_w_cnt + pixel_x_cnt_add);
assign pixel_w_cur = {{3 -1{1'b0}},pixel_w_cnt[15:3]}; //by entry 
assign pixel_w_cnt_reg_en = layer_st_d1 | (dat_exec_valid & is_img_d1[2] & (is_sub_h_end | is_w_end));
assign pixel_w_ori_reg_en = layer_st_d1 | (dat_exec_valid & is_img_d1[3] & is_stripe_end & dl_block_end);
assign pixel_ch_ori_reg_en = layer_st_d1 | (dat_exec_valid & is_img_d1[4] & is_stripe_end & dl_block_end & dl_channel_end);
assign pixel_force_fetch = (is_img_d1[0] & dat_req_stripe_st) ? 1'b1 : (pixel_force_clr_d1) ? 1'b0 : pixel_force_fetch_d1;
assign pixel_force_clr = is_img_d1[0] & is_sub_h_end & (pixel_force_fetch | pixel_force_fetch_d1);
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"datain_w_cnt_reg_en\" -d \"datain_w_cnt_w\" -q datain_w_cnt");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"datain_w_ori_reg_en\" -d \"datain_w_cnt_w\" -q datain_w_ori");
//: &eperl::flop("-nodeclare   -rval \"{16{1'b0}}\"  -en \"pixel_w_cnt_reg_en\" -d \"pixel_w_cnt_w\" -q pixel_w_cnt");
//: &eperl::flop("-nodeclare   -rval \"{16{1'b0}}\"  -en \"pixel_w_ori_reg_en\" -d \"pixel_w_cnt_w\" -q pixel_w_ori");
//: &eperl::flop("-nodeclare   -rval \"{16{1'b0}}\"  -en \"pixel_ch_ori_reg_en\" -d \"pixel_w_cnt_w\" -q pixel_w_ch_ori");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       datain_w_cnt <= {14{1'b0}};
   end else begin
       if ((datain_w_cnt_reg_en) == 1'b1) begin
           datain_w_cnt <= datain_w_cnt_w;
       // VCS coverage off
       end else if ((datain_w_cnt_reg_en) == 1'b0) begin
       end else begin
           datain_w_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       datain_w_ori <= {14{1'b0}};
   end else begin
       if ((datain_w_ori_reg_en) == 1'b1) begin
           datain_w_ori <= datain_w_cnt_w;
       // VCS coverage off
       end else if ((datain_w_ori_reg_en) == 1'b0) begin
       end else begin
           datain_w_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_w_cnt <= {16{1'b0}};
   end else begin
       if ((pixel_w_cnt_reg_en) == 1'b1) begin
           pixel_w_cnt <= pixel_w_cnt_w;
       // VCS coverage off
       end else if ((pixel_w_cnt_reg_en) == 1'b0) begin
       end else begin
           pixel_w_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_w_ori <= {16{1'b0}};
   end else begin
       if ((pixel_w_ori_reg_en) == 1'b1) begin
           pixel_w_ori <= pixel_w_cnt_w;
       // VCS coverage off
       end else if ((pixel_w_ori_reg_en) == 1'b0) begin
       end else begin
           pixel_w_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_w_ch_ori <= {16{1'b0}};
   end else begin
       if ((pixel_ch_ori_reg_en) == 1'b1) begin
           pixel_w_ch_ori <= pixel_w_cnt_w;
       // VCS coverage off
       end else if ((pixel_ch_ori_reg_en) == 1'b0) begin
       end else begin
           pixel_w_ch_ori <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// input height coordinate counter, feature/image both  //////////////////////////
// full data cube h counter, start form negative
assign datain_h_cnt_st = (is_winograd) ? 14'b0 : 14'b0 - reg2dp_pad_top;
assign {mon_datain_h_cnt_inc, datain_h_cnt_inc} = datain_h_cnt + conv_y_stride;
assign datain_h_cnt_w = (layer_st | (is_stripe_end & dl_group_end)) ? datain_h_cnt_st :
                        (is_stripe_end & ~dl_channel_end) ? datain_h_ori :
                        is_w_end ? datain_h_cnt_inc :
                        datain_h_cnt;
assign datain_h_cnt_reg_en = layer_st | (dat_exec_valid & ((is_stripe_end & ~dl_channel_end) | is_w_end));
assign datain_h_ori_reg_en = layer_st | (dat_exec_valid & is_stripe_end & dl_channel_end);
assign dl_h_offset_ext = dl_h_offset * y_dilate;
assign {mon_datain_h_cur,datain_h_cur} = datain_h_cnt + dl_h_offset_ext + sub_h_cnt;
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"datain_h_cnt_reg_en\" -d \"datain_h_cnt_w\" -q datain_h_cnt");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"datain_h_ori_reg_en\" -d \"datain_h_cnt_w\" -q datain_h_ori");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       datain_h_cnt <= {14{1'b0}};
   end else begin
       if ((datain_h_cnt_reg_en) == 1'b1) begin
           datain_h_cnt <= datain_h_cnt_w;
       // VCS coverage off
       end else if ((datain_h_cnt_reg_en) == 1'b0) begin
       end else begin
           datain_h_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       datain_h_ori <= {14{1'b0}};
   end else begin
       if ((datain_h_ori_reg_en) == 1'b1) begin
           datain_h_ori <= datain_h_cnt_w;
       // VCS coverage off
       end else if ((datain_h_ori_reg_en) == 1'b0) begin
       end else begin
           datain_h_ori <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// fetch valid generate //////////////////////////
assign dat_conv_req_dummy = (datain_w_cur[13 ]) | (datain_w_cur > {1'b0, datain_width_cmp})
                            | (datain_h_cur[13 ]) | (datain_h_cur > {1'b0, datain_height_cmp});
assign dat_wg_req_dummy = 1'b0;
assign dat_wg_req_skip = ((|datain_w_cur[13:2]) & datain_w_cur[1] & (|stripe_cnt[6:1]));
assign dat_img_req_dummy = (datain_h_cur[13]) | (datain_h_cur > {1'b0, datain_height_cmp});
//w address(in entry) is bigger than avilable entrys
assign dat_img_req_skip = ({{15 -12{1'b0}},w_bias_w[13:2]} > entries_cmp[15 -1:0]);
assign dat_req_dummy = is_img_d1[5] ? dat_img_req_dummy : is_winograd_d1[4] ? dat_wg_req_dummy : dat_conv_req_dummy;
assign dat_req_skip = (is_winograd_d1[5] & dat_wg_req_skip) | (is_img_d1[6] & dat_img_req_skip);
assign dat_req_valid = (dat_exec_valid & ~dat_req_dummy & ~dat_req_skip);
//Add corner case
assign dat_req_sub_c_w = ~is_img_d1[7] ? datain_c_cnt[0] : dl_block_end;
assign dat_req_sub_w_w = is_winograd_d1[6] ? {1'b0, ~datain_w_cur[1]} : datain_w_cur[1:0];
assign dat_req_sub_w_st_en = dat_exec_valid & (sub_h_cnt == 2'h0);
assign dat_req_batch_index = batch_cnt;
assign dat_req_stripe_st = dl_pvld;
assign dat_req_stripe_end = is_stripe_equal & dat_pipe_valid;
assign dat_req_channel_end = dl_channel_end;
assign dat_req_layer_end = dl_layer_end;
// PKT_PACK_WIRE( nvdla_stripe_info , dat_req_ , dat_req_flag_w )
assign dat_req_flag_w[4:0] = dat_req_batch_index[4:0];
assign dat_req_flag_w[5] = dat_req_stripe_st ;
assign dat_req_flag_w[6] = dat_req_stripe_end ;
assign dat_req_flag_w[7] = dat_req_channel_end ;
assign dat_req_flag_w[8] = dat_req_layer_end ;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_req_valid\" -q dat_req_valid_d1");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"dat_exec_valid\" -d \"dat_req_sub_w_w\" -q dat_req_sub_w_d1");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"dat_exec_valid\" -d \"sub_h_cnt\" -q dat_req_sub_h_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid\" -d \"dat_req_sub_c_w\" -q dat_req_sub_c_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid\" -d \"is_last_channel\" -q dat_req_ch_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid\" -d \"dat_req_dummy\" -q dat_req_dummy_d1");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"dat_exec_valid\" -d \"dl_cur_sub_h\" -q dat_req_cur_sub_h_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_req_sub_w_st_en\" -d \"dat_req_stripe_st\" -q dat_req_sub_w_st_d1");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"dat_exec_valid\" -d \"dat_req_flag_w\" -q dat_req_flag_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid\" -d \"dl_dat_release & is_stripe_equal & dat_pipe_valid\" -q dat_req_rls_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid\" -d \"pixel_force_fetch\" -q pixel_force_fetch_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid\" -d \"pixel_force_clr\" -q pixel_force_clr_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_valid_d1 <= 1'b0;
   end else begin
       dat_req_valid_d1 <= dat_req_valid;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_w_d1 <= {2{1'b0}};
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_sub_w_d1 <= dat_req_sub_w_w;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_sub_w_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_h_d1 <= {2{1'b0}};
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_sub_h_d1 <= sub_h_cnt;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_sub_h_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_c_d1 <= 1'b0;
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_sub_c_d1 <= dat_req_sub_c_w;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_sub_c_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_ch_end_d1 <= 1'b0;
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_ch_end_d1 <= is_last_channel;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_ch_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_dummy_d1 <= 1'b0;
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_dummy_d1 <= dat_req_dummy;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_dummy_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_cur_sub_h_d1 <= {2{1'b0}};
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_cur_sub_h_d1 <= dl_cur_sub_h;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_cur_sub_h_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_w_st_d1 <= 1'b0;
   end else begin
       if ((dat_req_sub_w_st_en) == 1'b1) begin
           dat_req_sub_w_st_d1 <= dat_req_stripe_st;
       // VCS coverage off
       end else if ((dat_req_sub_w_st_en) == 1'b0) begin
       end else begin
           dat_req_sub_w_st_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_flag_d1 <= {9{1'b0}};
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_flag_d1 <= dat_req_flag_w;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_flag_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_rls_d1 <= 1'b0;
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           dat_req_rls_d1 <= dl_dat_release & is_stripe_equal & dat_pipe_valid;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           dat_req_rls_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_force_fetch_d1 <= 1'b0;
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           pixel_force_fetch_d1 <= pixel_force_fetch;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           pixel_force_fetch_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_force_clr_d1 <= 1'b0;
   end else begin
       if ((dat_exec_valid) == 1'b1) begin
           pixel_force_clr_d1 <= pixel_force_clr;
       // VCS coverage off
       end else if ((dat_exec_valid) == 1'b0) begin
       end else begin
           pixel_force_clr_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// generate data read address                         /////
//////////////////////////////////////////////////////////////
////////////////////////// data read index generator: 1st stage //////////////////////////
//channel bias, by w_in element
//assign c_bias_add = (~is_img_d1[8] & datain_c_cnt[0]) ? datain_width[12 -1:0] : 12'b0;
assign c_bias_add = (~is_img_d1[8]) ? datain_width[12 -1:0] : 12'b0;
assign {mon_c_bias_w, c_bias_w} = layer_st ? 13'b0 : (is_stripe_end & dl_channel_end) ? 13'b0 : c_bias + c_bias_add;
assign c_bias_reg_en = layer_st | (dat_exec_valid & is_stripe_end & dl_block_end);
assign c_bias_d1_reg_en = (c_bias != c_bias_d1);
//height bias, by element
assign {mon_h_bias_0_w,h_bias_0_w} = datain_h_cnt[13:0] * h_bias_0_stride;
assign {mon_h_bias_1_w,h_bias_1_w} = dl_h_offset * h_bias_1_stride;
assign {mon_h_bias_2_w,h_bias_2_w} = batch_cnt * h_bias_2_stride;
assign {mon_h_bias_3_w,h_bias_3_w} = layer_st ? 13'b0 :sub_h_cnt * h_bias_3_stride;
assign h_bias_reg_en[0] = dat_exec_valid;
assign h_bias_reg_en[1] = layer_st | (dat_exec_valid & (is_winograd_d1[7] | is_img_d1[9]));
//width bias, by entry in image, by element in feature data
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_1
assign w_bias_int8 = is_img_d1[10] ? {pixel_w_cur} : //by entry in image 
                     is_winograd_d1[8] ? {1'b0, datain_w_cnt} :
                     (~is_last_channel | datain_c_cnt[0] | is_winograd_d1[8]) ? {2'b0,datain_w_cur[12:0]} ://by element
                     {2'b0, datain_w_cur[12:0]}; //by element, last channel and current c is even, atomC=atomM
`endif
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_2
assign w_bias_int8 = is_img_d1[10] ? {pixel_w_cur} : //by entry in image 
                     is_winograd_d1[8] ? {1'b0, datain_w_cnt} :
                     (~is_last_channel | is_winograd_d1[8]) ? {2'b0,datain_w_cur[12:0]} ://not last channel, by element
                     (dat_req_bytes > 8'h04) ? {2'b0,datain_w_cur[12:0]} : //last channel & request >1/2*entry
                     {3'b0, datain_w_cur[12:1]}; //last channel & request<=1/2*entry
`endif
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_4
assign w_bias_int8 = is_img_d1[10] ? {pixel_w_cur} : //by entry in image 
                     is_winograd_d1[8] ? {1'b0, datain_w_cnt} :
                     (~is_last_channel | is_winograd_d1[8]) ? {2'b0,datain_w_cur[12:0]} ://not last channel, by element
                     (dat_req_bytes > 8'h04) ? {2'b0,datain_w_cur[12:0]} : //last channel & request >1/2*entry
                     (dat_req_bytes <= 8'h2) ? {4'b0, datain_w_cur[12:2]} : //last channel & request <=1/4*entry
                     {3'b0, datain_w_cur[12:1]}; //last channel & (1/4*entry<request<=1/2*entry)
`endif
assign w_bias_w = w_bias_int8[13:0];
assign w_bias_reg_en = dat_exec_valid;
assign dat_req_base_d1 = dat_entry_st[14 -1:0];
//: my $kk=14;
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"c_bias_reg_en\" -d \"c_bias_w\" -q c_bias");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"c_bias_d1_reg_en\" -d \"c_bias\" -q c_bias_d1");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"h_bias_reg_en[0]\" -d \"h_bias_0_w\" -q h_bias_0_d1");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"h_bias_reg_en[0]\" -d \"h_bias_1_w\" -q h_bias_1_d1");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"h_bias_reg_en[0]\" -d \"h_bias_2_w\" -q h_bias_2_d1");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"h_bias_reg_en[1]\" -d \"h_bias_3_w\" -q h_bias_3_d1");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"w_bias_reg_en\" -d \"w_bias_w\" -q w_bias_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       c_bias <= {14{1'b0}};
   end else begin
       if ((c_bias_reg_en) == 1'b1) begin
           c_bias <= c_bias_w;
       // VCS coverage off
       end else if ((c_bias_reg_en) == 1'b0) begin
       end else begin
           c_bias <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       c_bias_d1 <= {14{1'b0}};
   end else begin
       if ((c_bias_d1_reg_en) == 1'b1) begin
           c_bias_d1 <= c_bias;
       // VCS coverage off
       end else if ((c_bias_d1_reg_en) == 1'b0) begin
       end else begin
           c_bias_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_bias_0_d1 <= {14{1'b0}};
   end else begin
       if ((h_bias_reg_en[0]) == 1'b1) begin
           h_bias_0_d1 <= h_bias_0_w;
       // VCS coverage off
       end else if ((h_bias_reg_en[0]) == 1'b0) begin
       end else begin
           h_bias_0_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_bias_1_d1 <= {14{1'b0}};
   end else begin
       if ((h_bias_reg_en[0]) == 1'b1) begin
           h_bias_1_d1 <= h_bias_1_w;
       // VCS coverage off
       end else if ((h_bias_reg_en[0]) == 1'b0) begin
       end else begin
           h_bias_1_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_bias_2_d1 <= {14{1'b0}};
   end else begin
       if ((h_bias_reg_en[0]) == 1'b1) begin
           h_bias_2_d1 <= h_bias_2_w;
       // VCS coverage off
       end else if ((h_bias_reg_en[0]) == 1'b0) begin
       end else begin
           h_bias_2_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_bias_3_d1 <= {14{1'b0}};
   end else begin
       if ((h_bias_reg_en[1]) == 1'b1) begin
           h_bias_3_d1 <= h_bias_3_w;
       // VCS coverage off
       end else if ((h_bias_reg_en[1]) == 1'b0) begin
       end else begin
           h_bias_3_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       w_bias_d1 <= {14{1'b0}};
   end else begin
       if ((w_bias_reg_en) == 1'b1) begin
           w_bias_d1 <= w_bias_w;
       // VCS coverage off
       end else if ((w_bias_reg_en) == 1'b0) begin
       end else begin
           w_bias_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////// data read index generator: 2st stage //////////////////////////
wire [14 -1:0] dat_req_addr_minus1;
wire mon_dat_req_addr_minus1;
wire is_dat_req_addr_minus1_wrap;
wire [14 -1:0] dat_req_addr_minus1_wrap;
wire [14 -1:0] dat_req_addr_minus1_real;
assign {mon_h_bias_d1,h_bias_d1} = h_bias_0_d1 + h_bias_1_d1 + h_bias_2_d1 + h_bias_3_d1;
//assign {mon_dat_req_addr_sum,dat_req_addr_sum} = dat_req_base_d1 + c_bias_d1 + h_bias_d1 + w_bias_d1; //by entry
assign dat_req_addr_sum = dat_req_base_d1 + c_bias_d1 + h_bias_d1 + w_bias_d1; //by entry
assign is_dat_req_addr_wrap = (dat_req_addr_sum >= {1'b0,data_bank, {9{1'b0}}});
assign {mon_dat_req_addr_wrap,dat_req_addr_wrap} = dat_req_addr_sum[14:0] - {1'b0,data_bank, {9{1'b0}}};
assign dat_req_addr_w = (layer_st | dat_req_dummy_d1) ? {14{1'b1}} : is_dat_req_addr_wrap ? dat_req_addr_wrap : dat_req_addr_sum[14 -1:0]; //get the adress sends to cbuf
assign {mon_dat_req_addr_minus1,dat_req_addr_minus1} = dat_req_addr_w-1'b1;
assign is_dat_req_addr_minus1_wrap = (dat_req_addr_minus1 >= {data_bank, {9{1'b0}}}); //only one case: 0-1=ffff would introduce wrap  
assign dat_req_addr_minus1_wrap = {data_bank, {9{1'b1}}};
assign dat_req_addr_minus1_real = is_dat_req_addr_minus1_wrap ? dat_req_addr_minus1_wrap : dat_req_addr_minus1;
assign sc2buf_dat_rd_en_w = dat_req_valid_d1 & ((dat_req_addr_last != dat_req_addr_w) | pixel_force_fetch_d1);
assign dat_req_addr_last = (dat_req_sub_h_d1 == 2'h0) ? dat_req_sub_h_0_addr :
                           (dat_req_sub_h_d1 == 2'h1) ? dat_req_sub_h_1_addr :
                           (dat_req_sub_h_d1 == 2'h2) ? dat_req_sub_h_2_addr :
                           dat_req_sub_h_3_addr;
assign dat_req_sub_h_0_addr_en = layer_st | ((dat_req_valid_d1 | dat_req_dummy_d1) & (dat_req_sub_h_d1 == 2'h0));
assign dat_req_sub_h_1_addr_en = layer_st | ((dat_req_valid_d1 | dat_req_dummy_d1) & (dat_req_sub_h_d1 == 2'h1));
assign dat_req_sub_h_2_addr_en = layer_st | ((dat_req_valid_d1 | dat_req_dummy_d1) & (dat_req_sub_h_d1 == 2'h2));
assign dat_req_sub_h_3_addr_en = layer_st | ((dat_req_valid_d1 | dat_req_dummy_d1) & (dat_req_sub_h_d1 == 2'h3));
`ifdef CBUF_NO_SUPPORT_READ_JUMPING
wire sc2buf_dat_rd_next1_en = 1'b0;
wire sc2buf_dat_rd_next1_en_w = 1'b0;
wire sc2buf_dat_rd_shift = {7{1'b0}};
`endif
`ifdef CBUF_SUPPORT_READ_JUMPING
wire [7 -1:0] sc2buf_dat_rd_shift_w;
wire mon_sc2buf_dat_rd_shift_w;
wire sc2buf_dat_rd_next1_en_w;
wire [14 -1:0] dat_req_addr_last_plus1;
wire [14 -1:0] dat_req_addr_last_plus1_real;
wire is_dat_req_addr_last_plus1_wrap;
wire [14 -1:0] dat_req_addr_last_plus1_wrap;
wire mon_dat_req_addr_last_plus1_wrap;
wire [3:0] pixel_w_cnt_plus1;
wire stripe_begin_disable_jump_w;
//every stripe will start form the head Byte of an entry, no need to jump
assign stripe_begin_disable_jump_w = sub_h_total_g0[2] ? (stripe_cnt[6:2]==5'b0) : //stripe_cnt = 0/1/2/3
                                     sub_h_total_g0[1] ? (stripe_cnt[6:1]==6'b0) : //stripe_cnt = 0/1
                                     stripe_cnt==7'b0; //stripe_cnt = 0
//: my $kk= 3 +1;
//: &eperl::flop("-q  stripe_begin_disable_jump -d stripe_begin_disable_jump_w");
//: &eperl::flop("-wid ${kk} -q pixel_w_cnt_plus1_d1 -d pixel_w_cnt_plus1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  stripe_begin_disable_jump;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       stripe_begin_disable_jump <= 'b0;
   end else begin
       stripe_begin_disable_jump <= stripe_begin_disable_jump_w;
   end
end
reg [3:0] pixel_w_cnt_plus1_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pixel_w_cnt_plus1_d1 <= 'b0;
   end else begin
       pixel_w_cnt_plus1_d1 <= pixel_w_cnt_plus1;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dat_req_addr_last_plus1 = dat_req_addr_last+1'b1;
assign is_dat_req_addr_last_plus1_wrap = (dat_req_addr_last_plus1 >= {data_bank, {9{1'b0}}});
assign {mon_dat_req_addr_last_plus1_wrap,dat_req_addr_last_plus1_wrap} = dat_req_addr_last_plus1[14 -1:0] - {data_bank, {9{1'b0}}};
assign dat_req_addr_last_plus1_real = is_dat_req_addr_last_plus1_wrap ? dat_req_addr_last_plus1_wrap : dat_req_addr_last_plus1;
//iamge data may encounter read jump, which happens when image data_read_address - last_rd_address >= 2 entries, and read form the middle of an entry.
//then csc need read 2 entries simultaneously, then shift out unneeded part.
//this address jump should not happened in the begining of a stripe OP.
//assign sc2buf_dat_rd_next1_en_w = is_img_d1[10]&&sc2buf_dat_rd_en_w&&(pixel_x_byte_stride > 8'h08  )&&(dat_req_addr_w != dat_req_addr_last_plus1_real)
// &&(pixel_w_cnt_plus1_d1<dat_req_pipe_bytes[3:0])&&(~stripe_begin_disable_jump);
assign sc2buf_dat_rd_next1_en_w = is_img_d1[10]&&sc2buf_dat_rd_en_w&&(pixel_x_byte_stride > 8'h08  )
                                    &&(pixel_w_cnt_plus1_d1<dat_req_pipe_bytes[3:0])&&(~stripe_begin_disable_jump);
assign pixel_w_cnt_plus1 = pixel_w_cnt[3 -1:0]+1'b1;
//for no y_ext cases,the entry read form cbuf must make sure low byte aligned. High Bytes may dropped, low bytes will always be used.
//for y_ext cases, cbuf do no shift, csc will take this job.
//assign sc2buf_dat_rd_shift_w = sc2buf_dat_rd_next1_en_w ? pixel_w_cnt_plus1_d1[3 -1:0]+ 7'h08 - dat_req_pipe_bytes: //image read jump
// is_img_d1[10]&&stripe_begin_disable_jump ? {7{1'd0}}: //image read no jump,stripe's start need no shift 
// is_img_d1[10]&&(reg2dp_y_extension!=2'b0)? {7{1'd0}}: //y_ext,no need to shift,csc will shift
// //image read no jump, not image's start, not y_ext,then not all bytes are used,need shift out low bytes
// is_img_d1[10]&&(pixel_w_cnt_plus1_d1[3:0]> dat_req_pipe_bytes)&&(pixel_x_byte_stride > 8'h08  )?
// pixel_w_cnt_plus1_d1[3:0] - dat_req_pipe_bytes :
// is_img_d1[10]&&(pixel_w_cnt_plus1_d1[3:0]<= dat_req_pipe_bytes)? {7{1'd0}} :
// {7{1'd0}}; //read data, no need to shift
//only when pixel_stride>entry and fetched more data than needed, then need shift
assign {mon_sc2buf_dat_rd_shift_w, sc2buf_dat_rd_shift_w} =
        sc2buf_dat_rd_next1_en_w ? pixel_w_cnt_plus1_d1[3 -1:0]+ 7'h08 - dat_req_pipe_bytes: //image read jump
//image read no jump, not image's start,fetch more than needed,not y_ext,then not all bytes are used,need shift out low bytes
        is_img_d1[10]&&(pixel_w_cnt_plus1_d1[3:0]> dat_req_pipe_bytes[3:0])&&(~stripe_begin_disable_jump)&&(pixel_x_byte_stride > 8'h08  )?
        pixel_w_cnt_plus1_d1[3:0] - dat_req_pipe_bytes[3:0] : {7{1'd0}};
//: my $kk= 7;
//: &eperl::flop("-d sc2buf_dat_rd_next1_en_w -q sc2buf_dat_rd_next1_en");
//: &eperl::flop("-d sc2buf_dat_rd_shift_w -q sc2buf_dat_rd_shift -wid ${kk}");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  sc2buf_dat_rd_next1_en;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_dat_rd_next1_en <= 'b0;
   end else begin
       sc2buf_dat_rd_next1_en <= sc2buf_dat_rd_next1_en_w;
   end
end
reg [6:0] sc2buf_dat_rd_shift;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_dat_rd_shift <= 'b0;
   end else begin
       sc2buf_dat_rd_shift <= sc2buf_dat_rd_shift_w;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
wire [14 -1:0] sc2buf_dat_rd_addr_w;
wire [14 -1:0] sc2buf_dat_rd_next1_addr_w;
assign sc2buf_dat_rd_addr_w = sc2buf_dat_rd_next1_en_w ? dat_req_addr_minus1_real : dat_req_addr_w;
assign sc2buf_dat_rd_next1_addr_w = sc2buf_dat_rd_next1_en_w ? dat_req_addr_w : {14{1'b0}};
//: my $kk=14;
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b1}}\"  -en \"dat_req_sub_h_0_addr_en\" -d \"dat_req_addr_w\" -q dat_req_sub_h_0_addr");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b1}}\"  -en \"dat_req_sub_h_1_addr_en\" -d \"dat_req_addr_w\" -q dat_req_sub_h_1_addr");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b1}}\"  -en \"dat_req_sub_h_2_addr_en\" -d \"dat_req_addr_w\" -q dat_req_sub_h_2_addr");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b1}}\"  -en \"dat_req_sub_h_3_addr_en\" -d \"dat_req_addr_w\" -q dat_req_sub_h_3_addr");
//: my $kk=14;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sc2buf_dat_rd_en_w\" -q sc2buf_dat_rd_en");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b1}}\"  -en \"layer_st | sc2buf_dat_rd_en_w\" -d \"sc2buf_dat_rd_addr_w\" -q sc2buf_dat_rd_addr");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b1}}\"  -en \"layer_st | sc2buf_dat_rd_en_w\" -d \"sc2buf_dat_rd_next1_addr_w\" -q sc2buf_dat_rd_next1_addr");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_pipe_valid_d1\" -q dat_pipe_valid_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_exec_valid_d1\" -q dat_exec_valid_d2");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"dat_exec_valid_d1\" -d \"dat_req_sub_w_d1\" -q dat_req_sub_w_d2");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"dat_exec_valid_d1\" -d \"dat_req_sub_h_d1\" -q dat_req_sub_h_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid_d1\" -d \"dat_req_sub_c_d1\" -q dat_req_sub_c_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid_d1\" -d \"dat_req_ch_end_d1\" -q dat_req_ch_end_d2");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"dat_exec_valid_d1\" -d \"dat_req_bytes_d1\" -q dat_req_bytes_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid_d1\" -d \"dat_req_dummy_d1\" -q dat_req_dummy_d2");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"dat_exec_valid_d1\" -d \"dat_req_cur_sub_h_d1\" -q dat_req_cur_sub_h_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid_d1\" -d \"dat_req_sub_w_st_d1\" -q dat_req_sub_w_st_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"dat_exec_valid_d1\" -d \"dat_req_rls_d1\" -q dat_req_rls_d2");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"dat_exec_valid_d1\" -d \"dat_req_flag_d1\" -q dat_req_flag_d2");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_h_0_addr <= {14{1'b1}};
   end else begin
       if ((dat_req_sub_h_0_addr_en) == 1'b1) begin
           dat_req_sub_h_0_addr <= dat_req_addr_w;
       // VCS coverage off
       end else if ((dat_req_sub_h_0_addr_en) == 1'b0) begin
       end else begin
           dat_req_sub_h_0_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_h_1_addr <= {14{1'b1}};
   end else begin
       if ((dat_req_sub_h_1_addr_en) == 1'b1) begin
           dat_req_sub_h_1_addr <= dat_req_addr_w;
       // VCS coverage off
       end else if ((dat_req_sub_h_1_addr_en) == 1'b0) begin
       end else begin
           dat_req_sub_h_1_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_h_2_addr <= {14{1'b1}};
   end else begin
       if ((dat_req_sub_h_2_addr_en) == 1'b1) begin
           dat_req_sub_h_2_addr <= dat_req_addr_w;
       // VCS coverage off
       end else if ((dat_req_sub_h_2_addr_en) == 1'b0) begin
       end else begin
           dat_req_sub_h_2_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_h_3_addr <= {14{1'b1}};
   end else begin
       if ((dat_req_sub_h_3_addr_en) == 1'b1) begin
           dat_req_sub_h_3_addr <= dat_req_addr_w;
       // VCS coverage off
       end else if ((dat_req_sub_h_3_addr_en) == 1'b0) begin
       end else begin
           dat_req_sub_h_3_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_dat_rd_en <= 1'b0;
   end else begin
       sc2buf_dat_rd_en <= sc2buf_dat_rd_en_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_dat_rd_addr <= {14{1'b1}};
   end else begin
       if ((layer_st | sc2buf_dat_rd_en_w) == 1'b1) begin
           sc2buf_dat_rd_addr <= sc2buf_dat_rd_addr_w;
       // VCS coverage off
       end else if ((layer_st | sc2buf_dat_rd_en_w) == 1'b0) begin
       end else begin
           sc2buf_dat_rd_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2buf_dat_rd_next1_addr <= {14{1'b1}};
   end else begin
       if ((layer_st | sc2buf_dat_rd_en_w) == 1'b1) begin
           sc2buf_dat_rd_next1_addr <= sc2buf_dat_rd_next1_addr_w;
       // VCS coverage off
       end else if ((layer_st | sc2buf_dat_rd_en_w) == 1'b0) begin
       end else begin
           sc2buf_dat_rd_next1_addr <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_pipe_valid_d2 <= 1'b0;
   end else begin
       dat_pipe_valid_d2 <= dat_pipe_valid_d1;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_exec_valid_d2 <= 1'b0;
   end else begin
       dat_exec_valid_d2 <= dat_exec_valid_d1;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_w_d2 <= {2{1'b0}};
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_sub_w_d2 <= dat_req_sub_w_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_sub_w_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_h_d2 <= {2{1'b0}};
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_sub_h_d2 <= dat_req_sub_h_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_sub_h_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_c_d2 <= 1'b0;
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_sub_c_d2 <= dat_req_sub_c_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_sub_c_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_ch_end_d2 <= 1'b0;
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_ch_end_d2 <= dat_req_ch_end_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_ch_end_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_bytes_d2 <= {8{1'b0}};
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_bytes_d2 <= dat_req_bytes_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_bytes_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_dummy_d2 <= 1'b0;
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_dummy_d2 <= dat_req_dummy_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_dummy_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_cur_sub_h_d2 <= {2{1'b0}};
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_cur_sub_h_d2 <= dat_req_cur_sub_h_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_cur_sub_h_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_sub_w_st_d2 <= 1'b0;
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_sub_w_st_d2 <= dat_req_sub_w_st_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_sub_w_st_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_rls_d2 <= 1'b0;
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_rls_d2 <= dat_req_rls_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_rls_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_req_flag_d2 <= {9{1'b0}};
   end else begin
       if ((dat_exec_valid_d1) == 1'b1) begin
           dat_req_flag_d2 <= dat_req_flag_d1;
       // VCS coverage off
       end else if ((dat_exec_valid_d1) == 1'b0) begin
       end else begin
           dat_req_flag_d2 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// sideband pipeline                                  /////
//////////////////////////////////////////////////////////////
assign dat_req_pipe_pvld = dat_pipe_valid_d2;
assign dat_req_pipe_sub_w = dat_req_sub_w_d2;
assign dat_req_pipe_sub_h = dat_req_sub_h_d2;
assign dat_req_pipe_sub_c = dat_req_sub_c_d2;
assign dat_req_pipe_ch_end = dat_req_ch_end_d2;
assign dat_req_pipe_bytes = dat_req_bytes_d2;
assign dat_req_pipe_dummy = dat_req_dummy_d2;
assign dat_req_pipe_cur_sub_h = dat_req_cur_sub_h_d2;
assign dat_req_pipe_sub_w_st = dat_req_sub_w_st_d2;
assign dat_req_pipe_rls = dat_req_rls_d2;
assign dat_req_pipe_flag = dat_req_flag_d2;
assign dat_req_exec_pvld = dat_exec_valid_d2;
assign dat_req_exec_dummy = dat_req_dummy_d2;
assign dat_req_exec_sub_h = dat_req_sub_h_d2;
// PKT_PACK_WIRE( csc_dat_req_pkg , dat_req_pipe_ , dat_req_pipe_pd )
assign dat_req_pipe_pd[1:0] = dat_req_pipe_sub_w[1:0];
assign dat_req_pipe_pd[3:2] = dat_req_pipe_sub_h[1:0];
assign dat_req_pipe_pd[4] = dat_req_pipe_sub_c ;
assign dat_req_pipe_pd[5] = dat_req_pipe_ch_end ;
assign dat_req_pipe_pd[6] = 1'b0 ;
assign dat_req_pipe_pd[14:7] = dat_req_pipe_bytes[7:0];
assign dat_req_pipe_pd[16:15] = dat_req_pipe_cur_sub_h[1:0];
assign dat_req_pipe_pd[17] = dat_req_pipe_dummy ;
assign dat_req_pipe_pd[18] = dat_req_pipe_sub_w_st ;
assign dat_req_pipe_pd[19] = dat_req_pipe_rls ;
assign dat_req_pipe_pd[28:20] = dat_req_pipe_flag[8:0];
//add latency for data request contorl signal
//: my $pipe_depth = 6;
//: my $i;
//: my $j;
//: if($pipe_depth == 0) {
//: print "assign dat_rsp_pipe_pvld = dat_req_pipe_pvld;\n";
//: print "assign dat_rsp_pipe_pd = dat_req_pipe_pd;\n";
//: print "assign dat_rsp_exec_pvld = dat_req_exec_pvld;\n";
//: print "assign dat_rsp_exec_dummy = dat_req_exec_dummy;\n";
//: print "assign dat_rsp_exec_sub_h = dat_req_exec_sub_h;\n\n";
//: } else {
//: print "assign dat_rsp_pipe_pvld_d0 = dat_req_pipe_pvld;\n";
//: print "assign dat_rsp_pipe_pd_d0 = dat_req_pipe_pd;\n";
//: print "assign dat_rsp_exec_pvld_d0 = dat_req_exec_pvld;\n";
//: print "assign dat_rsp_exec_dummy_d0 = dat_req_exec_dummy;\n";
//: print "assign dat_rsp_exec_sub_h_d0 = dat_req_exec_sub_h;\n\n";
//: for($i = 0; $i < $pipe_depth; $i ++) {
//: $j = $i + 1;
//: &eperl::flop("-wid 1   -rval \"1'b0\"       -d \"dat_rsp_pipe_pvld_d${i}\"  -q dat_rsp_pipe_pvld_d${j}");
//: &eperl::flop("-wid 29  -rval \"{29{1'b0}}\" -en \"dat_rsp_pipe_pvld_d${i}\" -d \"dat_rsp_pipe_pd_d${i}\"    -q dat_rsp_pipe_pd_d${j}");
//: &eperl::flop("-wid 1   -rval \"1'b0\"       -d \"dat_rsp_exec_pvld_d${i}\"  -q dat_rsp_exec_pvld_d${j}");
//: &eperl::flop("-wid 1   -rval \"1'b0\"       -en \"dat_rsp_exec_pvld_d${i}\" -d \"dat_rsp_exec_dummy_d${i}\" -q dat_rsp_exec_dummy_d${j}");
//: &eperl::flop("-wid 2   -rval \"{2{1'b0}}\"  -en \"dat_rsp_exec_pvld_d${i}\" -d \"dat_rsp_exec_sub_h_d${i}\" -q dat_rsp_exec_sub_h_d${j}");
//: }
//: print "assign dat_rsp_pipe_pvld = dat_rsp_pipe_pvld_d${i};\n";
//: print "assign dat_rsp_pipe_pd = dat_rsp_pipe_pd_d${i};\n";
//: print "assign dat_rsp_exec_pvld = dat_rsp_exec_pvld_d${i};\n";
//: print "assign dat_rsp_exec_dummy = dat_rsp_exec_dummy_d${i};\n";
//: print "assign dat_rsp_exec_sub_h = dat_rsp_exec_sub_h_d${i};\n\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign dat_rsp_pipe_pvld_d0 = dat_req_pipe_pvld;
assign dat_rsp_pipe_pd_d0 = dat_req_pipe_pd;
assign dat_rsp_exec_pvld_d0 = dat_req_exec_pvld;
assign dat_rsp_exec_dummy_d0 = dat_req_exec_dummy;
assign dat_rsp_exec_sub_h_d0 = dat_req_exec_sub_h;

reg  dat_rsp_pipe_pvld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pvld_d1 <= 1'b0;
   end else begin
       dat_rsp_pipe_pvld_d1 <= dat_rsp_pipe_pvld_d0;
   end
end
reg [28:0] dat_rsp_pipe_pd_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pd_d1 <= {29{1'b0}};
   end else begin
       if ((dat_rsp_pipe_pvld_d0) == 1'b1) begin
           dat_rsp_pipe_pd_d1 <= dat_rsp_pipe_pd_d0;
       // VCS coverage off
       end else if ((dat_rsp_pipe_pvld_d0) == 1'b0) begin
       end else begin
           dat_rsp_pipe_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_exec_pvld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_pvld_d1 <= 1'b0;
   end else begin
       dat_rsp_exec_pvld_d1 <= dat_rsp_exec_pvld_d0;
   end
end
reg  dat_rsp_exec_dummy_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_dummy_d1 <= 1'b0;
   end else begin
       if ((dat_rsp_exec_pvld_d0) == 1'b1) begin
           dat_rsp_exec_dummy_d1 <= dat_rsp_exec_dummy_d0;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d0) == 1'b0) begin
       end else begin
           dat_rsp_exec_dummy_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [1:0] dat_rsp_exec_sub_h_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_sub_h_d1 <= {2{1'b0}};
   end else begin
       if ((dat_rsp_exec_pvld_d0) == 1'b1) begin
           dat_rsp_exec_sub_h_d1 <= dat_rsp_exec_sub_h_d0;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d0) == 1'b0) begin
       end else begin
           dat_rsp_exec_sub_h_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_pipe_pvld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pvld_d2 <= 1'b0;
   end else begin
       dat_rsp_pipe_pvld_d2 <= dat_rsp_pipe_pvld_d1;
   end
end
reg [28:0] dat_rsp_pipe_pd_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pd_d2 <= {29{1'b0}};
   end else begin
       if ((dat_rsp_pipe_pvld_d1) == 1'b1) begin
           dat_rsp_pipe_pd_d2 <= dat_rsp_pipe_pd_d1;
       // VCS coverage off
       end else if ((dat_rsp_pipe_pvld_d1) == 1'b0) begin
       end else begin
           dat_rsp_pipe_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_exec_pvld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_pvld_d2 <= 1'b0;
   end else begin
       dat_rsp_exec_pvld_d2 <= dat_rsp_exec_pvld_d1;
   end
end
reg  dat_rsp_exec_dummy_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_dummy_d2 <= 1'b0;
   end else begin
       if ((dat_rsp_exec_pvld_d1) == 1'b1) begin
           dat_rsp_exec_dummy_d2 <= dat_rsp_exec_dummy_d1;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d1) == 1'b0) begin
       end else begin
           dat_rsp_exec_dummy_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [1:0] dat_rsp_exec_sub_h_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_sub_h_d2 <= {2{1'b0}};
   end else begin
       if ((dat_rsp_exec_pvld_d1) == 1'b1) begin
           dat_rsp_exec_sub_h_d2 <= dat_rsp_exec_sub_h_d1;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d1) == 1'b0) begin
       end else begin
           dat_rsp_exec_sub_h_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_pipe_pvld_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pvld_d3 <= 1'b0;
   end else begin
       dat_rsp_pipe_pvld_d3 <= dat_rsp_pipe_pvld_d2;
   end
end
reg [28:0] dat_rsp_pipe_pd_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pd_d3 <= {29{1'b0}};
   end else begin
       if ((dat_rsp_pipe_pvld_d2) == 1'b1) begin
           dat_rsp_pipe_pd_d3 <= dat_rsp_pipe_pd_d2;
       // VCS coverage off
       end else if ((dat_rsp_pipe_pvld_d2) == 1'b0) begin
       end else begin
           dat_rsp_pipe_pd_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_exec_pvld_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_pvld_d3 <= 1'b0;
   end else begin
       dat_rsp_exec_pvld_d3 <= dat_rsp_exec_pvld_d2;
   end
end
reg  dat_rsp_exec_dummy_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_dummy_d3 <= 1'b0;
   end else begin
       if ((dat_rsp_exec_pvld_d2) == 1'b1) begin
           dat_rsp_exec_dummy_d3 <= dat_rsp_exec_dummy_d2;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d2) == 1'b0) begin
       end else begin
           dat_rsp_exec_dummy_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [1:0] dat_rsp_exec_sub_h_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_sub_h_d3 <= {2{1'b0}};
   end else begin
       if ((dat_rsp_exec_pvld_d2) == 1'b1) begin
           dat_rsp_exec_sub_h_d3 <= dat_rsp_exec_sub_h_d2;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d2) == 1'b0) begin
       end else begin
           dat_rsp_exec_sub_h_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_pipe_pvld_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pvld_d4 <= 1'b0;
   end else begin
       dat_rsp_pipe_pvld_d4 <= dat_rsp_pipe_pvld_d3;
   end
end
reg [28:0] dat_rsp_pipe_pd_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pd_d4 <= {29{1'b0}};
   end else begin
       if ((dat_rsp_pipe_pvld_d3) == 1'b1) begin
           dat_rsp_pipe_pd_d4 <= dat_rsp_pipe_pd_d3;
       // VCS coverage off
       end else if ((dat_rsp_pipe_pvld_d3) == 1'b0) begin
       end else begin
           dat_rsp_pipe_pd_d4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_exec_pvld_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_pvld_d4 <= 1'b0;
   end else begin
       dat_rsp_exec_pvld_d4 <= dat_rsp_exec_pvld_d3;
   end
end
reg  dat_rsp_exec_dummy_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_dummy_d4 <= 1'b0;
   end else begin
       if ((dat_rsp_exec_pvld_d3) == 1'b1) begin
           dat_rsp_exec_dummy_d4 <= dat_rsp_exec_dummy_d3;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d3) == 1'b0) begin
       end else begin
           dat_rsp_exec_dummy_d4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [1:0] dat_rsp_exec_sub_h_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_sub_h_d4 <= {2{1'b0}};
   end else begin
       if ((dat_rsp_exec_pvld_d3) == 1'b1) begin
           dat_rsp_exec_sub_h_d4 <= dat_rsp_exec_sub_h_d3;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d3) == 1'b0) begin
       end else begin
           dat_rsp_exec_sub_h_d4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_pipe_pvld_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pvld_d5 <= 1'b0;
   end else begin
       dat_rsp_pipe_pvld_d5 <= dat_rsp_pipe_pvld_d4;
   end
end
reg [28:0] dat_rsp_pipe_pd_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pd_d5 <= {29{1'b0}};
   end else begin
       if ((dat_rsp_pipe_pvld_d4) == 1'b1) begin
           dat_rsp_pipe_pd_d5 <= dat_rsp_pipe_pd_d4;
       // VCS coverage off
       end else if ((dat_rsp_pipe_pvld_d4) == 1'b0) begin
       end else begin
           dat_rsp_pipe_pd_d5 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_exec_pvld_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_pvld_d5 <= 1'b0;
   end else begin
       dat_rsp_exec_pvld_d5 <= dat_rsp_exec_pvld_d4;
   end
end
reg  dat_rsp_exec_dummy_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_dummy_d5 <= 1'b0;
   end else begin
       if ((dat_rsp_exec_pvld_d4) == 1'b1) begin
           dat_rsp_exec_dummy_d5 <= dat_rsp_exec_dummy_d4;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d4) == 1'b0) begin
       end else begin
           dat_rsp_exec_dummy_d5 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [1:0] dat_rsp_exec_sub_h_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_sub_h_d5 <= {2{1'b0}};
   end else begin
       if ((dat_rsp_exec_pvld_d4) == 1'b1) begin
           dat_rsp_exec_sub_h_d5 <= dat_rsp_exec_sub_h_d4;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d4) == 1'b0) begin
       end else begin
           dat_rsp_exec_sub_h_d5 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_pipe_pvld_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pvld_d6 <= 1'b0;
   end else begin
       dat_rsp_pipe_pvld_d6 <= dat_rsp_pipe_pvld_d5;
   end
end
reg [28:0] dat_rsp_pipe_pd_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pipe_pd_d6 <= {29{1'b0}};
   end else begin
       if ((dat_rsp_pipe_pvld_d5) == 1'b1) begin
           dat_rsp_pipe_pd_d6 <= dat_rsp_pipe_pd_d5;
       // VCS coverage off
       end else if ((dat_rsp_pipe_pvld_d5) == 1'b0) begin
       end else begin
           dat_rsp_pipe_pd_d6 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_rsp_exec_pvld_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_pvld_d6 <= 1'b0;
   end else begin
       dat_rsp_exec_pvld_d6 <= dat_rsp_exec_pvld_d5;
   end
end
reg  dat_rsp_exec_dummy_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_dummy_d6 <= 1'b0;
   end else begin
       if ((dat_rsp_exec_pvld_d5) == 1'b1) begin
           dat_rsp_exec_dummy_d6 <= dat_rsp_exec_dummy_d5;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d5) == 1'b0) begin
       end else begin
           dat_rsp_exec_dummy_d6 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [1:0] dat_rsp_exec_sub_h_d6;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_exec_sub_h_d6 <= {2{1'b0}};
   end else begin
       if ((dat_rsp_exec_pvld_d5) == 1'b1) begin
           dat_rsp_exec_sub_h_d6 <= dat_rsp_exec_sub_h_d5;
       // VCS coverage off
       end else if ((dat_rsp_exec_pvld_d5) == 1'b0) begin
       end else begin
           dat_rsp_exec_sub_h_d6 <= 'bx;
       // VCS coverage on
       end
   end
end
assign dat_rsp_pipe_pvld = dat_rsp_pipe_pvld_d6;
assign dat_rsp_pipe_pd = dat_rsp_pipe_pd_d6;
assign dat_rsp_exec_pvld = dat_rsp_exec_pvld_d6;
assign dat_rsp_exec_dummy = dat_rsp_exec_dummy_d6;
assign dat_rsp_exec_sub_h = dat_rsp_exec_sub_h_d6;


//| eperl: generated_end (DO NOT EDIT ABOVE)
// PKT_UNPACK_WIRE( csc_dat_req_pkg , dat_rsp_pipe_ , dat_rsp_pipe_pd )
assign dat_rsp_pipe_sub_w[1:0] = dat_rsp_pipe_pd[1:0];
assign dat_rsp_pipe_sub_h[1:0] = dat_rsp_pipe_pd[3:2];
assign dat_rsp_pipe_sub_c = dat_rsp_pipe_pd[4];
assign dat_rsp_pipe_ch_end = dat_rsp_pipe_pd[5];
assign dat_rsp_pipe_bytes[7:0] = dat_rsp_pipe_pd[14:7];
assign dat_rsp_pipe_cur_sub_h[1:0] = dat_rsp_pipe_pd[16:15];
assign dat_rsp_pipe_dummy = dat_rsp_pipe_pd[17];
assign dat_rsp_pipe_sub_w_st = dat_rsp_pipe_pd[18];
assign dat_rsp_pipe_rls = dat_rsp_pipe_pd[19];
assign dat_rsp_pipe_flag[8:0] = dat_rsp_pipe_pd[28:20];
//////////////////////////////////////////////////////////////
///// dl data cache                                      /////
//////////////////////////////////////////////////////////////
assign dat_l0c0_en = (sc2buf_dat_rd_valid & (dat_rsp_exec_sub_h == 2'h0));
assign dat_l1c0_en = (sc2buf_dat_rd_valid & (dat_rsp_exec_sub_h == 2'h1));
assign dat_l2c0_en = (sc2buf_dat_rd_valid & (dat_rsp_exec_sub_h == 2'h2));
assign dat_l3c0_en = (sc2buf_dat_rd_valid & (dat_rsp_exec_sub_h == 2'h3));
//only winograd/image
assign dat_l0c1_en = (dat_wg_adv & ~dat_rsp_exec_sub_h[0]) | (is_img_d1[12] & dat_l0c0_en & ~dat_l0c0_dummy);
assign dat_l1c1_en = (dat_wg_adv & dat_rsp_exec_sub_h[0]) | (is_img_d1[13] & dat_l1c0_en & ~dat_l1c0_dummy);
assign dat_l2c1_en = (is_img_d1[15] & dat_l2c0_en & ~dat_l2c0_dummy);
assign dat_l3c1_en = (is_img_d1[16] & dat_l3c0_en & ~dat_l3c0_dummy);
assign dat_dummy_l0_en = dat_rsp_exec_pvld & dat_rsp_exec_dummy & (dat_rsp_exec_sub_h == 2'h0);
assign dat_dummy_l1_en = dat_rsp_exec_pvld & dat_rsp_exec_dummy & (dat_rsp_exec_sub_h == 2'h1);
assign dat_dummy_l2_en = dat_rsp_exec_pvld & dat_rsp_exec_dummy & (dat_rsp_exec_sub_h == 2'h2);
assign dat_dummy_l3_en = dat_rsp_exec_pvld & dat_rsp_exec_dummy & (dat_rsp_exec_sub_h == 2'h3);
assign dat_wg_adv = sc2buf_dat_rd_valid & is_winograd_d1[11] & ~dat_rsp_pipe_sub_w_st;
assign dat_l0c0_dummy_w = dat_l0c0_en ? 1'b0 : dat_dummy_l0_en ? 1'b1 : dat_l0c0_dummy;
assign dat_l1c0_dummy_w = dat_l1c0_en ? 1'b0 : dat_dummy_l1_en ? 1'b1 : dat_l1c0_dummy;
assign dat_l2c0_dummy_w = dat_l2c0_en ? 1'b0 : dat_dummy_l2_en ? 1'b1 : dat_l2c0_dummy;
assign dat_l3c0_dummy_w = dat_l3c0_en ? 1'b0 : dat_dummy_l3_en ? 1'b1 : dat_l3c0_dummy;
assign dat_l0c1_dummy_w = dat_l0c1_en ? 1'b0 : (dat_l0_set) ? dat_l0c0_dummy : dat_l0c1_dummy;
assign dat_l1c1_dummy_w = dat_l1c1_en ? 1'b0 : (dat_l1_set & (|sub_h_total_g2)) ? dat_l1c0_dummy : dat_l1c1_dummy;
assign dat_l2c1_dummy_w = dat_l2c1_en ? 1'b0 : (dat_l2_set & sub_h_total_g2[1]) ? dat_l2c0_dummy : dat_l2c1_dummy;
assign dat_l3c1_dummy_w = dat_l3c1_en ? 1'b0 : (dat_l3_set & sub_h_total_g2[1]) ? dat_l3c0_dummy : dat_l3c1_dummy;
assign dat_l0_set = dat_l0c0_en | dat_dummy_l0_en;
assign dat_l1_set = dat_l1c0_en | dat_dummy_l1_en;
assign dat_l2_set = dat_l2c0_en | dat_dummy_l2_en;
assign dat_l3_set = dat_l3c0_en | dat_dummy_l3_en;
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"dat_l0c0_dummy_w\" -q dat_l0c0_dummy");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"dat_l1c0_dummy_w\" -q dat_l1c0_dummy");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"dat_l2c0_dummy_w\" -q dat_l2c0_dummy");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"dat_l3c0_dummy_w\" -q dat_l3c0_dummy");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"dat_l0c1_dummy_w\" -q dat_l0c1_dummy");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"dat_l1c1_dummy_w\" -q dat_l1c1_dummy");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"dat_l2c1_dummy_w\" -q dat_l2c1_dummy");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"dat_l3c1_dummy_w\" -q dat_l3c1_dummy");
//: &eperl::flop("-nodeclare  -norst -en \"dat_l0c0_en\" -d \"sc2buf_dat_rd_data\" -q dat_l0c0 ");
//: &eperl::flop("-nodeclare  -norst -en \"dat_l1c0_en\" -d \"sc2buf_dat_rd_data\" -q dat_l1c0 ");
//: &eperl::flop("-nodeclare  -norst -en \"dat_l2c0_en\" -d \"sc2buf_dat_rd_data\" -q dat_l2c0 ");
//: &eperl::flop("-nodeclare  -norst -en \"dat_l3c0_en\" -d \"sc2buf_dat_rd_data\" -q dat_l3c0 ");
//: &eperl::flop("-nodeclare  -norst -en \"dat_l0c1_en\" -d dat_l0c0 -q dat_l0c1 ");
//: &eperl::flop("-nodeclare  -norst -en \"dat_l1c1_en\" -d dat_l1c0 -q dat_l1c1 ");
//: &eperl::flop("-nodeclare  -norst -en \"dat_l2c1_en\" -d dat_l2c0 -q dat_l2c1 ");
//: &eperl::flop("-nodeclare  -norst -en \"dat_l3c1_en\" -d dat_l3c0 -q dat_l3c1 ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_l0c0_dummy <= 1'b1;
   end else begin
       dat_l0c0_dummy <= dat_l0c0_dummy_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_l1c0_dummy <= 1'b1;
   end else begin
       dat_l1c0_dummy <= dat_l1c0_dummy_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_l2c0_dummy <= 1'b1;
   end else begin
       dat_l2c0_dummy <= dat_l2c0_dummy_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_l3c0_dummy <= 1'b1;
   end else begin
       dat_l3c0_dummy <= dat_l3c0_dummy_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_l0c1_dummy <= 1'b1;
   end else begin
       dat_l0c1_dummy <= dat_l0c1_dummy_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_l1c1_dummy <= 1'b1;
   end else begin
       dat_l1c1_dummy <= dat_l1c1_dummy_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_l2c1_dummy <= 1'b1;
   end else begin
       dat_l2c1_dummy <= dat_l2c1_dummy_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_l3c1_dummy <= 1'b1;
   end else begin
       dat_l3c1_dummy <= dat_l3c1_dummy_w;
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_l0c0_en) == 1'b1) begin
           dat_l0c0 <= sc2buf_dat_rd_data;
       // VCS coverage off
       end else if ((dat_l0c0_en) == 1'b0) begin
       end else begin
           dat_l0c0 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_l1c0_en) == 1'b1) begin
           dat_l1c0 <= sc2buf_dat_rd_data;
       // VCS coverage off
       end else if ((dat_l1c0_en) == 1'b0) begin
       end else begin
           dat_l1c0 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_l2c0_en) == 1'b1) begin
           dat_l2c0 <= sc2buf_dat_rd_data;
       // VCS coverage off
       end else if ((dat_l2c0_en) == 1'b0) begin
       end else begin
           dat_l2c0 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_l3c0_en) == 1'b1) begin
           dat_l3c0 <= sc2buf_dat_rd_data;
       // VCS coverage off
       end else if ((dat_l3c0_en) == 1'b0) begin
       end else begin
           dat_l3c0 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_l0c1_en) == 1'b1) begin
           dat_l0c1 <= dat_l0c0;
       // VCS coverage off
       end else if ((dat_l0c1_en) == 1'b0) begin
       end else begin
           dat_l0c1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_l1c1_en) == 1'b1) begin
           dat_l1c1 <= dat_l1c0;
       // VCS coverage off
       end else if ((dat_l1c1_en) == 1'b0) begin
       end else begin
           dat_l1c1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_l2c1_en) == 1'b1) begin
           dat_l2c1 <= dat_l2c0;
       // VCS coverage off
       end else if ((dat_l2c1_en) == 1'b0) begin
       end else begin
           dat_l2c1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_l3c1_en) == 1'b1) begin
           dat_l3c1 <= dat_l3c0;
       // VCS coverage off
       end else if ((dat_l3c1_en) == 1'b0) begin
       end else begin
           dat_l3c1 <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// response contorl                                   /////
//////////////////////////////////////////////////////////////
// PKT_PACK_WIRE( csc_dat_rsp_pkg , dat_rsp_pipe_ , dat_rsp_pd_d0 )
assign dat_rsp_pd_d0[1:0] = dat_rsp_pipe_sub_w[1:0];
assign dat_rsp_pd_d0[3:2] = dat_rsp_pipe_sub_h[1:0];
assign dat_rsp_pd_d0[4] = dat_rsp_pipe_sub_c ;
assign dat_rsp_pd_d0[5] = dat_rsp_pipe_ch_end ;
assign dat_rsp_pd_d0[6] = 1'b0 ;
assign dat_rsp_pd_d0[14:7] = dat_rsp_pipe_bytes[7:0];
assign dat_rsp_pd_d0[16:15] = dat_rsp_pipe_cur_sub_h[1:0];
assign dat_rsp_pd_d0[17] = dat_rsp_pipe_rls ;
assign dat_rsp_pd_d0[26:18] = dat_rsp_pipe_flag[8:0];
//add latency
//: my $delay_depth = 4;
//: my $i;
//: my $j;
//:
//: print "assign dat_rsp_pvld_d0 = dat_rsp_pipe_pvld;\n";
//: for($i = 0; $i < $delay_depth; $i ++) {
//: $j = $i + 1;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"           -d \"dat_rsp_pvld_d${i}\"   -q dat_rsp_pvld_d${j}");
//: &eperl::flop("-nodeclare   -rval \"{27{1'b0}}\"     -en \"dat_rsp_pvld_d${i}\"  -d \"dat_rsp_pd_d${i}\" -q dat_rsp_pd_d${j}");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign dat_rsp_pvld_d0 = dat_rsp_pipe_pvld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pvld_d1 <= 1'b0;
   end else begin
       dat_rsp_pvld_d1 <= dat_rsp_pvld_d0;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pd_d1 <= {27{1'b0}};
   end else begin
       if ((dat_rsp_pvld_d0) == 1'b1) begin
           dat_rsp_pd_d1 <= dat_rsp_pd_d0;
       // VCS coverage off
       end else if ((dat_rsp_pvld_d0) == 1'b0) begin
       end else begin
           dat_rsp_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pvld_d2 <= 1'b0;
   end else begin
       dat_rsp_pvld_d2 <= dat_rsp_pvld_d1;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pd_d2 <= {27{1'b0}};
   end else begin
       if ((dat_rsp_pvld_d1) == 1'b1) begin
           dat_rsp_pd_d2 <= dat_rsp_pd_d1;
       // VCS coverage off
       end else if ((dat_rsp_pvld_d1) == 1'b0) begin
       end else begin
           dat_rsp_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pvld_d3 <= 1'b0;
   end else begin
       dat_rsp_pvld_d3 <= dat_rsp_pvld_d2;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pd_d3 <= {27{1'b0}};
   end else begin
       if ((dat_rsp_pvld_d2) == 1'b1) begin
           dat_rsp_pd_d3 <= dat_rsp_pd_d2;
       // VCS coverage off
       end else if ((dat_rsp_pvld_d2) == 1'b0) begin
       end else begin
           dat_rsp_pd_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pvld_d4 <= 1'b0;
   end else begin
       dat_rsp_pvld_d4 <= dat_rsp_pvld_d3;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pd_d4 <= {27{1'b0}};
   end else begin
       if ((dat_rsp_pvld_d3) == 1'b1) begin
           dat_rsp_pd_d4 <= dat_rsp_pd_d3;
       // VCS coverage off
       end else if ((dat_rsp_pvld_d3) == 1'b0) begin
       end else begin
           dat_rsp_pd_d4 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dat_rsp_pvld = (sub_h_total_g3[2] & dat_rsp_pvld_d4) |
                      (sub_h_total_g3[1] & dat_rsp_pvld_d2) |
                      (sub_h_total_g3[0] & dat_rsp_pvld_d1);
assign dat_rsp_l0_pvld = dat_rsp_pvld_d1;
assign dat_rsp_l1_pvld = dat_rsp_pvld_d2;
assign dat_rsp_l2_pvld = dat_rsp_pvld_d3;
assign dat_rsp_l3_pvld = dat_rsp_pvld_d4;
assign dat_rsp_pd = ({27 {sub_h_total_g4[2]}} & dat_rsp_pd_d4) |
                    ({27 {sub_h_total_g4[1]}} & dat_rsp_pd_d2) |
                    ({27 {sub_h_total_g4[0]}} & dat_rsp_pd_d1);
assign dat_rsp_l0_sub_c = dat_rsp_pd_d1[4:4];
assign dat_rsp_l1_sub_c = dat_rsp_pd_d2[4:4];
assign dat_rsp_l2_sub_c = dat_rsp_pd_d3[4:4];
assign dat_rsp_l3_sub_c = dat_rsp_pd_d4[4:4];
assign dat_rsp_l0_flag = dat_rsp_pd_d1[26:18];
assign dat_rsp_l1_flag = dat_rsp_pd_d2[26:18];
assign dat_rsp_l2_flag = dat_rsp_pd_d3[26:18];
assign dat_rsp_l3_flag = dat_rsp_pd_d4[26:18];
assign dat_rsp_l0_stripe_end = dat_rsp_l0_flag[6:6];
assign dat_rsp_l1_stripe_end = dat_rsp_l1_flag[6:6];
assign dat_rsp_l2_stripe_end = dat_rsp_l2_flag[6:6];
assign dat_rsp_l3_stripe_end = dat_rsp_l3_flag[6:6];
// PKT_UNPACK_WIRE( csc_dat_rsp_pkg , dat_rsp_ , dat_rsp_pd )
assign dat_rsp_sub_w[1:0] = dat_rsp_pd[1:0];
assign dat_rsp_sub_h[1:0] = dat_rsp_pd[3:2];
assign dat_rsp_sub_c = dat_rsp_pd[4];
assign dat_rsp_ch_end = dat_rsp_pd[5];
assign dat_rsp_bytes[7:0] = dat_rsp_pd[14:7];
assign dat_rsp_cur_sub_h[1:0] = dat_rsp_pd[16:15];
assign dat_rsp_rls = dat_rsp_pd[17];
assign dat_rsp_flag[8:0] = dat_rsp_pd[26:18];
// PKT_UNPACK_WIRE( nvdla_stripe_info , dat_rsp_ , dat_rsp_flag )
assign dat_rsp_batch_index[4:0] = dat_rsp_flag[4:0];
assign dat_rsp_stripe_st = dat_rsp_flag[5];
assign dat_rsp_stripe_end = dat_rsp_flag[6];
assign dat_rsp_channel_end = dat_rsp_flag[7];
assign dat_rsp_layer_end = dat_rsp_flag[8];
assign rsp_sft_cnt_l0_sub = dat_l0c0_en ? 8'h08   : 8'h0;
assign rsp_sft_cnt_l1_sub = dat_l1c0_en ? 8'h08   : 8'h0;
assign rsp_sft_cnt_l2_sub = dat_l2c0_en ? 8'h08   : 8'h0;
assign rsp_sft_cnt_l3_sub = dat_l3c0_en ? 8'h08   : 8'h0;
////: &eperl::retime("-O stripe_begin_disable_jump_7T -i stripe_begin_disable_jump -stage 8 -clk nvdla_core_clk");
////: &eperl::flop("-q stripe_begin_disable_jump_8T -d stripe_begin_disable_jump_7T -clk nvdla_core_clk");
assign {mon_rsp_sft_cnt_l0_w,rsp_sft_cnt_l0_inc} = (pixel_x_byte_stride > 8'h08  ) ? 8'h08   :
                                                    (rsp_sft_cnt_l0 + pixel_x_byte_stride - rsp_sft_cnt_l0_sub);
assign {mon_rsp_sft_cnt_l1_w,rsp_sft_cnt_l1_inc} = (pixel_x_byte_stride > 8'h08  ) ? 8'h08   :
                                                    (rsp_sft_cnt_l1 + pixel_x_byte_stride - rsp_sft_cnt_l1_sub);
assign {mon_rsp_sft_cnt_l2_w,rsp_sft_cnt_l2_inc} = (pixel_x_byte_stride > 8'h08  ) ? 8'h08   :
                                                    (rsp_sft_cnt_l2 + pixel_x_byte_stride - rsp_sft_cnt_l2_sub);
assign {mon_rsp_sft_cnt_l3_w,rsp_sft_cnt_l3_inc} = (pixel_x_byte_stride > 8'h08  ) ? 8'h08   :
                                                    (rsp_sft_cnt_l3 + pixel_x_byte_stride - rsp_sft_cnt_l3_sub);
//the data frm cbuf's low Bytes is always needed. High Bytes maybe unneeded.
assign dat_rsp_l0_block_end = dat_rsp_l0_sub_c;
assign dat_rsp_l1_block_end = dat_rsp_l1_sub_c;
assign dat_rsp_l2_block_end = dat_rsp_l2_sub_c;
assign dat_rsp_l3_block_end = dat_rsp_l3_sub_c;
assign rsp_sft_cnt_l0_w = (layer_st) ? 8'h08   : //begin from C0
                          (dat_rsp_l0_stripe_end & ~dat_rsp_l0_block_end) ? rsp_sft_cnt_l0_ori :
                          (dat_rsp_l0_stripe_end & dat_rsp_l0_block_end) ? 8'h08   :
                          (dat_dummy_l0_en) ? (rsp_sft_cnt_l0_inc & 8'h07) :
                          rsp_sft_cnt_l0_inc;
assign rsp_sft_cnt_l1_w = (layer_st) ? 8'h08   :
                          (dat_rsp_l1_stripe_end & ~dat_rsp_l1_block_end) ? rsp_sft_cnt_l1_ori :
                          (dat_rsp_l1_stripe_end & dat_rsp_l1_block_end) ? 8'h08   :
                          (dat_dummy_l1_en) ? (rsp_sft_cnt_l1_inc & 8'h07) :
                          rsp_sft_cnt_l1_inc;
assign rsp_sft_cnt_l2_w = (layer_st) ? 8'h08   :
                          (dat_rsp_l2_stripe_end & ~dat_rsp_l2_block_end) ? rsp_sft_cnt_l2_ori :
                          (dat_rsp_l2_stripe_end & dat_rsp_l2_block_end) ? 8'h08   :
                          (dat_dummy_l2_en) ? (rsp_sft_cnt_l2_inc & 8'h07) :
                          rsp_sft_cnt_l2_inc;
assign rsp_sft_cnt_l3_w = (layer_st) ? 8'h08   :
                          (dat_rsp_l3_stripe_end & ~dat_rsp_l3_block_end) ? rsp_sft_cnt_l3_ori :
                          (dat_rsp_l3_stripe_end & dat_rsp_l3_block_end) ? 8'h08   :
                          (dat_dummy_l3_en) ? (rsp_sft_cnt_l3_inc & 8'h07) :
                          rsp_sft_cnt_l3_inc;
assign rsp_sft_cnt_l0_en = layer_st | (is_img_d1[17] & dat_rsp_l0_pvld);
assign rsp_sft_cnt_l1_en = layer_st | (is_img_d1[18] & dat_rsp_l1_pvld & (sub_h_total_g5 != 3'h1));
assign rsp_sft_cnt_l2_en = layer_st | (is_img_d1[19] & dat_rsp_l2_pvld & (sub_h_total_g5 == 3'h4));
assign rsp_sft_cnt_l3_en = layer_st | (is_img_d1[20] & dat_rsp_l3_pvld & (sub_h_total_g5 == 3'h4));
assign rsp_sft_cnt_l0_ori_en = layer_st | (is_img_d1[21] & dat_rsp_l0_pvld & dat_rsp_l0_stripe_end & dat_rsp_l0_block_end);
assign rsp_sft_cnt_l1_ori_en = layer_st | (is_img_d1[22] & dat_rsp_l1_pvld & dat_rsp_l1_stripe_end & dat_rsp_l1_block_end & (sub_h_total_g6 != 3'h1));
assign rsp_sft_cnt_l2_ori_en = layer_st | (is_img_d1[23] & dat_rsp_l2_pvld & dat_rsp_l2_stripe_end & dat_rsp_l2_block_end & (sub_h_total_g6 == 3'h4));
assign rsp_sft_cnt_l3_ori_en = layer_st | (is_img_d1[24] & dat_rsp_l3_pvld & dat_rsp_l3_stripe_end & dat_rsp_l3_block_end & (sub_h_total_g6 == 3'h4));
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_sft_cnt_l0_en\" -d \"rsp_sft_cnt_l0_w\" -q rsp_sft_cnt_l0");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_sft_cnt_l1_en\" -d \"rsp_sft_cnt_l1_w\" -q rsp_sft_cnt_l1");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_sft_cnt_l2_en\" -d \"rsp_sft_cnt_l2_w\" -q rsp_sft_cnt_l2");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_sft_cnt_l3_en\" -d \"rsp_sft_cnt_l3_w\" -q rsp_sft_cnt_l3");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_sft_cnt_l0_ori_en\" -d \"rsp_sft_cnt_l0_w\" -q rsp_sft_cnt_l0_ori");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_sft_cnt_l1_ori_en\" -d \"rsp_sft_cnt_l1_w\" -q rsp_sft_cnt_l1_ori");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_sft_cnt_l2_ori_en\" -d \"rsp_sft_cnt_l2_w\" -q rsp_sft_cnt_l2_ori");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_sft_cnt_l3_ori_en\" -d \"rsp_sft_cnt_l3_w\" -q rsp_sft_cnt_l3_ori");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sft_cnt_l0 <= {8{1'b0}};
   end else begin
       if ((rsp_sft_cnt_l0_en) == 1'b1) begin
           rsp_sft_cnt_l0 <= rsp_sft_cnt_l0_w;
       // VCS coverage off
       end else if ((rsp_sft_cnt_l0_en) == 1'b0) begin
       end else begin
           rsp_sft_cnt_l0 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sft_cnt_l1 <= {8{1'b0}};
   end else begin
       if ((rsp_sft_cnt_l1_en) == 1'b1) begin
           rsp_sft_cnt_l1 <= rsp_sft_cnt_l1_w;
       // VCS coverage off
       end else if ((rsp_sft_cnt_l1_en) == 1'b0) begin
       end else begin
           rsp_sft_cnt_l1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sft_cnt_l2 <= {8{1'b0}};
   end else begin
       if ((rsp_sft_cnt_l2_en) == 1'b1) begin
           rsp_sft_cnt_l2 <= rsp_sft_cnt_l2_w;
       // VCS coverage off
       end else if ((rsp_sft_cnt_l2_en) == 1'b0) begin
       end else begin
           rsp_sft_cnt_l2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sft_cnt_l3 <= {8{1'b0}};
   end else begin
       if ((rsp_sft_cnt_l3_en) == 1'b1) begin
           rsp_sft_cnt_l3 <= rsp_sft_cnt_l3_w;
       // VCS coverage off
       end else if ((rsp_sft_cnt_l3_en) == 1'b0) begin
       end else begin
           rsp_sft_cnt_l3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sft_cnt_l0_ori <= {8{1'b0}};
   end else begin
       if ((rsp_sft_cnt_l0_ori_en) == 1'b1) begin
           rsp_sft_cnt_l0_ori <= rsp_sft_cnt_l0_w;
       // VCS coverage off
       end else if ((rsp_sft_cnt_l0_ori_en) == 1'b0) begin
       end else begin
           rsp_sft_cnt_l0_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sft_cnt_l1_ori <= {8{1'b0}};
   end else begin
       if ((rsp_sft_cnt_l1_ori_en) == 1'b1) begin
           rsp_sft_cnt_l1_ori <= rsp_sft_cnt_l1_w;
       // VCS coverage off
       end else if ((rsp_sft_cnt_l1_ori_en) == 1'b0) begin
       end else begin
           rsp_sft_cnt_l1_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sft_cnt_l2_ori <= {8{1'b0}};
   end else begin
       if ((rsp_sft_cnt_l2_ori_en) == 1'b1) begin
           rsp_sft_cnt_l2_ori <= rsp_sft_cnt_l2_w;
       // VCS coverage off
       end else if ((rsp_sft_cnt_l2_ori_en) == 1'b0) begin
       end else begin
           rsp_sft_cnt_l2_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sft_cnt_l3_ori <= {8{1'b0}};
   end else begin
       if ((rsp_sft_cnt_l3_ori_en) == 1'b1) begin
           rsp_sft_cnt_l3_ori <= rsp_sft_cnt_l3_w;
       // VCS coverage off
       end else if ((rsp_sft_cnt_l3_ori_en) == 1'b0) begin
       end else begin
           rsp_sft_cnt_l3_ori <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// response data                                      /////
//////////////////////////////////////////////////////////////
//////////////// data for winograd ////////////////
//winograd need future update
`ifdef NVDLA_WINOGRAD_ENABLE
//6x6x8byte matrix
assign dat_wg = ~is_winograd_d1[12] ? 2304'b0 :
                {dat_l1c0[511:256], dat_l1c1[511:384],
                dat_l1c0[255:0], dat_l1c1[255:128],
                dat_l0c0[511:256], dat_l0c1[511:384],
                dat_l0c0[255:0], dat_l0c1[255:128],
                dat_l0c0[511:256], dat_l0c1[511:384],
                dat_l0c0[255:0], dat_l0c1[255:128]};
assign dat_rsp_wg_sel_lt = (~dat_rsp_sub_h[0] & ~dat_rsp_sub_w[0]);
assign dat_rsp_wg_sel_lb = (dat_rsp_sub_h[0] & ~dat_rsp_sub_w[0]);
assign dat_rsp_wg_sel_rt = (~dat_rsp_sub_h[0] & dat_rsp_sub_w[0]);
assign dat_rsp_wg_sel_rb = (dat_rsp_sub_h[0] & dat_rsp_sub_w[0]);
assign dat_rsp_wg_sel_8b_lo = ~dat_rsp_sub_c;
assign dat_rsp_wg_sel_8b_hi = dat_rsp_sub_c;
assign dat_rsp_wg_lt = {dat_wg[1535:1280], dat_wg[1151:896], dat_wg[767:512], dat_wg[383:128]};
assign dat_rsp_wg_lb = {dat_wg[2303:2048], dat_wg[1919:1664], dat_wg[1535:1280], dat_wg[1151:896]};
assign dat_rsp_wg_rt = {dat_wg[1407:1152], dat_wg[1023:768], dat_wg[639:384], dat_wg[255:0]};
assign dat_rsp_wg_rb = {dat_wg[2175:1920], dat_wg[1791:1536], dat_wg[1407:1152], dat_wg[1023:768]};
assign dat_rsp_wg = ({1024{dat_rsp_wg_sel_lt}} & dat_rsp_wg_lt) |
                    ({1024{dat_rsp_wg_sel_lb}} & dat_rsp_wg_lb) |
                    ({1024{dat_rsp_wg_sel_rt}} & dat_rsp_wg_rt) |
                    ({1024{dat_rsp_wg_sel_rb}} & dat_rsp_wg_rb);
`endif
`ifdef NVDLA_PRINT_WINOGRAD
always @ (posedge nvdla_core_clk)
begin
    if(dat_rsp_pra_en)
    begin
        $display("[NVDLA WINOGRAD] data_pre_pra_remap  = %01024h", dat_rsp_wg);
        $display("[NVDLA WINOGRAD] data_post_pra_remap = %01024h", {dat_rsp_wg_ch3, dat_rsp_wg_ch2, dat_rsp_wg_ch1, dat_rsp_wg_ch0});
    end
end
always @ (posedge nvdla_core_clk)
begin
    if(|mon_dat_out_pra_vld)
    begin
        $display("[NVDLA WINOGRAD] data_pra_out_ch0 = %0256h", dat_pra_dat_ch0);
        $display("[NVDLA WINOGRAD] data_pra_out_ch1 = %0256h", dat_pra_dat_ch1);
        $display("[NVDLA WINOGRAD] data_pra_out_ch2 = %0256h", dat_pra_dat_ch2);
        $display("[NVDLA WINOGRAD] data_pra_out_ch3 = %0256h", dat_pra_dat_ch3);
    end
end
assign dat_wg_8b_ch0 = {{8{dat_rsp_wg[15*64+ 7]}}, dat_rsp_wg[15*64+7:15*64], {8{dat_rsp_wg[14*64+ 7]}}, dat_rsp_wg[14*64+7:14*64], {8{dat_rsp_wg[13*64+ 7]}}, dat_rsp_wg[13*64+7:13*64], {8{dat_rsp_wg[12*64+ 7]}}, dat_rsp_wg[12*64+7:12*64], {8{dat_rsp_wg[11*64+ 7]}}, dat_rsp_wg[11*64+7:11*64], {8{dat_rsp_wg[10*64+ 7]}}, dat_rsp_wg[10*64+7:10*64], {8{dat_rsp_wg[9*64+ 7]}}, dat_rsp_wg[9*64+7:9*64], {8{dat_rsp_wg[8*64+ 7]}}, dat_rsp_wg[8*64+7:8*64], {8{dat_rsp_wg[7*64+ 7]}}, dat_rsp_wg[7*64+7:7*64], {8{dat_rsp_wg[6*64+ 7]}}, dat_rsp_wg[6*64+7:6*64], {8{dat_rsp_wg[5*64+ 7]}}, dat_rsp_wg[5*64+7:5*64], {8{dat_rsp_wg[4*64+ 7]}}, dat_rsp_wg[4*64+7:4*64], {8{dat_rsp_wg[3*64+ 7]}}, dat_rsp_wg[3*64+7:3*64], {8{dat_rsp_wg[2*64+ 7]}}, dat_rsp_wg[2*64+7:2*64], {8{dat_rsp_wg[1*64+ 7]}}, dat_rsp_wg[1*64+7:1*64], {8{dat_rsp_wg[0*64+ 7]}}, dat_rsp_wg[0*64+7:0*64]};
assign dat_wg_8b_ch1 = {{8{dat_rsp_wg[15*64+15]}}, dat_rsp_wg[15*64+15:15*64+8], {8{dat_rsp_wg[14*64+15]}}, dat_rsp_wg[14*64+15:14*64+8], {8{dat_rsp_wg[13*64+15]}}, dat_rsp_wg[13*64+15:13*64+8], {8{dat_rsp_wg[12*64+15]}}, dat_rsp_wg[12*64+15:12*64+8], {8{dat_rsp_wg[11*64+15]}}, dat_rsp_wg[11*64+15:11*64+8], {8{dat_rsp_wg[10*64+15]}}, dat_rsp_wg[10*64+15:10*64+8], {8{dat_rsp_wg[9*64+15]}}, dat_rsp_wg[9*64+15:9*64+8], {8{dat_rsp_wg[8*64+15]}}, dat_rsp_wg[8*64+15:8*64+8], {8{dat_rsp_wg[7*64+15]}}, dat_rsp_wg[7*64+15:7*64+8], {8{dat_rsp_wg[6*64+15]}}, dat_rsp_wg[6*64+15:6*64+8], {8{dat_rsp_wg[5*64+15]}}, dat_rsp_wg[5*64+15:5*64+8], {8{dat_rsp_wg[4*64+15]}}, dat_rsp_wg[4*64+15:4*64+8], {8{dat_rsp_wg[3*64+15]}}, dat_rsp_wg[3*64+15:3*64+8], {8{dat_rsp_wg[2*64+15]}}, dat_rsp_wg[2*64+15:2*64+8], {8{dat_rsp_wg[1*64+15]}}, dat_rsp_wg[1*64+15:1*64+8], {8{dat_rsp_wg[0*64+15]}}, dat_rsp_wg[0*64+15:0*64+8]};
assign dat_wg_8b_ch2 = {{8{dat_rsp_wg[15*64+23]}}, dat_rsp_wg[15*64+23:15*64+16], {8{dat_rsp_wg[14*64+23]}}, dat_rsp_wg[14*64+23:14*64+16], {8{dat_rsp_wg[13*64+23]}}, dat_rsp_wg[13*64+23:13*64+16], {8{dat_rsp_wg[12*64+23]}}, dat_rsp_wg[12*64+23:12*64+16], {8{dat_rsp_wg[11*64+23]}}, dat_rsp_wg[11*64+23:11*64+16], {8{dat_rsp_wg[10*64+23]}}, dat_rsp_wg[10*64+23:10*64+16], {8{dat_rsp_wg[9*64+23]}}, dat_rsp_wg[9*64+23:9*64+16], {8{dat_rsp_wg[8*64+23]}}, dat_rsp_wg[8*64+23:8*64+16], {8{dat_rsp_wg[7*64+23]}}, dat_rsp_wg[7*64+23:7*64+16], {8{dat_rsp_wg[6*64+23]}}, dat_rsp_wg[6*64+23:6*64+16], {8{dat_rsp_wg[5*64+23]}}, dat_rsp_wg[5*64+23:5*64+16], {8{dat_rsp_wg[4*64+23]}}, dat_rsp_wg[4*64+23:4*64+16], {8{dat_rsp_wg[3*64+23]}}, dat_rsp_wg[3*64+23:3*64+16], {8{dat_rsp_wg[2*64+23]}}, dat_rsp_wg[2*64+23:2*64+16], {8{dat_rsp_wg[1*64+23]}}, dat_rsp_wg[1*64+23:1*64+16], {8{dat_rsp_wg[0*64+23]}}, dat_rsp_wg[0*64+23:0*64+16]};
assign dat_wg_8b_ch3 = {{8{dat_rsp_wg[15*64+31]}}, dat_rsp_wg[15*64+31:15*64+24], {8{dat_rsp_wg[14*64+31]}}, dat_rsp_wg[14*64+31:14*64+24], {8{dat_rsp_wg[13*64+31]}}, dat_rsp_wg[13*64+31:13*64+24], {8{dat_rsp_wg[12*64+31]}}, dat_rsp_wg[12*64+31:12*64+24], {8{dat_rsp_wg[11*64+31]}}, dat_rsp_wg[11*64+31:11*64+24], {8{dat_rsp_wg[10*64+31]}}, dat_rsp_wg[10*64+31:10*64+24], {8{dat_rsp_wg[9*64+31]}}, dat_rsp_wg[9*64+31:9*64+24], {8{dat_rsp_wg[8*64+31]}}, dat_rsp_wg[8*64+31:8*64+24], {8{dat_rsp_wg[7*64+31]}}, dat_rsp_wg[7*64+31:7*64+24], {8{dat_rsp_wg[6*64+31]}}, dat_rsp_wg[6*64+31:6*64+24], {8{dat_rsp_wg[5*64+31]}}, dat_rsp_wg[5*64+31:5*64+24], {8{dat_rsp_wg[4*64+31]}}, dat_rsp_wg[4*64+31:4*64+24], {8{dat_rsp_wg[3*64+31]}}, dat_rsp_wg[3*64+31:3*64+24], {8{dat_rsp_wg[2*64+31]}}, dat_rsp_wg[2*64+31:2*64+24], {8{dat_rsp_wg[1*64+31]}}, dat_rsp_wg[1*64+31:1*64+24], {8{dat_rsp_wg[0*64+31]}}, dat_rsp_wg[0*64+31:0*64+24]};
assign dat_wg_8b_ch4 = {{8{dat_rsp_wg[15*64+39]}}, dat_rsp_wg[15*64+39:15*64+32], {8{dat_rsp_wg[14*64+39]}}, dat_rsp_wg[14*64+39:14*64+32], {8{dat_rsp_wg[13*64+39]}}, dat_rsp_wg[13*64+39:13*64+32], {8{dat_rsp_wg[12*64+39]}}, dat_rsp_wg[12*64+39:12*64+32], {8{dat_rsp_wg[11*64+39]}}, dat_rsp_wg[11*64+39:11*64+32], {8{dat_rsp_wg[10*64+39]}}, dat_rsp_wg[10*64+39:10*64+32], {8{dat_rsp_wg[9*64+39]}}, dat_rsp_wg[9*64+39:9*64+32], {8{dat_rsp_wg[8*64+39]}}, dat_rsp_wg[8*64+39:8*64+32], {8{dat_rsp_wg[7*64+39]}}, dat_rsp_wg[7*64+39:7*64+32], {8{dat_rsp_wg[6*64+39]}}, dat_rsp_wg[6*64+39:6*64+32], {8{dat_rsp_wg[5*64+39]}}, dat_rsp_wg[5*64+39:5*64+32], {8{dat_rsp_wg[4*64+39]}}, dat_rsp_wg[4*64+39:4*64+32], {8{dat_rsp_wg[3*64+39]}}, dat_rsp_wg[3*64+39:3*64+32], {8{dat_rsp_wg[2*64+39]}}, dat_rsp_wg[2*64+39:2*64+32], {8{dat_rsp_wg[1*64+39]}}, dat_rsp_wg[1*64+39:1*64+32], {8{dat_rsp_wg[0*64+39]}}, dat_rsp_wg[0*64+39:0*64+32]};
assign dat_wg_8b_ch5 = {{8{dat_rsp_wg[15*64+47]}}, dat_rsp_wg[15*64+47:15*64+40], {8{dat_rsp_wg[14*64+47]}}, dat_rsp_wg[14*64+47:14*64+40], {8{dat_rsp_wg[13*64+47]}}, dat_rsp_wg[13*64+47:13*64+40], {8{dat_rsp_wg[12*64+47]}}, dat_rsp_wg[12*64+47:12*64+40], {8{dat_rsp_wg[11*64+47]}}, dat_rsp_wg[11*64+47:11*64+40], {8{dat_rsp_wg[10*64+47]}}, dat_rsp_wg[10*64+47:10*64+40], {8{dat_rsp_wg[9*64+47]}}, dat_rsp_wg[9*64+47:9*64+40], {8{dat_rsp_wg[8*64+47]}}, dat_rsp_wg[8*64+47:8*64+40], {8{dat_rsp_wg[7*64+47]}}, dat_rsp_wg[7*64+47:7*64+40], {8{dat_rsp_wg[6*64+47]}}, dat_rsp_wg[6*64+47:6*64+40], {8{dat_rsp_wg[5*64+47]}}, dat_rsp_wg[5*64+47:5*64+40], {8{dat_rsp_wg[4*64+47]}}, dat_rsp_wg[4*64+47:4*64+40], {8{dat_rsp_wg[3*64+47]}}, dat_rsp_wg[3*64+47:3*64+40], {8{dat_rsp_wg[2*64+47]}}, dat_rsp_wg[2*64+47:2*64+40], {8{dat_rsp_wg[1*64+47]}}, dat_rsp_wg[1*64+47:1*64+40], {8{dat_rsp_wg[0*64+47]}}, dat_rsp_wg[0*64+47:0*64+40]};
assign dat_wg_8b_ch6 = {{8{dat_rsp_wg[15*64+55]}}, dat_rsp_wg[15*64+55:15*64+48], {8{dat_rsp_wg[14*64+55]}}, dat_rsp_wg[14*64+55:14*64+48], {8{dat_rsp_wg[13*64+55]}}, dat_rsp_wg[13*64+55:13*64+48], {8{dat_rsp_wg[12*64+55]}}, dat_rsp_wg[12*64+55:12*64+48], {8{dat_rsp_wg[11*64+55]}}, dat_rsp_wg[11*64+55:11*64+48], {8{dat_rsp_wg[10*64+55]}}, dat_rsp_wg[10*64+55:10*64+48], {8{dat_rsp_wg[9*64+55]}}, dat_rsp_wg[9*64+55:9*64+48], {8{dat_rsp_wg[8*64+55]}}, dat_rsp_wg[8*64+55:8*64+48], {8{dat_rsp_wg[7*64+55]}}, dat_rsp_wg[7*64+55:7*64+48], {8{dat_rsp_wg[6*64+55]}}, dat_rsp_wg[6*64+55:6*64+48], {8{dat_rsp_wg[5*64+55]}}, dat_rsp_wg[5*64+55:5*64+48], {8{dat_rsp_wg[4*64+55]}}, dat_rsp_wg[4*64+55:4*64+48], {8{dat_rsp_wg[3*64+55]}}, dat_rsp_wg[3*64+55:3*64+48], {8{dat_rsp_wg[2*64+55]}}, dat_rsp_wg[2*64+55:2*64+48], {8{dat_rsp_wg[1*64+55]}}, dat_rsp_wg[1*64+55:1*64+48], {8{dat_rsp_wg[0*64+55]}}, dat_rsp_wg[0*64+55:0*64+48]};
assign dat_wg_8b_ch7 = {{8{dat_rsp_wg[15*64+63]}}, dat_rsp_wg[15*64+63:15*64+56], {8{dat_rsp_wg[14*64+63]}}, dat_rsp_wg[14*64+63:14*64+56], {8{dat_rsp_wg[13*64+63]}}, dat_rsp_wg[13*64+63:13*64+56], {8{dat_rsp_wg[12*64+63]}}, dat_rsp_wg[12*64+63:12*64+56], {8{dat_rsp_wg[11*64+63]}}, dat_rsp_wg[11*64+63:11*64+56], {8{dat_rsp_wg[10*64+63]}}, dat_rsp_wg[10*64+63:10*64+56], {8{dat_rsp_wg[9*64+63]}}, dat_rsp_wg[9*64+63:9*64+56], {8{dat_rsp_wg[8*64+63]}}, dat_rsp_wg[8*64+63:8*64+56], {8{dat_rsp_wg[7*64+63]}}, dat_rsp_wg[7*64+63:7*64+56], {8{dat_rsp_wg[6*64+63]}}, dat_rsp_wg[6*64+63:6*64+56], {8{dat_rsp_wg[5*64+63]}}, dat_rsp_wg[5*64+63:5*64+56], {8{dat_rsp_wg[4*64+63]}}, dat_rsp_wg[4*64+63:4*64+56], {8{dat_rsp_wg[3*64+63]}}, dat_rsp_wg[3*64+63:3*64+56], {8{dat_rsp_wg[2*64+63]}}, dat_rsp_wg[2*64+63:2*64+56], {8{dat_rsp_wg[1*64+63]}}, dat_rsp_wg[1*64+63:1*64+56], {8{dat_rsp_wg[0*64+63]}}, dat_rsp_wg[0*64+63:0*64+56]};
//winograd need future update
assign dat_rsp_wg_ch0 = ({256{dat_rsp_wg_sel_8b_lo}} & dat_wg_8b_ch0) |
                        ({256{dat_rsp_wg_sel_8b_hi}} & dat_wg_8b_ch4);
assign dat_rsp_wg_ch1 = ({256{dat_rsp_wg_sel_8b_lo}} & dat_wg_8b_ch1) |
                        ({256{dat_rsp_wg_sel_8b_hi}} & dat_wg_8b_ch5);
assign dat_rsp_wg_ch2 = ({256{dat_rsp_wg_sel_8b_lo}} & dat_wg_8b_ch2) |
                        ({256{dat_rsp_wg_sel_8b_hi}} & dat_wg_8b_ch6);
assign dat_rsp_wg_ch3 = ({256{dat_rsp_wg_sel_8b_lo}} & dat_wg_8b_ch3) |
                        ({256{dat_rsp_wg_sel_8b_hi}} & dat_wg_8b_ch7);
`endif
//////////////// data for convlution ////////////////
assign dat_rsp_pad_value = {8{pad_value[7:0]}};
assign dat_rsp_l0c0 = dat_l0c0_dummy ? dat_rsp_pad_value : dat_l0c0;
assign dat_rsp_l1c0 = dat_l1c0_dummy ? dat_rsp_pad_value : dat_l1c0;
assign dat_rsp_l2c0 = dat_l2c0_dummy ? dat_rsp_pad_value : dat_l2c0;
assign dat_rsp_l3c0 = dat_l3c0_dummy ? dat_rsp_pad_value : dat_l3c0;
assign dat_rsp_l0c1 = dat_l0c1_dummy ? dat_rsp_pad_value : dat_l0c1;
assign dat_rsp_l1c1 = dat_l1c1_dummy ? dat_rsp_pad_value : dat_l1c1;
assign dat_rsp_l2c1 = dat_l2c1_dummy ? dat_rsp_pad_value : dat_l2c1;
assign dat_rsp_l3c1 = dat_l3c1_dummy ? dat_rsp_pad_value : dat_l3c1;
//several atomM may combine together as an entry
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_1
assign dat_rsp_conv_8b = (is_winograd_d1[14] | is_img_d1[26]) ? {64{1'b0}} :
                         dat_rsp_l0c0;
`endif
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_2
assign dat_rsp_conv_8b = (is_winograd_d1[14] | is_img_d1[26]) ? {64{1'b0}} :
((dat_rsp_bytes <= 8'h04)&((dat_rsp_sub_w[0] == 1'h0))) ? {{64/2{1'b0}}, dat_rsp_l0c0[64/2 -1:0]} :
((dat_rsp_bytes <= 8'h04)&((dat_rsp_sub_w[0] == 1'h1))) ? {{64/2{1'b0}}, dat_rsp_l0c0[64 -1:64/2]} :
                dat_rsp_l0c0;
`endif
`ifdef CC_ATOMC_DIV_ATOMK_EQUAL_4
assign dat_rsp_conv_8b = (is_winograd_d1[14] | is_img_d1[26]) ? {64{1'b0}} :
((dat_rsp_bytes <= 8'h04)&(dat_rsp_bytes > 8'h2)&((dat_rsp_sub_w[0] == 1'h0))) ?
 {{64/2{1'b0}}, dat_rsp_l0c0[64/2 -1:0]} :
((dat_rsp_bytes <= 8'h04)&(dat_rsp_bytes > 8'h2)&((dat_rsp_sub_w[0] == 1'h1))) ?
 {{64/2{1'b0}}, dat_rsp_l0c0[64 -1:64/2]} :
((dat_rsp_bytes <= 8'h2) & (dat_rsp_sub_w == 2'h0)) ? {{64*3/4{1'b0}}, dat_rsp_l0c0[64/4 -1:0]} :
((dat_rsp_bytes <= 8'h2) & (dat_rsp_sub_w == 2'h1)) ? {{64*3/4{1'b0}}, dat_rsp_l0c0[64/2 -1:64/4]} :
((dat_rsp_bytes <= 8'h2) & (dat_rsp_sub_w == 2'h2)) ? {{64*3/4{1'b0}}, dat_rsp_l0c0[64*3/4 -1:64/2]} :
((dat_rsp_bytes <= 8'h2) & (dat_rsp_sub_w == 2'h3)) ? {{64*3/4{1'b0}}, dat_rsp_l0c0[64 -1:64*3/4]} :
dat_rsp_l0c0;
`endif
assign dat_rsp_conv = dat_rsp_conv_8b;
//////////////// data for image ////////////////
assign dat_rsp_l0_sft_in = ~is_img_d1[27] ? 'b0 : {dat_rsp_l0c0, dat_rsp_l0c1};
assign dat_rsp_l1_sft_in = ~is_img_d1[28] ? 'b0 : {dat_rsp_l1c0, dat_rsp_l1c1};
assign dat_rsp_l2_sft_in = ~is_img_d1[29] ? 'b0 : {dat_rsp_l2c0, dat_rsp_l2c1};
assign dat_rsp_l3_sft_in = ~is_img_d1[30] ? 'b0 : {dat_rsp_l3c0, dat_rsp_l3c1};
assign {mon_dat_rsp_l0_sft, dat_rsp_l0_sft} = dat_rsp_l0_sft_in >> {rsp_sft_cnt_l0, 3'b0};
assign {mon_dat_rsp_l1_sft, dat_rsp_l1_sft} = dat_rsp_l1_sft_in >> {rsp_sft_cnt_l1, 3'b0};
assign {mon_dat_rsp_l2_sft, dat_rsp_l2_sft} = dat_rsp_l2_sft_in >> {rsp_sft_cnt_l2, 3'b0};
assign {mon_dat_rsp_l3_sft, dat_rsp_l3_sft} = dat_rsp_l3_sft_in >> {rsp_sft_cnt_l3, 3'b0};
assign dat_rsp_img_8b = (~is_img_d1[32])? 'b0 :
                        (sub_h_total_g8 == 3'h4) ? {dat_rsp_l3_sft[64/4 -1:0], dat_rsp_l2_sft_d3[64/4 -1:0], dat_rsp_l1_sft_d3[64/4 -1:0], dat_rsp_l0_sft_d3[64/4 -1:0]} :
                        (sub_h_total_g8 == 3'h2) ? {dat_rsp_l1_sft[64/2 -1:0], dat_rsp_l0_sft_d1[64/2 -1:0]} :
                        dat_rsp_l0_sft[64 -1:0];
assign dat_rsp_img = dat_rsp_img_8b;
wire dat_rsp_sft_d1_en = dat_rsp_l0_pvld & (sub_h_total_g9 != 3'h1);
wire dat_rsp_sft_d2_en = dat_rsp_l1_pvld & (sub_h_total_g9 == 3'h4);
wire dat_rsp_sft_d3_en = dat_rsp_l2_pvld & (sub_h_total_g9 == 3'h4);
//: my $half=64/2;
//: my $quat=64/4;
//: &eperl::flop("-nodeclare -wid ${half} -norst -en \"dat_rsp_sft_d1_en\" -d \"dat_rsp_l0_sft\" -q dat_rsp_l0_sft_d1");
//: &eperl::flop("-nodeclare -wid ${quat} -norst -en \"dat_rsp_sft_d2_en\" -d \"dat_rsp_l0_sft_d1\" -q dat_rsp_l0_sft_d2");
//: &eperl::flop("-nodeclare -wid ${quat} -norst -en \"dat_rsp_sft_d3_en\" -d \"dat_rsp_l0_sft_d2\" -q dat_rsp_l0_sft_d3");
//: &eperl::flop("-nodeclare -wid ${quat} -norst -en \"dat_rsp_sft_d2_en\" -d \"dat_rsp_l1_sft\" -q dat_rsp_l1_sft_d2");
//: &eperl::flop("-nodeclare -wid ${quat} -norst -en \"dat_rsp_sft_d3_en\" -d \"dat_rsp_l1_sft_d2\" -q dat_rsp_l1_sft_d3");
//: &eperl::flop("-nodeclare -wid ${quat} -norst -en \"dat_rsp_sft_d3_en\" -d \"dat_rsp_l2_sft\" -q dat_rsp_l2_sft_d3");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_sft_d1_en) == 1'b1) begin
           dat_rsp_l0_sft_d1 <= dat_rsp_l0_sft;
       // VCS coverage off
       end else if ((dat_rsp_sft_d1_en) == 1'b0) begin
       end else begin
           dat_rsp_l0_sft_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_sft_d2_en) == 1'b1) begin
           dat_rsp_l0_sft_d2 <= dat_rsp_l0_sft_d1;
       // VCS coverage off
       end else if ((dat_rsp_sft_d2_en) == 1'b0) begin
       end else begin
           dat_rsp_l0_sft_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_sft_d3_en) == 1'b1) begin
           dat_rsp_l0_sft_d3 <= dat_rsp_l0_sft_d2;
       // VCS coverage off
       end else if ((dat_rsp_sft_d3_en) == 1'b0) begin
       end else begin
           dat_rsp_l0_sft_d3 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_sft_d2_en) == 1'b1) begin
           dat_rsp_l1_sft_d2 <= dat_rsp_l1_sft;
       // VCS coverage off
       end else if ((dat_rsp_sft_d2_en) == 1'b0) begin
       end else begin
           dat_rsp_l1_sft_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_sft_d3_en) == 1'b1) begin
           dat_rsp_l1_sft_d3 <= dat_rsp_l1_sft_d2;
       // VCS coverage off
       end else if ((dat_rsp_sft_d3_en) == 1'b0) begin
       end else begin
           dat_rsp_l1_sft_d3 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_sft_d3_en) == 1'b1) begin
           dat_rsp_l2_sft_d3 <= dat_rsp_l2_sft;
       // VCS coverage off
       end else if ((dat_rsp_sft_d3_en) == 1'b0) begin
       end else begin
           dat_rsp_l2_sft_d3 <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// byte mask ////////////////
//sub_h_total=2, each sub_h align to 1/2 entry;
//sub_h_total=4, each sub_h align to 1/4 entry;
assign dat_rsp_ori_mask = ~({8{1'b1}} << dat_rsp_bytes);
assign dat_rsp_cur_h_mask_p1 = (dat_rsp_cur_sub_h >= 2'h1) ? {8{1'b1}} : 'b0;
assign dat_rsp_cur_h_mask_p2 = (dat_rsp_cur_sub_h >= 2'h2) ? {8/2{1'b1}} : 'b0;
assign dat_rsp_cur_h_mask_p3 = (dat_rsp_cur_sub_h == 2'h3) ? {8/2{1'b1}} : 'b0;
assign dat_rsp_cur_h_e2_mask_8b = {dat_rsp_cur_h_mask_p1[8/2 -1:0], {8/2{1'b1}}};
assign dat_rsp_cur_h_e4_mask_8b = {dat_rsp_cur_h_mask_p3[8/4 -1:0], dat_rsp_cur_h_mask_p2[8/4 -1:0], dat_rsp_cur_h_mask_p1[8/4 -1:0], {8/4{1'b1}}};
assign dat_rsp_mask_8b = (sub_h_total_g11 == 3'h4) ? ({4{dat_rsp_ori_mask[8/4 -1:0]}} & dat_rsp_cur_h_e4_mask_8b) :
                         (sub_h_total_g11 == 3'h2) ? ({2{dat_rsp_ori_mask[8/2 -1:0]}} & dat_rsp_cur_h_e2_mask_8b) :
                         dat_rsp_ori_mask[8 -1:0];
assign dat_rsp_data_w = is_img_d1[33] ? dat_rsp_img :
                        dat_rsp_conv;
//: my $i;
//: my $b1;
//: my $b0;
//: my $kk=8 -1;
//: print "assign dat_rsp_mask_val_int8 = {";
//: for($i = ${kk}; $i >= 0; $i --) {
//: $b0 = sprintf("%3d", $i * 8);
//: $b1 = sprintf("%3d", $i * 8 + 7);
//: print "(|dat_rsp_data_w[${b1}:${b0}])";
//: if($i == 0) {
//: print "};\n";
//: } elsif ($i % 8 == 0) {
//: print ",\n                               ";
//: } else {
//: print ", ";
//: }
//: }
//: print "\n\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign dat_rsp_mask_val_int8 = {(|dat_rsp_data_w[ 63: 56]), (|dat_rsp_data_w[ 55: 48]), (|dat_rsp_data_w[ 47: 40]), (|dat_rsp_data_w[ 39: 32]), (|dat_rsp_data_w[ 31: 24]), (|dat_rsp_data_w[ 23: 16]), (|dat_rsp_data_w[ 15:  8]), (|dat_rsp_data_w[  7:  0])};



//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dat_rsp_mask_w = (dat_rsp_mask_8b & dat_rsp_mask_val_int8) ;
assign dat_rsp_p1_vld_w = 1'b0;
assign dat_rsp_p0_vld_w = dat_rsp_pvld & ~is_winograd_d1[16];
//////////////////////////////////////////////////////////////
///// latency register to balance with PRA cell          /////
//////////////////////////////////////////////////////////////
//: my $total_latency = 5;
//:
//: print "assign dat_out_pvld_l0 = dat_rsp_pvld;\n";
//: print "assign dat_out_flag_l0 = dat_rsp_flag;\n";
//: for(my $i = 0; $i < $total_latency; $i ++) {
//: my $j = $i + 1;
//: &eperl::flop("-wid 1   -rval \"1'b0\"       -d \"dat_out_pvld_l${i}\"   -q dat_out_pvld_l${j}");
//: &eperl::flop("-wid 9   -rval \"{9{1'b0}}\"  -en \"dat_out_pvld_l${i}\"  -d \"dat_out_flag_l${i}\" -q dat_out_flag_l${j}");
//: }
//:
//: my $k = $total_latency;
//: print "assign dat_out_pvld_w = is_winograd_d1[17] ? dat_out_pvld_l${k} : dat_rsp_pvld;\n";
//: print "assign dat_out_flag_w = is_winograd_d1[18] ? dat_out_flag_l${k} : dat_rsp_flag;\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign dat_out_pvld_l0 = dat_rsp_pvld;
assign dat_out_flag_l0 = dat_rsp_flag;
reg  dat_out_pvld_l1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_pvld_l1 <= 1'b0;
   end else begin
       dat_out_pvld_l1 <= dat_out_pvld_l0;
   end
end
reg [8:0] dat_out_flag_l1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_flag_l1 <= {9{1'b0}};
   end else begin
       if ((dat_out_pvld_l0) == 1'b1) begin
           dat_out_flag_l1 <= dat_out_flag_l0;
       // VCS coverage off
       end else if ((dat_out_pvld_l0) == 1'b0) begin
       end else begin
           dat_out_flag_l1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_out_pvld_l2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_pvld_l2 <= 1'b0;
   end else begin
       dat_out_pvld_l2 <= dat_out_pvld_l1;
   end
end
reg [8:0] dat_out_flag_l2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_flag_l2 <= {9{1'b0}};
   end else begin
       if ((dat_out_pvld_l1) == 1'b1) begin
           dat_out_flag_l2 <= dat_out_flag_l1;
       // VCS coverage off
       end else if ((dat_out_pvld_l1) == 1'b0) begin
       end else begin
           dat_out_flag_l2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_out_pvld_l3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_pvld_l3 <= 1'b0;
   end else begin
       dat_out_pvld_l3 <= dat_out_pvld_l2;
   end
end
reg [8:0] dat_out_flag_l3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_flag_l3 <= {9{1'b0}};
   end else begin
       if ((dat_out_pvld_l2) == 1'b1) begin
           dat_out_flag_l3 <= dat_out_flag_l2;
       // VCS coverage off
       end else if ((dat_out_pvld_l2) == 1'b0) begin
       end else begin
           dat_out_flag_l3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_out_pvld_l4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_pvld_l4 <= 1'b0;
   end else begin
       dat_out_pvld_l4 <= dat_out_pvld_l3;
   end
end
reg [8:0] dat_out_flag_l4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_flag_l4 <= {9{1'b0}};
   end else begin
       if ((dat_out_pvld_l3) == 1'b1) begin
           dat_out_flag_l4 <= dat_out_flag_l3;
       // VCS coverage off
       end else if ((dat_out_pvld_l3) == 1'b0) begin
       end else begin
           dat_out_flag_l4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dat_out_pvld_l5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_pvld_l5 <= 1'b0;
   end else begin
       dat_out_pvld_l5 <= dat_out_pvld_l4;
   end
end
reg [8:0] dat_out_flag_l5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_flag_l5 <= {9{1'b0}};
   end else begin
       if ((dat_out_pvld_l4) == 1'b1) begin
           dat_out_flag_l5 <= dat_out_flag_l4;
       // VCS coverage off
       end else if ((dat_out_pvld_l4) == 1'b0) begin
       end else begin
           dat_out_flag_l5 <= 'bx;
       // VCS coverage on
       end
   end
end
assign dat_out_pvld_w = is_winograd_d1[17] ? dat_out_pvld_l5 : dat_rsp_pvld;
assign dat_out_flag_w = is_winograd_d1[18] ? dat_out_flag_l5 : dat_rsp_flag;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dat_out_bypass_p0_vld_w = dat_rsp_p0_vld_w;
assign dat_out_bypass_mask_w = dat_rsp_mask_w;
assign dat_out_bypass_data_w = dat_rsp_data_w;
//: my $kk=8;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_out_pvld_w\" -q dat_out_pvld");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"dat_out_pvld_w\" -d \"dat_out_flag_w\" -q dat_out_flag");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"dat_out_bypass_p0_vld_w\" -d \"dat_out_bypass_mask_w\" -q dat_out_bypass_mask");
//: for(my $i = 0; $i < 8; $i ++) {
//: my $b0 = $i * 8;
//: my $b1 = $i * 8 + 7;
//: &eperl::flop("-nodeclare  -norst -en \"dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[${i}]\" -d \"dat_out_bypass_data_w[${b1}:${b0}]\" -q dat_out_bypass_data[${b1}:${b0}]");
//: }
//:
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_pvld <= 1'b0;
   end else begin
       dat_out_pvld <= dat_out_pvld_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_flag <= {9{1'b0}};
   end else begin
       if ((dat_out_pvld_w) == 1'b1) begin
           dat_out_flag <= dat_out_flag_w;
       // VCS coverage off
       end else if ((dat_out_pvld_w) == 1'b0) begin
       end else begin
           dat_out_flag <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_out_bypass_mask <= {8{1'b0}};
   end else begin
       if ((dat_out_bypass_p0_vld_w) == 1'b1) begin
           dat_out_bypass_mask <= dat_out_bypass_mask_w;
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w) == 1'b0) begin
       end else begin
           dat_out_bypass_mask <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[0]) == 1'b1) begin
           dat_out_bypass_data[7:0] <= dat_out_bypass_data_w[7:0];
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[0]) == 1'b0) begin
       end else begin
           dat_out_bypass_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[1]) == 1'b1) begin
           dat_out_bypass_data[15:8] <= dat_out_bypass_data_w[15:8];
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[1]) == 1'b0) begin
       end else begin
           dat_out_bypass_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[2]) == 1'b1) begin
           dat_out_bypass_data[23:16] <= dat_out_bypass_data_w[23:16];
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[2]) == 1'b0) begin
       end else begin
           dat_out_bypass_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[3]) == 1'b1) begin
           dat_out_bypass_data[31:24] <= dat_out_bypass_data_w[31:24];
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[3]) == 1'b0) begin
       end else begin
           dat_out_bypass_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[4]) == 1'b1) begin
           dat_out_bypass_data[39:32] <= dat_out_bypass_data_w[39:32];
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[4]) == 1'b0) begin
       end else begin
           dat_out_bypass_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[5]) == 1'b1) begin
           dat_out_bypass_data[47:40] <= dat_out_bypass_data_w[47:40];
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[5]) == 1'b0) begin
       end else begin
           dat_out_bypass_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[6]) == 1'b1) begin
           dat_out_bypass_data[55:48] <= dat_out_bypass_data_w[55:48];
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[6]) == 1'b0) begin
       end else begin
           dat_out_bypass_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[7]) == 1'b1) begin
           dat_out_bypass_data[63:56] <= dat_out_bypass_data_w[63:56];
       // VCS coverage off
       end else if ((dat_out_bypass_p0_vld_w & dat_out_bypass_mask_w[7]) == 1'b0) begin
       end else begin
           dat_out_bypass_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
`ifdef NVDLA_WINOGRAD_ENABLE
//////////////////////////////////////////////////////////////
///// PRA units instance                                 /////
//////////////////////////////////////////////////////////////
assign dat_rsp_pra_en = dat_rsp_pvld & is_winograd_d1[19];
assign {pra_truncate_3, pra_truncate_2, pra_truncate_1, pra_truncate_0} = pra_truncate;
assign {pra_precision_3, pra_precision_2, pra_precision_1, pra_precision_0} = pra_precision;
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"   -d \"{4{dat_rsp_pra_en}}\" -q dat_rsp_pra_en_d1");
//: &eperl::flop("-nodeclare  -norst -en \"dat_rsp_pra_en\" -d \"dat_rsp_wg_ch0\" -q dat_rsp_wg_ch0_d1");
//: &eperl::flop("-nodeclare  -norst -en \"dat_rsp_pra_en\" -d \"dat_rsp_wg_ch1\" -q dat_rsp_wg_ch1_d1");
//: &eperl::flop("-nodeclare  -norst -en \"dat_rsp_pra_en\" -d \"dat_rsp_wg_ch2\" -q dat_rsp_wg_ch2_d1");
//: &eperl::flop("-nodeclare  -norst -en \"dat_rsp_pra_en\" -d \"dat_rsp_wg_ch3\" -q dat_rsp_wg_ch3_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_rsp_pra_en_d1 <= {4{1'b0}};
   end else begin
       dat_rsp_pra_en_d1 <= {4{dat_rsp_pra_en}};
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_pra_en) == 1'b1) begin
           dat_rsp_wg_ch0_d1 <= dat_rsp_wg_ch0;
       // VCS coverage off
       end else if ((dat_rsp_pra_en) == 1'b0) begin
       end else begin
           dat_rsp_wg_ch0_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_pra_en) == 1'b1) begin
           dat_rsp_wg_ch1_d1 <= dat_rsp_wg_ch1;
       // VCS coverage off
       end else if ((dat_rsp_pra_en) == 1'b0) begin
       end else begin
           dat_rsp_wg_ch1_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_pra_en) == 1'b1) begin
           dat_rsp_wg_ch2_d1 <= dat_rsp_wg_ch2;
       // VCS coverage off
       end else if ((dat_rsp_pra_en) == 1'b0) begin
       end else begin
           dat_rsp_wg_ch2_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_rsp_pra_en) == 1'b1) begin
           dat_rsp_wg_ch3_d1 <= dat_rsp_wg_ch3;
       // VCS coverage off
       end else if ((dat_rsp_pra_en) == 1'b0) begin
       end else begin
           dat_rsp_wg_ch3_d1 <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
NV_NVDLA_CSC_pra_cell u_pra_cell_0 (
   .nvdla_core_clk (nvdla_wg_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.chn_data_in_rsc_z (dat_rsp_wg_ch0_d1[255:0]) //|< r
  ,.chn_data_in_rsc_vz (dat_rsp_pra_en_d1[0]) //|< r
// spyglass disable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.chn_data_in_rsc_lz (mon_dat_rsp_pra_rdy[0]) //|> w *
// spyglass enable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.cfg_precision (pra_precision_0[1:0]) //|< w
  ,.cfg_truncate_rsc_z (pra_truncate_0[1:0]) //|< w
  ,.chn_data_out_rsc_z (dat_pra_dat_ch0[255:0]) //|> w
  ,.chn_data_out_rsc_vz (1'b1) //|< ?
// spyglass disable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.chn_data_out_rsc_lz (mon_dat_out_pra_vld[0]) //|> w *
// spyglass enable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  );
NV_NVDLA_CSC_pra_cell u_pra_cell_1 (
   .nvdla_core_clk (nvdla_wg_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.chn_data_in_rsc_z (dat_rsp_wg_ch1_d1[255:0]) //|< r
  ,.chn_data_in_rsc_vz (dat_rsp_pra_en_d1[1]) //|< r
// spyglass disable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.chn_data_in_rsc_lz (mon_dat_rsp_pra_rdy[1]) //|> w *
// spyglass enable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.cfg_precision (pra_precision_1[1:0]) //|< w
  ,.cfg_truncate_rsc_z (pra_truncate_1[1:0]) //|< w
  ,.chn_data_out_rsc_z (dat_pra_dat_ch1[255:0]) //|> w
  ,.chn_data_out_rsc_vz (1'b1) //|< ?
// spyglass disable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.chn_data_out_rsc_lz (mon_dat_out_pra_vld[1]) //|> w *
// spyglass enable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  );
NV_NVDLA_CSC_pra_cell u_pra_cell_2 (
   .nvdla_core_clk (nvdla_wg_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.chn_data_in_rsc_z (dat_rsp_wg_ch2_d1[255:0]) //|< r
  ,.chn_data_in_rsc_vz (dat_rsp_pra_en_d1[2]) //|< r
// spyglass disable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.chn_data_in_rsc_lz (mon_dat_rsp_pra_rdy[2]) //|> w *
// spyglass enable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.cfg_precision (pra_precision_2[1:0]) //|< w
  ,.cfg_truncate_rsc_z (pra_truncate_2[1:0]) //|< w
  ,.chn_data_out_rsc_z (dat_pra_dat_ch2[255:0]) //|> w
  ,.chn_data_out_rsc_vz (1'b1) //|< ?
// spyglass disable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.chn_data_out_rsc_lz (mon_dat_out_pra_vld[2]) //|> w *
// spyglass enable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  );
NV_NVDLA_CSC_pra_cell u_pra_cell_3 (
   .nvdla_core_clk (nvdla_wg_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.chn_data_in_rsc_z (dat_rsp_wg_ch3_d1[255:0]) //|< r
  ,.chn_data_in_rsc_vz (dat_rsp_pra_en_d1[3]) //|< r
// spyglass disable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.chn_data_in_rsc_lz (mon_dat_rsp_pra_rdy[3]) //|> w *
// spyglass enable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.cfg_precision (pra_precision_3[1:0]) //|< w
  ,.cfg_truncate_rsc_z (pra_truncate_3[1:0]) //|< w
  ,.chn_data_out_rsc_z (dat_pra_dat_ch3[255:0]) //|> w
  ,.chn_data_out_rsc_vz (1'b1) //|< ?
// spyglass disable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  ,.chn_data_out_rsc_lz (mon_dat_out_pra_vld[3]) //|> w *
// spyglass enable_block UnloadedNet-ML UnloadedOutTerm-ML W528 W123 W287a
  );
assign dat_pra_dat = {dat_pra_dat_ch3, dat_pra_dat_ch2, dat_pra_dat_ch1, dat_pra_dat_ch0};
assign dat_out_wg_8b = {dat_pra_dat[1015:1008], dat_pra_dat[ 759: 752], dat_pra_dat[ 503: 496], dat_pra_dat[ 247: 240],
                       dat_pra_dat[ 999: 992], dat_pra_dat[ 743: 736], dat_pra_dat[ 487: 480], dat_pra_dat[ 231: 224],
                       dat_pra_dat[ 983: 976], dat_pra_dat[ 727: 720], dat_pra_dat[ 471: 464], dat_pra_dat[ 215: 208],
                       dat_pra_dat[ 967: 960], dat_pra_dat[ 711: 704], dat_pra_dat[ 455: 448], dat_pra_dat[ 199: 192],
                       dat_pra_dat[ 951: 944], dat_pra_dat[ 695: 688], dat_pra_dat[ 439: 432], dat_pra_dat[ 183: 176],
                       dat_pra_dat[ 935: 928], dat_pra_dat[ 679: 672], dat_pra_dat[ 423: 416], dat_pra_dat[ 167: 160],
                       dat_pra_dat[ 919: 912], dat_pra_dat[ 663: 656], dat_pra_dat[ 407: 400], dat_pra_dat[ 151: 144],
                       dat_pra_dat[ 903: 896], dat_pra_dat[ 647: 640], dat_pra_dat[ 391: 384], dat_pra_dat[ 135: 128],
                       dat_pra_dat[ 887: 880], dat_pra_dat[ 631: 624], dat_pra_dat[ 375: 368], dat_pra_dat[ 119: 112],
                       dat_pra_dat[ 871: 864], dat_pra_dat[ 615: 608], dat_pra_dat[ 359: 352], dat_pra_dat[ 103: 96],
                       dat_pra_dat[ 855: 848], dat_pra_dat[ 599: 592], dat_pra_dat[ 343: 336], dat_pra_dat[ 87: 80],
                       dat_pra_dat[ 839: 832], dat_pra_dat[ 583: 576], dat_pra_dat[ 327: 320], dat_pra_dat[ 71: 64],
                       dat_pra_dat[ 823: 816], dat_pra_dat[ 567: 560], dat_pra_dat[ 311: 304], dat_pra_dat[ 55: 48],
                       dat_pra_dat[ 807: 800], dat_pra_dat[ 551: 544], dat_pra_dat[ 295: 288], dat_pra_dat[ 39: 32],
                       dat_pra_dat[ 791: 784], dat_pra_dat[ 535: 528], dat_pra_dat[ 279: 272], dat_pra_dat[ 23: 16],
                       dat_pra_dat[ 775: 768], dat_pra_dat[ 519: 512], dat_pra_dat[ 263: 256], dat_pra_dat[ 7: 0]};
assign dat_out_wg_data = {2{dat_out_wg_8b}} ;
assign dat_out_wg_mask_int8 = {(|dat_out_wg_data[ 511: 504]), (|dat_out_wg_data[ 503: 496]), (|dat_out_wg_data[ 495: 488]), (|dat_out_wg_data[ 487: 480]), (|dat_out_wg_data[ 479: 472]), (|dat_out_wg_data[ 471: 464]), (|dat_out_wg_data[ 463: 456]), (|dat_out_wg_data[ 455: 448]),
                              (|dat_out_wg_data[ 447: 440]), (|dat_out_wg_data[ 439: 432]), (|dat_out_wg_data[ 431: 424]), (|dat_out_wg_data[ 423: 416]), (|dat_out_wg_data[ 415: 408]), (|dat_out_wg_data[ 407: 400]), (|dat_out_wg_data[ 399: 392]), (|dat_out_wg_data[ 391: 384]),
                              (|dat_out_wg_data[ 383: 376]), (|dat_out_wg_data[ 375: 368]), (|dat_out_wg_data[ 367: 360]), (|dat_out_wg_data[ 359: 352]), (|dat_out_wg_data[ 351: 344]), (|dat_out_wg_data[ 343: 336]), (|dat_out_wg_data[ 335: 328]), (|dat_out_wg_data[ 327: 320]),
                              (|dat_out_wg_data[ 319: 312]), (|dat_out_wg_data[ 311: 304]), (|dat_out_wg_data[ 303: 296]), (|dat_out_wg_data[ 295: 288]), (|dat_out_wg_data[ 287: 280]), (|dat_out_wg_data[ 279: 272]), (|dat_out_wg_data[ 271: 264]), (|dat_out_wg_data[ 263: 256]),
                              (|dat_out_wg_data[ 255: 248]), (|dat_out_wg_data[ 247: 240]), (|dat_out_wg_data[ 239: 232]), (|dat_out_wg_data[ 231: 224]), (|dat_out_wg_data[ 223: 216]), (|dat_out_wg_data[ 215: 208]), (|dat_out_wg_data[ 207: 200]), (|dat_out_wg_data[ 199: 192]),
                              (|dat_out_wg_data[ 191: 184]), (|dat_out_wg_data[ 183: 176]), (|dat_out_wg_data[ 175: 168]), (|dat_out_wg_data[ 167: 160]), (|dat_out_wg_data[ 159: 152]), (|dat_out_wg_data[ 151: 144]), (|dat_out_wg_data[ 143: 136]), (|dat_out_wg_data[ 135: 128]),
                              (|dat_out_wg_data[ 127: 120]), (|dat_out_wg_data[ 119: 112]), (|dat_out_wg_data[ 111: 104]), (|dat_out_wg_data[ 103: 96]), (|dat_out_wg_data[ 95: 88]), (|dat_out_wg_data[ 87: 80]), (|dat_out_wg_data[ 79: 72]), (|dat_out_wg_data[ 71: 64]),
                              (|dat_out_wg_data[ 63: 56]), (|dat_out_wg_data[ 55: 48]), (|dat_out_wg_data[ 47: 40]), (|dat_out_wg_data[ 39: 32]), (|dat_out_wg_data[ 31: 24]), (|dat_out_wg_data[ 23: 16]), (|dat_out_wg_data[ 15: 8]), (|dat_out_wg_data[ 7: 0])};
assign dat_out_wg_mask = {2{dat_out_wg_mask_int8}};
`else
assign dat_out_wg_data = {64{1'b0}};
assign dat_out_wg_mask = {8{1'b0}};
`endif
//////////////////////////////////////////////////////////////
///// finial registers                                   /////
//////////////////////////////////////////////////////////////
assign dat_out_data = is_winograd_d1[20] ? dat_out_wg_data : dat_out_bypass_data;
assign dat_out_mask = ~dat_out_pvld ? 'b0 : is_winograd_d1[21] ? dat_out_wg_mask : dat_out_bypass_mask;
//: my $kk=8;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dat_out_pvld\" -q dl_out_pvld");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"dat_out_pvld | dl_out_pvld\" -d \"dat_out_mask\" -q dl_out_mask");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"dat_out_pvld\" -d \"dat_out_flag\" -q dl_out_flag");
//: my $i;
//: my $b0;
//: my $b1;
//: my $kk= 8;
//: for($i = 0; $i < 8; $i ++) {
//: $b0 = $i * 8;
//: $b1 = $i * 8 + 7;
//: &eperl::flop("-wid ${kk}  -norst -en \"dat_out_mask[$i]\" -d \"dat_out_data[${b1}:${b0}]\" -q dl_out_data${i}");
//: }
//: print "\n\n\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_out_pvld <= 1'b0;
   end else begin
       dl_out_pvld <= dat_out_pvld;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_out_mask <= {8{1'b0}};
   end else begin
       if ((dat_out_pvld | dl_out_pvld) == 1'b1) begin
           dl_out_mask <= dat_out_mask;
       // VCS coverage off
       end else if ((dat_out_pvld | dl_out_pvld) == 1'b0) begin
       end else begin
           dl_out_mask <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_out_flag <= {9{1'b0}};
   end else begin
       if ((dat_out_pvld) == 1'b1) begin
           dl_out_flag <= dat_out_flag;
       // VCS coverage off
       end else if ((dat_out_pvld) == 1'b0) begin
       end else begin
           dl_out_flag <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] dl_out_data0;
always @(posedge nvdla_core_clk) begin
       if ((dat_out_mask[0]) == 1'b1) begin
           dl_out_data0 <= dat_out_data[7:0];
       // VCS coverage off
       end else if ((dat_out_mask[0]) == 1'b0) begin
       end else begin
           dl_out_data0 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dl_out_data1;
always @(posedge nvdla_core_clk) begin
       if ((dat_out_mask[1]) == 1'b1) begin
           dl_out_data1 <= dat_out_data[15:8];
       // VCS coverage off
       end else if ((dat_out_mask[1]) == 1'b0) begin
       end else begin
           dl_out_data1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dl_out_data2;
always @(posedge nvdla_core_clk) begin
       if ((dat_out_mask[2]) == 1'b1) begin
           dl_out_data2 <= dat_out_data[23:16];
       // VCS coverage off
       end else if ((dat_out_mask[2]) == 1'b0) begin
       end else begin
           dl_out_data2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dl_out_data3;
always @(posedge nvdla_core_clk) begin
       if ((dat_out_mask[3]) == 1'b1) begin
           dl_out_data3 <= dat_out_data[31:24];
       // VCS coverage off
       end else if ((dat_out_mask[3]) == 1'b0) begin
       end else begin
           dl_out_data3 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dl_out_data4;
always @(posedge nvdla_core_clk) begin
       if ((dat_out_mask[4]) == 1'b1) begin
           dl_out_data4 <= dat_out_data[39:32];
       // VCS coverage off
       end else if ((dat_out_mask[4]) == 1'b0) begin
       end else begin
           dl_out_data4 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dl_out_data5;
always @(posedge nvdla_core_clk) begin
       if ((dat_out_mask[5]) == 1'b1) begin
           dl_out_data5 <= dat_out_data[47:40];
       // VCS coverage off
       end else if ((dat_out_mask[5]) == 1'b0) begin
       end else begin
           dl_out_data5 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dl_out_data6;
always @(posedge nvdla_core_clk) begin
       if ((dat_out_mask[6]) == 1'b1) begin
           dl_out_data6 <= dat_out_data[55:48];
       // VCS coverage off
       end else if ((dat_out_mask[6]) == 1'b0) begin
       end else begin
           dl_out_data6 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dl_out_data7;
always @(posedge nvdla_core_clk) begin
       if ((dat_out_mask[7]) == 1'b1) begin
           dl_out_data7 <= dat_out_data[63:56];
       // VCS coverage off
       end else if ((dat_out_mask[7]) == 1'b0) begin
       end else begin
           dl_out_data7 <= 'bx;
       // VCS coverage on
       end
end




//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// registers for retiming                             /////
//////////////////////////////////////////////////////////////
assign sc2mac_dat_pd_w = ~dl_out_pvld ? 9'b0 : dl_out_flag;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dl_out_pvld\" -q dl_out_pvld_d1");
//: my $kk=8;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dl_out_pvld\" -q sc2mac_dat_a_pvld");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dl_out_pvld\" -q sc2mac_dat_b_pvld");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"dl_out_pvld | dl_out_pvld_d1\" -d \"sc2mac_dat_pd_w\" -q sc2mac_dat_a_pd");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"dl_out_pvld | dl_out_pvld_d1\" -d \"sc2mac_dat_pd_w\" -q sc2mac_dat_b_pd");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"dl_out_pvld | dl_out_pvld_d1\" -d \"dl_out_mask\" -q sc2mac_dat_a_mask");
//: &eperl::flop("-nodeclare   -rval \"{${kk}{1'b0}}\"  -en \"dl_out_pvld | dl_out_pvld_d1\" -d \"dl_out_mask\" -q sc2mac_dat_b_mask");
//: my $i;
//: for($i = 0; $i < 8; $i ++) {
//: &eperl::flop("-wid 8 -norst -en \"dl_out_mask[${i}]\" -d \"dl_out_data${i}\" -q sc2mac_dat_a_data${i}");
//: }
//: print "\n\n";
//:
//: for($i = 0; $i < 8; $i ++) {
//: &eperl::flop("-wid 8  -norst -en \"dl_out_mask[${i}]\" -d \"dl_out_data${i}\" -q sc2mac_dat_b_data${i}");
//: }
//: print "\n\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dl_out_pvld_d1 <= 1'b0;
   end else begin
       dl_out_pvld_d1 <= dl_out_pvld;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_a_pvld <= 1'b0;
   end else begin
       sc2mac_dat_a_pvld <= dl_out_pvld;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_b_pvld <= 1'b0;
   end else begin
       sc2mac_dat_b_pvld <= dl_out_pvld;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_a_pd <= {9{1'b0}};
   end else begin
       if ((dl_out_pvld | dl_out_pvld_d1) == 1'b1) begin
           sc2mac_dat_a_pd <= sc2mac_dat_pd_w;
       // VCS coverage off
       end else if ((dl_out_pvld | dl_out_pvld_d1) == 1'b0) begin
       end else begin
           sc2mac_dat_a_pd <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_b_pd <= {9{1'b0}};
   end else begin
       if ((dl_out_pvld | dl_out_pvld_d1) == 1'b1) begin
           sc2mac_dat_b_pd <= sc2mac_dat_pd_w;
       // VCS coverage off
       end else if ((dl_out_pvld | dl_out_pvld_d1) == 1'b0) begin
       end else begin
           sc2mac_dat_b_pd <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_a_mask <= {8{1'b0}};
   end else begin
       if ((dl_out_pvld | dl_out_pvld_d1) == 1'b1) begin
           sc2mac_dat_a_mask <= dl_out_mask;
       // VCS coverage off
       end else if ((dl_out_pvld | dl_out_pvld_d1) == 1'b0) begin
       end else begin
           sc2mac_dat_a_mask <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_b_mask <= {8{1'b0}};
   end else begin
       if ((dl_out_pvld | dl_out_pvld_d1) == 1'b1) begin
           sc2mac_dat_b_mask <= dl_out_mask;
       // VCS coverage off
       end else if ((dl_out_pvld | dl_out_pvld_d1) == 1'b0) begin
       end else begin
           sc2mac_dat_b_mask <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_a_data0;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[0]) == 1'b1) begin
           sc2mac_dat_a_data0 <= dl_out_data0;
       // VCS coverage off
       end else if ((dl_out_mask[0]) == 1'b0) begin
       end else begin
           sc2mac_dat_a_data0 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_a_data1;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[1]) == 1'b1) begin
           sc2mac_dat_a_data1 <= dl_out_data1;
       // VCS coverage off
       end else if ((dl_out_mask[1]) == 1'b0) begin
       end else begin
           sc2mac_dat_a_data1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_a_data2;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[2]) == 1'b1) begin
           sc2mac_dat_a_data2 <= dl_out_data2;
       // VCS coverage off
       end else if ((dl_out_mask[2]) == 1'b0) begin
       end else begin
           sc2mac_dat_a_data2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_a_data3;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[3]) == 1'b1) begin
           sc2mac_dat_a_data3 <= dl_out_data3;
       // VCS coverage off
       end else if ((dl_out_mask[3]) == 1'b0) begin
       end else begin
           sc2mac_dat_a_data3 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_a_data4;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[4]) == 1'b1) begin
           sc2mac_dat_a_data4 <= dl_out_data4;
       // VCS coverage off
       end else if ((dl_out_mask[4]) == 1'b0) begin
       end else begin
           sc2mac_dat_a_data4 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_a_data5;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[5]) == 1'b1) begin
           sc2mac_dat_a_data5 <= dl_out_data5;
       // VCS coverage off
       end else if ((dl_out_mask[5]) == 1'b0) begin
       end else begin
           sc2mac_dat_a_data5 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_a_data6;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[6]) == 1'b1) begin
           sc2mac_dat_a_data6 <= dl_out_data6;
       // VCS coverage off
       end else if ((dl_out_mask[6]) == 1'b0) begin
       end else begin
           sc2mac_dat_a_data6 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_a_data7;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[7]) == 1'b1) begin
           sc2mac_dat_a_data7 <= dl_out_data7;
       // VCS coverage off
       end else if ((dl_out_mask[7]) == 1'b0) begin
       end else begin
           sc2mac_dat_a_data7 <= 'bx;
       // VCS coverage on
       end
end


reg [7:0] sc2mac_dat_b_data0;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[0]) == 1'b1) begin
           sc2mac_dat_b_data0 <= dl_out_data0;
       // VCS coverage off
       end else if ((dl_out_mask[0]) == 1'b0) begin
       end else begin
           sc2mac_dat_b_data0 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_b_data1;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[1]) == 1'b1) begin
           sc2mac_dat_b_data1 <= dl_out_data1;
       // VCS coverage off
       end else if ((dl_out_mask[1]) == 1'b0) begin
       end else begin
           sc2mac_dat_b_data1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_b_data2;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[2]) == 1'b1) begin
           sc2mac_dat_b_data2 <= dl_out_data2;
       // VCS coverage off
       end else if ((dl_out_mask[2]) == 1'b0) begin
       end else begin
           sc2mac_dat_b_data2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_b_data3;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[3]) == 1'b1) begin
           sc2mac_dat_b_data3 <= dl_out_data3;
       // VCS coverage off
       end else if ((dl_out_mask[3]) == 1'b0) begin
       end else begin
           sc2mac_dat_b_data3 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_b_data4;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[4]) == 1'b1) begin
           sc2mac_dat_b_data4 <= dl_out_data4;
       // VCS coverage off
       end else if ((dl_out_mask[4]) == 1'b0) begin
       end else begin
           sc2mac_dat_b_data4 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_b_data5;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[5]) == 1'b1) begin
           sc2mac_dat_b_data5 <= dl_out_data5;
       // VCS coverage off
       end else if ((dl_out_mask[5]) == 1'b0) begin
       end else begin
           sc2mac_dat_b_data5 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_b_data6;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[6]) == 1'b1) begin
           sc2mac_dat_b_data6 <= dl_out_data6;
       // VCS coverage off
       end else if ((dl_out_mask[6]) == 1'b0) begin
       end else begin
           sc2mac_dat_b_data6 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] sc2mac_dat_b_data7;
always @(posedge nvdla_core_clk) begin
       if ((dl_out_mask[7]) == 1'b1) begin
           sc2mac_dat_b_data7 <= dl_out_data7;
       // VCS coverage off
       end else if ((dl_out_mask[7]) == 1'b0) begin
       end else begin
           sc2mac_dat_b_data7 <= 'bx;
       // VCS coverage on
       end
end



//| eperl: generated_end (DO NOT EDIT ABOVE)
`ifndef SYNTHESIS
//: for(my $i = 0; $i < 8; $i ++) {
//: print "assign dbg_csc_dat_${i} = sc2mac_dat_a_mask[${i}] ? sc2mac_dat_a_data${i} : 8'h0;\n";
//: }
//: print "\n\n\n\n";
//: print "assign dbg_csc_dat = {";
//: my $kk=8;
//: for(my $i = ${kk}-1; $i >= 0; $i --) {
//: print "dbg_csc_dat_${i}";
//: if($i != 0) {
//: print ", ";
//: } else {
//: print "};\n\n\n";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign dbg_csc_dat_0 = sc2mac_dat_a_mask[0] ? sc2mac_dat_a_data0 : 8'h0;
assign dbg_csc_dat_1 = sc2mac_dat_a_mask[1] ? sc2mac_dat_a_data1 : 8'h0;
assign dbg_csc_dat_2 = sc2mac_dat_a_mask[2] ? sc2mac_dat_a_data2 : 8'h0;
assign dbg_csc_dat_3 = sc2mac_dat_a_mask[3] ? sc2mac_dat_a_data3 : 8'h0;
assign dbg_csc_dat_4 = sc2mac_dat_a_mask[4] ? sc2mac_dat_a_data4 : 8'h0;
assign dbg_csc_dat_5 = sc2mac_dat_a_mask[5] ? sc2mac_dat_a_data5 : 8'h0;
assign dbg_csc_dat_6 = sc2mac_dat_a_mask[6] ? sc2mac_dat_a_data6 : 8'h0;
assign dbg_csc_dat_7 = sc2mac_dat_a_mask[7] ? sc2mac_dat_a_data7 : 8'h0;




assign dbg_csc_dat = {dbg_csc_dat_7, dbg_csc_dat_6, dbg_csc_dat_5, dbg_csc_dat_4, dbg_csc_dat_3, dbg_csc_dat_2, dbg_csc_dat_1, dbg_csc_dat_0};



//| eperl: generated_end (DO NOT EDIT ABOVE)
`ifdef NVDLA_PRINT_DL
always @ (posedge nvdla_core_clk)
begin
    if(layer_st)
    begin
        $display("[NVDLA DL] layer start");
    end
end
always @ (posedge nvdla_core_clk)
begin
    if(sc2mac_dat_a_pvld)
    begin
        $display("[NVDLA DL] sc2mac_dat = %01024h", dbg_csc_dat);
    end
end
`endif
`endif
endmodule // NV_NVDLA_CSC_dl
