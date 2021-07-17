// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_WDMA_DAT_in.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_define.h
`include "simulate_x_tick.vh"
module NV_NVDLA_SDP_WDMA_DAT_in (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,op_load //|< i
  ,cmd2dat_spt_pd //|< i
  ,cmd2dat_spt_pvld //|< i
  ,cmd2dat_spt_prdy //|> o
  ,sdp_dp2wdma_pd //|< i
  ,sdp_dp2wdma_valid //|< i
  ,sdp_dp2wdma_ready //|> o
  ,dfifo0_rd_prdy //|< i
  ,dfifo1_rd_prdy //|< i
  ,dfifo2_rd_prdy //|< i
  ,dfifo3_rd_prdy //|< i
  ,dfifo0_rd_pd //|> o
  ,dfifo0_rd_pvld //|> o
  ,dfifo1_rd_pd //|> o
  ,dfifo1_rd_pvld //|> o
  ,dfifo2_rd_pd //|> o
  ,dfifo2_rd_pvld //|> o
  ,dfifo3_rd_pd //|> o
  ,dfifo3_rd_pvld //|> o
  ,reg2dp_batch_number //|< i
  ,reg2dp_winograd //|< i
  ,reg2dp_height //|< i
  ,reg2dp_width //|< i
  ,reg2dp_proc_precision //|< i
  ,reg2dp_out_precision //|< i
  ,dp2reg_status_nan_output_num //|> o
  );
//
// NV_NVDLA_SDP_WDMA_DAT_in_ports.v
//
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input op_load;
input cmd2dat_spt_pvld;
output cmd2dat_spt_prdy;
input [14:0] cmd2dat_spt_pd;
input sdp_dp2wdma_valid;
output sdp_dp2wdma_ready;
input [8*8 -1:0] sdp_dp2wdma_pd;
output dfifo0_rd_pvld;
input dfifo0_rd_prdy;
output [8*8 -1:0] dfifo0_rd_pd;
output dfifo1_rd_pvld;
input dfifo1_rd_prdy;
output [8*8 -1:0] dfifo1_rd_pd;
output dfifo2_rd_pvld;
input dfifo2_rd_prdy;
output [8*8 -1:0] dfifo2_rd_pd;
output dfifo3_rd_pvld;
input dfifo3_rd_prdy;
output [8*8 -1:0] dfifo3_rd_pd;
input [4:0] reg2dp_batch_number;
input [12:0] reg2dp_height;
input [1:0] reg2dp_out_precision;
input [1:0] reg2dp_proc_precision;
input [12:0] reg2dp_width;
input reg2dp_winograd;
output [31:0] dp2reg_status_nan_output_num;
wire cfg_di_8;
wire cfg_do_16;
wire cfg_do_8;
wire cfg_do_fp16;
wire cfg_do_int16;
wire cfg_mode_1x1_pack;
wire cfg_mode_batch;
wire cfg_mode_winograd;
wire [8*8 -1:0] dp2wdma_data;
wire [8*8 -1:0] dp2wdma_data_16;
wire [8*8 -1:0] dp2wdma_data_8;
wire cmd2dat_spt_odd;
wire [13:0] cmd2dat_spt_size;
reg [13:0] spt_size;
reg spt_vld;
wire spt_rdy;
wire in_dat_accept;
wire in_dat_rdy;
wire is_last_beat;
reg [13:0] beat_count;
wire [8*8 -1:0] dfifo0_wr_pd;
wire dfifo0_wr_prdy;
wire dfifo0_wr_pvld;
wire dfifo0_wr_rdy;
wire [8*8 -1:0] dfifo1_wr_pd;
wire dfifo1_wr_prdy;
wire dfifo1_wr_pvld;
wire dfifo1_wr_rdy;
wire [8*8 -1:0] dfifo2_wr_pd;
wire dfifo2_wr_prdy;
wire dfifo2_wr_pvld;
wire dfifo2_wr_rdy;
wire [8*8 -1:0] dfifo3_wr_pd;
wire dfifo3_wr_prdy;
wire dfifo3_wr_pvld;
wire dfifo3_wr_rdy;
assign cfg_mode_batch = (reg2dp_batch_number!=0);
assign cfg_mode_winograd = reg2dp_winograd== 1'h1 ;
assign cfg_mode_1x1_pack = (reg2dp_width==0) & (reg2dp_height==0);
assign cfg_di_8 = reg2dp_proc_precision== 0 ;
assign cfg_do_8 = reg2dp_out_precision== 0 ;
assign cfg_do_int16 = (reg2dp_out_precision== 1 );
assign cfg_do_fp16 = (reg2dp_out_precision== 2 );
assign cfg_do_16 = cfg_do_int16 | cfg_do_fp16;
//==================================
// DATA split and assembly
//==================================
assign dp2wdma_data = sdp_dp2wdma_pd;
assign dp2wdma_data_16 = dp2wdma_data;
assign dp2wdma_data_8 = dp2wdma_data;
assign dp2reg_status_nan_output_num = 32'h0;
assign sdp_dp2wdma_ready = in_dat_rdy;
//pop comand
assign spt_rdy = in_dat_accept & is_last_beat;
assign cmd2dat_spt_size[13:0] = cmd2dat_spt_pd[13:0];
assign cmd2dat_spt_odd = cmd2dat_spt_pd[14];
assign cmd2dat_spt_prdy = spt_rdy || !spt_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    spt_vld <= 1'b0;
  end else begin
  if ((cmd2dat_spt_prdy) == 1'b1) begin
    spt_vld <= cmd2dat_spt_pvld;
//end else if ((cmd2dat_spt_prdy) == 1'b0) begin
//end else begin
// spt_vld <= 1'bx;
  end
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    beat_count <= {14{1'b0}};
  end else begin
    if (in_dat_accept) begin
        if (is_last_beat) begin
            beat_count <= 0;
        end else begin
            beat_count <= beat_count + 1;
        end
    end
  end
end
assign is_last_beat = (beat_count==spt_size);
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_1x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(cmd2dat_spt_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
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
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    spt_size <= {14{1'b0}};
  end else begin
  if ((cmd2dat_spt_pvld & cmd2dat_spt_prdy) == 1'b1) begin
    spt_size <= cmd2dat_spt_size;
//end else if ((cmd2dat_spt_pvld & cmd2dat_spt_prdy) == 1'b0) begin
//end else begin
// spt_size <= 14'bx;
  end
  end
end
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_2x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(cmd2dat_spt_pvld & cmd2dat_spt_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
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
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(cmd2dat_spt_pvld & cmd2dat_spt_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_never #(0,0,"spt_vld should be faster than dp2wdma_valid") zzz_assert_never_4x (nvdla_core_clk, `ASSERT_RESET, (!spt_vld) && sdp_dp2wdma_valid); // spyglass disable W504 SelfDeterminedExpr-ML 
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
assign in_dat_rdy = dfifo0_wr_rdy & dfifo1_wr_rdy & dfifo2_wr_rdy & dfifo3_wr_rdy;
assign in_dat_accept = (dfifo0_wr_pvld & dfifo0_wr_prdy) | (dfifo1_wr_pvld & dfifo1_wr_prdy) | (dfifo2_wr_pvld & dfifo2_wr_prdy) | (dfifo3_wr_pvld & dfifo3_wr_prdy);
wire dfifo0_wr_en = beat_count[1:0] == 2'h0;
wire dfifo1_wr_en = beat_count[1:0] == 2'h1;
wire dfifo2_wr_en = beat_count[1:0] == 2'h2;
wire dfifo3_wr_en = beat_count[1:0] == 2'h3;
assign dfifo0_wr_pvld = sdp_dp2wdma_valid & dfifo0_wr_en;
assign dfifo0_wr_rdy = dfifo0_wr_en ? dfifo0_wr_prdy : 1'b1;
assign dfifo0_wr_pd = dp2wdma_data[8*8 -1:0];
assign dfifo1_wr_pvld = sdp_dp2wdma_valid & dfifo1_wr_en;
assign dfifo1_wr_rdy = dfifo1_wr_en ? dfifo1_wr_prdy : 1'b1;
assign dfifo1_wr_pd = dp2wdma_data[8*8 -1:0];
assign dfifo2_wr_pvld = sdp_dp2wdma_valid & dfifo2_wr_en;
assign dfifo2_wr_rdy = dfifo2_wr_en ? dfifo2_wr_prdy : 1'b1;
assign dfifo2_wr_pd = dp2wdma_data[8*8 -1:0];
assign dfifo3_wr_pvld = sdp_dp2wdma_valid & dfifo3_wr_en;
assign dfifo3_wr_rdy = dfifo3_wr_en ? dfifo3_wr_prdy : 1'b1;
assign dfifo3_wr_pd = dp2wdma_data[8*8 -1:0];
NV_NVDLA_SDP_WDMA_DAT_IN_dfifo u_dfifo0 (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.dfifo_wr_prdy (dfifo0_wr_prdy)
  ,.dfifo_wr_pvld (dfifo0_wr_pvld)
  ,.dfifo_wr_pd (dfifo0_wr_pd[8*8 -1:0])
  ,.dfifo_rd_prdy (dfifo0_rd_prdy)
  ,.dfifo_rd_pvld (dfifo0_rd_pvld)
  ,.dfifo_rd_pd (dfifo0_rd_pd[8*8 -1:0])
  );
NV_NVDLA_SDP_WDMA_DAT_IN_dfifo u_dfifo1 (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.dfifo_wr_prdy (dfifo1_wr_prdy)
  ,.dfifo_wr_pvld (dfifo1_wr_pvld)
  ,.dfifo_wr_pd (dfifo1_wr_pd[8*8 -1:0])
  ,.dfifo_rd_prdy (dfifo1_rd_prdy)
  ,.dfifo_rd_pvld (dfifo1_rd_pvld)
  ,.dfifo_rd_pd (dfifo1_rd_pd[8*8 -1:0])
  );
NV_NVDLA_SDP_WDMA_DAT_IN_dfifo u_dfifo2 (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.dfifo_wr_prdy (dfifo2_wr_prdy)
  ,.dfifo_wr_pvld (dfifo2_wr_pvld)
  ,.dfifo_wr_pd (dfifo2_wr_pd[8*8 -1:0])
  ,.dfifo_rd_prdy (dfifo2_rd_prdy)
  ,.dfifo_rd_pvld (dfifo2_rd_pvld)
  ,.dfifo_rd_pd (dfifo2_rd_pd[8*8 -1:0])
  );
NV_NVDLA_SDP_WDMA_DAT_IN_dfifo u_dfifo3 (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.dfifo_wr_prdy (dfifo3_wr_prdy)
  ,.dfifo_wr_pvld (dfifo3_wr_pvld)
  ,.dfifo_wr_pd (dfifo3_wr_pd[8*8 -1:0])
  ,.dfifo_rd_prdy (dfifo3_rd_prdy)
  ,.dfifo_rd_pvld (dfifo3_rd_pvld)
  ,.dfifo_rd_pd (dfifo3_rd_pd[8*8 -1:0])
  );
endmodule // NV_NVDLA_SDP_WDMA_DAT_in
module NV_NVDLA_SDP_WDMA_DAT_IN_dfifo (
      nvdla_core_clk
    , nvdla_core_rstn
    , dfifo_wr_prdy
    , dfifo_wr_pvld
    , dfifo_wr_pd
    , dfifo_rd_prdy
    , dfifo_rd_pvld
    , dfifo_rd_pd
    );
input nvdla_core_clk;
input nvdla_core_rstn;
output dfifo_wr_prdy;
input dfifo_wr_pvld;
input [8*8 -1:0] dfifo_wr_pd;
input dfifo_rd_prdy;
output dfifo_rd_pvld;
output [8*8 -1:0] dfifo_rd_pd;
//: my $dw = 8*8;
//: &eperl::pipe("-is -wid $dw -do dfifo_rd_pd -vo dfifo_rd_pvld -ri dfifo_rd_prdy -di dfifo_wr_pd -vi dfifo_wr_pvld -ro dfifo_wr_prdy");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg dfifo_wr_prdy;
reg skid_flop_dfifo_wr_prdy;
reg skid_flop_dfifo_wr_pvld;
reg [64-1:0] skid_flop_dfifo_wr_pd;
reg pipe_skid_dfifo_wr_pvld;
reg [64-1:0] pipe_skid_dfifo_wr_pd;
// Wire
wire skid_dfifo_wr_pvld;
wire [64-1:0] skid_dfifo_wr_pd;
wire skid_dfifo_wr_prdy;
wire pipe_skid_dfifo_wr_prdy;
wire dfifo_rd_pvld;
wire [64-1:0] dfifo_rd_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dfifo_wr_prdy <= 1'b1;
       skid_flop_dfifo_wr_prdy <= 1'b1;
   end else begin
       dfifo_wr_prdy <= skid_dfifo_wr_prdy;
       skid_flop_dfifo_wr_prdy <= skid_dfifo_wr_prdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_dfifo_wr_pvld <= 1'b0;
    end else begin
        if (skid_flop_dfifo_wr_prdy) begin
            skid_flop_dfifo_wr_pvld <= dfifo_wr_pvld;
        end
   end
end
assign skid_dfifo_wr_pvld = (skid_flop_dfifo_wr_prdy) ? dfifo_wr_pvld : skid_flop_dfifo_wr_pvld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_dfifo_wr_prdy & dfifo_wr_pvld) begin
        skid_flop_dfifo_wr_pd[64-1:0] <= dfifo_wr_pd[64-1:0];
    end
end
assign skid_dfifo_wr_pd[64-1:0] = (skid_flop_dfifo_wr_prdy) ? dfifo_wr_pd[64-1:0] : skid_flop_dfifo_wr_pd[64-1:0];


// PIPE READY
assign skid_dfifo_wr_prdy = pipe_skid_dfifo_wr_prdy || !pipe_skid_dfifo_wr_pvld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_dfifo_wr_pvld <= 1'b0;
    end else begin
        if (skid_dfifo_wr_prdy) begin
            pipe_skid_dfifo_wr_pvld <= skid_dfifo_wr_pvld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_dfifo_wr_prdy && skid_dfifo_wr_pvld) begin
        pipe_skid_dfifo_wr_pd[64-1:0] <= skid_dfifo_wr_pd[64-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_dfifo_wr_prdy = dfifo_rd_prdy;
assign dfifo_rd_pvld = pipe_skid_dfifo_wr_pvld;
assign dfifo_rd_pd = pipe_skid_dfifo_wr_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
