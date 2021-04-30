// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_RUBIK_dma.v
module NV_NVDLA_RUBIK_dma (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,mcif2rbk_rd_rsp_pd //|< i
  ,mcif2rbk_rd_rsp_valid //|< i
  ,mcif2rbk_wr_rsp_complete //|< i
  ,rbk2mcif_rd_req_ready //|< i
  ,rbk2mcif_wr_req_ready //|< i
  ,rd_cdt_lat_fifo_pop //|< i
  ,rd_req_pd //|< i
  ,rd_req_type //|< i
  ,rd_req_vld //|< i
  ,rd_rsp_rdy //|< i
  ,wr_req_pd //|< i
  ,wr_req_type //|< i
  ,wr_req_vld //|< i
  ,mcif2rbk_rd_rsp_ready //|> o
  ,rbk2mcif_rd_cdt_lat_fifo_pop //|> o
  ,rbk2mcif_rd_req_pd //|> o
  ,rbk2mcif_rd_req_valid //|> o
  ,rbk2mcif_wr_req_pd //|> o
  ,rbk2mcif_wr_req_valid //|> o
  ,rd_req_rdy //|> o
  ,rd_rsp_pd //|> o
  ,rd_rsp_vld //|> o
  ,wr_req_rdy //|> o
  ,wr_rsp_complete //|> o
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [513:0] mcif2rbk_rd_rsp_pd;
input mcif2rbk_rd_rsp_valid;
input mcif2rbk_wr_rsp_complete;
input rbk2mcif_rd_req_ready;
input rbk2mcif_wr_req_ready;
input rd_cdt_lat_fifo_pop;
input [78:0] rd_req_pd;
input rd_req_type;
input rd_req_vld;
input rd_rsp_rdy;
input [514:0] wr_req_pd;
input wr_req_type;
input wr_req_vld;
output mcif2rbk_rd_rsp_ready;
output rbk2mcif_rd_cdt_lat_fifo_pop;
output [78:0] rbk2mcif_rd_req_pd;
output rbk2mcif_rd_req_valid;
output [514:0] rbk2mcif_wr_req_pd;
output rbk2mcif_wr_req_valid;
output rd_req_rdy;
output [513:0] rd_rsp_pd;
output rd_rsp_vld;
output wr_req_rdy;
output wr_rsp_complete;
reg ack_bot_id;
reg ack_bot_vld;
reg ack_top_id;
reg ack_top_vld;
reg mc_pending;
reg mc_wr_rsp_complete;
reg rbk2mcif_rd_cdt_lat_fifo_pop;
reg wr_rsp_complete;
wire ack_bot_rdy;
wire ack_raw_id;
wire ack_raw_rdy;
wire ack_raw_vld;
wire ack_top_rdy;
wire [78:0] mc_int_rd_req_pd;
wire [78:0] mc_int_rd_req_pd_d0;
wire mc_int_rd_req_ready;
wire mc_int_rd_req_ready_d0;
wire mc_int_rd_req_valid;
wire mc_int_rd_req_valid_d0;
wire [513:0] mc_int_rd_rsp_pd;
wire mc_int_rd_rsp_ready;
wire mc_int_rd_rsp_valid;
wire [514:0] mc_int_wr_req_pd;
wire [514:0] mc_int_wr_req_pd_d0;
wire mc_int_wr_req_ready;
wire mc_int_wr_req_ready_d0;
wire mc_int_wr_req_valid;
wire mc_int_wr_req_valid_d0;
wire mc_int_wr_rsp_complete;
wire mc_rd_req_rdy;
wire mc_rd_req_rdyi;
wire mc_rd_req_vld;
wire [513:0] mc_rd_rsp_pd;
wire mc_rd_rsp_vld;
wire mc_releasing;
wire mc_wr_req_rdy;
wire mc_wr_req_rdyi;
wire mc_wr_req_vld;
wire [513:0] mcif2rbk_rd_rsp_pd_d0;
wire mcif2rbk_rd_rsp_ready_d0;
wire mcif2rbk_rd_rsp_valid_d0;
wire rd_req_rdyi;
wire rd_rsp_type;
wire releasing;
wire require_ack;
wire wr_req_rdyi;
// synoff nets
// monitor nets
// debug nets
// tie high nets
// tie low nets
// no connect nets
// not all bits used nets
// todo nets
//instance dma_rd & dma_wr
// rd Channel: Request
assign mc_rd_req_vld = rd_req_vld & (rd_req_type == 1'b1);
assign mc_rd_req_rdyi = mc_rd_req_rdy & (rd_req_type == 1'b1);
assign rd_req_rdyi = mc_rd_req_rdyi;
assign rd_req_rdy= rd_req_rdyi;
NV_NVDLA_RUBIK_DMA_pipe_p1 pipe_p1 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.mc_int_rd_req_ready (mc_int_rd_req_ready) //|< w
  ,.mc_rd_req_vld (mc_rd_req_vld) //|< w
  ,.rd_req_pd (rd_req_pd[78:0]) //|< i
  ,.mc_int_rd_req_pd (mc_int_rd_req_pd[78:0]) //|> w
  ,.mc_int_rd_req_valid (mc_int_rd_req_valid) //|> w
  ,.mc_rd_req_rdy (mc_rd_req_rdy) //|> w
  );
assign mc_int_rd_req_valid_d0 = mc_int_rd_req_valid;
assign mc_int_rd_req_ready = mc_int_rd_req_ready_d0;
assign mc_int_rd_req_pd_d0[78:0] = mc_int_rd_req_pd[78:0];
assign rbk2mcif_rd_req_valid = mc_int_rd_req_valid_d0;
assign mc_int_rd_req_ready_d0 = rbk2mcif_rd_req_ready;
assign rbk2mcif_rd_req_pd[78:0] = mc_int_rd_req_pd_d0[78:0];
// rd Channel: Response
assign mcif2rbk_rd_rsp_valid_d0 = mcif2rbk_rd_rsp_valid;
assign mcif2rbk_rd_rsp_ready = mcif2rbk_rd_rsp_ready_d0;
assign mcif2rbk_rd_rsp_pd_d0[513:0] = mcif2rbk_rd_rsp_pd[513:0];
assign mc_int_rd_rsp_valid = mcif2rbk_rd_rsp_valid_d0;
assign mcif2rbk_rd_rsp_ready_d0 = mc_int_rd_rsp_ready;
assign mc_int_rd_rsp_pd[513:0] = mcif2rbk_rd_rsp_pd_d0[513:0];
NV_NVDLA_RUBIK_DMA_pipe_p3 pipe_p3 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.mc_int_rd_rsp_pd (mc_int_rd_rsp_pd[513:0]) //|< w
  ,.mc_int_rd_rsp_valid (mc_int_rd_rsp_valid) //|< w
  ,.rd_rsp_rdy (rd_rsp_rdy) //|< i
  ,.mc_int_rd_rsp_ready (mc_int_rd_rsp_ready) //|> w
  ,.mc_rd_rsp_pd (mc_rd_rsp_pd[513:0]) //|> w
  ,.mc_rd_rsp_vld (mc_rd_rsp_vld) //|> w
  );
assign rd_rsp_vld = mc_rd_rsp_vld;
assign rd_rsp_pd = ({514{mc_rd_rsp_vld}} & mc_rd_rsp_pd);
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
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    rbk2mcif_rd_cdt_lat_fifo_pop <= 1'b0;
  end else begin
  rbk2mcif_rd_cdt_lat_fifo_pop <= rd_cdt_lat_fifo_pop & (rd_rsp_type == 1'b1);
  end
end
// wr Channel: Request
assign mc_wr_req_vld = wr_req_vld & (wr_req_type == 1'b1);
assign mc_wr_req_rdyi = mc_wr_req_rdy & (wr_req_type == 1'b1);
assign wr_req_rdyi = mc_wr_req_rdyi;
assign wr_req_rdy= wr_req_rdyi;
NV_NVDLA_RUBIK_DMA_pipe_p5 pipe_p5 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.mc_int_wr_req_ready (mc_int_wr_req_ready) //|< w
  ,.mc_wr_req_vld (mc_wr_req_vld) //|< w
  ,.wr_req_pd (wr_req_pd[514:0]) //|< i
  ,.mc_int_wr_req_pd (mc_int_wr_req_pd[514:0]) //|> w
  ,.mc_int_wr_req_valid (mc_int_wr_req_valid) //|> w
  ,.mc_wr_req_rdy (mc_wr_req_rdy) //|> w
  );
assign mc_int_wr_req_valid_d0 = mc_int_wr_req_valid;
assign mc_int_wr_req_ready = mc_int_wr_req_ready_d0;
assign mc_int_wr_req_pd_d0[514:0] = mc_int_wr_req_pd[514:0];
assign rbk2mcif_wr_req_valid = mc_int_wr_req_valid_d0;
assign mc_int_wr_req_ready_d0 = rbk2mcif_wr_req_ready;
assign rbk2mcif_wr_req_pd[514:0] = mc_int_wr_req_pd_d0[514:0];
// wr Channel: Response
assign mc_int_wr_rsp_complete = mcif2rbk_wr_rsp_complete;
assign require_ack = (wr_req_pd[514:514]==0) & (wr_req_pd[77:77]==1);
assign ack_raw_vld = wr_req_vld & wr_req_rdyi & require_ack;
assign ack_raw_id = wr_req_type;
// stage1: bot
assign ack_raw_rdy = ack_bot_rdy || !ack_bot_vld;
always @(posedge nvdla_core_clk) begin
  if ((ack_raw_vld & ack_raw_rdy) == 1'b1) begin
    ack_bot_id <= ack_raw_id;
// VCS coverage off
  end else if ((ack_raw_vld & ack_raw_rdy) == 1'b0) begin
  end else begin
    ack_bot_id <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
// VCS coverage on
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    ack_bot_vld <= 1'b0;
  end else begin
  if ((ack_raw_rdy) == 1'b1) begin
    ack_bot_vld <= ack_raw_vld;
// VCS coverage off
  end else if ((ack_raw_rdy) == 1'b0) begin
  end else begin
    ack_bot_vld <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
// VCS coverage on
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_2x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(ack_raw_rdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_never #(0,0,"dmaif bot never push back") zzz_assert_never_3x (nvdla_core_clk, `ASSERT_RESET, ack_raw_vld & !ack_raw_rdy); // spyglass disable W504 SelfDeterminedExpr-ML 
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
// stage2: top
assign ack_bot_rdy = ack_top_rdy || !ack_top_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    ack_top_id <= 1'b0;
  end else begin
  if ((ack_bot_vld & ack_bot_rdy) == 1'b1) begin
    ack_top_id <= ack_bot_id;
// VCS coverage off
  end else if ((ack_bot_vld & ack_bot_rdy) == 1'b0) begin
  end else begin
    ack_top_id <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
// VCS coverage on
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_4x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(ack_bot_vld & ack_bot_rdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
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
    ack_top_vld <= 1'b0;
  end else begin
  if ((ack_bot_rdy) == 1'b1) begin
    ack_top_vld <= ack_bot_vld;
// VCS coverage off
  end else if ((ack_bot_rdy) == 1'b0) begin
  end else begin
    ack_top_vld <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
// VCS coverage on
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_5x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(ack_bot_rdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
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
assign ack_top_rdy = releasing;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    mc_wr_rsp_complete <= 1'b0;
  end else begin
  mc_wr_rsp_complete <= mc_int_wr_rsp_complete;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    wr_rsp_complete <= 1'b0;
  end else begin
  wr_rsp_complete <= releasing;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    mc_pending <= 1'b0;
  end else begin
   if (ack_top_id==0) begin
       if (mc_wr_rsp_complete) begin
           mc_pending <= 1'b1;
       end
   end else if (ack_top_id==1) begin
       if (mc_pending) begin
           mc_pending <= 1'b0;
       end
   end
  end
end
assign mc_releasing = ack_top_id==1'b1 & (mc_wr_rsp_complete | mc_pending);
assign releasing = mc_releasing;
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
  nv_assert_never #(0,0,"no mc resp back and pending together") zzz_assert_never_7x (nvdla_core_clk, `ASSERT_RESET, mc_pending & mc_wr_rsp_complete); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_never #(0,0,"no ack_top_vld when resp from mc") zzz_assert_never_10x (nvdla_core_clk, `ASSERT_RESET, (mc_pending | mc_wr_rsp_complete) & !ack_top_vld); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
  `endif
`endif
//VCS coverage on
assign rd_rsp_type = rd_req_type;
endmodule // NV_NVDLA_RUBIK_dma
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is mc_int_rd_req_pd (mc_int_rd_req_valid,mc_int_rd_req_ready) <= rd_req_pd[78:0] (mc_rd_req_vld,mc_rd_req_rdy)
// **************************************************************************************************************
module NV_NVDLA_RUBIK_DMA_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mc_int_rd_req_ready
  ,mc_rd_req_vld
  ,rd_req_pd
  ,mc_int_rd_req_pd
  ,mc_int_rd_req_valid
  ,mc_rd_req_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input mc_int_rd_req_ready;
input mc_rd_req_vld;
input [78:0] rd_req_pd;
output [78:0] mc_int_rd_req_pd;
output mc_int_rd_req_valid;
output mc_rd_req_rdy;
reg [78:0] mc_int_rd_req_pd;
reg mc_int_rd_req_valid;
reg mc_rd_req_rdy;
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
     mc_rd_req_vld
  or p1_pipe_rand_ready
  or rd_req_pd
  ) begin
  `ifdef SYNTHESIS
  p1_pipe_rand_valid = mc_rd_req_vld;
  mc_rd_req_rdy = p1_pipe_rand_ready;
  p1_pipe_rand_data = rd_req_pd[78:0];
  `else
// VCS coverage off
  p1_pipe_rand_valid = (p1_pipe_rand_active)? 1'b0 : mc_rd_req_vld;
  mc_rd_req_rdy = (p1_pipe_rand_active)? 1'b0 : p1_pipe_rand_ready;
  p1_pipe_rand_data = (p1_pipe_rand_active)? 'bx : rd_req_pd[78:0];
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
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_rand_probability=%d", p1_pipe_stall_probability ) ) ; // deprecated
  else if ( $value$plusargs( "default_pipe_rand_probability=%d", p1_pipe_stall_probability ) ) ; // deprecated
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_probability=%d", p1_pipe_stall_probability ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_probability=%d", p1_pipe_stall_probability ) ) ;
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_min=%d", p1_pipe_stall_cycles_min ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_min=%d", p1_pipe_stall_cycles_min ) ) ;
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_max=%d", p1_pipe_stall_cycles_max ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_max=%d", p1_pipe_stall_cycles_max ) ) ;
`endif
end
// randomization globals
`ifndef SYNTH_LEVEL1_COMPILE
`ifdef SIMTOP_RANDOMIZE_STALLS
always @( `SIMTOP_RANDOMIZE_STALLS.global_stall_event ) begin
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_probability" ) ) p1_pipe_stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_probability;
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_min" ) ) p1_pipe_stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_min;
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_max" ) ) p1_pipe_stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_max;
end
`endif
`endif
//// randomization active
reg p1_pipe_rand_enable;
reg p1_pipe_rand_poised;
always @(
  p1_pipe_stall_cycles
  or p1_pipe_stall_probability
  or mc_rd_req_vld
  ) begin
  p1_pipe_rand_active = p1_pipe_stall_cycles != 0;
  p1_pipe_rand_enable = p1_pipe_stall_probability != 0;
  p1_pipe_rand_poised = p1_pipe_rand_enable && !p1_pipe_rand_active && mc_rd_req_vld === 1'b1;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mc_int_rd_req_valid^mc_int_rd_req_ready^mc_rd_req_vld^mc_rd_req_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_12x (nvdla_core_clk, `ASSERT_RESET, (mc_rd_req_vld && !mc_rd_req_rdy), (mc_rd_req_vld), (mc_rd_req_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_RUBIK_DMA_pipe_p1
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is cv_int_rd_req_pd (cv_int_rd_req_valid,cv_int_rd_req_ready) <= rd_req_pd[78:0] (cv_rd_req_vld,cv_rd_req_rdy)
// **************************************************************************************************************
// **************************************************************************************************************
// Generated by ::pipe -m -bc -os mc_rd_rsp_pd (mc_rd_rsp_vld,rd_rsp_rdy) <= mc_int_rd_rsp_pd[513:0] (mc_int_rd_rsp_valid,mc_int_rd_rsp_ready)
// **************************************************************************************************************
module NV_NVDLA_RUBIK_DMA_pipe_p3 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mc_int_rd_rsp_pd
  ,mc_int_rd_rsp_valid
  ,rd_rsp_rdy
  ,mc_int_rd_rsp_ready
  ,mc_rd_rsp_pd
  ,mc_rd_rsp_vld
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [513:0] mc_int_rd_rsp_pd;
input mc_int_rd_rsp_valid;
input rd_rsp_rdy;
output mc_int_rd_rsp_ready;
output [513:0] mc_rd_rsp_pd;
output mc_rd_rsp_vld;
reg mc_int_rd_rsp_ready;
reg [513:0] mc_rd_rsp_pd;
reg mc_rd_rsp_vld;
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
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_rand_probability=%d", p3_pipe_stall_probability ) ) ; // deprecated
  else if ( $value$plusargs( "default_pipe_rand_probability=%d", p3_pipe_stall_probability ) ) ; // deprecated
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_probability=%d", p3_pipe_stall_probability ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_probability=%d", p3_pipe_stall_probability ) ) ;
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_min=%d", p3_pipe_stall_cycles_min ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_min=%d", p3_pipe_stall_cycles_min ) ) ;
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_max=%d", p3_pipe_stall_cycles_max ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_max=%d", p3_pipe_stall_cycles_max ) ) ;
`endif
end
// randomization globals
`ifndef SYNTH_LEVEL1_COMPILE
`ifdef SIMTOP_RANDOMIZE_STALLS
always @( `SIMTOP_RANDOMIZE_STALLS.global_stall_event ) begin
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_probability" ) ) p3_pipe_stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_probability;
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_min" ) ) p3_pipe_stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_min;
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_max" ) ) p3_pipe_stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_max;
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
  or rd_rsp_rdy
  or p3_pipe_skid_data
  ) begin
  mc_rd_rsp_vld = p3_pipe_skid_valid;
  p3_pipe_skid_ready = rd_rsp_rdy;
  mc_rd_rsp_pd = p3_pipe_skid_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_15x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mc_rd_rsp_vld^rd_rsp_rdy^mc_int_rd_rsp_valid^mc_int_rd_rsp_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_16x (nvdla_core_clk, `ASSERT_RESET, (mc_int_rd_rsp_valid && !mc_int_rd_rsp_ready), (mc_int_rd_rsp_valid), (mc_int_rd_rsp_ready)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_RUBIK_DMA_pipe_p3
// **************************************************************************************************************
// Generated by ::pipe -m -bc -os cv_rd_rsp_pd (cv_rd_rsp_vld,rd_rsp_rdy) <= cv_int_rd_rsp_pd[513:0] (cv_int_rd_rsp_valid,cv_int_rd_rsp_ready)
// **************************************************************************************************************
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is mc_int_wr_req_pd (mc_int_wr_req_valid,mc_int_wr_req_ready) <= wr_req_pd[514:0] (mc_wr_req_vld,mc_wr_req_rdy)
// **************************************************************************************************************
module NV_NVDLA_RUBIK_DMA_pipe_p5 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mc_int_wr_req_ready
  ,mc_wr_req_vld
  ,wr_req_pd
  ,mc_int_wr_req_pd
  ,mc_int_wr_req_valid
  ,mc_wr_req_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input mc_int_wr_req_ready;
input mc_wr_req_vld;
input [514:0] wr_req_pd;
output [514:0] mc_int_wr_req_pd;
output mc_int_wr_req_valid;
output mc_wr_req_rdy;
reg [514:0] mc_int_wr_req_pd;
reg mc_int_wr_req_valid;
reg mc_wr_req_rdy;
reg [514:0] p5_pipe_data;
reg [514:0] p5_pipe_rand_data;
reg p5_pipe_rand_ready;
reg p5_pipe_rand_valid;
reg p5_pipe_ready;
reg p5_pipe_ready_bc;
reg p5_pipe_valid;
reg p5_skid_catch;
reg [514:0] p5_skid_data;
reg [514:0] p5_skid_pipe_data;
reg p5_skid_pipe_ready;
reg p5_skid_pipe_valid;
reg p5_skid_ready;
reg p5_skid_ready_flop;
reg p5_skid_valid;
//## pipe (5) randomizer
`ifndef SYNTHESIS
reg p5_pipe_rand_active;
`endif
always @(
  `ifndef SYNTHESIS
  p5_pipe_rand_active
  or
     `endif
     mc_wr_req_vld
  or p5_pipe_rand_ready
  or wr_req_pd
  ) begin
  `ifdef SYNTHESIS
  p5_pipe_rand_valid = mc_wr_req_vld;
  mc_wr_req_rdy = p5_pipe_rand_ready;
  p5_pipe_rand_data = wr_req_pd[514:0];
  `else
// VCS coverage off
  p5_pipe_rand_valid = (p5_pipe_rand_active)? 1'b0 : mc_wr_req_vld;
  mc_wr_req_rdy = (p5_pipe_rand_active)? 1'b0 : p5_pipe_rand_ready;
  p5_pipe_rand_data = (p5_pipe_rand_active)? 'bx : wr_req_pd[514:0];
// VCS coverage on
  `endif
end
`ifndef SYNTHESIS
// VCS coverage off
//// randomization init   
integer p5_pipe_stall_cycles;
integer p5_pipe_stall_probability;
integer p5_pipe_stall_cycles_min;
integer p5_pipe_stall_cycles_max;
initial begin
  p5_pipe_stall_cycles = 0;
  p5_pipe_stall_probability = 0;
  p5_pipe_stall_cycles_min = 1;
  p5_pipe_stall_cycles_max = 10;
`ifndef SYNTH_LEVEL1_COMPILE
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_rand_probability=%d", p5_pipe_stall_probability ) ) ; // deprecated
  else if ( $value$plusargs( "default_pipe_rand_probability=%d", p5_pipe_stall_probability ) ) ; // deprecated
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_probability=%d", p5_pipe_stall_probability ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_probability=%d", p5_pipe_stall_probability ) ) ;
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_min=%d", p5_pipe_stall_cycles_min ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_min=%d", p5_pipe_stall_cycles_min ) ) ;
  if ( $value$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_max=%d", p5_pipe_stall_cycles_max ) ) ;
  else if ( $value$plusargs( "default_pipe_stall_cycles_max=%d", p5_pipe_stall_cycles_max ) ) ;
`endif
end
// randomization globals
`ifndef SYNTH_LEVEL1_COMPILE
`ifdef SIMTOP_RANDOMIZE_STALLS
always @( `SIMTOP_RANDOMIZE_STALLS.global_stall_event ) begin
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_probability" ) ) p5_pipe_stall_probability = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_probability;
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_min" ) ) p5_pipe_stall_cycles_min = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_min;
  if ( ! $test$plusargs( "NV_NVDLA_RUBIK_dma_pipe_stall_cycles_max" ) ) p5_pipe_stall_cycles_max = `SIMTOP_RANDOMIZE_STALLS.global_stall_pipe_cycles_max;
end
`endif
`endif
//// randomization active
reg p5_pipe_rand_enable;
reg p5_pipe_rand_poised;
always @(
  p5_pipe_stall_cycles
  or p5_pipe_stall_probability
  or mc_wr_req_vld
  ) begin
  p5_pipe_rand_active = p5_pipe_stall_cycles != 0;
  p5_pipe_rand_enable = p5_pipe_stall_probability != 0;
  p5_pipe_rand_poised = p5_pipe_rand_enable && !p5_pipe_rand_active && mc_wr_req_vld === 1'b1;
end
//// randomization cycles
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p5_pipe_stall_cycles <= 1'b0;
  end else begin
  if (p5_pipe_rand_poised) begin
    if (p5_pipe_stall_probability >= prand_inst0(1, 100)) begin
      p5_pipe_stall_cycles <= prand_inst1(p5_pipe_stall_cycles_min, p5_pipe_stall_cycles_max);
    end
  end else if (p5_pipe_rand_active) begin
    p5_pipe_stall_cycles <= p5_pipe_stall_cycles - 1;
  end else begin
    p5_pipe_stall_cycles <= 0;
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
//## pipe (5) skid buffer
always @(
  p5_pipe_rand_valid
  or p5_skid_ready_flop
  or p5_skid_pipe_ready
  or p5_skid_valid
  ) begin
  p5_skid_catch = p5_pipe_rand_valid && p5_skid_ready_flop && !p5_skid_pipe_ready;
  p5_skid_ready = (p5_skid_valid)? p5_skid_pipe_ready : !p5_skid_catch;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p5_skid_valid <= 1'b0;
    p5_skid_ready_flop <= 1'b1;
    p5_pipe_rand_ready <= 1'b1;
  end else begin
  p5_skid_valid <= (p5_skid_valid)? !p5_skid_pipe_ready : p5_skid_catch;
  p5_skid_ready_flop <= p5_skid_ready;
  p5_pipe_rand_ready <= p5_skid_ready;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p5_skid_data <= (p5_skid_catch)? p5_pipe_rand_data : p5_skid_data;
// VCS sop_coverage_off end
end
always @(
  p5_skid_ready_flop
  or p5_pipe_rand_valid
  or p5_skid_valid
  or p5_pipe_rand_data
  or p5_skid_data
  ) begin
  p5_skid_pipe_valid = (p5_skid_ready_flop)? p5_pipe_rand_valid : p5_skid_valid;
// VCS sop_coverage_off start
  p5_skid_pipe_data = (p5_skid_ready_flop)? p5_pipe_rand_data : p5_skid_data;
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
  or mc_int_wr_req_ready
  or p5_pipe_data
  ) begin
  mc_int_wr_req_valid = p5_pipe_valid;
  p5_pipe_ready = mc_int_wr_req_ready;
  mc_int_wr_req_pd = p5_pipe_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_19x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (mc_int_wr_req_valid^mc_int_wr_req_ready^mc_wr_req_vld^mc_wr_req_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_20x (nvdla_core_clk, `ASSERT_RESET, (mc_wr_req_vld && !mc_wr_req_rdy), (mc_wr_req_vld), (mc_wr_req_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_RUBIK_DMA_pipe_p5
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is cv_int_wr_req_pd (cv_int_wr_req_valid,cv_int_wr_req_ready) <= wr_req_pd[514:0] (cv_wr_req_vld,cv_wr_req_rdy)
// **************************************************************************************************************
