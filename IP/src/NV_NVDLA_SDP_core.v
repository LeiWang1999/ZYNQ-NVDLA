// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_core.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_define.h
module NV_NVDLA_SDP_core (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cacc2sdp_pd //|< i
  ,cacc2sdp_valid //|< i
  ,cacc2sdp_ready //|> o
  ,dla_clk_ovr_on_sync //|< i
  ,dp2reg_done //|< i
  ,global_clk_ovr_on_sync //|< i
  ,pwrbus_ram_pd //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,reg2dp_bcore_slcg_op_en //|< i
  ,reg2dp_flying_mode //|< i
  ,reg2dp_bn_alu_algo //|< i
  ,reg2dp_bn_alu_bypass //|< i
  ,reg2dp_bn_alu_operand //|< i
  ,reg2dp_bn_alu_shift_value //|< i
  ,reg2dp_bn_alu_src //|< i
  ,reg2dp_bn_bypass //|< i
  ,reg2dp_bn_mul_bypass //|< i
  ,reg2dp_bn_mul_operand //|< i
  ,reg2dp_bn_mul_prelu //|< i
  ,reg2dp_bn_mul_shift_value //|< i
  ,reg2dp_bn_mul_src //|< i
  ,reg2dp_bn_relu_bypass //|< i
  ,reg2dp_bs_alu_algo //|< i
  ,reg2dp_bs_alu_bypass //|< i
  ,reg2dp_bs_alu_operand //|< i
  ,reg2dp_bs_alu_shift_value //|< i
  ,reg2dp_bs_alu_src //|< i
  ,reg2dp_bs_bypass //|< i
  ,reg2dp_bs_mul_bypass //|< i
  ,reg2dp_bs_mul_operand //|< i
  ,reg2dp_bs_mul_prelu //|< i
  ,reg2dp_bs_mul_shift_value //|< i
  ,reg2dp_bs_mul_src //|< i
  ,reg2dp_bs_relu_bypass //|< i
  ,reg2dp_cvt_offset //|< i
  ,reg2dp_cvt_scale //|< i
  ,reg2dp_cvt_shift //|< i
  ,reg2dp_ecore_slcg_op_en //|< i
  ,reg2dp_nan_to_zero //|< i
  ,reg2dp_ncore_slcg_op_en //|< i
  ,reg2dp_op_en //|< i
  ,reg2dp_out_precision //|< i
  ,reg2dp_output_dst //|< i
  ,reg2dp_perf_lut_en //|< i
  ,reg2dp_perf_sat_en //|< i
  ,reg2dp_proc_precision //|< i
  ,dp2reg_out_saturation //|> o
  ,sdp_brdma2dp_alu_pd //|< i
  ,sdp_brdma2dp_alu_valid //|< i
  ,sdp_brdma2dp_alu_ready //|> o
  ,sdp_brdma2dp_mul_pd //|< i
  ,sdp_brdma2dp_mul_valid //|< i
  ,sdp_brdma2dp_mul_ready //|> o
  ,sdp_nrdma2dp_alu_pd //|< i
  ,sdp_nrdma2dp_alu_valid //|< i
  ,sdp_nrdma2dp_alu_ready //|> o
  ,sdp_nrdma2dp_mul_pd //|< i
  ,sdp_nrdma2dp_mul_valid //|< i
  ,sdp_nrdma2dp_mul_ready //|> o
  ,sdp_mrdma2cmux_pd //|< i
  ,sdp_mrdma2cmux_valid //|< i
  ,sdp_mrdma2cmux_ready //|> o
  ,sdp2pdp_pd //|> o
  ,sdp2pdp_valid //|> o
  ,sdp2pdp_ready //|< i
  ,sdp_dp2wdma_pd //|> o
  ,sdp_dp2wdma_valid //|> o
  ,sdp_dp2wdma_ready //|< i
  );
//
// NV_NVDLA_SDP_core_ports.v
//
input nvdla_core_clk;
input nvdla_core_rstn;
input sdp_brdma2dp_mul_valid;
output sdp_brdma2dp_mul_ready;
input [8*16:0] sdp_brdma2dp_mul_pd;
input sdp_brdma2dp_alu_valid;
output sdp_brdma2dp_alu_ready;
input [8*16:0] sdp_brdma2dp_alu_pd;
input sdp_nrdma2dp_mul_valid;
output sdp_nrdma2dp_mul_ready;
input [8*16:0] sdp_nrdma2dp_mul_pd;
input sdp_nrdma2dp_alu_valid;
output sdp_nrdma2dp_alu_ready;
input [8*16:0] sdp_nrdma2dp_alu_pd;
output sdp_dp2wdma_valid;
input sdp_dp2wdma_ready;
output [8*8 -1:0] sdp_dp2wdma_pd;
output sdp2pdp_valid;
input sdp2pdp_ready;
output [8*1 -1:0] sdp2pdp_pd;
input [31:0] pwrbus_ram_pd;
input cacc2sdp_valid;
output cacc2sdp_ready;
input [32*1 +1:0] cacc2sdp_pd;
input sdp_mrdma2cmux_valid;
output sdp_mrdma2cmux_ready;
input [32*8 +1:0] sdp_mrdma2cmux_pd;
input reg2dp_bcore_slcg_op_en;
input reg2dp_flying_mode;
input [1:0] reg2dp_bn_alu_algo;
input reg2dp_bn_alu_bypass;
input [15:0] reg2dp_bn_alu_operand;
input [5:0] reg2dp_bn_alu_shift_value;
input reg2dp_bn_alu_src;
input reg2dp_bn_bypass;
input reg2dp_bn_mul_bypass;
input [15:0] reg2dp_bn_mul_operand;
input reg2dp_bn_mul_prelu;
input [7:0] reg2dp_bn_mul_shift_value;
input reg2dp_bn_mul_src;
input reg2dp_bn_relu_bypass;
input [1:0] reg2dp_bs_alu_algo;
input reg2dp_bs_alu_bypass;
input [15:0] reg2dp_bs_alu_operand;
input [5:0] reg2dp_bs_alu_shift_value;
input reg2dp_bs_alu_src;
input reg2dp_bs_bypass;
input reg2dp_bs_mul_bypass;
input [15:0] reg2dp_bs_mul_operand;
input reg2dp_bs_mul_prelu;
input [7:0] reg2dp_bs_mul_shift_value;
input reg2dp_bs_mul_src;
input reg2dp_bs_relu_bypass;
input [31:0] reg2dp_cvt_offset;
input [15:0] reg2dp_cvt_scale;
input [5:0] reg2dp_cvt_shift;
input reg2dp_ecore_slcg_op_en;
input reg2dp_nan_to_zero;
input reg2dp_ncore_slcg_op_en;
input reg2dp_op_en;
input [1:0] reg2dp_out_precision;
input reg2dp_output_dst;
input reg2dp_perf_lut_en;
input reg2dp_perf_sat_en;
input [1:0] reg2dp_proc_precision;
input dp2reg_done;
output [31:0] dp2reg_out_saturation;
input dla_clk_ovr_on_sync;
input global_clk_ovr_on_sync;
input tmc2slcg_disable_clock_gating;
wire bcore_slcg_en;
wire ncore_slcg_en;
wire ecore_slcg_en;
wire nvdla_gated_bcore_clk;
wire nvdla_gated_ecore_clk;
wire nvdla_gated_ncore_clk;
wire op_en_load;
reg wait_for_op_en;
reg cfg_bs_en;
reg cfg_bn_en;
reg cfg_ew_en;
reg cfg_mode_eql;
reg cfg_nan_to_zero;
reg [1:0] cfg_out_precision;
reg [1:0] cfg_proc_precision;
wire cfg_mode_pdp;
reg [31:0] cfg_cvt_offset;
reg [15:0] cfg_cvt_scale;
reg [5:0] cfg_cvt_shift;
reg [1:0] cfg_bn_alu_algo;
reg cfg_bn_alu_bypass;
reg [15:0] cfg_bn_alu_operand;
reg [5:0] cfg_bn_alu_shift_value;
reg cfg_bn_alu_src;
reg cfg_bn_mul_bypass;
reg [15:0] cfg_bn_mul_operand;
reg cfg_bn_mul_prelu;
reg [7:0] cfg_bn_mul_shift_value;
reg cfg_bn_mul_src;
reg cfg_bn_relu_bypass;
reg [1:0] cfg_bs_alu_algo;
reg cfg_bs_alu_bypass;
reg [15:0] cfg_bs_alu_operand;
reg [5:0] cfg_bs_alu_shift_value;
reg cfg_bs_alu_src;
reg cfg_bs_mul_bypass;
reg [15:0] cfg_bs_mul_operand;
reg cfg_bs_mul_prelu;
reg [7:0] cfg_bs_mul_shift_value;
reg cfg_bs_mul_src;
reg cfg_bs_relu_bypass;
reg bn_alu_in_en;
reg bn_mul_in_en;
wire [16*1 -1:0] bn_alu_in_data;
wire bn_alu_in_layer_end;
wire [16*1:0] bn_alu_in_pd;
wire bn_alu_in_prdy;
wire bn_alu_in_pvld;
wire bn_alu_in_rdy;
wire bn_alu_in_vld;
wire [16*1 -1:0] bn_mul_in_data;
wire bn_mul_in_layer_end;
wire [16*1:0] bn_mul_in_pd;
wire bn_mul_in_prdy;
wire bn_mul_in_pvld;
wire bn_mul_in_rdy;
wire bn_mul_in_vld;
reg bs_alu_in_en;
reg bs_mul_in_en;
wire [16*1 -1:0] bs_alu_in_data;
wire bs_alu_in_layer_end;
wire [16*1:0] bs_alu_in_pd;
wire bs_alu_in_prdy;
wire bs_alu_in_pvld;
wire bs_alu_in_rdy;
wire bs_alu_in_vld;
wire [16*1 -1:0] bs_mul_in_data;
wire bs_mul_in_layer_end;
wire [16*1:0] bs_mul_in_pd;
wire bs_mul_in_prdy;
wire bs_mul_in_pvld;
wire bs_mul_in_rdy;
wire bs_mul_in_vld;
wire sdp_mrdma_data_in_valid;
wire sdp_mrdma_data_in_ready;
wire [32*1 +1:0] sdp_mrdma_data_in_pd;
wire [32*1 -1:0] sdp_cmux2dp_data;
wire [32*1 -1:0] sdp_cmux2dp_pd;
wire sdp_cmux2dp_ready;
wire sdp_cmux2dp_valid;
wire bn2ew_data_pvld;
wire bs_data_in_pvld;
wire [32*1 -1:0] bs_data_in_pd;
wire bs_data_in_prdy;
wire [32*1 -1:0] flop_bs_data_in_pd;
wire flop_bs_data_in_prdy;
wire flop_bs_data_in_pvld;
wire [32*1:0] bs_data_out_pd;
wire bs_data_out_prdy;
wire bs_data_out_pvld;
wire [32*1 -1:0] flop_bs_data_out_pd;
wire flop_bs_data_out_pvld;
wire flop_bs_data_out_prdy;
wire bs2bn_data_pvld;
wire bn_data_in_pvld;
wire bn_data_in_prdy;
wire [32*1 -1:0] bn_data_in_pd;
wire flop_bn_data_in_prdy;
wire flop_bn_data_in_pvld;
wire [32*1 -1:0] flop_bn_data_in_pd;
wire bn_data_out_prdy;
wire bn_data_out_pvld;
wire [32*1 -1:0] bn_data_out_pd;
wire flop_bn_data_out_pvld;
wire flop_bn_data_out_prdy;
wire [32*1 -1:0] flop_bn_data_out_pd;
wire ew_data_in_prdy;
wire ew_data_in_pvld;
wire [32*1 -1:0] ew_data_in_pd;
wire flop_ew_data_in_prdy;
wire flop_ew_data_in_pvld;
wire [32*0 -1:0] flop_ew_data_in_pd;
wire ew_data_out_prdy;
wire ew_data_out_pvld;
wire [32*0 -1:0] ew_data_out_pd;
wire flop_ew_data_out_prdy;
wire flop_ew_data_out_pvld;
wire [32*1 -1:0] flop_ew_data_out_pd;
wire ew2cvt_data_pvld;
wire cvt_data_in_pvld;
wire cvt_data_in_prdy;
wire [32*1 -1:0] cvt_data_in_pd;
wire [16*1 +1 -1:0] cvt_data_out_pd;
wire [16*1 -1:0] cvt_data_out_data;
wire cvt_data_out_prdy;
wire cvt_data_out_pvld;
wire [16*1 -1:0] core2wdma_pd;
wire core2wdma_rdy;
wire core2wdma_vld;
wire [8*1 -1:0] core2pdp_pd;
wire core2pdp_rdy;
wire core2pdp_vld;
wire [1 -1:0] cvt_data_out_sat;
reg [1 -1:0] saturation_bits;
reg cvt_sat_cvt_sat_adv;
reg [31:0] cvt_sat_cvt_sat_cnt_cur;
reg [33:0] cvt_sat_cvt_sat_cnt_ext;
reg [33:0] cvt_sat_cvt_sat_cnt_mod;
reg [33:0] cvt_sat_cvt_sat_cnt_new;
reg [33:0] cvt_sat_cvt_sat_cnt_nxt;
reg [31:0] cvt_saturation_cnt;
wire [4:0] i_add;
wire [0:0] i_sub;
wire [4:0] cvt_sat_add_act;
wire [4:0] cvt_sat_add_act_ext;
wire [4:0] cvt_sat_add_ext;
wire cvt_sat_add_flow;
wire cvt_sat_add_guard;
wire cvt_sat_dec;
wire cvt_sat_inc;
wire [4:0] cvt_sat_mod_ext;
wire cvt_sat_sub_act;
wire [4:0] cvt_sat_sub_act_ext;
wire [4:0] cvt_sat_sub_ext;
wire cvt_sat_sub_flow;
wire cvt_sat_sub_guard;
wire [4:0] cvt_saturation_add;
wire cvt_saturation_cen;
wire cvt_saturation_clr;
wire cvt_saturation_sub;
//===========================================
// CFG
//===========================================
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cfg_bs_en <= 1'b0;
    cfg_bn_en <= 1'b0;
    cfg_ew_en <= 1'b0;
    cfg_mode_eql <= 1'b0;
  end else begin
        cfg_bs_en <= reg2dp_bs_bypass== 1'h0 ;
        cfg_bn_en <= reg2dp_bn_bypass== 1'h0 ;
        cfg_ew_en <= 1'b0;
        cfg_mode_eql <= 1'b0;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cfg_bs_alu_operand <= {16{1'b0}};
    cfg_bs_mul_operand <= {16{1'b0}};
    cfg_bs_alu_bypass <= 1'b0;
    cfg_bs_alu_algo <= {2{1'b0}};
    cfg_bs_alu_src <= 1'b0;
    cfg_bs_alu_shift_value <= {6{1'b0}};
    cfg_bs_mul_bypass <= 1'b0;
    cfg_bs_mul_prelu <= 1'b0;
    cfg_bs_mul_src <= 1'b0;
    cfg_bs_mul_shift_value <= {8{1'b0}};
    cfg_bs_relu_bypass <= 1'b0;
    cfg_bn_alu_operand <= {16{1'b0}};
    cfg_bn_mul_operand <= {16{1'b0}};
    cfg_bn_alu_bypass <= 1'b0;
    cfg_bn_alu_algo <= {2{1'b0}};
    cfg_bn_alu_src <= 1'b0;
    cfg_bn_alu_shift_value <= {6{1'b0}};
    cfg_bn_mul_bypass <= 1'b0;
    cfg_bn_mul_prelu <= 1'b0;
    cfg_bn_mul_src <= 1'b0;
    cfg_bn_mul_shift_value <= {8{1'b0}};
    cfg_bn_relu_bypass <= 1'b0;
    cfg_cvt_offset <= {32{1'b0}};
    cfg_cvt_scale <= {16{1'b0}};
    cfg_cvt_shift <= {6{1'b0}};
    cfg_proc_precision <= {2{1'b0}};
    cfg_out_precision <= {2{1'b0}};
    cfg_nan_to_zero <= 1'b0;
  end else begin
    if (op_en_load) begin
        cfg_bs_alu_operand <= reg2dp_bs_alu_operand ;
        cfg_bs_mul_operand <= reg2dp_bs_mul_operand ;
        cfg_bs_alu_bypass <= reg2dp_bs_alu_bypass ;
        cfg_bs_alu_algo <= reg2dp_bs_alu_algo ;
        cfg_bs_alu_src <= reg2dp_bs_alu_src ;
        cfg_bs_alu_shift_value <= reg2dp_bs_alu_shift_value ;
        cfg_bs_mul_bypass <= reg2dp_bs_mul_bypass ;
        cfg_bs_mul_prelu <= reg2dp_bs_mul_prelu ;
        cfg_bs_mul_src <= reg2dp_bs_mul_src ;
        cfg_bs_mul_shift_value <= reg2dp_bs_mul_shift_value ;
        cfg_bs_relu_bypass <= reg2dp_bs_relu_bypass ;
        cfg_bn_alu_operand <= reg2dp_bn_alu_operand ;
        cfg_bn_mul_operand <= reg2dp_bn_mul_operand ;
        cfg_bn_alu_bypass <= reg2dp_bn_alu_bypass ;
        cfg_bn_alu_algo <= reg2dp_bn_alu_algo ;
        cfg_bn_alu_src <= reg2dp_bn_alu_src ;
        cfg_bn_alu_shift_value <= reg2dp_bn_alu_shift_value ;
        cfg_bn_mul_bypass <= reg2dp_bn_mul_bypass ;
        cfg_bn_mul_prelu <= reg2dp_bn_mul_prelu ;
        cfg_bn_mul_src <= reg2dp_bn_mul_src ;
        cfg_bn_mul_shift_value <= reg2dp_bn_mul_shift_value ;
        cfg_bn_relu_bypass <= reg2dp_bn_relu_bypass ;
        cfg_cvt_offset <= reg2dp_cvt_offset ;
        cfg_cvt_scale <= reg2dp_cvt_scale ;
        cfg_cvt_shift <= reg2dp_cvt_shift ;
        cfg_proc_precision <= reg2dp_proc_precision ;
        cfg_out_precision <= reg2dp_out_precision ;
        cfg_nan_to_zero <= reg2dp_nan_to_zero ;
    end
  end
end
//===========================================
// SLCG Gate
//===========================================
assign bcore_slcg_en = cfg_bs_en & reg2dp_bcore_slcg_op_en;
assign ncore_slcg_en = cfg_bn_en & reg2dp_ncore_slcg_op_en;
assign ecore_slcg_en = (cfg_ew_en & reg2dp_ecore_slcg_op_en);
NV_NVDLA_SDP_CORE_gate u_gate (
   .bcore_slcg_en (bcore_slcg_en) //|< w
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
  ,.ecore_slcg_en (ecore_slcg_en) //|< w
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
  ,.ncore_slcg_en (ncore_slcg_en) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
  ,.nvdla_gated_bcore_clk (nvdla_gated_bcore_clk) //|> w
  ,.nvdla_gated_ecore_clk (nvdla_gated_ecore_clk) //|> w
  ,.nvdla_gated_ncore_clk (nvdla_gated_ncore_clk) //|> w
  );
//===========================================================================
// DATA PATH LOGIC
// RDMA data
//===========================================================================
//covert mrdma data from atomic_m to 1
NV_NVDLA_SDP_RDMA_pack #(.IW(32*8),.OW(32*1),.CW(2)) u_dpin_pack (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.cfg_dp_8 (~(|reg2dp_proc_precision))
  ,.inp_pvld (sdp_mrdma2cmux_valid)
  ,.inp_prdy (sdp_mrdma2cmux_ready)
  ,.inp_data (sdp_mrdma2cmux_pd[32*8 +1:0])
  ,.out_pvld (sdp_mrdma_data_in_valid)
  ,.out_prdy (sdp_mrdma_data_in_ready)
  ,.out_data (sdp_mrdma_data_in_pd[32*1 +1:0])
  );
//covert atomic_m to 1
NV_NVDLA_SDP_RDMA_pack #(.IW(8*16),.OW(16*1),.CW(1)) u_bs_mul_pack (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.cfg_dp_8 (~(|reg2dp_proc_precision))
  ,.inp_pvld (sdp_brdma2dp_mul_valid)
  ,.inp_prdy (sdp_brdma2dp_mul_ready)
  ,.inp_data (sdp_brdma2dp_mul_pd[8*16:0])
  ,.out_pvld (bs_mul_in_pvld)
  ,.out_prdy (bs_mul_in_prdy)
  ,.out_data (bs_mul_in_pd[16*1:0])
  );
assign bs_mul_in_data[16*1 -1:0] = bs_mul_in_pd[16*1 -1:0];
assign bs_mul_in_layer_end = bs_mul_in_pd[16*1];
//covert atomic_m to 1
NV_NVDLA_SDP_RDMA_pack #(.IW(8*16),.OW(16*1),.CW(1)) u_bs_alu_pack (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.cfg_dp_8 (~(|reg2dp_proc_precision))
  ,.inp_pvld (sdp_brdma2dp_alu_valid)
  ,.inp_prdy (sdp_brdma2dp_alu_ready)
  ,.inp_data (sdp_brdma2dp_alu_pd[8*16:0])
  ,.out_pvld (bs_alu_in_pvld)
  ,.out_prdy (bs_alu_in_prdy)
  ,.out_data (bs_alu_in_pd[16*1:0])
  );
assign bs_alu_in_data[16*1 -1:0] = bs_alu_in_pd[16*1 -1:0];
assign bs_alu_in_layer_end = bs_alu_in_pd[16*1];
//covert atomic_m to 1
NV_NVDLA_SDP_RDMA_pack #(.IW(8*16),.OW(16*1),.CW(1)) u_bn_mul_pack (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.cfg_dp_8 (~(|reg2dp_proc_precision))
  ,.inp_pvld (sdp_nrdma2dp_mul_valid)
  ,.inp_prdy (sdp_nrdma2dp_mul_ready)
  ,.inp_data (sdp_nrdma2dp_mul_pd[8*16:0])
  ,.out_pvld (bn_mul_in_pvld)
  ,.out_prdy (bn_mul_in_prdy)
  ,.out_data (bn_mul_in_pd[16*1:0])
  );
assign bn_mul_in_data[16*1 -1:0] = bn_mul_in_pd[16*1 -1:0];
assign bn_mul_in_layer_end = bn_mul_in_pd[16*1];
NV_NVDLA_SDP_RDMA_pack #(.IW(8*16),.OW(16*1),.CW(1)) u_bn_alu_pack (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.cfg_dp_8 (~(|reg2dp_proc_precision))
  ,.inp_pvld (sdp_nrdma2dp_alu_valid)
  ,.inp_prdy (sdp_nrdma2dp_alu_ready)
  ,.inp_data (sdp_nrdma2dp_alu_pd[8*16:0])
  ,.out_pvld (bn_alu_in_pvld)
  ,.out_prdy (bn_alu_in_prdy)
  ,.out_data (bn_alu_in_pd[16*1:0])
  );
assign bn_alu_in_data[16*1 -1:0] = bn_alu_in_pd[16*1 -1:0];
assign bn_alu_in_layer_end = bn_alu_in_pd[16*1];
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    wait_for_op_en <= 1'b1;
  end else begin
    if (dp2reg_done) begin
        wait_for_op_en <= 1'b1;
    end else if (reg2dp_op_en) begin
        wait_for_op_en <= 1'b0;
    end
  end
end
assign op_en_load = wait_for_op_en & reg2dp_op_en;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    bs_alu_in_en <= 1'b0;
  end else begin
   if (dp2reg_done) begin
      bs_alu_in_en <= 1'b0;
   end else if (op_en_load) begin
      bs_alu_in_en <= cfg_bs_en && (!reg2dp_bs_alu_bypass) && (reg2dp_bs_alu_src==1);
   end else if (bs_alu_in_layer_end && bs_alu_in_pvld && bs_alu_in_prdy) begin
      bs_alu_in_en <= 1'b0;
   end
  end
end
assign bs_alu_in_vld = bs_alu_in_en & bs_alu_in_pvld;
assign bs_alu_in_prdy = bs_alu_in_en & bs_alu_in_rdy;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    bs_mul_in_en <= 1'b0;
  end else begin
   if (dp2reg_done) begin
      bs_mul_in_en <= 1'b0;
   end else if (op_en_load) begin
      bs_mul_in_en <= cfg_bs_en && (!reg2dp_bs_mul_bypass) &(reg2dp_bs_mul_src==1);
   end else if (bs_mul_in_layer_end && bs_mul_in_pvld && bs_mul_in_prdy) begin
      bs_mul_in_en <= 1'b0;
   end
  end
end
assign bs_mul_in_vld = bs_mul_in_en & bs_mul_in_pvld;
assign bs_mul_in_prdy = bs_mul_in_en & bs_mul_in_rdy;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    bn_alu_in_en <= 1'b0;
  end else begin
   if (dp2reg_done) begin
      bn_alu_in_en <= 1'b0;
   end else if (op_en_load) begin
      bn_alu_in_en <= cfg_bn_en && (!reg2dp_bn_alu_bypass) && (reg2dp_bn_alu_src==1);
   end else if (bn_alu_in_layer_end && bn_alu_in_pvld && bn_alu_in_prdy) begin
      bn_alu_in_en <= 1'b0;
   end
  end
end
assign bn_alu_in_vld = bn_alu_in_en & bn_alu_in_pvld;
assign bn_alu_in_prdy = bn_alu_in_en & bn_alu_in_rdy;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    bn_mul_in_en <= 1'b0;
  end else begin
   if (dp2reg_done) begin
      bn_mul_in_en <= 1'b0;
   end else if (op_en_load) begin
      bn_mul_in_en <= cfg_bn_en && (!reg2dp_bn_mul_bypass) &(reg2dp_bn_mul_src==1);
   end else if (bn_mul_in_layer_end && bn_mul_in_pvld && bn_mul_in_prdy) begin
      bn_mul_in_en <= 1'b0;
   end
  end
end
assign bn_mul_in_vld = bn_mul_in_en & bn_mul_in_pvld;
assign bn_mul_in_prdy = bn_mul_in_en & bn_mul_in_rdy;
//===========================================
// CORE
//===========================================
// data from MUX ? CC : MEM
NV_NVDLA_SDP_cmux u_NV_NVDLA_SDP_cmux (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd[32*1 +1:0])
  ,.sdp_mrdma2cmux_valid (sdp_mrdma_data_in_valid)
  ,.sdp_mrdma2cmux_ready (sdp_mrdma_data_in_ready)
  ,.sdp_mrdma2cmux_pd (sdp_mrdma_data_in_pd[32*1 +1:0])
  ,.sdp_cmux2dp_ready (sdp_cmux2dp_ready)
  ,.sdp_cmux2dp_pd (sdp_cmux2dp_pd[32*1 -1:0])
  ,.sdp_cmux2dp_valid (sdp_cmux2dp_valid)
  ,.reg2dp_flying_mode (reg2dp_flying_mode)
  ,.reg2dp_nan_to_zero (reg2dp_nan_to_zero)
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0])
  ,.op_en_load (op_en_load)
  );
assign sdp_cmux2dp_data[32*1 -1:0] = sdp_cmux2dp_pd[32*1 -1:0];
// MUX to bypass CORE_x0
assign sdp_cmux2dp_ready = cfg_bs_en ? bs_data_in_prdy : flop_bs_data_out_prdy;
assign bs_data_in_pd = sdp_cmux2dp_data;
assign bs_data_in_pvld = cfg_bs_en & sdp_cmux2dp_valid;
//covert 1 to 1
NV_NVDLA_SDP_CORE_pack #(.IW(32*1),.OW(32*1)) u_bs_dppack (
   .nvdla_core_clk (nvdla_gated_bcore_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.inp_pvld (bs_data_in_pvld) //|< i
  ,.inp_data (bs_data_in_pd[32*1 -1:0]) //|< i
  ,.inp_prdy (bs_data_in_prdy) //|> o
  ,.out_pvld (flop_bs_data_in_pvld) //|> w
  ,.out_data (flop_bs_data_in_pd[32*1 -1:0]) //|> w
  ,.out_prdy (flop_bs_data_in_prdy) //|< w
  );
NV_NVDLA_SDP_HLS_x1_int u_bs (
   .cfg_alu_algo (cfg_bs_alu_algo[1:0]) //|< r
  ,.cfg_alu_bypass (cfg_bs_alu_bypass) //|< r
  ,.cfg_alu_op (cfg_bs_alu_operand[15:0]) //|< r
  ,.cfg_alu_shift_value (cfg_bs_alu_shift_value[5:0]) //|< r
  ,.cfg_alu_src (cfg_bs_alu_src) //|< r
  ,.cfg_mul_bypass (cfg_bs_mul_bypass) //|< r
  ,.cfg_mul_op (cfg_bs_mul_operand[15:0]) //|< r
  ,.cfg_mul_prelu (cfg_bs_mul_prelu) //|< r
  ,.cfg_mul_shift_value (cfg_bs_mul_shift_value[5:0]) //|< r
  ,.cfg_mul_src (cfg_bs_mul_src) //|< r
  ,.cfg_relu_bypass (cfg_bs_relu_bypass) //|< r
  ,.chn_alu_op (bs_alu_in_data[16*1 -1:0]) //|< w
  ,.chn_alu_op_pvld (bs_alu_in_vld) //|< w
  ,.chn_data_in (flop_bs_data_in_pd[32*1 -1:0]) //|< w
  ,.chn_in_pvld (flop_bs_data_in_pvld) //|< w
  ,.chn_mul_op (bs_mul_in_data[16*1 -1:0]) //|< w
  ,.chn_mul_op_pvld (bs_mul_in_vld) //|< w
  ,.chn_out_prdy (bs_data_out_prdy) //|< w
  ,.chn_alu_op_prdy (bs_alu_in_rdy) //|> w
  ,.chn_data_out (bs_data_out_pd[32*1 -1:0]) //|> w
  ,.chn_in_prdy (flop_bs_data_in_prdy) //|> w
  ,.chn_mul_op_prdy (bs_mul_in_rdy) //|> w
  ,.chn_out_pvld (bs_data_out_pvld) //|> w
  ,.nvdla_core_clk (nvdla_gated_bcore_clk) //|< w
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  );
//covert 1 to 1
NV_NVDLA_SDP_CORE_unpack #(.IW(32*1),.OW(32*1)) u_bs_dpunpack (
   .nvdla_core_clk (nvdla_gated_bcore_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.inp_pvld (bs_data_out_pvld) //|< i
  ,.inp_data (bs_data_out_pd[32*1 -1:0]) //|< i
  ,.inp_prdy (bs_data_out_prdy) //|> o
  ,.out_pvld (flop_bs_data_out_pvld) //|> w
  ,.out_data (flop_bs_data_out_pd[32*1 -1:0]) //|> w
  ,.out_prdy (flop_bs_data_out_prdy) //|< w
  );
//===========================================
// MUX between BS and BN
//===========================================
assign flop_bs_data_out_prdy = cfg_bn_en ? bn_data_in_prdy : flop_bn_data_out_prdy;
assign bs2bn_data_pvld = cfg_bs_en ? flop_bs_data_out_pvld : sdp_cmux2dp_valid;
assign bn_data_in_pd = cfg_bs_en ? flop_bs_data_out_pd : bs_data_in_pd;
assign bn_data_in_pvld = cfg_bn_en & bs2bn_data_pvld;
//covert 1 to 1
NV_NVDLA_SDP_CORE_pack #(.IW(32*1),.OW(32*1)) u_bn_dppack (
   .nvdla_core_clk (nvdla_gated_ncore_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.inp_pvld (bn_data_in_pvld) //|< i
  ,.inp_data (bn_data_in_pd[32*1 -1:0]) //|< i
  ,.inp_prdy (bn_data_in_prdy) //|> o
  ,.out_pvld (flop_bn_data_in_pvld) //|> w
  ,.out_data (flop_bn_data_in_pd[32*1 -1:0]) //|> w
  ,.out_prdy (flop_bn_data_in_prdy) //|< w
  );
NV_NVDLA_SDP_HLS_x2_int u_bn (
   .nvdla_core_clk (nvdla_gated_ncore_clk) //|< w
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.cfg_alu_algo (cfg_bn_alu_algo[1:0]) //|< r
  ,.cfg_alu_bypass (cfg_bn_alu_bypass) //|< r
  ,.cfg_alu_op (cfg_bn_alu_operand[15:0]) //|< r
  ,.cfg_alu_shift_value (cfg_bn_alu_shift_value[5:0]) //|< r
  ,.cfg_alu_src (cfg_bn_alu_src) //|< r
  ,.cfg_mul_bypass (cfg_bn_mul_bypass) //|< r
  ,.cfg_mul_op (cfg_bn_mul_operand[15:0]) //|< r
  ,.cfg_mul_prelu (cfg_bn_mul_prelu) //|< r
  ,.cfg_mul_shift_value (cfg_bn_mul_shift_value[5:0]) //|< r
  ,.cfg_mul_src (cfg_bn_mul_src) //|< r
  ,.cfg_relu_bypass (cfg_bn_relu_bypass) //|< r
  ,.chn_data_in (flop_bn_data_in_pd[32*1 -1:0]) //|< w
  ,.chn_in_pvld (flop_bn_data_in_pvld) //|< w
  ,.chn_in_prdy (flop_bn_data_in_prdy) //|> w
  ,.chn_alu_op (bn_alu_in_data[16*1 -1:0]) //|< w
  ,.chn_alu_op_pvld (bn_alu_in_vld) //|< w
  ,.chn_alu_op_prdy (bn_alu_in_rdy) //|> w
  ,.chn_mul_op (bn_mul_in_data[16*1 -1:0]) //|< w
  ,.chn_mul_op_pvld (bn_mul_in_vld) //|< w
  ,.chn_mul_op_prdy (bn_mul_in_rdy) //|> w
  ,.chn_out_prdy (bn_data_out_prdy) //|< w
  ,.chn_data_out (bn_data_out_pd[32*1 -1:0]) //|> w
  ,.chn_out_pvld (bn_data_out_pvld) //|> w
  );
//covert 1 to 1
NV_NVDLA_SDP_CORE_unpack #(.IW(32*1),.OW(32*1)) u_bn_dpunpack (
   .nvdla_core_clk (nvdla_gated_ncore_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.inp_pvld (bn_data_out_pvld) //|< i
  ,.inp_data (bn_data_out_pd[32*1 -1:0]) //|< i
  ,.inp_prdy (bn_data_out_prdy) //|> o
  ,.out_pvld (flop_bn_data_out_pvld) //|> w
  ,.out_data (flop_bn_data_out_pd[32*1 -1:0]) //|> w
  ,.out_prdy (flop_bn_data_out_prdy) //|< w
  );
//===========================================
// MUX between BN and EW
//===========================================
assign flop_bn_data_out_prdy = flop_ew_data_out_prdy;
assign bn2ew_data_pvld = cfg_bn_en ? flop_bn_data_out_pvld : bs2bn_data_pvld;
assign ew_data_in_pd = cfg_bn_en ? flop_bn_data_out_pd : bn_data_in_pd;
assign flop_ew_data_out_prdy = cvt_data_in_prdy;
assign cvt_data_in_pvld = bn2ew_data_pvld;
assign cvt_data_in_pd = ew_data_in_pd;
NV_NVDLA_SDP_HLS_c u_c (
   .cfg_mode_eql (cfg_mode_eql) //|< r
  ,.cfg_out_precision (cfg_out_precision[1:0]) //|< r
  ,.cfg_offset (cfg_cvt_offset[31:0]) //|< r
  ,.cfg_scale (cfg_cvt_scale[15:0]) //|< r
  ,.cfg_truncate (cfg_cvt_shift[5:0]) //|< r
  ,.cvt_in_pvld (cvt_data_in_pvld) //|< w
  ,.cvt_in_prdy (cvt_data_in_prdy) //|> w
  ,.cvt_pd_in (cvt_data_in_pd[32*1 -1:0]) //|< w
  ,.cvt_out_pvld (cvt_data_out_pvld) //|> w
  ,.cvt_out_prdy (cvt_data_out_prdy) //|< w
  ,.cvt_pd_out (cvt_data_out_pd[16*1 +1 -1:0]) //|> w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  );
assign cvt_data_out_data = cvt_data_out_pd[16*1 -1:0];
assign cvt_data_out_sat = cvt_data_out_pd[16*1 +1 -1:16*1];
// to (PDP | WDMA)
assign cfg_mode_pdp = reg2dp_output_dst== 1'h1 ;
assign cvt_data_out_prdy = core2wdma_rdy & ((!cfg_mode_pdp) || core2pdp_rdy);
assign core2wdma_vld = cvt_data_out_pvld & ( (!cfg_mode_pdp) || core2pdp_rdy);
assign core2pdp_vld = cfg_mode_pdp & cvt_data_out_pvld & core2wdma_rdy;
assign core2wdma_pd = cfg_mode_pdp ? {8*1{1'b0}} : cvt_data_out_data;
assign core2pdp_pd = cfg_mode_pdp ? cvt_data_out_data[8*1 -1:0] : {8*1{1'b0}};
//covert 1 to atomic_m
//only int8 or int16. If support both, use NV_NVDLA_SDP_WDMA_unpack
NV_NVDLA_SDP_CORE_unpack #(.IW(8*1),.OW(8*8)) u_dpout_unpack (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.inp_pvld (core2wdma_vld)
  ,.inp_prdy (core2wdma_rdy)
  ,.inp_data (core2wdma_pd[8*1 -1:0])
  ,.out_pvld (sdp_dp2wdma_valid)
  ,.out_prdy (sdp_dp2wdma_ready)
  ,.out_data (sdp_dp2wdma_pd[8*8 -1:0])
  );
//pdp THROUGHPUT is 1
NV_NVDLA_SDP_CORE_pipe_p11 pipe_p11 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.core2pdp_pd (core2pdp_pd[8*1 -1:0]) //|< w
  ,.core2pdp_vld (core2pdp_vld) //|< w
  ,.core2pdp_rdy (core2pdp_rdy) //|> w
  ,.sdp2pdp_pd (sdp2pdp_pd[8*1 -1:0]) //|> o
  ,.sdp2pdp_valid (sdp2pdp_valid) //|> o
  ,.sdp2pdp_ready (sdp2pdp_ready) //|< i
  );
//===========================================
// PERF STATISTIC: SATURATION
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    saturation_bits <= {1{1'b0}};
  end else begin
    if (cvt_data_out_pvld & cvt_data_out_prdy) begin
          saturation_bits <= cvt_data_out_sat;
    end else begin
        saturation_bits <= 0;
    end
  end
end
assign cvt_saturation_add = fun_my_bit_sum({{(16-1){1'b0}},saturation_bits});
assign cvt_saturation_sub = 1'b0;
assign cvt_saturation_clr = op_en_load;
assign cvt_saturation_cen = reg2dp_perf_sat_en;
assign cvt_sat_add_ext = cvt_saturation_add;
assign cvt_sat_sub_ext = {{4{1'b0}}, cvt_saturation_sub};
assign cvt_sat_inc = cvt_sat_add_ext > cvt_sat_sub_ext;
assign cvt_sat_dec = cvt_sat_add_ext < cvt_sat_sub_ext;
assign cvt_sat_mod_ext[4:0] = cvt_sat_inc ? (cvt_sat_add_ext - cvt_sat_sub_ext) : (cvt_sat_sub_ext - cvt_sat_add_ext); // spyglass disable W484 
assign cvt_sat_sub_guard = (|cvt_saturation_cnt[31:1])==1'b0;
assign cvt_sat_sub_act = cvt_saturation_cnt[0:0];
assign cvt_sat_sub_act_ext = {{4{1'b0}}, cvt_sat_sub_act};
assign cvt_sat_sub_flow = cvt_sat_dec & cvt_sat_sub_guard & (cvt_sat_sub_act_ext < cvt_sat_mod_ext);
assign cvt_sat_add_guard = (&cvt_saturation_cnt[31:5])==1'b1;
assign cvt_sat_add_act = cvt_saturation_cnt[4:0];
assign cvt_sat_add_act_ext = cvt_sat_add_act;
assign cvt_sat_add_flow = cvt_sat_inc & cvt_sat_add_guard & (cvt_sat_add_act_ext + cvt_sat_mod_ext > 31 );
assign i_add = cvt_sat_add_flow ? (31 - cvt_sat_add_act) : cvt_sat_sub_flow ? 0 : cvt_saturation_add;
assign i_sub = cvt_sat_sub_flow ? (cvt_sat_sub_act) : cvt_sat_add_flow ? 0 : cvt_saturation_sub ;
always @(
  i_add
  or i_sub
  ) begin
  cvt_sat_cvt_sat_adv = i_add[4:0] != {{4{1'b0}}, i_sub[0:0]};
end
always @(
  cvt_sat_cvt_sat_cnt_cur
  or i_add
  or i_sub
  or cvt_sat_cvt_sat_adv
  or cvt_saturation_clr
  ) begin
  cvt_sat_cvt_sat_cnt_ext[33:0] = {1'b0, 1'b0, cvt_sat_cvt_sat_cnt_cur};
  cvt_sat_cvt_sat_cnt_mod[33:0] = cvt_sat_cvt_sat_cnt_cur + i_add[4:0] - i_sub[0:0]; // spyglass disable W164b
  cvt_sat_cvt_sat_cnt_new[33:0] = (cvt_sat_cvt_sat_adv)? cvt_sat_cvt_sat_cnt_mod[33:0] : cvt_sat_cvt_sat_cnt_ext[33:0];
  cvt_sat_cvt_sat_cnt_nxt[33:0] = (cvt_saturation_clr)? 34'd0 : cvt_sat_cvt_sat_cnt_new[33:0];
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cvt_sat_cvt_sat_cnt_cur[31:0] <= 0;
  end else begin
  if (cvt_saturation_cen) begin
  cvt_sat_cvt_sat_cnt_cur[31:0] <= cvt_sat_cvt_sat_cnt_nxt[31:0];
  end
  end
end
always @(
  cvt_sat_cvt_sat_cnt_cur
  ) begin
  cvt_saturation_cnt[31:0] = cvt_sat_cvt_sat_cnt_cur[31:0];
end
assign dp2reg_out_saturation = cvt_saturation_cnt;
function [4:0] fun_my_bit_sum;
  input [15:0] idata;
  reg [4:0] ocnt;
  begin
    ocnt =
        ((( idata[0]
      + idata[1]
      + idata[2] )
      + ( idata[3]
      + idata[4]
      + idata[5] ))
      + (( idata[6]
      + idata[7]
      + idata[8] )
      + ( idata[9]
      + idata[10]
      + idata[11] )))
      + ( idata[12]
      + idata[13]
      + idata[14] )
      + idata[15] ;
    fun_my_bit_sum = ocnt;
  end
endfunction
endmodule // NV_NVDLA_SDP_core
// **************************************************************************************************************
// Generated by ::pipe -m -bc sdp2pdp_pd (sdp2pdp_valid,sdp2pdp_ready) <= core2pdp_pd[255:0] (core2pdp_vld,core2pdp_rdy)
// **************************************************************************************************************
module NV_NVDLA_SDP_CORE_pipe_p11 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,core2pdp_pd
  ,core2pdp_vld
  ,sdp2pdp_ready
  ,core2pdp_rdy
  ,sdp2pdp_pd
  ,sdp2pdp_valid
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [8*1 -1:0] core2pdp_pd;
input core2pdp_vld;
input sdp2pdp_ready;
output core2pdp_rdy;
output [8*1 -1:0] sdp2pdp_pd;
output sdp2pdp_valid;
//: my $dw = 8*1;
//: &eperl::pipe("-is -wid $dw -do sdp2pdp_pd -vo sdp2pdp_valid -ri sdp2pdp_ready -di core2pdp_pd -vi core2pdp_vld -ro core2pdp_rdy");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg core2pdp_rdy;
reg skid_flop_core2pdp_rdy;
reg skid_flop_core2pdp_vld;
reg [8-1:0] skid_flop_core2pdp_pd;
reg pipe_skid_core2pdp_vld;
reg [8-1:0] pipe_skid_core2pdp_pd;
// Wire
wire skid_core2pdp_vld;
wire [8-1:0] skid_core2pdp_pd;
wire skid_core2pdp_rdy;
wire pipe_skid_core2pdp_rdy;
wire sdp2pdp_valid;
wire [8-1:0] sdp2pdp_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       core2pdp_rdy <= 1'b1;
       skid_flop_core2pdp_rdy <= 1'b1;
   end else begin
       core2pdp_rdy <= skid_core2pdp_rdy;
       skid_flop_core2pdp_rdy <= skid_core2pdp_rdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_core2pdp_vld <= 1'b0;
    end else begin
        if (skid_flop_core2pdp_rdy) begin
            skid_flop_core2pdp_vld <= core2pdp_vld;
        end
   end
end
assign skid_core2pdp_vld = (skid_flop_core2pdp_rdy) ? core2pdp_vld : skid_flop_core2pdp_vld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_core2pdp_rdy & core2pdp_vld) begin
        skid_flop_core2pdp_pd[8-1:0] <= core2pdp_pd[8-1:0];
    end
end
assign skid_core2pdp_pd[8-1:0] = (skid_flop_core2pdp_rdy) ? core2pdp_pd[8-1:0] : skid_flop_core2pdp_pd[8-1:0];


// PIPE READY
assign skid_core2pdp_rdy = pipe_skid_core2pdp_rdy || !pipe_skid_core2pdp_vld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_core2pdp_vld <= 1'b0;
    end else begin
        if (skid_core2pdp_rdy) begin
            pipe_skid_core2pdp_vld <= skid_core2pdp_vld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_core2pdp_rdy && skid_core2pdp_vld) begin
        pipe_skid_core2pdp_pd[8-1:0] <= skid_core2pdp_pd[8-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_core2pdp_rdy = sdp2pdp_ready;
assign sdp2pdp_valid = pipe_skid_core2pdp_vld;
assign sdp2pdp_pd = pipe_skid_core2pdp_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_SDP_CORE_pipe_p11
