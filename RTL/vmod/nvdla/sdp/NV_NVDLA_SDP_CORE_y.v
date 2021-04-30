// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_CORE_y.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_define.h
module NV_NVDLA_SDP_CORE_y (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,op_en_load //|< i
  ,pwrbus_ram_pd //|< i
  ,ew_alu_in_rdy //|> o
  ,ew_alu_in_data //|< i
  ,ew_alu_in_vld //|< i
  ,ew_mul_in_data //|< i
  ,ew_mul_in_vld //|< i
  ,ew_mul_in_rdy //|> o
  ,ew_data_in_pd //|< i
  ,ew_data_in_pvld //|< i
  ,ew_data_in_prdy //|> o
  ,reg2dp_nan_to_zero //|< i
  ,reg2dp_perf_lut_en //|< i
  ,reg2dp_proc_precision //|< i
  ,reg2dp_ew_alu_algo //|< i
  ,reg2dp_ew_alu_bypass //|< i
  ,reg2dp_ew_alu_cvt_bypass //|< i
  ,reg2dp_ew_alu_cvt_offset //|< i
  ,reg2dp_ew_alu_cvt_scale //|< i
  ,reg2dp_ew_alu_cvt_truncate //|< i
  ,reg2dp_ew_alu_operand //|< i
  ,reg2dp_ew_alu_src //|< i
  ,reg2dp_ew_lut_bypass //|< i
  ,reg2dp_ew_mul_bypass //|< i
  ,reg2dp_ew_mul_cvt_bypass //|< i
  ,reg2dp_ew_mul_cvt_offset //|< i
  ,reg2dp_ew_mul_cvt_scale //|< i
  ,reg2dp_ew_mul_cvt_truncate //|< i
  ,reg2dp_ew_mul_operand //|< i
  ,reg2dp_ew_mul_prelu //|< i
  ,reg2dp_ew_mul_src //|< i
  ,reg2dp_ew_truncate //|< i
  ,ew_data_out_pd //|> o
  ,ew_data_out_pvld //|> o
  ,ew_data_out_prdy //|< i
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [16*0 -1:0] ew_alu_in_data;
input ew_alu_in_vld;
output ew_alu_in_rdy;
input [32*0 -1:0] ew_data_in_pd;
input ew_data_in_pvld;
output ew_data_in_prdy;
input [16*0 -1:0] ew_mul_in_data;
input ew_mul_in_vld;
output ew_mul_in_rdy;
output [32*0 -1:0] ew_data_out_pd;
output ew_data_out_pvld;
input ew_data_out_prdy;
input [1:0] reg2dp_ew_alu_algo;
input reg2dp_ew_alu_bypass;
input reg2dp_ew_alu_cvt_bypass;
input [31:0] reg2dp_ew_alu_cvt_offset;
input [15:0] reg2dp_ew_alu_cvt_scale;
input [5:0] reg2dp_ew_alu_cvt_truncate;
input [31:0] reg2dp_ew_alu_operand;
input reg2dp_ew_alu_src;
input reg2dp_ew_lut_bypass;
input reg2dp_ew_mul_bypass;
input reg2dp_ew_mul_cvt_bypass;
input [31:0] reg2dp_ew_mul_cvt_offset;
input [15:0] reg2dp_ew_mul_cvt_scale;
input [5:0] reg2dp_ew_mul_cvt_truncate;
input [31:0] reg2dp_ew_mul_operand;
input reg2dp_ew_mul_prelu;
input reg2dp_ew_mul_src;
input [9:0] reg2dp_ew_truncate;
input reg2dp_nan_to_zero;
input reg2dp_perf_lut_en;
input [1:0] reg2dp_proc_precision;
//&Ports /^cfg/;
input [31:0] pwrbus_ram_pd;
input op_en_load;
reg [1:0] cfg_ew_alu_algo;
reg cfg_ew_alu_bypass;
reg cfg_ew_alu_cvt_bypass;
reg [31:0] cfg_ew_alu_cvt_offset;
reg [15:0] cfg_ew_alu_cvt_scale;
reg [5:0] cfg_ew_alu_cvt_truncate;
reg [31:0] cfg_ew_alu_operand;
reg cfg_ew_alu_src;
reg cfg_ew_lut_bypass;
reg cfg_ew_mul_bypass;
reg cfg_ew_mul_cvt_bypass;
reg [31:0] cfg_ew_mul_cvt_offset;
reg [15:0] cfg_ew_mul_cvt_scale;
reg [5:0] cfg_ew_mul_cvt_truncate;
reg [31:0] cfg_ew_mul_operand;
reg cfg_ew_mul_prelu;
reg cfg_ew_mul_src;
reg [9:0] cfg_ew_truncate;
reg cfg_nan_to_zero;
reg [1:0] cfg_proc_precision;
wire [32*0 -1:0] alu_cvt_out_pd;
wire alu_cvt_out_prdy;
wire alu_cvt_out_pvld;
wire [32*0 -1:0] mul_cvt_out_pd;
wire mul_cvt_out_prdy;
wire mul_cvt_out_pvld;
wire [32*0 -1:0] core_out_pd;
wire core_out_prdy;
wire core_out_pvld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cfg_proc_precision <= {2{1'b0}};
    cfg_nan_to_zero <= 1'b0;
    cfg_ew_alu_operand <= {32{1'b0}};
    cfg_ew_alu_bypass <= 1'b0;
    cfg_ew_alu_algo <= {2{1'b0}};
    cfg_ew_alu_src <= 1'b0;
    cfg_ew_alu_cvt_bypass <= 1'b0;
    cfg_ew_alu_cvt_offset <= {32{1'b0}};
    cfg_ew_alu_cvt_scale <= {16{1'b0}};
    cfg_ew_alu_cvt_truncate <= {6{1'b0}};
    cfg_ew_mul_operand <= {32{1'b0}};
    cfg_ew_mul_bypass <= 1'b0;
    cfg_ew_mul_src <= 1'b0;
    cfg_ew_mul_cvt_bypass <= 1'b0;
    cfg_ew_mul_cvt_offset <= {32{1'b0}};
    cfg_ew_mul_cvt_scale <= {16{1'b0}};
    cfg_ew_mul_cvt_truncate <= {6{1'b0}};
    cfg_ew_truncate <= {10{1'b0}};
    cfg_ew_mul_prelu <= 1'b0;
    cfg_ew_lut_bypass <= 1'b1;
  end else begin
    if (op_en_load) begin
        cfg_proc_precision <= reg2dp_proc_precision ;
        cfg_nan_to_zero <= reg2dp_nan_to_zero ;
        cfg_ew_alu_operand <= reg2dp_ew_alu_operand ;
        cfg_ew_alu_bypass <= reg2dp_ew_alu_bypass ;
        cfg_ew_alu_algo <= reg2dp_ew_alu_algo ;
        cfg_ew_alu_src <= reg2dp_ew_alu_src ;
        cfg_ew_alu_cvt_bypass <= reg2dp_ew_alu_cvt_bypass ;
        cfg_ew_alu_cvt_offset <= reg2dp_ew_alu_cvt_offset ;
        cfg_ew_alu_cvt_scale <= reg2dp_ew_alu_cvt_scale ;
        cfg_ew_alu_cvt_truncate <= reg2dp_ew_alu_cvt_truncate;
        cfg_ew_mul_operand <= reg2dp_ew_mul_operand ;
        cfg_ew_mul_bypass <= reg2dp_ew_mul_bypass ;
        cfg_ew_mul_src <= reg2dp_ew_mul_src ;
        cfg_ew_mul_cvt_bypass <= reg2dp_ew_mul_cvt_bypass ;
        cfg_ew_mul_cvt_offset <= reg2dp_ew_mul_cvt_offset ;
        cfg_ew_mul_cvt_scale <= reg2dp_ew_mul_cvt_scale ;
        cfg_ew_mul_cvt_truncate <= reg2dp_ew_mul_cvt_truncate;
        cfg_ew_truncate <= reg2dp_ew_truncate ;
        cfg_ew_mul_prelu <= reg2dp_ew_mul_prelu ;
        cfg_ew_lut_bypass <= 1'b1;
    end
  end
end
//===========================================
// y input pipe
//===========================================
//=================================================
NV_NVDLA_SDP_HLS_Y_cvt_top u_alu_cvt (
   .cfg_cvt_bypass (cfg_ew_alu_cvt_bypass) //|< r
  ,.cfg_cvt_offset (cfg_ew_alu_cvt_offset[31:0]) //|< r
  ,.cfg_cvt_scale (cfg_ew_alu_cvt_scale[15:0]) //|< r
  ,.cfg_cvt_truncate (cfg_ew_alu_cvt_truncate[5:0]) //|< r
  ,.cvt_data_in (ew_alu_in_data[16*0 -1:0]) //|< w
  ,.cvt_in_pvld (ew_alu_in_vld) //|< w
  ,.cvt_in_prdy (ew_alu_in_rdy) //|> w
  ,.cvt_out_prdy (alu_cvt_out_prdy) //|< w
  ,.cvt_data_out (alu_cvt_out_pd[32*0 -1:0]) //|> w
  ,.cvt_out_pvld (alu_cvt_out_pvld) //|> w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  );
NV_NVDLA_SDP_HLS_Y_cvt_top u_mul_cvt (
   .cfg_cvt_bypass (cfg_ew_mul_cvt_bypass) //|< r
  ,.cfg_cvt_offset (cfg_ew_mul_cvt_offset[31:0]) //|< r
  ,.cfg_cvt_scale (cfg_ew_mul_cvt_scale[15:0]) //|< r
  ,.cfg_cvt_truncate (cfg_ew_mul_cvt_truncate[5:0]) //|< r
  ,.cvt_data_in (ew_mul_in_data[16*0 -1:0]) //|< w
  ,.cvt_in_pvld (ew_mul_in_vld) //|< w
  ,.cvt_in_prdy (ew_mul_in_rdy) //|> w
  ,.cvt_out_prdy (mul_cvt_out_prdy) //|< w
  ,.cvt_data_out (mul_cvt_out_pd[32*0 -1:0]) //|> w
  ,.cvt_out_pvld (mul_cvt_out_pvld) //|> w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  );
NV_NVDLA_SDP_HLS_Y_int_core u_core (
   .cfg_alu_algo (cfg_ew_alu_algo[1:0]) //|< r
  ,.cfg_alu_bypass (cfg_ew_alu_bypass) //|< r
  ,.cfg_alu_op (cfg_ew_alu_operand[31:0]) //|< r
  ,.cfg_alu_src (cfg_ew_alu_src) //|< r
  ,.cfg_mul_bypass (cfg_ew_mul_bypass) //|< r
  ,.cfg_mul_op (cfg_ew_mul_operand[31:0]) //|< r
  ,.cfg_mul_prelu (cfg_ew_mul_prelu) //|< r
  ,.cfg_mul_src (cfg_ew_mul_src) //|< r
  ,.cfg_mul_truncate (cfg_ew_truncate[9:0]) //|< r
  ,.chn_alu_op (alu_cvt_out_pd[32*0 -1:0]) //|< w
  ,.chn_alu_op_pvld (alu_cvt_out_pvld) //|< w
  ,.chn_data_in (ew_data_in_pd[32*0 -1:0]) //|< w
  ,.chn_in_pvld (ew_data_in_pvld) //|< w
  ,.chn_in_prdy (ew_data_in_prdy) //|> w
  ,.chn_mul_op (mul_cvt_out_pd[32*0 -1:0]) //|< w
  ,.chn_mul_op_pvld (mul_cvt_out_pvld) //|< w
  ,.chn_alu_op_prdy (alu_cvt_out_prdy) //|> w
  ,.chn_mul_op_prdy (mul_cvt_out_prdy) //|> w
  ,.chn_data_out (core_out_pd[32*0 -1:0]) //|> w
  ,.chn_out_pvld (core_out_pvld) //|> w
  ,.chn_out_prdy (core_out_prdy) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  );
assign core_out_prdy = ew_data_out_prdy;
assign ew_data_out_pvld = core_out_pvld;
assign ew_data_out_pd = core_out_pd;
endmodule // NV_NVDLA_SDP_CORE_y
