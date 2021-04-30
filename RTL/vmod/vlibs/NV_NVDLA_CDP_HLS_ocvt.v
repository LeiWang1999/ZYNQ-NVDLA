// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_HLS_ocvt.v
module NV_NVDLA_CDP_HLS_ocvt (
   cfg_alu_in //|< i
  ,cfg_mul_in //|< i
  ,cfg_precision //|< i
  ,cfg_truncate //|< i
  ,chn_data_in //|< i
  ,chn_in_pvld //|< i
  ,chn_out_prdy //|< i
  ,nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,chn_data_out //|> o
  ,chn_in_prdy //|> o
  ,chn_out_pvld //|> o
  );
input [31:0] cfg_alu_in;
input [15:0] cfg_mul_in;
input [1:0] cfg_precision;
input [5:0] cfg_truncate;
input [49:0] chn_data_in;
input chn_in_pvld;
input chn_out_prdy;
input nvdla_core_clk;
input nvdla_core_rstn;
output [17:0] chn_data_out;
output chn_in_prdy;
output chn_out_pvld;
wire [25:0] cfg_alu_ext;
wire [33:0] chn_alu_ext;
wire [33:0] chn_data_ext;
wire [24:0] chn_data_lsb;
wire [24:0] chn_data_msb;
wire [32:0] chn_data_tmp;
wire [17:0] chn_dout;
wire [15:0] chn_int16_dout;
wire chn_int16_prdy;
wire chn_int16_pvld;
wire [1:0] chn_int16_sat;
wire [15:0] chn_int8_dout;
wire chn_int8_prdy;
wire chn_int8_pvld;
wire [1:0] chn_int8_sat;
wire [25:0] data_lsb_ext;
wire [25:0] data_msb_ext;
wire mon_sub_c;
wire mon_sub_lc;
wire mon_sub_mc;
wire [49:0] mul_data_out;
wire [49:0] mul_dout;
wire [41:0] mul_lsb_data_out;
wire [41:0] mul_lsb_dout;
wire [41:0] mul_msb_data_out;
wire [41:0] mul_msb_dout;
wire mul_out_prdy;
wire mul_out_pvld;
wire mul_outh_prdy;
wire mul_outh_pvld;
wire sat_data_out;
wire sat_dout;
wire [1:0] sat_int8_data_out;
wire [1:0] sat_int8_dout;
wire sat_lsb_dout;
wire sat_msb_dout;
wire [33:0] sub_data_out;
wire [33:0] sub_dout;
wire [25:0] sub_lsb_data_out;
wire [25:0] sub_lsb_dout;
wire [25:0] sub_msb_data_out;
wire [25:0] sub_msb_dout;
wire sub_out_prdy;
wire sub_out_pvld;
wire sub_outh_prdy;
wire sub_outh_pvld;
wire [15:0] tru_data_out;
wire [15:0] tru_dout;
wire tru_final_prdy;
wire tru_final_pvld;
wire [15:0] tru_int8_data_out;
wire [15:0] tru_int8_dout;
wire [7:0] tru_lsb_dout;
wire [7:0] tru_msb_dout;
wire tru_out_prdy;
wire tru_out_pvld;
wire tru_outh_prdy;
wire tru_outh_pvld;
// synoff nets
// monitor nets
// debug nets
// tie high nets
// tie low nets
// no connect nets
// not all bits used nets
// todo nets
//int8 cvt
assign chn_data_lsb[24:0] = chn_data_in[24:0];
assign chn_data_msb[24:0] = chn_data_in[49:25];
assign data_lsb_ext[25:0] = {{1{chn_data_lsb[24]}}, chn_data_lsb[24:0]};
assign data_msb_ext[25:0] = {{1{chn_data_msb[24]}}, chn_data_msb[24:0]};
assign cfg_alu_ext[25:0] = {{1{cfg_alu_in[24]}}, cfg_alu_in[24:0]};
//sub
assign {mon_sub_lc,sub_lsb_dout[25:0]} = $signed(data_lsb_ext[25:0]) -$signed(cfg_alu_ext[25:0]);
assign {mon_sub_mc,sub_msb_dout[25:0]} = $signed(data_msb_ext[25:0]) -$signed(cfg_alu_ext[25:0]);
NV_NVDLA_CDP_HLS_OCVT_pipe_p1 pipe_p1 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.chn_int8_pvld (chn_int8_pvld) //|< w
  ,.sub_lsb_dout (sub_lsb_dout[25:0]) //|< w
  ,.sub_msb_dout (sub_msb_dout[25:0]) //|< w
  ,.sub_outh_prdy (sub_outh_prdy) //|< w
  ,.chn_int8_prdy (chn_int8_prdy) //|> w
  ,.sub_lsb_data_out (sub_lsb_data_out[25:0]) //|> w
  ,.sub_msb_data_out (sub_msb_data_out[25:0]) //|> w
  ,.sub_outh_pvld (sub_outh_pvld) //|> w
  );
//mul
assign mul_lsb_dout[41:0] = $signed(sub_lsb_data_out[25:0]) * $signed(cfg_mul_in[15:0]);
assign mul_msb_dout[41:0] = $signed(sub_msb_data_out[25:0]) * $signed(cfg_mul_in[15:0]);
NV_NVDLA_CDP_HLS_OCVT_pipe_p2 pipe_p2 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.mul_lsb_dout (mul_lsb_dout[41:0]) //|< w
  ,.mul_msb_dout (mul_msb_dout[41:0]) //|< w
  ,.mul_outh_prdy (mul_outh_prdy) //|< w
  ,.sub_outh_pvld (sub_outh_pvld) //|< w
  ,.mul_lsb_data_out (mul_lsb_data_out[41:0]) //|> w
  ,.mul_msb_data_out (mul_msb_data_out[41:0]) //|> w
  ,.mul_outh_pvld (mul_outh_pvld) //|> w
  ,.sub_outh_prdy (sub_outh_prdy) //|> w
  );
//truncate
NV_NVDLA_HLS_shiftrightsatsu #(.IN_WIDTH(16 + 26 ),.OUT_WIDTH(8 ),.SHIFT_WIDTH(6 )) shiftrightsat_su_lsb (
   .data_in (mul_lsb_data_out[41:0]) //|< w
  ,.shift_num (cfg_truncate[5:0]) //|< i
  ,.data_out (tru_lsb_dout[7:0]) //|> w
  ,.sat_out (sat_lsb_dout) //|> w
  );
//signed
//unsigned
NV_NVDLA_HLS_shiftrightsatsu #(.IN_WIDTH(16 + 26 ),.OUT_WIDTH(8 ),.SHIFT_WIDTH(6 )) shiftrightsat_su_msb (
   .data_in (mul_msb_data_out[41:0]) //|< w
  ,.shift_num (cfg_truncate[5:0]) //|< i
  ,.data_out (tru_msb_dout[7:0]) //|> w
  ,.sat_out (sat_msb_dout) //|> w
  );
//signed
//unsigned
assign tru_int8_dout[15:0] = {tru_msb_dout[7:0],tru_lsb_dout[7:0]};
assign sat_int8_dout[1:0] = {sat_msb_dout,sat_lsb_dout};
NV_NVDLA_CDP_HLS_OCVT_pipe_p3 pipe_p3 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.mul_outh_pvld (mul_outh_pvld) //|< w
  ,.sat_int8_dout (sat_int8_dout[1:0]) //|< w
  ,.tru_int8_dout (tru_int8_dout[15:0]) //|< w
  ,.tru_outh_prdy (tru_outh_prdy) //|< w
  ,.mul_outh_prdy (mul_outh_prdy) //|> w
  ,.sat_int8_data_out (sat_int8_data_out[1:0]) //|> w
  ,.tru_int8_data_out (tru_int8_data_out[15:0]) //|> w
  ,.tru_outh_pvld (tru_outh_pvld) //|> w
  );
assign chn_int8_dout[15:0] = tru_int8_data_out[15:0];
assign chn_int8_sat[1:0] = sat_int8_data_out[1:0];
/////////int16 covert 
assign chn_data_tmp[32:0] = chn_data_in[32:0];
assign chn_data_ext[33:0] = {{1{chn_data_tmp[32]}}, chn_data_tmp[32:0]};
assign chn_alu_ext[33:0] = {{2{cfg_alu_in[31]}}, cfg_alu_in[31:0]};
//sub
assign {mon_sub_c,sub_dout[33:0]} = $signed(chn_data_ext[33:0]) -$signed(chn_alu_ext[33:0]);
NV_NVDLA_CDP_HLS_OCVT_pipe_p4 pipe_p4 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.chn_int16_pvld (chn_int16_pvld) //|< w
  ,.sub_dout (sub_dout[33:0]) //|< w
  ,.sub_out_prdy (sub_out_prdy) //|< w
  ,.chn_int16_prdy (chn_int16_prdy) //|> w
  ,.sub_data_out (sub_data_out[33:0]) //|> w
  ,.sub_out_pvld (sub_out_pvld) //|> w
  );
//mul
assign mul_dout[49:0] = $signed(sub_data_out[33:0]) * $signed(cfg_mul_in[15:0]);
NV_NVDLA_CDP_HLS_OCVT_pipe_p5 pipe_p5 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.mul_dout (mul_dout[49:0]) //|< w
  ,.mul_out_prdy (mul_out_prdy) //|< w
  ,.sub_out_pvld (sub_out_pvld) //|< w
  ,.mul_data_out (mul_data_out[49:0]) //|> w
  ,.mul_out_pvld (mul_out_pvld) //|> w
  ,.sub_out_prdy (sub_out_prdy) //|> w
  );
//truncate
NV_NVDLA_HLS_shiftrightsatsu #(.IN_WIDTH(16 + 34 ),.OUT_WIDTH(16 ),.SHIFT_WIDTH(6 )) shiftrightsat_su (
   .data_in (mul_data_out[49:0]) //|< w
  ,.shift_num (cfg_truncate[5:0]) //|< i
  ,.data_out (tru_dout[15:0]) //|> w
  ,.sat_out (sat_dout) //|> w
  );
//signed
//unsigned
NV_NVDLA_CDP_HLS_OCVT_pipe_p6 pipe_p6 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.mul_out_pvld (mul_out_pvld) //|< w
  ,.sat_dout (sat_dout) //|< w
  ,.tru_dout (tru_dout[15:0]) //|< w
  ,.tru_out_prdy (tru_out_prdy) //|< w
  ,.mul_out_prdy (mul_out_prdy) //|> w
  ,.sat_data_out (sat_data_out) //|> w
  ,.tru_data_out (tru_data_out[15:0]) //|> w
  ,.tru_out_pvld (tru_out_pvld) //|> w
  );
assign chn_int16_dout[15:0] = tru_data_out;
assign chn_int16_sat[1:0] = {1'b0,sat_data_out};
//mux int16 and int8 final data out
assign chn_in_prdy = (cfg_precision[1:0] == 1 ) ? chn_int16_prdy : chn_int8_prdy;
assign chn_int8_pvld = (cfg_precision[1:0] == 1 ) ? 1'b0 : chn_in_pvld;
assign chn_int16_pvld = (cfg_precision[1:0] == 1 ) ? chn_in_pvld : 1'b0;
assign tru_final_pvld = (cfg_precision[1:0] == 1 ) ? tru_out_pvld : tru_outh_pvld;
assign tru_out_prdy = (cfg_precision[1:0] == 1 ) ? tru_final_prdy : 1'b1;
assign tru_outh_prdy = (cfg_precision[1:0] == 1 ) ? 1'b1: tru_final_prdy;
assign chn_dout[17:0] = (cfg_precision[1:0] == 1 ) ? {chn_int16_sat[1:0],chn_int16_dout[15:0]} : {chn_int8_sat[1:0],chn_int8_dout[15:0]};
NV_NVDLA_CDP_HLS_OCVT_pipe_p7 pipe_p7 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.chn_dout (chn_dout[17:0]) //|< w
  ,.chn_out_prdy (chn_out_prdy) //|< i
  ,.tru_final_pvld (tru_final_pvld) //|< w
  ,.chn_data_out (chn_data_out[17:0]) //|> o
  ,.chn_out_pvld (chn_out_pvld) //|> o
  ,.tru_final_prdy (tru_final_prdy) //|> w
  );
endmodule // NV_NVDLA_CDP_HLS_ocvt
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none -is {sub_msb_data_out[25:0],sub_lsb_data_out[25:0]} (sub_outh_pvld,sub_outh_prdy) <= {sub_msb_dout[25:0],sub_lsb_dout[25:0]} (chn_int8_pvld,chn_int8_prdy)
// **************************************************************************************************************
module NV_NVDLA_CDP_HLS_OCVT_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,chn_int8_pvld
  ,sub_lsb_dout
  ,sub_msb_dout
  ,sub_outh_prdy
  ,chn_int8_prdy
  ,sub_lsb_data_out
  ,sub_msb_data_out
  ,sub_outh_pvld
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input chn_int8_pvld;
input [25:0] sub_lsb_dout;
input [25:0] sub_msb_dout;
input sub_outh_prdy;
output chn_int8_prdy;
output [25:0] sub_lsb_data_out;
output [25:0] sub_msb_data_out;
output sub_outh_pvld;
reg chn_int8_prdy;
reg [51:0] p1_pipe_data;
reg p1_pipe_ready;
reg p1_pipe_ready_bc;
reg p1_pipe_valid;
reg p1_skid_catch;
reg [51:0] p1_skid_data;
reg [51:0] p1_skid_pipe_data;
reg p1_skid_pipe_ready;
reg p1_skid_pipe_valid;
reg p1_skid_ready;
reg p1_skid_ready_flop;
reg p1_skid_valid;
reg [25:0] sub_lsb_data_out;
reg [25:0] sub_msb_data_out;
reg sub_outh_pvld;
//## pipe (1) skid buffer
always @(
  chn_int8_pvld
  or p1_skid_ready_flop
  or p1_skid_pipe_ready
  or p1_skid_valid
  ) begin
  p1_skid_catch = chn_int8_pvld && p1_skid_ready_flop && !p1_skid_pipe_ready;
  p1_skid_ready = (p1_skid_valid)? p1_skid_pipe_ready : !p1_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p1_skid_valid <= 1'b0;
    p1_skid_ready_flop <= 1'b1;
    chn_int8_prdy <= 1'b1;
  end else begin
  p1_skid_valid <= (p1_skid_valid)? !p1_skid_pipe_ready : p1_skid_catch;
  p1_skid_ready_flop <= p1_skid_ready;
  chn_int8_prdy <= p1_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p1_skid_data <= (p1_skid_catch)? {sub_msb_dout[25:0],sub_lsb_dout[25:0]} : p1_skid_data;
// VCS sop_coverage_off end
end
always @(
  p1_skid_ready_flop
  or chn_int8_pvld
  or p1_skid_valid
  or sub_msb_dout
  or sub_lsb_dout
  or p1_skid_data
  ) begin
  p1_skid_pipe_valid = (p1_skid_ready_flop)? chn_int8_pvld : p1_skid_valid;
// VCS sop_coverage_off start
  p1_skid_pipe_data = (p1_skid_ready_flop)? {sub_msb_dout[25:0],sub_lsb_dout[25:0]} : p1_skid_data;
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
  or sub_outh_prdy
  or p1_pipe_data
  ) begin
  sub_outh_pvld = p1_pipe_valid;
  p1_pipe_ready = sub_outh_prdy;
  {sub_msb_data_out[25:0],sub_lsb_data_out[25:0]} = p1_pipe_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_1x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (sub_outh_pvld^sub_outh_prdy^chn_int8_pvld^chn_int8_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_2x (nvdla_core_clk, `ASSERT_RESET, (chn_int8_pvld && !chn_int8_prdy), (chn_int8_pvld), (chn_int8_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_HLS_OCVT_pipe_p1
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none -is {mul_msb_data_out[41:0],mul_lsb_data_out[41:0]} (mul_outh_pvld,mul_outh_prdy) <= {mul_msb_dout[41:0],mul_lsb_dout[41:0]} (sub_outh_pvld,sub_outh_prdy)
// **************************************************************************************************************
module NV_NVDLA_CDP_HLS_OCVT_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mul_lsb_dout
  ,mul_msb_dout
  ,mul_outh_prdy
  ,sub_outh_pvld
  ,mul_lsb_data_out
  ,mul_msb_data_out
  ,mul_outh_pvld
  ,sub_outh_prdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [41:0] mul_lsb_dout;
input [41:0] mul_msb_dout;
input mul_outh_prdy;
input sub_outh_pvld;
output [41:0] mul_lsb_data_out;
output [41:0] mul_msb_data_out;
output mul_outh_pvld;
output sub_outh_prdy;
reg [41:0] mul_lsb_data_out;
reg [41:0] mul_msb_data_out;
reg mul_outh_pvld;
reg [83:0] p2_pipe_data;
reg p2_pipe_ready;
reg p2_pipe_ready_bc;
reg p2_pipe_valid;
reg p2_skid_catch;
reg [83:0] p2_skid_data;
reg [83:0] p2_skid_pipe_data;
reg p2_skid_pipe_ready;
reg p2_skid_pipe_valid;
reg p2_skid_ready;
reg p2_skid_ready_flop;
reg p2_skid_valid;
reg sub_outh_prdy;
//## pipe (2) skid buffer
always @(
  sub_outh_pvld
  or p2_skid_ready_flop
  or p2_skid_pipe_ready
  or p2_skid_valid
  ) begin
  p2_skid_catch = sub_outh_pvld && p2_skid_ready_flop && !p2_skid_pipe_ready;
  p2_skid_ready = (p2_skid_valid)? p2_skid_pipe_ready : !p2_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p2_skid_valid <= 1'b0;
    p2_skid_ready_flop <= 1'b1;
    sub_outh_prdy <= 1'b1;
  end else begin
  p2_skid_valid <= (p2_skid_valid)? !p2_skid_pipe_ready : p2_skid_catch;
  p2_skid_ready_flop <= p2_skid_ready;
  sub_outh_prdy <= p2_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p2_skid_data <= (p2_skid_catch)? {mul_msb_dout[41:0],mul_lsb_dout[41:0]} : p2_skid_data;
// VCS sop_coverage_off end
end
always @(
  p2_skid_ready_flop
  or sub_outh_pvld
  or p2_skid_valid
  or mul_msb_dout
  or mul_lsb_dout
  or p2_skid_data
  ) begin
  p2_skid_pipe_valid = (p2_skid_ready_flop)? sub_outh_pvld : p2_skid_valid;
// VCS sop_coverage_off start
  p2_skid_pipe_data = (p2_skid_ready_flop)? {mul_msb_dout[41:0],mul_lsb_dout[41:0]} : p2_skid_data;
// VCS sop_coverage_off end
end
//## pipe (2) valid-ready-bubble-collapse
always @(
  p2_pipe_ready
  or p2_pipe_valid
  ) begin
  p2_pipe_ready_bc = p2_pipe_ready || !p2_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p2_pipe_valid <= 1'b0;
  end else begin
  p2_pipe_valid <= (p2_pipe_ready_bc)? p2_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p2_pipe_data <= (p2_pipe_ready_bc && p2_skid_pipe_valid)? p2_skid_pipe_data : p2_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p2_pipe_ready_bc
  ) begin
  p2_skid_pipe_ready = p2_pipe_ready_bc;
end
//## pipe (2) output
always @(
  p2_pipe_valid
  or mul_outh_prdy
  or p2_pipe_data
  ) begin
  mul_outh_pvld = p2_pipe_valid;
  p2_pipe_ready = mul_outh_prdy;
  {mul_msb_data_out[41:0],mul_lsb_data_out[41:0]} = p2_pipe_data;
end
//## pipe (2) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p2_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mul_outh_pvld^mul_outh_prdy^sub_outh_pvld^sub_outh_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_4x (nvdla_core_clk, `ASSERT_RESET, (sub_outh_pvld && !sub_outh_prdy), (sub_outh_pvld), (sub_outh_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_HLS_OCVT_pipe_p2
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none -is {sat_int8_data_out[1:0],tru_int8_data_out[15:0]} (tru_outh_pvld,tru_outh_prdy) <= {sat_int8_dout[1:0],tru_int8_dout[15:0]} (mul_outh_pvld,mul_outh_prdy)
// **************************************************************************************************************
module NV_NVDLA_CDP_HLS_OCVT_pipe_p3 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mul_outh_pvld
  ,sat_int8_dout
  ,tru_int8_dout
  ,tru_outh_prdy
  ,mul_outh_prdy
  ,sat_int8_data_out
  ,tru_int8_data_out
  ,tru_outh_pvld
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input mul_outh_pvld;
input [1:0] sat_int8_dout;
input [15:0] tru_int8_dout;
input tru_outh_prdy;
output mul_outh_prdy;
output [1:0] sat_int8_data_out;
output [15:0] tru_int8_data_out;
output tru_outh_pvld;
reg mul_outh_prdy;
reg [17:0] p3_pipe_data;
reg p3_pipe_ready;
reg p3_pipe_ready_bc;
reg p3_pipe_valid;
reg p3_skid_catch;
reg [17:0] p3_skid_data;
reg [17:0] p3_skid_pipe_data;
reg p3_skid_pipe_ready;
reg p3_skid_pipe_valid;
reg p3_skid_ready;
reg p3_skid_ready_flop;
reg p3_skid_valid;
reg [1:0] sat_int8_data_out;
reg [15:0] tru_int8_data_out;
reg tru_outh_pvld;
//## pipe (3) skid buffer
always @(
  mul_outh_pvld
  or p3_skid_ready_flop
  or p3_skid_pipe_ready
  or p3_skid_valid
  ) begin
  p3_skid_catch = mul_outh_pvld && p3_skid_ready_flop && !p3_skid_pipe_ready;
  p3_skid_ready = (p3_skid_valid)? p3_skid_pipe_ready : !p3_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p3_skid_valid <= 1'b0;
    p3_skid_ready_flop <= 1'b1;
    mul_outh_prdy <= 1'b1;
  end else begin
  p3_skid_valid <= (p3_skid_valid)? !p3_skid_pipe_ready : p3_skid_catch;
  p3_skid_ready_flop <= p3_skid_ready;
  mul_outh_prdy <= p3_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p3_skid_data <= (p3_skid_catch)? {sat_int8_dout[1:0],tru_int8_dout[15:0]} : p3_skid_data;
// VCS sop_coverage_off end
end
always @(
  p3_skid_ready_flop
  or mul_outh_pvld
  or p3_skid_valid
  or sat_int8_dout
  or tru_int8_dout
  or p3_skid_data
  ) begin
  p3_skid_pipe_valid = (p3_skid_ready_flop)? mul_outh_pvld : p3_skid_valid;
// VCS sop_coverage_off start
  p3_skid_pipe_data = (p3_skid_ready_flop)? {sat_int8_dout[1:0],tru_int8_dout[15:0]} : p3_skid_data;
// VCS sop_coverage_off end
end
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
  p3_pipe_valid <= (p3_pipe_ready_bc)? p3_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p3_pipe_data <= (p3_pipe_ready_bc && p3_skid_pipe_valid)? p3_skid_pipe_data : p3_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p3_pipe_ready_bc
  ) begin
  p3_skid_pipe_ready = p3_pipe_ready_bc;
end
//## pipe (3) output
always @(
  p3_pipe_valid
  or tru_outh_prdy
  or p3_pipe_data
  ) begin
  tru_outh_pvld = p3_pipe_valid;
  p3_pipe_ready = tru_outh_prdy;
  {sat_int8_data_out[1:0],tru_int8_data_out[15:0]} = p3_pipe_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_5x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (tru_outh_pvld^tru_outh_prdy^mul_outh_pvld^mul_outh_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_6x (nvdla_core_clk, `ASSERT_RESET, (mul_outh_pvld && !mul_outh_prdy), (mul_outh_pvld), (mul_outh_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_HLS_OCVT_pipe_p3
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none -is sub_data_out[33:0] (sub_out_pvld,sub_out_prdy) <= sub_dout[33:0] (chn_int16_pvld,chn_int16_prdy)
// **************************************************************************************************************
module NV_NVDLA_CDP_HLS_OCVT_pipe_p4 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,chn_int16_pvld
  ,sub_dout
  ,sub_out_prdy
  ,chn_int16_prdy
  ,sub_data_out
  ,sub_out_pvld
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input chn_int16_pvld;
input [33:0] sub_dout;
input sub_out_prdy;
output chn_int16_prdy;
output [33:0] sub_data_out;
output sub_out_pvld;
reg chn_int16_prdy;
reg [33:0] p4_pipe_data;
reg p4_pipe_ready;
reg p4_pipe_ready_bc;
reg p4_pipe_valid;
reg p4_skid_catch;
reg [33:0] p4_skid_data;
reg [33:0] p4_skid_pipe_data;
reg p4_skid_pipe_ready;
reg p4_skid_pipe_valid;
reg p4_skid_ready;
reg p4_skid_ready_flop;
reg p4_skid_valid;
reg [33:0] sub_data_out;
reg sub_out_pvld;
//## pipe (4) skid buffer
always @(
  chn_int16_pvld
  or p4_skid_ready_flop
  or p4_skid_pipe_ready
  or p4_skid_valid
  ) begin
  p4_skid_catch = chn_int16_pvld && p4_skid_ready_flop && !p4_skid_pipe_ready;
  p4_skid_ready = (p4_skid_valid)? p4_skid_pipe_ready : !p4_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p4_skid_valid <= 1'b0;
    p4_skid_ready_flop <= 1'b1;
    chn_int16_prdy <= 1'b1;
  end else begin
  p4_skid_valid <= (p4_skid_valid)? !p4_skid_pipe_ready : p4_skid_catch;
  p4_skid_ready_flop <= p4_skid_ready;
  chn_int16_prdy <= p4_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p4_skid_data <= (p4_skid_catch)? sub_dout[33:0] : p4_skid_data;
// VCS sop_coverage_off end
end
always @(
  p4_skid_ready_flop
  or chn_int16_pvld
  or p4_skid_valid
  or sub_dout
  or p4_skid_data
  ) begin
  p4_skid_pipe_valid = (p4_skid_ready_flop)? chn_int16_pvld : p4_skid_valid;
// VCS sop_coverage_off start
  p4_skid_pipe_data = (p4_skid_ready_flop)? sub_dout[33:0] : p4_skid_data;
// VCS sop_coverage_off end
end
//## pipe (4) valid-ready-bubble-collapse
always @(
  p4_pipe_ready
  or p4_pipe_valid
  ) begin
  p4_pipe_ready_bc = p4_pipe_ready || !p4_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p4_pipe_valid <= 1'b0;
  end else begin
  p4_pipe_valid <= (p4_pipe_ready_bc)? p4_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p4_pipe_data <= (p4_pipe_ready_bc && p4_skid_pipe_valid)? p4_skid_pipe_data : p4_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p4_pipe_ready_bc
  ) begin
  p4_skid_pipe_ready = p4_pipe_ready_bc;
end
//## pipe (4) output
always @(
  p4_pipe_valid
  or sub_out_prdy
  or p4_pipe_data
  ) begin
  sub_out_pvld = p4_pipe_valid;
  p4_pipe_ready = sub_out_prdy;
  sub_data_out[33:0] = p4_pipe_data;
end
//## pipe (4) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p4_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_7x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (sub_out_pvld^sub_out_prdy^chn_int16_pvld^chn_int16_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_8x (nvdla_core_clk, `ASSERT_RESET, (chn_int16_pvld && !chn_int16_prdy), (chn_int16_pvld), (chn_int16_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_HLS_OCVT_pipe_p4
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none -is mul_data_out[49:0] (mul_out_pvld,mul_out_prdy) <= mul_dout[49:0] (sub_out_pvld,sub_out_prdy)
// **************************************************************************************************************
module NV_NVDLA_CDP_HLS_OCVT_pipe_p5 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mul_dout
  ,mul_out_prdy
  ,sub_out_pvld
  ,mul_data_out
  ,mul_out_pvld
  ,sub_out_prdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [49:0] mul_dout;
input mul_out_prdy;
input sub_out_pvld;
output [49:0] mul_data_out;
output mul_out_pvld;
output sub_out_prdy;
reg [49:0] mul_data_out;
reg mul_out_pvld;
reg [49:0] p5_pipe_data;
reg p5_pipe_ready;
reg p5_pipe_ready_bc;
reg p5_pipe_valid;
reg p5_skid_catch;
reg [49:0] p5_skid_data;
reg [49:0] p5_skid_pipe_data;
reg p5_skid_pipe_ready;
reg p5_skid_pipe_valid;
reg p5_skid_ready;
reg p5_skid_ready_flop;
reg p5_skid_valid;
reg sub_out_prdy;
//## pipe (5) skid buffer
always @(
  sub_out_pvld
  or p5_skid_ready_flop
  or p5_skid_pipe_ready
  or p5_skid_valid
  ) begin
  p5_skid_catch = sub_out_pvld && p5_skid_ready_flop && !p5_skid_pipe_ready;
  p5_skid_ready = (p5_skid_valid)? p5_skid_pipe_ready : !p5_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p5_skid_valid <= 1'b0;
    p5_skid_ready_flop <= 1'b1;
    sub_out_prdy <= 1'b1;
  end else begin
  p5_skid_valid <= (p5_skid_valid)? !p5_skid_pipe_ready : p5_skid_catch;
  p5_skid_ready_flop <= p5_skid_ready;
  sub_out_prdy <= p5_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p5_skid_data <= (p5_skid_catch)? mul_dout[49:0] : p5_skid_data;
// VCS sop_coverage_off end
end
always @(
  p5_skid_ready_flop
  or sub_out_pvld
  or p5_skid_valid
  or mul_dout
  or p5_skid_data
  ) begin
  p5_skid_pipe_valid = (p5_skid_ready_flop)? sub_out_pvld : p5_skid_valid;
// VCS sop_coverage_off start
  p5_skid_pipe_data = (p5_skid_ready_flop)? mul_dout[49:0] : p5_skid_data;
// VCS sop_coverage_off end
end
//## pipe (5) valid-ready-bubble-collapse
always @(
  p5_pipe_ready
  or p5_pipe_valid
  ) begin
  p5_pipe_ready_bc = p5_pipe_ready || !p5_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p5_pipe_valid <= 1'b0;
  end else begin
  p5_pipe_valid <= (p5_pipe_ready_bc)? p5_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p5_pipe_data <= (p5_pipe_ready_bc && p5_skid_pipe_valid)? p5_skid_pipe_data : p5_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p5_pipe_ready_bc
  ) begin
  p5_skid_pipe_ready = p5_pipe_ready_bc;
end
//## pipe (5) output
always @(
  p5_pipe_valid
  or mul_out_prdy
  or p5_pipe_data
  ) begin
  mul_out_pvld = p5_pipe_valid;
  p5_pipe_ready = mul_out_prdy;
  mul_data_out[49:0] = p5_pipe_data;
end
//## pipe (5) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p5_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_9x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mul_out_pvld^mul_out_prdy^sub_out_pvld^sub_out_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_10x (nvdla_core_clk, `ASSERT_RESET, (sub_out_pvld && !sub_out_prdy), (sub_out_pvld), (sub_out_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_HLS_OCVT_pipe_p5
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none -is {sat_data_out,tru_data_out[15:0]} (tru_out_pvld,tru_out_prdy) <= {sat_dout,tru_dout[15:0]} (mul_out_pvld,mul_out_prdy)
// **************************************************************************************************************
module NV_NVDLA_CDP_HLS_OCVT_pipe_p6 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mul_out_pvld
  ,sat_dout
  ,tru_dout
  ,tru_out_prdy
  ,mul_out_prdy
  ,sat_data_out
  ,tru_data_out
  ,tru_out_pvld
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input mul_out_pvld;
input sat_dout;
input [15:0] tru_dout;
input tru_out_prdy;
output mul_out_prdy;
output sat_data_out;
output [15:0] tru_data_out;
output tru_out_pvld;
reg mul_out_prdy;
reg [16:0] p6_pipe_data;
reg p6_pipe_ready;
reg p6_pipe_ready_bc;
reg p6_pipe_valid;
reg p6_skid_catch;
reg [16:0] p6_skid_data;
reg [16:0] p6_skid_pipe_data;
reg p6_skid_pipe_ready;
reg p6_skid_pipe_valid;
reg p6_skid_ready;
reg p6_skid_ready_flop;
reg p6_skid_valid;
reg sat_data_out;
reg [15:0] tru_data_out;
reg tru_out_pvld;
//## pipe (6) skid buffer
always @(
  mul_out_pvld
  or p6_skid_ready_flop
  or p6_skid_pipe_ready
  or p6_skid_valid
  ) begin
  p6_skid_catch = mul_out_pvld && p6_skid_ready_flop && !p6_skid_pipe_ready;
  p6_skid_ready = (p6_skid_valid)? p6_skid_pipe_ready : !p6_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p6_skid_valid <= 1'b0;
    p6_skid_ready_flop <= 1'b1;
    mul_out_prdy <= 1'b1;
  end else begin
  p6_skid_valid <= (p6_skid_valid)? !p6_skid_pipe_ready : p6_skid_catch;
  p6_skid_ready_flop <= p6_skid_ready;
  mul_out_prdy <= p6_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p6_skid_data <= (p6_skid_catch)? {sat_dout,tru_dout[15:0]} : p6_skid_data;
// VCS sop_coverage_off end
end
always @(
  p6_skid_ready_flop
  or mul_out_pvld
  or p6_skid_valid
  or sat_dout
  or tru_dout
  or p6_skid_data
  ) begin
  p6_skid_pipe_valid = (p6_skid_ready_flop)? mul_out_pvld : p6_skid_valid;
// VCS sop_coverage_off start
  p6_skid_pipe_data = (p6_skid_ready_flop)? {sat_dout,tru_dout[15:0]} : p6_skid_data;
// VCS sop_coverage_off end
end
//## pipe (6) valid-ready-bubble-collapse
always @(
  p6_pipe_ready
  or p6_pipe_valid
  ) begin
  p6_pipe_ready_bc = p6_pipe_ready || !p6_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p6_pipe_valid <= 1'b0;
  end else begin
  p6_pipe_valid <= (p6_pipe_ready_bc)? p6_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p6_pipe_data <= (p6_pipe_ready_bc && p6_skid_pipe_valid)? p6_skid_pipe_data : p6_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p6_pipe_ready_bc
  ) begin
  p6_skid_pipe_ready = p6_pipe_ready_bc;
end
//## pipe (6) output
always @(
  p6_pipe_valid
  or tru_out_prdy
  or p6_pipe_data
  ) begin
  tru_out_pvld = p6_pipe_valid;
  p6_pipe_ready = tru_out_prdy;
  {sat_data_out,tru_data_out[15:0]} = p6_pipe_data;
end
//## pipe (6) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p6_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (tru_out_pvld^tru_out_prdy^mul_out_pvld^mul_out_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_12x (nvdla_core_clk, `ASSERT_RESET, (mul_out_pvld && !mul_out_prdy), (mul_out_pvld), (mul_out_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_HLS_OCVT_pipe_p6
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none -is chn_data_out[17:0] (chn_out_pvld,chn_out_prdy) <= chn_dout[17:0] (tru_final_pvld,tru_final_prdy)
// **************************************************************************************************************
module NV_NVDLA_CDP_HLS_OCVT_pipe_p7 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,chn_dout
  ,chn_out_prdy
  ,tru_final_pvld
  ,chn_data_out
  ,chn_out_pvld
  ,tru_final_prdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [17:0] chn_dout;
input chn_out_prdy;
input tru_final_pvld;
output [17:0] chn_data_out;
output chn_out_pvld;
output tru_final_prdy;
reg [17:0] chn_data_out;
reg chn_out_pvld;
reg [17:0] p7_pipe_data;
reg p7_pipe_ready;
reg p7_pipe_ready_bc;
reg p7_pipe_valid;
reg p7_skid_catch;
reg [17:0] p7_skid_data;
reg [17:0] p7_skid_pipe_data;
reg p7_skid_pipe_ready;
reg p7_skid_pipe_valid;
reg p7_skid_ready;
reg p7_skid_ready_flop;
reg p7_skid_valid;
reg tru_final_prdy;
//## pipe (7) skid buffer
always @(
  tru_final_pvld
  or p7_skid_ready_flop
  or p7_skid_pipe_ready
  or p7_skid_valid
  ) begin
  p7_skid_catch = tru_final_pvld && p7_skid_ready_flop && !p7_skid_pipe_ready;
  p7_skid_ready = (p7_skid_valid)? p7_skid_pipe_ready : !p7_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p7_skid_valid <= 1'b0;
    p7_skid_ready_flop <= 1'b1;
    tru_final_prdy <= 1'b1;
  end else begin
  p7_skid_valid <= (p7_skid_valid)? !p7_skid_pipe_ready : p7_skid_catch;
  p7_skid_ready_flop <= p7_skid_ready;
  tru_final_prdy <= p7_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p7_skid_data <= (p7_skid_catch)? chn_dout[17:0] : p7_skid_data;
// VCS sop_coverage_off end
end
always @(
  p7_skid_ready_flop
  or tru_final_pvld
  or p7_skid_valid
  or chn_dout
  or p7_skid_data
  ) begin
  p7_skid_pipe_valid = (p7_skid_ready_flop)? tru_final_pvld : p7_skid_valid;
// VCS sop_coverage_off start
  p7_skid_pipe_data = (p7_skid_ready_flop)? chn_dout[17:0] : p7_skid_data;
// VCS sop_coverage_off end
end
//## pipe (7) valid-ready-bubble-collapse
always @(
  p7_pipe_ready
  or p7_pipe_valid
  ) begin
  p7_pipe_ready_bc = p7_pipe_ready || !p7_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p7_pipe_valid <= 1'b0;
  end else begin
  p7_pipe_valid <= (p7_pipe_ready_bc)? p7_skid_pipe_valid : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p7_pipe_data <= (p7_pipe_ready_bc && p7_skid_pipe_valid)? p7_skid_pipe_data : p7_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p7_pipe_ready_bc
  ) begin
  p7_skid_pipe_ready = p7_pipe_ready_bc;
end
//## pipe (7) output
always @(
  p7_pipe_valid
  or chn_out_prdy
  or p7_pipe_data
  ) begin
  chn_out_pvld = p7_pipe_valid;
  p7_pipe_ready = chn_out_prdy;
  chn_data_out[17:0] = p7_pipe_data;
end
//## pipe (7) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p7_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_13x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (chn_out_pvld^chn_out_prdy^tru_final_pvld^tru_final_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_14x (nvdla_core_clk, `ASSERT_RESET, (tru_final_pvld && !tru_final_prdy), (tru_final_pvld), (tru_final_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_HLS_OCVT_pipe_p7
