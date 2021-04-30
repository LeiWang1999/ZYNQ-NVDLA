// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_PDP_WDMA_dat.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_PDP_define.h
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//#ifdef NVDLA_FEATURE_DATA_TYPE_INT8
//#if ( NVDLA_PDP_THROUGHPUT  ==  8 )
//    #define LARGE_FIFO_RAM
//#endif
//#if ( NVDLA_PDP_THROUGHPUT == 1 )
//    #define SMALL_FIFO_RAM
//#endif
//#endif
`include "simulate_x_tick.vh"
module NV_NVDLA_PDP_WDMA_dat (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,dp2wdma_pd //|< i
  ,dp2wdma_vld //|< i
  ,op_load //|< i
  ,pwrbus_ram_pd //|< i
  ,reg2dp_cube_out_channel //|< i
  ,reg2dp_cube_out_height //|< i
  ,reg2dp_cube_out_width //|< i
// ,reg2dp_input_data //|< i
  ,reg2dp_partial_width_out_first //|< i
  ,reg2dp_partial_width_out_last //|< i
  ,reg2dp_partial_width_out_mid //|< i
  ,reg2dp_split_num //|< i
  ,wdma_done //|< i
//: my $dmaifBW = 64;
//: my $atomicm = 8*8;
//: my $pdpbw = 1*8;
//: my $Wnum = int( $dmaifBW/$atomicm );
//: my $Bnum = int($atomicm/$pdpbw);
//: foreach my $posw (0..$Wnum-1) { ##High...low atomic_m
//: foreach my $posb (0..$Bnum-1) { ##throughput in each atomic_m
//: print qq(
//: ,dat${posw}_fifo${posb}_rd_pd
//: ,dat${posw}_fifo${posb}_rd_prdy
//: ,dat${posw}_fifo${posb}_rd_pvld
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,dat0_fifo0_rd_pd
,dat0_fifo0_rd_prdy
,dat0_fifo0_rd_pvld

,dat0_fifo1_rd_pd
,dat0_fifo1_rd_prdy
,dat0_fifo1_rd_pvld

,dat0_fifo2_rd_pd
,dat0_fifo2_rd_prdy
,dat0_fifo2_rd_pvld

,dat0_fifo3_rd_pd
,dat0_fifo3_rd_prdy
,dat0_fifo3_rd_pvld

,dat0_fifo4_rd_pd
,dat0_fifo4_rd_prdy
,dat0_fifo4_rd_pvld

,dat0_fifo5_rd_pd
,dat0_fifo5_rd_prdy
,dat0_fifo5_rd_pvld

,dat0_fifo6_rd_pd
,dat0_fifo6_rd_prdy
,dat0_fifo6_rd_pvld

,dat0_fifo7_rd_pd
,dat0_fifo7_rd_prdy
,dat0_fifo7_rd_pvld

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,dp2wdma_rdy //|> o
  );
/////////////////////////////////////////////////////////////////////
//&Catenate "NV_NVDLA_PDP_wdma_ports.v";
input [12:0] reg2dp_cube_out_channel;
input [12:0] reg2dp_cube_out_height;
input [12:0] reg2dp_cube_out_width;
//input [1:0] reg2dp_input_data;
input [9:0] reg2dp_partial_width_out_first;
input [9:0] reg2dp_partial_width_out_last;
input [9:0] reg2dp_partial_width_out_mid;
input [7:0] reg2dp_split_num;
input [1*8 -1:0] dp2wdma_pd;
input dp2wdma_vld;
output dp2wdma_rdy;
//&Ports /^spt/;
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
//: my $dmaifBW = 64;
//: my $atomicm = 8*8;
//: my $pdpbw = 1*8;
//: my $Wnum = int( $dmaifBW/$atomicm );
//: my $Bnum = int($atomicm/$pdpbw);
//: foreach my $posw (0..$Wnum-1) { ##High...low atomic_m
//: foreach my $posb (0..$Bnum-1) { ##throughput in each atomic_m
//: print qq(
//: output [$pdpbw-1:0] dat${posw}_fifo${posb}_rd_pd;
//: input dat${posw}_fifo${posb}_rd_prdy;
//: output dat${posw}_fifo${posb}_rd_pvld;
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [8-1:0] dat0_fifo0_rd_pd;
input dat0_fifo0_rd_prdy;
output dat0_fifo0_rd_pvld;

output [8-1:0] dat0_fifo1_rd_pd;
input dat0_fifo1_rd_prdy;
output dat0_fifo1_rd_pvld;

output [8-1:0] dat0_fifo2_rd_pd;
input dat0_fifo2_rd_prdy;
output dat0_fifo2_rd_pvld;

output [8-1:0] dat0_fifo3_rd_pd;
input dat0_fifo3_rd_prdy;
output dat0_fifo3_rd_pvld;

output [8-1:0] dat0_fifo4_rd_pd;
input dat0_fifo4_rd_prdy;
output dat0_fifo4_rd_pvld;

output [8-1:0] dat0_fifo5_rd_pd;
input dat0_fifo5_rd_prdy;
output dat0_fifo5_rd_pvld;

output [8-1:0] dat0_fifo6_rd_pd;
input dat0_fifo6_rd_prdy;
output dat0_fifo6_rd_pvld;

output [8-1:0] dat0_fifo7_rd_pd;
input dat0_fifo7_rd_prdy;
output dat0_fifo7_rd_pvld;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input wdma_done;
input op_load;
//////////////////////////////////////////////////////////////////
//reg cfg_do_fp16;
//reg cfg_do_int16;
//reg cfg_do_int8;
reg [4:0] count_b;
reg [12:0] count_h;
//: my $atomicm = 8;
//: my $k = int( log($atomicm)/log(2) );
//: print "reg     [12-${k}:0] count_surf;  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg     [12-3:0] count_surf;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [12:0] count_w;
reg [7:0] count_wg;
//reg mon_nan_in_count;
//reg [31:0] nan_in_count;
//reg [31:0] nan_out_num;
//reg [31:0] nan_output_num;
wire cfg_mode_split;
wire dat_fifo_wr_prdy;
wire dat_fifo_wr_pvld;
//wire [3:0] dat_is_nan;
wire [1*8 -1:0] dp2wdma_dat_pd;
//wire [15:0] fp16_in_pd_0;
//wire [15:0] fp16_in_pd_1;
//wire [15:0] fp16_in_pd_2;
//wire [15:0] fp16_in_pd_3;
wire is_blk_end;
wire is_cube_end;
wire is_first_wg;
wire is_fspt;
wire is_last_b;
wire is_last_h;
wire is_last_surf;
wire is_last_w;
wire is_last_wg;
wire is_line_end;
wire is_lspt;
wire is_mspt;
wire is_split_end;
wire is_surf_end;
//wire mon_size_of_surf;
//wire [2:0] nan_num_in_8byte;
//wire [1:0] nan_num_in_8byte_0;
//wire [1:0] nan_num_in_8byte_1;
wire [12:0] size_of_width;
wire [9:0] split_size_of_width;
wire spt_dat_accept;
//wire [1:0] spt_posb;
wire [4:0] spt_posb;
wire [1:0] spt_posw;
//wire wdma_loadin;
////////////////////////////////////////////////////////////////////////
assign cfg_mode_split = (reg2dp_split_num!=0);
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
// if (!nvdla_core_rstn) begin
// cfg_do_int8 <= 1'b0;
// end else begin
// cfg_do_int8 <= reg2dp_input_data== 0;
// end
// end
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
// if (!nvdla_core_rstn) begin
// cfg_do_int16 <= 1'b0;
// end else begin
// cfg_do_int16 <= reg2dp_input_data== 2'h1;
// end
// end
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
// if (!nvdla_core_rstn) begin
// cfg_do_fp16 <= 1'b0;
// end else begin
// cfg_do_fp16 <= reg2dp_input_data== 2'h2;
// end
// end
//
// //==============
// //NaN counter
// //==============
// assign wdma_loadin = spt_dat_accept;//dp2wdma_vld & dp2wdma_rdy;
// assign fp16_in_pd_0 = dp2wdma_pd[15:0];
// assign fp16_in_pd_1 = dp2wdma_pd[31:16];
// assign fp16_in_pd_2 = dp2wdma_pd[47:32];
// assign fp16_in_pd_3 = dp2wdma_pd[63:48];
// assign dat_is_nan[0] = cfg_do_fp16 & (&fp16_in_pd_0[14:10]) & (|fp16_in_pd_0[9:0]);
// assign dat_is_nan[1] = cfg_do_fp16 & (&fp16_in_pd_1[14:10]) & (|fp16_in_pd_1[9:0]);
// assign dat_is_nan[2] = cfg_do_fp16 & (&fp16_in_pd_2[14:10]) & (|fp16_in_pd_2[9:0]);
// assign dat_is_nan[3] = cfg_do_fp16 & (&fp16_in_pd_3[14:10]) & (|fp16_in_pd_3[9:0]);
//
// assign nan_num_in_8byte_0[1:0] = dat_is_nan[0] + dat_is_nan[1];
// assign nan_num_in_8byte_1[1:0] = dat_is_nan[2] + dat_is_nan[3];
// assign nan_num_in_8byte[2:0] = nan_num_in_8byte_0 + nan_num_in_8byte_1;
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
// if (!nvdla_core_rstn) begin
// {mon_nan_in_count,nan_in_count[31:0]} <= {33{1'b0}};
// end else begin
// if(wdma_loadin) begin
// if(is_cube_end)
// {mon_nan_in_count,nan_in_count[31:0]} <= 33'd0;
// else
// {mon_nan_in_count,nan_in_count[31:0]} <= nan_in_count + nan_num_in_8byte;
// end
// end
// end
// `ifdef SPYGLASS_ASSERT_ON
// `else
// // spyglass disable_block NoWidthInBasedNum-ML 
// // spyglass disable_block STARC-2.10.3.2a 
// // spyglass disable_block STARC05-2.1.3.1 
// // spyglass disable_block STARC-2.1.4.6 
// // spyglass disable_block W116 
// // spyglass disable_block W154 
// // spyglass disable_block W239 
// // spyglass disable_block W362 
// // spyglass disable_block WRN_58 
// // spyglass disable_block WRN_61 
// `endif // SPYGLASS_ASSERT_ON
// `ifdef ASSERT_ON
// `ifdef FV_ASSERT_ON
// `define ASSERT_RESET nvdla_core_rstn
// `else
// `ifdef SYNTHESIS
// `define ASSERT_RESET nvdla_core_rstn
// `else
// `ifdef ASSERT_OFF_RESET_IS_X
// `define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
// `else
// `define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
// `endif // ASSERT_OFF_RESET_IS_X
// `endif // SYNTHESIS
// `endif // FV_ASSERT_ON
// // VCS coverage off 
// nv_assert_never #(0,0,"PDP WDMA: no overflow is allowed") zzz_assert_never_1x (nvdla_core_clk, `ASSERT_RESET, mon_nan_in_count); // spyglass disable W504 SelfDeterminedExpr-ML 
// // VCS coverage on
// `undef ASSERT_RESET
// `endif // ASSERT_ON
// `ifdef SPYGLASS_ASSERT_ON
// `else
// // spyglass enable_block NoWidthInBasedNum-ML 
// // spyglass enable_block STARC-2.10.3.2a 
// // spyglass enable_block STARC05-2.1.3.1 
// // spyglass enable_block STARC-2.1.4.6 
// // spyglass enable_block W116 
// // spyglass enable_block W154 
// // spyglass enable_block W239 
// // spyglass enable_block W362 
// // spyglass enable_block WRN_58 
// // spyglass enable_block WRN_61 
// `endif // SPYGLASS_ASSERT_ON
//
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
// if (!nvdla_core_rstn) begin
// nan_out_num <= {32{1'b0}};
// end else begin
// if(is_cube_end)
// nan_out_num <= nan_in_count;
// end
// end
// //assign wdma_done = dp2reg_done;
// always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
// if (!nvdla_core_rstn) begin
// nan_output_num <= {32{1'b0}};
// end else begin
// if(wdma_done) begin
// nan_output_num <= nan_out_num;
// end
// end
// end
//
//==============
// CUBE DRAW
//==============
assign is_blk_end = is_last_b;
assign is_line_end = is_blk_end & is_last_w;
assign is_surf_end = is_line_end & is_last_h;
assign is_split_end = is_surf_end & is_last_surf;
assign is_cube_end = is_split_end & is_last_wg;
// WIDTH COUNT: in width direction, indidate one block
assign split_size_of_width = is_fspt ? reg2dp_partial_width_out_first :
                             is_lspt ? reg2dp_partial_width_out_last :
                             is_mspt ? reg2dp_partial_width_out_mid : {10{`x_or_0}};
assign size_of_width = cfg_mode_split ? {3'd0,split_size_of_width} : reg2dp_cube_out_width;
// WG: WidthGroup, including one FSPT, one LSPT, and many MSPT
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_wg <= {8{1'b0}};
  end else begin
    if (op_load) begin
        count_wg <= 0;
    end else if (spt_dat_accept) begin
        if (is_cube_end) begin
            count_wg <= 0;
        end else if (is_split_end) begin
            count_wg <= count_wg + 1;
        end
    end
  end
end
assign is_last_wg = (count_wg==reg2dp_split_num);
assign is_first_wg = (count_wg==0);
assign is_fspt = cfg_mode_split & is_first_wg;
assign is_lspt = cfg_mode_split & is_last_wg;
assign is_mspt = cfg_mode_split & !is_fspt & !is_lspt;
//================================================================
// C direction: count_b + count_surf
// count_b: in each W in line, will go 4 step in c first
// count_surf: when one surf with 4c is done, will go to next surf
//================================================================
//==============
// COUNT B
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_b <= {5{1'b0}};
  end else begin
    if (spt_dat_accept) begin
        if (is_blk_end) begin
            count_b <= 0;
        end else begin
            count_b <= count_b + 1;
        end
    end
  end
end
//: my $atomicm = 8;
//: my $pdpth = 1;
//: my $k = int( $atomicm/$pdpth );
//: print "assign is_last_b = (count_b==5'd${k} -1 ); \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign is_last_b = (count_b==5'd8 -1 ); 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//==============
// COUNT W
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_w <= {13{1'b0}};
  end else begin
    if (spt_dat_accept) begin
        if (is_line_end) begin
            count_w <= 0;
        end else if (is_blk_end) begin
            count_w <= count_w + 1;
        end
    end
  end
end
assign is_last_w = (count_w==size_of_width);
//==============
// COUNT SURF
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_surf <= 0;
  end else begin
    if (spt_dat_accept) begin
        if (is_split_end) begin
            count_surf <= 0;
        end else if (is_surf_end) begin
            count_surf <= count_surf + 1;
        end
    end
  end
end
//: my $atomicm = 8;
//: my $k = int( log($atomicm)/log(2) );
//: print qq(
//: assign is_last_surf = (count_surf== reg2dp_cube_out_channel[12:${k}]);
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign is_last_surf = (count_surf== reg2dp_cube_out_channel[12:3]);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//==============
// COUNT HEIGHT
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_h <= {13{1'b0}};
  end else begin
    if (spt_dat_accept) begin
        if (is_surf_end) begin
            count_h <= 0;
        end else if (is_line_end) begin
            count_h <= count_h + 1;
        end
    end
  end
end
assign is_last_h = (count_h==reg2dp_cube_out_height);
//==============
// spt information gen
//==============
assign spt_posb = count_b;
//: my $Wnum = 64/8/8;
//: if($Wnum == 1) {
//: print qq(
//: assign spt_posw = 2'b0;
//: );
//: } else {
//: my $k = int( log($Wnum)/log(2) );
//: print qq(
//: assign spt_posw = {{(2-$k){1'b0}},count_w[$k-1:0]};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign spt_posw = 2'b0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//==============
// Data FIFO WRITE contrl
//==============
assign dp2wdma_dat_pd = dp2wdma_pd;
assign dat_fifo_wr_pvld = dp2wdma_vld;
assign dp2wdma_rdy = dat_fifo_wr_prdy;
//: my @dat_wr_rdys;
//: my @dat_wr_accepts;
//: my $dmaifBW = 64;
//: my $atomicm = 8*8;
//: my $pdpbw = 1*8;
//: my $Wnum = int( $dmaifBW/$atomicm );
//: my $Bnum = int($atomicm/$pdpbw);
//: foreach my $posw (0..$Wnum-1) { ##High...low atomic_m
//: foreach my $posb (0..$Bnum-1) { ##throughput in each atomic_m
//: print qq(
//: wire [$pdpbw-1:0] dat${posw}_fifo${posb}_wr_pd;
//: wire dat${posw}_fifo${posb}_wr_prdy;
//: wire dat${posw}_fifo${posb}_wr_pvld;
//: // DATA FIFO WRITE SIDE
//: // is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
//: assign dat${posw}_fifo${posb}_wr_pvld = dat_fifo_wr_pvld & (spt_posw==$posw) & (spt_posb == $posb);
//: assign dat${posw}_fifo${posb}_wr_pd = dp2wdma_dat_pd;
//:
//: // DATA FIFO INSTANCE
//: NV_NVDLA_PDP_WDMA_DAT_fifo_32x${pdpbw} u_dat${posw}_fifo${posb} (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.dat_fifo_wr_prdy (dat${posw}_fifo${posb}_wr_prdy)
//: ,.dat_fifo_wr_pvld (dat${posw}_fifo${posb}_wr_pvld)
//: ,.dat_fifo_wr_pd (dat${posw}_fifo${posb}_wr_pd)
//: ,.dat_fifo_rd_prdy (dat${posw}_fifo${posb}_rd_prdy)
//: ,.dat_fifo_rd_pvld (dat${posw}_fifo${posb}_rd_pvld)
//: ,.dat_fifo_rd_pd (dat${posw}_fifo${posb}_rd_pd)
//: ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
//: );
//: );
//:
//: push @dat_wr_rdys, "( dat${posw}_fifo${posb}_wr_prdy & (spt_posw==$posw) & (spt_posb == $posb) )";
//:
//: print qq {
//: // ::assert never "when the first fifo is ready, all the left fifo should be ready" dat${posw}_fifo0_wr_prdy & !dat${posw}_fifo${posb}_wr_prdy;
//: // ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat${posw}_fifo${posb}_wr_prdy & !dat${posw}_fifo3_wr_prdy;
//: };
//: }
//: }
//:
//: # dat_wr_rdys to make sure the dat fifo which is to sink data is not full
//: my $dat_wr_rdys_str = join(" \n| ",@dat_wr_rdys);
//: print "assign dat_fifo_wr_prdy = $dat_wr_rdys_str;";
//:
//: my $dat_wr_accepts_str = join(" \n| ",@dat_wr_accepts);
//: print "assign spt_dat_accept = dat_fifo_wr_pvld & dat_fifo_wr_prdy;";
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [8-1:0] dat0_fifo0_wr_pd;
wire dat0_fifo0_wr_prdy;
wire dat0_fifo0_wr_pvld;
// DATA FIFO WRITE SIDE
// is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
assign dat0_fifo0_wr_pvld = dat_fifo_wr_pvld & (spt_posw==0) & (spt_posb == 0);
assign dat0_fifo0_wr_pd = dp2wdma_dat_pd;

// DATA FIFO INSTANCE
NV_NVDLA_PDP_WDMA_DAT_fifo_32x8 u_dat0_fifo0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dat_fifo_wr_prdy (dat0_fifo0_wr_prdy)
,.dat_fifo_wr_pvld (dat0_fifo0_wr_pvld)
,.dat_fifo_wr_pd (dat0_fifo0_wr_pd)
,.dat_fifo_rd_prdy (dat0_fifo0_rd_prdy)
,.dat_fifo_rd_pvld (dat0_fifo0_rd_pvld)
,.dat_fifo_rd_pd (dat0_fifo0_rd_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);

// ::assert never "when the first fifo is ready, all the left fifo should be ready" dat0_fifo0_wr_prdy & !dat0_fifo0_wr_prdy;
// ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat0_fifo0_wr_prdy & !dat0_fifo3_wr_prdy;

wire [8-1:0] dat0_fifo1_wr_pd;
wire dat0_fifo1_wr_prdy;
wire dat0_fifo1_wr_pvld;
// DATA FIFO WRITE SIDE
// is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
assign dat0_fifo1_wr_pvld = dat_fifo_wr_pvld & (spt_posw==0) & (spt_posb == 1);
assign dat0_fifo1_wr_pd = dp2wdma_dat_pd;

// DATA FIFO INSTANCE
NV_NVDLA_PDP_WDMA_DAT_fifo_32x8 u_dat0_fifo1 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dat_fifo_wr_prdy (dat0_fifo1_wr_prdy)
,.dat_fifo_wr_pvld (dat0_fifo1_wr_pvld)
,.dat_fifo_wr_pd (dat0_fifo1_wr_pd)
,.dat_fifo_rd_prdy (dat0_fifo1_rd_prdy)
,.dat_fifo_rd_pvld (dat0_fifo1_rd_pvld)
,.dat_fifo_rd_pd (dat0_fifo1_rd_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);

// ::assert never "when the first fifo is ready, all the left fifo should be ready" dat0_fifo0_wr_prdy & !dat0_fifo1_wr_prdy;
// ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat0_fifo1_wr_prdy & !dat0_fifo3_wr_prdy;

wire [8-1:0] dat0_fifo2_wr_pd;
wire dat0_fifo2_wr_prdy;
wire dat0_fifo2_wr_pvld;
// DATA FIFO WRITE SIDE
// is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
assign dat0_fifo2_wr_pvld = dat_fifo_wr_pvld & (spt_posw==0) & (spt_posb == 2);
assign dat0_fifo2_wr_pd = dp2wdma_dat_pd;

// DATA FIFO INSTANCE
NV_NVDLA_PDP_WDMA_DAT_fifo_32x8 u_dat0_fifo2 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dat_fifo_wr_prdy (dat0_fifo2_wr_prdy)
,.dat_fifo_wr_pvld (dat0_fifo2_wr_pvld)
,.dat_fifo_wr_pd (dat0_fifo2_wr_pd)
,.dat_fifo_rd_prdy (dat0_fifo2_rd_prdy)
,.dat_fifo_rd_pvld (dat0_fifo2_rd_pvld)
,.dat_fifo_rd_pd (dat0_fifo2_rd_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);

// ::assert never "when the first fifo is ready, all the left fifo should be ready" dat0_fifo0_wr_prdy & !dat0_fifo2_wr_prdy;
// ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat0_fifo2_wr_prdy & !dat0_fifo3_wr_prdy;

wire [8-1:0] dat0_fifo3_wr_pd;
wire dat0_fifo3_wr_prdy;
wire dat0_fifo3_wr_pvld;
// DATA FIFO WRITE SIDE
// is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
assign dat0_fifo3_wr_pvld = dat_fifo_wr_pvld & (spt_posw==0) & (spt_posb == 3);
assign dat0_fifo3_wr_pd = dp2wdma_dat_pd;

// DATA FIFO INSTANCE
NV_NVDLA_PDP_WDMA_DAT_fifo_32x8 u_dat0_fifo3 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dat_fifo_wr_prdy (dat0_fifo3_wr_prdy)
,.dat_fifo_wr_pvld (dat0_fifo3_wr_pvld)
,.dat_fifo_wr_pd (dat0_fifo3_wr_pd)
,.dat_fifo_rd_prdy (dat0_fifo3_rd_prdy)
,.dat_fifo_rd_pvld (dat0_fifo3_rd_pvld)
,.dat_fifo_rd_pd (dat0_fifo3_rd_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);

// ::assert never "when the first fifo is ready, all the left fifo should be ready" dat0_fifo0_wr_prdy & !dat0_fifo3_wr_prdy;
// ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat0_fifo3_wr_prdy & !dat0_fifo3_wr_prdy;

wire [8-1:0] dat0_fifo4_wr_pd;
wire dat0_fifo4_wr_prdy;
wire dat0_fifo4_wr_pvld;
// DATA FIFO WRITE SIDE
// is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
assign dat0_fifo4_wr_pvld = dat_fifo_wr_pvld & (spt_posw==0) & (spt_posb == 4);
assign dat0_fifo4_wr_pd = dp2wdma_dat_pd;

// DATA FIFO INSTANCE
NV_NVDLA_PDP_WDMA_DAT_fifo_32x8 u_dat0_fifo4 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dat_fifo_wr_prdy (dat0_fifo4_wr_prdy)
,.dat_fifo_wr_pvld (dat0_fifo4_wr_pvld)
,.dat_fifo_wr_pd (dat0_fifo4_wr_pd)
,.dat_fifo_rd_prdy (dat0_fifo4_rd_prdy)
,.dat_fifo_rd_pvld (dat0_fifo4_rd_pvld)
,.dat_fifo_rd_pd (dat0_fifo4_rd_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);

// ::assert never "when the first fifo is ready, all the left fifo should be ready" dat0_fifo0_wr_prdy & !dat0_fifo4_wr_prdy;
// ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat0_fifo4_wr_prdy & !dat0_fifo3_wr_prdy;

wire [8-1:0] dat0_fifo5_wr_pd;
wire dat0_fifo5_wr_prdy;
wire dat0_fifo5_wr_pvld;
// DATA FIFO WRITE SIDE
// is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
assign dat0_fifo5_wr_pvld = dat_fifo_wr_pvld & (spt_posw==0) & (spt_posb == 5);
assign dat0_fifo5_wr_pd = dp2wdma_dat_pd;

// DATA FIFO INSTANCE
NV_NVDLA_PDP_WDMA_DAT_fifo_32x8 u_dat0_fifo5 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dat_fifo_wr_prdy (dat0_fifo5_wr_prdy)
,.dat_fifo_wr_pvld (dat0_fifo5_wr_pvld)
,.dat_fifo_wr_pd (dat0_fifo5_wr_pd)
,.dat_fifo_rd_prdy (dat0_fifo5_rd_prdy)
,.dat_fifo_rd_pvld (dat0_fifo5_rd_pvld)
,.dat_fifo_rd_pd (dat0_fifo5_rd_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);

// ::assert never "when the first fifo is ready, all the left fifo should be ready" dat0_fifo0_wr_prdy & !dat0_fifo5_wr_prdy;
// ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat0_fifo5_wr_prdy & !dat0_fifo3_wr_prdy;

wire [8-1:0] dat0_fifo6_wr_pd;
wire dat0_fifo6_wr_prdy;
wire dat0_fifo6_wr_pvld;
// DATA FIFO WRITE SIDE
// is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
assign dat0_fifo6_wr_pvld = dat_fifo_wr_pvld & (spt_posw==0) & (spt_posb == 6);
assign dat0_fifo6_wr_pd = dp2wdma_dat_pd;

// DATA FIFO INSTANCE
NV_NVDLA_PDP_WDMA_DAT_fifo_32x8 u_dat0_fifo6 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dat_fifo_wr_prdy (dat0_fifo6_wr_prdy)
,.dat_fifo_wr_pvld (dat0_fifo6_wr_pvld)
,.dat_fifo_wr_pd (dat0_fifo6_wr_pd)
,.dat_fifo_rd_prdy (dat0_fifo6_rd_prdy)
,.dat_fifo_rd_pvld (dat0_fifo6_rd_pvld)
,.dat_fifo_rd_pd (dat0_fifo6_rd_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);

// ::assert never "when the first fifo is ready, all the left fifo should be ready" dat0_fifo0_wr_prdy & !dat0_fifo6_wr_prdy;
// ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat0_fifo6_wr_prdy & !dat0_fifo3_wr_prdy;

wire [8-1:0] dat0_fifo7_wr_pd;
wire dat0_fifo7_wr_prdy;
wire dat0_fifo7_wr_pvld;
// DATA FIFO WRITE SIDE
// is last_b, then fifo idx large than count_b will need a push to fill in fake data to make up a full atomic_m
assign dat0_fifo7_wr_pvld = dat_fifo_wr_pvld & (spt_posw==0) & (spt_posb == 7);
assign dat0_fifo7_wr_pd = dp2wdma_dat_pd;

// DATA FIFO INSTANCE
NV_NVDLA_PDP_WDMA_DAT_fifo_32x8 u_dat0_fifo7 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dat_fifo_wr_prdy (dat0_fifo7_wr_prdy)
,.dat_fifo_wr_pvld (dat0_fifo7_wr_pvld)
,.dat_fifo_wr_pd (dat0_fifo7_wr_pd)
,.dat_fifo_rd_prdy (dat0_fifo7_rd_prdy)
,.dat_fifo_rd_pvld (dat0_fifo7_rd_pvld)
,.dat_fifo_rd_pd (dat0_fifo7_rd_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);

// ::assert never "when the first fifo is ready, all the left fifo should be ready" dat0_fifo0_wr_prdy & !dat0_fifo7_wr_prdy;
// ::assert never "when the last fifo is not ready, all the previous fifo should not be ready" dat0_fifo7_wr_prdy & !dat0_fifo3_wr_prdy;
assign dat_fifo_wr_prdy = ( dat0_fifo0_wr_prdy & (spt_posw==0) & (spt_posb == 0) ) 
| ( dat0_fifo1_wr_prdy & (spt_posw==0) & (spt_posb == 1) ) 
| ( dat0_fifo2_wr_prdy & (spt_posw==0) & (spt_posb == 2) ) 
| ( dat0_fifo3_wr_prdy & (spt_posw==0) & (spt_posb == 3) ) 
| ( dat0_fifo4_wr_prdy & (spt_posw==0) & (spt_posb == 4) ) 
| ( dat0_fifo5_wr_prdy & (spt_posw==0) & (spt_posb == 5) ) 
| ( dat0_fifo6_wr_prdy & (spt_posw==0) & (spt_posb == 6) ) 
| ( dat0_fifo7_wr_prdy & (spt_posw==0) & (spt_posb == 7) );assign spt_dat_accept = dat_fifo_wr_pvld & dat_fifo_wr_prdy;
//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_PDP_WDMA_dat
// -w 64, 8byte each fifo
// -d 3, depth=4 as we have rd_reg
//
// AUTOMATICALLY GENERATED -- DO NOT EDIT OR CHECK IN
//
// /home/nvtools/engr/2017/03/11_05_00_06/nvtools/scripts/fifogen
// fifogen -input_config_yaml ../../../../../../../socd/ip_chip_tools/1.0/defs/public/fifogen/golden/tlit5/fifogen.yml -no_make_ram -no_make_ram -stdout -m NV_NVDLA_PDP_WDMA_DAT_fifo -clk_name nvdla_core_clk -reset_name nvdla_core_rstn -wr_pipebus dat_fifo_wr -rd_pipebus dat_fifo_rd -rand_none -rd_reg -ram_bypass -d 3 -w 64 -ram ff [Chosen ram type: ff - fifogen_flops (user specified, thus no other ram type is allowed)]
// chip config vars: assertion_module_prefix=nv_ strict_synchronizers=1 strict_synchronizers_use_lib_cells=1 strict_synchronizers_use_tm_lib_cells=1 strict_sync_randomizer=1 assertion_message_prefix=FIFOGEN_ASSERTION allow_async_fifola=0 ignore_ramgen_fifola_variant=1 uses_p_SSYNC=0 uses_prand=1 uses_rammake_inc=1 use_x_or_0=1 force_wr_reg_gated=1 no_force_reset=1 no_timescale=1 no_pli_ifdef=1 requires_full_throughput=1 ram_auto_ff_bits_cutoff=16 ram_auto_ff_width_cutoff=2 ram_auto_ff_width_cutoff_max_depth=32 ram_auto_ff_depth_cutoff=-1 ram_auto_ff_no_la2_depth_cutoff=5 ram_auto_la2_width_cutoff=8 ram_auto_la2_width_cutoff_max_depth=56 ram_auto_la2_depth_cutoff=16 flopram_emu_model=1 dslp_single_clamp_port=1 dslp_clamp_port=1 slp_single_clamp_port=1 slp_clamp_port=1 master_clk_gated=1 clk_gate_module=NV_CLK_gate_power redundant_timing_flops=0 hot_reset_async_force_ports_and_loopback=1 ram_sleep_en_width=1 async_cdc_reg_id=NV_AFIFO_ rd_reg_default_for_async=1 async_ram_instance_prefix=NV_ASYNC_RAM_ allow_rd_busy_reg_warning=0 do_dft_xelim_gating=1 add_dft_xelim_wr_clkgate=1 add_dft_xelim_rd_clkgate=1
//
// leda B_3208_NV OFF -- Unequal length LHS and RHS in assignment
// leda B_1405 OFF -- 2 asynchronous resets in this unit detected
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
