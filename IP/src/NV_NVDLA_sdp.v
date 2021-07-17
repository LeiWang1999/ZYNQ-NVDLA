// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_sdp.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_define.h
module NV_NVDLA_sdp (
   cacc2sdp_pd //|< i
  ,cacc2sdp_valid //|< i
  ,cacc2sdp_ready //|> o
  ,csb2sdp_rdma_req_pd //|< i
  ,csb2sdp_rdma_req_pvld //|< i
  ,csb2sdp_req_pd //|< i
  ,csb2sdp_req_pvld //|< i
  ,dla_clk_ovr_on_sync //|< i
  ,global_clk_ovr_on_sync //|< i
  ,sdp_b2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_b2mcif_rd_req_pd //|> o
  ,sdp_b2mcif_rd_req_valid //|> o
  ,sdp_b2mcif_rd_req_ready //|< i
  ,mcif2sdp_b_rd_rsp_pd //|< i
  ,mcif2sdp_b_rd_rsp_valid //|< i
  ,mcif2sdp_b_rd_rsp_ready //|> o
  ,sdp_n2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_n2mcif_rd_req_pd //|> o
  ,sdp_n2mcif_rd_req_valid //|> o
  ,sdp_n2mcif_rd_req_ready //|< i
  ,mcif2sdp_n_rd_rsp_pd //|< i
  ,mcif2sdp_n_rd_rsp_valid //|< i
  ,mcif2sdp_n_rd_rsp_ready //|> o
  ,sdp2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp2mcif_rd_req_pd //|> o
  ,sdp2mcif_rd_req_valid //|> o
  ,sdp2mcif_rd_req_ready //|< i
  ,mcif2sdp_rd_rsp_pd //|< i
  ,mcif2sdp_rd_rsp_valid //|< i
  ,mcif2sdp_rd_rsp_ready //|> o
  ,sdp2mcif_wr_req_pd //|> o
  ,sdp2mcif_wr_req_valid //|> o
  ,sdp2mcif_wr_req_ready //|< i
  ,mcif2sdp_wr_rsp_complete //|< i
  ,nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,sdp2glb_done_intr_pd //|> o
  ,csb2sdp_rdma_req_prdy //|> o
  ,csb2sdp_req_prdy //|> o
  ,sdp2csb_resp_pd //|> o
  ,sdp2csb_resp_valid //|> o
  ,sdp_rdma2csb_resp_pd //|> o
  ,sdp_rdma2csb_resp_valid //|> o
  ,sdp2pdp_pd //|> o
  ,sdp2pdp_valid //|> o
  ,sdp2pdp_ready //|< i
  );
//
// NV_NVDLA_sdp_ports.v
//
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input dla_clk_ovr_on_sync;
input global_clk_ovr_on_sync;
input tmc2slcg_disable_clock_gating;
input cacc2sdp_valid;
output cacc2sdp_ready;
input [32*1 +1:0] cacc2sdp_pd;
output sdp2pdp_valid;
input sdp2pdp_ready;
output [8*1 -1:0] sdp2pdp_pd;
output [1:0] sdp2glb_done_intr_pd;
input csb2sdp_rdma_req_pvld;
output csb2sdp_rdma_req_prdy;
input [62:0] csb2sdp_rdma_req_pd;
output sdp_rdma2csb_resp_valid;
output [33:0] sdp_rdma2csb_resp_pd;
input csb2sdp_req_pvld;
output csb2sdp_req_prdy;
input [62:0] csb2sdp_req_pd;
output sdp2csb_resp_valid;
output [33:0] sdp2csb_resp_pd;
output sdp_b2mcif_rd_cdt_lat_fifo_pop;
output sdp_b2mcif_rd_req_valid;
input sdp_b2mcif_rd_req_ready;
output [47 -1:0] sdp_b2mcif_rd_req_pd;
input mcif2sdp_b_rd_rsp_valid;
output mcif2sdp_b_rd_rsp_ready;
input [65 -1:0] mcif2sdp_b_rd_rsp_pd;
output sdp_n2mcif_rd_cdt_lat_fifo_pop;
output sdp_n2mcif_rd_req_valid;
input sdp_n2mcif_rd_req_ready;
output [47 -1:0] sdp_n2mcif_rd_req_pd;
input mcif2sdp_n_rd_rsp_valid;
output mcif2sdp_n_rd_rsp_ready;
input [65 -1:0] mcif2sdp_n_rd_rsp_pd;
output sdp2mcif_rd_cdt_lat_fifo_pop;
output sdp2mcif_rd_req_valid;
input sdp2mcif_rd_req_ready;
output [47 -1:0] sdp2mcif_rd_req_pd;
input mcif2sdp_rd_rsp_valid;
output mcif2sdp_rd_rsp_ready;
input [65 -1:0] mcif2sdp_rd_rsp_pd;
output sdp2mcif_wr_req_valid;
input sdp2mcif_wr_req_ready;
output [66 -1:0] sdp2mcif_wr_req_pd;
input mcif2sdp_wr_rsp_complete;
wire dp2reg_done;
wire [31:0] dp2reg_out_saturation;
wire [31:0] dp2reg_status_nan_output_num;
wire [0:0] dp2reg_status_unequal;
wire [31:0] dp2reg_wdma_stall;
wire [4:0] reg2dp_batch_number;
wire reg2dp_bcore_slcg_op_en;
wire reg2dp_flying_mode;
wire [12:0] reg2dp_height;
wire reg2dp_interrupt_ptr;
wire [1:0] reg2dp_bn_alu_algo;
wire reg2dp_bn_alu_bypass;
wire [15:0] reg2dp_bn_alu_operand;
wire [5:0] reg2dp_bn_alu_shift_value;
wire reg2dp_bn_alu_src;
wire reg2dp_bn_bypass;
wire reg2dp_bn_mul_bypass;
wire [15:0] reg2dp_bn_mul_operand;
wire reg2dp_bn_mul_prelu;
wire [7:0] reg2dp_bn_mul_shift_value;
wire reg2dp_bn_mul_src;
wire reg2dp_bn_relu_bypass;
wire [1:0] reg2dp_bs_alu_algo;
wire reg2dp_bs_alu_bypass;
wire [15:0] reg2dp_bs_alu_operand;
wire [5:0] reg2dp_bs_alu_shift_value;
wire reg2dp_bs_alu_src;
wire reg2dp_bs_bypass;
wire reg2dp_bs_mul_bypass;
wire [15:0] reg2dp_bs_mul_operand;
wire reg2dp_bs_mul_prelu;
wire [7:0] reg2dp_bs_mul_shift_value;
wire reg2dp_bs_mul_src;
wire reg2dp_bs_relu_bypass;
wire [12:0] reg2dp_channel;
wire [31:0] reg2dp_cvt_offset;
wire [15:0] reg2dp_cvt_scale;
wire [5:0] reg2dp_cvt_shift;
wire [31:0] reg2dp_dst_base_addr_high;
wire [31:0] reg2dp_dst_base_addr_low;
wire [31:0] reg2dp_dst_batch_stride;
wire [31:0] reg2dp_dst_line_stride;
wire reg2dp_dst_ram_type;
wire [31:0] reg2dp_dst_surface_stride;
wire reg2dp_ecore_slcg_op_en;
wire reg2dp_nan_to_zero;
wire reg2dp_ncore_slcg_op_en;
wire reg2dp_op_en;
wire [1:0] reg2dp_out_precision;
wire reg2dp_output_dst;
wire reg2dp_perf_dma_en;
wire reg2dp_perf_lut_en;
wire reg2dp_perf_sat_en;
wire [1:0] reg2dp_proc_precision;
wire reg2dp_wdma_slcg_op_en;
wire [12:0] reg2dp_width;
wire reg2dp_winograd;
wire [32*8 +1:0] sdp_mrdma2cmux_pd;
wire sdp_mrdma2cmux_ready;
wire sdp_mrdma2cmux_valid;
wire sdp_dp2wdma_ready;
wire sdp_dp2wdma_valid;
wire [8*8 -1:0] sdp_dp2wdma_pd;
wire [8*16:0] sdp_brdma2dp_alu_pd;
wire sdp_brdma2dp_alu_ready;
wire sdp_brdma2dp_alu_valid;
wire [8*16:0] sdp_brdma2dp_mul_pd;
wire sdp_brdma2dp_mul_ready;
wire sdp_brdma2dp_mul_valid;
wire [8*16:0] sdp_nrdma2dp_alu_pd;
wire sdp_nrdma2dp_alu_ready;
wire sdp_nrdma2dp_alu_valid;
wire [8*16:0] sdp_nrdma2dp_mul_pd;
wire sdp_nrdma2dp_mul_ready;
wire sdp_nrdma2dp_mul_valid;
//=======================================
//DMA
//---------------------------------------
NV_NVDLA_SDP_rdma u_rdma (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd[62:0])
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd[33:0])
  ,.sdp_mrdma2cmux_valid (sdp_mrdma2cmux_valid)
  ,.sdp_mrdma2cmux_ready (sdp_mrdma2cmux_ready)
  ,.sdp_mrdma2cmux_pd (sdp_mrdma2cmux_pd[32*8 +1:0])
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd[47 -1:0])
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd[65 -1:0])
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd[47 -1:0])
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd[65 -1:0])
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd[47 -1:0])
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd[65 -1:0])
  ,.sdp_brdma2dp_alu_valid (sdp_brdma2dp_alu_valid)
  ,.sdp_brdma2dp_alu_ready (sdp_brdma2dp_alu_ready)
  ,.sdp_brdma2dp_alu_pd (sdp_brdma2dp_alu_pd[8*16:0])
  ,.sdp_brdma2dp_mul_valid (sdp_brdma2dp_mul_valid)
  ,.sdp_brdma2dp_mul_ready (sdp_brdma2dp_mul_ready)
  ,.sdp_brdma2dp_mul_pd (sdp_brdma2dp_mul_pd[8*16:0])
  ,.sdp_nrdma2dp_alu_valid (sdp_nrdma2dp_alu_valid)
  ,.sdp_nrdma2dp_alu_ready (sdp_nrdma2dp_alu_ready)
  ,.sdp_nrdma2dp_alu_pd (sdp_nrdma2dp_alu_pd[8*16:0])
  ,.sdp_nrdma2dp_mul_valid (sdp_nrdma2dp_mul_valid)
  ,.sdp_nrdma2dp_mul_ready (sdp_nrdma2dp_mul_ready)
  ,.sdp_nrdma2dp_mul_pd (sdp_nrdma2dp_mul_pd[8*16:0])
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  );
NV_NVDLA_SDP_wdma u_wdma (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd[1:0])
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd[66 -1:0])
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.sdp_dp2wdma_valid (sdp_dp2wdma_valid)
  ,.sdp_dp2wdma_ready (sdp_dp2wdma_ready)
  ,.sdp_dp2wdma_pd (sdp_dp2wdma_pd[8*8 -1:0])
  ,.reg2dp_ew_alu_algo ( 2'b0 ) //reg2dp_ew_alu_algo[1:0])               
  ,.reg2dp_ew_alu_bypass ( 1'b1 ) //reg2dp_ew_alu_bypass)                  
  ,.reg2dp_ew_bypass ( 1'b1 ) //reg2dp_ew_bypass)                      
  ,.reg2dp_op_en (reg2dp_op_en)
  ,.reg2dp_wdma_slcg_op_en (reg2dp_wdma_slcg_op_en)
  ,.reg2dp_output_dst (reg2dp_output_dst)
  ,.reg2dp_batch_number (reg2dp_batch_number[4:0])
  ,.reg2dp_winograd (reg2dp_winograd)
  ,.reg2dp_channel (reg2dp_channel[12:0])
  ,.reg2dp_height (reg2dp_height[12:0])
  ,.reg2dp_width (reg2dp_width[12:0])
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0])
  ,.reg2dp_out_precision (reg2dp_out_precision[1:0])
  ,.reg2dp_dst_ram_type (reg2dp_dst_ram_type)
  ,.reg2dp_dst_base_addr_high (reg2dp_dst_base_addr_high[31:0])
  ,.reg2dp_dst_base_addr_low (reg2dp_dst_base_addr_low[31:3])
  ,.reg2dp_dst_batch_stride (reg2dp_dst_batch_stride[31:3])
  ,.reg2dp_dst_line_stride (reg2dp_dst_line_stride[31:3])
  ,.reg2dp_dst_surface_stride (reg2dp_dst_surface_stride[31:3])
  ,.reg2dp_interrupt_ptr (reg2dp_interrupt_ptr)
  ,.reg2dp_perf_dma_en (reg2dp_perf_dma_en)
  ,.dp2reg_done (dp2reg_done)
  ,.dp2reg_status_nan_output_num (dp2reg_status_nan_output_num[31:0])
  ,.dp2reg_status_unequal (dp2reg_status_unequal)
  ,.dp2reg_wdma_stall (dp2reg_wdma_stall[31:0])
  );
//========================================
//SDP core instance
//----------------------------------------
NV_NVDLA_SDP_core u_core (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd[32*1 +1:0])
  ,.sdp_mrdma2cmux_valid (sdp_mrdma2cmux_valid)
  ,.sdp_mrdma2cmux_ready (sdp_mrdma2cmux_ready)
  ,.sdp_mrdma2cmux_pd (sdp_mrdma2cmux_pd[32*8 +1:0])
  ,.sdp_brdma2dp_mul_valid (sdp_brdma2dp_mul_valid)
  ,.sdp_brdma2dp_mul_ready (sdp_brdma2dp_mul_ready)
  ,.sdp_brdma2dp_mul_pd (sdp_brdma2dp_mul_pd[8*16:0])
  ,.sdp_brdma2dp_alu_valid (sdp_brdma2dp_alu_valid)
  ,.sdp_brdma2dp_alu_ready (sdp_brdma2dp_alu_ready)
  ,.sdp_brdma2dp_alu_pd (sdp_brdma2dp_alu_pd[8*16:0])
  ,.sdp_nrdma2dp_mul_valid (sdp_nrdma2dp_mul_valid)
  ,.sdp_nrdma2dp_mul_ready (sdp_nrdma2dp_mul_ready)
  ,.sdp_nrdma2dp_mul_pd (sdp_nrdma2dp_mul_pd[8*16:0])
  ,.sdp_nrdma2dp_alu_valid (sdp_nrdma2dp_alu_valid)
  ,.sdp_nrdma2dp_alu_ready (sdp_nrdma2dp_alu_ready)
  ,.sdp_nrdma2dp_alu_pd (sdp_nrdma2dp_alu_pd[8*16:0])
  ,.sdp_dp2wdma_valid (sdp_dp2wdma_valid)
  ,.sdp_dp2wdma_ready (sdp_dp2wdma_ready)
  ,.sdp_dp2wdma_pd (sdp_dp2wdma_pd[8*8 -1:0])
  ,.sdp2pdp_valid (sdp2pdp_valid)
  ,.sdp2pdp_ready (sdp2pdp_ready)
  ,.sdp2pdp_pd (sdp2pdp_pd[8*1 -1:0])
  ,.reg2dp_ncore_slcg_op_en (reg2dp_ncore_slcg_op_en)
  ,.reg2dp_bn_alu_algo (reg2dp_bn_alu_algo[1:0])
  ,.reg2dp_bn_alu_bypass (reg2dp_bn_alu_bypass)
  ,.reg2dp_bn_alu_operand (reg2dp_bn_alu_operand[15:0])
  ,.reg2dp_bn_alu_shift_value (reg2dp_bn_alu_shift_value[5:0])
  ,.reg2dp_bn_alu_src (reg2dp_bn_alu_src)
  ,.reg2dp_bn_bypass (reg2dp_bn_bypass)
  ,.reg2dp_bn_mul_bypass (reg2dp_bn_mul_bypass)
  ,.reg2dp_bn_mul_operand (reg2dp_bn_mul_operand[15:0])
  ,.reg2dp_bn_mul_prelu (reg2dp_bn_mul_prelu)
  ,.reg2dp_bn_mul_shift_value (reg2dp_bn_mul_shift_value[7:0])
  ,.reg2dp_bn_mul_src (reg2dp_bn_mul_src)
  ,.reg2dp_bn_relu_bypass (reg2dp_bn_relu_bypass)
  ,.reg2dp_bcore_slcg_op_en (reg2dp_bcore_slcg_op_en)
  ,.reg2dp_bs_alu_algo (reg2dp_bs_alu_algo[1:0])
  ,.reg2dp_bs_alu_bypass (reg2dp_bs_alu_bypass)
  ,.reg2dp_bs_alu_operand (reg2dp_bs_alu_operand[15:0])
  ,.reg2dp_bs_alu_shift_value (reg2dp_bs_alu_shift_value[5:0])
  ,.reg2dp_bs_alu_src (reg2dp_bs_alu_src)
  ,.reg2dp_bs_bypass (reg2dp_bs_bypass)
  ,.reg2dp_bs_mul_bypass (reg2dp_bs_mul_bypass)
  ,.reg2dp_bs_mul_operand (reg2dp_bs_mul_operand[15:0])
  ,.reg2dp_bs_mul_prelu (reg2dp_bs_mul_prelu)
  ,.reg2dp_bs_mul_shift_value (reg2dp_bs_mul_shift_value[7:0])
  ,.reg2dp_bs_mul_src (reg2dp_bs_mul_src)
  ,.reg2dp_bs_relu_bypass (reg2dp_bs_relu_bypass)
  ,.reg2dp_ecore_slcg_op_en (reg2dp_ecore_slcg_op_en)
  ,.reg2dp_cvt_offset (reg2dp_cvt_offset[31:0])
  ,.reg2dp_cvt_scale (reg2dp_cvt_scale[15:0])
  ,.reg2dp_cvt_shift (reg2dp_cvt_shift[5:0])
  ,.reg2dp_op_en (reg2dp_op_en)
  ,.reg2dp_flying_mode (reg2dp_flying_mode)
  ,.reg2dp_output_dst (reg2dp_output_dst)
  ,.reg2dp_nan_to_zero (reg2dp_nan_to_zero)
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0])
  ,.reg2dp_out_precision (reg2dp_out_precision[1:0])
  ,.reg2dp_perf_lut_en (reg2dp_perf_lut_en)
  ,.reg2dp_perf_sat_en (reg2dp_perf_sat_en)
  ,.dp2reg_done (dp2reg_done)
  ,.dp2reg_out_saturation (dp2reg_out_saturation[31:0])
  );
//=======================================
//CONFIG instance
//rdma has seperate config register, while wdma share with core
//---------------------------------------
NV_NVDLA_SDP_reg u_reg (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.csb2sdp_req_pd (csb2sdp_req_pd[62:0])
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd[33:0])
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.dp2reg_done (dp2reg_done)
  ,.dp2reg_out_saturation (dp2reg_out_saturation[31:0])
  ,.dp2reg_status_inf_input_num ({32{1'b0}})
  ,.dp2reg_status_nan_input_num ({32{1'b0}})
  ,.dp2reg_status_nan_output_num (dp2reg_status_nan_output_num[31:0])
  ,.dp2reg_status_unequal (dp2reg_status_unequal[0])
  ,.dp2reg_wdma_stall (dp2reg_wdma_stall[31:0])
  ,.reg2dp_ncore_slcg_op_en (reg2dp_ncore_slcg_op_en)
  ,.reg2dp_bn_alu_algo (reg2dp_bn_alu_algo[1:0])
  ,.reg2dp_bn_alu_bypass (reg2dp_bn_alu_bypass)
  ,.reg2dp_bn_alu_operand (reg2dp_bn_alu_operand[15:0])
  ,.reg2dp_bn_alu_shift_value (reg2dp_bn_alu_shift_value[5:0])
  ,.reg2dp_bn_alu_src (reg2dp_bn_alu_src)
  ,.reg2dp_bn_bypass (reg2dp_bn_bypass)
  ,.reg2dp_bn_mul_bypass (reg2dp_bn_mul_bypass)
  ,.reg2dp_bn_mul_operand (reg2dp_bn_mul_operand[15:0])
  ,.reg2dp_bn_mul_prelu (reg2dp_bn_mul_prelu)
  ,.reg2dp_bn_mul_shift_value (reg2dp_bn_mul_shift_value[7:0])
  ,.reg2dp_bn_mul_src (reg2dp_bn_mul_src)
  ,.reg2dp_bn_relu_bypass (reg2dp_bn_relu_bypass)
  ,.reg2dp_bcore_slcg_op_en (reg2dp_bcore_slcg_op_en)
  ,.reg2dp_bs_alu_algo (reg2dp_bs_alu_algo[1:0])
  ,.reg2dp_bs_alu_bypass (reg2dp_bs_alu_bypass)
  ,.reg2dp_bs_alu_operand (reg2dp_bs_alu_operand[15:0])
  ,.reg2dp_bs_alu_shift_value (reg2dp_bs_alu_shift_value[5:0])
  ,.reg2dp_bs_alu_src (reg2dp_bs_alu_src)
  ,.reg2dp_bs_bypass (reg2dp_bs_bypass)
  ,.reg2dp_bs_mul_bypass (reg2dp_bs_mul_bypass)
  ,.reg2dp_bs_mul_operand (reg2dp_bs_mul_operand[15:0])
  ,.reg2dp_bs_mul_prelu (reg2dp_bs_mul_prelu)
  ,.reg2dp_bs_mul_shift_value (reg2dp_bs_mul_shift_value[7:0])
  ,.reg2dp_bs_mul_src (reg2dp_bs_mul_src)
  ,.reg2dp_bs_relu_bypass (reg2dp_bs_relu_bypass)
  ,.reg2dp_ecore_slcg_op_en (reg2dp_ecore_slcg_op_en)
  ,.reg2dp_cvt_offset (reg2dp_cvt_offset[31:0])
  ,.reg2dp_cvt_scale (reg2dp_cvt_scale[15:0])
  ,.reg2dp_cvt_shift (reg2dp_cvt_shift[5:0])
  ,.reg2dp_wdma_slcg_op_en (reg2dp_wdma_slcg_op_en)
  ,.reg2dp_op_en (reg2dp_op_en)
  ,.reg2dp_flying_mode (reg2dp_flying_mode)
  ,.reg2dp_output_dst (reg2dp_output_dst)
  ,.reg2dp_batch_number (reg2dp_batch_number[4:0])
  ,.reg2dp_winograd (reg2dp_winograd)
  ,.reg2dp_channel (reg2dp_channel[12:0])
  ,.reg2dp_height (reg2dp_height[12:0])
  ,.reg2dp_width (reg2dp_width[12:0])
  ,.reg2dp_dst_ram_type (reg2dp_dst_ram_type)
  ,.reg2dp_dst_base_addr_high (reg2dp_dst_base_addr_high[31:0])
  ,.reg2dp_dst_base_addr_low (reg2dp_dst_base_addr_low[31:0])
  ,.reg2dp_dst_batch_stride (reg2dp_dst_batch_stride[31:0])
  ,.reg2dp_dst_line_stride (reg2dp_dst_line_stride[31:0])
  ,.reg2dp_dst_surface_stride (reg2dp_dst_surface_stride[31:0])
  ,.reg2dp_nan_to_zero (reg2dp_nan_to_zero)
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0])
  ,.reg2dp_out_precision (reg2dp_out_precision[1:0])
  ,.reg2dp_interrupt_ptr (reg2dp_interrupt_ptr)
  ,.reg2dp_perf_dma_en (reg2dp_perf_dma_en)
  ,.reg2dp_perf_lut_en (reg2dp_perf_lut_en)
  ,.reg2dp_perf_nan_inf_count_en ()
  ,.reg2dp_perf_sat_en (reg2dp_perf_sat_en)
  );
endmodule // NV_NVDLA_sdp
