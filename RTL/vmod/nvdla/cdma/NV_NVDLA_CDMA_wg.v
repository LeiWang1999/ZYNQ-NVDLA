// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDMA_wg.v
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
module NV_NVDLA_CDMA_wg (
   nvdla_core_clk //|< i
  ,nvdla_core_ng_clk //|< i
  ,nvdla_core_rstn //|< i
  ,mcif2wg_dat_rd_rsp_pd //|< i
  ,mcif2wg_dat_rd_rsp_valid //|< i
  ,pwrbus_ram_pd //|< i
  ,reg2dp_conv_mode //|< i
  ,reg2dp_conv_x_stride //|< i
  ,reg2dp_conv_y_stride //|< i
  ,reg2dp_data_bank //|< i
  ,reg2dp_data_reuse //|< i
  ,reg2dp_datain_addr_high_0 //|< i
  ,reg2dp_datain_addr_low_0 //|< i
  ,reg2dp_datain_channel //|< i
  ,reg2dp_datain_format //|< i
  ,reg2dp_datain_height //|< i
  ,reg2dp_datain_height_ext //|< i
  ,reg2dp_datain_ram_type //|< i
  ,reg2dp_datain_width //|< i
  ,reg2dp_datain_width_ext //|< i
  ,reg2dp_dma_en //|< i
  ,reg2dp_entries //|< i
  ,reg2dp_in_precision //|< i
  ,reg2dp_line_stride //|< i
  ,reg2dp_op_en //|< i
  ,reg2dp_pad_bottom //|< i *
  ,reg2dp_pad_left //|< i
  ,reg2dp_pad_right //|< i
  ,reg2dp_pad_top //|< i
  ,reg2dp_pad_value //|< i
  ,reg2dp_proc_precision //|< i
  ,reg2dp_skip_data_rls //|< i
  ,reg2dp_surf_stride //|< i
  ,sc2cdma_dat_pending_req //|< i
  ,status2dma_free_entries //|< i
  ,status2dma_fsm_switch //|< i
  ,status2dma_valid_slices //|< i *
  ,status2dma_wr_idx //|< i
  ,wg2sbuf_p0_rd_data //|< i
  ,wg2sbuf_p1_rd_data //|< i
  ,wg_dat2mcif_rd_req_ready //|< i
  ,dp2reg_wg_rd_latency //|> o
  ,dp2reg_wg_rd_stall //|> o
  ,mcif2wg_dat_rd_rsp_ready //|> o
  ,slcg_wg_gate_dc //|> o
  ,slcg_wg_gate_img //|> o
  ,wg2cvt_dat_wr_addr //|> o
  ,wg2cvt_dat_wr_data //|> o
  ,wg2cvt_dat_wr_en //|> o
  ,wg2cvt_dat_wr_sel //|> o
  ,wg2cvt_dat_wr_info_pd //|> o
  ,wg2sbuf_p0_rd_addr //|> o
  ,wg2sbuf_p0_rd_en //|> o
  ,wg2sbuf_p0_wr_addr //|> o
  ,wg2sbuf_p0_wr_data //|> o
  ,wg2sbuf_p0_wr_en //|> o
  ,wg2sbuf_p1_rd_addr //|> o
  ,wg2sbuf_p1_rd_en //|> o
  ,wg2sbuf_p1_wr_addr //|> o
  ,wg2sbuf_p1_wr_data //|> o
  ,wg2sbuf_p1_wr_en //|> o
  ,wg2status_dat_entries //|> o
  ,wg2status_dat_slices //|> o
  ,wg2status_dat_updt //|> o
  ,wg2status_state //|> o
  ,wg_dat2mcif_rd_req_pd //|> o
  ,wg_dat2mcif_rd_req_valid //|> o
  );
//
// NV_NVDLA_CDMA_wg_ports.v
//
input nvdla_core_clk; /* wg_dat2mcif_rd_req, wg_dat2cvif_rd_req, mcif2wg_dat_rd_rsp, cvif2wg_dat_rd_rsp, wg2cvt_dat_wr, wg2cvt_dat_wr_info, switch_status2dma, state_wg2status, dat_up_wg2status, bc_status2dma, wg2sbuf_p0_wr, wg2sbuf_p1_wr, wg2sbuf_p0_rd_nvdla_ram_addr_ADDR_WIDTH_8_BE_1, wg2sbuf_p0_rd_nvdla_ram_data_DATA_WIDTH_256, wg2sbuf_p1_rd_nvdla_ram_addr_ADDR_WIDTH_8_BE_1, wg2sbuf_p1_rd_nvdla_ram_data_DATA_WIDTH_256, sc2cdma_dat_pending */
input nvdla_core_rstn; /* wg_dat2mcif_rd_req, wg_dat2cvif_rd_req, mcif2wg_dat_rd_rsp, cvif2wg_dat_rd_rsp, wg2cvt_dat_wr, wg2cvt_dat_wr_info, switch_status2dma, state_wg2status, dat_up_wg2status, bc_status2dma, wg2sbuf_p0_wr, wg2sbuf_p1_wr, wg2sbuf_p0_rd_nvdla_ram_addr_ADDR_WIDTH_8_BE_1, wg2sbuf_p0_rd_nvdla_ram_data_DATA_WIDTH_256, wg2sbuf_p1_rd_nvdla_ram_addr_ADDR_WIDTH_8_BE_1, wg2sbuf_p1_rd_nvdla_ram_data_DATA_WIDTH_256, sc2cdma_dat_pending */
input [31:0] pwrbus_ram_pd;
output wg_dat2mcif_rd_req_valid; /* data valid */
input wg_dat2mcif_rd_req_ready; /* data return handshake */
output [78:0] wg_dat2mcif_rd_req_pd;
input mcif2wg_dat_rd_rsp_valid; /* data valid */
output mcif2wg_dat_rd_rsp_ready; /* data return handshake */
input [513:0] mcif2wg_dat_rd_rsp_pd;
output wg2cvt_dat_wr_en; /* data valid */
output [11:0] wg2cvt_dat_wr_addr;
output wg2cvt_dat_wr_sel;
output [511:0] wg2cvt_dat_wr_data;
output [11:0] wg2cvt_dat_wr_info_pd;
input status2dma_fsm_switch;
output [1:0] wg2status_state;
output wg2status_dat_updt; /* data valid */
output [14:0] wg2status_dat_entries;
output [13:0] wg2status_dat_slices;
input [13:0] status2dma_valid_slices;
input [14:0] status2dma_free_entries;
input [11:0] status2dma_wr_idx;
output wg2sbuf_p0_wr_en; /* data valid */
output [7:0] wg2sbuf_p0_wr_addr;
output [255:0] wg2sbuf_p0_wr_data;
output wg2sbuf_p1_wr_en; /* data valid */
output [7:0] wg2sbuf_p1_wr_addr;
output [255:0] wg2sbuf_p1_wr_data;
output wg2sbuf_p0_rd_en; /* data valid */
output [7:0] wg2sbuf_p0_rd_addr;
input [255:0] wg2sbuf_p0_rd_data;
output wg2sbuf_p1_rd_en; /* data valid */
output [7:0] wg2sbuf_p1_rd_addr;
input [255:0] wg2sbuf_p1_rd_data;
input sc2cdma_dat_pending_req;
input nvdla_core_ng_clk;
input [0:0] reg2dp_op_en;
input [0:0] reg2dp_conv_mode;
input [1:0] reg2dp_in_precision;
input [1:0] reg2dp_proc_precision;
input [0:0] reg2dp_data_reuse;
input [0:0] reg2dp_skip_data_rls;
input [0:0] reg2dp_datain_format;
input [12:0] reg2dp_datain_width;
input [12:0] reg2dp_datain_height;
input [12:0] reg2dp_datain_width_ext;
input [12:0] reg2dp_datain_height_ext;
input [12:0] reg2dp_datain_channel;
input [0:0] reg2dp_datain_ram_type;
input [31:0] reg2dp_datain_addr_high_0;
input [26:0] reg2dp_datain_addr_low_0;
input [26:0] reg2dp_line_stride;
input [26:0] reg2dp_surf_stride;
input [13:0] reg2dp_entries;
input [2:0] reg2dp_conv_x_stride;
input [2:0] reg2dp_conv_y_stride;
input [4:0] reg2dp_pad_left;
input [5:0] reg2dp_pad_right;
input [4:0] reg2dp_pad_top;
input [5:0] reg2dp_pad_bottom;
input [15:0] reg2dp_pad_value;
input [4:0] reg2dp_data_bank;
input [0:0] reg2dp_dma_en;
output slcg_wg_gate_dc;
output slcg_wg_gate_img;
output [31:0] dp2reg_wg_rd_stall;
output [31:0] dp2reg_wg_rd_latency;
reg [26:0] c_offset_d1;
reg [3:0] conv_x_stride;
reg [10:0] conv_xy_stride;
reg [3:0] conv_y_stride;
reg [1:0] cur_state;
reg [4:0] data_bank;
reg [14:0] data_entries;
reg [13:0] data_height;
reg [9:0] data_surf;
reg [11:0] data_width_ext;
reg [4:0] delay_cnt;
reg [3:0] dma_rsp_size;
reg [3:0] dma_rsp_size_cnt;
reg [31:0] dp2reg_wg_rd_latency;
reg [31:0] dp2reg_wg_rd_stall;
reg [14:0] h_coord;
reg [14:0] h_coord_sub_h;
reg [14:0] h_coord_surf;
reg [10:0] h_ext_surf;
reg [10:0] height_ext_total;
reg is_cbuf_ready;
reg is_req_done;
reg is_rsp_done;
reg is_running_d1;
reg is_x_stride_one;
reg [4:0] last_data_bank;
reg [3:0] last_lp;
reg [3:0] last_rp;
reg last_skip_data_rls;
reg last_wg;
reg layer_st_d1;
reg [4:0] lp_end;
reg ltc_1_adv;
reg [8:0] ltc_1_cnt_cur;
reg [10:0] ltc_1_cnt_dec;
reg [10:0] ltc_1_cnt_ext;
reg [10:0] ltc_1_cnt_inc;
reg [10:0] ltc_1_cnt_mod;
reg [10:0] ltc_1_cnt_new;
reg [10:0] ltc_1_cnt_nxt;
reg ltc_2_adv;
reg [31:0] ltc_2_cnt_cur;
reg [33:0] ltc_2_cnt_dec;
reg [33:0] ltc_2_cnt_ext;
reg [33:0] ltc_2_cnt_inc;
reg [33:0] ltc_2_cnt_mod;
reg [33:0] ltc_2_cnt_new;
reg [33:0] ltc_2_cnt_nxt;
reg no_lp;
reg [1:0] nxt_state;
reg [8:0] outs_dp2reg_wg_rd_latency;
reg pending_req;
reg pending_req_d1;
reg [3:0] rd_cube_cnt;
reg [2:0] rd_sub_cnt;
reg [58:0] req_addr_d2;
reg req_dummy_d1;
reg req_dummy_d2;
reg [10:0] req_h_ext_cnt;
reg [3:0] req_size_d1;
reg [3:0] req_size_d2;
reg [2:0] req_size_out_d1;
reg [2:0] req_size_out_d2;
reg [1:0] req_sub_h_cnt;
reg [12:0] req_sub_w_cnt;
reg [8:0] req_surf_cnt;
reg req_valid_d1;
reg req_valid_d2;
reg [1:0] req_w_set_cnt;
reg [2:0] req_y_std_cnt;
reg [5:0] rp_end;
reg [11:0] rsp_addr_base;
reg [11:0] rsp_addr_d1;
reg [11:0] rsp_addr_offset;
reg [11:0] rsp_ch_offset;
reg [11:0] rsp_ch_surf_base;
reg [11:0] rsp_ch_w_base;
reg [11:0] rsp_ch_x_std_base;
reg [11:0] rsp_ch_y_std_base;
reg rsp_dat_vld_d1;
reg rsp_dat_vld_d2;
reg [511:0] rsp_data_d1;
reg [511:0] rsp_data_l0c0;
reg [511:0] rsp_data_l0c1;
reg [511:0] rsp_data_l1c0;
reg [511:0] rsp_data_l1c1;
reg rsp_en_d1;
reg [10:0] rsp_h_ext_cnt;
reg rsp_hsel_d1;
reg rsp_layer_done_d1;
reg rsp_slice_done_d1;
reg [2:0] rsp_sub_cube_cnt;
reg [8:0] rsp_surf_cnt;
reg [10:0] rsp_width_cnt;
reg [2:0] rsp_x_std_cnt;
reg [2:0] rsp_y_std_cnt;
reg [3:0] sbuf_avl_cube;
reg sbuf_blocking;
reg sbuf_cube_inc_en_d1;
reg [3:0] sbuf_cube_inc_size_d1;
reg sbuf_rd_en_d1;
reg [7:0] sbuf_rd_p0_idx_d1;
reg [7:0] sbuf_rd_p1_idx_d1;
reg [1:0] sbuf_rd_sel_d1;
reg [1:0] sbuf_wr_line;
reg [3:0] sbuf_wr_p0_base;
reg [3:0] sbuf_wr_p0_base_ori;
reg [3:0] sbuf_wr_p0_ch;
reg [3:0] sbuf_wr_p0_ch_ori;
reg [255:0] sbuf_wr_p0_data_d1;
reg sbuf_wr_p0_en_d1;
reg [7:0] sbuf_wr_p0_idx_d1;
reg [2:0] sbuf_wr_p0_offset;
reg [2:0] sbuf_wr_p0_offset_ori;
reg [3:0] sbuf_wr_p1_base;
reg [3:0] sbuf_wr_p1_base_ori;
reg [1:0] sbuf_wr_p1_ch;
reg [1:0] sbuf_wr_p1_ch_ori;
reg [255:0] sbuf_wr_p1_data_d1;
reg sbuf_wr_p1_en_d1;
reg [7:0] sbuf_wr_p1_idx_d1;
reg [2:0] sbuf_wr_p1_offset;
reg [2:0] sbuf_wr_p1_offset_ori;
reg [1:0] slcg_wg_gate_d1;
reg [1:0] slcg_wg_gate_d2;
reg [1:0] slcg_wg_gate_d3;
reg stl_adv;
reg [31:0] stl_cnt_cur;
reg [33:0] stl_cnt_dec;
reg [33:0] stl_cnt_ext;
reg [33:0] stl_cnt_inc;
reg [33:0] stl_cnt_mod;
reg [33:0] stl_cnt_new;
reg [33:0] stl_cnt_nxt;
reg [8:0] surf_cnt_total;
reg [10:0] w_ext_surf;
reg [1:0] wg2status_state;
reg [14:0] wg_entry_onfly;
reg wg_rd_latency_cen;
reg wg_rd_latency_clr;
reg wg_rd_latency_dec;
reg wg_rd_latency_inc;
reg wg_rd_stall_cen;
reg wg_rd_stall_clr;
reg wg_rd_stall_inc;
reg [10:0] width_ext_total;
reg [1:0] width_set_total;
reg [12:0] x_offset_d1;
reg [26:0] y_offset_d1;
wire [26:0] c_offset;
wire cbuf_wr_info_ext128;
wire cbuf_wr_info_ext64;
wire cbuf_wr_info_interleave;
wire [3:0] cbuf_wr_info_mask;
wire cbuf_wr_info_mean;
wire [2:0] cbuf_wr_info_sub_h;
wire cbuf_wr_info_uint;
wire [3:0] conv_x_stride_w;
wire [10:0] conv_xy_stride_w;
wire [3:0] conv_y_stride_w;
wire [1023:0] dat_cur;
wire [1023:0] dat_cur_remapped;
wire [14:0] data_entries_add;
wire [14:0] data_entries_w;
wire [14:0] data_height_st_w;
wire [13:0] data_height_w;
wire [9:0] data_surf_w;
wire [11:0] data_width_ext_w;
wire [4:0] delay_cnt_end;
wire [4:0] delay_cnt_w;
wire [511:0] dma_pad_data;
wire [63:0] dma_rd_req_addr;
wire [78:0] dma_rd_req_pd;
wire dma_rd_req_rdy;
wire [15:0] dma_rd_req_size;
wire dma_rd_req_type;
wire dma_rd_req_vld;
wire dma_rd_rsp_blocking;
wire [511:0] dma_rd_rsp_data;
wire [1:0] dma_rd_rsp_mask;
wire [513:0] dma_rd_rsp_pd;
wire dma_rd_rsp_rdy;
wire dma_rd_rsp_vld;
wire [4:0] dma_req_fifo_data;
wire dma_req_fifo_ready;
wire dma_req_fifo_req;
wire [511:0] dma_rsp_data;
wire [255:0] dma_rsp_data_p0;
wire [255:0] dma_rsp_data_p1;
wire dma_rsp_dummy;
wire [4:0] dma_rsp_fifo_data;
wire dma_rsp_fifo_ready;
wire dma_rsp_fifo_req;
wire [1:0] dma_rsp_mask;
wire [3:0] dma_rsp_size_cnt_inc;
wire [3:0] dma_rsp_size_cnt_w;
wire dma_rsp_vld;
wire dp2reg_wg_rd_stall_dec;
wire fetch_done;
wire [14:0] h_coord_w;
wire [10:0] h_ext_surf_w;
wire height_dummy;
wire is_cbuf_ready_w;
wire is_done;
wire is_feature;
wire is_first_running;
wire is_idle;
wire is_int8;
wire is_last_req;
wire is_last_rsp;
wire is_pending;
wire is_req_done_w;
wire is_req_last_di;
wire is_req_last_h_ext;
wire is_req_last_lp;
wire is_req_last_rp;
wire is_req_last_sub_h;
wire is_req_last_sub_w;
wire is_req_last_surf;
wire is_req_last_w_set;
wire is_req_last_width;
wire is_req_last_y_std;
wire is_rsp_addr_wrap;
wire is_rsp_done_w;
wire is_rsp_last_h_ext;
wire is_rsp_last_sub_cube;
wire is_rsp_last_surf;
wire is_rsp_last_width;
wire is_rsp_last_x_std;
wire is_rsp_last_y_std;
wire is_running;
wire is_sbuf_wr_last_line;
wire is_slice_done;
wire is_w_set_di;
wire is_w_set_lp;
wire is_w_set_rp;
wire is_wg;
wire is_x_stride_one_w;
wire [3:0] last_lp_w;
wire [3:0] last_rp_w;
wire layer_st;
wire [4:0] lp_end_w;
wire ltc_1_dec;
wire ltc_1_inc;
wire ltc_2_dec;
wire ltc_2_inc;
wire mc_dma_rd_req_rdy;
wire mc_dma_rd_req_vld;
wire [513:0] mc_dma_rd_rsp_pd;
wire mc_dma_rd_rsp_vld;
wire [78:0] mc_int_rd_req_pd;
wire [78:0] mc_int_rd_req_pd_d0;
wire mc_int_rd_req_ready;
wire mc_int_rd_req_ready_d0;
wire mc_int_rd_req_valid;
wire mc_int_rd_req_valid_d0;
wire [513:0] mc_int_rd_rsp_pd;
wire mc_int_rd_rsp_ready;
wire mc_int_rd_rsp_valid;
wire mc_rd_req_rdyi;
wire [513:0] mcif2wg_dat_rd_rsp_pd_d0;
wire mcif2wg_dat_rd_rsp_ready_d0;
wire mcif2wg_dat_rd_rsp_valid_d0;
wire mode_match;
wire [8:0] mon_c_offset;
wire [4:0] mon_conv_xy_stride_w;
wire mon_data_entries_w;
wire mon_delay_cnt_w;
wire mon_dma_rsp_size_cnt_inc;
wire mon_h_coord_w;
wire [9:0] mon_h_ext_surf_w;
wire mon_lp_end_w;
wire mon_rd_cube_cnt_w;
wire mon_rd_sub_cnt_w;
wire mon_req_addr_w;
wire mon_req_cubf_needed;
wire mon_req_h_ext_cnt_inc;
wire mon_req_size_out;
wire mon_req_sub_h_cnt_w;
wire mon_req_sub_w_cnt_inc;
wire mon_req_surf_cnt_inc;
wire mon_req_w_set_cnt_inc;
wire mon_req_y_std_cnt_inc;
wire mon_rp_end_w;
wire mon_rsp_addr_inc;
wire mon_rsp_addr_offset_w;
wire [1:0] mon_rsp_addr_wrap;
wire mon_rsp_ch_offset_w;
wire mon_rsp_h_ext_cnt_inc;
wire mon_rsp_sub_cube_cnt_inc;
wire mon_rsp_surf_cnt_inc;
wire mon_rsp_width_cnt_inc;
wire mon_rsp_x_std_cnt_inc;
wire mon_rsp_y_std_cnt_inc;
wire mon_sbuf_avl_cube_w;
wire mon_sbuf_wr_line_w;
wire mon_sbuf_wr_p0_base_w;
wire mon_sbuf_wr_p0_ch_inc;
wire mon_sbuf_wr_p0_idx_lo;
wire mon_sbuf_wr_p1_base_w;
wire mon_sbuf_wr_p1_ch_inc;
wire mon_sbuf_wr_p1_idx_lo;
wire [10:0] mon_w_ext_surf_w;
wire mon_wg_entry_onfly_w;
wire [12:0] mon_y_offset;
wire need_pending;
wire no_lp_w;
wire pending_req_end;
wire [3:0] rd_cube_cnt_w;
wire rd_req_rdyi;
wire [2:0] rd_sub_cnt_w;
wire [58:0] req_addr_base;
wire [58:0] req_addr_w;
wire req_adv;
wire [14:0] req_cbuf_needed;
wire [10:0] req_h_ext_cnt_inc;
wire [10:0] req_h_ext_cnt_w;
wire req_h_ext_en;
wire req_ready;
wire req_ready_d1;
wire req_ready_d2;
wire [3:0] req_size;
wire [2:0] req_size_out;
wire [1:0] req_sub_h_cnt_w;
wire req_sub_h_en;
wire [12:0] req_sub_w_cnt_inc;
wire [12:0] req_sub_w_cnt_w;
wire [3:0] req_sub_w_cur;
wire req_sub_w_en;
wire [8:0] req_surf_cnt_inc;
wire [8:0] req_surf_cnt_w;
wire req_surf_en;
wire req_valid;
wire req_valid_d1_w;
wire req_valid_d2_w;
wire [1:0] req_w_set_cnt_inc;
wire [1:0] req_w_set_cnt_w;
wire req_w_set_en;
wire [2:0] req_y_std_cnt_inc;
wire [2:0] req_y_std_cnt_w;
wire req_y_std_en;
wire [5:0] rp_end_w;
wire [11:0] rsp_addr;
wire [12:0] rsp_addr_inc;
wire [11:0] rsp_addr_offset_w;
wire [11:0] rsp_addr_wrap;
wire rsp_ch_offset_en;
wire [11:0] rsp_ch_offset_w;
wire [11:0] rsp_ch_surf_add;
wire rsp_ch_surf_base_en;
wire rsp_ch_w_base_en;
wire [11:0] rsp_ch_x_std_add;
wire rsp_ch_x_std_base_en;
wire [11:0] rsp_ch_y_std_add;
wire rsp_ch_y_std_base_en;
wire [511:0] rsp_data_d1_w;
wire [1023:0] rsp_data_l0;
wire rsp_data_l0c0_en;
wire rsp_data_l0c1_en;
wire [1023:0] rsp_data_l1;
wire rsp_data_l1c0_en;
wire rsp_data_l1c1_en;
wire rsp_en;
wire [10:0] rsp_h_ext_cnt_inc;
wire [10:0] rsp_h_ext_cnt_w;
wire rsp_h_ext_en;
wire rsp_hsel;
wire [1:0] rsp_sel;
wire [1:0] rsp_sel_d0;
wire [2:0] rsp_sub_cube_cnt_inc;
wire [2:0] rsp_sub_cube_cnt_w;
wire rsp_sub_cube_en;
wire [8:0] rsp_surf_cnt_inc;
wire [8:0] rsp_surf_cnt_w;
wire rsp_surf_en;
wire rsp_vld;
wire rsp_vld_d0;
wire [10:0] rsp_width_cnt_inc;
wire [10:0] rsp_width_cnt_w;
wire rsp_width_en;
wire [2:0] rsp_x_std_cnt_inc;
wire [2:0] rsp_x_std_cnt_w;
wire rsp_x_std_en;
wire [2:0] rsp_y_std_cnt_inc;
wire [2:0] rsp_y_std_cnt_w;
wire rsp_y_std_en;
wire [3:0] sbuf_avl_cube_add;
wire sbuf_avl_cube_en;
wire sbuf_avl_cube_sub;
wire [3:0] sbuf_avl_cube_w;
wire sbuf_blocking_w;
wire sbuf_cube_inc_en;
wire [3:0] sbuf_cube_inc_size;
wire sbuf_rd_en;
wire [7:0] sbuf_rd_p0_idx;
wire [7:0] sbuf_rd_p1_idx;
wire [1:0] sbuf_wr_add;
wire sbuf_wr_addr_en;
wire sbuf_wr_addr_ori_en;
wire [1:0] sbuf_wr_line_w;
wire [3:0] sbuf_wr_p0_base_w;
wire [3:0] sbuf_wr_p0_ch_inc;
wire [3:0] sbuf_wr_p0_ch_w;
wire sbuf_wr_p0_en;
wire [7:0] sbuf_wr_p0_idx;
wire [3:0] sbuf_wr_p0_idx_lo;
wire sbuf_wr_p0_of;
wire sbuf_wr_p0_of_0;
wire sbuf_wr_p0_of_1;
wire [3:0] sbuf_wr_p0_offset_inc;
wire [2:0] sbuf_wr_p0_offset_w;
wire [3:0] sbuf_wr_p1_base_w;
wire [1:0] sbuf_wr_p1_ch_inc;
wire [1:0] sbuf_wr_p1_ch_w;
wire sbuf_wr_p1_en;
wire [7:0] sbuf_wr_p1_idx;
wire [3:0] sbuf_wr_p1_idx_lo;
wire sbuf_wr_p1_of;
wire sbuf_wr_p1_of_0;
wire sbuf_wr_p1_of_1;
wire [3:0] sbuf_wr_p1_offset_inc;
wire [2:0] sbuf_wr_p1_offset_w;
wire [1:0] sbuf_x_stride_inc_size;
wire slcg_wg_en_w;
wire [1:0] slcg_wg_gate_w;
wire [8:0] surf_cnt_total_w;
wire [10:0] w_ext_surf_w;
wire [1:0] wg2status_state_w;
wire wg_en;
wire [14:0] wg_entry_onfly_add;
wire wg_entry_onfly_en;
wire [14:0] wg_entry_onfly_sub;
wire [14:0] wg_entry_onfly_w;
wire width_dummy;
wire [1:0] width_set_total_w;
wire [12:0] x_offset;
wire [26:0] y_offset;
////////////////////////////////////////////////////////////////////////
// CDMA winograd convolution data fetching logic FSM //
////////////////////////////////////////////////////////////////////////
//## fsm (1) defines
localparam WG_STATE_IDLE = 2'b00;
localparam WG_STATE_PEND = 2'b01;
localparam WG_STATE_BUSY = 2'b10;
localparam WG_STATE_DONE = 2'b11;
//## fsm (1) com block
always @(*) begin
    nxt_state = cur_state;
    begin
        casez (cur_state)
        WG_STATE_IDLE: begin
            if ((wg_en & need_pending)) begin
                nxt_state = WG_STATE_PEND;
            end
            else if ((wg_en & reg2dp_data_reuse & last_skip_data_rls & mode_match)) begin
                nxt_state = WG_STATE_DONE;
            end
            else if (wg_en) begin
                nxt_state = WG_STATE_BUSY;
            end
        end
        WG_STATE_PEND: begin
            if ((pending_req_end)) begin
                nxt_state = WG_STATE_BUSY;
            end
        end
        WG_STATE_BUSY: begin
            if (fetch_done) begin
                nxt_state = WG_STATE_DONE;
            end
        end
        WG_STATE_DONE: begin
            if (status2dma_fsm_switch) begin
                nxt_state = WG_STATE_IDLE;
            end
        end
        endcase
    end
end
//## fsm (1) seq block
//: &eperl::flop("-nodeclare   -rval \"WG_STATE_IDLE\"   -d \"nxt_state\" -q cur_state");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cur_state <= WG_STATE_IDLE;
   end else begin
       cur_state <= nxt_state;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// FSM input signals //
////////////////////////////////////////////////////////////////////////
assign fetch_done = is_running & is_req_done & is_rsp_done & (delay_cnt == delay_cnt_end);
assign delay_cnt_end = (3 + 3 + 3 ) ;
assign {mon_delay_cnt_w,
        delay_cnt_w} = ~is_running ? 6'b0 :
                      is_rsp_done ? delay_cnt + 1'b1 :
                      {1'b0, delay_cnt};
assign need_pending = (last_data_bank != reg2dp_data_bank);
assign mode_match = wg_en & last_wg;
assign is_feature = (reg2dp_datain_format == 1'h0 );
assign is_wg = (reg2dp_conv_mode == 1'h1 );
assign wg_en = reg2dp_op_en & is_wg & is_feature;
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"is_rsp_done | is_done\" -d \"delay_cnt_w\" -q delay_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       delay_cnt <= {5{1'b0}};
   end else begin
       if ((is_rsp_done | is_done) == 1'b1) begin
           delay_cnt <= delay_cnt_w;
       // VCS coverage off
       end else if ((is_rsp_done | is_done) == 1'b0) begin
       end else begin
           delay_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// FSM output signals //
////////////////////////////////////////////////////////////////////////
assign layer_st = wg_en & is_idle;
assign is_idle = (cur_state == WG_STATE_IDLE);
assign is_pending = (cur_state == WG_STATE_PEND);
assign is_running = (cur_state == WG_STATE_BUSY);
assign is_done = (cur_state == WG_STATE_DONE);
assign is_first_running = ~is_running_d1 & is_running;
assign wg2status_state_w = (nxt_state == WG_STATE_PEND) ? 1 :
                           (nxt_state == WG_STATE_BUSY) ? 2 :
                           (nxt_state == WG_STATE_DONE) ? 3 :
                           0 ;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"layer_st\" -q layer_st_d1");
//: &eperl::flop("-nodeclare   -rval \"0\"   -d \"wg2status_state_w\" -q wg2status_state");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"is_running\" -q is_running_d1");
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
       wg2status_state <= 'b0;
   end else begin
       wg2status_state <= wg2status_state_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_running_d1 <= 1'b0;
   end else begin
       is_running_d1 <= is_running;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// registers to keep last layer status //
////////////////////////////////////////////////////////////////////////
assign pending_req_end = pending_req_d1 & ~pending_req;
//================ Non-SLCG clock domain ================//
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"1'b0\"  -en \"reg2dp_op_en & is_idle\" -d \"wg_en\" -q last_wg");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{5{1'b1}}\"  -en \"reg2dp_op_en & is_idle\" -d \"reg2dp_data_bank\" -q last_data_bank");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"1'b0\"  -en \"reg2dp_op_en & is_idle\" -d \"wg_en & reg2dp_skip_data_rls\" -q last_skip_data_rls");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"1'b0\"   -d \"sc2cdma_dat_pending_req\" -q pending_req");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"1'b0\"   -d \"pending_req\" -q pending_req_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_wg <= 1'b0;
   end else begin
       if ((reg2dp_op_en & is_idle) == 1'b1) begin
           last_wg <= wg_en;
       // VCS coverage off
       end else if ((reg2dp_op_en & is_idle) == 1'b0) begin
       end else begin
           last_wg <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_data_bank <= {5{1'b1}};
   end else begin
       if ((reg2dp_op_en & is_idle) == 1'b1) begin
           last_data_bank <= reg2dp_data_bank;
       // VCS coverage off
       end else if ((reg2dp_op_en & is_idle) == 1'b0) begin
       end else begin
           last_data_bank <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_skip_data_rls <= 1'b0;
   end else begin
       if ((reg2dp_op_en & is_idle) == 1'b1) begin
           last_skip_data_rls <= wg_en & reg2dp_skip_data_rls;
       // VCS coverage off
       end else if ((reg2dp_op_en & is_idle) == 1'b0) begin
       end else begin
           last_skip_data_rls <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pending_req <= 1'b0;
   end else begin
       pending_req <= sc2cdma_dat_pending_req;
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pending_req_d1 <= 1'b0;
   end else begin
       pending_req_d1 <= pending_req;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// SLCG control signal //
////////////////////////////////////////////////////////////////////////
assign slcg_wg_en_w = wg_en & (is_running | is_pending | is_done);
assign slcg_wg_gate_w = {2{~slcg_wg_en_w}};
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{2{1'b1}}\"   -d \"slcg_wg_gate_w\" -q slcg_wg_gate_d1");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{2{1'b1}}\"   -d \"slcg_wg_gate_d1\" -q slcg_wg_gate_d2");
//: &eperl::flop("-nodeclare -clk nvdla_core_ng_clk  -rval \"{2{1'b1}}\"   -d \"slcg_wg_gate_d2\" -q slcg_wg_gate_d3");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_wg_gate_d1 <= {2{1'b1}};
   end else begin
       slcg_wg_gate_d1 <= slcg_wg_gate_w;
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_wg_gate_d2 <= {2{1'b1}};
   end else begin
       slcg_wg_gate_d2 <= slcg_wg_gate_d1;
   end
end
always @(posedge nvdla_core_ng_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_wg_gate_d3 <= {2{1'b1}};
   end else begin
       slcg_wg_gate_d3 <= slcg_wg_gate_d2;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign slcg_wg_gate_dc = slcg_wg_gate_d3[0];
assign slcg_wg_gate_img = slcg_wg_gate_d3[1];
//================ Non-SLCG clock domain end ================//
////////////////////////////////////////////////////////////////////////
// registers to calculate local values //
////////////////////////////////////////////////////////////////////////
assign is_int8 = 1'b1;
assign surf_cnt_total_w = {1'b0, reg2dp_datain_channel[12:5]};
assign data_surf_w = {1'b0, reg2dp_datain_channel[12:5]} + 1'b1;
assign is_x_stride_one_w = ~(|reg2dp_conv_x_stride);
assign data_height_st_w = 14'b0 - reg2dp_pad_top;
assign data_height_w = reg2dp_datain_height + 1'b1;
assign data_width_ext_w = reg2dp_datain_width_ext[12:2] + 1'b1;
assign {mon_conv_xy_stride_w,
        conv_xy_stride_w} = conv_x_stride_w * data_width_ext_w;
assign {mon_w_ext_surf_w,
        w_ext_surf_w} = data_width_ext_w * data_surf;
assign {mon_h_ext_surf_w,
        h_ext_surf_w} = conv_xy_stride * data_surf;
assign conv_x_stride_w = reg2dp_conv_x_stride + 1'b1;
assign conv_y_stride_w = reg2dp_conv_y_stride + 1'b1;
assign {mon_data_entries_w,
        data_entries_w} = {reg2dp_entries[12:0], 2'b0} + 3'h4;
assign width_set_total_w[1:0] = (|reg2dp_pad_left) + (|reg2dp_pad_right);
assign no_lp_w = ~(|reg2dp_pad_left);
assign {mon_lp_end_w,
        lp_end_w} = ~(|reg2dp_pad_left[2:0]) ? (reg2dp_pad_left - 4'h8) :
                   {reg2dp_pad_left[4:3], 3'b0};
assign last_lp_w = ~(|reg2dp_pad_left[2:0]) ? 4'h8 : {1'b0, reg2dp_pad_left[2:0]};
assign {mon_rp_end_w,
        rp_end_w} = ~(|reg2dp_pad_right[2:0]) ? (reg2dp_pad_right - 4'h8) :
                   {reg2dp_pad_right[5:3], 3'b0};
assign last_rp_w = ~(|reg2dp_pad_right[2:0]) ? 4'h8 : {1'b0, reg2dp_pad_right[2:0]};
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"layer_st\" -d \"is_x_stride_one_w\" -q is_x_stride_one");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"layer_st\" -d \"data_height_w\" -q data_height");
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"layer_st\" -d \"surf_cnt_total_w\" -q surf_cnt_total");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"layer_st\" -d \"data_width_ext_w\" -q data_width_ext");
//: &eperl::flop("-nodeclare   -rval \"{10{1'b0}}\"  -en \"layer_st\" -d \"data_surf_w\" -q data_surf");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"layer_st\" -d \"conv_x_stride_w\" -q conv_x_stride");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"layer_st\" -d \"conv_y_stride_w\" -q conv_y_stride");
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"layer_st\" -d \"conv_xy_stride_w\" -q conv_xy_stride");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"layer_st\" -d \"data_entries_w\" -q data_entries");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"layer_st\" -d \"reg2dp_data_bank + 1'b1\" -q data_bank");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"layer_st\" -d \"width_set_total_w\" -q width_set_total");
//: &eperl::flop("-nodeclare   -rval \"1'b1\"  -en \"layer_st\" -d \"no_lp_w\" -q no_lp");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"layer_st\" -d \"lp_end_w\" -q lp_end");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"layer_st\" -d \"last_lp_w\" -q last_lp");
//: &eperl::flop("-nodeclare   -rval \"{6{1'b0}}\"  -en \"layer_st\" -d \"rp_end_w\" -q rp_end");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"layer_st\" -d \"last_rp_w\" -q last_rp");
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"layer_st\" -d \"reg2dp_datain_width_ext[12:2]\" -q width_ext_total");
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"layer_st\" -d \"reg2dp_datain_height_ext[12:2]\" -q height_ext_total");
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"layer_st_d1\" -d \"w_ext_surf_w\" -q w_ext_surf");
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"layer_st_d1\" -d \"h_ext_surf_w\" -q h_ext_surf");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_x_stride_one <= 1'b0;
   end else begin
       if ((layer_st) == 1'b1) begin
           is_x_stride_one <= is_x_stride_one_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           is_x_stride_one <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_height <= {14{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           data_height <= data_height_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           data_height <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       surf_cnt_total <= {9{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           surf_cnt_total <= surf_cnt_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           surf_cnt_total <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_width_ext <= {12{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           data_width_ext <= data_width_ext_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           data_width_ext <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_surf <= {10{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           data_surf <= data_surf_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           data_surf <= 'bx;
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
       conv_xy_stride <= {11{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           conv_xy_stride <= conv_xy_stride_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           conv_xy_stride <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_entries <= {15{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           data_entries <= data_entries_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           data_entries <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_bank <= {5{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           data_bank <= reg2dp_data_bank + 1'b1;
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
       width_set_total <= {2{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           width_set_total <= width_set_total_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           width_set_total <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       no_lp <= 1'b1;
   end else begin
       if ((layer_st) == 1'b1) begin
           no_lp <= no_lp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           no_lp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       lp_end <= {5{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           lp_end <= lp_end_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           lp_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_lp <= {4{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           last_lp <= last_lp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           last_lp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rp_end <= {6{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           rp_end <= rp_end_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           rp_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       last_rp <= {4{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           last_rp <= last_rp_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           last_rp <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       width_ext_total <= {11{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           width_ext_total <= reg2dp_datain_width_ext[12:2];
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           width_ext_total <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       height_ext_total <= {11{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           height_ext_total <= reg2dp_datain_height_ext[12:2];
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           height_ext_total <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       w_ext_surf <= {11{1'b0}};
   end else begin
       if ((layer_st_d1) == 1'b1) begin
           w_ext_surf <= w_ext_surf_w;
       // VCS coverage off
       end else if ((layer_st_d1) == 1'b0) begin
       end else begin
           w_ext_surf <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_ext_surf <= {11{1'b0}};
   end else begin
       if ((layer_st_d1) == 1'b1) begin
           h_ext_surf <= h_ext_surf_w;
       // VCS coverage off
       end else if ((layer_st_d1) == 1'b0) begin
       end else begin
           h_ext_surf <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// entries on-the-fly //
////////////////////////////////////////////////////////////////////////
//how many entries onfly
//current onfly entries + valid entries can be write in Cbuf - entries per slice
assign wg_entry_onfly_add = (~is_req_done & ~is_cbuf_ready & is_cbuf_ready_w) ? data_entries : 15'b0;
assign wg_entry_onfly_sub = wg2status_dat_updt ? wg2status_dat_entries : 15'b0;
assign {mon_wg_entry_onfly_w,
        wg_entry_onfly_w} = wg_entry_onfly + wg_entry_onfly_add - wg_entry_onfly_sub;
assign wg_entry_onfly_en = wg2status_dat_updt | (~is_req_done & ~is_cbuf_ready & is_cbuf_ready_w);
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"wg_entry_onfly_en\" -d \"wg_entry_onfly_w\" -q wg_entry_onfly");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wg_entry_onfly <= {15{1'b0}};
   end else begin
       if ((wg_entry_onfly_en) == 1'b1) begin
           wg_entry_onfly <= wg_entry_onfly_w;
       // VCS coverage off
       end else if ((wg_entry_onfly_en) == 1'b0) begin
       end else begin
           wg_entry_onfly <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// prepare for address generation //
////////////////////////////////////////////////////////////////////////
//////////////// extended height count ////////////////
assign {mon_req_h_ext_cnt_inc,
        req_h_ext_cnt_inc} = req_h_ext_cnt + 1'b1;
assign req_h_ext_cnt_w = layer_st ? 11'b0 :
                         req_h_ext_cnt_inc;
assign is_req_last_h_ext = (req_h_ext_cnt == height_ext_total);
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"req_h_ext_en\" -d \"req_h_ext_cnt_w\" -q req_h_ext_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_h_ext_cnt <= {11{1'b0}};
   end else begin
       if ((req_h_ext_en) == 1'b1) begin
           req_h_ext_cnt <= req_h_ext_cnt_w;
       // VCS coverage off
       end else if ((req_h_ext_en) == 1'b0) begin
       end else begin
           req_h_ext_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// surface count ////////////////
assign {mon_req_surf_cnt_inc,
        req_surf_cnt_inc} = req_surf_cnt + 1'b1;
assign req_surf_cnt_w = (layer_st | is_req_last_surf) ? 9'b0 :
                        req_surf_cnt_inc;
assign is_req_last_surf = (req_surf_cnt == surf_cnt_total);
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"req_surf_en\" -d \"req_surf_cnt_w\" -q req_surf_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_surf_cnt <= {9{1'b0}};
   end else begin
       if ((req_surf_en) == 1'b1) begin
           req_surf_cnt <= req_surf_cnt_w;
       // VCS coverage off
       end else if ((req_surf_en) == 1'b0) begin
       end else begin
           req_surf_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// conv y stride count ////////////////
assign {mon_req_y_std_cnt_inc,
        req_y_std_cnt_inc} = req_y_std_cnt + 1'b1;
assign req_y_std_cnt_w = (layer_st | is_req_last_y_std) ? 3'b0 :
                         req_y_std_cnt_inc;
assign is_req_last_y_std = (req_y_std_cnt == reg2dp_conv_y_stride);
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"req_y_std_en\" -d \"req_y_std_cnt_w\" -q req_y_std_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_y_std_cnt <= {3{1'b0}};
   end else begin
       if ((req_y_std_en) == 1'b1) begin
           req_y_std_cnt <= req_y_std_cnt_w;
       // VCS coverage off
       end else if ((req_y_std_en) == 1'b0) begin
       end else begin
           req_y_std_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// width set count ////////////////
assign {mon_req_w_set_cnt_inc,
        req_w_set_cnt_inc} = req_w_set_cnt + 1'b1;
assign req_w_set_cnt_w = (layer_st | is_req_last_w_set) ? 2'b0 :
                         req_w_set_cnt_inc;
assign is_req_last_w_set = (req_w_set_cnt == width_set_total);
assign is_w_set_rp = (req_w_set_cnt == 2'h2) | (no_lp & (req_w_set_cnt == 2'h1));
assign is_w_set_lp = ~no_lp & (req_w_set_cnt == 2'h0);
assign is_w_set_di = no_lp ? (req_w_set_cnt == 2'h0) : (req_w_set_cnt == 2'h1);
assign width_dummy = ~is_w_set_di;
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"req_w_set_en\" -d \"req_w_set_cnt_w\" -q req_w_set_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_w_set_cnt <= {2{1'b0}};
   end else begin
       if ((req_w_set_en) == 1'b1) begin
           req_w_set_cnt <= req_w_set_cnt_w;
       // VCS coverage off
       end else if ((req_w_set_en) == 1'b0) begin
       end else begin
           req_w_set_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// sub width count ////////////////
assign {mon_req_sub_w_cnt_inc,
        req_sub_w_cnt_inc} = req_sub_w_cnt + 4'h8;
assign req_sub_w_cnt_w = (layer_st | is_req_last_sub_w) ? 13'b0 :
                         req_sub_w_cnt_inc;
assign req_sub_w_cur = is_req_last_lp ? last_lp :
                       is_req_last_rp ? last_rp :
                       is_req_last_di ? (reg2dp_datain_width[2:0] + 1'b1) :
                       4'h8;
assign is_req_last_lp = (is_w_set_lp & (~(|req_sub_w_cnt[12:5]) & (req_sub_w_cnt[4:0] == lp_end)));
assign is_req_last_rp = (is_w_set_rp & (~(|req_sub_w_cnt[12:6]) & (req_sub_w_cnt[5:0] == rp_end)));
assign is_req_last_di = (is_w_set_di & (req_sub_w_cnt == {reg2dp_datain_width[12:3], 3'b0}));
assign is_req_last_sub_w = is_req_last_lp | is_req_last_di | is_req_last_rp;
assign is_req_last_width = is_req_last_sub_w & is_req_last_w_set;
//: &eperl::flop("-nodeclare   -rval \"{13{1'b0}}\"  -en \"req_sub_w_en\" -d \"req_sub_w_cnt_w\" -q req_sub_w_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_sub_w_cnt <= {13{1'b0}};
   end else begin
       if ((req_sub_w_en) == 1'b1) begin
           req_sub_w_cnt <= req_sub_w_cnt_w;
       // VCS coverage off
       end else if ((req_sub_w_en) == 1'b0) begin
       end else begin
           req_sub_w_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// sub h count ////////////////
assign {mon_req_sub_h_cnt_w,
        req_sub_h_cnt_w} = (layer_st | is_req_last_sub_h) ? 3'b0 :
                          (req_sub_h_cnt + 1'b1);
assign is_req_last_sub_h = (req_sub_h_cnt == 2'h3);
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"req_sub_h_en\" -d \"req_sub_h_cnt_w\" -q req_sub_h_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_sub_h_cnt <= {2{1'b0}};
   end else begin
       if ((req_sub_h_en) == 1'b1) begin
           req_sub_h_cnt <= req_sub_h_cnt_w;
       // VCS coverage off
       end else if ((req_sub_h_en) == 1'b0) begin
       end else begin
           req_sub_h_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// loop control logic ////////////////
assign is_req_done_w = layer_st ? 1'b0 :
                       is_last_req ? 1'b1 :
                       is_req_done;
assign req_valid = is_running & ~is_req_done & is_cbuf_ready;
assign data_entries_add = (is_req_last_h_ext & is_cbuf_ready) ? 15'b0 : data_entries;
assign {mon_req_cubf_needed,
        req_cbuf_needed} = data_entries_add + wg_entry_onfly;
assign is_cbuf_ready_w = (~is_running | req_h_ext_en) ? 1'b0 :
                         (~is_cbuf_ready) ? (req_cbuf_needed <= status2dma_free_entries) :
                         is_cbuf_ready;
assign req_ready = ~req_valid_d1 | req_ready_d1;
assign req_adv = req_valid & req_ready;
assign req_sub_h_en = layer_st | req_adv;
assign req_sub_w_en = layer_st | (req_adv & is_req_last_sub_h);
assign req_w_set_en = layer_st | (req_adv & is_req_last_sub_h & is_req_last_sub_w);
assign req_y_std_en = layer_st | (req_adv & is_req_last_sub_h & is_req_last_sub_w & is_req_last_w_set);
assign req_surf_en = layer_st | (req_adv & is_req_last_sub_h & is_req_last_sub_w & is_req_last_w_set & is_req_last_y_std);
assign req_h_ext_en = layer_st | (req_adv & is_req_last_sub_h & is_req_last_sub_w & is_req_last_w_set & is_req_last_y_std & is_req_last_surf);
assign is_last_req = (is_req_last_sub_h & is_req_last_sub_w & is_req_last_w_set & is_req_last_y_std & is_req_last_surf & is_req_last_h_ext);
//: &eperl::flop("-nodeclare   -rval \"1'b1\"  -en \"req_h_ext_en\" -d \"is_req_done_w\" -q is_req_done");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"is_cbuf_ready_w\" -q is_cbuf_ready");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_req_done <= 1'b1;
   end else begin
       if ((req_h_ext_en) == 1'b1) begin
           is_req_done <= is_req_done_w;
       // VCS coverage off
       end else if ((req_h_ext_en) == 1'b0) begin
       end else begin
           is_req_done <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_cbuf_ready <= 1'b0;
   end else begin
       is_cbuf_ready <= is_cbuf_ready_w;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// height coordinate count ////////////////
assign {mon_h_coord_w,
        h_coord_w} = (layer_st) ? {1'b0, data_height_st_w} :
                    (~is_req_last_sub_h) ? (h_coord + conv_y_stride) :
                    (~is_req_last_width & is_req_last_sub_h) ? {1'b0, h_coord_sub_h} :
                    (~is_req_last_y_std & is_req_last_width & is_req_last_sub_h) ? (h_coord_sub_h + 1'h1) :
                    (~is_req_last_surf & is_req_last_y_std & is_req_last_width & is_req_last_sub_h) ? {1'b0, h_coord_surf} :
                    (h_coord_surf + {conv_y_stride, 2'b0});
assign height_dummy = (h_coord[13 +1]) | (h_coord[13:0] >= data_height);
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"req_sub_h_en\" -d \"h_coord_w\" -q h_coord");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"req_y_std_en\" -d \"h_coord_w\" -q h_coord_sub_h");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"req_surf_en\" -d \"h_coord_w\" -q h_coord_surf");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_coord <= {15{1'b0}};
   end else begin
       if ((req_sub_h_en) == 1'b1) begin
           h_coord <= h_coord_w;
       // VCS coverage off
       end else if ((req_sub_h_en) == 1'b0) begin
       end else begin
           h_coord <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_coord_sub_h <= {15{1'b0}};
   end else begin
       if ((req_y_std_en) == 1'b1) begin
           h_coord_sub_h <= h_coord_w;
       // VCS coverage off
       end else if ((req_y_std_en) == 1'b0) begin
       end else begin
           h_coord_sub_h <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       h_coord_surf <= {15{1'b0}};
   end else begin
       if ((req_surf_en) == 1'b1) begin
           h_coord_surf <= h_coord_w;
       // VCS coverage off
       end else if ((req_surf_en) == 1'b0) begin
       end else begin
           h_coord_surf <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// package signals ////////////////
assign x_offset = req_sub_w_cnt[12:0];
assign {mon_y_offset,
        y_offset} = h_coord[12:0] * reg2dp_line_stride;
assign {mon_c_offset,
        c_offset} = req_surf_cnt * reg2dp_surf_stride;
assign req_size = req_sub_w_cur;
assign {mon_req_size_out,
        req_size_out} = req_sub_w_cur - 1'b1;
assign req_ready_d1 = ~req_valid_d2 | req_ready_d2;
assign req_valid_d1_w = ~is_running ? 1'b0 :
                        req_valid ? 1'b1 :
                        req_ready_d1 ? 1'b0 :
                        req_valid_d1;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"req_valid_d1_w\" -q req_valid_d1");
//: &eperl::flop("-nodeclare  -norst -en \"req_adv\" -d \"x_offset\" -q x_offset_d1");
//: &eperl::flop("-nodeclare  -norst -en \"req_adv\" -d \"y_offset\" -q y_offset_d1");
//: &eperl::flop("-nodeclare  -norst -en \"req_adv\" -d \"c_offset\" -q c_offset_d1");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"req_adv\" -d \"req_size\" -q req_size_d1");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"req_adv\" -d \"req_size_out\" -q req_size_out_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_adv\" -d \"width_dummy | height_dummy\" -q req_dummy_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_valid_d1 <= 1'b0;
   end else begin
       req_valid_d1 <= req_valid_d1_w;
   end
end
always @(posedge nvdla_core_clk) begin
       if ((req_adv) == 1'b1) begin
           x_offset_d1 <= x_offset;
       // VCS coverage off
       end else if ((req_adv) == 1'b0) begin
       end else begin
           x_offset_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((req_adv) == 1'b1) begin
           y_offset_d1 <= y_offset;
       // VCS coverage off
       end else if ((req_adv) == 1'b0) begin
       end else begin
           y_offset_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((req_adv) == 1'b1) begin
           c_offset_d1 <= c_offset;
       // VCS coverage off
       end else if ((req_adv) == 1'b0) begin
       end else begin
           c_offset_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_size_d1 <= {4{1'b0}};
   end else begin
       if ((req_adv) == 1'b1) begin
           req_size_d1 <= req_size;
       // VCS coverage off
       end else if ((req_adv) == 1'b0) begin
       end else begin
           req_size_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_size_out_d1 <= {3{1'b0}};
   end else begin
       if ((req_adv) == 1'b1) begin
           req_size_out_d1 <= req_size_out;
       // VCS coverage off
       end else if ((req_adv) == 1'b0) begin
       end else begin
           req_size_out_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_dummy_d1 <= 1'b0;
   end else begin
       if ((req_adv) == 1'b1) begin
           req_dummy_d1 <= width_dummy | height_dummy;
       // VCS coverage off
       end else if ((req_adv) == 1'b0) begin
       end else begin
           req_dummy_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// package signals d2 ////////////////
assign req_addr_base = {reg2dp_datain_addr_high_0, reg2dp_datain_addr_low_0};
assign {mon_req_addr_w,
        req_addr_w} = req_addr_base + x_offset_d1 + y_offset_d1 + c_offset_d1;
assign req_valid_d2_w = ~is_running ? 1'b0 :
                        req_valid_d1 ? 1'b1 :
                        req_ready_d2 ? 1'b0 :
                        req_valid_d2;
assign req_ready_d2 = dma_req_fifo_ready & (dma_rd_req_rdy | (req_valid_d2 & req_dummy_d2));
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"req_valid_d2_w\" -q req_valid_d2");
//: &eperl::flop("-nodeclare  -norst -en \"req_valid_d1 & req_ready_d1 & ~req_dummy_d1\" -d \"req_addr_w\" -q req_addr_d2");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"req_valid_d1 & req_ready_d1\" -d \"req_size_d1\" -q req_size_d2");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"req_valid_d1 & req_ready_d1\" -d \"req_size_out_d1\" -q req_size_out_d2");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_valid_d1 & req_ready_d1\" -d \"req_dummy_d1\" -q req_dummy_d2");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_valid_d2 <= 1'b0;
   end else begin
       req_valid_d2 <= req_valid_d2_w;
   end
end
always @(posedge nvdla_core_clk) begin
       if ((req_valid_d1 & req_ready_d1 & ~req_dummy_d1) == 1'b1) begin
           req_addr_d2 <= req_addr_w;
       // VCS coverage off
       end else if ((req_valid_d1 & req_ready_d1 & ~req_dummy_d1) == 1'b0) begin
       end else begin
           req_addr_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_size_d2 <= {4{1'b0}};
   end else begin
       if ((req_valid_d1 & req_ready_d1) == 1'b1) begin
           req_size_d2 <= req_size_d1;
       // VCS coverage off
       end else if ((req_valid_d1 & req_ready_d1) == 1'b0) begin
       end else begin
           req_size_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_size_out_d2 <= {3{1'b0}};
   end else begin
       if ((req_valid_d1 & req_ready_d1) == 1'b1) begin
           req_size_out_d2 <= req_size_out_d1;
       // VCS coverage off
       end else if ((req_valid_d1 & req_ready_d1) == 1'b0) begin
       end else begin
           req_size_out_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_dummy_d2 <= 1'b0;
   end else begin
       if ((req_valid_d1 & req_ready_d1) == 1'b1) begin
           req_dummy_d2 <= req_dummy_d1;
       // VCS coverage off
       end else if ((req_valid_d1 & req_ready_d1) == 1'b0) begin
       end else begin
           req_dummy_d2 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
`ifdef NVDLA_PRINT_CDMA
always @ (posedge nvdla_core_clk)
begin
    if(req_valid_d2 & req_ready_d2)
    begin
        $display("[CDMA WG REQ] Dummy = %d, Addr = 0x%010h, size = %0d, time = %0d", req_dummy_d2, req_addr_d2, req_size_d2, $stime);
    end
end
`endif
////////////////////////////////////////////////////////////////////////
// CDMA DC read request interface //
////////////////////////////////////////////////////////////////////////
//==============
// DMA Interface
//==============
// rd Channel: Request
NV_NVDLA_DMAIF_rdreq NV_NVDLA_PDP_RDMA_rdreq(
  .nvdla_core_clk (nvdla_core_clk )
 ,.nvdla_core_rstn (nvdla_core_rstn )
 ,.reg2dp_src_ram_type (reg2dp_datain_ram_type)
 ,.mcif_rd_req_pd (wg_dat2mcif_rd_req_pd )
 ,.mcif_rd_req_valid (wg_dat2mcif_rd_req_valid)
 ,.mcif_rd_req_ready (wg_dat2mcif_rd_req_ready)
 ,.dmaif_rd_req_pd (dma_rd_req_pd )
 ,.dmaif_rd_req_vld (dma_rd_req_vld )
 ,.dmaif_rd_req_rdy (dma_rd_req_rdy )
);
// rd Channel: Response
NV_NVDLA_DMAIF_rdrsp NV_NVDLA_PDP_RDMA_rdrsp(
   .nvdla_core_clk (nvdla_core_clk )
  ,.nvdla_core_rstn (nvdla_core_rstn )
  ,.mcif_rd_rsp_pd (mcif2wg_dat_rd_rsp_pd )
  ,.mcif_rd_rsp_valid (mcif2wg_dat_rd_rsp_valid )
  ,.mcif_rd_rsp_ready (mcif2wg_dat_rd_rsp_ready )
  ,.dmaif_rd_rsp_pd (dma_rd_rsp_pd )
  ,.dmaif_rd_rsp_pvld (dma_rd_rsp_vld )
  ,.dmaif_rd_rsp_prdy (dma_rd_rsp_rdy )
);
///////////////////////////////////////////
assign dma_rd_req_pd[63:0] = dma_rd_req_addr[63:0];
assign dma_rd_req_pd[78:64] = dma_rd_req_size[14:0];
//assign dma_rd_req_vld = dma_req_fifo_ready & req_valid_d1 & cbuf_entry_ready;
assign dma_rd_req_vld = dma_req_fifo_ready & req_valid_d2 & ~req_dummy_d2;
assign dma_rd_req_addr = {req_addr_d2[58:0], 5'b0};
assign dma_rd_req_size = {{13{1'b0}}, req_size_out_d2};
assign dma_rd_req_type = reg2dp_datain_ram_type;
assign dma_rd_rsp_rdy = ~dma_rd_rsp_blocking;
NV_NVDLA_CDMA_WG_fifo u_fifo (
   .clk (nvdla_core_clk) //|< i
  ,.reset_ (nvdla_core_rstn) //|< i
  ,.wr_ready (dma_req_fifo_ready) //|> w
  ,.wr_req (dma_req_fifo_req) //|< r
  ,.wr_data (dma_req_fifo_data[4:0]) //|< r
  ,.rd_ready (dma_rsp_fifo_ready) //|< r
  ,.rd_req (dma_rsp_fifo_req) //|> w
  ,.rd_data (dma_rsp_fifo_data[4:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  );
assign dma_req_fifo_req = req_valid_d2 & (dma_rd_req_rdy | req_dummy_d2);
assign dma_req_fifo_data = {req_dummy_d2, req_size_d2};
////////////////////////////////////////////////////////////////////////
// CDMA WG read response connection //
////////////////////////////////////////////////////////////////////////
assign dma_rd_rsp_data[511:0] = dma_rd_rsp_pd[511:0];
assign dma_rd_rsp_mask[1:0] = dma_rd_rsp_pd[513:512];
assign {dma_rsp_dummy, dma_rsp_size} = dma_rsp_fifo_data;
assign dma_rd_rsp_blocking = (dma_rsp_fifo_req & dma_rsp_dummy) | sbuf_blocking;
assign dma_rsp_mask[0] = (~dma_rsp_fifo_req | sbuf_blocking) ? 1'b0 :
                         ~dma_rsp_dummy ? (dma_rd_rsp_vld & dma_rd_rsp_mask[0]) :
                         1'b1;
assign dma_rsp_mask[1] = (~dma_rsp_fifo_req | sbuf_blocking) ? 1'b0 :
                         ~dma_rsp_dummy ? (dma_rd_rsp_vld & dma_rd_rsp_mask[1]) :
                         (dma_rsp_size[3:1] == dma_rsp_size_cnt[3:1]) ? 1'b0 :
                         1'b1;
assign {mon_dma_rsp_size_cnt_inc,
        dma_rsp_size_cnt_inc} = dma_rsp_size_cnt + dma_rsp_mask[0] + dma_rsp_mask[1];
assign dma_rsp_size_cnt_w = (dma_rsp_size_cnt_inc == dma_rsp_size) ? 4'b0 :
                            dma_rsp_size_cnt_inc;
assign dma_rsp_vld = dma_rsp_fifo_req & ~sbuf_blocking & (dma_rsp_dummy | dma_rd_rsp_vld);
assign dma_rsp_fifo_ready = (dma_rsp_vld & (dma_rsp_size_cnt_inc == dma_rsp_size));
assign dma_pad_data = {64{reg2dp_pad_value[7:0]}};
assign dma_rsp_data = dma_rsp_dummy ? dma_pad_data[511:0] : dma_rd_rsp_data[511:0];
assign {dma_rsp_data_p1, dma_rsp_data_p0} = dma_rsp_data;
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"dma_rsp_vld\" -d \"dma_rsp_size_cnt_w\" -q dma_rsp_size_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dma_rsp_size_cnt <= {4{1'b0}};
   end else begin
       if ((dma_rsp_vld) == 1'b1) begin
           dma_rsp_size_cnt <= dma_rsp_size_cnt_w;
       // VCS coverage off
       end else if ((dma_rsp_vld) == 1'b0) begin
       end else begin
           dma_rsp_size_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// WG write data to shared buffer //
////////////////////////////////////////////////////////////////////////
//////////////// line selection ////////////////
assign {mon_sbuf_wr_line_w,
        sbuf_wr_line_w} = (layer_st) ? 3'b0 :
                          sbuf_wr_line + 1'b1;
assign is_sbuf_wr_last_line = (sbuf_wr_line == 2'h3);
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"layer_st | dma_rsp_fifo_ready\" -d \"sbuf_wr_line_w\" -q sbuf_wr_line");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_line <= {2{1'b0}};
   end else begin
       if ((layer_st | dma_rsp_fifo_ready) == 1'b1) begin
           sbuf_wr_line <= sbuf_wr_line_w;
       // VCS coverage off
       end else if ((layer_st | dma_rsp_fifo_ready) == 1'b0) begin
       end else begin
           sbuf_wr_line <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// write port 0 ////////////////
assign sbuf_wr_add = dma_rsp_mask[1] ? 2'h2 : 2'h1;
assign {mon_sbuf_wr_p0_base_w,
        sbuf_wr_p0_base_w} = (layer_st) ? 5'b0 :
                            (dma_rsp_fifo_ready & ~is_sbuf_wr_last_line) ? {1'b0, sbuf_wr_p0_base_ori} :
                            ((sbuf_wr_p0_ch[1:0] == 2'h3) & sbuf_wr_p0_of) ? sbuf_wr_p0_base + conv_x_stride :
                            ((sbuf_wr_p0_ch[1:0] == 2'h2) & is_x_stride_one & dma_rsp_mask[1]) ? sbuf_wr_p1_base + conv_x_stride :
                            sbuf_wr_p0_base;
assign {mon_sbuf_wr_p1_base_w,
        sbuf_wr_p1_base_w} = (layer_st) ? 5'b0 :
                            (dma_rsp_fifo_ready & ~is_sbuf_wr_last_line) ? {1'b0, sbuf_wr_p1_base_ori} :
                            ((sbuf_wr_p1_ch[1:0] == 2'h3) & sbuf_wr_p1_of) ? sbuf_wr_p1_base + conv_x_stride :
                            ((sbuf_wr_p1_ch[1:0] == 2'h2) & is_x_stride_one & dma_rsp_mask[1]) ? sbuf_wr_p1_base + conv_x_stride :
                            sbuf_wr_p1_base;
assign sbuf_wr_p0_offset_inc = sbuf_wr_p0_offset + sbuf_wr_add;
assign sbuf_wr_p1_offset_inc = sbuf_wr_p1_offset + sbuf_wr_add;
assign sbuf_wr_p0_of_0 = (sbuf_wr_p0_offset_inc == conv_x_stride) | is_x_stride_one;
assign sbuf_wr_p0_of_1 = (sbuf_wr_p0_offset_inc > conv_x_stride);
assign sbuf_wr_p0_of = sbuf_wr_p0_of_0 | sbuf_wr_p0_of_1;
assign sbuf_wr_p1_of_0 = (sbuf_wr_p1_offset_inc == conv_x_stride) | is_x_stride_one;
assign sbuf_wr_p1_of_1 = (sbuf_wr_p1_offset_inc > conv_x_stride);
assign sbuf_wr_p1_of = sbuf_wr_p1_of_0 | sbuf_wr_p1_of_1;
assign sbuf_wr_p0_offset_w = (layer_st | is_x_stride_one) ? 3'b0 :
                             (dma_rsp_fifo_ready & ~is_sbuf_wr_last_line) ? sbuf_wr_p0_offset_ori :
                             (sbuf_wr_p0_of_1) ? 3'b1 :
                             (sbuf_wr_p0_of_0) ? 3'b0 :
                             sbuf_wr_p0_offset_inc[2:0];
assign sbuf_wr_p1_offset_w = (is_x_stride_one_w) ? 3'b0 :
                             (layer_st) ? 3'b1 :
                             (dma_rsp_fifo_ready & ~is_sbuf_wr_last_line) ? sbuf_wr_p1_offset_ori :
                             (sbuf_wr_p1_of_1) ? 3'b1 :
                             (sbuf_wr_p1_of_0) ? 3'b0 :
                             sbuf_wr_p1_offset_inc[2:0];
assign {mon_sbuf_wr_p0_ch_inc,
        sbuf_wr_p0_ch_inc} = (is_x_stride_one) ? (sbuf_wr_p0_ch + sbuf_wr_add) :
                             (sbuf_wr_p0_ch + 1'b1);
assign {mon_sbuf_wr_p1_ch_inc,
        sbuf_wr_p1_ch_inc} = (is_x_stride_one) ? (sbuf_wr_p1_ch + sbuf_wr_add) :
                             (sbuf_wr_p1_ch + 1'b1);
assign sbuf_wr_p0_ch_w = (layer_st) ? 4'b0 :
                         (dma_rsp_fifo_ready & ~is_sbuf_wr_last_line) ? sbuf_wr_p0_ch_ori :
                         (dma_rsp_fifo_ready & is_sbuf_wr_last_line & sbuf_wr_p0_of) ? {2'd0, sbuf_wr_p0_ch_inc[1:0]} :
                         (dma_rsp_fifo_ready & is_sbuf_wr_last_line & ~sbuf_wr_p0_of) ? {2'd0, sbuf_wr_p0_ch[1:0]} :
                         (sbuf_wr_p0_of) ? sbuf_wr_p0_ch_inc :
                         sbuf_wr_p0_ch;
assign sbuf_wr_p1_ch_w = (layer_st & is_x_stride_one_w) ? 2'b1 :
                         (layer_st & ~is_x_stride_one_w) ? 2'b0 :
                         (dma_rsp_fifo_ready & ~is_sbuf_wr_last_line) ? sbuf_wr_p1_ch_ori :
                         (sbuf_wr_p1_of) ? sbuf_wr_p1_ch_inc :
                         sbuf_wr_p1_ch;
assign sbuf_wr_addr_en = layer_st | dma_rsp_vld;
assign sbuf_wr_addr_ori_en = layer_st | (dma_rsp_fifo_ready & is_sbuf_wr_last_line);
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"sbuf_wr_addr_en\" -d \"sbuf_wr_p0_base_w\" -q sbuf_wr_p0_base");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"sbuf_wr_addr_en\" -d \"sbuf_wr_p1_base_w\" -q sbuf_wr_p1_base");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"sbuf_wr_addr_en\" -d \"sbuf_wr_p0_offset_w\" -q sbuf_wr_p0_offset");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"sbuf_wr_addr_en\" -d \"sbuf_wr_p1_offset_w\" -q sbuf_wr_p1_offset");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"sbuf_wr_addr_en\" -d \"sbuf_wr_p0_ch_w\" -q sbuf_wr_p0_ch");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"sbuf_wr_addr_en\" -d \"sbuf_wr_p1_ch_w\" -q sbuf_wr_p1_ch");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"sbuf_wr_addr_ori_en\" -d \"sbuf_wr_p0_base_w\" -q sbuf_wr_p0_base_ori");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"sbuf_wr_addr_ori_en\" -d \"sbuf_wr_p1_base_w\" -q sbuf_wr_p1_base_ori");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"sbuf_wr_addr_ori_en\" -d \"sbuf_wr_p0_offset_w\" -q sbuf_wr_p0_offset_ori");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"sbuf_wr_addr_ori_en\" -d \"sbuf_wr_p1_offset_w\" -q sbuf_wr_p1_offset_ori");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"sbuf_wr_addr_ori_en\" -d \"sbuf_wr_p0_ch_w\" -q sbuf_wr_p0_ch_ori");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"sbuf_wr_addr_ori_en\" -d \"sbuf_wr_p1_ch_w\" -q sbuf_wr_p1_ch_ori");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_base <= {4{1'b0}};
   end else begin
       if ((sbuf_wr_addr_en) == 1'b1) begin
           sbuf_wr_p0_base <= sbuf_wr_p0_base_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_en) == 1'b0) begin
       end else begin
           sbuf_wr_p0_base <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_base <= {4{1'b0}};
   end else begin
       if ((sbuf_wr_addr_en) == 1'b1) begin
           sbuf_wr_p1_base <= sbuf_wr_p1_base_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_en) == 1'b0) begin
       end else begin
           sbuf_wr_p1_base <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_offset <= {3{1'b0}};
   end else begin
       if ((sbuf_wr_addr_en) == 1'b1) begin
           sbuf_wr_p0_offset <= sbuf_wr_p0_offset_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_en) == 1'b0) begin
       end else begin
           sbuf_wr_p0_offset <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_offset <= {3{1'b0}};
   end else begin
       if ((sbuf_wr_addr_en) == 1'b1) begin
           sbuf_wr_p1_offset <= sbuf_wr_p1_offset_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_en) == 1'b0) begin
       end else begin
           sbuf_wr_p1_offset <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_ch <= {4{1'b0}};
   end else begin
       if ((sbuf_wr_addr_en) == 1'b1) begin
           sbuf_wr_p0_ch <= sbuf_wr_p0_ch_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_en) == 1'b0) begin
       end else begin
           sbuf_wr_p0_ch <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_ch <= {2{1'b0}};
   end else begin
       if ((sbuf_wr_addr_en) == 1'b1) begin
           sbuf_wr_p1_ch <= sbuf_wr_p1_ch_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_en) == 1'b0) begin
       end else begin
           sbuf_wr_p1_ch <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_base_ori <= {4{1'b0}};
   end else begin
       if ((sbuf_wr_addr_ori_en) == 1'b1) begin
           sbuf_wr_p0_base_ori <= sbuf_wr_p0_base_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_ori_en) == 1'b0) begin
       end else begin
           sbuf_wr_p0_base_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_base_ori <= {4{1'b0}};
   end else begin
       if ((sbuf_wr_addr_ori_en) == 1'b1) begin
           sbuf_wr_p1_base_ori <= sbuf_wr_p1_base_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_ori_en) == 1'b0) begin
       end else begin
           sbuf_wr_p1_base_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_offset_ori <= {3{1'b0}};
   end else begin
       if ((sbuf_wr_addr_ori_en) == 1'b1) begin
           sbuf_wr_p0_offset_ori <= sbuf_wr_p0_offset_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_ori_en) == 1'b0) begin
       end else begin
           sbuf_wr_p0_offset_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_offset_ori <= {3{1'b0}};
   end else begin
       if ((sbuf_wr_addr_ori_en) == 1'b1) begin
           sbuf_wr_p1_offset_ori <= sbuf_wr_p1_offset_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_ori_en) == 1'b0) begin
       end else begin
           sbuf_wr_p1_offset_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_ch_ori <= {4{1'b0}};
   end else begin
       if ((sbuf_wr_addr_ori_en) == 1'b1) begin
           sbuf_wr_p0_ch_ori <= sbuf_wr_p0_ch_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_ori_en) == 1'b0) begin
       end else begin
           sbuf_wr_p0_ch_ori <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_ch_ori <= {2{1'b0}};
   end else begin
       if ((sbuf_wr_addr_ori_en) == 1'b1) begin
           sbuf_wr_p1_ch_ori <= sbuf_wr_p1_ch_w;
       // VCS coverage off
       end else if ((sbuf_wr_addr_ori_en) == 1'b0) begin
       end else begin
           sbuf_wr_p1_ch_ori <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// current write index ////////////////
assign {mon_sbuf_wr_p0_idx_lo,
        sbuf_wr_p0_idx_lo} = sbuf_wr_p0_base + sbuf_wr_p0_offset;
assign {mon_sbuf_wr_p1_idx_lo,
        sbuf_wr_p1_idx_lo} = sbuf_wr_p1_base + sbuf_wr_p1_offset;
assign sbuf_wr_p0_idx = {sbuf_wr_p0_idx_lo[0], sbuf_wr_line[0], sbuf_wr_p0_ch[1:0], sbuf_wr_line[1], sbuf_wr_p0_idx_lo[8 -5:1]};
assign sbuf_wr_p1_idx = {sbuf_wr_p1_idx_lo[0], sbuf_wr_line[0], sbuf_wr_p1_ch[1:0], sbuf_wr_line[1], sbuf_wr_p1_idx_lo[8 -5:1]};
assign sbuf_x_stride_inc_size = (~dma_rsp_fifo_ready | ~is_sbuf_wr_last_line) ? 2'b0 :
                                (sbuf_wr_p0_of) ? sbuf_wr_p0_ch_inc[3:2] : sbuf_wr_p0_ch[3:2];
assign sbuf_cube_inc_size = sbuf_x_stride_inc_size[1] ? {conv_x_stride[2:0], 1'b0} :
                            sbuf_x_stride_inc_size[0] ? conv_x_stride :
                            4'b0;
assign sbuf_wr_p0_en = dma_rsp_vld & dma_rsp_mask[0];
assign sbuf_wr_p1_en = dma_rsp_vld & dma_rsp_mask[1];
assign sbuf_cube_inc_en = dma_rsp_fifo_ready & is_sbuf_wr_last_line;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sbuf_wr_p0_en\" -q sbuf_wr_p0_en_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sbuf_wr_p1_en\" -q sbuf_wr_p1_en_d1");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"sbuf_wr_p0_en\" -d \"sbuf_wr_p0_idx\" -q sbuf_wr_p0_idx_d1");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"sbuf_wr_p1_en\" -d \"sbuf_wr_p1_idx\" -q sbuf_wr_p1_idx_d1");
//: &eperl::flop("-nodeclare   -rval \"{256{1'b0}}\"  -en \"sbuf_wr_p0_en\" -d \"dma_rsp_data_p0\" -q sbuf_wr_p0_data_d1");
//: &eperl::flop("-nodeclare   -rval \"{256{1'b0}}\"  -en \"sbuf_wr_p1_en\" -d \"dma_rsp_data_p1\" -q sbuf_wr_p1_data_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sbuf_cube_inc_en\" -q sbuf_cube_inc_en_d1");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"sbuf_cube_inc_en\" -d \"sbuf_cube_inc_size\" -q sbuf_cube_inc_size_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_en_d1 <= 1'b0;
   end else begin
       sbuf_wr_p0_en_d1 <= sbuf_wr_p0_en;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_en_d1 <= 1'b0;
   end else begin
       sbuf_wr_p1_en_d1 <= sbuf_wr_p1_en;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_idx_d1 <= {8{1'b0}};
   end else begin
       if ((sbuf_wr_p0_en) == 1'b1) begin
           sbuf_wr_p0_idx_d1 <= sbuf_wr_p0_idx;
       // VCS coverage off
       end else if ((sbuf_wr_p0_en) == 1'b0) begin
       end else begin
           sbuf_wr_p0_idx_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_idx_d1 <= {8{1'b0}};
   end else begin
       if ((sbuf_wr_p1_en) == 1'b1) begin
           sbuf_wr_p1_idx_d1 <= sbuf_wr_p1_idx;
       // VCS coverage off
       end else if ((sbuf_wr_p1_en) == 1'b0) begin
       end else begin
           sbuf_wr_p1_idx_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p0_data_d1 <= {256{1'b0}};
   end else begin
       if ((sbuf_wr_p0_en) == 1'b1) begin
           sbuf_wr_p0_data_d1 <= dma_rsp_data_p0;
       // VCS coverage off
       end else if ((sbuf_wr_p0_en) == 1'b0) begin
       end else begin
           sbuf_wr_p0_data_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_wr_p1_data_d1 <= {256{1'b0}};
   end else begin
       if ((sbuf_wr_p1_en) == 1'b1) begin
           sbuf_wr_p1_data_d1 <= dma_rsp_data_p1;
       // VCS coverage off
       end else if ((sbuf_wr_p1_en) == 1'b0) begin
       end else begin
           sbuf_wr_p1_data_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_cube_inc_en_d1 <= 1'b0;
   end else begin
       sbuf_cube_inc_en_d1 <= sbuf_cube_inc_en;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_cube_inc_size_d1 <= {4{1'b0}};
   end else begin
       if ((sbuf_cube_inc_en) == 1'b1) begin
           sbuf_cube_inc_size_d1 <= sbuf_cube_inc_size;
       // VCS coverage off
       end else if ((sbuf_cube_inc_en) == 1'b0) begin
       end else begin
           sbuf_cube_inc_size_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// Shared buffer write signals //
////////////////////////////////////////////////////////////////////////
assign wg2sbuf_p0_wr_en = sbuf_wr_p0_en_d1;
assign wg2sbuf_p1_wr_en = sbuf_wr_p1_en_d1;
assign wg2sbuf_p0_wr_addr = sbuf_wr_p0_idx_d1;
assign wg2sbuf_p1_wr_addr = sbuf_wr_p1_idx_d1;
assign wg2sbuf_p0_wr_data = sbuf_wr_p0_data_d1;
assign wg2sbuf_p1_wr_data = sbuf_wr_p1_data_d1;
////////////////////////////////////////////////////////////////////////
// WG read data from shared buffer //
////////////////////////////////////////////////////////////////////////
assign sbuf_avl_cube_add = sbuf_cube_inc_en_d1 ? sbuf_cube_inc_size_d1 : 4'b0;
assign sbuf_avl_cube_sub = sbuf_rd_en & (rd_sub_cnt == 3'h7);
assign {mon_sbuf_avl_cube_w,
        sbuf_avl_cube_w} = (layer_st) ? 5'b0 :
                          (sbuf_avl_cube + sbuf_avl_cube_add - sbuf_avl_cube_sub);
assign sbuf_blocking_w = (sbuf_avl_cube_w >= 4'h8) ? 1'b1 : 1'b0;
assign sbuf_rd_en = (|sbuf_avl_cube);
assign {mon_rd_sub_cnt_w,
        rd_sub_cnt_w} = (layer_st) ? 4'b0 :
                       (rd_sub_cnt + 1'b1);
assign sbuf_avl_cube_en = sbuf_avl_cube_sub | sbuf_cube_inc_en_d1;
assign {mon_rd_cube_cnt_w,
        rd_cube_cnt_w} = (layer_st) ? 5'b0 :
                        rd_cube_cnt + 1;
assign sbuf_rd_p0_idx = {rd_cube_cnt[0], 1'b0, rd_sub_cnt[0], rd_cube_cnt[8 -5:1], rd_sub_cnt[2:1]};
assign sbuf_rd_p1_idx = {rd_cube_cnt[0], 1'b1, rd_sub_cnt[0], rd_cube_cnt[8 -5:1], rd_sub_cnt[2:1]};
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"layer_st | sbuf_avl_cube_en\" -d \"sbuf_avl_cube_w\" -q sbuf_avl_cube");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"layer_st | sbuf_avl_cube_en\" -d \"sbuf_blocking_w\" -q sbuf_blocking");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"layer_st | sbuf_avl_cube_sub\" -d \"rd_cube_cnt_w\" -q rd_cube_cnt");
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"layer_st | sbuf_rd_en\" -d \"rd_sub_cnt_w\" -q rd_sub_cnt");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sbuf_rd_en\" -q sbuf_rd_en_d1");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"sbuf_rd_en\" -d \"sbuf_rd_p0_idx\" -q sbuf_rd_p0_idx_d1");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"sbuf_rd_en\" -d \"sbuf_rd_p1_idx\" -q sbuf_rd_p1_idx_d1");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"sbuf_rd_en\" -d \"rd_sub_cnt[1:0]\" -q sbuf_rd_sel_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_avl_cube <= {4{1'b0}};
   end else begin
       if ((layer_st | sbuf_avl_cube_en) == 1'b1) begin
           sbuf_avl_cube <= sbuf_avl_cube_w;
       // VCS coverage off
       end else if ((layer_st | sbuf_avl_cube_en) == 1'b0) begin
       end else begin
           sbuf_avl_cube <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_blocking <= 1'b0;
   end else begin
       if ((layer_st | sbuf_avl_cube_en) == 1'b1) begin
           sbuf_blocking <= sbuf_blocking_w;
       // VCS coverage off
       end else if ((layer_st | sbuf_avl_cube_en) == 1'b0) begin
       end else begin
           sbuf_blocking <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rd_cube_cnt <= {4{1'b0}};
   end else begin
       if ((layer_st | sbuf_avl_cube_sub) == 1'b1) begin
           rd_cube_cnt <= rd_cube_cnt_w;
       // VCS coverage off
       end else if ((layer_st | sbuf_avl_cube_sub) == 1'b0) begin
       end else begin
           rd_cube_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rd_sub_cnt <= {3{1'b0}};
   end else begin
       if ((layer_st | sbuf_rd_en) == 1'b1) begin
           rd_sub_cnt <= rd_sub_cnt_w;
       // VCS coverage off
       end else if ((layer_st | sbuf_rd_en) == 1'b0) begin
       end else begin
           rd_sub_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_rd_en_d1 <= 1'b0;
   end else begin
       sbuf_rd_en_d1 <= sbuf_rd_en;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_rd_p0_idx_d1 <= {8{1'b0}};
   end else begin
       if ((sbuf_rd_en) == 1'b1) begin
           sbuf_rd_p0_idx_d1 <= sbuf_rd_p0_idx;
       // VCS coverage off
       end else if ((sbuf_rd_en) == 1'b0) begin
       end else begin
           sbuf_rd_p0_idx_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_rd_p1_idx_d1 <= {8{1'b0}};
   end else begin
       if ((sbuf_rd_en) == 1'b1) begin
           sbuf_rd_p1_idx_d1 <= sbuf_rd_p1_idx;
       // VCS coverage off
       end else if ((sbuf_rd_en) == 1'b0) begin
       end else begin
           sbuf_rd_p1_idx_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_rd_sel_d1 <= {2{1'b0}};
   end else begin
       if ((sbuf_rd_en) == 1'b1) begin
           sbuf_rd_sel_d1 <= rd_sub_cnt[1:0];
       // VCS coverage off
       end else if ((sbuf_rd_en) == 1'b0) begin
       end else begin
           sbuf_rd_sel_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// Shared buffer read signals //
////////////////////////////////////////////////////////////////////////
assign wg2sbuf_p0_rd_en = sbuf_rd_en_d1;
assign wg2sbuf_p1_rd_en = sbuf_rd_en_d1;
assign wg2sbuf_p0_rd_addr = sbuf_rd_p0_idx_d1;
assign wg2sbuf_p1_rd_addr = sbuf_rd_p1_idx_d1;
////////////////////////////////////////////////////////////////////////
// pipeline to sync the sbuf read to output to convertor //
////////////////////////////////////////////////////////////////////////
//: my $latency = 2;
//: my $i;
//: my $j;
//: if($latency == 0) {
//: print "assign rsp_vld = sbuf_rd_en_d1;\n";
//: print "assign rsp_sel = sbuf_rd_sel_d1;\n";
//: } else {
//: print "assign rsp_vld_d0 = sbuf_rd_en_d1;\n";
//: print "assign rsp_sel_d0 = sbuf_rd_sel_d1;\n";
//: for($i = 0; $i < $latency; $i ++) {
//: $j = $i + 1;
//: &eperl::flop("-wid 1   -rval \"1'b0\"                             -d \"rsp_vld_d${i}\" -q rsp_vld_d${j}");
//: &eperl::flop("-wid 2   -rval \"{2{1'b0}}\"  -en \"rsp_vld_d${i}\" -d \"rsp_sel_d${i}\" -q rsp_sel_d${j}");
//: }
//: print "\n\n";
//: print "assign rsp_vld = rsp_vld_d${i};\n";
//: print "assign rsp_sel = rsp_sel_d${i};\n\n\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign rsp_vld_d0 = sbuf_rd_en_d1;
assign rsp_sel_d0 = sbuf_rd_sel_d1;
reg  rsp_vld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_vld_d1 <= 1'b0;
   end else begin
       rsp_vld_d1 <= rsp_vld_d0;
   end
end
reg [1:0] rsp_sel_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sel_d1 <= {2{1'b0}};
   end else begin
       if ((rsp_vld_d0) == 1'b1) begin
           rsp_sel_d1 <= rsp_sel_d0;
       // VCS coverage off
       end else if ((rsp_vld_d0) == 1'b0) begin
       end else begin
           rsp_sel_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  rsp_vld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_vld_d2 <= 1'b0;
   end else begin
       rsp_vld_d2 <= rsp_vld_d1;
   end
end
reg [1:0] rsp_sel_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sel_d2 <= {2{1'b0}};
   end else begin
       if ((rsp_vld_d1) == 1'b1) begin
           rsp_sel_d2 <= rsp_sel_d1;
       // VCS coverage off
       end else if ((rsp_vld_d1) == 1'b0) begin
       end else begin
           rsp_sel_d2 <= 'bx;
       // VCS coverage on
       end
   end
end


assign rsp_vld = rsp_vld_d2;
assign rsp_sel = rsp_sel_d2;



//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// WG local cache //
////////////////////////////////////////////////////////////////////////
assign rsp_data_l0c0_en = (rsp_vld & (rsp_sel == 2'h0));
assign rsp_data_l0c1_en = (rsp_vld & (rsp_sel == 2'h1));
assign rsp_data_l1c0_en = (rsp_vld & (rsp_sel == 2'h2));
assign rsp_data_l1c1_en = (rsp_vld & (rsp_sel == 2'h3));
//: &eperl::flop("-nodeclare  -norst -en \"rsp_data_l0c0_en\" -d \"{wg2sbuf_p1_rd_data, wg2sbuf_p0_rd_data}\" -q rsp_data_l0c0");
//: &eperl::flop("-nodeclare  -norst -en \"rsp_data_l0c1_en\" -d \"{wg2sbuf_p1_rd_data, wg2sbuf_p0_rd_data}\" -q rsp_data_l0c1");
//: &eperl::flop("-nodeclare  -norst -en \"rsp_data_l1c0_en\" -d \"{wg2sbuf_p1_rd_data, wg2sbuf_p0_rd_data}\" -q rsp_data_l1c0");
//: &eperl::flop("-nodeclare  -norst -en \"rsp_data_l1c1_en\" -d \"{wg2sbuf_p1_rd_data, wg2sbuf_p0_rd_data}\" -q rsp_data_l1c1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"rsp_vld\" -q rsp_dat_vld_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"rsp_dat_vld_d1\" -q rsp_dat_vld_d2");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk) begin
       if ((rsp_data_l0c0_en) == 1'b1) begin
           rsp_data_l0c0 <= {wg2sbuf_p1_rd_data, wg2sbuf_p0_rd_data};
       // VCS coverage off
       end else if ((rsp_data_l0c0_en) == 1'b0) begin
       end else begin
           rsp_data_l0c0 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((rsp_data_l0c1_en) == 1'b1) begin
           rsp_data_l0c1 <= {wg2sbuf_p1_rd_data, wg2sbuf_p0_rd_data};
       // VCS coverage off
       end else if ((rsp_data_l0c1_en) == 1'b0) begin
       end else begin
           rsp_data_l0c1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((rsp_data_l1c0_en) == 1'b1) begin
           rsp_data_l1c0 <= {wg2sbuf_p1_rd_data, wg2sbuf_p0_rd_data};
       // VCS coverage off
       end else if ((rsp_data_l1c0_en) == 1'b0) begin
       end else begin
           rsp_data_l1c0 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((rsp_data_l1c1_en) == 1'b1) begin
           rsp_data_l1c1 <= {wg2sbuf_p1_rd_data, wg2sbuf_p0_rd_data};
       // VCS coverage off
       end else if ((rsp_data_l1c1_en) == 1'b0) begin
       end else begin
           rsp_data_l1c1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_dat_vld_d1 <= 1'b0;
   end else begin
       rsp_dat_vld_d1 <= rsp_vld;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_dat_vld_d2 <= 1'b0;
   end else begin
       rsp_dat_vld_d2 <= rsp_dat_vld_d1;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// WG response data counter //
////////////////////////////////////////////////////////////////////////
//////////////// sub cube count ////////////////
assign {mon_rsp_sub_cube_cnt_inc,
        rsp_sub_cube_cnt_inc} = rsp_sub_cube_cnt + 1'b1;
assign rsp_sub_cube_cnt_w = (layer_st | is_rsp_last_sub_cube) ? 3'b0 :
                            rsp_sub_cube_cnt_inc;
assign is_rsp_last_sub_cube = (rsp_sub_cube_cnt == 3'h7);
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"rsp_sub_cube_en\" -d \"rsp_sub_cube_cnt_w\" -q rsp_sub_cube_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_sub_cube_cnt <= {3{1'b0}};
   end else begin
       if ((rsp_sub_cube_en) == 1'b1) begin
           rsp_sub_cube_cnt <= rsp_sub_cube_cnt_w;
       // VCS coverage off
       end else if ((rsp_sub_cube_en) == 1'b0) begin
       end else begin
           rsp_sub_cube_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// conv x stride count ////////////////
assign {mon_rsp_x_std_cnt_inc,
        rsp_x_std_cnt_inc} = rsp_x_std_cnt + 1'b1;
assign rsp_x_std_cnt_w = (layer_st | is_rsp_last_x_std) ? 3'b0 :
                         rsp_x_std_cnt_inc;
assign is_rsp_last_x_std = (rsp_x_std_cnt == reg2dp_conv_x_stride);
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"rsp_x_std_en\" -d \"rsp_x_std_cnt_w\" -q rsp_x_std_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_x_std_cnt <= {3{1'b0}};
   end else begin
       if ((rsp_x_std_en) == 1'b1) begin
           rsp_x_std_cnt <= rsp_x_std_cnt_w;
       // VCS coverage off
       end else if ((rsp_x_std_en) == 1'b0) begin
       end else begin
           rsp_x_std_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// width_ext count ////////////////
assign {mon_rsp_width_cnt_inc,
        rsp_width_cnt_inc} = rsp_width_cnt + 1'b1;
assign rsp_width_cnt_w = (layer_st | is_rsp_last_width) ? 11'b0 :
                         rsp_width_cnt_inc;
assign is_rsp_last_width = (rsp_width_cnt == width_ext_total);
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"rsp_width_en\" -d \"rsp_width_cnt_w\" -q rsp_width_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_width_cnt <= {11{1'b0}};
   end else begin
       if ((rsp_width_en) == 1'b1) begin
           rsp_width_cnt <= rsp_width_cnt_w;
       // VCS coverage off
       end else if ((rsp_width_en) == 1'b0) begin
       end else begin
           rsp_width_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// conv y stride count ////////////////
assign {mon_rsp_y_std_cnt_inc,
        rsp_y_std_cnt_inc} = rsp_y_std_cnt + 1'b1;
assign rsp_y_std_cnt_w = (layer_st | is_rsp_last_y_std) ? 3'b0 :
                         rsp_y_std_cnt_inc;
assign is_rsp_last_y_std = (rsp_y_std_cnt == reg2dp_conv_y_stride);
//: &eperl::flop("-nodeclare   -rval \"{3{1'b0}}\"  -en \"rsp_y_std_en\" -d \"rsp_y_std_cnt_w\" -q rsp_y_std_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_y_std_cnt <= {3{1'b0}};
   end else begin
       if ((rsp_y_std_en) == 1'b1) begin
           rsp_y_std_cnt <= rsp_y_std_cnt_w;
       // VCS coverage off
       end else if ((rsp_y_std_en) == 1'b0) begin
       end else begin
           rsp_y_std_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// surf count ////////////////
assign {mon_rsp_surf_cnt_inc,
        rsp_surf_cnt_inc} = rsp_surf_cnt + 1'b1;
assign rsp_surf_cnt_w = (layer_st | is_rsp_last_surf) ? 4'b0 :
                        rsp_surf_cnt_inc;
assign is_rsp_last_surf = (rsp_surf_cnt == surf_cnt_total);
//: &eperl::flop("-nodeclare   -rval \"{9{1'b0}}\"  -en \"rsp_surf_en\" -d \"rsp_surf_cnt_w\" -q rsp_surf_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_surf_cnt <= {9{1'b0}};
   end else begin
       if ((rsp_surf_en) == 1'b1) begin
           rsp_surf_cnt <= rsp_surf_cnt_w;
       // VCS coverage off
       end else if ((rsp_surf_en) == 1'b0) begin
       end else begin
           rsp_surf_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// height ext ////////////////
assign {mon_rsp_h_ext_cnt_inc,
        rsp_h_ext_cnt_inc} = rsp_h_ext_cnt + 1'b1;
assign rsp_h_ext_cnt_w = layer_st ? 11'b0 :
                         rsp_h_ext_cnt_inc;
assign is_rsp_last_h_ext = (rsp_h_ext_cnt == height_ext_total);
//: &eperl::flop("-nodeclare   -rval \"{11{1'b0}}\"  -en \"rsp_h_ext_en\" -d \"rsp_h_ext_cnt_w\" -q rsp_h_ext_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_h_ext_cnt <= {11{1'b0}};
   end else begin
       if ((rsp_h_ext_en) == 1'b1) begin
           rsp_h_ext_cnt <= rsp_h_ext_cnt_w;
       // VCS coverage off
       end else if ((rsp_h_ext_en) == 1'b0) begin
       end else begin
           rsp_h_ext_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// control signal ////////////////
assign rsp_en = rsp_dat_vld_d2;
assign rsp_sub_cube_en = layer_st | rsp_en;
assign rsp_x_std_en = layer_st | (rsp_en & is_rsp_last_sub_cube);
assign rsp_width_en = layer_st | (rsp_en & is_rsp_last_sub_cube & is_rsp_last_x_std);
assign rsp_y_std_en = layer_st | (rsp_en & is_rsp_last_sub_cube & is_rsp_last_x_std & is_rsp_last_width);
assign rsp_surf_en = layer_st | (rsp_en & is_rsp_last_sub_cube & is_rsp_last_x_std & is_rsp_last_width & is_rsp_last_y_std);
assign rsp_h_ext_en = layer_st | (rsp_en & is_rsp_last_sub_cube & is_rsp_last_x_std & is_rsp_last_width & is_rsp_last_y_std & is_rsp_last_surf);
assign is_slice_done = (is_rsp_last_sub_cube & is_rsp_last_x_std & is_rsp_last_width & is_rsp_last_y_std & is_rsp_last_surf);
assign is_last_rsp = (is_rsp_last_sub_cube & is_rsp_last_x_std & is_rsp_last_width & is_rsp_last_y_std & is_rsp_last_surf & is_rsp_last_h_ext);
////////////////////////////////////////////////////////////////////////
// WG response CBUF address generator //
////////////////////////////////////////////////////////////////////////
//////////////// base address ////////////////
assign {mon_rsp_addr_offset_w,
        rsp_addr_offset_w} = layer_st ? 13'b0 :
                            rsp_addr_offset + data_entries;
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"is_first_running\" -d \"status2dma_wr_idx\" -q rsp_addr_base");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"rsp_h_ext_en\" -d \"rsp_addr_offset_w\" -q rsp_addr_offset");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_addr_base <= {12{1'b0}};
   end else begin
       if ((is_first_running) == 1'b1) begin
           rsp_addr_base <= status2dma_wr_idx;
       // VCS coverage off
       end else if ((is_first_running) == 1'b0) begin
       end else begin
           rsp_addr_base <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_addr_offset <= {12{1'b0}};
   end else begin
       if ((rsp_h_ext_en) == 1'b1) begin
           rsp_addr_offset <= rsp_addr_offset_w;
       // VCS coverage off
       end else if ((rsp_h_ext_en) == 1'b0) begin
       end else begin
           rsp_addr_offset <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// offset ////////////////
//aaa = rsp_sub_surf * data_width_ext
//bbb = rsp_sub_surf * data_width_ext * conv_x_stride;
//ccc = rsp_sub_surf_per_surf * data_width_ext;
assign rsp_ch_x_std_add = {w_ext_surf[12 -3:0], 2'b0};
assign rsp_ch_y_std_add = {h_ext_surf[12 -3:0], 2'b0};
assign rsp_ch_surf_add = {data_width_ext[12 -3:0], 2'b0};
assign {mon_rsp_ch_offset_w,
        rsp_ch_offset_w} = (layer_st) ? 13'b0 :
                          (~is_rsp_last_sub_cube) ? (rsp_ch_offset + data_width_ext) :
                          (~is_rsp_last_x_std) ? (rsp_ch_x_std_base + rsp_ch_x_std_add) :
                          (~is_rsp_last_width) ? (rsp_ch_w_base + 1'b1) :
                          (~is_rsp_last_y_std) ? (rsp_ch_y_std_base + rsp_ch_y_std_add) :
                          (~is_rsp_last_surf) ? (rsp_ch_surf_base + rsp_ch_surf_add) :
                          13'b0;
assign rsp_ch_offset_en = (rsp_en & rsp_sub_cube_cnt[0]);
assign rsp_ch_x_std_base_en = rsp_ch_offset_en & is_rsp_last_sub_cube;
assign rsp_ch_w_base_en = rsp_ch_offset_en & is_rsp_last_sub_cube & is_rsp_last_x_std;
assign rsp_ch_y_std_base_en = rsp_ch_offset_en & is_rsp_last_sub_cube & is_rsp_last_x_std & is_rsp_last_width;
assign rsp_ch_surf_base_en = rsp_ch_offset_en & is_rsp_last_sub_cube & is_rsp_last_x_std & is_rsp_last_width & is_rsp_last_y_std;
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"rsp_ch_offset_en\" -d \"rsp_ch_offset_w\" -q rsp_ch_offset");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"rsp_ch_x_std_base_en\" -d \"rsp_ch_offset_w\" -q rsp_ch_x_std_base");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"rsp_ch_w_base_en\" -d \"rsp_ch_offset_w\" -q rsp_ch_w_base");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"rsp_ch_y_std_base_en\" -d \"rsp_ch_offset_w\" -q rsp_ch_y_std_base");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"rsp_ch_surf_base_en\" -d \"rsp_ch_offset_w\" -q rsp_ch_surf_base");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_ch_offset <= {12{1'b0}};
   end else begin
       if ((rsp_ch_offset_en) == 1'b1) begin
           rsp_ch_offset <= rsp_ch_offset_w;
       // VCS coverage off
       end else if ((rsp_ch_offset_en) == 1'b0) begin
       end else begin
           rsp_ch_offset <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_ch_x_std_base <= {12{1'b0}};
   end else begin
       if ((rsp_ch_x_std_base_en) == 1'b1) begin
           rsp_ch_x_std_base <= rsp_ch_offset_w;
       // VCS coverage off
       end else if ((rsp_ch_x_std_base_en) == 1'b0) begin
       end else begin
           rsp_ch_x_std_base <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_ch_w_base <= {12{1'b0}};
   end else begin
       if ((rsp_ch_w_base_en) == 1'b1) begin
           rsp_ch_w_base <= rsp_ch_offset_w;
       // VCS coverage off
       end else if ((rsp_ch_w_base_en) == 1'b0) begin
       end else begin
           rsp_ch_w_base <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_ch_y_std_base <= {12{1'b0}};
   end else begin
       if ((rsp_ch_y_std_base_en) == 1'b1) begin
           rsp_ch_y_std_base <= rsp_ch_offset_w;
       // VCS coverage off
       end else if ((rsp_ch_y_std_base_en) == 1'b0) begin
       end else begin
           rsp_ch_y_std_base <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_ch_surf_base <= {12{1'b0}};
   end else begin
       if ((rsp_ch_surf_base_en) == 1'b1) begin
           rsp_ch_surf_base <= rsp_ch_offset_w;
       // VCS coverage off
       end else if ((rsp_ch_surf_base_en) == 1'b0) begin
       end else begin
           rsp_ch_surf_base <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// write address  ////////////////
assign {mon_rsp_addr_inc,
        rsp_addr_inc} = rsp_addr_base + rsp_addr_offset + rsp_ch_offset;
assign {mon_rsp_addr_wrap,
//rsp_addr_wrap} = rsp_addr_inc - {1'b0, data_bank, 8'b0};
        rsp_addr_wrap} = rsp_addr_inc - {data_bank, 9'b0};
//assign is_rsp_addr_wrap = rsp_addr_inc[12 : 8 ] >= {1'b0, data_bank};
assign is_rsp_addr_wrap = {1'b0,rsp_addr_inc[12 : 9 ]} >= data_bank;
assign rsp_addr = ~is_rsp_addr_wrap ? rsp_addr_inc[12 -1:0] :
                  rsp_addr_wrap;
assign rsp_hsel = rsp_sub_cube_cnt[0];
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"rsp_en\" -q rsp_en_d1");
//: &eperl::flop("-nodeclare   -rval \"{12{1'b0}}\"  -en \"rsp_en\" -d \"rsp_addr\" -q rsp_addr_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_en\" -d \"rsp_hsel\" -q rsp_hsel_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"rsp_en & is_slice_done\" -q rsp_slice_done_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_en\" -d \"is_last_rsp\" -q rsp_layer_done_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_en_d1 <= 1'b0;
   end else begin
       rsp_en_d1 <= rsp_en;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_addr_d1 <= {12{1'b0}};
   end else begin
       if ((rsp_en) == 1'b1) begin
           rsp_addr_d1 <= rsp_addr;
       // VCS coverage off
       end else if ((rsp_en) == 1'b0) begin
       end else begin
           rsp_addr_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_hsel_d1 <= 1'b0;
   end else begin
       if ((rsp_en) == 1'b1) begin
           rsp_hsel_d1 <= rsp_hsel;
       // VCS coverage off
       end else if ((rsp_en) == 1'b0) begin
       end else begin
           rsp_hsel_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_slice_done_d1 <= 1'b0;
   end else begin
       rsp_slice_done_d1 <= rsp_en & is_slice_done;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_layer_done_d1 <= 1'b0;
   end else begin
       if ((rsp_en) == 1'b1) begin
           rsp_layer_done_d1 <= is_last_rsp;
       // VCS coverage off
       end else if ((rsp_en) == 1'b0) begin
       end else begin
           rsp_layer_done_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// WG response data output //
////////////////////////////////////////////////////////////////////////
assign rsp_data_l0 = {rsp_data_l0c1, rsp_data_l0c0};
assign rsp_data_l1 = {rsp_data_l1c1, rsp_data_l1c0};
assign dat_cur = rsp_sub_cube_cnt[1] ? rsp_data_l1 : rsp_data_l0;
assign dat_cur_remapped = dat_cur;
assign rsp_data_d1_w = rsp_sub_cube_cnt[0] ? dat_cur_remapped[1023:512] :
                       dat_cur_remapped[511:0];
//: &eperl::flop("-nodeclare  -norst -en \"rsp_en\" -d \"rsp_data_d1_w\" -q rsp_data_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk) begin
       if ((rsp_en) == 1'b1) begin
           rsp_data_d1 <= rsp_data_d1_w;
       // VCS coverage off
       end else if ((rsp_en) == 1'b0) begin
       end else begin
           rsp_data_d1 <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// WG to CDMA convertor //
////////////////////////////////////////////////////////////////////////
assign wg2cvt_dat_wr_en = rsp_en_d1;
assign wg2cvt_dat_wr_addr = rsp_addr_d1;
assign wg2cvt_dat_wr_sel = rsp_hsel_d1;
assign wg2cvt_dat_wr_data = rsp_data_d1;
assign cbuf_wr_info_mask = 4'h3;
assign cbuf_wr_info_interleave = 1'b0;
assign cbuf_wr_info_ext64 = 1'b0;
assign cbuf_wr_info_ext128 = 1'b0;
assign cbuf_wr_info_mean = 1'b0;
assign cbuf_wr_info_uint = 1'b0;
assign cbuf_wr_info_sub_h = 3'b0;
assign wg2cvt_dat_wr_info_pd[3:0] = cbuf_wr_info_mask[3:0];
assign wg2cvt_dat_wr_info_pd[4] = cbuf_wr_info_interleave ;
assign wg2cvt_dat_wr_info_pd[5] = cbuf_wr_info_ext64 ;
assign wg2cvt_dat_wr_info_pd[6] = cbuf_wr_info_ext128 ;
assign wg2cvt_dat_wr_info_pd[7] = cbuf_wr_info_mean ;
assign wg2cvt_dat_wr_info_pd[8] = cbuf_wr_info_uint ;
assign wg2cvt_dat_wr_info_pd[11:9] = cbuf_wr_info_sub_h[2:0];
////////////////////////////////////////////////////////////////////////
// WG response done signal //
////////////////////////////////////////////////////////////////////////
assign is_rsp_done_w = layer_st ? 1'b0 :
                       (rsp_en_d1 & rsp_layer_done_d1) ? 1'b1 :
                       is_rsp_done;
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"is_rsp_done_w\" -q is_rsp_done");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_rsp_done <= 1'b1;
   end else begin
       is_rsp_done <= is_rsp_done_w;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// WG to status update //
////////////////////////////////////////////////////////////////////////
assign wg2status_dat_updt = rsp_slice_done_d1;
assign wg2status_dat_entries = data_entries;
assign wg2status_dat_slices = 14'h4;
////////////////////////////////////////////////////////////////////////
// performance counting register //
////////////////////////////////////////////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wg_rd_stall_inc <= 1'b0;
    end else begin
        wg_rd_stall_inc <= dma_rd_req_vld & ~dma_rd_req_rdy & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wg_rd_stall_clr <= 1'b0;
    end else begin
        wg_rd_stall_clr <= status2dma_fsm_switch & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wg_rd_stall_cen <= 1'b0;
    end else begin
        wg_rd_stall_cen <= reg2dp_op_en & reg2dp_dma_en;
    end
end
assign dp2reg_wg_rd_stall_dec = 1'b0;
// stl adv logic
always @(*) begin
    stl_adv = wg_rd_stall_inc ^ dp2reg_wg_rd_stall_dec;
end
// stl cnt logic
always @(*) begin
// VCS sop_coverage_off start
    stl_cnt_ext[33:0] = {1'b0, 1'b0, stl_cnt_cur};
    stl_cnt_inc[33:0] = stl_cnt_cur + 1'b1; // spyglass disable W164b
    stl_cnt_dec[33:0] = stl_cnt_cur - 1'b1; // spyglass disable W164b
    stl_cnt_mod[33:0] = (wg_rd_stall_inc && !dp2reg_wg_rd_stall_dec)? stl_cnt_inc : (!wg_rd_stall_inc && dp2reg_wg_rd_stall_dec)? stl_cnt_dec : stl_cnt_ext;
    stl_cnt_new[33:0] = (stl_adv)? stl_cnt_mod[33:0] : stl_cnt_ext[33:0];
    stl_cnt_nxt[33:0] = (wg_rd_stall_clr)? 34'd0 : stl_cnt_new[33:0];
// VCS sop_coverage_off end
end
// stl flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        stl_cnt_cur[31:0] <= 0;
    end else begin
        if (wg_rd_stall_cen) begin
            stl_cnt_cur[31:0] <= stl_cnt_nxt[31:0];
        end
    end
end
// stl output logic
always @(*) begin
    dp2reg_wg_rd_stall[31:0] = stl_cnt_cur[31:0];
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wg_rd_latency_inc <= 1'b0;
    end else begin
        wg_rd_latency_inc <= dma_rd_req_vld & dma_rd_req_rdy & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wg_rd_latency_dec <= 1'b0;
    end else begin
        wg_rd_latency_dec <= dma_rsp_fifo_ready & ~dma_rsp_dummy & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wg_rd_latency_clr <= 1'b0;
    end else begin
        wg_rd_latency_clr <= status2dma_fsm_switch;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        wg_rd_latency_cen <= 1'b0;
    end else begin
        wg_rd_latency_cen <= reg2dp_op_en & reg2dp_dma_en;
    end
end
assign ltc_1_inc = (outs_dp2reg_wg_rd_latency!=511) & wg_rd_latency_inc;
assign ltc_1_dec = (outs_dp2reg_wg_rd_latency!=511) & wg_rd_latency_dec;
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
    ltc_1_cnt_nxt[10:0] = (wg_rd_latency_clr)? 11'd0 : ltc_1_cnt_new[10:0];
// VCS sop_coverage_off end
end
// ltc_1 flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      ltc_1_cnt_cur[8:0] <= 0;
    end else begin
        if (wg_rd_latency_cen) begin
            ltc_1_cnt_cur[8:0] <= ltc_1_cnt_nxt[8:0];
        end
    end
end
// ltc_1 output logic
always @(*) begin
    outs_dp2reg_wg_rd_latency[8:0] = ltc_1_cnt_cur[8:0];
end
assign ltc_2_dec = 1'b0;
assign ltc_2_inc = (~&dp2reg_wg_rd_latency) & (|outs_dp2reg_wg_rd_latency);
// ltc_2 adv logic
always @(*) begin
    ltc_2_adv = ltc_2_inc ^ ltc_2_dec;
end
// ltc_2 cnt logic
always @(*) begin
// VCS sop_coverage_off start
    ltc_2_cnt_ext[33:0] = {1'b0, 1'b0, ltc_2_cnt_cur};
    ltc_2_cnt_inc[33:0] = ltc_2_cnt_cur + 1'b1; // spyglass disable W164b
    ltc_2_cnt_dec[33:0] = ltc_2_cnt_cur - 1'b1; // spyglass disable W164b
    ltc_2_cnt_mod[33:0] = (ltc_2_inc && !ltc_2_dec)? ltc_2_cnt_inc : (!ltc_2_inc && ltc_2_dec)? ltc_2_cnt_dec : ltc_2_cnt_ext;
    ltc_2_cnt_new[33:0] = (ltc_2_adv)? ltc_2_cnt_mod[33:0] : ltc_2_cnt_ext[33:0];
    ltc_2_cnt_nxt[33:0] = (wg_rd_latency_clr)? 34'd0 : ltc_2_cnt_new[33:0];
// VCS sop_coverage_off end
end
// ltc_2 flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        ltc_2_cnt_cur[31:0] <= 0;
    end else begin
        if (wg_rd_latency_cen) begin
            ltc_2_cnt_cur[31:0] <= ltc_2_cnt_nxt[31:0];
        end
    end
end
// ltc_2 output logic
always @(*) begin
    dp2reg_wg_rd_latency[31:0] = ltc_2_cnt_cur[31:0];
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
    property cdma_wg__rsp_addr_wrap__0_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        (rsp_en & is_rsp_addr_wrap);
    endproperty
// Cover 0 : "(rsp_en & is_rsp_addr_wrap)"
    FUNCPOINT_cdma_wg__rsp_addr_wrap__0_COV : cover property (cdma_wg__rsp_addr_wrap__0_cov);
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    property cdma_wg__wg_conv_stride_EQ_0__1_0_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 0));
    endproperty
// Cover 1_0 : "(reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 0)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_0__1_0_COV : cover property (cdma_wg__wg_conv_stride_EQ_0__1_0_cov);
    property cdma_wg__wg_conv_stride_EQ_1__1_1_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 1));
    endproperty
// Cover 1_1 : "(reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 1)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_1__1_1_COV : cover property (cdma_wg__wg_conv_stride_EQ_1__1_1_cov);
    property cdma_wg__wg_conv_stride_EQ_2__1_2_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 2));
    endproperty
// Cover 1_2 : "(reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 2)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_2__1_2_COV : cover property (cdma_wg__wg_conv_stride_EQ_2__1_2_cov);
    property cdma_wg__wg_conv_stride_EQ_3__1_3_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 3));
    endproperty
// Cover 1_3 : "(reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 3)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_3__1_3_COV : cover property (cdma_wg__wg_conv_stride_EQ_3__1_3_cov);
    property cdma_wg__wg_conv_stride_EQ_4__1_4_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 4));
    endproperty
// Cover 1_4 : "(reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 4)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_4__1_4_COV : cover property (cdma_wg__wg_conv_stride_EQ_4__1_4_cov);
    property cdma_wg__wg_conv_stride_EQ_5__1_5_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 5));
    endproperty
// Cover 1_5 : "(reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 5)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_5__1_5_COV : cover property (cdma_wg__wg_conv_stride_EQ_5__1_5_cov);
    property cdma_wg__wg_conv_stride_EQ_6__1_6_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 6));
    endproperty
// Cover 1_6 : "(reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 6)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_6__1_6_COV : cover property (cdma_wg__wg_conv_stride_EQ_6__1_6_cov);
    property cdma_wg__wg_conv_stride_EQ_7__1_7_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 7));
    endproperty
// Cover 1_7 : "(reg2dp_conv_x_stride == 0) && (reg2dp_conv_y_stride == 7)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_7__1_7_COV : cover property (cdma_wg__wg_conv_stride_EQ_7__1_7_cov);
    property cdma_wg__wg_conv_stride_EQ_8__1_8_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 0));
    endproperty
// Cover 1_8 : "(reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 0)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_8__1_8_COV : cover property (cdma_wg__wg_conv_stride_EQ_8__1_8_cov);
    property cdma_wg__wg_conv_stride_EQ_9__1_9_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 1));
    endproperty
// Cover 1_9 : "(reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 1)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_9__1_9_COV : cover property (cdma_wg__wg_conv_stride_EQ_9__1_9_cov);
    property cdma_wg__wg_conv_stride_EQ_10__1_10_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 2));
    endproperty
// Cover 1_10 : "(reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 2)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_10__1_10_COV : cover property (cdma_wg__wg_conv_stride_EQ_10__1_10_cov);
    property cdma_wg__wg_conv_stride_EQ_11__1_11_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 3));
    endproperty
// Cover 1_11 : "(reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 3)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_11__1_11_COV : cover property (cdma_wg__wg_conv_stride_EQ_11__1_11_cov);
    property cdma_wg__wg_conv_stride_EQ_12__1_12_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 4));
    endproperty
// Cover 1_12 : "(reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 4)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_12__1_12_COV : cover property (cdma_wg__wg_conv_stride_EQ_12__1_12_cov);
    property cdma_wg__wg_conv_stride_EQ_13__1_13_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 5));
    endproperty
// Cover 1_13 : "(reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 5)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_13__1_13_COV : cover property (cdma_wg__wg_conv_stride_EQ_13__1_13_cov);
    property cdma_wg__wg_conv_stride_EQ_14__1_14_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 6));
    endproperty
// Cover 1_14 : "(reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 6)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_14__1_14_COV : cover property (cdma_wg__wg_conv_stride_EQ_14__1_14_cov);
    property cdma_wg__wg_conv_stride_EQ_15__1_15_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 7));
    endproperty
// Cover 1_15 : "(reg2dp_conv_x_stride == 1) && (reg2dp_conv_y_stride == 7)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_15__1_15_COV : cover property (cdma_wg__wg_conv_stride_EQ_15__1_15_cov);
    property cdma_wg__wg_conv_stride_EQ_16__1_16_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 0));
    endproperty
// Cover 1_16 : "(reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 0)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_16__1_16_COV : cover property (cdma_wg__wg_conv_stride_EQ_16__1_16_cov);
    property cdma_wg__wg_conv_stride_EQ_17__1_17_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 1));
    endproperty
// Cover 1_17 : "(reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 1)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_17__1_17_COV : cover property (cdma_wg__wg_conv_stride_EQ_17__1_17_cov);
    property cdma_wg__wg_conv_stride_EQ_18__1_18_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 2));
    endproperty
// Cover 1_18 : "(reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 2)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_18__1_18_COV : cover property (cdma_wg__wg_conv_stride_EQ_18__1_18_cov);
    property cdma_wg__wg_conv_stride_EQ_19__1_19_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 3));
    endproperty
// Cover 1_19 : "(reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 3)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_19__1_19_COV : cover property (cdma_wg__wg_conv_stride_EQ_19__1_19_cov);
    property cdma_wg__wg_conv_stride_EQ_20__1_20_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 4));
    endproperty
// Cover 1_20 : "(reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 4)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_20__1_20_COV : cover property (cdma_wg__wg_conv_stride_EQ_20__1_20_cov);
    property cdma_wg__wg_conv_stride_EQ_21__1_21_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 5));
    endproperty
// Cover 1_21 : "(reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 5)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_21__1_21_COV : cover property (cdma_wg__wg_conv_stride_EQ_21__1_21_cov);
    property cdma_wg__wg_conv_stride_EQ_22__1_22_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 6));
    endproperty
// Cover 1_22 : "(reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 6)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_22__1_22_COV : cover property (cdma_wg__wg_conv_stride_EQ_22__1_22_cov);
    property cdma_wg__wg_conv_stride_EQ_23__1_23_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 7));
    endproperty
// Cover 1_23 : "(reg2dp_conv_x_stride == 2) && (reg2dp_conv_y_stride == 7)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_23__1_23_COV : cover property (cdma_wg__wg_conv_stride_EQ_23__1_23_cov);
    property cdma_wg__wg_conv_stride_EQ_24__1_24_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 0));
    endproperty
// Cover 1_24 : "(reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 0)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_24__1_24_COV : cover property (cdma_wg__wg_conv_stride_EQ_24__1_24_cov);
    property cdma_wg__wg_conv_stride_EQ_25__1_25_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 1));
    endproperty
// Cover 1_25 : "(reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 1)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_25__1_25_COV : cover property (cdma_wg__wg_conv_stride_EQ_25__1_25_cov);
    property cdma_wg__wg_conv_stride_EQ_26__1_26_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 2));
    endproperty
// Cover 1_26 : "(reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 2)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_26__1_26_COV : cover property (cdma_wg__wg_conv_stride_EQ_26__1_26_cov);
    property cdma_wg__wg_conv_stride_EQ_27__1_27_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 3));
    endproperty
// Cover 1_27 : "(reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 3)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_27__1_27_COV : cover property (cdma_wg__wg_conv_stride_EQ_27__1_27_cov);
    property cdma_wg__wg_conv_stride_EQ_28__1_28_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 4));
    endproperty
// Cover 1_28 : "(reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 4)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_28__1_28_COV : cover property (cdma_wg__wg_conv_stride_EQ_28__1_28_cov);
    property cdma_wg__wg_conv_stride_EQ_29__1_29_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 5));
    endproperty
// Cover 1_29 : "(reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 5)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_29__1_29_COV : cover property (cdma_wg__wg_conv_stride_EQ_29__1_29_cov);
    property cdma_wg__wg_conv_stride_EQ_30__1_30_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 6));
    endproperty
// Cover 1_30 : "(reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 6)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_30__1_30_COV : cover property (cdma_wg__wg_conv_stride_EQ_30__1_30_cov);
    property cdma_wg__wg_conv_stride_EQ_31__1_31_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 7));
    endproperty
// Cover 1_31 : "(reg2dp_conv_x_stride == 3) && (reg2dp_conv_y_stride == 7)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_31__1_31_COV : cover property (cdma_wg__wg_conv_stride_EQ_31__1_31_cov);
    property cdma_wg__wg_conv_stride_EQ_32__1_32_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 0));
    endproperty
// Cover 1_32 : "(reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 0)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_32__1_32_COV : cover property (cdma_wg__wg_conv_stride_EQ_32__1_32_cov);
    property cdma_wg__wg_conv_stride_EQ_33__1_33_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 1));
    endproperty
// Cover 1_33 : "(reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 1)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_33__1_33_COV : cover property (cdma_wg__wg_conv_stride_EQ_33__1_33_cov);
    property cdma_wg__wg_conv_stride_EQ_34__1_34_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 2));
    endproperty
// Cover 1_34 : "(reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 2)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_34__1_34_COV : cover property (cdma_wg__wg_conv_stride_EQ_34__1_34_cov);
    property cdma_wg__wg_conv_stride_EQ_35__1_35_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 3));
    endproperty
// Cover 1_35 : "(reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 3)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_35__1_35_COV : cover property (cdma_wg__wg_conv_stride_EQ_35__1_35_cov);
    property cdma_wg__wg_conv_stride_EQ_36__1_36_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 4));
    endproperty
// Cover 1_36 : "(reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 4)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_36__1_36_COV : cover property (cdma_wg__wg_conv_stride_EQ_36__1_36_cov);
    property cdma_wg__wg_conv_stride_EQ_37__1_37_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 5));
    endproperty
// Cover 1_37 : "(reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 5)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_37__1_37_COV : cover property (cdma_wg__wg_conv_stride_EQ_37__1_37_cov);
    property cdma_wg__wg_conv_stride_EQ_38__1_38_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 6));
    endproperty
// Cover 1_38 : "(reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 6)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_38__1_38_COV : cover property (cdma_wg__wg_conv_stride_EQ_38__1_38_cov);
    property cdma_wg__wg_conv_stride_EQ_39__1_39_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 7));
    endproperty
// Cover 1_39 : "(reg2dp_conv_x_stride == 4) && (reg2dp_conv_y_stride == 7)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_39__1_39_COV : cover property (cdma_wg__wg_conv_stride_EQ_39__1_39_cov);
    property cdma_wg__wg_conv_stride_EQ_40__1_40_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 0));
    endproperty
// Cover 1_40 : "(reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 0)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_40__1_40_COV : cover property (cdma_wg__wg_conv_stride_EQ_40__1_40_cov);
    property cdma_wg__wg_conv_stride_EQ_41__1_41_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 1));
    endproperty
// Cover 1_41 : "(reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 1)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_41__1_41_COV : cover property (cdma_wg__wg_conv_stride_EQ_41__1_41_cov);
    property cdma_wg__wg_conv_stride_EQ_42__1_42_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 2));
    endproperty
// Cover 1_42 : "(reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 2)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_42__1_42_COV : cover property (cdma_wg__wg_conv_stride_EQ_42__1_42_cov);
    property cdma_wg__wg_conv_stride_EQ_43__1_43_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 3));
    endproperty
// Cover 1_43 : "(reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 3)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_43__1_43_COV : cover property (cdma_wg__wg_conv_stride_EQ_43__1_43_cov);
    property cdma_wg__wg_conv_stride_EQ_44__1_44_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 4));
    endproperty
// Cover 1_44 : "(reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 4)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_44__1_44_COV : cover property (cdma_wg__wg_conv_stride_EQ_44__1_44_cov);
    property cdma_wg__wg_conv_stride_EQ_45__1_45_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 5));
    endproperty
// Cover 1_45 : "(reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 5)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_45__1_45_COV : cover property (cdma_wg__wg_conv_stride_EQ_45__1_45_cov);
    property cdma_wg__wg_conv_stride_EQ_46__1_46_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 6));
    endproperty
// Cover 1_46 : "(reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 6)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_46__1_46_COV : cover property (cdma_wg__wg_conv_stride_EQ_46__1_46_cov);
    property cdma_wg__wg_conv_stride_EQ_47__1_47_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 7));
    endproperty
// Cover 1_47 : "(reg2dp_conv_x_stride == 5) && (reg2dp_conv_y_stride == 7)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_47__1_47_COV : cover property (cdma_wg__wg_conv_stride_EQ_47__1_47_cov);
    property cdma_wg__wg_conv_stride_EQ_48__1_48_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 0));
    endproperty
// Cover 1_48 : "(reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 0)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_48__1_48_COV : cover property (cdma_wg__wg_conv_stride_EQ_48__1_48_cov);
    property cdma_wg__wg_conv_stride_EQ_49__1_49_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 1));
    endproperty
// Cover 1_49 : "(reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 1)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_49__1_49_COV : cover property (cdma_wg__wg_conv_stride_EQ_49__1_49_cov);
    property cdma_wg__wg_conv_stride_EQ_50__1_50_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 2));
    endproperty
// Cover 1_50 : "(reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 2)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_50__1_50_COV : cover property (cdma_wg__wg_conv_stride_EQ_50__1_50_cov);
    property cdma_wg__wg_conv_stride_EQ_51__1_51_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 3));
    endproperty
// Cover 1_51 : "(reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 3)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_51__1_51_COV : cover property (cdma_wg__wg_conv_stride_EQ_51__1_51_cov);
    property cdma_wg__wg_conv_stride_EQ_52__1_52_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 4));
    endproperty
// Cover 1_52 : "(reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 4)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_52__1_52_COV : cover property (cdma_wg__wg_conv_stride_EQ_52__1_52_cov);
    property cdma_wg__wg_conv_stride_EQ_53__1_53_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 5));
    endproperty
// Cover 1_53 : "(reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 5)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_53__1_53_COV : cover property (cdma_wg__wg_conv_stride_EQ_53__1_53_cov);
    property cdma_wg__wg_conv_stride_EQ_54__1_54_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 6));
    endproperty
// Cover 1_54 : "(reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 6)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_54__1_54_COV : cover property (cdma_wg__wg_conv_stride_EQ_54__1_54_cov);
    property cdma_wg__wg_conv_stride_EQ_55__1_55_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 7));
    endproperty
// Cover 1_55 : "(reg2dp_conv_x_stride == 6) && (reg2dp_conv_y_stride == 7)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_55__1_55_COV : cover property (cdma_wg__wg_conv_stride_EQ_55__1_55_cov);
    property cdma_wg__wg_conv_stride_EQ_56__1_56_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 0));
    endproperty
// Cover 1_56 : "(reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 0)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_56__1_56_COV : cover property (cdma_wg__wg_conv_stride_EQ_56__1_56_cov);
    property cdma_wg__wg_conv_stride_EQ_57__1_57_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 1));
    endproperty
// Cover 1_57 : "(reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 1)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_57__1_57_COV : cover property (cdma_wg__wg_conv_stride_EQ_57__1_57_cov);
    property cdma_wg__wg_conv_stride_EQ_58__1_58_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 2));
    endproperty
// Cover 1_58 : "(reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 2)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_58__1_58_COV : cover property (cdma_wg__wg_conv_stride_EQ_58__1_58_cov);
    property cdma_wg__wg_conv_stride_EQ_59__1_59_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 3));
    endproperty
// Cover 1_59 : "(reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 3)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_59__1_59_COV : cover property (cdma_wg__wg_conv_stride_EQ_59__1_59_cov);
    property cdma_wg__wg_conv_stride_EQ_60__1_60_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 4));
    endproperty
// Cover 1_60 : "(reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 4)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_60__1_60_COV : cover property (cdma_wg__wg_conv_stride_EQ_60__1_60_cov);
    property cdma_wg__wg_conv_stride_EQ_61__1_61_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 5));
    endproperty
// Cover 1_61 : "(reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 5)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_61__1_61_COV : cover property (cdma_wg__wg_conv_stride_EQ_61__1_61_cov);
    property cdma_wg__wg_conv_stride_EQ_62__1_62_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 6));
    endproperty
// Cover 1_62 : "(reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 6)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_62__1_62_COV : cover property (cdma_wg__wg_conv_stride_EQ_62__1_62_cov);
    property cdma_wg__wg_conv_stride_EQ_63__1_63_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((layer_st) && nvdla_core_rstn) |-> ((reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 7));
    endproperty
// Cover 1_63 : "(reg2dp_conv_x_stride == 7) && (reg2dp_conv_y_stride == 7)"
    FUNCPOINT_cdma_wg__wg_conv_stride_EQ_63__1_63_COV : cover property (cdma_wg__wg_conv_stride_EQ_63__1_63_cov);
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    property cdma_wg__wg_reuse__2_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((cur_state == WG_STATE_IDLE) & (nxt_state == WG_STATE_DONE));
    endproperty
// Cover 2 : "((cur_state == WG_STATE_IDLE) & (nxt_state == WG_STATE_DONE))"
    FUNCPOINT_cdma_wg__wg_reuse__2_COV : cover property (cdma_wg__wg_reuse__2_cov);
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_2x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_rsp_done | is_done))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_6x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(reg2dp_op_en & is_idle))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_7x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(reg2dp_op_en & is_idle))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_8x (nvdla_core_ng_clk, `ASSERT_RESET, 1'd1, (^(reg2dp_op_en & is_idle))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_9x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_10x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_12x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_13x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_14x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_15x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_16x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_17x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_18x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_19x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_20x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_21x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_22x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_23x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_24x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_25x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_26x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_27x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_28x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_29x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_30x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st_d1))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_31x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st_d1))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_52x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(wg_entry_onfly_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_55x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_h_ext_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_56x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_surf_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_57x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_y_std_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_58x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_w_set_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_60x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_sub_w_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_61x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_sub_h_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_62x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_h_ext_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_64x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_sub_h_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_65x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_y_std_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_66x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_surf_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_67x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_adv))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_68x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_adv))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_69x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_adv))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_70x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_valid_d1 & req_ready_d1))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_71x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_valid_d1 & req_ready_d1))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_72x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_valid_d1 & req_ready_d1))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_75x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(dma_rsp_vld))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_80x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | dma_rsp_fifo_ready))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_81x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_82x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_83x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_84x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_85x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_86x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_87x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_ori_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_88x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_ori_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_89x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_ori_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_90x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_ori_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_91x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_ori_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_92x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_addr_ori_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_97x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_p0_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_98x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_p1_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_99x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_p0_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_100x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_wr_p1_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_101x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_cube_inc_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_104x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | sbuf_avl_cube_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_105x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | sbuf_avl_cube_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_106x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | sbuf_avl_cube_sub))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_107x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st | sbuf_rd_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_108x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_rd_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_109x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_rd_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_110x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(sbuf_rd_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_113x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_vld_d0))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_114x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_vld_d1))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_115x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_sub_cube_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_116x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_x_std_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_117x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_width_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_118x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_y_std_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_119x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_surf_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_120x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_h_ext_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_121x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_first_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_122x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_h_ext_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_124x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_ch_offset_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_125x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_ch_x_std_base_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_126x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_ch_w_base_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_127x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_ch_y_std_base_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_128x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_ch_surf_base_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_131x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_132x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_133x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! fifo is not empty when done!") zzz_assert_never_3x (nvdla_core_clk, `ASSERT_RESET, (is_rsp_done & dma_rsp_fifo_req)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! Req is not done when rsp is done!") zzz_assert_never_4x (nvdla_core_clk, `ASSERT_RESET, (is_running & is_rsp_done & ~is_req_done)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! entry_onfly is non zero when idle") zzz_assert_never_5x (nvdla_core_clk, `ASSERT_RESET, (fetch_done & |(wg_entry_onfly))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error Config! None feature input when wg!") zzz_assert_never_32x (nvdla_core_clk, `ASSERT_RESET, (layer_st & is_wg & ~is_feature)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! data_entries_w is overflow!") zzz_assert_never_33x (nvdla_core_clk, `ASSERT_RESET, (layer_st & mon_data_entries_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! width is not divisible by conv_x_stride") zzz_assert_never_34x (nvdla_core_clk, `ASSERT_RESET, (layer_st & ((reg2dp_pad_left + reg2dp_datain_width + reg2dp_pad_right + 1) % conv_x_stride_w != 0))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! height is not divisible by conv_y_stride") zzz_assert_never_35x (nvdla_core_clk, `ASSERT_RESET, (layer_st & ((reg2dp_pad_top + reg2dp_datain_height + reg2dp_pad_bottom + 1) % conv_y_stride_w != 0))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! channel is not divisible by 16/32") zzz_assert_never_36x (nvdla_core_clk, `ASSERT_RESET, (layer_st & ((is_int8 & (reg2dp_datain_channel[4:0] != 5'h1f)) | (~is_int8 & (reg2dp_datain_channel[3:0] != 4'hf))))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! width_ext is not divisible by 4") zzz_assert_never_37x (nvdla_core_clk, `ASSERT_RESET, (layer_st & (reg2dp_datain_width_ext[1:0] != 2'b11))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! height_ext is not divisible by 4") zzz_assert_never_38x (nvdla_core_clk, `ASSERT_RESET, (layer_st & (reg2dp_datain_height_ext[1:0] != 2'b11))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! width and width_ext not match") zzz_assert_never_39x (nvdla_core_clk, `ASSERT_RESET, (layer_st & (((reg2dp_pad_left + reg2dp_datain_width + reg2dp_pad_right + 1) / conv_x_stride_w) != (reg2dp_datain_width_ext + 1)))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! height and height_ext not match") zzz_assert_never_40x (nvdla_core_clk, `ASSERT_RESET, (layer_st & (((reg2dp_pad_top + reg2dp_datain_height + reg2dp_pad_bottom + 1) / conv_y_stride_w) != (reg2dp_datain_height_ext + 1)))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! reg2dp_entries is out of range in winograd mode!") zzz_assert_never_41x (nvdla_core_clk, `ASSERT_RESET, (layer_st & is_wg & (|reg2dp_entries[11:10]))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! w_ext_surf_w is overflow!") zzz_assert_never_46x (nvdla_core_clk, `ASSERT_RESET, (layer_st_d1 & (|mon_w_ext_surf_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! h_ext_surf_w is overflow!") zzz_assert_never_47x (nvdla_core_clk, `ASSERT_RESET, (layer_st_d1 & (|mon_h_ext_surf_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! w_ext_surf_w is out of range when normal!") zzz_assert_never_49x (nvdla_core_clk, `ASSERT_RESET, (layer_st_d1 & w_ext_surf_w[12 -2])); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! h_ext_surf_w is out of range when normal!") zzz_assert_never_51x (nvdla_core_clk, `ASSERT_RESET, (layer_st_d1 & h_ext_surf_w[12 -2])); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wg_entry_onfly_w is overflow!") zzz_assert_never_53x (nvdla_core_clk, `ASSERT_RESET, (wg_entry_onfly_en & mon_wg_entry_onfly_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! wg_entry_onfly is not zero when idle!") zzz_assert_never_54x (nvdla_core_clk, `ASSERT_RESET, (~is_running & (|wg_entry_onfly))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_one_hot #(0,3,0,"Error! width section select error!") zzz_assert_one_hot_59x (nvdla_core_clk, `ASSERT_RESET, ({is_w_set_lp, is_w_set_di, is_w_set_rp})); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_cbuf_needed is overflow!") zzz_assert_never_63x (nvdla_core_clk, `ASSERT_RESET, (mon_req_cubf_needed)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! Receive input data when not busy") zzz_assert_never_74x (nvdla_core_clk, `ASSERT_RESET, (dma_rd_rsp_vld & ~is_running)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"response fifo pop error") zzz_assert_never_76x (nvdla_core_clk, `ASSERT_RESET, (~dma_rsp_fifo_req & dma_rd_rsp_vld)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"response size mismatch") zzz_assert_never_77x (nvdla_core_clk, `ASSERT_RESET, (dma_rsp_size_cnt_inc > dma_rsp_size)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! dma_rsp_size_cnt_inc is overflow") zzz_assert_never_78x (nvdla_core_clk, `ASSERT_RESET, (mon_dma_rsp_size_cnt_inc)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! dma_rsp_size_cnt_inc is out of range") zzz_assert_never_79x (nvdla_core_clk, `ASSERT_RESET, (dma_rsp_size_cnt_inc > 8'h8)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! p0 overflow conflict!") zzz_assert_never_93x (nvdla_core_clk, `ASSERT_RESET, (sbuf_wr_addr_en & ~is_x_stride_one & sbuf_wr_p0_of_0 & sbuf_wr_p1_of_0 & (~is_idle))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! p1 overflow conflict!") zzz_assert_never_94x (nvdla_core_clk, `ASSERT_RESET, (sbuf_wr_addr_en & ~is_x_stride_one & sbuf_wr_p0_of_1 & sbuf_wr_p1_of_1 & (~is_idle))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! sbuf_wr_p0_ch_inc is overflow!") zzz_assert_never_95x (nvdla_core_clk, `ASSERT_RESET, (sbuf_wr_addr_en & mon_sbuf_wr_p0_ch_inc)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! sbuf_wr_p0_ch_inc is out of range!") zzz_assert_never_96x (nvdla_core_clk, `ASSERT_RESET, (sbuf_wr_addr_en & (sbuf_wr_p0_ch_inc[3:2] > 2'h2))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! sbuf x_stride increase size out of range!") zzz_assert_never_102x (nvdla_core_clk, `ASSERT_RESET, (sbuf_cube_inc_en & sbuf_x_stride_inc_size[1] & (|reg2dp_conv_x_stride))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! sbuf cube increase size out of range!") zzz_assert_never_103x (nvdla_core_clk, `ASSERT_RESET, (sbuf_cube_inc_en & (sbuf_cube_inc_size > 4'h8))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rd_sub_cnt is not zero when idle!") zzz_assert_never_111x (nvdla_core_clk, `ASSERT_RESET, (~is_running & (|rd_sub_cnt))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! sbuf_avl_cube_w is overflow!") zzz_assert_never_112x (nvdla_core_clk, `ASSERT_RESET, (sbuf_avl_cube_en & mon_sbuf_avl_cube_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_addr_offset is overflow!") zzz_assert_never_123x (nvdla_core_clk, `ASSERT_RESET, (mon_rsp_addr_offset_w & rsp_h_ext_en)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_ch_offset_w is overflow!") zzz_assert_never_129x (nvdla_core_clk, `ASSERT_RESET, (rsp_ch_offset_en & mon_rsp_ch_offset_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_ch_offset_w is out of range!") zzz_assert_never_130x (nvdla_core_clk, `ASSERT_RESET, (rsp_ch_offset_en & (rsp_ch_offset_w > 12'd3840))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_addr_inc is overflow!") zzz_assert_never_134x (nvdla_core_clk, `ASSERT_RESET, (rsp_en & mon_rsp_addr_inc)); // spyglass disable W504 SelfDeterminedExpr-ML 
      nv_assert_never #(0,0,"never: counter overflow beyond <ovr_cnt>") zzz_assert_never_135x (nvdla_core_clk, `ASSERT_RESET, (ltc_1_cnt_nxt > 511 && wg_rd_latency_cen)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDMA_wg
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is mc_int_rd_req_pd (mc_int_rd_req_valid,mc_int_rd_req_ready) <= dma_rd_req_pd[78:0] (mc_dma_rd_req_vld,mc_dma_rd_req_rdy)
// **************************************************************************************************************
module NV_NVDLA_CDMA_WG_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dma_rd_req_pd
  ,mc_dma_rd_req_vld
  ,mc_int_rd_req_ready
  ,mc_dma_rd_req_rdy
  ,mc_int_rd_req_pd
  ,mc_int_rd_req_valid
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [78:0] dma_rd_req_pd;
input mc_dma_rd_req_vld;
input mc_int_rd_req_ready;
output mc_dma_rd_req_rdy;
output [78:0] mc_int_rd_req_pd;
output mc_int_rd_req_valid;
reg mc_dma_rd_req_rdy;
reg [78:0] mc_int_rd_req_pd;
reg mc_int_rd_req_valid;
reg [78:0] p1_pipe_data;
reg [78:0] p1_pipe_rand_data;
reg p1_pipe_rand_ready;
reg p1_pipe_rand_valid;
reg p1_pipe_ready;
reg p1_pipe_ready_bc;
reg p1_pipe_valid;
reg p1_skid_catch;
reg [78:0] p1_skid_data;
reg [78:0] p1_skid_pipe_data;
reg p1_skid_pipe_ready;
reg p1_skid_pipe_valid;
reg p1_skid_ready;
reg p1_skid_ready_flop;
reg p1_skid_valid;
//## pipe (1) randomizer
`ifndef SYNTHESIS
reg p1_pipe_rand_active;
`endif
always @(
  `ifndef SYNTHESIS
  p1_pipe_rand_active
  or
     `endif
     mc_dma_rd_req_vld
  or p1_pipe_rand_ready
  or dma_rd_req_pd
  ) begin
  `ifdef SYNTHESIS
  p1_pipe_rand_valid = mc_dma_rd_req_vld;
  mc_dma_rd_req_rdy = p1_pipe_rand_ready;
  p1_pipe_rand_data = dma_rd_req_pd[78:0];
  `else
// VCS coverage off
  p1_pipe_rand_valid = (p1_pipe_rand_active)? 1'b0 : mc_dma_rd_req_vld;
  mc_dma_rd_req_rdy = (p1_pipe_rand_active)? 1'b0 : p1_pipe_rand_ready;
  p1_pipe_rand_data = (p1_pipe_rand_active)? 'bx : dma_rd_req_pd[78:0];
// VCS coverage on
  `endif
end
`ifndef SYNTHESIS
// VCS coverage off
//// randomization init   
integer p1_pipe_stall_cycles;
integer p1_pipe_stall_probability;
integer p1_pipe_stall_cycles_min;
integer p1_pipe_stall_cycles_max;
initial begin
  p1_pipe_stall_cycles = 0;
  p1_pipe_stall_probability = 0;
  p1_pipe_stall_cycles_min = 1;
  p1_pipe_stall_cycles_max = 10;
`ifndef SYNTH_LEVEL1_COMPILE
  if ( $value$plusargs( "NV_NVDLA_CDMA_wg_pipe_rand_probability=%d", p1_pipe_stall_probability ) ) ; // deprecated
  else if ( $value$plusargs( "default_pipe_rand_probability=%d", p1_pipe_stall_probability ) ) ; // deprecated
  if ( $value$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_probability=%d", p1_pipe_stall_probability ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_probability=%d", p1_pipe_stall_probability ) ) ;
  if ( $value$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_cycles_min=%d", p1_pipe_stall_cycles_min ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_min=%d", p1_pipe_stall_cycles_min ) ) ;
  if ( $value$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_cycles_max=%d", p1_pipe_stall_cycles_max ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_max=%d", p1_pipe_stall_cycles_max ) ) ;
`endif
end
// randomization globals
`ifndef SYNTH_LEVEL1_COMPILE
`ifdef SIMTOP_RANDOMIZE_STALLS
always @( `SIMTOP_RANDOMIZE_STALLS.global_stall_event ) begin
  if ( ! $test$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_probability" ) ) p1_pipe_stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_probability;
  if ( ! $test$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_cycles_min" ) ) p1_pipe_stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_min;
  if ( ! $test$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_cycles_max" ) ) p1_pipe_stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_max;
end
`endif
`endif
//// randomization active
reg p1_pipe_rand_enable;
reg p1_pipe_rand_poised;
always @(
  p1_pipe_stall_cycles
  or p1_pipe_stall_probability
  or mc_dma_rd_req_vld
  ) begin
  p1_pipe_rand_active = p1_pipe_stall_cycles != 0;
  p1_pipe_rand_enable = p1_pipe_stall_probability != 0;
  p1_pipe_rand_poised = p1_pipe_rand_enable && !p1_pipe_rand_active && mc_dma_rd_req_vld === 1'b1;
end
//// randomization cycles
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p1_pipe_stall_cycles <= 1'b0;
  end else begin
  if (p1_pipe_rand_poised) begin
    if (p1_pipe_stall_probability >= prand_inst0(1, 100)) begin
      p1_pipe_stall_cycles <= prand_inst1(p1_pipe_stall_cycles_min, p1_pipe_stall_cycles_max);
    end
  end else if (p1_pipe_rand_active) begin
    p1_pipe_stall_cycles <= p1_pipe_stall_cycles - 1;
  end else begin
    p1_pipe_stall_cycles <= 0;
  end
  end
end
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
`endif
// VCS coverage on
//## pipe (1) skid buffer
always @(
  p1_pipe_rand_valid
  or p1_skid_ready_flop
  or p1_skid_pipe_ready
  or p1_skid_valid
  ) begin
  p1_skid_catch = p1_pipe_rand_valid && p1_skid_ready_flop && !p1_skid_pipe_ready;
  p1_skid_ready = (p1_skid_valid)? p1_skid_pipe_ready : !p1_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p1_skid_valid <= 1'b0;
    p1_skid_ready_flop <= 1'b1;
    p1_pipe_rand_ready <= 1'b1;
  end else begin
  p1_skid_valid <= (p1_skid_valid)? !p1_skid_pipe_ready : p1_skid_catch;
  p1_skid_ready_flop <= p1_skid_ready;
  p1_pipe_rand_ready <= p1_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p1_skid_data <= (p1_skid_catch)? p1_pipe_rand_data : p1_skid_data;
// VCS sop_coverage_off end
end
always @(
  p1_skid_ready_flop
  or p1_pipe_rand_valid
  or p1_skid_valid
  or p1_pipe_rand_data
  or p1_skid_data
  ) begin
  p1_skid_pipe_valid = (p1_skid_ready_flop)? p1_pipe_rand_valid : p1_skid_valid;
// VCS sop_coverage_off start
  p1_skid_pipe_data = (p1_skid_ready_flop)? p1_pipe_rand_data : p1_skid_data;
// VCS sop_coverage_off end
end
//## pipe (1) valid-ready-bubble-collapse
always @(
  p1_pipe_ready
  or p1_pipe_valid
  ) begin
  p1_pipe_ready_bc = p1_pipe_ready || !p1_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p1_pipe_valid <= 1'b0;
  end else begin
  p1_pipe_valid <= (p1_pipe_ready_bc)? p1_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p1_pipe_data <= (p1_pipe_ready_bc && p1_skid_pipe_valid)? p1_skid_pipe_data : p1_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p1_pipe_ready_bc
  ) begin
  p1_skid_pipe_ready = p1_pipe_ready_bc;
end
//## pipe (1) output
always @(
  p1_pipe_valid
  or mc_int_rd_req_ready
  or p1_pipe_data
  ) begin
  mc_int_rd_req_valid = p1_pipe_valid;
  p1_pipe_ready = mc_int_rd_req_ready;
  mc_int_rd_req_pd = p1_pipe_data;
end
//## pipe (1) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p1_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_136x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mc_int_rd_req_valid^mc_int_rd_req_ready^mc_dma_rd_req_vld^mc_dma_rd_req_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
// VCS coverage off
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_137x (nvdla_core_clk, `ASSERT_RESET, (mc_dma_rd_req_vld && !mc_dma_rd_req_rdy), (mc_dma_rd_req_vld), (mc_dma_rd_req_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
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
`endif
endmodule // NV_NVDLA_CDMA_WG_pipe_p1
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is cv_int_rd_req_pd (cv_int_rd_req_valid,cv_int_rd_req_ready) <= dma_rd_req_pd[78:0] (cv_dma_rd_req_vld,cv_dma_rd_req_rdy)
// **************************************************************************************************************
// **************************************************************************************************************
// Generated by ::pipe -m -bc -os mc_dma_rd_rsp_pd (mc_dma_rd_rsp_vld,dma_rd_rsp_rdy) <= mc_int_rd_rsp_pd[513:0] (mc_int_rd_rsp_valid,mc_int_rd_rsp_ready)
// **************************************************************************************************************
module NV_NVDLA_CDMA_WG_pipe_p3 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dma_rd_rsp_rdy
  ,mc_int_rd_rsp_pd
  ,mc_int_rd_rsp_valid
  ,mc_dma_rd_rsp_pd
  ,mc_dma_rd_rsp_vld
  ,mc_int_rd_rsp_ready
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input dma_rd_rsp_rdy;
input [513:0] mc_int_rd_rsp_pd;
input mc_int_rd_rsp_valid;
output [513:0] mc_dma_rd_rsp_pd;
output mc_dma_rd_rsp_vld;
output mc_int_rd_rsp_ready;
reg [513:0] mc_dma_rd_rsp_pd;
reg mc_dma_rd_rsp_vld;
reg mc_int_rd_rsp_ready;
reg [513:0] p3_pipe_data;
reg [513:0] p3_pipe_rand_data;
reg p3_pipe_rand_ready;
reg p3_pipe_rand_valid;
reg p3_pipe_ready;
reg p3_pipe_ready_bc;
reg [513:0] p3_pipe_skid_data;
reg p3_pipe_skid_ready;
reg p3_pipe_skid_valid;
reg p3_pipe_valid;
reg p3_skid_catch;
reg [513:0] p3_skid_data;
reg p3_skid_ready;
reg p3_skid_ready_flop;
reg p3_skid_valid;
//## pipe (3) randomizer
`ifndef SYNTHESIS
reg p3_pipe_rand_active;
`endif
always @(
  `ifndef SYNTHESIS
  p3_pipe_rand_active
  or
     `endif
     mc_int_rd_rsp_valid
  or p3_pipe_rand_ready
  or mc_int_rd_rsp_pd
  ) begin
  `ifdef SYNTHESIS
  p3_pipe_rand_valid = mc_int_rd_rsp_valid;
  mc_int_rd_rsp_ready = p3_pipe_rand_ready;
  p3_pipe_rand_data = mc_int_rd_rsp_pd[513:0];
  `else
// VCS coverage off
  p3_pipe_rand_valid = (p3_pipe_rand_active)? 1'b0 : mc_int_rd_rsp_valid;
  mc_int_rd_rsp_ready = (p3_pipe_rand_active)? 1'b0 : p3_pipe_rand_ready;
  p3_pipe_rand_data = (p3_pipe_rand_active)? 'bx : mc_int_rd_rsp_pd[513:0];
// VCS coverage on
  `endif
end
`ifndef SYNTHESIS
// VCS coverage off
//// randomization init   
integer p3_pipe_stall_cycles;
integer p3_pipe_stall_probability;
integer p3_pipe_stall_cycles_min;
integer p3_pipe_stall_cycles_max;
initial begin
  p3_pipe_stall_cycles = 0;
  p3_pipe_stall_probability = 0;
  p3_pipe_stall_cycles_min = 1;
  p3_pipe_stall_cycles_max = 10;
`ifndef SYNTH_LEVEL1_COMPILE
  if ( $value$plusargs( "NV_NVDLA_CDMA_wg_pipe_rand_probability=%d", p3_pipe_stall_probability ) ) ; // deprecated
  else if ( $value$plusargs( "default_pipe_rand_probability=%d", p3_pipe_stall_probability ) ) ; // deprecated
  if ( $value$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_probability=%d", p3_pipe_stall_probability ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_probability=%d", p3_pipe_stall_probability ) ) ;
  if ( $value$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_cycles_min=%d", p3_pipe_stall_cycles_min ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_min=%d", p3_pipe_stall_cycles_min ) ) ;
  if ( $value$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_cycles_max=%d", p3_pipe_stall_cycles_max ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_max=%d", p3_pipe_stall_cycles_max ) ) ;
`endif
end
// randomization globals
`ifndef SYNTH_LEVEL1_COMPILE
`ifdef SIMTOP_RANDOMIZE_STALLS
always @( `SIMTOP_RANDOMIZE_STALLS.global_stall_event ) begin
  if ( ! $test$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_probability" ) ) p3_pipe_stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_probability;
  if ( ! $test$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_cycles_min" ) ) p3_pipe_stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_min;
  if ( ! $test$plusargs( "NV_NVDLA_CDMA_wg_pipe_stall_cycles_max" ) ) p3_pipe_stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_max;
end
`endif
`endif
//// randomization active
reg p3_pipe_rand_enable;
reg p3_pipe_rand_poised;
always @(
  p3_pipe_stall_cycles
  or p3_pipe_stall_probability
  or mc_int_rd_rsp_valid
  ) begin
  p3_pipe_rand_active = p3_pipe_stall_cycles != 0;
  p3_pipe_rand_enable = p3_pipe_stall_probability != 0;
  p3_pipe_rand_poised = p3_pipe_rand_enable && !p3_pipe_rand_active && mc_int_rd_rsp_valid === 1'b1;
end
//// randomization cycles
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p3_pipe_stall_cycles <= 1'b0;
  end else begin
  if (p3_pipe_rand_poised) begin
    if (p3_pipe_stall_probability >= prand_inst0(1, 100)) begin
      p3_pipe_stall_cycles <= prand_inst1(p3_pipe_stall_cycles_min, p3_pipe_stall_cycles_max);
    end
  end else if (p3_pipe_rand_active) begin
    p3_pipe_stall_cycles <= p3_pipe_stall_cycles - 1;
  end else begin
    p3_pipe_stall_cycles <= 0;
  end
  end
end
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
`endif
// VCS coverage on
//## pipe (3) valid-ready-bubble-collapse
always @(
  p3_pipe_ready
  or p3_pipe_valid
  ) begin
  p3_pipe_ready_bc = p3_pipe_ready || !p3_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p3_pipe_valid <= 1'b0;
  end else begin
  p3_pipe_valid <= (p3_pipe_ready_bc)? p3_pipe_rand_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p3_pipe_data <= (p3_pipe_ready_bc && p3_pipe_rand_valid)? p3_pipe_rand_data : p3_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p3_pipe_ready_bc
  ) begin
  p3_pipe_rand_ready = p3_pipe_ready_bc;
end
//## pipe (3) skid buffer
always @(
  p3_pipe_valid
  or p3_skid_ready_flop
  or p3_pipe_skid_ready
  or p3_skid_valid
  ) begin
  p3_skid_catch = p3_pipe_valid && p3_skid_ready_flop && !p3_pipe_skid_ready;
  p3_skid_ready = (p3_skid_valid)? p3_pipe_skid_ready : !p3_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p3_skid_valid <= 1'b0;
    p3_skid_ready_flop <= 1'b1;
    p3_pipe_ready <= 1'b1;
  end else begin
  p3_skid_valid <= (p3_skid_valid)? !p3_pipe_skid_ready : p3_skid_catch;
  p3_skid_ready_flop <= p3_skid_ready;
  p3_pipe_ready <= p3_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p3_skid_data <= (p3_skid_catch)? p3_pipe_data : p3_skid_data;
// VCS sop_coverage_off end
end
always @(
  p3_skid_ready_flop
  or p3_pipe_valid
  or p3_skid_valid
  or p3_pipe_data
  or p3_skid_data
  ) begin
  p3_pipe_skid_valid = (p3_skid_ready_flop)? p3_pipe_valid : p3_skid_valid;
// VCS sop_coverage_off start
  p3_pipe_skid_data = (p3_skid_ready_flop)? p3_pipe_data : p3_skid_data;
// VCS sop_coverage_off end
end
//## pipe (3) output
always @(
  p3_pipe_skid_valid
  or dma_rd_rsp_rdy
  or p3_pipe_skid_data
  ) begin
  mc_dma_rd_rsp_vld = p3_pipe_skid_valid;
  p3_pipe_skid_ready = dma_rd_rsp_rdy;
  mc_dma_rd_rsp_pd = p3_pipe_skid_data;
end
//## pipe (3) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p3_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_140x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mc_dma_rd_rsp_vld^dma_rd_rsp_rdy^mc_int_rd_rsp_valid^mc_int_rd_rsp_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
// VCS coverage off
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_141x (nvdla_core_clk, `ASSERT_RESET, (mc_int_rd_rsp_valid && !mc_int_rd_rsp_ready), (mc_int_rd_rsp_valid), (mc_int_rd_rsp_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
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
`endif
endmodule // NV_NVDLA_CDMA_WG_pipe_p3
// **************************************************************************************************************
// Generated by ::pipe -m -bc -os cv_dma_rd_rsp_pd (cv_dma_rd_rsp_vld,dma_rd_rsp_rdy) <= cv_int_rd_rsp_pd[513:0] (cv_int_rd_rsp_valid,cv_int_rd_rsp_ready)
// **************************************************************************************************************
