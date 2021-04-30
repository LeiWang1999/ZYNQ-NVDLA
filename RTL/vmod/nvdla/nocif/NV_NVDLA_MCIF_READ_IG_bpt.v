// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_READ_IG_bpt.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
`include "simulate_x_tick.vh"
module NV_NVDLA_MCIF_READ_IG_bpt (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,dma2bpt_cdt_lat_fifo_pop //|< i
  ,dma2bpt_req_pd //|< i
  ,dma2bpt_req_valid //|< i
  ,dma2bpt_req_ready //|> o
  ,bpt2arb_req_pd //|> o
  ,bpt2arb_req_valid //|> o
  ,bpt2arb_req_ready //|< i
  ,tieoff_axid //|< i
  ,tieoff_lat_fifo_depth //|< i
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input dma2bpt_req_valid;
output dma2bpt_req_ready;
input [47 -1:0] dma2bpt_req_pd;
input dma2bpt_cdt_lat_fifo_pop;
output bpt2arb_req_valid;
input bpt2arb_req_ready;
output [32 +11 -1:0] bpt2arb_req_pd;
input [3:0] tieoff_axid;
input [8:0] tieoff_lat_fifo_depth;
reg [15 -1:0] count_req;
reg [15 -1:0] req_num;
wire lat_fifo_stall_enable;
reg lat_adv;
reg [10:0] lat_cnt_ext;
reg [10:0] lat_cnt_mod;
reg [10:0] lat_cnt_new;
reg [10:0] lat_cnt_nxt;
reg [8:0] lat_cnt_cur;
reg [8:0] lat_count_cnt;
reg [0:0] lat_count_dec;
wire [2:0] lat_count_inc;
wire [8:0] lat_fifo_free_slot;
wire mon_lat_fifo_free_slot_c;
reg [32 -1:0] out_addr;
wire [2:0] out_size;
reg [2:0] out_size_tmp;
wire [1:0] beat_size;
wire bpt2arb_accept;
wire [32 -1:0] bpt2arb_addr;
wire [3:0] bpt2arb_axid;
wire bpt2arb_ftran;
wire bpt2arb_ltran;
wire bpt2arb_odd;
wire [2:0] bpt2arb_size;
wire bpt2arb_swizzle;
wire [0 -1:0] stt_offset;
wire [0 -1:0] end_offset;
wire [0 -1:0] size_offset;
wire [0 -1:0] ftran_size_tmp;
wire [0 -1:0] ltran_size_tmp;
wire mon_end_offset_c;
wire [2:0] ftran_size;
wire [2:0] ltran_size;
wire [15 -1:0] mtran_num;
wire [32 -1:0] in_addr;
wire [47 -1:0] in_pd;
wire [47 -1:0] in_pd_p;
wire in_rdy;
wire in_rdy_p;
wire [15 -1:0] in_size;
wire in_vld;
wire in_vld_p;
wire [47 -1:0] in_vld_pd;
wire is_ftran;
wire is_ltran;
wire is_mtran;
wire is_single_tran;
wire mon_out_beats_c;
wire out_inc;
wire out_odd;
wire out_swizzle;
wire req_enable;
wire req_rdy;
wire req_vld;
NV_NVDLA_MCIF_READ_IG_BPT_pipe_p1 pipe_p1 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.dma2bpt_req_pd (dma2bpt_req_pd) //|< i
  ,.dma2bpt_req_valid (dma2bpt_req_valid) //|< i
  ,.dma2bpt_req_ready (dma2bpt_req_ready) //|> o
  ,.in_pd_p (in_pd_p) //|> w
  ,.in_vld_p (in_vld_p) //|> w
  ,.in_rdy_p (in_rdy_p) //|< w
  );
NV_NVDLA_MCIF_READ_IG_BPT_pipe_p2 pipe_p2 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.in_pd_p (in_pd_p) //|< w
  ,.in_vld_p (in_vld_p) //|< w
  ,.in_rdy_p (in_rdy_p) //|> w
  ,.in_pd (in_pd) //|> w
  ,.in_vld (in_vld) //|> w
  ,.in_rdy (in_rdy) //|< w
  );
assign in_rdy = req_rdy & is_ltran;
assign in_vld_pd = {47{in_vld}} & in_pd;
assign in_addr[32 -1:0] = in_vld_pd[32 -1:0];
assign in_size[15 -1:0] = in_vld_pd[47 -1:32];
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
  wire cond_zzz_assert_always_1x = (in_addr[3 -1:0] == 0);
  nv_assert_always #(0,0,"lower LSB should always be 0") zzz_assert_always_1x (.clk(nvdla_core_clk), .reset_(`ASSERT_RESET), .test_expr(cond_zzz_assert_always_1x)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
assign ftran_size[2:0] = 3'b0;
assign ltran_size[2:0] = 3'b0;
assign mtran_num = in_size - 1;
//================
// check the empty entry of lat.fifo
//================
wire [2:0] slot_needed = 3'b1;
assign lat_fifo_stall_enable = (tieoff_lat_fifo_depth!=0);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    lat_count_dec <= 1'b0;
  end else begin
    lat_count_dec <= dma2bpt_cdt_lat_fifo_pop;
  end
end
assign lat_count_inc = (bpt2arb_accept && lat_fifo_stall_enable ) ? slot_needed : 0;
always @(
  lat_count_inc
  or lat_count_dec
  ) begin
  lat_adv = lat_count_inc[2:0] != {{2{1'b0}}, lat_count_dec[0:0]};
end
// lat cnt logic
always @(
  lat_cnt_cur
  or lat_count_inc
  or lat_count_dec
  or lat_adv
  ) begin
// VCS sop_coverage_off start
  lat_cnt_ext[10:0] = {1'b0, 1'b0, lat_cnt_cur};
  lat_cnt_mod[10:0] = lat_cnt_cur + lat_count_inc[2:0] - lat_count_dec[0:0]; // spyglass disable W164b
  lat_cnt_new[10:0] = (lat_adv)? lat_cnt_mod[10:0] : lat_cnt_ext[10:0];
  lat_cnt_nxt[10:0] = lat_cnt_new[10:0];
// VCS sop_coverage_off end
//| &End;
end
// lat flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    lat_cnt_cur[8:0] <= 0;
  end else begin
  lat_cnt_cur[8:0] <= lat_cnt_nxt[8:0];
  end
end
// lat output logic
always @(
  lat_cnt_cur
  ) begin
  lat_count_cnt[8:0] = lat_cnt_cur[8:0];
end
// lat asserts
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
  nv_assert_never #(0,0,"never: counter underflow below <und_cnt>") zzz_assert_never_2x (nvdla_core_clk, `ASSERT_RESET, (lat_cnt_nxt < 0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
assign {mon_lat_fifo_free_slot_c,lat_fifo_free_slot[8:0]} = tieoff_lat_fifo_depth - lat_count_cnt;
assign req_enable = (!lat_fifo_stall_enable) || ({{6{1'b0}}, slot_needed} <= lat_fifo_free_slot);
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
  nv_assert_never #(0,0,"should not over flow") zzz_assert_never_3x (nvdla_core_clk, `ASSERT_RESET, mon_lat_fifo_free_slot_c); // spyglass disable W504 SelfDeterminedExpr-ML 
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
//================
// bsp out: swizzle
//================
assign out_swizzle = 1'b0;
assign out_odd = 1'b0;
//================
// bsp out: size
//================
assign out_size = 3'h0;
//================
// bpt2arb: addr
//================
always @(posedge nvdla_core_clk) begin
    if (bpt2arb_accept) begin
        if (is_ftran) begin
            out_addr <= in_addr + (1 <<3);
        end else begin
            out_addr <= out_addr + (1<<3);
        end
    end
end
//================
// tran count
//================
always @(*) begin
  req_num = in_size;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_req <= {15{1'b0}};
  end else begin
    if (bpt2arb_accept) begin
        if (is_ltran) begin
            count_req <= 0;
        end else begin
            count_req <= count_req + 1;
        end
    end
  end
end
assign is_ftran = (count_req==0);
assign is_mtran = (count_req>0 && count_req<req_num);
assign is_ltran = (count_req==req_num);
assign bpt2arb_addr = (is_ftran) ? in_addr : out_addr;
assign bpt2arb_size = out_size;
assign bpt2arb_swizzle = out_swizzle;
assign bpt2arb_odd = out_odd;
assign bpt2arb_ltran = is_ltran;
assign bpt2arb_ftran = is_ftran;
assign bpt2arb_axid = tieoff_axid[3:0];
assign req_rdy = req_enable & bpt2arb_req_ready;
assign req_vld = req_enable & in_vld;
assign bpt2arb_req_valid = req_vld;
assign bpt2arb_accept = bpt2arb_req_valid & req_rdy;
assign bpt2arb_req_pd[3:0] = bpt2arb_axid[3:0];
assign bpt2arb_req_pd[32 +3:4] = bpt2arb_addr[32 -1:0];
assign bpt2arb_req_pd[32 +6:32 +4] = bpt2arb_size[2:0];
assign bpt2arb_req_pd[32 +7] = bpt2arb_swizzle ;
assign bpt2arb_req_pd[32 +8] = bpt2arb_odd ;
assign bpt2arb_req_pd[32 +9] = bpt2arb_ltran ;
assign bpt2arb_req_pd[32 +10] = bpt2arb_ftran ;
endmodule // NV_NVDLA_MCIF_READ_IG_bpt
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is in_pd_p (in_vld_p,in_rdy_p) <= dma2bpt_req_pd[47 -1:0] (dma2bpt_req_valid,dma2bpt_req_ready)
// **************************************************************************************************************
module NV_NVDLA_MCIF_READ_IG_BPT_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dma2bpt_req_pd
  ,dma2bpt_req_valid
  ,dma2bpt_req_ready
  ,in_pd_p
  ,in_vld_p
  ,in_rdy_p
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [47 -1:0] dma2bpt_req_pd;
input dma2bpt_req_valid;
output dma2bpt_req_ready;
output [47 -1:0] in_pd_p;
output in_vld_p;
input in_rdy_p;
//: my $mem = 47;
//: &eperl::pipe(" -wid $mem -is -do in_pd_p -vo in_vld_p -ri in_rdy_p  -di dma2bpt_req_pd -vi dma2bpt_req_valid -ro dma2bpt_req_ready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg dma2bpt_req_ready;
reg skid_flop_dma2bpt_req_ready;
reg skid_flop_dma2bpt_req_valid;
reg [47-1:0] skid_flop_dma2bpt_req_pd;
reg pipe_skid_dma2bpt_req_valid;
reg [47-1:0] pipe_skid_dma2bpt_req_pd;
// Wire
wire skid_dma2bpt_req_valid;
wire [47-1:0] skid_dma2bpt_req_pd;
wire skid_dma2bpt_req_ready;
wire pipe_skid_dma2bpt_req_ready;
wire in_vld_p;
wire [47-1:0] in_pd_p;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dma2bpt_req_ready <= 1'b1;
       skid_flop_dma2bpt_req_ready <= 1'b1;
   end else begin
       dma2bpt_req_ready <= skid_dma2bpt_req_ready;
       skid_flop_dma2bpt_req_ready <= skid_dma2bpt_req_ready;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_dma2bpt_req_valid <= 1'b0;
    end else begin
        if (skid_flop_dma2bpt_req_ready) begin
            skid_flop_dma2bpt_req_valid <= dma2bpt_req_valid;
        end
   end
end
assign skid_dma2bpt_req_valid = (skid_flop_dma2bpt_req_ready) ? dma2bpt_req_valid : skid_flop_dma2bpt_req_valid;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_dma2bpt_req_ready & dma2bpt_req_valid) begin
        skid_flop_dma2bpt_req_pd[47-1:0] <= dma2bpt_req_pd[47-1:0];
    end
end
assign skid_dma2bpt_req_pd[47-1:0] = (skid_flop_dma2bpt_req_ready) ? dma2bpt_req_pd[47-1:0] : skid_flop_dma2bpt_req_pd[47-1:0];


// PIPE READY
assign skid_dma2bpt_req_ready = pipe_skid_dma2bpt_req_ready || !pipe_skid_dma2bpt_req_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_dma2bpt_req_valid <= 1'b0;
    end else begin
        if (skid_dma2bpt_req_ready) begin
            pipe_skid_dma2bpt_req_valid <= skid_dma2bpt_req_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_dma2bpt_req_ready && skid_dma2bpt_req_valid) begin
        pipe_skid_dma2bpt_req_pd[47-1:0] <= skid_dma2bpt_req_pd[47-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_dma2bpt_req_ready = in_rdy_p;
assign in_vld_p = pipe_skid_dma2bpt_req_valid;
assign in_pd_p = pipe_skid_dma2bpt_req_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is in_pd (in_vld,in_rdy) <= in_pd_p[47 -1:0] (in_vld_p,in_rdy_p)
// **************************************************************************************************************
module NV_NVDLA_MCIF_READ_IG_BPT_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,in_pd_p
  ,in_vld_p
  ,in_rdy_p
  ,in_pd
  ,in_vld
  ,in_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [47 -1:0] in_pd_p;
input in_vld_p;
output in_rdy_p;
output [47 -1:0] in_pd;
output in_vld;
input in_rdy;
//: my $mem = 47;
//: &eperl::pipe(" -wid $mem -is -do in_pd -vo in_vld -ri in_rdy -di in_pd_p -vi in_vld_p -ro in_rdy_p ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg in_rdy_p;
reg skid_flop_in_rdy_p;
reg skid_flop_in_vld_p;
reg [47-1:0] skid_flop_in_pd_p;
reg pipe_skid_in_vld_p;
reg [47-1:0] pipe_skid_in_pd_p;
// Wire
wire skid_in_vld_p;
wire [47-1:0] skid_in_pd_p;
wire skid_in_rdy_p;
wire pipe_skid_in_rdy_p;
wire in_vld;
wire [47-1:0] in_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rdy_p <= 1'b1;
       skid_flop_in_rdy_p <= 1'b1;
   end else begin
       in_rdy_p <= skid_in_rdy_p;
       skid_flop_in_rdy_p <= skid_in_rdy_p;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_in_vld_p <= 1'b0;
    end else begin
        if (skid_flop_in_rdy_p) begin
            skid_flop_in_vld_p <= in_vld_p;
        end
   end
end
assign skid_in_vld_p = (skid_flop_in_rdy_p) ? in_vld_p : skid_flop_in_vld_p;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_in_rdy_p & in_vld_p) begin
        skid_flop_in_pd_p[47-1:0] <= in_pd_p[47-1:0];
    end
end
assign skid_in_pd_p[47-1:0] = (skid_flop_in_rdy_p) ? in_pd_p[47-1:0] : skid_flop_in_pd_p[47-1:0];


// PIPE READY
assign skid_in_rdy_p = pipe_skid_in_rdy_p || !pipe_skid_in_vld_p;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_in_vld_p <= 1'b0;
    end else begin
        if (skid_in_rdy_p) begin
            pipe_skid_in_vld_p <= skid_in_vld_p;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_in_rdy_p && skid_in_vld_p) begin
        pipe_skid_in_pd_p[47-1:0] <= skid_in_pd_p[47-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_in_rdy_p = in_rdy;
assign in_vld = pipe_skid_in_vld_p;
assign in_pd = pipe_skid_in_pd_p;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_READ_IG_BPT_pipe_p2
