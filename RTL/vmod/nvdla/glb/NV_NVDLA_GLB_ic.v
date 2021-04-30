// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_GLB_ic.v
module NV_NVDLA_GLB_ic (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cacc2glb_done_intr_pd //|< i
  ,cacc_done_mask0 //|< i
  ,cacc_done_mask1 //|< i
  ,cdma_dat2glb_done_intr_pd //|< i
  ,cdma_dat_done_mask0 //|< i
  ,cdma_dat_done_mask1 //|< i
  ,cdma_wt2glb_done_intr_pd //|< i
  ,cdma_wt_done_mask0 //|< i
  ,cdma_wt_done_mask1 //|< i
  ,cdp2glb_done_intr_pd //|< i
  ,cdp_done_mask0 //|< i
  ,cdp_done_mask1 //|< i
  ,nvdla_falcon_clk //|< i
  ,nvdla_falcon_rstn //|< i
  ,pdp2glb_done_intr_pd //|< i
  ,pdp_done_mask0 //|< i
  ,pdp_done_mask1 //|< i
  ,req_wdat //|< i
  ,sdp2glb_done_intr_pd //|< i
  ,sdp_done_mask0 //|< i
  ,sdp_done_mask1 //|< i
  ,sdp_done_set0_trigger //|< i
  ,sdp_done_status0_trigger //|< i
  ,cacc_done_status0 //|> o
  ,cacc_done_status1 //|> o
  ,cdma_dat_done_status0 //|> o
  ,cdma_dat_done_status1 //|> o
  ,cdma_wt_done_status0 //|> o
  ,cdma_wt_done_status1 //|> o
  ,cdp_done_status0 //|> o
  ,cdp_done_status1 //|> o
  ,core_intr //|> o
  ,pdp_done_status0 //|> o
  ,pdp_done_status1 //|> o
  ,sdp_done_status0 //|> o
  ,sdp_done_status1 //|> o
  );
//&Catenate "NV_NVDLA_GLB_ic_ports.v";
input nvdla_core_clk;
input nvdla_core_rstn;
input [1:0] cacc2glb_done_intr_pd;
input cacc_done_mask0;
input cacc_done_mask1;
input [1:0] cdma_dat2glb_done_intr_pd;
input cdma_dat_done_mask0;
input cdma_dat_done_mask1;
input [1:0] cdma_wt2glb_done_intr_pd;
input cdma_wt_done_mask0;
input cdma_wt_done_mask1;
input [1:0] cdp2glb_done_intr_pd;
input cdp_done_mask0;
input cdp_done_mask1;
input nvdla_falcon_clk;
input nvdla_falcon_rstn;
input [1:0] pdp2glb_done_intr_pd;
input pdp_done_mask0;
input pdp_done_mask1;
input [21:0] req_wdat;
input [1:0] sdp2glb_done_intr_pd;
input sdp_done_mask0;
input sdp_done_mask1;
input sdp_done_set0_trigger;
input sdp_done_status0_trigger;
output cacc_done_status0;
output cacc_done_status1;
output cdma_dat_done_status0;
output cdma_dat_done_status1;
output cdma_wt_done_status0;
output cdma_wt_done_status1;
output cdp_done_status0;
output cdp_done_status1;
output core_intr;
output pdp_done_status0;
output pdp_done_status1;
output sdp_done_status0;
output sdp_done_status1;
reg cacc_done_status0;
reg cacc_done_status1;
wire cacc_done_status0_w;
wire cacc_done_status1_w;
reg cdma_dat_done_status0;
reg cdma_dat_done_status1;
wire cdma_dat_done_status0_w;
wire cdma_dat_done_status1_w;
reg cdma_wt_done_status0;
reg cdma_wt_done_status1;
wire cdma_wt_done_status0_w;
wire cdma_wt_done_status1_w;
reg cdp_done_status0;
reg cdp_done_status1;
wire cdp_done_status0_w;
wire cdp_done_status1_w;
reg pdp_done_status0;
reg pdp_done_status1;
wire pdp_done_status0_w;
wire pdp_done_status1_w;
reg sdp_done_status0;
reg sdp_done_status1;
wire sdp_done_status0_w;
wire sdp_done_status1_w;
reg core_intr_d;
reg [15:0] done_source;
wire core_intr_w;
wire [15:0] done_set;
wire [15:0] done_wr_clr;
assign done_wr_clr = sdp_done_status0_trigger ? {req_wdat[21:16], req_wdat[9:0]} : 14'b0;
assign done_set = sdp_done_set0_trigger ? {req_wdat[21:16], req_wdat[9:0]} : 14'b0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        done_source <= {16{1'b0}};
    end else begin
        done_source <= {cacc2glb_done_intr_pd[1:0],
                        cdma_wt2glb_done_intr_pd[1:0],
                        cdma_dat2glb_done_intr_pd[1:0],
                        2'b0,
                        2'b0,
                        pdp2glb_done_intr_pd[1:0],
                        cdp2glb_done_intr_pd[1:0],
                        sdp2glb_done_intr_pd[1:0]};
    end
end
//////// interrrupt status 0 for sdp ////////
assign sdp_done_status0_w = (done_set[0] | done_source[0]) ? 1'b1 :
                            (done_wr_clr[0]) ? 1'b0 :
                            sdp_done_status0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        sdp_done_status0 <= 1'b0;
    end else begin
        sdp_done_status0 <= sdp_done_status0_w;
    end
end
//////// interrrupt status 1 for sdp ////////
assign sdp_done_status1_w = (done_set[1] | done_source[1]) ? 1'b1 :
                            (done_wr_clr[1]) ? 1'b0 :
                            sdp_done_status1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        sdp_done_status1 <= 1'b0;
    end else begin
        sdp_done_status1 <= sdp_done_status1_w;
    end
end
//////// interrrupt status 0 for cdp ////////
assign cdp_done_status0_w = (done_set[2] | done_source[2]) ? 1'b1 :
                            (done_wr_clr[2]) ? 1'b0 :
                            cdp_done_status0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cdp_done_status0 <= 1'b0;
    end else begin
        cdp_done_status0 <= cdp_done_status0_w;
    end
end
//////// interrrupt status 1 for cdp ////////
assign cdp_done_status1_w = (done_set[3] | done_source[3]) ? 1'b1 :
                            (done_wr_clr[3]) ? 1'b0 :
                            cdp_done_status1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cdp_done_status1 <= 1'b0;
    end else begin
        cdp_done_status1 <= cdp_done_status1_w;
    end
end
//////// interrrupt status 0 for pdp ////////
assign pdp_done_status0_w = (done_set[4] | done_source[4]) ? 1'b1 :
                            (done_wr_clr[4]) ? 1'b0 :
                            pdp_done_status0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pdp_done_status0 <= 1'b0;
    end else begin
        pdp_done_status0 <= pdp_done_status0_w;
    end
end
//////// interrrupt status 1 for pdp ////////
assign pdp_done_status1_w = (done_set[5] | done_source[5]) ? 1'b1 :
                            (done_wr_clr[5]) ? 1'b0 :
                            pdp_done_status1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pdp_done_status1 <= 1'b0;
    end else begin
        pdp_done_status1 <= pdp_done_status1_w;
    end
end
//////// interrrupt status 0 for cdma_dat ////////
assign cdma_dat_done_status0_w = (done_set[10] | done_source[10]) ? 1'b1 :
                                 (done_wr_clr[10]) ? 1'b0 :
                                 cdma_dat_done_status0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cdma_dat_done_status0 <= 1'b0;
    end else begin
        cdma_dat_done_status0 <= cdma_dat_done_status0_w;
    end
end
//////// interrrupt status 1 for cdma_dat ////////
assign cdma_dat_done_status1_w = (done_set[11] | done_source[11]) ? 1'b1 :
                                 (done_wr_clr[11]) ? 1'b0 :
                                 cdma_dat_done_status1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cdma_dat_done_status1 <= 1'b0;
    end else begin
        cdma_dat_done_status1 <= cdma_dat_done_status1_w;
    end
end
//////// interrrupt status 0 for cdma_wt ////////
assign cdma_wt_done_status0_w = (done_set[12] | done_source[12]) ? 1'b1 :
                                (done_wr_clr[12]) ? 1'b0 :
                                cdma_wt_done_status0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cdma_wt_done_status0 <= 1'b0;
    end else begin
        cdma_wt_done_status0 <= cdma_wt_done_status0_w;
    end
end
//////// interrrupt status 1 for cdma_wt ////////
assign cdma_wt_done_status1_w = (done_set[13] | done_source[13]) ? 1'b1 :
                                (done_wr_clr[13]) ? 1'b0 :
                                cdma_wt_done_status1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cdma_wt_done_status1 <= 1'b0;
    end else begin
        cdma_wt_done_status1 <= cdma_wt_done_status1_w;
    end
end
//////// interrrupt status 0 for cacc ////////
assign cacc_done_status0_w = (done_set[14] | done_source[14]) ? 1'b1 :
                             (done_wr_clr[14]) ? 1'b0 :
                             cacc_done_status0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cacc_done_status0 <= 1'b0;
    end else begin
        cacc_done_status0 <= cacc_done_status0_w;
    end
end
//////// interrrupt status 1 for cacc ////////
assign cacc_done_status1_w = (done_set[15] | done_source[15]) ? 1'b1 :
                             (done_wr_clr[15]) ? 1'b0 :
                             cacc_done_status1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cacc_done_status1 <= 1'b0;
    end else begin
        cacc_done_status1 <= cacc_done_status1_w;
    end
end
assign core_intr_w = (~sdp_done_mask0 & sdp_done_status0) |
                     (~sdp_done_mask1 & sdp_done_status1) |
                     (~cdp_done_mask0 & cdp_done_status0) |
                     (~cdp_done_mask1 & cdp_done_status1) |
                     (~pdp_done_mask0 & pdp_done_status0) |
                     (~pdp_done_mask1 & pdp_done_status1) |
                     (~cdma_dat_done_mask0 & cdma_dat_done_status0) |
                     (~cdma_dat_done_mask1 & cdma_dat_done_status1) |
                     (~cdma_wt_done_mask0 & cdma_wt_done_status0) |
                     (~cdma_wt_done_mask1 & cdma_wt_done_status1) |
                     (~cacc_done_mask0 & cacc_done_status0) |
                     (~cacc_done_mask1 & cacc_done_status1);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        core_intr_d <= 1'b0;
    end else begin
        core_intr_d <= core_intr_w;
    end
end
NV_NVDLA_sync3d_c u_sync_core_intr (
   .clk (nvdla_falcon_clk) //|< i
  ,.rst (nvdla_falcon_rstn) //|< i
  ,.sync_i (core_intr_d) //|< r
  ,.sync_o (core_intr) //|> o
  );
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
  nv_assert_never #(0,0,"Error! Set and clear interrupt concurrently!") zzz_assert_never_1x (nvdla_core_clk, `ASSERT_RESET, (sdp_done_status0_trigger & sdp_done_set0_trigger)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! CDMA data sends two interrupts at same cycle!") zzz_assert_never_3x (nvdla_core_clk, `ASSERT_RESET, (cdma_dat2glb_done_intr_pd == 3'h3)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! CDMA weight sends two interrupts at same cycle!") zzz_assert_never_4x (nvdla_core_clk, `ASSERT_RESET, (cdma_wt2glb_done_intr_pd == 3'h3)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! CACC sends two interrupts at same cycle!") zzz_assert_never_5x (nvdla_core_clk, `ASSERT_RESET, (cacc2glb_done_intr_pd == 3'h3)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! SDP sends two interrupts at same cycle!") zzz_assert_never_6x (nvdla_core_clk, `ASSERT_RESET, (sdp2glb_done_intr_pd == 3'h3)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! PDP sends two interrupts at same cycle!") zzz_assert_never_7x (nvdla_core_clk, `ASSERT_RESET, (pdp2glb_done_intr_pd == 3'h3)); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"Error! CDP sends two interrupts at same cycle!") zzz_assert_never_8x (nvdla_core_clk, `ASSERT_RESET, (cdp2glb_done_intr_pd == 3'h3)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_GLB_ic
