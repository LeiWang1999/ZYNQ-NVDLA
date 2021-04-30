// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDMA_dma_mux.v
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
module NV_NVDLA_CDMA_dma_mux (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dc_dat2mcif_rd_req_valid
  ,dc_dat2mcif_rd_req_ready
  ,dc_dat2mcif_rd_req_pd
  ,img_dat2mcif_rd_req_valid
  ,img_dat2mcif_rd_req_ready
  ,img_dat2mcif_rd_req_pd
  ,cdma_dat2mcif_rd_req_valid
  ,cdma_dat2mcif_rd_req_ready
  ,cdma_dat2mcif_rd_req_pd
  ,mcif2cdma_dat_rd_rsp_valid
  ,mcif2cdma_dat_rd_rsp_ready
  ,mcif2cdma_dat_rd_rsp_pd
  ,mcif2dc_dat_rd_rsp_valid
  ,mcif2dc_dat_rd_rsp_ready
  ,mcif2dc_dat_rd_rsp_pd
  ,mcif2img_dat_rd_rsp_valid
  ,mcif2img_dat_rd_rsp_ready
  ,mcif2img_dat_rd_rsp_pd
  );
////////////////////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
input dc_dat2mcif_rd_req_valid; /* data valid */
output dc_dat2mcif_rd_req_ready; /* data return handshake */
input [( 32 + 15 )-1:0] dc_dat2mcif_rd_req_pd;
output mcif2dc_dat_rd_rsp_valid; /* data valid */
input mcif2dc_dat_rd_rsp_ready; /* data return handshake */
output [( 64 + (64/8/8) )-1:0] mcif2dc_dat_rd_rsp_pd;
input img_dat2mcif_rd_req_valid; /* data valid */
output img_dat2mcif_rd_req_ready; /* data return handshake */
input [( 32 + 15 )-1:0] img_dat2mcif_rd_req_pd;
output mcif2img_dat_rd_rsp_valid; /* data valid */
input mcif2img_dat_rd_rsp_ready; /* data return handshake */
output [( 64 + (64/8/8) )-1:0] mcif2img_dat_rd_rsp_pd;
output cdma_dat2mcif_rd_req_valid; /* data valid */
input cdma_dat2mcif_rd_req_ready; /* data return handshake */
output [( 32 + 15 )-1:0] cdma_dat2mcif_rd_req_pd;
input mcif2cdma_dat_rd_rsp_valid; /* data valid */
output mcif2cdma_dat_rd_rsp_ready; /* data return handshake */
input [( 64 + (64/8/8) )-1:0] mcif2cdma_dat_rd_rsp_pd;
////////////////////////////////////////////////////////////////////
wire [( 32 + 15 )-1:0] cdma_dat2mcif_rd_req_pd;
wire cdma_dat2mcif_rd_req_valid;
wire dc_dat2mcif_rd_req_ready;
wire img_dat2mcif_rd_req_ready;
wire mc_sel_dc_w;
wire mc_sel_img_w;
wire mcif2cdma_dat_rd_rsp_ready;
wire [( 64 + (64/8/8) )-1:0] mcif2dc_dat_rd_rsp_pd;
wire mcif2dc_dat_rd_rsp_valid;
wire [( 64 + (64/8/8) )-1:0] mcif2img_dat_rd_rsp_pd;
wire mcif2img_dat_rd_rsp_valid;
wire [( 32 + 15 )-1:0] req_mc_in_pd;
wire req_mc_in_pvld;
wire req_mc_out_prdy;
wire [( 64 + (64/8/8) )-1:0] rsp_mc_in_pd;
wire rsp_mc_in_pvld;
wire rsp_mc_out_prdy;
reg mc_sel_dc;
reg mc_sel_img;
////////////////////////////////////////////////////////////////////////
// Data request channel //
////////////////////////////////////////////////////////////////////////
//////////////// MCIF interface ////////////////
assign mc_sel_dc_w = dc_dat2mcif_rd_req_valid;
assign mc_sel_img_w = img_dat2mcif_rd_req_valid;
assign req_mc_in_pvld = dc_dat2mcif_rd_req_valid |
                        img_dat2mcif_rd_req_valid;
assign req_mc_in_pd = ({( 32 + 15 ) {mc_sel_dc_w}} & dc_dat2mcif_rd_req_pd) |
                      ({( 32 + 15 ) {mc_sel_img_w}} & img_dat2mcif_rd_req_pd);
//: my $k = ( 32 + 15 );
//: &eperl::pipe("-is -wid ${k} -do req_mc_out_pd -vo req_mc_out_pvld -ri req_mc_out_prdy -di req_mc_in_pd -vi req_mc_in_pvld -ro req_mc_in_prdy");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg req_mc_in_prdy;
reg skid_flop_req_mc_in_prdy;
reg skid_flop_req_mc_in_pvld;
reg [47-1:0] skid_flop_req_mc_in_pd;
reg pipe_skid_req_mc_in_pvld;
reg [47-1:0] pipe_skid_req_mc_in_pd;
// Wire
wire skid_req_mc_in_pvld;
wire [47-1:0] skid_req_mc_in_pd;
wire skid_req_mc_in_prdy;
wire pipe_skid_req_mc_in_prdy;
wire req_mc_out_pvld;
wire [47-1:0] req_mc_out_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       req_mc_in_prdy <= 1'b1;
       skid_flop_req_mc_in_prdy <= 1'b1;
   end else begin
       req_mc_in_prdy <= skid_req_mc_in_prdy;
       skid_flop_req_mc_in_prdy <= skid_req_mc_in_prdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_req_mc_in_pvld <= 1'b0;
    end else begin
        if (skid_flop_req_mc_in_prdy) begin
            skid_flop_req_mc_in_pvld <= req_mc_in_pvld;
        end
   end
end
assign skid_req_mc_in_pvld = (skid_flop_req_mc_in_prdy) ? req_mc_in_pvld : skid_flop_req_mc_in_pvld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_req_mc_in_prdy & req_mc_in_pvld) begin
        skid_flop_req_mc_in_pd[47-1:0] <= req_mc_in_pd[47-1:0];
    end
end
assign skid_req_mc_in_pd[47-1:0] = (skid_flop_req_mc_in_prdy) ? req_mc_in_pd[47-1:0] : skid_flop_req_mc_in_pd[47-1:0];


// PIPE READY
assign skid_req_mc_in_prdy = pipe_skid_req_mc_in_prdy || !pipe_skid_req_mc_in_pvld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_req_mc_in_pvld <= 1'b0;
    end else begin
        if (skid_req_mc_in_prdy) begin
            pipe_skid_req_mc_in_pvld <= skid_req_mc_in_pvld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_req_mc_in_prdy && skid_req_mc_in_pvld) begin
        pipe_skid_req_mc_in_pd[47-1:0] <= skid_req_mc_in_pd[47-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_req_mc_in_prdy = req_mc_out_prdy;
assign req_mc_out_pvld = pipe_skid_req_mc_in_pvld;
assign req_mc_out_pd = pipe_skid_req_mc_in_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dc_dat2mcif_rd_req_ready = req_mc_in_prdy & dc_dat2mcif_rd_req_valid;
assign img_dat2mcif_rd_req_ready = req_mc_in_prdy & img_dat2mcif_rd_req_valid;
assign cdma_dat2mcif_rd_req_valid = req_mc_out_pvld;
assign cdma_dat2mcif_rd_req_pd = req_mc_out_pd;
assign req_mc_out_prdy = cdma_dat2mcif_rd_req_ready;
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_mc_in_pvld & req_mc_in_prdy\" -d \"mc_sel_dc_w\" -q mc_sel_dc");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"  -en \"req_mc_in_pvld & req_mc_in_prdy\" -d \"mc_sel_img_w\" -q mc_sel_img");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       mc_sel_dc <= 1'b0;
   end else begin
       if ((req_mc_in_pvld & req_mc_in_prdy) == 1'b1) begin
           mc_sel_dc <= mc_sel_dc_w;
       // VCS coverage off
       end else if ((req_mc_in_pvld & req_mc_in_prdy) == 1'b0) begin
       end else begin
           mc_sel_dc <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       mc_sel_img <= 1'b0;
   end else begin
       if ((req_mc_in_pvld & req_mc_in_prdy) == 1'b1) begin
           mc_sel_img <= mc_sel_img_w;
       // VCS coverage off
       end else if ((req_mc_in_pvld & req_mc_in_prdy) == 1'b0) begin
       end else begin
           mc_sel_img <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////// CVIF interface ////////////////
////////////////////////////////////////////////////////////////////////
// Data response channel //
////////////////////////////////////////////////////////////////////////
//////////////// MCIF interface ////////////////
assign rsp_mc_in_pvld = mcif2cdma_dat_rd_rsp_valid;
assign rsp_mc_in_pd = mcif2cdma_dat_rd_rsp_pd;
//: my $k = ( 64 + (64/8/8) );
//: &eperl::pipe("-is -wid $k -do rsp_mc_out_pd -vo rsp_mc_out_pvld -ri rsp_mc_out_prdy -di rsp_mc_in_pd -vi rsp_mc_in_pvld -ro rsp_mc_in_prdy");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg rsp_mc_in_prdy;
reg skid_flop_rsp_mc_in_prdy;
reg skid_flop_rsp_mc_in_pvld;
reg [65-1:0] skid_flop_rsp_mc_in_pd;
reg pipe_skid_rsp_mc_in_pvld;
reg [65-1:0] pipe_skid_rsp_mc_in_pd;
// Wire
wire skid_rsp_mc_in_pvld;
wire [65-1:0] skid_rsp_mc_in_pd;
wire skid_rsp_mc_in_prdy;
wire pipe_skid_rsp_mc_in_prdy;
wire rsp_mc_out_pvld;
wire [65-1:0] rsp_mc_out_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rsp_mc_in_prdy <= 1'b1;
       skid_flop_rsp_mc_in_prdy <= 1'b1;
   end else begin
       rsp_mc_in_prdy <= skid_rsp_mc_in_prdy;
       skid_flop_rsp_mc_in_prdy <= skid_rsp_mc_in_prdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_rsp_mc_in_pvld <= 1'b0;
    end else begin
        if (skid_flop_rsp_mc_in_prdy) begin
            skid_flop_rsp_mc_in_pvld <= rsp_mc_in_pvld;
        end
   end
end
assign skid_rsp_mc_in_pvld = (skid_flop_rsp_mc_in_prdy) ? rsp_mc_in_pvld : skid_flop_rsp_mc_in_pvld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_rsp_mc_in_prdy & rsp_mc_in_pvld) begin
        skid_flop_rsp_mc_in_pd[65-1:0] <= rsp_mc_in_pd[65-1:0];
    end
end
assign skid_rsp_mc_in_pd[65-1:0] = (skid_flop_rsp_mc_in_prdy) ? rsp_mc_in_pd[65-1:0] : skid_flop_rsp_mc_in_pd[65-1:0];


// PIPE READY
assign skid_rsp_mc_in_prdy = pipe_skid_rsp_mc_in_prdy || !pipe_skid_rsp_mc_in_pvld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_rsp_mc_in_pvld <= 1'b0;
    end else begin
        if (skid_rsp_mc_in_prdy) begin
            pipe_skid_rsp_mc_in_pvld <= skid_rsp_mc_in_pvld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_rsp_mc_in_prdy && skid_rsp_mc_in_pvld) begin
        pipe_skid_rsp_mc_in_pd[65-1:0] <= skid_rsp_mc_in_pd[65-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_rsp_mc_in_prdy = rsp_mc_out_prdy;
assign rsp_mc_out_pvld = pipe_skid_rsp_mc_in_pvld;
assign rsp_mc_out_pd = pipe_skid_rsp_mc_in_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign mcif2cdma_dat_rd_rsp_ready = rsp_mc_in_prdy;
assign mcif2dc_dat_rd_rsp_valid = rsp_mc_out_pvld & mc_sel_dc;
assign mcif2img_dat_rd_rsp_valid = rsp_mc_out_pvld & mc_sel_img;
assign mcif2dc_dat_rd_rsp_pd = {( 64 + (64/8/8) ) {mc_sel_dc}} & rsp_mc_out_pd;
assign mcif2img_dat_rd_rsp_pd = {( 64 + (64/8/8) ) {mc_sel_img}} & rsp_mc_out_pd;
assign rsp_mc_out_prdy = (mc_sel_dc & mcif2dc_dat_rd_rsp_ready) |
                         (mc_sel_img & mcif2img_dat_rd_rsp_ready);
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_1x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (req_mc_out_pvld^req_mc_out_prdy^req_mc_in_pvld^req_mc_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_mc_in_pvld & req_mc_in_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_4x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_mc_in_pvld & req_mc_in_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_5x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_mc_in_pvld & req_mc_in_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_6x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (req_cv_out_pvld^req_cv_out_prdy^req_cv_in_pvld^req_cv_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_8x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_cv_in_pvld & req_cv_in_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_9x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_cv_in_pvld & req_cv_in_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_10x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(req_cv_in_pvld & req_cv_in_prdy))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_18x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (rsp_mc_out_pvld^rsp_mc_out_prdy^rsp_mc_in_pvld^rsp_mc_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_20x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (rsp_cv_out_pvld^rsp_cv_out_prdy^rsp_cv_in_pvld^rsp_cv_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_2x (nvdla_core_clk, `ASSERT_RESET, (req_mc_in_pvld && !req_mc_in_prdy), (req_mc_in_pvld), (req_mc_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_7x (nvdla_core_clk, `ASSERT_RESET, (req_cv_in_pvld && !req_cv_in_prdy), (req_cv_in_pvld), (req_cv_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_19x (nvdla_core_clk, `ASSERT_RESET, (rsp_mc_in_pvld && !rsp_mc_in_prdy), (rsp_mc_in_pvld), (rsp_mc_in_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_zero_one_hot #(0,2,0,"Error! DMA resp conflict!") zzz_assert_zero_one_hot_22x (nvdla_core_clk, `ASSERT_RESET, {mcif2cdma_dat_rd_rsp_valid, cvif2cdma_dat_rd_rsp_valid}); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDMA_dma_mux
