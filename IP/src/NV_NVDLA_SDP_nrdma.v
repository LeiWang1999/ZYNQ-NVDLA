// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_nrdma.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_define.h
module NV_NVDLA_SDP_nrdma (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,dla_clk_ovr_on_sync //|< i
  ,global_clk_ovr_on_sync //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,nrdma_disable //|< i
  ,nrdma_slcg_op_en //|< i
  ,sdp_n2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_n2mcif_rd_req_pd //|> o
  ,sdp_n2mcif_rd_req_valid //|> o
  ,sdp_n2mcif_rd_req_ready //|< i
  ,mcif2sdp_n_rd_rsp_pd //|< i
  ,mcif2sdp_n_rd_rsp_valid //|< i
  ,mcif2sdp_n_rd_rsp_ready //|> o
  ,reg2dp_bn_base_addr_high //|< i
  ,reg2dp_bn_base_addr_low //|< i
  ,reg2dp_bn_line_stride //|< i
  ,reg2dp_bn_surface_stride //|< i
  ,reg2dp_nrdma_data_mode //|< i
  ,reg2dp_nrdma_data_size //|< i
  ,reg2dp_nrdma_data_use //|< i
  ,reg2dp_nrdma_ram_type //|< i
  ,reg2dp_batch_number //|< i
  ,reg2dp_channel //|< i
  ,reg2dp_height //|< i
  ,reg2dp_width //|< i
  ,reg2dp_op_en //|< i
  ,reg2dp_out_precision //|< i
  ,reg2dp_perf_dma_en //|< i
  ,reg2dp_proc_precision //|< i
  ,reg2dp_winograd //|< i
  ,dp2reg_nrdma_stall //|> o
  ,dp2reg_done //|> o
  ,sdp_nrdma2dp_alu_ready //|< i
  ,sdp_nrdma2dp_mul_ready //|< i
  ,sdp_nrdma2dp_alu_pd //|> o
  ,sdp_nrdma2dp_alu_valid //|> o
  ,sdp_nrdma2dp_mul_pd //|> o
  ,sdp_nrdma2dp_mul_valid //|> o
  );
//
// NV_NVDLA_SDP_nrdma_ports.v
//
 input nvdla_core_clk;
 input nvdla_core_rstn;
 input [31:0] pwrbus_ram_pd;
 output sdp_n2mcif_rd_req_valid;
 input sdp_n2mcif_rd_req_ready;
 output [47 -1:0] sdp_n2mcif_rd_req_pd;
 input mcif2sdp_n_rd_rsp_valid;
 output mcif2sdp_n_rd_rsp_ready;
 input [65 -1:0] mcif2sdp_n_rd_rsp_pd;
 output sdp_n2mcif_rd_cdt_lat_fifo_pop;
 output sdp_nrdma2dp_alu_valid;
 input sdp_nrdma2dp_alu_ready;
 output [8*16:0] sdp_nrdma2dp_alu_pd;
 output sdp_nrdma2dp_mul_valid;
 input sdp_nrdma2dp_mul_ready;
 output [8*16:0] sdp_nrdma2dp_mul_pd;
 input reg2dp_nrdma_data_mode;
 input reg2dp_nrdma_data_size;
 input [1:0] reg2dp_nrdma_data_use;
 input reg2dp_nrdma_ram_type;
 input [31:0] reg2dp_bn_base_addr_high;
 input [31-3:0] reg2dp_bn_base_addr_low;
 input [31-3:0] reg2dp_bn_line_stride;
 input [31-3:0] reg2dp_bn_surface_stride;
 input [4:0] reg2dp_batch_number;
 input [12:0] reg2dp_channel;
 input [12:0] reg2dp_height;
 input reg2dp_op_en;
 input [1:0] reg2dp_out_precision;
 input reg2dp_perf_dma_en;
 input [1:0] reg2dp_proc_precision;
 input [12:0] reg2dp_width;
 input reg2dp_winograd;
 output [31:0] dp2reg_nrdma_stall;
 output dp2reg_done;
 input dla_clk_ovr_on_sync;
 input global_clk_ovr_on_sync;
 input tmc2slcg_disable_clock_gating;
 input nrdma_slcg_op_en;
 input nrdma_disable;
 wire nvdla_gated_clk;
 wire op_load;
 wire eg_done;
 reg layer_process;
 wire [15:0] ig2cq_pd;
 wire ig2cq_prdy;
 wire ig2cq_pvld;
 wire [15:0] cq2eg_pd;
 wire cq2eg_prdy;
 wire cq2eg_pvld;
 wire dma_rd_cdt_lat_fifo_pop;
 wire [47 -1:0] dma_rd_req_pd;
 wire dma_rd_req_rdy;
 wire dma_rd_req_vld;
 wire [65 -1:0] dma_rd_rsp_pd;
 wire dma_rd_rsp_rdy;
 wire dma_rd_rsp_vld;
 wire [65 -1:0] lat_fifo_rd_pd;
 wire lat_fifo_rd_pvld;
 wire lat_fifo_rd_prdy;
// Layer Switch
assign op_load = reg2dp_op_en & !layer_process;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    layer_process <= 1'b0;
  end else begin
    if (op_load) begin
        layer_process <= 1'b1;
    end else if (eg_done) begin
        layer_process <= 1'b0;
    end
  end
end
assign dp2reg_done = eg_done;
//=======================================
NV_NVDLA_SDP_NRDMA_gate u_gate (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.nrdma_disable (nrdma_disable) //|< i
  ,.nrdma_slcg_op_en (nrdma_slcg_op_en) //|< i
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
  ,.nvdla_gated_clk (nvdla_gated_clk) //|> w
  );
NV_NVDLA_SDP_RDMA_ig u_ig (
   .nvdla_core_clk (nvdla_gated_clk) //|< w
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.op_load (op_load) //|< w
  ,.ig2cq_pd (ig2cq_pd[15:0]) //|> w
  ,.ig2cq_pvld (ig2cq_pvld) //|> w
  ,.ig2cq_prdy (ig2cq_prdy) //|< w
  ,.dma_rd_req_pd (dma_rd_req_pd[47 -1:0]) //|> w
  ,.dma_rd_req_vld (dma_rd_req_vld) //|> w
  ,.dma_rd_req_rdy (dma_rd_req_rdy) //|< w
  ,.reg2dp_op_en (reg2dp_op_en) //|< i
  ,.reg2dp_perf_dma_en (reg2dp_perf_dma_en) //|< i
  ,.reg2dp_winograd (reg2dp_winograd) //|< i
  ,.reg2dp_channel (reg2dp_channel[12:0]) //|< i
  ,.reg2dp_height (reg2dp_height[12:0]) //|< i
  ,.reg2dp_width (reg2dp_width[12:0]) //|< i
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0]) //|< i
  ,.reg2dp_rdma_data_mode (reg2dp_nrdma_data_mode) //|< i
  ,.reg2dp_rdma_data_size (reg2dp_nrdma_data_size) //|< i
  ,.reg2dp_rdma_data_use (reg2dp_nrdma_data_use[1:0]) //|< i
  ,.reg2dp_base_addr_high (reg2dp_bn_base_addr_high[31:0]) //|< i
  ,.reg2dp_base_addr_low (reg2dp_bn_base_addr_low[31-3:0]) //|< i
  ,.reg2dp_line_stride (reg2dp_bn_line_stride[31-3:0]) //|< i
  ,.reg2dp_surface_stride (reg2dp_bn_surface_stride[31-3:0]) //|< i
  ,.dp2reg_rdma_stall (dp2reg_nrdma_stall[31:0]) //|> o
  );
//: my $depth = 16;
//: my $width = 16;
//: print "NV_NVDLA_SDP_NRDMA_cq_${depth}x${width}  u_cq ( \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
NV_NVDLA_SDP_NRDMA_cq_16x16  u_cq ( 

//| eperl: generated_end (DO NOT EDIT ABOVE)
   .nvdla_core_clk (nvdla_gated_clk) //|< w
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.ig2cq_prdy (ig2cq_prdy) //|> w
  ,.ig2cq_pvld (ig2cq_pvld) //|< w
  ,.ig2cq_pd (ig2cq_pd[15:0]) //|< w
  ,.cq2eg_prdy (cq2eg_prdy) //|< w
  ,.cq2eg_pvld (cq2eg_pvld) //|> w
  ,.cq2eg_pd (cq2eg_pd[15:0]) //|> w
  );
NV_NVDLA_SDP_RDMA_eg u_eg (
   .nvdla_core_clk (nvdla_gated_clk) //|< w
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.op_load (op_load) //|< w
  ,.eg_done (eg_done) //|> w
  ,.cq2eg_pd (cq2eg_pd[15:0]) //|< w
  ,.cq2eg_pvld (cq2eg_pvld) //|< w
  ,.cq2eg_prdy (cq2eg_prdy) //|> w
  ,.dma_rd_cdt_lat_fifo_pop (dma_rd_cdt_lat_fifo_pop) //|> w
  ,.lat_fifo_rd_pd (lat_fifo_rd_pd[65 -1:0]) //|< w
  ,.lat_fifo_rd_pvld (lat_fifo_rd_pvld) //|< w
  ,.lat_fifo_rd_prdy (lat_fifo_rd_prdy) //|> w
  ,.sdp_rdma2dp_alu_ready (sdp_nrdma2dp_alu_ready) //|< i
  ,.sdp_rdma2dp_mul_ready (sdp_nrdma2dp_mul_ready) //|< i
  ,.sdp_rdma2dp_alu_pd (sdp_nrdma2dp_alu_pd[8*16:0]) //|> o
  ,.sdp_rdma2dp_alu_valid (sdp_nrdma2dp_alu_valid) //|> o
  ,.sdp_rdma2dp_mul_pd (sdp_nrdma2dp_mul_pd[8*16:0]) //|> o
  ,.sdp_rdma2dp_mul_valid (sdp_nrdma2dp_mul_valid) //|> o
  ,.reg2dp_batch_number (reg2dp_batch_number[4:0]) //|< i
  ,.reg2dp_channel (reg2dp_channel[12:0]) //|< i
  ,.reg2dp_height (reg2dp_height[12:0]) //|< i
  ,.reg2dp_width (reg2dp_width[12:0]) //|< i
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0]) //|< i
  ,.reg2dp_out_precision (reg2dp_out_precision[1:0]) //|< i
  ,.reg2dp_rdma_data_mode (reg2dp_nrdma_data_mode) //|< i
  ,.reg2dp_rdma_data_size (reg2dp_nrdma_data_size) //|< i
  ,.reg2dp_rdma_data_use (reg2dp_nrdma_data_use[1:0]) //|< i
  );
//: my $depth = 16;
//: my $width = 65;
//: print "NV_NVDLA_SDP_NRDMA_lat_fifo_${depth}x${width}  u_lat_fifo (\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
NV_NVDLA_SDP_NRDMA_lat_fifo_16x65  u_lat_fifo (

//| eperl: generated_end (DO NOT EDIT ABOVE)
   .nvdla_core_clk (nvdla_gated_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.lat_wr_prdy (dma_rd_rsp_rdy)
  ,.lat_wr_pvld (dma_rd_rsp_vld)
  ,.lat_wr_pd (dma_rd_rsp_pd[65 -1:0])
  ,.lat_rd_prdy (lat_fifo_rd_prdy)
  ,.lat_rd_pvld (lat_fifo_rd_pvld)
  ,.lat_rd_pd (lat_fifo_rd_pd[65 -1:0])
  );
NV_NVDLA_SDP_RDMA_dmaif u_NV_NVDLA_SDP_RDMA_dmaif (
   .nvdla_core_clk (nvdla_gated_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop) //|> o
  ,.sdp2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd[47 -1:0]) //|> o
  ,.sdp2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid) //|> o
  ,.sdp2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready) //|< i
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd[65 -1:0]) //|< i
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid) //|< i
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready) //|> o
  ,.dma_rd_req_ram_type (reg2dp_nrdma_ram_type) //|< w
  ,.dma_rd_rsp_ram_type (reg2dp_nrdma_ram_type) //|< w
  ,.dma_rd_req_pd (dma_rd_req_pd[47 -1:0]) //|< w
  ,.dma_rd_req_vld (dma_rd_req_vld) //|< w
  ,.dma_rd_req_rdy (dma_rd_req_rdy) //|> w
  ,.dma_rd_rsp_pd (dma_rd_rsp_pd[65 -1:0]) //|> w
  ,.dma_rd_rsp_vld (dma_rd_rsp_vld) //|> w
  ,.dma_rd_rsp_rdy (dma_rd_rsp_rdy) //|< w
  ,.dma_rd_cdt_lat_fifo_pop (dma_rd_cdt_lat_fifo_pop) //|< w
  );
endmodule // NV_NVDLA_SDP_nrdma
