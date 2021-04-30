// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_WRITE_IG_cvt.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
`include "simulate_x_tick.vh"
module NV_NVDLA_MCIF_WRITE_IG_cvt (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,reg2dp_wr_os_cnt //|< i
  ,cq_wr_pd //|> o
  ,cq_wr_pvld //|> o
  ,cq_wr_prdy //|< i
  ,cq_wr_thread_id //|> o
  ,eg2ig_axi_len //|< i
  ,eg2ig_axi_vld //|< i
  ,spt2cvt_cmd_pd //|< i
  ,spt2cvt_cmd_valid //|< i
  ,spt2cvt_cmd_ready //|> o
  ,spt2cvt_dat_pd //|< i
  ,spt2cvt_dat_valid //|< i
  ,spt2cvt_dat_ready //|> o
  ,mcif2noc_axi_aw_awaddr //|> o
  ,mcif2noc_axi_aw_awid //|> o
  ,mcif2noc_axi_aw_awlen //|> o
  ,mcif2noc_axi_aw_awvalid //|> o
  ,mcif2noc_axi_aw_awready //|< i
  ,mcif2noc_axi_w_wdata //|> o
  ,mcif2noc_axi_w_wlast //|> o
  ,mcif2noc_axi_w_wstrb //|> o
  ,mcif2noc_axi_w_wvalid //|> o
  ,mcif2noc_axi_w_wready //|< i
  );
//
// NV_NVDLA_MCIF_WRITE_IG_cvt_ports.v
//
input nvdla_core_clk;
input nvdla_core_rstn;
input spt2cvt_cmd_valid;
output spt2cvt_cmd_ready;
input [32 +13 -1:0] spt2cvt_cmd_pd;
input spt2cvt_dat_valid;
output spt2cvt_dat_ready;
input [64 +1 -1:0] spt2cvt_dat_pd;
output cq_wr_pvld;
input cq_wr_prdy;
output [2:0] cq_wr_pd;
output [2:0] cq_wr_thread_id;
output mcif2noc_axi_aw_awvalid;
input mcif2noc_axi_aw_awready;
output [32 -1:0] mcif2noc_axi_aw_awaddr;
output [7:0] mcif2noc_axi_aw_awid;
output [3:0] mcif2noc_axi_aw_awlen;
output mcif2noc_axi_w_wvalid;
input mcif2noc_axi_w_wready;
output [64 -1:0] mcif2noc_axi_w_wdata;
output [8 -1:0] mcif2noc_axi_w_wstrb;
output mcif2noc_axi_w_wlast;
input [1:0] eg2ig_axi_len;
input eg2ig_axi_vld;
input [7:0] reg2dp_wr_os_cnt;
reg [1:0] eg2ig_axi_len_d;
reg eg2ig_axi_vld_d;
reg os_adv;
reg [8:0] os_cnt;
reg [8:0] os_cnt_cur;
reg [10:0] os_cnt_ext;
reg [10:0] os_cnt_mod;
reg [10:0] os_cnt_new;
reg [10:0] os_cnt_nxt;
wire all_downs_rdy;
wire axi_both_rdy;
wire [32 -1:0] axi_addr;
wire [3:0] axi_axid;
wire [32 +5:0] axi_aw_pd;
wire [32 +5:0] axi_cmd_pd;
wire axi_cmd_rdy;
wire axi_cmd_vld;
wire [64 +8:0] axi_dat_pd;
wire axi_dat_rdy;
wire axi_dat_vld;
wire [64 -1:0] axi_data;
wire axi_last;
wire [1:0] axi_len;
wire [8 -1:0] axi_strb;
wire [64 +8:0] axi_w_pd;
wire [7:0] cfg_wr_os_cnt;
wire [32 -1:0] cmd_addr;
wire [3:0] cmd_axid;
wire cmd_ftran;
wire cmd_inc;
wire cmd_ltran;
wire cmd_odd;
wire [32 +13 -1:0] cmd_pd;
wire cmd_rdy;
wire cmd_require_ack;
wire [2:0] cmd_size;
wire cmd_swizzle;
wire [2:0] cmd_user_size;
wire cmd_vld;
wire [32 +13 -1:0] cmd_vld_pd;
wire [1:0] cq_wr_len;
wire cq_wr_require_ack;
wire [64 -1:0] dat_data;
wire [1 -1:0] dat_mask;
wire [64 +1 -1:0] dat_pd;
wire dat_rdy;
wire dat_vld;
wire [0:0] mon_thread_id_c;
wire is_first_beat;
wire is_single_beat;
wire is_last_beat;
reg [1:0] beat_count;
wire is_first_cmd_dat_vld;
wire [32 -1:0] opipe_axi_addr;
wire [3:0] opipe_axi_axid;
wire [64 -1:0] opipe_axi_data;
wire opipe_axi_last;
wire [1:0] opipe_axi_len;
wire [8 -1:0] opipe_axi_strb;
wire os_cmd_vld;
wire [2:0] os_cnt_add;
wire os_cnt_add_en;
wire os_cnt_cen;
wire os_cnt_full;
wire [2:0] os_cnt_sub;
wire os_cnt_sub_en;
wire [2:0] os_inp_add_nxt;
wire [9:0] os_inp_nxt;
wire [2:0] os_inp_sub_nxt;
wire [8:0] wr_os_cnt_ext;
//IG_cvt===upack : none-flop-in
NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p1 pipe_p1 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.spt2cvt_cmd_pd (spt2cvt_cmd_pd)
  ,.spt2cvt_cmd_valid (spt2cvt_cmd_valid) //|< i
  ,.spt2cvt_cmd_ready (spt2cvt_cmd_ready) //|> o
  ,.cmd_pd (cmd_pd)
  ,.cmd_vld (cmd_vld) //|> w
  ,.cmd_rdy (cmd_rdy) //|< w
  );
NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p2 pipe_p2 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.spt2cvt_dat_pd (spt2cvt_dat_pd)
  ,.spt2cvt_dat_valid (spt2cvt_dat_valid) //|< i
  ,.spt2cvt_dat_ready (spt2cvt_dat_ready) //|> o
  ,.dat_pd (dat_pd)
  ,.dat_vld (dat_vld) //|> w
  ,.dat_rdy (dat_rdy) //|< w
  );
assign os_cmd_vld = cmd_vld & !os_cnt_full;
//IG_cvt=== push into the cq on first beat of data
assign dat_rdy = is_first_beat ? (os_cmd_vld & all_downs_rdy) : axi_dat_rdy;
//IG_cvt=== will release cmd on the acception of last beat of data
assign cmd_rdy = is_first_beat & dat_vld & all_downs_rdy & !os_cnt_full;
//IG_cvt===UNPACK after ipipe
assign cmd_vld_pd = {32 +13{cmd_vld}} & cmd_pd;
assign cmd_axid = cmd_vld_pd[3:0];
assign cmd_require_ack = cmd_vld_pd[4];
assign cmd_addr = cmd_vld_pd[32 +4:5];
assign cmd_size = cmd_vld_pd[32 +7:32 +5];
assign cmd_swizzle = cmd_vld_pd[32 +8];
assign cmd_odd = cmd_vld_pd[32 +9];
assign cmd_inc = cmd_vld_pd[32 +10];
assign cmd_ltran = cmd_vld_pd[32 +11];
assign cmd_ftran = cmd_vld_pd[32 +12];
// PKT_UNPACK_WIRE( cvt_write_data , dat_ , dat_pd )
assign dat_data[64 -1:0] = dat_pd[64 -1:0];
assign dat_mask[1 -1:0] = dat_pd[64 +1 -1:64];
assign axi_len[1:0] = cmd_size[1:0];
assign is_first_cmd_dat_vld = os_cmd_vld & dat_vld && is_first_beat;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    beat_count <= {2{1'b0}};
  end else begin
    if (is_first_cmd_dat_vld & all_downs_rdy) begin
        beat_count <= axi_len;
    end else if ((beat_count!=0) & dat_vld & axi_dat_rdy) begin //fixme
        beat_count <= beat_count - 1;
    end
  end
end
assign is_first_beat = (beat_count==0);
assign is_single_beat = (axi_len==0);
assign is_last_beat = (beat_count==1 || (beat_count==0 && is_single_beat));
assign axi_axid = cmd_axid[3:0];
assign axi_addr = cmd_addr;
assign axi_data = dat_data;
assign axi_last = is_last_beat;
assign axi_strb = {8{dat_mask}}; //{{32{dat_mask[1]}},{32{dat_mask[0]}}};
//=====================================
assign os_inp_add_nxt[2:0] = cmd_vld ? (axi_len + 1) : 3'd0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
     eg2ig_axi_vld_d <= 1'b0;
  end else begin
     eg2ig_axi_vld_d <= eg2ig_axi_vld;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
     eg2ig_axi_len_d <= {2{1'b0}};
  end else begin
  if ((eg2ig_axi_vld) == 1'b1) begin
     eg2ig_axi_len_d <= eg2ig_axi_len;
// VCS coverage off
  end else if ((eg2ig_axi_vld) == 1'b0) begin
  end else begin
     eg2ig_axi_len_d <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(eg2ig_axi_vld))); // spyglass disable W504 SelfDeterminedExpr-ML 
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
assign os_inp_sub_nxt[2:0] = eg2ig_axi_vld_d ? (eg2ig_axi_len_d+1) : 3'd0;
assign os_inp_nxt[9:0] = os_cnt + os_inp_add_nxt - os_inp_sub_nxt;
// IG_cvt=== 256 outstanding trans
assign os_cnt_add_en = axi_cmd_vld & axi_cmd_rdy;
assign os_cnt_sub_en = eg2ig_axi_vld_d;
assign os_cnt_cen = os_cnt_add_en | os_cnt_sub_en;
assign os_cnt_add = os_cnt_add_en ? (axi_len + 1) : 3'd0;
assign os_cnt_sub = os_cnt_sub_en ? (eg2ig_axi_len_d+1) : 3'd0;
assign cfg_wr_os_cnt = reg2dp_wr_os_cnt[7:0];
assign wr_os_cnt_ext = {{1{1'b0}}, cfg_wr_os_cnt};
assign os_cnt_full = os_inp_nxt>(wr_os_cnt_ext+1);
// os adv logic
always @(
  os_cnt_add
  or os_cnt_sub
  ) begin
  os_adv = os_cnt_add[2:0] != os_cnt_sub[2:0];
end
// os cnt logic
always @(
  os_cnt_cur
  or os_cnt_add
  or os_cnt_sub
  or os_adv
  ) begin
// VCS sop_coverage_off start
  os_cnt_ext[10:0] = {1'b0, 1'b0, os_cnt_cur};
  os_cnt_mod[10:0] = os_cnt_cur + os_cnt_add[2:0] - os_cnt_sub[2:0]; // spyglass disable W164b
  os_cnt_new[10:0] = (os_adv)? os_cnt_mod[10:0] : os_cnt_ext[10:0];
  os_cnt_nxt[10:0] = os_cnt_new[10:0];
// VCS sop_coverage_off end
end
// os flops
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    os_cnt_cur[8:0] <= 0;
  end else begin
  if (os_cnt_cen) begin
  os_cnt_cur[8:0] <= os_cnt_nxt[8:0];
  end
  end
end
// os output logic
always @(
  os_cnt_cur
  ) begin
  os_cnt[8:0] = os_cnt_cur[8:0];
end
// os asserts
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
  nv_assert_never #(0,0,"never: counter overflow beyond <ovr_cnt>") zzz_assert_never_4x (nvdla_core_clk, `ASSERT_RESET, (os_cnt_nxt > 256 && os_cnt_cen)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
//IG_cvt=== PIPE for $NOC ADDR Channel
// cmd will be pushed into pipe with the 1st beat of data in that cmd,
// and when *_beat_vld is high, *_cmd_vld should always be there.
assign axi_cmd_vld = is_first_cmd_dat_vld & cq_wr_prdy & axi_dat_rdy;
NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p3 pipe_p3 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.axi_cmd_pd (axi_cmd_pd) //|< w
  ,.axi_cmd_vld (axi_cmd_vld) //|< w
  ,.axi_cmd_rdy (axi_cmd_rdy) //|> w
  ,.axi_aw_pd (axi_aw_pd) //|> w
  ,.mcif2noc_axi_aw_awvalid (mcif2noc_axi_aw_awvalid) //|> o
  ,.mcif2noc_axi_aw_awready (mcif2noc_axi_aw_awready) //|< i
  );
//IG_cvt=== PIPE for $NOC DATA Channel
// first beat of data also need cq and cmd rdy, this is because we also need push ack/cmd into cq fifo and cmd pipe on first beat of data
assign axi_dat_vld = dat_vld & (!is_first_beat || (os_cmd_vld & cq_wr_prdy & axi_cmd_rdy));
//assign axi_dat_vld = dat_vld & (os_cmd_vld & cq_wr_prdy & axi_cmd_rdy);
NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p4 pipe_p4 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.axi_dat_pd (axi_dat_pd) //|< w
  ,.axi_dat_vld (axi_dat_vld) //|< w
  ,.axi_dat_rdy (axi_dat_rdy) //|> w
  ,.axi_w_pd (axi_w_pd) //|> w
  ,.mcif2noc_axi_w_wvalid (mcif2noc_axi_w_wvalid) //|> o
  ,.mcif2noc_axi_w_wready (mcif2noc_axi_w_wready) //|< i
  );
assign axi_cmd_pd = {axi_axid,axi_addr,axi_len};
assign {opipe_axi_axid,opipe_axi_addr,opipe_axi_len} = axi_aw_pd;
assign axi_dat_pd = {axi_data,axi_strb,axi_last};
assign {opipe_axi_data,opipe_axi_strb,opipe_axi_last} = axi_w_pd;
// IG_cvt===AXI OUT ZERO EXT
assign mcif2noc_axi_aw_awid = {{4{1'b0}}, opipe_axi_axid};
assign mcif2noc_axi_aw_awaddr = opipe_axi_addr;
assign mcif2noc_axi_aw_awlen = {{2{1'b0}}, opipe_axi_len};
assign mcif2noc_axi_w_wlast = opipe_axi_last;
assign mcif2noc_axi_w_wdata = opipe_axi_data;
assign mcif2noc_axi_w_wstrb = opipe_axi_strb;
//=====================================
// DownStream readiness
//=====================================
assign axi_both_rdy = axi_cmd_rdy & axi_dat_rdy;
assign all_downs_rdy = cq_wr_prdy & axi_both_rdy;
//=====================================
// Outstanding Queue
//=====================================
// IG_cvt===valid for axi_cmd and oq, inter-lock
assign cq_wr_pvld = is_first_cmd_dat_vld & axi_both_rdy & !os_cnt_full;
assign cq_wr_require_ack = cmd_ltran & cmd_require_ack;
assign cq_wr_len = axi_len;
// PKT_PACK_WIRE( mcif_write_ig2eg , cq_wr_ , cq_wr_pd )
assign cq_wr_pd[0] = cq_wr_require_ack ;
assign cq_wr_pd[2:1] = cq_wr_len[1:0];
assign {mon_thread_id_c,cq_wr_thread_id[2:0]} = cmd_axid;
`ifdef NVDLA_PRINT_AXI
reg [32 +5:0] mon_axi_count;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        mon_axi_count <= 0;
    end else begin
        mon_axi_count <= mon_axi_count + 1'b1;
    end
    if (mcif2noc_axi_aw_awvalid & mcif2noc_axi_aw_awready) begin
        $display("NVDLA MCIF WRITE ADDR:time=%0d:cycle=%0d:addr=0x%0h:id=%0d:len=%0d",$stime,mon_axi_count,mcif2noc_axi_aw_awaddr,mcif2noc_axi_aw_awid,mcif2noc_axi_aw_awlen);
    end
end
`endif
endmodule // NV_NVDLA_MCIF_WRITE_IG_cvt
// **************************************************************************************************************
// Generated by ::pipe -m -rand none -bc cmd_pd (cmd_vld,cmd_rdy) <= spt2cvt_cmd_pd[32 +13 -1:0] (spt2cvt_cmd_valid,spt2cvt_cmd_ready)
// **************************************************************************************************************
module NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,spt2cvt_cmd_pd
  ,spt2cvt_cmd_valid
  ,spt2cvt_cmd_ready
  ,cmd_pd
  ,cmd_vld
  ,cmd_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [32 +13 -1:0] spt2cvt_cmd_pd;
input spt2cvt_cmd_valid;
output spt2cvt_cmd_ready;
output [32 +13 -1:0] cmd_pd;
output cmd_vld;
input cmd_rdy;
//: my $k = 32 +13;
//: &eperl::pipe(" -wid $k -do cmd_pd -vo cmd_vld -ri cmd_rdy -di  spt2cvt_cmd_pd -vi spt2cvt_cmd_valid -ro spt2cvt_cmd_ready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg pipe_spt2cvt_cmd_valid;
reg [45-1:0] pipe_spt2cvt_cmd_pd;
// Wire
wire spt2cvt_cmd_ready;
wire pipe_spt2cvt_cmd_ready;
wire cmd_vld;
wire [45-1:0] cmd_pd;
// Code
// PIPE READY
assign spt2cvt_cmd_ready = pipe_spt2cvt_cmd_ready || !pipe_spt2cvt_cmd_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_spt2cvt_cmd_valid <= 1'b0;
    end else begin
        if (spt2cvt_cmd_ready) begin
            pipe_spt2cvt_cmd_valid <= spt2cvt_cmd_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (spt2cvt_cmd_ready && spt2cvt_cmd_valid) begin
        pipe_spt2cvt_cmd_pd[45-1:0] <= spt2cvt_cmd_pd[45-1:0];
    end
end


// PIPE OUTPUT
assign pipe_spt2cvt_cmd_ready = cmd_rdy;
assign cmd_vld = pipe_spt2cvt_cmd_valid;
assign cmd_pd = pipe_spt2cvt_cmd_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p1
// **************************************************************************************************************
// Generated by ::pipe -m -rand none -bc dat_pd (dat_vld,dat_rdy) <= spt2cvt_dat_pd[64 +1 -1:0] (spt2cvt_dat_valid,spt2cvt_dat_ready)
// **************************************************************************************************************
module NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,spt2cvt_dat_pd
  ,spt2cvt_dat_valid
  ,spt2cvt_dat_ready
  ,dat_pd
  ,dat_vld
  ,dat_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [64 +1 -1:0] spt2cvt_dat_pd;
input spt2cvt_dat_valid;
output spt2cvt_dat_ready;
output [64 +1 -1:0] dat_pd;
output dat_vld;
input dat_rdy;
//: my $k = 64 +1;
//: &eperl::pipe(" -wid  $k -do dat_pd -vo dat_vld -ri dat_rdy -di  spt2cvt_dat_pd -vi spt2cvt_dat_valid -ro spt2cvt_dat_ready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg pipe_spt2cvt_dat_valid;
reg [65-1:0] pipe_spt2cvt_dat_pd;
// Wire
wire spt2cvt_dat_ready;
wire pipe_spt2cvt_dat_ready;
wire dat_vld;
wire [65-1:0] dat_pd;
// Code
// PIPE READY
assign spt2cvt_dat_ready = pipe_spt2cvt_dat_ready || !pipe_spt2cvt_dat_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_spt2cvt_dat_valid <= 1'b0;
    end else begin
        if (spt2cvt_dat_ready) begin
            pipe_spt2cvt_dat_valid <= spt2cvt_dat_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (spt2cvt_dat_ready && spt2cvt_dat_valid) begin
        pipe_spt2cvt_dat_pd[65-1:0] <= spt2cvt_dat_pd[65-1:0];
    end
end


// PIPE OUTPUT
assign pipe_spt2cvt_dat_ready = dat_rdy;
assign dat_vld = pipe_spt2cvt_dat_valid;
assign dat_pd = pipe_spt2cvt_dat_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p2
// **************************************************************************************************************
// Generated by ::pipe -m -rand none -bc -is axi_aw_pd (mcif2noc_axi_aw_awvalid,mcif2noc_axi_aw_awready) <= axi_cmd_pd[32 +5:0] (axi_cmd_vld,axi_cmd_rdy)
// **************************************************************************************************************
module NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p3 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,axi_cmd_pd
  ,axi_cmd_vld
  ,axi_cmd_rdy
  ,axi_aw_pd
  ,mcif2noc_axi_aw_awvalid
  ,mcif2noc_axi_aw_awready
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [32 +5:0] axi_cmd_pd;
input axi_cmd_vld;
output axi_cmd_rdy;
output [32 +5:0] axi_aw_pd;
output mcif2noc_axi_aw_awvalid;
input mcif2noc_axi_aw_awready;
//: my $k = 32 +6;
//: &eperl::pipe(" -wid $k -is -do axi_aw_pd -vo mcif2noc_axi_aw_awvalid -ri mcif2noc_axi_aw_awready -di axi_cmd_pd -vi axi_cmd_vld -ro axi_cmd_rdy ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg axi_cmd_rdy;
reg skid_flop_axi_cmd_rdy;
reg skid_flop_axi_cmd_vld;
reg [38-1:0] skid_flop_axi_cmd_pd;
reg pipe_skid_axi_cmd_vld;
reg [38-1:0] pipe_skid_axi_cmd_pd;
// Wire
wire skid_axi_cmd_vld;
wire [38-1:0] skid_axi_cmd_pd;
wire skid_axi_cmd_rdy;
wire pipe_skid_axi_cmd_rdy;
wire mcif2noc_axi_aw_awvalid;
wire [38-1:0] axi_aw_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       axi_cmd_rdy <= 1'b1;
       skid_flop_axi_cmd_rdy <= 1'b1;
   end else begin
       axi_cmd_rdy <= skid_axi_cmd_rdy;
       skid_flop_axi_cmd_rdy <= skid_axi_cmd_rdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_axi_cmd_vld <= 1'b0;
    end else begin
        if (skid_flop_axi_cmd_rdy) begin
            skid_flop_axi_cmd_vld <= axi_cmd_vld;
        end
   end
end
assign skid_axi_cmd_vld = (skid_flop_axi_cmd_rdy) ? axi_cmd_vld : skid_flop_axi_cmd_vld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_axi_cmd_rdy & axi_cmd_vld) begin
        skid_flop_axi_cmd_pd[38-1:0] <= axi_cmd_pd[38-1:0];
    end
end
assign skid_axi_cmd_pd[38-1:0] = (skid_flop_axi_cmd_rdy) ? axi_cmd_pd[38-1:0] : skid_flop_axi_cmd_pd[38-1:0];


// PIPE READY
assign skid_axi_cmd_rdy = pipe_skid_axi_cmd_rdy || !pipe_skid_axi_cmd_vld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_axi_cmd_vld <= 1'b0;
    end else begin
        if (skid_axi_cmd_rdy) begin
            pipe_skid_axi_cmd_vld <= skid_axi_cmd_vld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_axi_cmd_rdy && skid_axi_cmd_vld) begin
        pipe_skid_axi_cmd_pd[38-1:0] <= skid_axi_cmd_pd[38-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_axi_cmd_rdy = mcif2noc_axi_aw_awready;
assign mcif2noc_axi_aw_awvalid = pipe_skid_axi_cmd_vld;
assign axi_aw_pd = pipe_skid_axi_cmd_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p3
// **************************************************************************************************************
// Generated by ::pipe -m -rand none -bc -is axi_w_pd (mcif2noc_axi_w_wvalid,mcif2noc_axi_w_wready) <= axi_dat_pd (axi_dat_vld,axi_dat_rdy)
// **************************************************************************************************************
module NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p4 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,axi_dat_pd
  ,axi_dat_vld
  ,axi_dat_rdy
  ,axi_w_pd
  ,mcif2noc_axi_w_wvalid
  ,mcif2noc_axi_w_wready
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [64 +8:0] axi_dat_pd;
input axi_dat_vld;
output axi_dat_rdy;
output [64 +8:0] axi_w_pd;
output mcif2noc_axi_w_wvalid;
input mcif2noc_axi_w_wready;
//: my $k = 64 +8 +1;
//: &eperl::pipe(" -wid $k -is -do axi_w_pd -vo mcif2noc_axi_w_wvalid -ri mcif2noc_axi_w_wready -di axi_dat_pd -vi axi_dat_vld -ro axi_dat_rdy ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg axi_dat_rdy;
reg skid_flop_axi_dat_rdy;
reg skid_flop_axi_dat_vld;
reg [73-1:0] skid_flop_axi_dat_pd;
reg pipe_skid_axi_dat_vld;
reg [73-1:0] pipe_skid_axi_dat_pd;
// Wire
wire skid_axi_dat_vld;
wire [73-1:0] skid_axi_dat_pd;
wire skid_axi_dat_rdy;
wire pipe_skid_axi_dat_rdy;
wire mcif2noc_axi_w_wvalid;
wire [73-1:0] axi_w_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       axi_dat_rdy <= 1'b1;
       skid_flop_axi_dat_rdy <= 1'b1;
   end else begin
       axi_dat_rdy <= skid_axi_dat_rdy;
       skid_flop_axi_dat_rdy <= skid_axi_dat_rdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_axi_dat_vld <= 1'b0;
    end else begin
        if (skid_flop_axi_dat_rdy) begin
            skid_flop_axi_dat_vld <= axi_dat_vld;
        end
   end
end
assign skid_axi_dat_vld = (skid_flop_axi_dat_rdy) ? axi_dat_vld : skid_flop_axi_dat_vld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_axi_dat_rdy & axi_dat_vld) begin
        skid_flop_axi_dat_pd[73-1:0] <= axi_dat_pd[73-1:0];
    end
end
assign skid_axi_dat_pd[73-1:0] = (skid_flop_axi_dat_rdy) ? axi_dat_pd[73-1:0] : skid_flop_axi_dat_pd[73-1:0];


// PIPE READY
assign skid_axi_dat_rdy = pipe_skid_axi_dat_rdy || !pipe_skid_axi_dat_vld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_axi_dat_vld <= 1'b0;
    end else begin
        if (skid_axi_dat_rdy) begin
            pipe_skid_axi_dat_vld <= skid_axi_dat_vld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_axi_dat_rdy && skid_axi_dat_vld) begin
        pipe_skid_axi_dat_pd[73-1:0] <= skid_axi_dat_pd[73-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_axi_dat_rdy = mcif2noc_axi_w_wready;
assign mcif2noc_axi_w_wvalid = pipe_skid_axi_dat_vld;
assign axi_w_pd = pipe_skid_axi_dat_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p4
