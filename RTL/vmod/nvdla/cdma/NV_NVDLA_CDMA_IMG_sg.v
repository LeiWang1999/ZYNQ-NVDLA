// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDMA_IMG_sg.v
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
module NV_NVDLA_CDMA_IMG_sg (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,img2status_dat_entries
  ,img2status_dat_updt
  ,img_dat2mcif_rd_req_ready
  ,is_running
  ,layer_st
  ,mcif2img_dat_rd_rsp_pd
  ,mcif2img_dat_rd_rsp_valid
  ,pixel_order
  ,pixel_planar
  ,pixel_planar0_bundle_limit
  ,pixel_planar0_bundle_limit_1st
  ,pixel_planar0_byte_sft
  ,pixel_planar0_lp_burst
  ,pixel_planar0_lp_vld
  ,pixel_planar0_rp_burst
  ,pixel_planar0_rp_vld
  ,pixel_planar0_width_burst
  ,pixel_planar1_bundle_limit
  ,pixel_planar1_bundle_limit_1st
  ,pixel_planar1_byte_sft
  ,pixel_planar1_lp_burst
  ,pixel_planar1_lp_vld
  ,pixel_planar1_rp_burst
  ,pixel_planar1_rp_vld
  ,pixel_planar1_width_burst
  ,pwrbus_ram_pd
  ,reg2dp_datain_addr_high_0
  ,reg2dp_datain_addr_high_1
  ,reg2dp_datain_addr_low_0
  ,reg2dp_datain_addr_low_1
  ,reg2dp_datain_height
  ,reg2dp_datain_ram_type
  ,reg2dp_dma_en
  ,reg2dp_entries
  ,reg2dp_line_stride
  ,reg2dp_mean_format
  ,reg2dp_op_en
  ,reg2dp_pixel_y_offset
  ,reg2dp_uv_line_stride
  ,sg2pack_img_prdy
  ,status2dma_free_entries
  ,status2dma_fsm_switch
  ,dp2reg_img_rd_latency
  ,dp2reg_img_rd_stall
//: my $dmaif = 64;
//: my $atmm = 8*8;
//: my $atmm_num = ($dmaif / $atmm);
//: foreach my $i(0..$atmm_num -1) {
//: print qq(
//: ,img2sbuf_p${i}_wr_addr
//: ,img2sbuf_p${i}_wr_data
//: ,img2sbuf_p${i}_wr_en
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,img2sbuf_p0_wr_addr
,img2sbuf_p0_wr_data
,img2sbuf_p0_wr_en

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,img_dat2mcif_rd_req_pd
  ,img_dat2mcif_rd_req_valid
  ,mcif2img_dat_rd_rsp_ready
  ,sg2pack_data_entries
  ,sg2pack_entry_end
  ,sg2pack_entry_mid
  ,sg2pack_entry_st
  ,sg2pack_height_total
  ,sg2pack_img_pd
  ,sg2pack_img_pvld
  ,sg2pack_mn_enable
  ,sg2pack_sub_h_end
  ,sg2pack_sub_h_mid
  ,sg2pack_sub_h_st
  ,sg_is_done
  );
//////////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
output [( 32 + 15 )-1:0] img_dat2mcif_rd_req_pd;
output img_dat2mcif_rd_req_valid;
input img_dat2mcif_rd_req_ready;
input [( 64 + (64/8/8) )-1:0] mcif2img_dat_rd_rsp_pd;
input mcif2img_dat_rd_rsp_valid;
output mcif2img_dat_rd_rsp_ready;
input [14:0] img2status_dat_entries;
input img2status_dat_updt;
input is_running;
input layer_st;
input [10:0] pixel_order;
input pixel_planar;
input [3:0] pixel_planar0_bundle_limit;
input [3:0] pixel_planar0_bundle_limit_1st;
//: my $atmmbw = int( log(8) / log(2) );
//: print qq(
//: input [${atmmbw}-1:0] pixel_planar0_byte_sft;
//: input [${atmmbw}-1:0] pixel_planar1_byte_sft;
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [3-1:0] pixel_planar0_byte_sft;
input [3-1:0] pixel_planar1_byte_sft;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input [3:0] pixel_planar0_lp_burst;
input pixel_planar0_lp_vld;
input [3:0] pixel_planar0_rp_burst;
input pixel_planar0_rp_vld;
input [13:0] pixel_planar0_width_burst;
input [4:0] pixel_planar1_bundle_limit;
input [4:0] pixel_planar1_bundle_limit_1st;
input [2:0] pixel_planar1_lp_burst;
input pixel_planar1_lp_vld;
input [2:0] pixel_planar1_rp_burst;
input pixel_planar1_rp_vld;
input [13:0] pixel_planar1_width_burst;
input [31:0] pwrbus_ram_pd;
input reg2dp_op_en;
input sg2pack_img_prdy;
input [14:0] status2dma_free_entries;
input status2dma_fsm_switch;
//: my $dmaif = 64;
//: my $atmm = 8*8;
//: my $atmm_num = ($dmaif / $atmm);
//: foreach my $i (0..$atmm_num -1) {
//: print qq(
//: output [7:0] img2sbuf_p${i}_wr_addr;
//: output [${atmm}-1:0] img2sbuf_p${i}_wr_data;
//: output img2sbuf_p${i}_wr_en;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [7:0] img2sbuf_p0_wr_addr;
output [64-1:0] img2sbuf_p0_wr_data;
output img2sbuf_p0_wr_en;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output [14:0] sg2pack_data_entries;
output [14:0] sg2pack_entry_end;
output [14:0] sg2pack_entry_mid;
output [14:0] sg2pack_entry_st;
output [12:0] sg2pack_height_total;
output [10:0] sg2pack_img_pd;
output sg2pack_img_pvld;
output sg2pack_mn_enable;
output [3:0] sg2pack_sub_h_end;
output [3:0] sg2pack_sub_h_mid;
output [3:0] sg2pack_sub_h_st;
output sg_is_done;
input [2:0] reg2dp_pixel_y_offset;
input [12:0] reg2dp_datain_height;
input [0:0] reg2dp_datain_ram_type;
input [31:0] reg2dp_datain_addr_high_0;
input [31:0] reg2dp_datain_addr_low_0;
input [31:0] reg2dp_datain_addr_high_1;
input [31:0] reg2dp_datain_addr_low_1;
input [31:0] reg2dp_line_stride;
input [31:0] reg2dp_uv_line_stride;
input [0:0] reg2dp_mean_format;
input [13:0] reg2dp_entries;
input [0:0] reg2dp_dma_en;
output [31:0] dp2reg_img_rd_stall;
output [31:0] dp2reg_img_rd_latency;
//////////////////////////////////////////////////////////
reg [14:0] data_entries;
reg [13:0] data_height;
reg [4:0] dma_rsp_size_cnt;
reg [31:0] dp2reg_img_rd_latency;
reg [31:0] dp2reg_img_rd_stall;
reg [12:0] height_cnt_total;
reg [14:0] img_entry_onfly;
reg img_rd_latency_cen;
reg img_rd_latency_clr;
reg img_rd_latency_dec;
reg img_rd_latency_inc;
reg img_rd_stall_cen;
reg img_rd_stall_clr;
reg img_rd_stall_inc;
reg is_cbuf_ready;
reg is_running_d1;
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
reg mn_enable_d1;
reg [14:0] pre_entry_end_d1;
reg [14:0] pre_entry_mid_d1;
reg [14:0] pre_entry_st_d1;
reg [63:0] req_addr_d1;
reg req_bundle_end_d1;
reg req_end_d1;
reg req_grant_end_d1;
reg [12:0] req_height_cnt;
reg [63:0] req_img_p0_addr_base;
reg [3:0] req_img_p0_bundle_cnt;
reg [13:0] req_img_p0_burst_cnt;
reg [28:0] req_img_p0_burst_offset;
reg [31:0] req_img_p0_line_offset;
reg [1:0] req_img_p0_sec_cnt;
reg [63:0] req_img_p1_addr_base;
reg [4:0] req_img_p1_bundle_cnt;
reg [13:0] req_img_p1_burst_cnt;
reg [28:0] req_img_p1_burst_offset;
reg [31:0] req_img_p1_line_offset;
reg [1:0] req_img_p1_sec_cnt;
reg req_img_planar_cnt;
reg req_is_done;
reg req_is_dummy_d1;
reg req_line_end_d1;
reg req_line_st_d1;
reg req_planar_d1;
reg [4:0] req_size_d1;
reg [4:0] req_size_out_d1;
reg req_valid;
reg req_valid_d1;
reg rsp_img_1st_burst;
reg rsp_img_bundle_done_d1;
reg rsp_img_bundle_end;
reg [8*8 -1:0] rsp_img_c0l0;
reg [8*8 -1:0] rsp_img_c1l0;
reg rsp_img_end;
reg rsp_img_is_done;
reg rsp_img_layer_end_d1;
reg rsp_img_line_end;
reg rsp_img_line_end_d1;
reg rsp_img_line_st;
reg [7:0] rsp_img_p0_addr_d1;
reg [3:0] rsp_img_p0_burst_cnt;
reg [3:0] rsp_img_p0_burst_size_d1;
reg [8*8 -1:0] rsp_img_p0_data;
reg [8*8 -1:0] rsp_img_p0_data_d1;
reg [6:0] rsp_img_p0_planar0_idx;
reg [6:0] rsp_img_p0_planar1_idx;
reg rsp_img_p0_vld;
reg rsp_img_p0_vld_d1;
reg [7:0] rsp_img_p1_addr_d1;
reg [4:0] rsp_img_p1_burst_cnt;
reg [4:0] rsp_img_p1_burst_size_d1;
reg [8*8 -1:0] rsp_img_p1_data;
reg [8*8 -1:0] rsp_img_p1_data_d1;
reg [6:0] rsp_img_p1_planar0_idx;
reg [6:0] rsp_img_p1_planar1_idx;
reg rsp_img_p1_vld;
reg rsp_img_p1_vld_d1;
reg rsp_img_planar;
reg rsp_img_req_end;
reg rsp_img_vld;
reg [4:0] rsp_img_w_burst_size;
reg sg_is_done;
reg stl_adv;
reg [31:0] stl_cnt_cur;
reg [33:0] stl_cnt_dec;
reg [33:0] stl_cnt_ext;
reg [33:0] stl_cnt_inc;
reg [33:0] stl_cnt_mod;
reg [33:0] stl_cnt_new;
reg [33:0] stl_cnt_nxt;
wire [14:0] cur_required_entry;
wire [14:0] data_entries_w;
wire [13:0] data_height_w;
wire dma_blocking;
wire [63:0] dma_rd_req_addr;
wire [32 +14:0] dma_rd_req_pd;
wire dma_rd_req_rdy;
wire [14:0] dma_rd_req_size;
wire dma_rd_req_type;
wire dma_rd_req_vld;
wire [64 -1:0] dma_rd_rsp_data;
wire [(64/8/8)-1:0] dma_rd_rsp_mask;
wire [( 64 + (64/8/8) )-1:0] dma_rd_rsp_pd;
wire dma_rd_rsp_rdy;
wire dma_rd_rsp_vld;
wire [10:0] dma_req_fifo_data;
wire dma_req_fifo_ready;
wire dma_req_fifo_req;
wire dma_rsp_blocking;
wire dma_rsp_bundle_end;
wire dma_rsp_dummy;
wire dma_rsp_end;
wire [10:0] dma_rsp_fifo_data;
wire dma_rsp_fifo_ready;
wire dma_rsp_fifo_req;
wire dma_rsp_line_end;
wire dma_rsp_line_st;
wire [1:0] dma_rsp_mask;
wire dma_rsp_planar;
wire [4:0] dma_rsp_size;
wire [4:0] dma_rsp_size_cnt_inc;
wire [4:0] dma_rsp_size_cnt_w;
wire dma_rsp_vld;
wire [4:0] dma_rsp_w_burst_size;
wire dp2reg_img_rd_stall_dec;
wire [14:0] img_entry_onfly_add;
wire img_entry_onfly_en;
wire [14:0] img_entry_onfly_sub;
wire [14:0] img_entry_onfly_w;
wire is_1st_height;
wire is_cbuf_enough;
wire is_cbuf_ready_w;
wire is_first_running;
wire is_img_1st_burst;
wire is_img_bundle_end;
wire is_img_dummy;
wire is_img_last_burst;
wire is_img_last_planar;
wire is_last_height;
wire is_last_req;
wire is_p0_1st_burst;
wire is_p0_bundle_end;
wire is_p0_cur_sec_end;
wire is_p0_last_burst;
wire is_p0_req_real;
wire is_p1_1st_burst;
wire is_p1_bundle_end;
wire is_p1_cur_sec_end;
wire is_p1_last_burst;
wire is_p1_req_real;
wire ltc_1_dec;
wire ltc_1_inc;
wire ltc_2_dec;
wire ltc_2_inc;
wire mn_enable;
wire mon_data_entries_w;
wire mon_dma_rsp_size_cnt_inc;
wire mon_img_entry_onfly_w;
wire [3:0] mon_pre_entry_end_w;
wire [3:0] mon_pre_entry_st_w;
wire mon_req_height_cnt_inc;
wire mon_req_img_p0_addr;
wire mon_req_img_p0_bundle_cnt_w;
wire mon_req_img_p0_burst_offset_w;
wire mon_req_img_p0_line_offset_w;
wire mon_req_img_p0_sec_cnt_w;
wire mon_req_img_p1_addr;
wire mon_req_img_p1_bundle_cnt_w;
wire mon_req_img_p1_burst_offset_w;
wire mon_req_img_p1_line_offset_w;
wire mon_req_img_p1_sec_cnt_w;
wire mon_req_size_out;
wire mon_rsp_img_p0_burst_cnt_inc;
wire [8*8 -1:0] mon_rsp_img_p0_data_d1_w;
wire mon_rsp_img_p1_burst_cnt_inc;
wire [8*8 -1:0] mon_rsp_img_p1_data_d1_w;
wire mon_total_required_entry;
reg [8:0] outs_dp2reg_img_rd_latency;
wire planar1_enable;
wire [14:0] pre_entry_end_w;
wire [14:0] pre_entry_st_w;
reg [3:0] pre_sub_h_end_d1;
reg [3:0] pre_sub_h_mid_d1;
reg [3:0] pre_sub_h_st_d1;
wire rd_req_rdyi;
wire [63:0] req_addr;
wire req_adv;
wire req_bundle_end;
wire req_grant_end;
wire [12:0] req_height_cnt_inc;
wire [12:0] req_height_cnt_w;
wire req_height_en;
wire [4:0] req_img_burst_size;
wire [63:0] req_img_p0_addr;
wire [63:0] req_img_p0_addr_base_w;
wire [3:0] req_img_p0_bundle_cnt_w;
wire [14:0] req_img_p0_burst_cnt_dec;
wire [13:0] req_img_p0_burst_cnt_w;
wire req_img_p0_burst_en;
wire req_img_p0_burst_offset_en;
wire [28:0] req_img_p0_burst_offset_w;
wire [3:0] req_img_p0_burst_size;
wire [3:0] req_img_p0_cur_burst;
wire [31:0] req_img_p0_line_offset_w;
wire [1:0] req_img_p0_sec_cnt_w;
wire req_img_p0_sec_en;
wire [63:0] req_img_p1_addr;
wire [63:0] req_img_p1_addr_base_w;
wire [4:0] req_img_p1_bundle_cnt_w;
wire [14:0] req_img_p1_burst_cnt_dec;
wire [13:0] req_img_p1_burst_cnt_w;
wire req_img_p1_burst_en;
wire req_img_p1_burst_offset_en;
wire [28:0] req_img_p1_burst_offset_w;
wire [4:0] req_img_p1_burst_size;
wire [4:0] req_img_p1_cur_burst;
wire [31:0] req_img_p1_line_offset_w;
wire [1:0] req_img_p1_sec_cnt_w;
wire req_img_p1_sec_en;
wire req_img_planar_cnt_w;
wire req_img_planar_en;
wire req_img_reg_en;
wire req_is_done_w;
wire req_is_dummy;
wire req_line_end;
wire req_line_st;
wire req_ready_d1;
wire req_reg_en;
wire [4:0] req_size;
wire [4:0] req_size_out;
wire req_valid_d1_w;
wire req_valid_w;
wire [64 -1:0] rsp_dat;
wire rsp_img_1st_burst_w;
wire rsp_img_bundle_done;
wire rsp_img_c0l0_wr_en;
wire rsp_img_c1l0_wr_en;
wire [64 -1:0] rsp_img_data_sw_o0;
wire [64 -1:0] rsp_img_data_sw_o1;
wire [64 -1:0] rsp_img_data_sw_o3;
wire [64 -1:0] rsp_img_data_sw_o5;
wire [64 -1:0] rsp_img_data_sw_o9;
wire rsp_img_is_done_w;
wire [8*8 -1:0] rsp_img_l0_data;
wire [7:0] rsp_img_p0_addr;
wire rsp_img_p0_burst_cnt_en;
wire [3:0] rsp_img_p0_burst_cnt_inc;
wire [3:0] rsp_img_p0_burst_cnt_w;
wire rsp_img_p0_burst_size_en;
wire [3:0] rsp_img_p0_burst_size_w;
reg [8*8 -1:0] rsp_img_p0_cache_data;
reg [8*8 -1:0] rsp_img_p1_cache_data;
wire [8*8 -1:0] rsp_img_p0_data_d1_w;
wire [8*8 -1:0] rsp_img_p0_data_atmm1;
wire [8*8 -1:0] rsp_img_p0_data_atmm0;
wire [8*8 -1:0] rsp_img_p0_data_w;
wire rsp_img_p0_planar0_en;
wire [7:0] rsp_img_p0_planar0_idx_inc;
wire [6:0] rsp_img_p0_planar0_idx_w;
wire rsp_img_p0_planar1_en;
wire [7:0] rsp_img_p0_planar1_idx_inc;
wire [6:0] rsp_img_p0_planar1_idx_w;
wire rsp_img_p0_vld_d1_w;
wire rsp_img_p0_vld_w;
wire [7:0] rsp_img_p1_addr;
wire rsp_img_p1_burst_cnt_en;
wire [4:0] rsp_img_p1_burst_cnt_inc;
wire [4:0] rsp_img_p1_burst_cnt_w;
wire rsp_img_p1_burst_size_en;
wire [4:0] rsp_img_p1_burst_size_w;
wire [8*8 -1:0] rsp_img_p1_data_d1_w;
wire [8*8 -1:0] rsp_img_p1_data_w;
wire rsp_img_p1_planar0_en;
wire [7:0] rsp_img_p1_planar0_idx_inc;
wire [6:0] rsp_img_p1_planar0_idx_w;
wire rsp_img_p1_planar1_en;
wire [7:0] rsp_img_p1_planar1_idx_inc;
wire [6:0] rsp_img_p1_planar1_idx_w;
wire rsp_img_p1_vld_d1_w;
wire rsp_img_p1_vld_w;
wire [2:0] rsp_img_planar_idx_add;
wire [10:0] rsp_img_sel;
//: my $atmmbw = int( log(8) / log(2) );
//: print qq(
//: wire [${atmmbw}-1:0] rsp_img_sft;
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [3-1:0] rsp_img_sft;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire rsp_img_vld_w;
wire sg2pack_img_layer_end;
wire sg2pack_img_line_end;
wire [3:0] sg2pack_img_p0_burst;
wire [4:0] sg2pack_img_p1_burst;
wire [10:0] sg2pack_pop_data;
wire sg2pack_pop_ready;
wire sg2pack_pop_req;
wire [10:0] sg2pack_push_data;
wire sg2pack_push_ready;
wire sg2pack_push_req;
wire sg_is_done_w;
wire [3:0] sub_h_end_limit;
wire sub_h_end_sel;
wire [3:0] sub_h_end_w;
wire [3:0] sub_h_mid_w;
wire [3:0] sub_h_st_limit;
wire sub_h_st_sel;
wire [3:0] sub_h_st_w;
wire [14:0] total_required_entry;
////////////////////////////////////////////////////////////////////////
// general signal //
////////////////////////////////////////////////////////////////////////
assign planar1_enable = pixel_planar;
assign data_height_w = reg2dp_datain_height + 1'b1;
assign mn_enable = (reg2dp_mean_format == 1'h1 );
assign {mon_data_entries_w, data_entries_w} = reg2dp_entries + 1'b1;
assign is_first_running = is_running & ~is_running_d1;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"is_running\" -q is_running_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"layer_st\" -d \"mn_enable\" -q mn_enable_d1");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"layer_st\" -d \"data_height_w\" -q data_height");
//: &eperl::flop("-nodeclare   -rval \"{13{1'b0}}\"  -en \"layer_st\" -d \"reg2dp_datain_height\" -q height_cnt_total");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"layer_st\" -d \"data_entries_w\" -q data_entries");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_running_d1 <= 1'b0;
   end else begin
       is_running_d1 <= is_running;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       mn_enable_d1 <= 1'b0;
   end else begin
       if ((layer_st) == 1'b1) begin
           mn_enable_d1 <= mn_enable;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           mn_enable_d1 <= 'bx;
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
       height_cnt_total <= {13{1'b0}};
   end else begin
       if ((layer_st) == 1'b1) begin
           height_cnt_total <= reg2dp_datain_height;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           height_cnt_total <= 'bx;
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

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// generator preparing parameters //
////////////////////////////////////////////////////////////////////////
///////////// sub_h for total control /////////////
assign sub_h_st_limit = 4'b1;
assign sub_h_mid_w = 4'h1;
assign sub_h_end_limit = 4'h1;
assign sub_h_st_sel = (~(|data_height[13:4]) && (data_height[3:0] <= sub_h_st_limit));
assign sub_h_end_sel = (~(|data_height[13:4]) && (data_height[3:0] <= sub_h_end_limit));
assign sub_h_st_w = sub_h_st_sel ? data_height[3:0] : sub_h_st_limit;
assign sub_h_end_w = sub_h_end_sel ? data_height[3:0] : sub_h_end_limit;
assign {mon_pre_entry_st_w, pre_entry_st_w} = sub_h_st_w * data_entries;
assign {mon_pre_entry_end_w, pre_entry_end_w} = sub_h_end_w * data_entries;
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"   -en \"is_first_running\" -d \"sub_h_st_w\"      -q pre_sub_h_st_d1");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"   -en \"is_first_running\" -d \"sub_h_mid_w\"     -q pre_sub_h_mid_d1");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"   -en \"is_first_running\" -d \"sub_h_end_w\"     -q pre_sub_h_end_d1");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"is_first_running\" -d \"pre_entry_st_w\"  -q pre_entry_st_d1");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"is_first_running\" -d \"data_entries\"    -q pre_entry_mid_d1");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"is_first_running\" -d \"pre_entry_end_w\" -q pre_entry_end_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pre_sub_h_st_d1 <= {4{1'b0}};
   end else begin
       if ((is_first_running) == 1'b1) begin
           pre_sub_h_st_d1 <= sub_h_st_w;
       // VCS coverage off
       end else if ((is_first_running) == 1'b0) begin
       end else begin
           pre_sub_h_st_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pre_sub_h_mid_d1 <= {4{1'b0}};
   end else begin
       if ((is_first_running) == 1'b1) begin
           pre_sub_h_mid_d1 <= sub_h_mid_w;
       // VCS coverage off
       end else if ((is_first_running) == 1'b0) begin
       end else begin
           pre_sub_h_mid_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pre_sub_h_end_d1 <= {4{1'b0}};
   end else begin
       if ((is_first_running) == 1'b1) begin
           pre_sub_h_end_d1 <= sub_h_end_w;
       // VCS coverage off
       end else if ((is_first_running) == 1'b0) begin
       end else begin
           pre_sub_h_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pre_entry_st_d1 <= {15{1'b0}};
   end else begin
       if ((is_first_running) == 1'b1) begin
           pre_entry_st_d1 <= pre_entry_st_w;
       // VCS coverage off
       end else if ((is_first_running) == 1'b0) begin
       end else begin
           pre_entry_st_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pre_entry_mid_d1 <= {15{1'b0}};
   end else begin
       if ((is_first_running) == 1'b1) begin
           pre_entry_mid_d1 <= data_entries;
       // VCS coverage off
       end else if ((is_first_running) == 1'b0) begin
       end else begin
           pre_entry_mid_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pre_entry_end_d1 <= {15{1'b0}};
   end else begin
       if ((is_first_running) == 1'b1) begin
           pre_entry_end_d1 <= pre_entry_end_w;
       // VCS coverage off
       end else if ((is_first_running) == 1'b0) begin
       end else begin
           pre_entry_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// request generator for input image //
////////////////////////////////////////////////////////////////////////
localparam SRC_DUMMY = 2'h0;
localparam SRC_P0 = 2'h1;
localparam SRC_P1 = 2'h2;
///////////// height counter /////////////
assign is_1st_height = ~(|req_height_cnt);
assign is_last_height = (req_height_cnt == height_cnt_total);
assign {mon_req_height_cnt_inc, req_height_cnt_inc} = req_height_cnt + 1'b1;
assign req_height_cnt_w = is_first_running ? 13'b0 : req_height_cnt_inc;
//: &eperl::flop("-nodeclare   -rval \"{13{1'b0}}\"  -en \"req_height_en\" -d \"req_height_cnt_w\" -q req_height_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_height_cnt <= {13{1'b0}};
   end else begin
       if ((req_height_en) == 1'b1) begin
           req_height_cnt <= req_height_cnt_w;
       // VCS coverage off
       end else if ((req_height_en) == 1'b0) begin
       end else begin
           req_height_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////// image planar count /////////////
assign is_img_last_planar = (req_img_planar_cnt == pixel_planar);
assign req_img_planar_cnt_w = (is_first_running | is_img_last_planar) ? 1'b0 : ~req_img_planar_cnt;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_img_planar_en\" -d \"req_img_planar_cnt_w\" -q req_img_planar_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_planar_cnt <= 1'b0;
   end else begin
       if ((req_img_planar_en) == 1'b1) begin
           req_img_planar_cnt <= req_img_planar_cnt_w;
       // VCS coverage off
       end else if ((req_img_planar_en) == 1'b0) begin
       end else begin
           req_img_planar_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////// image planar 0 bundle and burst count /////////////
assign {mon_req_img_p0_bundle_cnt_w,
        req_img_p0_bundle_cnt_w} = (is_first_running | is_p0_last_burst) ? {1'b0, pixel_planar0_bundle_limit_1st} :
                                  is_p0_bundle_end ? {1'b0, pixel_planar0_bundle_limit} :
                                  req_img_p0_bundle_cnt - req_img_p0_cur_burst;
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"req_img_p0_burst_en\" -d \"req_img_p0_bundle_cnt_w\" -q req_img_p0_bundle_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p0_bundle_cnt <= {4{1'b0}};
   end else begin
       if ((req_img_p0_burst_en) == 1'b1) begin
           req_img_p0_bundle_cnt <= req_img_p0_bundle_cnt_w;
       // VCS coverage off
       end else if ((req_img_p0_burst_en) == 1'b0) begin
       end else begin
           req_img_p0_bundle_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign req_img_p0_burst_cnt_dec = req_img_p0_burst_cnt - req_img_p0_bundle_cnt;
assign req_img_p0_cur_burst = req_img_p0_burst_cnt_dec[14] ? req_img_p0_burst_cnt[3:0] : req_img_p0_bundle_cnt;
assign req_img_p0_burst_cnt_w = ((is_first_running | is_p0_last_burst) & pixel_planar0_lp_vld) ? {{10{1'b0}}, pixel_planar0_lp_burst} :
                                ((is_first_running | is_p0_last_burst) & ~pixel_planar0_lp_vld) ? pixel_planar0_width_burst :
                                ((req_img_p0_sec_cnt == 2'h0) & is_p0_cur_sec_end) ? pixel_planar0_width_burst :
                                ((req_img_p0_sec_cnt == 2'h1) & is_p0_cur_sec_end) ? {{10{1'b0}}, pixel_planar0_rp_burst} :
                                req_img_p0_burst_cnt_dec[13:0];
assign {mon_req_img_p0_sec_cnt_w,
        req_img_p0_sec_cnt_w} = ((is_first_running | is_p0_last_burst) & pixel_planar0_lp_vld) ? 3'h0 :
                               ((is_first_running | is_p0_last_burst) & ~pixel_planar0_lp_vld) ? 3'h1 : req_img_p0_sec_cnt + 1'b1;
assign is_p0_cur_sec_end = (req_img_p0_burst_cnt <= {{10{1'b0}}, req_img_p0_bundle_cnt});
assign is_p0_1st_burst = ((req_img_p0_burst_cnt == {{10{1'b0}}, pixel_planar0_lp_burst}) & (req_img_p0_sec_cnt == 2'h0)) |
                         ((req_img_p0_burst_cnt == pixel_planar0_width_burst) & (req_img_p0_sec_cnt == 2'h1) & ~pixel_planar0_lp_vld);
assign is_p0_last_burst = (is_p0_cur_sec_end & (req_img_p0_sec_cnt == 2'h1) & ~pixel_planar0_rp_vld) |
                          (is_p0_cur_sec_end & (req_img_p0_sec_cnt == 2'h2));
assign is_p0_bundle_end = (req_img_p0_cur_burst == req_img_p0_bundle_cnt) | is_p0_last_burst;
assign req_img_p0_burst_size = req_img_p0_cur_burst;
assign is_p0_req_real = (req_img_p0_sec_cnt == 2'b1);
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"req_img_p0_burst_en\" -d \"req_img_p0_burst_cnt_w\" -q req_img_p0_burst_cnt");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"req_img_p0_sec_en\" -d \"req_img_p0_sec_cnt_w\" -q req_img_p0_sec_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p0_burst_cnt <= {14{1'b0}};
   end else begin
       if ((req_img_p0_burst_en) == 1'b1) begin
           req_img_p0_burst_cnt <= req_img_p0_burst_cnt_w;
       // VCS coverage off
       end else if ((req_img_p0_burst_en) == 1'b0) begin
       end else begin
           req_img_p0_burst_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p0_sec_cnt <= {2{1'b0}};
   end else begin
       if ((req_img_p0_sec_en) == 1'b1) begin
           req_img_p0_sec_cnt <= req_img_p0_sec_cnt_w;
       // VCS coverage off
       end else if ((req_img_p0_sec_en) == 1'b0) begin
       end else begin
           req_img_p0_sec_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////// image planar 1 bundle and burst count /////////////
assign {mon_req_img_p1_bundle_cnt_w,
        req_img_p1_bundle_cnt_w} = (is_first_running | is_p1_last_burst) ? {1'b0, pixel_planar1_bundle_limit_1st} :
                                  is_p1_bundle_end ? {1'b0, pixel_planar1_bundle_limit} :
                                  req_img_p1_bundle_cnt - req_img_p1_cur_burst;
assign req_img_p1_burst_cnt_dec = req_img_p1_burst_cnt - req_img_p1_bundle_cnt;
assign req_img_p1_cur_burst = req_img_p1_burst_cnt_dec[14] ? req_img_p1_burst_cnt[4:0] : req_img_p1_bundle_cnt;
assign req_img_p1_burst_cnt_w = ((is_first_running | is_p1_last_burst) & pixel_planar1_lp_vld) ? {{11{1'b0}}, pixel_planar1_lp_burst} :
                                ((is_first_running | is_p1_last_burst) & ~pixel_planar1_lp_vld) ? pixel_planar1_width_burst :
                                ((req_img_p1_sec_cnt == 2'h0) & is_p1_cur_sec_end) ? pixel_planar1_width_burst :
                                ((req_img_p1_sec_cnt == 2'h1) & is_p1_cur_sec_end) ? {{11{1'b0}}, pixel_planar1_rp_burst} :
                                req_img_p1_burst_cnt_dec[13:0];
assign {mon_req_img_p1_sec_cnt_w,
        req_img_p1_sec_cnt_w} = ((is_first_running | is_p1_last_burst) & pixel_planar1_lp_vld) ? 3'h0 :
                               ((is_first_running | is_p1_last_burst) & ~pixel_planar1_lp_vld) ? 3'h1 :
                               req_img_p1_sec_cnt + 1'b1;
assign req_img_p1_burst_size = req_img_p1_cur_burst;
assign is_p1_cur_sec_end = req_img_p1_burst_cnt_dec[14] | (req_img_p1_burst_cnt == {{9{1'b0}}, req_img_p1_bundle_cnt});
assign is_p1_1st_burst = ((req_img_p1_burst_cnt == {{11{1'b0}}, pixel_planar1_lp_burst}) & (req_img_p1_sec_cnt == 2'h0)) |
                         ((req_img_p1_burst_cnt == pixel_planar1_width_burst) & (req_img_p1_sec_cnt == 2'h1) & ~pixel_planar1_lp_vld);
assign is_p1_last_burst = (is_p1_cur_sec_end & (req_img_p1_sec_cnt == 2'h1) & ~pixel_planar1_rp_vld) |
                          (is_p1_cur_sec_end & (req_img_p1_sec_cnt == 2'h2));
assign is_p1_bundle_end = (req_img_p1_cur_burst == req_img_p1_bundle_cnt) | is_p1_last_burst;
assign is_p1_req_real = (req_img_p1_sec_cnt == 2'b1);
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"req_img_p1_burst_en\" -d \"req_img_p1_bundle_cnt_w\" -q req_img_p1_bundle_cnt");
//: &eperl::flop("-nodeclare   -rval \"{14{1'b0}}\"  -en \"req_img_p1_burst_en\" -d \"req_img_p1_burst_cnt_w\" -q req_img_p1_burst_cnt");
//: &eperl::flop("-nodeclare   -rval \"{2{1'b0}}\"  -en \"req_img_p1_sec_en\" -d \"req_img_p1_sec_cnt_w\" -q req_img_p1_sec_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p1_bundle_cnt <= {5{1'b0}};
   end else begin
       if ((req_img_p1_burst_en) == 1'b1) begin
           req_img_p1_bundle_cnt <= req_img_p1_bundle_cnt_w;
       // VCS coverage off
       end else if ((req_img_p1_burst_en) == 1'b0) begin
       end else begin
           req_img_p1_bundle_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p1_burst_cnt <= {14{1'b0}};
   end else begin
       if ((req_img_p1_burst_en) == 1'b1) begin
           req_img_p1_burst_cnt <= req_img_p1_burst_cnt_w;
       // VCS coverage off
       end else if ((req_img_p1_burst_en) == 1'b0) begin
       end else begin
           req_img_p1_burst_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p1_sec_cnt <= {2{1'b0}};
   end else begin
       if ((req_img_p1_sec_en) == 1'b1) begin
           req_img_p1_sec_cnt <= req_img_p1_sec_cnt_w;
       // VCS coverage off
       end else if ((req_img_p1_sec_en) == 1'b0) begin
       end else begin
           req_img_p1_sec_cnt <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////// image burst signal /////////////
assign is_img_1st_burst = ~req_img_planar_cnt ? is_p0_1st_burst : is_p1_1st_burst;
assign is_img_last_burst = ~req_img_planar_cnt ? is_p0_last_burst : is_p1_last_burst;
assign is_img_bundle_end = ~req_img_planar_cnt ? is_p0_bundle_end : is_p1_bundle_end;
assign req_img_burst_size = ~req_img_planar_cnt ? {1'b0, req_img_p0_burst_size} : req_img_p1_burst_size;
assign is_img_dummy = ~req_img_planar_cnt ? ~is_p0_req_real : ~is_p1_req_real;
///////////// control signal /////////////
assign req_valid_w = (~is_running) ? 1'b0 :
                     is_first_running ? 1'b1 :
                     (req_reg_en & is_last_req) ? 1'b0 : req_valid;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"req_valid_w\" -q req_valid");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_valid <= 1'b0;
   end else begin
       req_valid <= req_valid_w;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign req_adv = req_valid & (~req_valid_d1 | req_ready_d1);
assign is_last_req = (is_img_last_burst & is_img_last_planar & is_last_height);
assign req_img_reg_en = req_adv;
assign req_reg_en = req_adv;
assign req_img_p0_burst_en = is_first_running | (req_img_reg_en & ~req_img_planar_cnt);
assign req_img_p0_sec_en = is_first_running | (req_img_reg_en & ~req_img_planar_cnt & is_p0_cur_sec_end);
assign req_img_p1_burst_en = is_first_running | (req_img_reg_en & req_img_planar_cnt);
assign req_img_p1_sec_en = is_first_running | (req_img_reg_en & req_img_planar_cnt & is_p1_cur_sec_end);
assign req_img_p0_burst_offset_en = is_first_running | (req_img_reg_en & ~req_img_planar_cnt & (is_p0_req_real | is_p0_last_burst));
assign req_img_p1_burst_offset_en = is_first_running | (req_img_reg_en & req_img_planar_cnt & (is_p1_req_real | is_p1_last_burst));
assign req_img_planar_en = is_first_running | (req_img_reg_en & is_img_bundle_end);
assign req_height_en = is_first_running | (req_img_reg_en & is_img_last_burst & is_img_last_planar);
///////////// address line offset for image /////////////
assign {mon_req_img_p0_line_offset_w,
        req_img_p0_line_offset_w} = (is_first_running) ? 33'b0 : (req_img_p0_line_offset + reg2dp_line_stride);
assign {mon_req_img_p1_line_offset_w,
        req_img_p1_line_offset_w} = (is_first_running) ? 33'b0 : (req_img_p1_line_offset + reg2dp_uv_line_stride);
//: &eperl::flop("-nodeclare   -rval \"{32{1'b0}}\"  -en \"req_height_en\" -d \"req_img_p0_line_offset_w\" -q req_img_p0_line_offset");
//: &eperl::flop("-nodeclare   -rval \"{32{1'b0}}\"  -en \"req_height_en & planar1_enable\" -d \"req_img_p1_line_offset_w\" -q req_img_p1_line_offset");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p0_line_offset <= {32{1'b0}};
   end else begin
       if ((req_height_en) == 1'b1) begin
           req_img_p0_line_offset <= req_img_p0_line_offset_w;
       // VCS coverage off
       end else if ((req_height_en) == 1'b0) begin
       end else begin
           req_img_p0_line_offset <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p1_line_offset <= {32{1'b0}};
   end else begin
       if ((req_height_en & planar1_enable) == 1'b1) begin
           req_img_p1_line_offset <= req_img_p1_line_offset_w;
       // VCS coverage off
       end else if ((req_height_en & planar1_enable) == 1'b0) begin
       end else begin
           req_img_p1_line_offset <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////// address burst offset for image /////////////
//: my $atmm = 8;
//: my $k = 33 - int(log($atmm)/log(2));
//: print qq(
//: assign {mon_req_img_p0_burst_offset_w,
//: req_img_p0_burst_offset_w} = (is_first_running | is_p0_last_burst) ? ${k}'b0 : (req_img_p0_burst_offset + req_img_p0_cur_burst);
//: assign {mon_req_img_p1_burst_offset_w,
//: req_img_p1_burst_offset_w} = (is_first_running | is_p1_last_burst) ? ${k}'b0 : (req_img_p1_burst_offset + req_img_p1_cur_burst);
//: );
//: &eperl::flop("-nodeclare   -rval \"{(${k}-1){1'b0}}\"  -en \"req_img_p0_burst_offset_en\" -d \"req_img_p0_burst_offset_w\" -q req_img_p0_burst_offset");
//: &eperl::flop("-nodeclare   -rval \"{(${k}-1){1'b0}}\"  -en \"req_img_p1_burst_offset_en\" -d \"req_img_p1_burst_offset_w\" -q req_img_p1_burst_offset");
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign {mon_req_img_p0_burst_offset_w,
req_img_p0_burst_offset_w} = (is_first_running | is_p0_last_burst) ? 30'b0 : (req_img_p0_burst_offset + req_img_p0_cur_burst);
assign {mon_req_img_p1_burst_offset_w,
req_img_p1_burst_offset_w} = (is_first_running | is_p1_last_burst) ? 30'b0 : (req_img_p1_burst_offset + req_img_p1_cur_burst);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p0_burst_offset <= {(30-1){1'b0}};
   end else begin
       if ((req_img_p0_burst_offset_en) == 1'b1) begin
           req_img_p0_burst_offset <= req_img_p0_burst_offset_w;
       // VCS coverage off
       end else if ((req_img_p0_burst_offset_en) == 1'b0) begin
       end else begin
           req_img_p0_burst_offset <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_img_p1_burst_offset <= {(30-1){1'b0}};
   end else begin
       if ((req_img_p1_burst_offset_en) == 1'b1) begin
           req_img_p1_burst_offset <= req_img_p1_burst_offset_w;
       // VCS coverage off
       end else if ((req_img_p1_burst_offset_en) == 1'b0) begin
       end else begin
           req_img_p1_burst_offset <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////// address base for image /////////////
assign req_img_p0_addr_base_w = {reg2dp_datain_addr_high_0, reg2dp_datain_addr_low_0};
assign req_img_p1_addr_base_w = {reg2dp_datain_addr_high_1, reg2dp_datain_addr_low_1};
//: my $atmm = 8;
//: my $k = int(log($atmm)/log(2));
//: print qq(
//: assign {mon_req_img_p0_addr,
//: req_img_p0_addr} = req_img_p0_addr_base + req_img_p0_line_offset + {req_img_p0_burst_offset,${k}'d0};
//: assign {mon_req_img_p1_addr,
//: req_img_p1_addr} = req_img_p1_addr_base + req_img_p1_line_offset + {req_img_p1_burst_offset,${k}'d0};
//: );
//: &eperl::flop("-nodeclare  -norst -en \"layer_st\" -d \"req_img_p0_addr_base_w\" -q req_img_p0_addr_base");
//: &eperl::flop("-nodeclare  -norst -en \"layer_st\" -d \"req_img_p1_addr_base_w\" -q req_img_p1_addr_base");
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign {mon_req_img_p0_addr,
req_img_p0_addr} = req_img_p0_addr_base + req_img_p0_line_offset + {req_img_p0_burst_offset,3'd0};
assign {mon_req_img_p1_addr,
req_img_p1_addr} = req_img_p1_addr_base + req_img_p1_line_offset + {req_img_p1_burst_offset,3'd0};
always @(posedge nvdla_core_clk) begin
       if ((layer_st) == 1'b1) begin
           req_img_p0_addr_base <= req_img_p0_addr_base_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           req_img_p0_addr_base <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((layer_st) == 1'b1) begin
           req_img_p1_addr_base <= req_img_p1_addr_base_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           req_img_p1_addr_base <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////// request package /////////////
assign req_valid_d1_w = ~is_running ? 1'b0 :
                        req_valid ? 1'b1 :
                        req_ready_d1 ? 1'b0 : req_valid_d1;
assign req_addr = req_img_planar_cnt ? req_img_p1_addr : req_img_p0_addr ;
assign req_size = req_img_burst_size;
assign {mon_req_size_out,
        req_size_out} = req_size - 1'b1;
assign req_line_st = is_img_1st_burst;
assign req_bundle_end = (is_img_bundle_end & is_img_last_planar);
assign req_line_end = (is_img_last_burst & is_img_last_planar);
assign req_grant_end = (is_img_last_burst & is_img_last_planar);
assign req_is_dummy = is_img_dummy;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"req_valid_d1_w\" -q req_valid_d1");
//: &eperl::flop("-nodeclare   -rval \"{64{1'b0}}\"  -en \"req_reg_en\" -d \"req_addr\" -q req_addr_d1");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"req_reg_en\" -d \"req_size\" -q req_size_d1");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"req_reg_en\" -d \"req_size_out\" -q req_size_out_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_reg_en\" -d \"req_line_st\" -q req_line_st_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_reg_en\" -d \"req_bundle_end\" -q req_bundle_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_reg_en\" -d \"req_line_end\" -q req_line_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_reg_en\" -d \"req_grant_end\" -q req_grant_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_reg_en\" -d \"is_last_req\" -q req_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_reg_en\" -d \"req_img_planar_cnt\" -q req_planar_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_reg_en\" -d \"req_is_dummy\" -q req_is_dummy_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_valid_d1 <= 1'b0;
   end else begin
       req_valid_d1 <= req_valid_d1_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_addr_d1 <= {64{1'b0}};
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_addr_d1 <= req_addr;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_addr_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_size_d1 <= {5{1'b0}};
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_size_d1 <= req_size;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_size_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_size_out_d1 <= {5{1'b0}};
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_size_out_d1 <= req_size_out;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_size_out_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_line_st_d1 <= 1'b0;
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_line_st_d1 <= req_line_st;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_line_st_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_bundle_end_d1 <= 1'b0;
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_bundle_end_d1 <= req_bundle_end;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_bundle_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_line_end_d1 <= 1'b0;
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_line_end_d1 <= req_line_end;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_line_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_grant_end_d1 <= 1'b0;
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_grant_end_d1 <= req_grant_end;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_grant_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_end_d1 <= 1'b0;
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_end_d1 <= is_last_req;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_planar_d1 <= 1'b0;
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_planar_d1 <= req_img_planar_cnt;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_planar_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_is_dummy_d1 <= 1'b0;
   end else begin
       if ((req_reg_en) == 1'b1) begin
           req_is_dummy_d1 <= req_is_dummy;
       // VCS coverage off
       end else if ((req_reg_en) == 1'b0) begin
       end else begin
           req_is_dummy_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
`ifdef NVDLA_PRINT_CDMA
always @ (posedge nvdla_core_clk)
begin
    if(req_valid_d1 & req_ready_d1)
    begin
        $display("[CDMA IMG REQ] Dummy = %d, Addr = 0x%010h, size = %0d, time = %0d", req_is_dummy_d1, req_addr_d1, req_size_d1, $stime);
    end
end
`endif
////////////////////////////////////////////////////////////////////////
// request arbiter and cbuf entry monitor //
////////////////////////////////////////////////////////////////////////
assign req_ready_d1 = ((dma_rd_req_rdy | req_is_dummy_d1) & dma_req_fifo_ready & is_cbuf_ready);
assign req_is_done_w = is_first_running ? 1'b0 :
                       (req_valid_d1 & req_ready_d1 & req_end_d1) ? 1'b1 : req_is_done;
//: &eperl::flop("-nodeclare   -rval \"1'b1\"   -d \"req_is_done_w\" -q req_is_done");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_is_done <= 1'b1;
   end else begin
       req_is_done <= req_is_done_w;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////// cbuf monitor /////////////
assign cur_required_entry = (is_cbuf_ready | req_is_done) ? 15'b0 :
                            is_last_height ? pre_entry_end_d1 :
                            is_1st_height ? pre_entry_st_d1 : pre_entry_mid_d1;
assign {mon_total_required_entry,
        total_required_entry} = cur_required_entry + img_entry_onfly;
assign is_cbuf_enough = (status2dma_free_entries >= total_required_entry);
assign is_cbuf_ready_w = (~is_running | is_first_running) ? 1'b0 :
                         (req_valid_d1 & req_ready_d1 & req_grant_end_d1) ? 1'b0 :
                         (~is_cbuf_ready) ? is_cbuf_enough : is_cbuf_ready;
assign img_entry_onfly_sub = img2status_dat_updt ? img2status_dat_entries : 15'b0;
assign img_entry_onfly_add = (~req_is_done & is_cbuf_enough & ~is_cbuf_ready) ? cur_required_entry : 15'b0;
assign {mon_img_entry_onfly_w,
        img_entry_onfly_w} = img_entry_onfly + img_entry_onfly_add - img_entry_onfly_sub;
assign img_entry_onfly_en = (~req_is_done & is_cbuf_enough & ~is_cbuf_ready) | img2status_dat_updt;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"is_cbuf_ready_w\" -q is_cbuf_ready");
//: &eperl::flop("-nodeclare   -rval \"{15{1'b0}}\"  -en \"img_entry_onfly_en\" -d \"img_entry_onfly_w\" -q img_entry_onfly");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       is_cbuf_ready <= 1'b0;
   end else begin
       is_cbuf_ready <= is_cbuf_ready_w;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       img_entry_onfly <= {15{1'b0}};
   end else begin
       if ((img_entry_onfly_en) == 1'b1) begin
           img_entry_onfly <= img_entry_onfly_w;
       // VCS coverage off
       end else if ((img_entry_onfly_en) == 1'b0) begin
       end else begin
           img_entry_onfly <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// CDMA IMG read request interface //
////////////////////////////////////////////////////////////////////////
//==============
// DMA Interface
//==============
// rd Channel: Request
NV_NVDLA_DMAIF_rdreq NV_NVDLA_PDP_RDMA_rdreq(
  .nvdla_core_clk (nvdla_core_clk )
 ,.nvdla_core_rstn (nvdla_core_rstn )
 ,.reg2dp_src_ram_type (reg2dp_datain_ram_type)
 ,.mcif_rd_req_pd (img_dat2mcif_rd_req_pd )
 ,.mcif_rd_req_valid (img_dat2mcif_rd_req_valid)
 ,.mcif_rd_req_ready (img_dat2mcif_rd_req_ready)
 ,.dmaif_rd_req_pd (dma_rd_req_pd )
 ,.dmaif_rd_req_vld (dma_rd_req_vld )
 ,.dmaif_rd_req_rdy (dma_rd_req_rdy )
);
// rd Channel: Response
NV_NVDLA_DMAIF_rdrsp NV_NVDLA_PDP_RDMA_rdrsp(
   .nvdla_core_clk (nvdla_core_clk )
  ,.nvdla_core_rstn (nvdla_core_rstn )
  ,.mcif_rd_rsp_pd (mcif2img_dat_rd_rsp_pd )
  ,.mcif_rd_rsp_valid (mcif2img_dat_rd_rsp_valid )
  ,.mcif_rd_rsp_ready (mcif2img_dat_rd_rsp_ready )
  ,.dmaif_rd_rsp_pd (dma_rd_rsp_pd )
  ,.dmaif_rd_rsp_pvld (dma_rd_rsp_vld )
  ,.dmaif_rd_rsp_prdy (dma_rd_rsp_rdy )
);
///////////////////////////////////////////
// PKT_PACK_WIRE( dma_read_cmd , dma_rd_req_ , dma_rd_req_pd )
assign dma_rd_req_pd[32 -1:0] = dma_rd_req_addr[32 -1:0];
assign dma_rd_req_pd[32 +14:32] = dma_rd_req_size[14:0];
assign dma_rd_req_vld = req_valid_d1 & dma_req_fifo_ready & is_cbuf_ready & ~req_is_dummy_d1;
assign dma_rd_req_addr = req_addr_d1;
assign dma_rd_req_size = {{10{1'b0}}, req_size_out_d1};
assign dma_rd_req_type = reg2dp_datain_ram_type;
assign dma_rd_rsp_rdy = ~dma_blocking;
assign dma_blocking = dma_rsp_blocking;
NV_NVDLA_CDMA_IMG_fifo u_NV_NVDLA_CDMA_IMG_fifo (
   .clk (nvdla_core_clk) //|< i
  ,.reset_ (nvdla_core_rstn) //|< i
  ,.wr_ready (dma_req_fifo_ready) //|> w
  ,.wr_req (dma_req_fifo_req) //|< r
  ,.wr_data (dma_req_fifo_data[10:0]) //|< r
  ,.rd_ready (dma_rsp_fifo_ready) //|< r
  ,.rd_req (dma_rsp_fifo_req) //|> w
  ,.rd_data (dma_rsp_fifo_data[10:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  );
assign dma_req_fifo_req = req_valid_d1 & is_cbuf_ready & (dma_rd_req_rdy | req_is_dummy_d1) ;
assign dma_req_fifo_data = {req_planar_d1,
                           req_end_d1,
                           req_line_end_d1,
                           req_bundle_end_d1,
                           req_line_st_d1,
                           req_is_dummy_d1,
                           req_size_d1[4:0]};
////////////////////////////////////////////////////////////////////////
// CDMA IMG read response logic //
////////////////////////////////////////////////////////////////////////
assign dma_rd_rsp_data[64 -1:0] = dma_rd_rsp_pd[64 -1:0];
assign dma_rd_rsp_mask[(64/8/8)-1:0] = dma_rd_rsp_pd[( 64 + (64/8/8) )-1:64];
assign {dma_rsp_planar,
        dma_rsp_end,
        dma_rsp_line_end,
        dma_rsp_bundle_end,
        dma_rsp_line_st,
        dma_rsp_dummy,
        dma_rsp_size} = dma_rsp_fifo_data;
assign dma_rsp_blocking = (dma_rsp_fifo_req & dma_rsp_dummy);
assign dma_rsp_mask[0] = (~dma_rsp_fifo_req) ? 1'b0 :
                         ~dma_rsp_dummy ? (dma_rd_rsp_vld & dma_rd_rsp_mask[0]) : 1'b1;
//: my $msk = (64/8/8);
//: if($msk >= 2) {
//: print qq(
//: assign dma_rsp_mask[1] = (~dma_rsp_fifo_req) ? 1'b0 :
//: ~dma_rsp_dummy ? (dma_rd_rsp_vld & dma_rd_rsp_mask[1]) :
//: (dma_rsp_size[4:1] == dma_rsp_size_cnt[4:1]) ? 1'b0 : 1'b1;
//: );
//: } elsif($msk == 4) {
//: print qq(
//: assign dma_rsp_mask[2] = (~dma_rsp_fifo_req) ? 1'b0 :
//: ~dma_rsp_dummy ? (dma_rd_rsp_vld & dma_rd_rsp_mask[2]) :
//: ((dma_rsp_size[4:2] == dma_rsp_size_cnt[4:2]) & (&dma_rsp_size_cnt[11])) ? 1'b0 : 1'b1;
//: assign dma_rsp_mask[3] = (~dma_rsp_fifo_req) ? 1'b0 :
//: ~dma_rsp_dummy ? (dma_rd_rsp_vld & dma_rd_rsp_mask[3]) :
//: (dma_rsp_size[4:2] == dma_rsp_size_cnt[4:2]) ? 1'b0 : 1'b1;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign {mon_dma_rsp_size_cnt_inc,
        dma_rsp_size_cnt_inc} = dma_rsp_size_cnt
//: my $msk = (64/8/8);
//: foreach my $i (0..$msk-1) {
//: print qq(
//: + dma_rsp_mask[$i]
//: );
//: }
//: print qq( ; );
//| eperl: generated_beg (DO NOT EDIT BELOW)

+ dma_rsp_mask[0]
 ; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dma_rsp_size_cnt_w = (dma_rsp_size_cnt_inc == dma_rsp_size) ? 5'b0 : dma_rsp_size_cnt_inc;
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"dma_rsp_vld\" -d \"dma_rsp_size_cnt_w\" -q dma_rsp_size_cnt");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dma_rsp_size_cnt <= {5{1'b0}};
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
assign dma_rsp_vld = dma_rsp_fifo_req & (dma_rsp_dummy | dma_rd_rsp_vld);
assign dma_rsp_fifo_ready = (dma_rsp_vld & (dma_rsp_size_cnt_inc == dma_rsp_size));
////////////////////////////////////////////////////////////////////////
// CDMA pixel data response logic stage 1 //
////////////////////////////////////////////////////////////////////////
assign rsp_img_vld_w = dma_rsp_vld;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"rsp_img_vld_w\" -q rsp_img_vld");
//: my $dmaif = 64/8;
//: my $atmm = 8;
//: my $atmm_num = ($dmaif / $atmm);
//: foreach my $i (0..$atmm_num-1) {
//: print qq(
//: assign rsp_img_p${i}_vld_w = dma_rsp_mask[${i}];
//:
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn)
//: if (!nvdla_core_rstn) begin
//: rsp_img_p${i}_vld <= 1'b0;
//: end else begin
//: rsp_img_p${i}_vld <= rsp_img_p${i}_vld_w;
//: end
//:
//: always @(posedge nvdla_core_clk)
//: if (rsp_img_p${i}_vld_w) begin
//: rsp_img_p${i}_data <= rsp_img_p${i}_data_w;
//: end
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_vld <= 1'b0;
   end else begin
       rsp_img_vld <= rsp_img_vld_w;
   end
end

assign rsp_img_p0_vld_w = dma_rsp_mask[0];

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn)
if (!nvdla_core_rstn) begin
rsp_img_p0_vld <= 1'b0;
end else begin
rsp_img_p0_vld <= rsp_img_p0_vld_w;
end

always @(posedge nvdla_core_clk)
if (rsp_img_p0_vld_w) begin
rsp_img_p0_data <= rsp_img_p0_data_w;
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign rsp_dat = dma_rd_rsp_data;
//10'h1 ABGR, VU, single, unchange
//10'h2 ARGB, AYUV, 8bpp
//10'h4 ARGB, AYUV, 16bpp
//10'h8 BGRA, VUYA, 8bpp
//10'h10 BGRA, VUYA, 16bpp
//10'h20 RGBA, YUVA, 8bpp
//10'h40 ARGB, AYUV, packed_10b
//10'h80 BGRA, YUVA, packed_10b
//10'h100 RGBA, packed_10b
//10'h200 UV, 8bpp
//10'h400 UV, 16bpp
assign rsp_img_sel[0] = pixel_order[0] | (~dma_rsp_planar & pixel_planar);
assign rsp_img_sel[1] = pixel_order[1];
assign rsp_img_sel[2] = pixel_order[2];
assign rsp_img_sel[3] = pixel_order[3];
assign rsp_img_sel[4] = pixel_order[4];
assign rsp_img_sel[5] = pixel_order[5];
assign rsp_img_sel[6] = pixel_order[6];
assign rsp_img_sel[7] = pixel_order[7];
assign rsp_img_sel[8] = pixel_order[8];
assign rsp_img_sel[9] = pixel_order[9] & dma_rsp_planar;
assign rsp_img_sel[10] = pixel_order[10] & dma_rsp_planar;
//////// reordering ////////
assign rsp_img_data_sw_o0 = rsp_dat;
assign rsp_img_data_sw_o1 = {
//: my $dmaif = 64/32;##
//: if($dmaif > 1) {
//: foreach my $i (0..$dmaif-2) {
//: my $k = $dmaif - $i -1;
//: print qq(
//: rsp_dat[${k}*32+31:${k}*32+24], rsp_dat[${k}*32+7:${k}*32], rsp_dat[${k}*32+15:${k}*32+8], rsp_dat[${k}*32+23:${k}*32+16],
//: );
//: }
//: }
//: print " rsp_dat[0*32+31:0*32+24], rsp_dat[0*32+7:0*32], rsp_dat[0*32+15:0*32+8], rsp_dat[0*32+23:0*32+16]};  \n";
//:
//:
//: print " assign rsp_img_data_sw_o3 = {  \n";
//: if($dmaif > 1) {
//: foreach my $i (0..$dmaif-2) {
//: my $k = $dmaif - $i -1;
//: print qq(
//: rsp_dat[${k}*32+7:${k}*32], rsp_dat[${k}*32+31:${k}*32+24], rsp_dat[${k}*32+23:${k}*32+16], rsp_dat[${k}*32+15:${k}*32+8],
//: );
//: }
//: }
//: print " rsp_dat[0*32+7:0*32], rsp_dat[0*32+31:0*32+24], rsp_dat[0*32+23:0*32+16], rsp_dat[0*32+15:0*32+8]};  \n";
//:
//:
//: print " assign rsp_img_data_sw_o5 = {  \n";
//: if($dmaif > 1) {
//: foreach my $i (0..$dmaif-2) {
//: my $k = $dmaif - $i -1;
//: print qq(
//: rsp_dat[${k}*32+7:${k}*32], rsp_dat[${k}*32+15:${k}*32+8], rsp_dat[${k}*32+23:${k}*32+16], rsp_dat[${k}*32+31:${k}*32+24],
//: );
//: }
//: }
//: print " rsp_dat[0*32+7:0*32], rsp_dat[0*32+15:0*32+8], rsp_dat[0*32+23:0*32+16], rsp_dat[0*32+31:0*32+24]};  \n";
//: my $dmaif = 64/16; ##
//: print " assign rsp_img_data_sw_o9 = {  \n";
//: if($dmaif > 1) {
//: foreach my $i (0..$dmaif-2) {
//: my $k = $dmaif - $i -1;
//: print qq(
//: rsp_dat[${k}*16+7:${k}*16], rsp_dat[${k}*16+15:${k}*16+8],
//: );
//: }
//: }
//: print " rsp_dat[0*16+7:0*16], rsp_dat[0*16+15:0*16+8]};  \n";
//: my $dmaif = 64/8;
//: my $atmm = 8;
//: my $atmm_num = ($dmaif / $atmm);
//: print " assign {  \n";
//: if($atmm_num > 1) {
//: foreach my $i (0..$atmm_num -2) {
//: my $k = $atmm_num - $i -1;
//: print " rsp_img_p${k}_data_w,  ";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

rsp_dat[1*32+31:1*32+24], rsp_dat[1*32+7:1*32], rsp_dat[1*32+15:1*32+8], rsp_dat[1*32+23:1*32+16],
 rsp_dat[0*32+31:0*32+24], rsp_dat[0*32+7:0*32], rsp_dat[0*32+15:0*32+8], rsp_dat[0*32+23:0*32+16]};  
 assign rsp_img_data_sw_o3 = {  

rsp_dat[1*32+7:1*32], rsp_dat[1*32+31:1*32+24], rsp_dat[1*32+23:1*32+16], rsp_dat[1*32+15:1*32+8],
 rsp_dat[0*32+7:0*32], rsp_dat[0*32+31:0*32+24], rsp_dat[0*32+23:0*32+16], rsp_dat[0*32+15:0*32+8]};  
 assign rsp_img_data_sw_o5 = {  

rsp_dat[1*32+7:1*32], rsp_dat[1*32+15:1*32+8], rsp_dat[1*32+23:1*32+16], rsp_dat[1*32+31:1*32+24],
 rsp_dat[0*32+7:0*32], rsp_dat[0*32+15:0*32+8], rsp_dat[0*32+23:0*32+16], rsp_dat[0*32+31:0*32+24]};  
 assign rsp_img_data_sw_o9 = {  

rsp_dat[3*16+7:3*16], rsp_dat[3*16+15:3*16+8],

rsp_dat[2*16+7:2*16], rsp_dat[2*16+15:2*16+8],

rsp_dat[1*16+7:1*16], rsp_dat[1*16+15:1*16+8],
 rsp_dat[0*16+7:0*16], rsp_dat[0*16+15:0*16+8]};  
 assign {  

//| eperl: generated_end (DO NOT EDIT ABOVE)
        rsp_img_p0_data_w} = ({64{rsp_img_sel[0]}} & rsp_img_data_sw_o0) |
                             ({64{rsp_img_sel[1]}} & rsp_img_data_sw_o1) |
                             ({64{rsp_img_sel[3]}} & rsp_img_data_sw_o3) |
                             ({64{rsp_img_sel[5]}} & rsp_img_data_sw_o5) |
                             ({64{rsp_img_sel[9]}} & rsp_img_data_sw_o9);
assign dma_rsp_w_burst_size = dma_rsp_size;
assign rsp_img_1st_burst_w = dma_rsp_line_st & (dma_rsp_size_cnt == 5'h0);
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_vld_w\" -d \"dma_rsp_planar\" -q rsp_img_planar");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_vld_w\" -d \"rsp_img_1st_burst_w\" -q rsp_img_1st_burst");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_vld_w\" -d \"dma_rsp_line_st\" -q rsp_img_line_st");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_vld_w\" -d \"dma_rsp_fifo_ready\" -q rsp_img_req_end");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"rsp_img_vld_w & dma_rsp_fifo_ready\" -d \"dma_rsp_w_burst_size\" -q rsp_img_w_burst_size");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_vld_w\" -d \"dma_rsp_line_end & dma_rsp_fifo_ready\" -q rsp_img_line_end");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_vld_w\" -d \"dma_rsp_bundle_end & dma_rsp_fifo_ready\" -q rsp_img_bundle_end");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_vld_w\" -d \"dma_rsp_end & dma_rsp_fifo_ready\" -q rsp_img_end");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_planar <= 1'b0;
   end else begin
       if ((rsp_img_vld_w) == 1'b1) begin
           rsp_img_planar <= dma_rsp_planar;
       // VCS coverage off
       end else if ((rsp_img_vld_w) == 1'b0) begin
       end else begin
           rsp_img_planar <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_1st_burst <= 1'b0;
   end else begin
       if ((rsp_img_vld_w) == 1'b1) begin
           rsp_img_1st_burst <= rsp_img_1st_burst_w;
       // VCS coverage off
       end else if ((rsp_img_vld_w) == 1'b0) begin
       end else begin
           rsp_img_1st_burst <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_line_st <= 1'b0;
   end else begin
       if ((rsp_img_vld_w) == 1'b1) begin
           rsp_img_line_st <= dma_rsp_line_st;
       // VCS coverage off
       end else if ((rsp_img_vld_w) == 1'b0) begin
       end else begin
           rsp_img_line_st <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_req_end <= 1'b0;
   end else begin
       if ((rsp_img_vld_w) == 1'b1) begin
           rsp_img_req_end <= dma_rsp_fifo_ready;
       // VCS coverage off
       end else if ((rsp_img_vld_w) == 1'b0) begin
       end else begin
           rsp_img_req_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_w_burst_size <= {5{1'b0}};
   end else begin
       if ((rsp_img_vld_w & dma_rsp_fifo_ready) == 1'b1) begin
           rsp_img_w_burst_size <= dma_rsp_w_burst_size;
       // VCS coverage off
       end else if ((rsp_img_vld_w & dma_rsp_fifo_ready) == 1'b0) begin
       end else begin
           rsp_img_w_burst_size <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_line_end <= 1'b0;
   end else begin
       if ((rsp_img_vld_w) == 1'b1) begin
           rsp_img_line_end <= dma_rsp_line_end & dma_rsp_fifo_ready;
       // VCS coverage off
       end else if ((rsp_img_vld_w) == 1'b0) begin
       end else begin
           rsp_img_line_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_bundle_end <= 1'b0;
   end else begin
       if ((rsp_img_vld_w) == 1'b1) begin
           rsp_img_bundle_end <= dma_rsp_bundle_end & dma_rsp_fifo_ready;
       // VCS coverage off
       end else if ((rsp_img_vld_w) == 1'b0) begin
       end else begin
           rsp_img_bundle_end <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_end <= 1'b0;
   end else begin
       if ((rsp_img_vld_w) == 1'b1) begin
           rsp_img_end <= dma_rsp_end & dma_rsp_fifo_ready;
       // VCS coverage off
       end else if ((rsp_img_vld_w) == 1'b0) begin
       end else begin
           rsp_img_end <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// CDMA pixel data response logic stage 2: cache and sbuf write //
////////////////////////////////////////////////////////////////////////
//////// cache line control ////////
assign rsp_img_c0l0_wr_en = (rsp_img_p0_vld & (~rsp_img_planar));
assign rsp_img_c1l0_wr_en = (rsp_img_p0_vld & rsp_img_planar);
//assign rsp_img_l0_data = rsp_img_p1_vld ? rsp_img_p1_data : rsp_img_p0_data;
// need cache more when more dmaif/atmm
//: my $dmaif = 64;
//: my $atmm = (8 * 8);
//: my $atmm_num = ($dmaif / $atmm);
//: if($atmm_num == 1) {
//: print qq(
//: /////rsp_img_p0_cache_data  p0 means planar 0
//: );
//: &eperl::flop("-nodeclare   -rval \"{${atmm}{1'b0}}\"  -en \"rsp_img_c0l0_wr_en \" -d \"rsp_img_p0_data\" -q rsp_img_p0_cache_data");
//: &eperl::flop("-nodeclare   -rval \"{${atmm}{1'b0}}\"  -en \"rsp_img_c1l0_wr_en \" -d \"rsp_img_p0_data\" -q rsp_img_p1_cache_data");
//: } elsif($atmm_num == 2) {
//: print qq(
//: assign rsp_img_l0_data = rsp_img_p1_vld ? rsp_img_p1_data : rsp_img_p0_data;
//: );
//: } elsif($atmm_num == 4) {
//: print qq(
//: assign rsp_img_l0_data = rsp_img_p3_vld ? rsp_img_p3_data : rsp_img_p2_vld ? rsp_img_p2_data : rsp_img_p1_vld ? rsp_img_p1_data : rsp_img_p0_data;
//: assign rsp_img_l1_data = rsp_img_p3_vld ? rsp_img_p2_data : rsp_img_p2_vld ? rsp_img_p1_data : rsp_img_p0_data;
//: assign rsp_img_l2_data = rsp_img_p3_vld ? rsp_img_p1_data : rsp_img_p0_data;
//: );
//: }
//:
//: if($atmm_num > 1) {
//: foreach my $i(0..$atmm_num-2) {
//: &eperl::flop("-nodeclare   -rval \"{${atmm}{1'b0}}\"  -en \"rsp_img_c0l${i}_wr_en\" -d \"rsp_img_l${i}_data\" -q rsp_img_c0l${i}");
//: &eperl::flop("-nodeclare   -rval \"{${atmm}{1'b0}}\"  -en \"rsp_img_c1l${i}_wr_en\" -d \"rsp_img_l${i}_data\" -q rsp_img_c1l${i}");
//: print " //////// data write control logic: normal write back ////////   \n";
//: print " assign rsp_img_p${i}_cache_data = ({${atmm} {~rsp_img_planar}} & rsp_img_c0l${i}) | ({${atmm} { rsp_img_planar}} & rsp_img_c1l${i});    \n";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

/////rsp_img_p0_cache_data  p0 means planar 0
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p0_cache_data <= {64{1'b0}};
   end else begin
       if ((rsp_img_c0l0_wr_en ) == 1'b1) begin
           rsp_img_p0_cache_data <= rsp_img_p0_data;
       // VCS coverage off
       end else if ((rsp_img_c0l0_wr_en ) == 1'b0) begin
       end else begin
           rsp_img_p0_cache_data <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p1_cache_data <= {64{1'b0}};
   end else begin
       if ((rsp_img_c1l0_wr_en ) == 1'b1) begin
           rsp_img_p1_cache_data <= rsp_img_p0_data;
       // VCS coverage off
       end else if ((rsp_img_c1l0_wr_en ) == 1'b0) begin
       end else begin
           rsp_img_p1_cache_data <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//per atmm
//: my $dmaif = 64;
//: my $atmm = (8*8);
//: my $atmm_num = ($dmaif / $atmm);
//: if($atmm_num == 1) {
//: print qq(
//: assign rsp_img_p0_vld_d1_w = rsp_img_p0_vld & (~rsp_img_1st_burst);
//:
//: assign rsp_img_p0_data_atmm0 = rsp_img_p0_data;
//: assign {mon_rsp_img_p0_data_d1_w, rsp_img_p0_data_d1_w} = ({rsp_img_p0_data_atmm0,(rsp_img_c0l0_wr_en ? rsp_img_p0_cache_data : rsp_img_p1_cache_data)} >> {rsp_img_sft, 3'b0});
//:
//: assign rsp_img_planar_idx_add = 3'h1;
//: );
//: } elsif ($atmm_num == 2) {
//: print qq(
//: assign rsp_img_p0_vld_d1_w = rsp_img_p0_vld & (~rsp_img_1st_burst | rsp_img_p1_vld);
//: assign rsp_img_p1_vld_d1_w = rsp_img_p1_vld & (~rsp_img_1st_burst );
//:
//: assign rsp_img_p0_data_atmm0 = rsp_img_1st_burst ? rsp_img_p0_data : rsp_img_p0_cache_data;
//: assign rsp_img_p0_data_atmm1 = rsp_img_1st_burst ? rsp_img_p1_data : rsp_img_p0_data;
//: assign {mon_rsp_img_p0_data_d1_w, rsp_img_p0_data_d1_w} = ({rsp_img_p0_data_atmm1, rsp_img_p0_data_atmm0} >> {rsp_img_sft, 3'b0});
//: assign {mon_rsp_img_p1_data_d1_w, rsp_img_p1_data_d1_w} = ({rsp_img_p1_data, rsp_img_p0_data} >> {rsp_img_sft, 3'b0});
//:
//: assign rsp_img_planar_idx_add = rsp_img_p1_vld_d1_w ? 3'h2 : 3'h1;
//: );
//: } elsif ($atmm_num == 4) {
//: print qq(
//: assign rsp_img_p0_vld_d1_w = rsp_img_p0_vld & (~rsp_img_1st_burst | rsp_img_p1_vld | rsp_img_p2_vld | rsp_img_p3_vld );
//: assign rsp_img_p1_vld_d1_w = rsp_img_p1_vld & (~rsp_img_1st_burst | rsp_img_p2_vld | rsp_img_p3_vld );
//: assign rsp_img_p2_vld_d1_w = rsp_img_p2_vld & (~rsp_img_1st_burst | rsp_img_p3_vld );
//: assign rsp_img_p3_vld_d1_w = rsp_img_p3_vld & (~rsp_img_1st_burst );
//:
//: assign rsp_img_p0_data_atmm0 = rsp_img_1st_burst ? rsp_img_p0_data : rsp_img_p0_cache_data;
//: assign rsp_img_p0_data_atmm1 = rsp_img_1st_burst ? rsp_img_p1_data : rsp_img_p1_cache_data;
//: assign rsp_img_p0_data_atmm2 = rsp_img_1st_burst ? rsp_img_p2_data : rsp_img_p2_cache_data;
//: assign rsp_img_p0_data_atmm3 = rsp_img_1st_burst ? rsp_img_p3_data : rsp_img_p0_data;
//: // assign {mon_rsp_img_p0_data_d1_w, rsp_img_p0_data_d1_w} = ({rsp_img_p0_data_atmm3, rsp_img_p0_data_atmm2, rsp_img_p0_data_atmm1, rsp_img_p0_data_atmm0} >> {rsp_img_sft, 3'b0});
//: // assign {mon_rsp_img_p1_data_d1_w, rsp_img_p1_data_d1_w} = ({rsp_img_p0_data_atmm3, rsp_img_p0_data_atmm2, rsp_img_p0_data_atmm1, rsp_img_p0_data_atmm0} >> {rsp_img_sft, 3'b0});
//: // assign {mon_rsp_img_p2_data_d1_w, rsp_img_p2_data_d1_w} = ({rsp_img_p0_data_atmm3, rsp_img_p0_data_atmm2, rsp_img_p0_data_atmm1, rsp_img_p0_data_atmm0} >> {rsp_img_sft, 3'b0});
//: // assign {mon_rsp_img_p3_data_d1_w, rsp_img_p3_data_d1_w} = ({rsp_img_p3_data, rsp_img_p2_data, rsp_img_p1_data, rsp_img_p0_data}    >> {rsp_img_sft, 3'b0});
//:
//: assign rsp_img_planar_idx_add = rsp_img_p3_vld_d1_w ? 3'h4 : rsp_img_p2_vld_d1_w ? 3'h3 : rsp_img_p1_vld_d1_w ? 3'h2 : 3'h1;
//: );
//: }
//: foreach my $i(0..$atmm_num -1) {
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"rsp_img_p${i}_vld_d1_w\" -q rsp_img_p${i}_vld_d1");
//: &eperl::flop("-nodeclare  -norst -en \"rsp_img_p${i}_vld_d1_w\" -d \"rsp_img_p${i}_data_d1_w\" -q rsp_img_p${i}_data_d1");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign rsp_img_p0_vld_d1_w = rsp_img_p0_vld & (~rsp_img_1st_burst);

assign rsp_img_p0_data_atmm0 = rsp_img_p0_data;
assign {mon_rsp_img_p0_data_d1_w, rsp_img_p0_data_d1_w} = ({rsp_img_p0_data_atmm0,(rsp_img_c0l0_wr_en ? rsp_img_p0_cache_data : rsp_img_p1_cache_data)} >> {rsp_img_sft, 3'b0});

assign rsp_img_planar_idx_add = 3'h1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p0_vld_d1 <= 1'b0;
   end else begin
       rsp_img_p0_vld_d1 <= rsp_img_p0_vld_d1_w;
   end
end
always @(posedge nvdla_core_clk) begin
       if ((rsp_img_p0_vld_d1_w) == 1'b1) begin
           rsp_img_p0_data_d1 <= rsp_img_p0_data_d1_w;
       // VCS coverage off
       end else if ((rsp_img_p0_vld_d1_w) == 1'b0) begin
       end else begin
           rsp_img_p0_data_d1 <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//assign rsp_img_p0_data_atmm0 = rsp_img_1st_burst ? rsp_img_p0_data : rsp_img_p0_cache_data;
//assign rsp_img_p0_data_atmm1 = rsp_img_1st_burst ? rsp_img_p1_data : rsp_img_p0_data;
//assign {mon_rsp_img_p0_data_d1_w, rsp_img_p0_data_d1_w} = ({rsp_img_p0_data_atmm1, rsp_img_p0_data_atmm0} >> {rsp_img_sft, 3'b0});
//assign {mon_rsp_img_p1_data_d1_w, rsp_img_p1_data_d1_w} = ({rsp_img_p1_data, rsp_img_p0_data} >> {rsp_img_sft, 3'b0});
assign rsp_img_sft = rsp_img_planar ? pixel_planar1_byte_sft : pixel_planar0_byte_sft;
//////// data write control logic: normal write back ////////
//assign rsp_img_planar_idx_add = rsp_img_p1_vld_d1_w ? 2'h2 : 2'h1;
//: my $dmaif = 64;
//: my $atmm = (8*8);
//: my $atmm_num = ($dmaif / $atmm);
//: foreach my $i (0..$atmm_num -1) {
//: print qq(
//: assign rsp_img_p${i}_planar0_idx_inc = rsp_img_p${i}_planar0_idx + rsp_img_planar_idx_add;
//: assign rsp_img_p${i}_planar1_idx_inc = rsp_img_p${i}_planar1_idx + rsp_img_planar_idx_add;
//: assign rsp_img_p${i}_planar0_idx_w = is_first_running ? 7'b${i} : rsp_img_p${i}_planar0_idx_inc[8 -2:0];
//: assign rsp_img_p${i}_planar1_idx_w = is_first_running ? 7'b${i} : rsp_img_p${i}_planar1_idx_inc[8 -2:0];
//: assign rsp_img_p${i}_planar0_en = is_first_running | (rsp_img_p${i}_vld_d1_w & ~rsp_img_planar);
//: assign rsp_img_p${i}_planar1_en = is_first_running | (rsp_img_p${i}_vld_d1_w & rsp_img_planar);
//: assign rsp_img_p${i}_addr = (~rsp_img_planar) ? {1'b0, rsp_img_p${i}_planar0_idx[0], rsp_img_p${i}_planar0_idx[8 -2:1]} :
//: {1'b1, rsp_img_p${i}_planar1_idx[0], rsp_img_p${i}_planar1_idx[8 -2:1]};
//: );
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"rsp_img_p${i}_planar0_en\" -d \"rsp_img_p${i}_planar0_idx_w\" -q rsp_img_p${i}_planar0_idx");
//: &eperl::flop("-nodeclare   -rval \"{7{1'b0}}\"  -en \"rsp_img_p${i}_planar1_en\" -d \"rsp_img_p${i}_planar1_idx_w\" -q rsp_img_p${i}_planar1_idx");
//: &eperl::flop("-nodeclare   -rval \"{8{1'b0}}\"  -en \"rsp_img_p${i}_vld_d1_w\" -d \"rsp_img_p${i}_addr\" -q rsp_img_p${i}_addr_d1");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign rsp_img_p0_planar0_idx_inc = rsp_img_p0_planar0_idx + rsp_img_planar_idx_add;
assign rsp_img_p0_planar1_idx_inc = rsp_img_p0_planar1_idx + rsp_img_planar_idx_add;
assign rsp_img_p0_planar0_idx_w = is_first_running ? 7'b0 : rsp_img_p0_planar0_idx_inc[8 -2:0];
assign rsp_img_p0_planar1_idx_w = is_first_running ? 7'b0 : rsp_img_p0_planar1_idx_inc[8 -2:0];
assign rsp_img_p0_planar0_en = is_first_running | (rsp_img_p0_vld_d1_w & ~rsp_img_planar);
assign rsp_img_p0_planar1_en = is_first_running | (rsp_img_p0_vld_d1_w & rsp_img_planar);
assign rsp_img_p0_addr = (~rsp_img_planar) ? {1'b0, rsp_img_p0_planar0_idx[0], rsp_img_p0_planar0_idx[8 -2:1]} :
{1'b1, rsp_img_p0_planar1_idx[0], rsp_img_p0_planar1_idx[8 -2:1]};
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p0_planar0_idx <= {7{1'b0}};
   end else begin
       if ((rsp_img_p0_planar0_en) == 1'b1) begin
           rsp_img_p0_planar0_idx <= rsp_img_p0_planar0_idx_w;
       // VCS coverage off
       end else if ((rsp_img_p0_planar0_en) == 1'b0) begin
       end else begin
           rsp_img_p0_planar0_idx <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p0_planar1_idx <= {7{1'b0}};
   end else begin
       if ((rsp_img_p0_planar1_en) == 1'b1) begin
           rsp_img_p0_planar1_idx <= rsp_img_p0_planar1_idx_w;
       // VCS coverage off
       end else if ((rsp_img_p0_planar1_en) == 1'b0) begin
       end else begin
           rsp_img_p0_planar1_idx <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p0_addr_d1 <= {8{1'b0}};
   end else begin
       if ((rsp_img_p0_vld_d1_w) == 1'b1) begin
           rsp_img_p0_addr_d1 <= rsp_img_p0_addr;
       // VCS coverage off
       end else if ((rsp_img_p0_vld_d1_w) == 1'b0) begin
       end else begin
           rsp_img_p0_addr_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////// data write control logic: MISC output ////////
assign {mon_rsp_img_p0_burst_cnt_inc,
        rsp_img_p0_burst_cnt_inc} = rsp_img_p0_burst_cnt + rsp_img_w_burst_size[3:0] - rsp_img_line_st;
assign {mon_rsp_img_p1_burst_cnt_inc,
        rsp_img_p1_burst_cnt_inc} = rsp_img_p1_burst_cnt + rsp_img_w_burst_size - rsp_img_line_st;
assign rsp_img_p0_burst_cnt_w = is_first_running ? 4'b0 :
                                (rsp_img_vld & rsp_img_bundle_end) ? 4'b0 :
                                (~rsp_img_planar) ? rsp_img_p0_burst_cnt_inc : rsp_img_p0_burst_cnt;
assign rsp_img_p1_burst_cnt_w = is_first_running ? 5'b0 :
                                (rsp_img_vld & rsp_img_bundle_end) ? 5'b0 :
                                (rsp_img_planar) ? rsp_img_p1_burst_cnt_inc : rsp_img_p1_burst_cnt;
assign rsp_img_bundle_done = (rsp_img_vld & rsp_img_bundle_end);
assign rsp_img_p0_burst_size_w = ~rsp_img_planar ? rsp_img_p0_burst_cnt_inc : rsp_img_p0_burst_cnt;
assign rsp_img_p1_burst_size_w = rsp_img_p1_burst_cnt_inc;
assign rsp_img_p0_burst_cnt_en = is_first_running | (rsp_img_vld & rsp_img_req_end);
assign rsp_img_p1_burst_cnt_en = is_first_running | (rsp_img_vld & rsp_img_req_end & pixel_planar);
assign rsp_img_p0_burst_size_en = is_first_running | (rsp_img_vld & rsp_img_bundle_end);
assign rsp_img_p1_burst_size_en = is_first_running | (rsp_img_vld & rsp_img_bundle_end & pixel_planar);
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"rsp_img_p0_burst_cnt_en\" -d \"rsp_img_p0_burst_cnt_w\" -q rsp_img_p0_burst_cnt");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"rsp_img_p1_burst_cnt_en\" -d \"rsp_img_p1_burst_cnt_w\" -q rsp_img_p1_burst_cnt");
//: &eperl::flop("-nodeclare   -rval \"{4{1'b0}}\"  -en \"rsp_img_p0_burst_size_en\" -d \"rsp_img_p0_burst_size_w\" -q rsp_img_p0_burst_size_d1");
//: &eperl::flop("-nodeclare   -rval \"{5{1'b0}}\"  -en \"rsp_img_p1_burst_size_en\" -d \"rsp_img_p1_burst_size_w\" -q rsp_img_p1_burst_size_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"rsp_img_bundle_done\" -q rsp_img_bundle_done_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_bundle_done\" -d \"rsp_img_line_end\" -q rsp_img_line_end_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"rsp_img_bundle_done\" -d \"rsp_img_end\" -q rsp_img_layer_end_d1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p0_burst_cnt <= {4{1'b0}};
   end else begin
       if ((rsp_img_p0_burst_cnt_en) == 1'b1) begin
           rsp_img_p0_burst_cnt <= rsp_img_p0_burst_cnt_w;
       // VCS coverage off
       end else if ((rsp_img_p0_burst_cnt_en) == 1'b0) begin
       end else begin
           rsp_img_p0_burst_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p1_burst_cnt <= {5{1'b0}};
   end else begin
       if ((rsp_img_p1_burst_cnt_en) == 1'b1) begin
           rsp_img_p1_burst_cnt <= rsp_img_p1_burst_cnt_w;
       // VCS coverage off
       end else if ((rsp_img_p1_burst_cnt_en) == 1'b0) begin
       end else begin
           rsp_img_p1_burst_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p0_burst_size_d1 <= {4{1'b0}};
   end else begin
       if ((rsp_img_p0_burst_size_en) == 1'b1) begin
           rsp_img_p0_burst_size_d1 <= rsp_img_p0_burst_size_w;
       // VCS coverage off
       end else if ((rsp_img_p0_burst_size_en) == 1'b0) begin
       end else begin
           rsp_img_p0_burst_size_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_p1_burst_size_d1 <= {5{1'b0}};
   end else begin
       if ((rsp_img_p1_burst_size_en) == 1'b1) begin
           rsp_img_p1_burst_size_d1 <= rsp_img_p1_burst_size_w;
       // VCS coverage off
       end else if ((rsp_img_p1_burst_size_en) == 1'b0) begin
       end else begin
           rsp_img_p1_burst_size_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_bundle_done_d1 <= 1'b0;
   end else begin
       rsp_img_bundle_done_d1 <= rsp_img_bundle_done;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_line_end_d1 <= 1'b0;
   end else begin
       if ((rsp_img_bundle_done) == 1'b1) begin
           rsp_img_line_end_d1 <= rsp_img_line_end;
       // VCS coverage off
       end else if ((rsp_img_bundle_done) == 1'b0) begin
       end else begin
           rsp_img_line_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_layer_end_d1 <= 1'b0;
   end else begin
       if ((rsp_img_bundle_done) == 1'b1) begin
           rsp_img_layer_end_d1 <= rsp_img_end;
       // VCS coverage off
       end else if ((rsp_img_bundle_done) == 1'b0) begin
       end else begin
           rsp_img_layer_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////// data write control logic: status ////////
assign rsp_img_is_done_w = is_first_running ? 1'b0 :
                           (rsp_img_end & rsp_img_line_end) ? 1'b1 : rsp_img_is_done;
//: &eperl::flop("-nodeclare   -rval \"1'b1\"  -en \"is_running\" -d \"rsp_img_is_done_w\" -q rsp_img_is_done");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_img_is_done <= 1'b1;
   end else begin
       if ((is_running) == 1'b1) begin
           rsp_img_is_done <= rsp_img_is_done_w;
       // VCS coverage off
       end else if ((is_running) == 1'b0) begin
       end else begin
           rsp_img_is_done <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// Shared buffer write signals //
////////////////////////////////////////////////////////////////////////
//: my $dmaif = 64;
//: my $atmm = 8*8;
//: my $atmm_num = ($dmaif / $atmm);
//: foreach my $i (0..$atmm_num -1) {
//: print qq(
//: assign img2sbuf_p${i}_wr_addr = rsp_img_p${i}_addr_d1;
//: assign img2sbuf_p${i}_wr_data = rsp_img_p${i}_data_d1;
//: assign img2sbuf_p${i}_wr_en = rsp_img_p${i}_vld_d1;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign img2sbuf_p0_wr_addr = rsp_img_p0_addr_d1;
assign img2sbuf_p0_wr_data = rsp_img_p0_data_d1;
assign img2sbuf_p0_wr_en = rsp_img_p0_vld_d1;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//assign img2sbuf_p0_wr_en = rsp_img_p0_vld_d1;
//assign img2sbuf_p1_wr_en = rsp_img_p1_vld_d1;
//assign img2sbuf_p0_wr_addr = rsp_img_p0_addr_d1;
//assign img2sbuf_p1_wr_addr = rsp_img_p1_addr_d1;
//assign img2sbuf_p0_wr_data = rsp_img_p0_data_d1;
//assign img2sbuf_p1_wr_data = rsp_img_p1_data_d1;
////////////////////////////////////////////////////////////////////////
// Signal from SG to PACK //
////////////////////////////////////////////////////////////////////////
assign sg2pack_img_line_end = rsp_img_line_end_d1;
assign sg2pack_img_layer_end = rsp_img_layer_end_d1;
assign sg2pack_img_p0_burst = rsp_img_p0_burst_size_d1;
assign sg2pack_img_p1_burst = rsp_img_p1_burst_size_d1;
// PKT_PACK_WIRE( sg2pack_info , sg2pack_img_ , sg2pack_push_data )
assign sg2pack_push_data[3:0] = sg2pack_img_p0_burst[3:0];
assign sg2pack_push_data[8:4] = sg2pack_img_p1_burst[4:0];
assign sg2pack_push_data[9] = sg2pack_img_line_end ;
assign sg2pack_push_data[10] = sg2pack_img_layer_end ;
assign sg2pack_push_req = rsp_img_bundle_done_d1;
assign sg2pack_img_pvld = sg2pack_pop_req;
assign sg2pack_img_pd = sg2pack_pop_data;
assign sg2pack_pop_ready = sg2pack_img_prdy;
NV_NVDLA_CDMA_IMG_sg2pack_fifo u_NV_NVDLA_CDMA_IMG_sg2pack_fifo (
   .clk (nvdla_core_clk)
  ,.reset_ (nvdla_core_rstn)
  ,.wr_ready (sg2pack_push_ready)
  ,.wr_req (sg2pack_push_req)
  ,.wr_data (sg2pack_push_data[10:0])
  ,.rd_ready (sg2pack_pop_ready)
  ,.rd_req (sg2pack_pop_req)
  ,.rd_data (sg2pack_pop_data[10:0])
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  );
assign sg2pack_height_total = height_cnt_total;
assign sg2pack_mn_enable = mn_enable_d1;
assign sg2pack_data_entries = data_entries;
assign sg2pack_entry_st = pre_entry_st_d1;
assign sg2pack_entry_mid = pre_entry_mid_d1;
assign sg2pack_entry_end = pre_entry_end_d1;
assign sg2pack_sub_h_st = pre_sub_h_st_d1;
assign sg2pack_sub_h_mid = pre_sub_h_mid_d1;
assign sg2pack_sub_h_end = pre_sub_h_end_d1;
////////////////////////////////////////////////////////////////////////
// Global status //
////////////////////////////////////////////////////////////////////////
assign sg_is_done_w = ~is_first_running & req_is_done & rsp_img_is_done;
//: &eperl::flop("-nodeclare   -rval \"1'b1\"  -en \"is_running\" -d \"sg_is_done_w\" -q sg_is_done");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sg_is_done <= 1'b1;
   end else begin
       if ((is_running) == 1'b1) begin
           sg_is_done <= sg_is_done_w;
       // VCS coverage off
       end else if ((is_running) == 1'b0) begin
       end else begin
           sg_is_done <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// performance counting register //
////////////////////////////////////////////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        img_rd_stall_inc <= 1'b0;
    end else begin
        img_rd_stall_inc <= dma_rd_req_vld & ~dma_rd_req_rdy & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        img_rd_stall_clr <= 1'b0;
    end else begin
        img_rd_stall_clr <= status2dma_fsm_switch & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        img_rd_stall_cen <= 1'b0;
    end else begin
        img_rd_stall_cen <= reg2dp_op_en & reg2dp_dma_en;
    end
end
assign dp2reg_img_rd_stall_dec = 1'b0;
// stl adv logic
always @(*) begin
    stl_adv = img_rd_stall_inc ^ dp2reg_img_rd_stall_dec;
end
// stl cnt logic
always @(*) begin
// VCS sop_coverage_off start
    stl_cnt_ext[33:0] = {1'b0, 1'b0, stl_cnt_cur};
    stl_cnt_inc[33:0] = stl_cnt_cur + 1'b1; // spyglass disable W164b
    stl_cnt_dec[33:0] = stl_cnt_cur - 1'b1; // spyglass disable W164b
    stl_cnt_mod[33:0] = (img_rd_stall_inc && !dp2reg_img_rd_stall_dec)? stl_cnt_inc : (!img_rd_stall_inc && dp2reg_img_rd_stall_dec)? stl_cnt_dec : stl_cnt_ext;
    stl_cnt_new[33:0] = (stl_adv)? stl_cnt_mod[33:0] : stl_cnt_ext[33:0];
    stl_cnt_nxt[33:0] = (img_rd_stall_clr)? 34'd0 : stl_cnt_new[33:0];
// VCS sop_coverage_off end
end
// stl flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        stl_cnt_cur[31:0] <= 0;
    end else begin
        if (img_rd_stall_cen) begin
            stl_cnt_cur[31:0] <= stl_cnt_nxt[31:0];
        end
    end
end
// stl output logic
always @(*) begin
    dp2reg_img_rd_stall[31:0] = stl_cnt_cur[31:0];
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        img_rd_latency_inc <= 1'b0;
    end else begin
        img_rd_latency_inc <= dma_rd_req_vld & dma_rd_req_rdy & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        img_rd_latency_dec <= 1'b0;
    end else begin
        img_rd_latency_dec <= dma_rsp_fifo_ready & ~dma_rsp_dummy & reg2dp_dma_en;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        img_rd_latency_clr <= 1'b0;
    end else begin
        img_rd_latency_clr <= status2dma_fsm_switch;
    end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        img_rd_latency_cen <= 1'b0;
    end else begin
        img_rd_latency_cen <= reg2dp_op_en & reg2dp_dma_en;
    end
end
assign ltc_1_inc = (outs_dp2reg_img_rd_latency!=511) & img_rd_latency_inc;
assign ltc_1_dec = (outs_dp2reg_img_rd_latency!=511) & img_rd_latency_dec;
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
    ltc_1_cnt_nxt[10:0] = (img_rd_latency_clr)? 11'd0 : ltc_1_cnt_new[10:0];
// VCS sop_coverage_off end
end
// ltc_1 flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        ltc_1_cnt_cur[8:0] <= 0;
    end else begin
        if (img_rd_latency_cen) begin
            ltc_1_cnt_cur[8:0] <= ltc_1_cnt_nxt[8:0];
        end
    end
end
// ltc_1 output logic
always @(*) begin
    outs_dp2reg_img_rd_latency[8:0] = ltc_1_cnt_cur[8:0];
end
assign ltc_2_dec = 1'b0;
assign ltc_2_inc = (~&dp2reg_img_rd_latency) & (|outs_dp2reg_img_rd_latency);
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
    ltc_2_cnt_nxt[33:0] = (img_rd_latency_clr)? 34'd0 : ltc_2_cnt_new[33:0];
// VCS sop_coverage_off end
end
// ltc_2 flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        ltc_2_cnt_cur[31:0] <= 0;
    end else begin
        if (img_rd_latency_cen) begin
            ltc_2_cnt_cur[31:0] <= ltc_2_cnt_nxt[31:0];
        end
    end
end
// ltc_2 output logic
always @(*) begin
    dp2reg_img_rd_latency[31:0] = ltc_2_cnt_cur[31:0];
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
    property cdma_img_sg__img_read_response_block__0_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        (dma_rd_rsp_vld & ~dma_rd_rsp_rdy);
    endproperty
// Cover 0 : "(dma_rd_rsp_vld & ~dma_rd_rsp_rdy)"
    FUNCPOINT_cdma_img_sg__img_read_response_block__0_COV : cover property (cdma_img_sg__img_read_response_block__0_cov);
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_1x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_2x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_4x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_st))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_7x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_first_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_8x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_first_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_9x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_first_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_10x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_first_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_first_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_12x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_first_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_13x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_height_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_14x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_planar_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_15x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_p0_burst_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_16x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_p0_burst_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_17x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_p0_sec_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_20x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_p1_burst_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_21x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_p1_burst_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_22x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_p1_sec_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_27x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_height_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_28x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_height_en & planar1_enable))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_31x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_p0_burst_offset_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_32x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_img_p1_burst_offset_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_35x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_36x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_37x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_38x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_39x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_40x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_41x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_42x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_43x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_44x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_reg_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_46x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(img_entry_onfly_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_54x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(dma_rsp_vld))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_64x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_vld_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_65x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_vld_w & dma_rsp_fifo_ready))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_69x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_c0l0_wr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_70x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_c1l0_wr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_72x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p0_planar0_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_73x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p0_planar1_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_74x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p1_planar0_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_75x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p1_planar1_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_76x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p0_vld_d1_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_77x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p1_vld_d1_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_78x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p0_burst_cnt_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_79x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p1_burst_cnt_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_80x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p0_burst_size_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_81x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_p1_burst_size_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_82x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_bundle_done))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_83x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(rsp_img_bundle_done))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_87x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_91x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(is_running))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Config error! Pixel height offset is not zero!") zzz_assert_never_5x (nvdla_core_clk, `ASSERT_RESET, (is_running & (|reg2dp_pixel_y_offset))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error config! data_entries_w is much to big!") zzz_assert_never_6x (nvdla_core_clk, `ASSERT_RESET, (layer_st & mon_data_entries_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_img_p0_bundle_cnt_w is overflow!") zzz_assert_never_18x (nvdla_core_clk, `ASSERT_RESET, (req_img_p0_burst_en & mon_req_img_p0_bundle_cnt_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_img_p0_sec_cnt_w is overflow!") zzz_assert_never_19x (nvdla_core_clk, `ASSERT_RESET, (req_img_p0_burst_en & mon_req_img_p0_sec_cnt_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_img_p1_bundle_cnt_w is overflow!") zzz_assert_never_23x (nvdla_core_clk, `ASSERT_RESET, (req_img_p1_burst_en & mon_req_img_p1_bundle_cnt_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_img_p1_sec_cnt_w is overflow!") zzz_assert_never_24x (nvdla_core_clk, `ASSERT_RESET, (req_img_p1_burst_en & mon_req_img_p1_sec_cnt_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_reg_en set when not running!") zzz_assert_never_25x (nvdla_core_clk, `ASSERT_RESET, (~is_running & req_reg_en)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_valid set when not running!") zzz_assert_never_26x (nvdla_core_clk, `ASSERT_RESET, (~is_running & req_valid)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_img_p0_line_offset_w is overflow!") zzz_assert_never_29x (nvdla_core_clk, `ASSERT_RESET, (req_height_en & mon_req_img_p0_line_offset_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_img_p1_line_offset_w is overflow!") zzz_assert_never_30x (nvdla_core_clk, `ASSERT_RESET, (req_height_en & planar1_enable & mon_req_img_p1_line_offset_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_img_p0_burst_offset_w is overflow!") zzz_assert_never_33x (nvdla_core_clk, `ASSERT_RESET, (req_img_p0_burst_offset_en & mon_req_img_p0_burst_offset_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_img_p1_burst_offset_w is overflow!") zzz_assert_never_34x (nvdla_core_clk, `ASSERT_RESET, (req_img_p1_burst_offset_en & mon_req_img_p1_burst_offset_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! req_size_out is overflow!") zzz_assert_never_45x (nvdla_core_clk, `ASSERT_RESET, (req_reg_en & mon_req_size_out)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! total_required_entry is overflow!") zzz_assert_never_47x (nvdla_core_clk, `ASSERT_RESET, (mon_total_required_entry & ~is_cbuf_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! total_required_entry is out of range!") zzz_assert_never_48x (nvdla_core_clk, `ASSERT_RESET, ((total_required_entry > 3840) & ~req_is_done_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! img_entry_onfly_w is overflow!") zzz_assert_never_49x (nvdla_core_clk, `ASSERT_RESET, (mon_img_entry_onfly_w)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! img_entry_onfly_w is out of range!") zzz_assert_never_50x (nvdla_core_clk, `ASSERT_RESET, (img_entry_onfly_w > 3840)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! img_entry_onfly is not empty when idle!") zzz_assert_never_51x (nvdla_core_clk, `ASSERT_RESET, (~is_running & (|img_entry_onfly))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! Receive input data when not busy") zzz_assert_never_53x (nvdla_core_clk, `ASSERT_RESET, (dma_rd_rsp_vld & ~is_running)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"response fifo pop error") zzz_assert_never_55x (nvdla_core_clk, `ASSERT_RESET, (dma_rsp_fifo_ready & ~dma_rsp_fifo_req)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"response fifo idle when data return") zzz_assert_never_56x (nvdla_core_clk, `ASSERT_RESET, (dma_rd_rsp_vld & ~dma_rsp_fifo_req)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"response size mismatch") zzz_assert_never_57x (nvdla_core_clk, `ASSERT_RESET, (dma_rsp_size_cnt_inc > dma_rsp_size)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! dma_rsp_size_cnt_inc is overflow") zzz_assert_never_58x (nvdla_core_clk, `ASSERT_RESET, (mon_dma_rsp_size_cnt_inc)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! dma_rsp_size_cnt_inc is out of range") zzz_assert_never_59x (nvdla_core_clk, `ASSERT_RESET, (dma_rsp_size_cnt_inc > 6'h30)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! Data input when idle!") zzz_assert_never_60x (nvdla_core_clk, `ASSERT_RESET, (~is_running & dma_rd_rsp_vld)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_img_p1_vld_d1 valid when rsp_img_p0_vld_d1 not!") zzz_assert_never_71x (nvdla_core_clk, `ASSERT_RESET, (~rsp_img_p0_vld_d1 & rsp_img_p1_vld_d1)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_img_p0_burst_cnt_inc is overflow!") zzz_assert_never_84x (nvdla_core_clk, `ASSERT_RESET, (rsp_img_p0_burst_cnt_en & mon_rsp_img_p0_burst_cnt_inc & ~rsp_img_planar)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_img_p1_burst_cnt_inc is overflow!") zzz_assert_never_85x (nvdla_core_clk, `ASSERT_RESET, (rsp_img_p1_burst_cnt_en & mon_rsp_img_p1_burst_cnt_inc)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_img_w_burst_size is out of range when planar0!") zzz_assert_never_86x (nvdla_core_clk, `ASSERT_RESET, (rsp_img_p0_burst_cnt_en & rsp_img_w_burst_size[4] & ~rsp_img_planar)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! rsp_img_is_done is 0 when not busy!") zzz_assert_never_88x (nvdla_core_clk, `ASSERT_RESET, (~is_running & ~rsp_img_is_done)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! sg2pack_fifo push block!") zzz_assert_never_89x (nvdla_core_clk, `ASSERT_RESET, (sg2pack_push_req & ~sg2pack_push_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! sg2pack_fifo pop invalid!") zzz_assert_never_90x (nvdla_core_clk, `ASSERT_RESET, (~sg2pack_pop_req & sg2pack_pop_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! sg_is_done is 0 when not busy!") zzz_assert_never_92x (nvdla_core_clk, `ASSERT_RESET, (~is_running & ~sg_is_done)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"never: counter overflow beyond <ovr_cnt>") zzz_assert_never_93x (nvdla_core_clk, `ASSERT_RESET, (ltc_1_cnt_nxt > 511 && img_rd_latency_cen)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDMA_IMG_sg
