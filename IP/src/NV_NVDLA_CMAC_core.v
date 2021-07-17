// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC_core.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC.h
`define DESIGNWARE_NOEXIST 1
module NV_NVDLA_CMAC_core (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,dla_clk_ovr_on_sync //|< i
  ,global_clk_ovr_on_sync //|< i
  ,reg2dp_conv_mode //|< i
  ,reg2dp_op_en //|< i
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: ,sc2mac_dat_data${i} //|< i)
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,sc2mac_dat_data0 //|< i
,sc2mac_dat_data1 //|< i
,sc2mac_dat_data2 //|< i
,sc2mac_dat_data3 //|< i
,sc2mac_dat_data4 //|< i
,sc2mac_dat_data5 //|< i
,sc2mac_dat_data6 //|< i
,sc2mac_dat_data7 //|< i
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_dat_mask //|< i
  ,sc2mac_dat_pd //|< i
  ,sc2mac_dat_pvld //|< i
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: ,sc2mac_wt_data${i} //|< i)
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,sc2mac_wt_data0 //|< i
,sc2mac_wt_data1 //|< i
,sc2mac_wt_data2 //|< i
,sc2mac_wt_data3 //|< i
,sc2mac_wt_data4 //|< i
,sc2mac_wt_data5 //|< i
,sc2mac_wt_data6 //|< i
,sc2mac_wt_data7 //|< i
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_wt_mask //|< i
  ,sc2mac_wt_pvld //|< i
  ,sc2mac_wt_sel //|< i
  ,slcg_op_en //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,dp2reg_done //|> o
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: ,mac2accu_data${i} //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,mac2accu_data0 //|< i 
,mac2accu_data1 //|< i 
,mac2accu_data2 //|< i 
,mac2accu_data3 //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,mac2accu_mask //|> o
  ,mac2accu_mode //|> o
  ,mac2accu_pd //|> o
  ,mac2accu_pvld //|> o
  );
//
// NV_NVDLA_CMAC_core_ports.v
//
input nvdla_core_clk;
input nvdla_core_rstn;
input sc2mac_dat_pvld; /* data valid */
input [8 -1:0] sc2mac_dat_mask;
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: input [8 -1:0] sc2mac_dat_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [8 -1:0] sc2mac_dat_data0; 
input [8 -1:0] sc2mac_dat_data1; 
input [8 -1:0] sc2mac_dat_data2; 
input [8 -1:0] sc2mac_dat_data3; 
input [8 -1:0] sc2mac_dat_data4; 
input [8 -1:0] sc2mac_dat_data5; 
input [8 -1:0] sc2mac_dat_data6; 
input [8 -1:0] sc2mac_dat_data7; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8:0] sc2mac_dat_pd;
input sc2mac_wt_pvld; /* data valid */
input [8 -1:0] sc2mac_wt_mask;
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: input [8 -1:0] sc2mac_wt_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [8 -1:0] sc2mac_wt_data0; 
input [8 -1:0] sc2mac_wt_data1; 
input [8 -1:0] sc2mac_wt_data2; 
input [8 -1:0] sc2mac_wt_data3; 
input [8 -1:0] sc2mac_wt_data4; 
input [8 -1:0] sc2mac_wt_data5; 
input [8 -1:0] sc2mac_wt_data6; 
input [8 -1:0] sc2mac_wt_data7; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8/2 -1:0] sc2mac_wt_sel;
output mac2accu_pvld; /* data valid */
output [8/2 -1:0] mac2accu_mask;
output mac2accu_mode;
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: output [19 -1:0] mac2accu_data${i}; //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [19 -1:0] mac2accu_data0; //|< i 
output [19 -1:0] mac2accu_data1; //|< i 
output [19 -1:0] mac2accu_data2; //|< i 
output [19 -1:0] mac2accu_data3; //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
output [8:0] mac2accu_pd;
input [0:0] reg2dp_op_en;
input [0:0] reg2dp_conv_mode;
output dp2reg_done;
//Port for SLCG
input dla_clk_ovr_on_sync;
input global_clk_ovr_on_sync;
input tmc2slcg_disable_clock_gating;
input [3+8/2 -1:0] slcg_op_en;
wire cfg_is_wg;
wire cfg_reg_en;
// interface with register config
//==========================================================
//: my $i=8/2;
//: print qq(
//: wire nvdla_op_gated_clk_${i}; );
//: print qq(
//: NV_NVDLA_CMAC_CORE_cfg u_cfg (
//: .nvdla_core_clk (nvdla_op_gated_clk_${i}) //|< w
//: ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//: ,.dp2reg_done (dp2reg_done) //|< o
//: ,.reg2dp_conv_mode (reg2dp_conv_mode) //|< i
//: ,.reg2dp_op_en (reg2dp_op_en) //|< i
//: ,.cfg_is_wg (cfg_is_wg) //|> w
//: ,.cfg_reg_en (cfg_reg_en) //|> w
//: );
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire nvdla_op_gated_clk_4; 
NV_NVDLA_CMAC_CORE_cfg u_cfg (
.nvdla_core_clk (nvdla_op_gated_clk_4) //|< w
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.dp2reg_done (dp2reg_done) //|< o
,.reg2dp_conv_mode (reg2dp_conv_mode) //|< i
,.reg2dp_op_en (reg2dp_op_en) //|< i
,.cfg_is_wg (cfg_is_wg) //|> w
,.cfg_reg_en (cfg_reg_en) //|> w
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire in_dat_pvld;
assign mac2accu_mode = 1'b0;
wire [8:0] in_dat_pd;
wire [8 -1:0] in_wt_mask;
wire in_wt_pvld;
wire [8/2 -1:0] in_wt_sel;
wire [8 -1:0] in_dat_mask;
wire in_dat_stripe_end;
wire in_dat_stripe_st;
wire [8/2 -1:0] out_mask;
//: for (my $i=0; $i < 8; ++$i) {
//: print qq(
//: wire [8 -1:0] in_dat_data${i};
//: wire [8 -1:0] in_wt_data${i}; );
//: }
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: wire [8*8 -1:0] dat${i}_actv_data;
//: wire [8 -1:0] dat${i}_actv_nz;
//: wire [8 -1:0] dat${i}_actv_pvld;
//: wire [8 -1:0] dat${i}_pre_mask;
//: wire dat${i}_pre_pvld;
//: wire dat${i}_pre_stripe_end;
//: wire dat${i}_pre_stripe_st;
//: wire [8*8 -1:0] wt${i}_actv_data;
//: wire [8 -1:0] wt${i}_actv_nz;
//: wire [8 -1:0] wt${i}_actv_pvld;
//: wire [8 -1:0] wt${i}_sd_mask;
//: wire wt${i}_sd_pvld;
//: );
//: }
//: my $i=(3 +2 -3);
//: &eperl::retime("-stage ${i} -wid 9 -i in_dat_pd -o out_pd -cg_en_i in_dat_pvld -cg_en_o out_pvld -cg_en_rtm");
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [8 -1:0] in_dat_data0;
wire [8 -1:0] in_wt_data0; 
wire [8 -1:0] in_dat_data1;
wire [8 -1:0] in_wt_data1; 
wire [8 -1:0] in_dat_data2;
wire [8 -1:0] in_wt_data2; 
wire [8 -1:0] in_dat_data3;
wire [8 -1:0] in_wt_data3; 
wire [8 -1:0] in_dat_data4;
wire [8 -1:0] in_wt_data4; 
wire [8 -1:0] in_dat_data5;
wire [8 -1:0] in_wt_data5; 
wire [8 -1:0] in_dat_data6;
wire [8 -1:0] in_wt_data6; 
wire [8 -1:0] in_dat_data7;
wire [8 -1:0] in_wt_data7; 
wire [8*8 -1:0] dat0_actv_data;
wire [8 -1:0] dat0_actv_nz;
wire [8 -1:0] dat0_actv_pvld;
wire [8 -1:0] dat0_pre_mask;
wire dat0_pre_pvld;
wire dat0_pre_stripe_end;
wire dat0_pre_stripe_st;
wire [8*8 -1:0] wt0_actv_data;
wire [8 -1:0] wt0_actv_nz;
wire [8 -1:0] wt0_actv_pvld;
wire [8 -1:0] wt0_sd_mask;
wire wt0_sd_pvld;

wire [8*8 -1:0] dat1_actv_data;
wire [8 -1:0] dat1_actv_nz;
wire [8 -1:0] dat1_actv_pvld;
wire [8 -1:0] dat1_pre_mask;
wire dat1_pre_pvld;
wire dat1_pre_stripe_end;
wire dat1_pre_stripe_st;
wire [8*8 -1:0] wt1_actv_data;
wire [8 -1:0] wt1_actv_nz;
wire [8 -1:0] wt1_actv_pvld;
wire [8 -1:0] wt1_sd_mask;
wire wt1_sd_pvld;

wire [8*8 -1:0] dat2_actv_data;
wire [8 -1:0] dat2_actv_nz;
wire [8 -1:0] dat2_actv_pvld;
wire [8 -1:0] dat2_pre_mask;
wire dat2_pre_pvld;
wire dat2_pre_stripe_end;
wire dat2_pre_stripe_st;
wire [8*8 -1:0] wt2_actv_data;
wire [8 -1:0] wt2_actv_nz;
wire [8 -1:0] wt2_actv_pvld;
wire [8 -1:0] wt2_sd_mask;
wire wt2_sd_pvld;

wire [8*8 -1:0] dat3_actv_data;
wire [8 -1:0] dat3_actv_nz;
wire [8 -1:0] dat3_actv_pvld;
wire [8 -1:0] dat3_pre_mask;
wire dat3_pre_pvld;
wire dat3_pre_stripe_end;
wire dat3_pre_stripe_st;
wire [8*8 -1:0] wt3_actv_data;
wire [8 -1:0] wt3_actv_nz;
wire [8 -1:0] wt3_actv_pvld;
wire [8 -1:0] wt3_sd_mask;
wire wt3_sd_pvld;
reg [9-1:0] in_dat_pd_d1;
always @(posedge nvdla_core_clk) begin
    if ((in_dat_pvld)) begin
        in_dat_pd_d1[9-1:0] <= in_dat_pd[9-1:0];
    end
end

reg in_dat_pvld_d1;
always @(posedge nvdla_core_clk) begin
    in_dat_pvld_d1 <= in_dat_pvld;
end

reg [9-1:0] in_dat_pd_d2;
always @(posedge nvdla_core_clk) begin
    if ((in_dat_pvld_d1)) begin
        in_dat_pd_d2[9-1:0] <= in_dat_pd_d1[9-1:0];
    end
end

reg in_dat_pvld_d2;
always @(posedge nvdla_core_clk) begin
    in_dat_pvld_d2 <= in_dat_pvld_d1;
end

wire [9-1:0] out_pd;
assign out_pd = in_dat_pd_d2;

wire out_pvld;
assign out_pvld = in_dat_pvld_d2;


//| eperl: generated_end (DO NOT EDIT ABOVE)
//==========================================================
// input retiming logic
//==========================================================
 NV_NVDLA_CMAC_CORE_rt_in u_rt_in (
//: my $i= 8/2;
//: print qq(
//: .nvdla_core_clk (nvdla_op_gated_clk_${i}) //|< w  );
//| eperl: generated_beg (DO NOT EDIT BELOW)

.nvdla_core_clk (nvdla_op_gated_clk_4) //|< w  
//| eperl: generated_end (DO NOT EDIT ABOVE)
 ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_dat_data${i} (sc2mac_dat_data${i}) //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_data0 (sc2mac_dat_data0) //|< i 
,.sc2mac_dat_data1 (sc2mac_dat_data1) //|< i 
,.sc2mac_dat_data2 (sc2mac_dat_data2) //|< i 
,.sc2mac_dat_data3 (sc2mac_dat_data3) //|< i 
,.sc2mac_dat_data4 (sc2mac_dat_data4) //|< i 
,.sc2mac_dat_data5 (sc2mac_dat_data5) //|< i 
,.sc2mac_dat_data6 (sc2mac_dat_data6) //|< i 
,.sc2mac_dat_data7 (sc2mac_dat_data7) //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_mask (sc2mac_dat_mask) //|< i
  ,.sc2mac_dat_pd (sc2mac_dat_pd) //|< i
  ,.sc2mac_dat_pvld (sc2mac_dat_pvld) //|< i
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_wt_data${i} (sc2mac_wt_data${i}) //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_wt_data0 (sc2mac_wt_data0) //|< i 
,.sc2mac_wt_data1 (sc2mac_wt_data1) //|< i 
,.sc2mac_wt_data2 (sc2mac_wt_data2) //|< i 
,.sc2mac_wt_data3 (sc2mac_wt_data3) //|< i 
,.sc2mac_wt_data4 (sc2mac_wt_data4) //|< i 
,.sc2mac_wt_data5 (sc2mac_wt_data5) //|< i 
,.sc2mac_wt_data6 (sc2mac_wt_data6) //|< i 
,.sc2mac_wt_data7 (sc2mac_wt_data7) //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_wt_mask (sc2mac_wt_mask) //|< i
  ,.sc2mac_wt_pvld (sc2mac_wt_pvld) //|< i
  ,.sc2mac_wt_sel (sc2mac_wt_sel) //|< i
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.in_dat_data${i} (in_dat_data${i}) //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.in_dat_data0 (in_dat_data0) //|< i 
,.in_dat_data1 (in_dat_data1) //|< i 
,.in_dat_data2 (in_dat_data2) //|< i 
,.in_dat_data3 (in_dat_data3) //|< i 
,.in_dat_data4 (in_dat_data4) //|< i 
,.in_dat_data5 (in_dat_data5) //|< i 
,.in_dat_data6 (in_dat_data6) //|< i 
,.in_dat_data7 (in_dat_data7) //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.in_dat_mask (in_dat_mask) //|> w
  ,.in_dat_pd (in_dat_pd) //|> w
  ,.in_dat_pvld (in_dat_pvld) //|> w
  ,.in_dat_stripe_end (in_dat_stripe_end) //|> w
  ,.in_dat_stripe_st (in_dat_stripe_st) //|> w
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.in_wt_data${i} (in_wt_data${i}) //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.in_wt_data0 (in_wt_data0) //|< i 
,.in_wt_data1 (in_wt_data1) //|< i 
,.in_wt_data2 (in_wt_data2) //|< i 
,.in_wt_data3 (in_wt_data3) //|< i 
,.in_wt_data4 (in_wt_data4) //|< i 
,.in_wt_data5 (in_wt_data5) //|< i 
,.in_wt_data6 (in_wt_data6) //|< i 
,.in_wt_data7 (in_wt_data7) //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.in_wt_mask (in_wt_mask) //|> w
  ,.in_wt_pvld (in_wt_pvld) //|> w
  ,.in_wt_sel (in_wt_sel) //|> w
  );
//==========================================================
// input shadow and active pipeline
//==========================================================
//: my $i = 8/2 +1;
//: print qq(
//: wire nvdla_op_gated_clk_${i}; );
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire nvdla_op_gated_clk_5; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
NV_NVDLA_CMAC_CORE_active u_active (
//: my $i=8/2 +1;
//: print qq(
//: .nvdla_core_clk (nvdla_op_gated_clk_${i}) //|< w );
//| eperl: generated_beg (DO NOT EDIT BELOW)

.nvdla_core_clk (nvdla_op_gated_clk_5) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
 ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.in_dat_data${i} (in_dat_data${i}) //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.in_dat_data0 (in_dat_data0) //|< i 
,.in_dat_data1 (in_dat_data1) //|< i 
,.in_dat_data2 (in_dat_data2) //|< i 
,.in_dat_data3 (in_dat_data3) //|< i 
,.in_dat_data4 (in_dat_data4) //|< i 
,.in_dat_data5 (in_dat_data5) //|< i 
,.in_dat_data6 (in_dat_data6) //|< i 
,.in_dat_data7 (in_dat_data7) //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
 ,.in_dat_mask (in_dat_mask) //|< w
 ,.in_dat_pvld (in_dat_pvld) //|< w
 ,.in_dat_stripe_end (in_dat_stripe_end) //|< w
 ,.in_dat_stripe_st (in_dat_stripe_st) //|< w
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.in_wt_data${i} (in_wt_data${i}) //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.in_wt_data0 (in_wt_data0) //|< i 
,.in_wt_data1 (in_wt_data1) //|< i 
,.in_wt_data2 (in_wt_data2) //|< i 
,.in_wt_data3 (in_wt_data3) //|< i 
,.in_wt_data4 (in_wt_data4) //|< i 
,.in_wt_data5 (in_wt_data5) //|< i 
,.in_wt_data6 (in_wt_data6) //|< i 
,.in_wt_data7 (in_wt_data7) //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
 ,.in_wt_mask (in_wt_mask) //|< w
 ,.in_wt_pvld (in_wt_pvld) //|< w
 ,.in_wt_sel (in_wt_sel) //|< w
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,.dat${i}_actv_data (dat${i}_actv_data) //|> w
//: ,.dat${i}_actv_nz (dat${i}_actv_nz) //|> w
//: ,.dat${i}_actv_pvld (dat${i}_actv_pvld) //|> w
//: ,.dat${i}_pre_mask (dat${i}_pre_mask) //|> w
//: ,.dat${i}_pre_pvld (dat${i}_pre_pvld) //|> w
//: ,.dat${i}_pre_stripe_end (dat${i}_pre_stripe_end) //|> w
//: ,.dat${i}_pre_stripe_st (dat${i}_pre_stripe_st) //|> w
//: )
//: }
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,.wt${i}_actv_data (wt${i}_actv_data) //|> w
//: ,.wt${i}_actv_nz (wt${i}_actv_nz) //|> w
//: ,.wt${i}_actv_pvld (wt${i}_actv_pvld) //|> w
//: ,.wt${i}_sd_mask (wt${i}_sd_mask) //|> w
//: ,.wt${i}_sd_pvld (wt${i}_sd_pvld) //|> w
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.dat0_actv_data (dat0_actv_data) //|> w
,.dat0_actv_nz (dat0_actv_nz) //|> w
,.dat0_actv_pvld (dat0_actv_pvld) //|> w
,.dat0_pre_mask (dat0_pre_mask) //|> w
,.dat0_pre_pvld (dat0_pre_pvld) //|> w
,.dat0_pre_stripe_end (dat0_pre_stripe_end) //|> w
,.dat0_pre_stripe_st (dat0_pre_stripe_st) //|> w

,.dat1_actv_data (dat1_actv_data) //|> w
,.dat1_actv_nz (dat1_actv_nz) //|> w
,.dat1_actv_pvld (dat1_actv_pvld) //|> w
,.dat1_pre_mask (dat1_pre_mask) //|> w
,.dat1_pre_pvld (dat1_pre_pvld) //|> w
,.dat1_pre_stripe_end (dat1_pre_stripe_end) //|> w
,.dat1_pre_stripe_st (dat1_pre_stripe_st) //|> w

,.dat2_actv_data (dat2_actv_data) //|> w
,.dat2_actv_nz (dat2_actv_nz) //|> w
,.dat2_actv_pvld (dat2_actv_pvld) //|> w
,.dat2_pre_mask (dat2_pre_mask) //|> w
,.dat2_pre_pvld (dat2_pre_pvld) //|> w
,.dat2_pre_stripe_end (dat2_pre_stripe_end) //|> w
,.dat2_pre_stripe_st (dat2_pre_stripe_st) //|> w

,.dat3_actv_data (dat3_actv_data) //|> w
,.dat3_actv_nz (dat3_actv_nz) //|> w
,.dat3_actv_pvld (dat3_actv_pvld) //|> w
,.dat3_pre_mask (dat3_pre_mask) //|> w
,.dat3_pre_pvld (dat3_pre_pvld) //|> w
,.dat3_pre_stripe_end (dat3_pre_stripe_end) //|> w
,.dat3_pre_stripe_st (dat3_pre_stripe_st) //|> w

,.wt0_actv_data (wt0_actv_data) //|> w
,.wt0_actv_nz (wt0_actv_nz) //|> w
,.wt0_actv_pvld (wt0_actv_pvld) //|> w
,.wt0_sd_mask (wt0_sd_mask) //|> w
,.wt0_sd_pvld (wt0_sd_pvld) //|> w

,.wt1_actv_data (wt1_actv_data) //|> w
,.wt1_actv_nz (wt1_actv_nz) //|> w
,.wt1_actv_pvld (wt1_actv_pvld) //|> w
,.wt1_sd_mask (wt1_sd_mask) //|> w
,.wt1_sd_pvld (wt1_sd_pvld) //|> w

,.wt2_actv_data (wt2_actv_data) //|> w
,.wt2_actv_nz (wt2_actv_nz) //|> w
,.wt2_actv_pvld (wt2_actv_pvld) //|> w
,.wt2_sd_mask (wt2_sd_mask) //|> w
,.wt2_sd_pvld (wt2_sd_pvld) //|> w

,.wt3_actv_data (wt3_actv_data) //|> w
,.wt3_actv_nz (wt3_actv_nz) //|> w
,.wt3_actv_pvld (wt3_actv_pvld) //|> w
,.wt3_sd_mask (wt3_sd_mask) //|> w
,.wt3_sd_pvld (wt3_sd_pvld) //|> w

//| eperl: generated_end (DO NOT EDIT ABOVE)
);
//==========================================================
// MAC CELLs
//==========================================================
//: my $total_num = 8/2;
//: for(my $i = 0; $i < $total_num; $i ++) {
//: print qq {
//: wire nvdla_op_gated_clk_${i};
//: wire nvdla_wg_gated_clk_${i};
//: wire [19 -1:0] out_data${i};
//: NV_NVDLA_CMAC_CORE_mac u_mac_${i} (
//: .nvdla_core_clk (nvdla_op_gated_clk_${i}) //|< w
//: ,.nvdla_wg_clk (nvdla_op_gated_clk_${i}) //|< w , need update for winograd
//: ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//: ,.cfg_is_wg (cfg_is_wg) //|< w
//: ,.cfg_reg_en (cfg_reg_en) //|< w
//: ,.dat_actv_data (dat${i}_actv_data) //|< w
//: ,.dat_actv_nz (dat${i}_actv_nz) //|< w
//: ,.dat_actv_pvld (dat${i}_actv_pvld) //|< w
//: ,.wt_actv_data (wt${i}_actv_data) //|< w
//: ,.wt_actv_nz (wt${i}_actv_nz) //|< w
//: ,.wt_actv_pvld (wt${i}_actv_pvld) //|< w
//: ,.mac_out_data (out_data${i}) //|> w
//: ,.mac_out_pvld (out_mask[${i}]) //|> w
//: );
//: }
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire nvdla_op_gated_clk_0;
wire nvdla_wg_gated_clk_0;
wire [19 -1:0] out_data0;
NV_NVDLA_CMAC_CORE_mac u_mac_0 (
.nvdla_core_clk (nvdla_op_gated_clk_0) //|< w
,.nvdla_wg_clk (nvdla_op_gated_clk_0) //|< w , need update for winograd
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.cfg_is_wg (cfg_is_wg) //|< w
,.cfg_reg_en (cfg_reg_en) //|< w
,.dat_actv_data (dat0_actv_data) //|< w
,.dat_actv_nz (dat0_actv_nz) //|< w
,.dat_actv_pvld (dat0_actv_pvld) //|< w
,.wt_actv_data (wt0_actv_data) //|< w
,.wt_actv_nz (wt0_actv_nz) //|< w
,.wt_actv_pvld (wt0_actv_pvld) //|< w
,.mac_out_data (out_data0) //|> w
,.mac_out_pvld (out_mask[0]) //|> w
);

wire nvdla_op_gated_clk_1;
wire nvdla_wg_gated_clk_1;
wire [19 -1:0] out_data1;
NV_NVDLA_CMAC_CORE_mac u_mac_1 (
.nvdla_core_clk (nvdla_op_gated_clk_1) //|< w
,.nvdla_wg_clk (nvdla_op_gated_clk_1) //|< w , need update for winograd
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.cfg_is_wg (cfg_is_wg) //|< w
,.cfg_reg_en (cfg_reg_en) //|< w
,.dat_actv_data (dat1_actv_data) //|< w
,.dat_actv_nz (dat1_actv_nz) //|< w
,.dat_actv_pvld (dat1_actv_pvld) //|< w
,.wt_actv_data (wt1_actv_data) //|< w
,.wt_actv_nz (wt1_actv_nz) //|< w
,.wt_actv_pvld (wt1_actv_pvld) //|< w
,.mac_out_data (out_data1) //|> w
,.mac_out_pvld (out_mask[1]) //|> w
);

wire nvdla_op_gated_clk_2;
wire nvdla_wg_gated_clk_2;
wire [19 -1:0] out_data2;
NV_NVDLA_CMAC_CORE_mac u_mac_2 (
.nvdla_core_clk (nvdla_op_gated_clk_2) //|< w
,.nvdla_wg_clk (nvdla_op_gated_clk_2) //|< w , need update for winograd
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.cfg_is_wg (cfg_is_wg) //|< w
,.cfg_reg_en (cfg_reg_en) //|< w
,.dat_actv_data (dat2_actv_data) //|< w
,.dat_actv_nz (dat2_actv_nz) //|< w
,.dat_actv_pvld (dat2_actv_pvld) //|< w
,.wt_actv_data (wt2_actv_data) //|< w
,.wt_actv_nz (wt2_actv_nz) //|< w
,.wt_actv_pvld (wt2_actv_pvld) //|< w
,.mac_out_data (out_data2) //|> w
,.mac_out_pvld (out_mask[2]) //|> w
);

wire nvdla_op_gated_clk_3;
wire nvdla_wg_gated_clk_3;
wire [19 -1:0] out_data3;
NV_NVDLA_CMAC_CORE_mac u_mac_3 (
.nvdla_core_clk (nvdla_op_gated_clk_3) //|< w
,.nvdla_wg_clk (nvdla_op_gated_clk_3) //|< w , need update for winograd
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.cfg_is_wg (cfg_is_wg) //|< w
,.cfg_reg_en (cfg_reg_en) //|< w
,.dat_actv_data (dat3_actv_data) //|< w
,.dat_actv_nz (dat3_actv_nz) //|< w
,.dat_actv_pvld (dat3_actv_pvld) //|< w
,.wt_actv_data (wt3_actv_data) //|< w
,.wt_actv_nz (wt3_actv_nz) //|< w
,.wt_actv_pvld (wt3_actv_pvld) //|< w
,.mac_out_data (out_data3) //|> w
,.mac_out_pvld (out_mask[3]) //|> w
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//==========================================================
// output retiming logic
//==========================================================
//: my $i = 8/2 +2;
//: print qq(
//: wire nvdla_op_gated_clk_${i}; );
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire nvdla_op_gated_clk_6; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
NV_NVDLA_CMAC_CORE_rt_out u_rt_out (
//: my $i=8/2 +2;
//: print qq(
//: .nvdla_core_clk (nvdla_op_gated_clk_${i}) //|< w 
//: ,.nvdla_wg_clk (nvdla_op_gated_clk_${i}) //|< w );
//| eperl: generated_beg (DO NOT EDIT BELOW)

.nvdla_core_clk (nvdla_op_gated_clk_6) //|< w 
,.nvdla_wg_clk (nvdla_op_gated_clk_6) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
 ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
 ,.cfg_is_wg (cfg_is_wg) //|< w
 ,.cfg_reg_en (cfg_reg_en) //|< w
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: ,.out_data${i} (out_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.out_data0 (out_data0) //|< w 
,.out_data1 (out_data1) //|< w 
,.out_data2 (out_data2) //|< w 
,.out_data3 (out_data3) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
 ,.out_mask (out_mask) //|< w
 ,.out_pd (out_pd) //|< w
 ,.out_pvld (out_pvld) //|< w
 ,.dp2reg_done (dp2reg_done) //|> o
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: ,.mac2accu_data${i} (mac2accu_data${i}) //|> o )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac2accu_data0 (mac2accu_data0) //|> o 
,.mac2accu_data1 (mac2accu_data1) //|> o 
,.mac2accu_data2 (mac2accu_data2) //|> o 
,.mac2accu_data3 (mac2accu_data3) //|> o 
//| eperl: generated_end (DO NOT EDIT ABOVE)
 ,.mac2accu_mask (mac2accu_mask) //|> o
 ,.mac2accu_pd (mac2accu_pd) //|> o
 ,.mac2accu_pvld (mac2accu_pvld) //|> o
 );
//==========================================================
// SLCG groups
//==========================================================
//: for(my $i = 0; $i < 3+8/2; $i ++) {
//: print qq {
//: NV_NVDLA_CMAC_CORE_slcg u_slcg_op_${i} (
//: .dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
//: ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
//: ,.nvdla_core_clk (nvdla_core_clk) //|< i
//: ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//: ,.slcg_en_src_0 (slcg_op_en[${i}]) //|< i
//: ,.slcg_en_src_1 (1'b1) //|< ?
//: ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
//: ,.nvdla_core_gated_clk (nvdla_op_gated_clk_${i}) //|> w
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

NV_NVDLA_CMAC_CORE_slcg u_slcg_op_0 (
.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
,.nvdla_core_clk (nvdla_core_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.slcg_en_src_0 (slcg_op_en[0]) //|< i
,.slcg_en_src_1 (1'b1) //|< ?
,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
,.nvdla_core_gated_clk (nvdla_op_gated_clk_0) //|> w
);

NV_NVDLA_CMAC_CORE_slcg u_slcg_op_1 (
.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
,.nvdla_core_clk (nvdla_core_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.slcg_en_src_0 (slcg_op_en[1]) //|< i
,.slcg_en_src_1 (1'b1) //|< ?
,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
,.nvdla_core_gated_clk (nvdla_op_gated_clk_1) //|> w
);

NV_NVDLA_CMAC_CORE_slcg u_slcg_op_2 (
.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
,.nvdla_core_clk (nvdla_core_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.slcg_en_src_0 (slcg_op_en[2]) //|< i
,.slcg_en_src_1 (1'b1) //|< ?
,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
,.nvdla_core_gated_clk (nvdla_op_gated_clk_2) //|> w
);

NV_NVDLA_CMAC_CORE_slcg u_slcg_op_3 (
.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
,.nvdla_core_clk (nvdla_core_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.slcg_en_src_0 (slcg_op_en[3]) //|< i
,.slcg_en_src_1 (1'b1) //|< ?
,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
,.nvdla_core_gated_clk (nvdla_op_gated_clk_3) //|> w
);

NV_NVDLA_CMAC_CORE_slcg u_slcg_op_4 (
.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
,.nvdla_core_clk (nvdla_core_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.slcg_en_src_0 (slcg_op_en[4]) //|< i
,.slcg_en_src_1 (1'b1) //|< ?
,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
,.nvdla_core_gated_clk (nvdla_op_gated_clk_4) //|> w
);

NV_NVDLA_CMAC_CORE_slcg u_slcg_op_5 (
.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
,.nvdla_core_clk (nvdla_core_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.slcg_en_src_0 (slcg_op_en[5]) //|< i
,.slcg_en_src_1 (1'b1) //|< ?
,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
,.nvdla_core_gated_clk (nvdla_op_gated_clk_5) //|> w
);

NV_NVDLA_CMAC_CORE_slcg u_slcg_op_6 (
.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
,.nvdla_core_clk (nvdla_core_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.slcg_en_src_0 (slcg_op_en[6]) //|< i
,.slcg_en_src_1 (1'b1) //|< ?
,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
,.nvdla_core_gated_clk (nvdla_op_gated_clk_6) //|> w
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
`ifndef SYNTHESIS
wire [8:0] dbg_mac2accu_pd;
wire dbg_mac2accu_pvld;
wire [8:0] dbg_out_pd_d0;
wire dbg_out_pvld_d0;
`endif
//////// for valid forwarding ///////
`ifndef SYNTHESIS
//: print qq (
//: assign dbg_out_pvld_d0 = out_pvld;
//: assign dbg_out_pd_d0 = out_pd;
//: );
//:
//: my $delay = (2 +2 +3 +2)-2 -(3 +2 -3);
//: my $i;
//:
//: for($i = 0; $i < $delay; $i ++) {
//: my $j = $i + 1;
//: &eperl::flop("-q dbg_out_pvld_d${j} -d dbg_out_pvld_d${i}");
//: &eperl::flop("-wid 9 -q dbg_out_pd_d${j} -en dbg_out_pvld_d${i} -d dbg_out_pd_d${i}");
//: }
//:
//: print qq (
//: assign dbg_mac2accu_pvld = dbg_out_pvld_d${delay};
//: assign dbg_mac2accu_pd = dbg_out_pd_d${delay};
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dbg_out_pvld_d0 = out_pvld;
assign dbg_out_pd_d0 = out_pd;
reg  dbg_out_pvld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pvld_d1 <= 'b0;
   end else begin
       dbg_out_pvld_d1 <= dbg_out_pvld_d0;
   end
end
reg [8:0] dbg_out_pd_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pd_d1 <= 'b0;
   end else begin
       if ((dbg_out_pvld_d0) == 1'b1) begin
           dbg_out_pd_d1 <= dbg_out_pd_d0;
       // VCS coverage off
       end else if ((dbg_out_pvld_d0) == 1'b0) begin
       end else begin
           dbg_out_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dbg_out_pvld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pvld_d2 <= 'b0;
   end else begin
       dbg_out_pvld_d2 <= dbg_out_pvld_d1;
   end
end
reg [8:0] dbg_out_pd_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pd_d2 <= 'b0;
   end else begin
       if ((dbg_out_pvld_d1) == 1'b1) begin
           dbg_out_pd_d2 <= dbg_out_pd_d1;
       // VCS coverage off
       end else if ((dbg_out_pvld_d1) == 1'b0) begin
       end else begin
           dbg_out_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dbg_out_pvld_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pvld_d3 <= 'b0;
   end else begin
       dbg_out_pvld_d3 <= dbg_out_pvld_d2;
   end
end
reg [8:0] dbg_out_pd_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pd_d3 <= 'b0;
   end else begin
       if ((dbg_out_pvld_d2) == 1'b1) begin
           dbg_out_pd_d3 <= dbg_out_pd_d2;
       // VCS coverage off
       end else if ((dbg_out_pvld_d2) == 1'b0) begin
       end else begin
           dbg_out_pd_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dbg_out_pvld_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pvld_d4 <= 'b0;
   end else begin
       dbg_out_pvld_d4 <= dbg_out_pvld_d3;
   end
end
reg [8:0] dbg_out_pd_d4;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pd_d4 <= 'b0;
   end else begin
       if ((dbg_out_pvld_d3) == 1'b1) begin
           dbg_out_pd_d4 <= dbg_out_pd_d3;
       // VCS coverage off
       end else if ((dbg_out_pvld_d3) == 1'b0) begin
       end else begin
           dbg_out_pd_d4 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dbg_out_pvld_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pvld_d5 <= 'b0;
   end else begin
       dbg_out_pvld_d5 <= dbg_out_pvld_d4;
   end
end
reg [8:0] dbg_out_pd_d5;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbg_out_pd_d5 <= 'b0;
   end else begin
       if ((dbg_out_pvld_d4) == 1'b1) begin
           dbg_out_pd_d5 <= dbg_out_pd_d4;
       // VCS coverage off
       end else if ((dbg_out_pvld_d4) == 1'b0) begin
       end else begin
           dbg_out_pd_d5 <= 'bx;
       // VCS coverage on
       end
   end
end

assign dbg_mac2accu_pvld = dbg_out_pvld_d5;
assign dbg_mac2accu_pd = dbg_out_pd_d5;

//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
endmodule
