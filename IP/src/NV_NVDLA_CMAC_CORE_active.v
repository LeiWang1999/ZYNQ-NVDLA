// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC_CORE_active.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC.h
`define DESIGNWARE_NOEXIST 1
module NV_NVDLA_CMAC_CORE_active (
   nvdla_core_clk
  ,nvdla_core_rstn
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: ,in_dat_data${i})
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,in_dat_data0
,in_dat_data1
,in_dat_data2
,in_dat_data3
,in_dat_data4
,in_dat_data5
,in_dat_data6
,in_dat_data7
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,in_dat_mask
  ,in_dat_pvld
  ,in_dat_stripe_end
  ,in_dat_stripe_st
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: ,in_wt_data${i})
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,in_wt_data0
,in_wt_data1
,in_wt_data2
,in_wt_data3
,in_wt_data4
,in_wt_data5
,in_wt_data6
,in_wt_data7
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,in_wt_mask
  ,in_wt_pvld
  ,in_wt_sel
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: ,dat${i}_actv_data
//: ,dat${i}_actv_nz
//: ,dat${i}_actv_pvld
//: ,dat${i}_pre_mask
//: ,dat${i}_pre_pvld
//: ,dat${i}_pre_stripe_end
//: ,dat${i}_pre_stripe_st
//: )
//: }
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: ,wt${i}_actv_data
//: ,wt${i}_actv_nz
//: ,wt${i}_actv_pvld
//: ,wt${i}_sd_mask
//: ,wt${i}_sd_pvld
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,dat0_actv_data
,dat0_actv_nz
,dat0_actv_pvld
,dat0_pre_mask
,dat0_pre_pvld
,dat0_pre_stripe_end
,dat0_pre_stripe_st

,dat1_actv_data
,dat1_actv_nz
,dat1_actv_pvld
,dat1_pre_mask
,dat1_pre_pvld
,dat1_pre_stripe_end
,dat1_pre_stripe_st

,dat2_actv_data
,dat2_actv_nz
,dat2_actv_pvld
,dat2_pre_mask
,dat2_pre_pvld
,dat2_pre_stripe_end
,dat2_pre_stripe_st

,dat3_actv_data
,dat3_actv_nz
,dat3_actv_pvld
,dat3_pre_mask
,dat3_pre_pvld
,dat3_pre_stripe_end
,dat3_pre_stripe_st

,wt0_actv_data
,wt0_actv_nz
,wt0_actv_pvld
,wt0_sd_mask
,wt0_sd_pvld

,wt1_actv_data
,wt1_actv_nz
,wt1_actv_pvld
,wt1_sd_mask
,wt1_sd_pvld

,wt2_actv_data
,wt2_actv_nz
,wt2_actv_pvld
,wt2_sd_mask
,wt2_sd_pvld

,wt3_actv_data
,wt3_actv_nz
,wt3_actv_pvld
,wt3_sd_mask
,wt3_sd_pvld

//| eperl: generated_end (DO NOT EDIT ABOVE)
  );
input nvdla_core_clk;
input nvdla_core_rstn;
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: input [8 -1:0] in_dat_data${i};)
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [8 -1:0] in_dat_data0;
input [8 -1:0] in_dat_data1;
input [8 -1:0] in_dat_data2;
input [8 -1:0] in_dat_data3;
input [8 -1:0] in_dat_data4;
input [8 -1:0] in_dat_data5;
input [8 -1:0] in_dat_data6;
input [8 -1:0] in_dat_data7;
//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8 -1:0] in_dat_mask;
input in_dat_pvld;
input in_dat_stripe_end;
input in_dat_stripe_st;
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: input [8 -1:0] in_wt_data${i};)
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [8 -1:0] in_wt_data0;
input [8 -1:0] in_wt_data1;
input [8 -1:0] in_wt_data2;
input [8 -1:0] in_wt_data3;
input [8 -1:0] in_wt_data4;
input [8 -1:0] in_wt_data5;
input [8 -1:0] in_wt_data6;
input [8 -1:0] in_wt_data7;
//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8 -1:0] in_wt_mask;
input in_wt_pvld;
input [8/2 -1:0] in_wt_sel;
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: output [8*8 -1:0] dat${i}_actv_data;
//: output [8 -1:0] dat${i}_actv_nz;
//: output [8 -1:0] dat${i}_actv_pvld;
//: output [8 -1:0] dat${i}_pre_mask;
//: output dat${i}_pre_pvld;
//: output dat${i}_pre_stripe_end;
//: output dat${i}_pre_stripe_st;
//: )
//: }
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: output [8*8 -1:0] wt${i}_actv_data;
//: output [8 -1:0] wt${i}_actv_nz;
//: output [8 -1:0] wt${i}_actv_pvld;
//: output [8 -1:0] wt${i}_sd_mask;
//: output wt${i}_sd_pvld;
//: )
//: }
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: reg [8*8 -1:0] dat_actv_data_reg${i};
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [8*8 -1:0] dat0_actv_data;
output [8 -1:0] dat0_actv_nz;
output [8 -1:0] dat0_actv_pvld;
output [8 -1:0] dat0_pre_mask;
output dat0_pre_pvld;
output dat0_pre_stripe_end;
output dat0_pre_stripe_st;

output [8*8 -1:0] dat1_actv_data;
output [8 -1:0] dat1_actv_nz;
output [8 -1:0] dat1_actv_pvld;
output [8 -1:0] dat1_pre_mask;
output dat1_pre_pvld;
output dat1_pre_stripe_end;
output dat1_pre_stripe_st;

output [8*8 -1:0] dat2_actv_data;
output [8 -1:0] dat2_actv_nz;
output [8 -1:0] dat2_actv_pvld;
output [8 -1:0] dat2_pre_mask;
output dat2_pre_pvld;
output dat2_pre_stripe_end;
output dat2_pre_stripe_st;

output [8*8 -1:0] dat3_actv_data;
output [8 -1:0] dat3_actv_nz;
output [8 -1:0] dat3_actv_pvld;
output [8 -1:0] dat3_pre_mask;
output dat3_pre_pvld;
output dat3_pre_stripe_end;
output dat3_pre_stripe_st;

output [8*8 -1:0] wt0_actv_data;
output [8 -1:0] wt0_actv_nz;
output [8 -1:0] wt0_actv_pvld;
output [8 -1:0] wt0_sd_mask;
output wt0_sd_pvld;

output [8*8 -1:0] wt1_actv_data;
output [8 -1:0] wt1_actv_nz;
output [8 -1:0] wt1_actv_pvld;
output [8 -1:0] wt1_sd_mask;
output wt1_sd_pvld;

output [8*8 -1:0] wt2_actv_data;
output [8 -1:0] wt2_actv_nz;
output [8 -1:0] wt2_actv_pvld;
output [8 -1:0] wt2_sd_mask;
output wt2_sd_pvld;

output [8*8 -1:0] wt3_actv_data;
output [8 -1:0] wt3_actv_nz;
output [8 -1:0] wt3_actv_pvld;
output [8 -1:0] wt3_sd_mask;
output wt3_sd_pvld;

reg [8*8 -1:0] dat_actv_data_reg0;

reg [8*8 -1:0] dat_actv_data_reg1;

reg [8*8 -1:0] dat_actv_data_reg2;

reg [8*8 -1:0] dat_actv_data_reg3;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8*8 -1:0] dat_pre_data_w;
wire [8 -1:0] dat_pre_mask_w;
reg [8 -1:0] dat_pre_nz_w;
reg dat_pre_stripe_end;
reg dat_pre_stripe_st;
reg [8*8 -1:0] wt_pre_data;
wire [8*8 -1:0] wt_pre_data_w;
reg [8 -1:0] wt_pre_mask;
wire [8 -1:0] wt_pre_mask_w;
reg [8 -1:0] wt_pre_nz_w;
//: my $kk=8;
//: for(my $i=0; $i<8/2; $i++){
//: print qq(
//: wire [${kk}-1:0] wt${i}_sd_mask={${kk}{1'b0}};
//: wire [${kk}-1:0] dat${i}_pre_mask={${kk}{1'b0}};
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [8-1:0] wt0_sd_mask={8{1'b0}};
wire [8-1:0] dat0_pre_mask={8{1'b0}};

wire [8-1:0] wt1_sd_mask={8{1'b0}};
wire [8-1:0] dat1_pre_mask={8{1'b0}};

wire [8-1:0] wt2_sd_mask={8{1'b0}};
wire [8-1:0] dat2_pre_mask={8{1'b0}};

wire [8-1:0] wt3_sd_mask={8{1'b0}};
wire [8-1:0] dat3_pre_mask={8{1'b0}};

//| eperl: generated_end (DO NOT EDIT ABOVE)
/////////////////////////////////////// handle weight ///////////////////////
// weight pack
//: print "assign    wt_pre_data_w  = {";
//: for(my $i = 8 -1; $i >= 0; $i --) {
//: print "in_wt_data${i}";
//: if($i == 0) {
//: print "};\n";
//: } elsif ($i % 8 == 0) {
//: print ",\n                       ";
//: } else {
//: print ", ";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign    wt_pre_data_w  = {in_wt_data7, in_wt_data6, in_wt_data5, in_wt_data4, in_wt_data3, in_wt_data2, in_wt_data1, in_wt_data0};

//| eperl: generated_end (DO NOT EDIT ABOVE)
// weight mask pack
//: print "assign    wt_pre_mask_w = {";
//: for(my $i = 8 -1; $i >= 0; $i --) {
//: print "in_wt_mask[${i}]";
//: if($i == 0) {
//: print "};\n";
//: } elsif ($i % 8 == 0) {
//: print ",\n                       ";
//: } else {
//: print ", ";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign    wt_pre_mask_w = {in_wt_mask[7], in_wt_mask[6], in_wt_mask[5], in_wt_mask[4], in_wt_mask[3], in_wt_mask[2], in_wt_mask[1], in_wt_mask[0]};

//| eperl: generated_end (DO NOT EDIT ABOVE)
// 1 pipe for input
//: my $i=8;
//: my $j=8/2;
//: &eperl::flop(" -q  wt_pre_nz    -en in_wt_pvld -d  wt_pre_mask_w -wid ${i}  -clk nvdla_core_clk -rst nvdla_core_rstn");
//: &eperl::flop(" -q wt_pre_sel -d \"in_wt_sel&{${j}{in_wt_pvld}}\" -wid ${j} -clk nvdla_core_clk -rst nvdla_core_rstn");
//:
//: for (my $i = 0; $i < 8; $i ++) {
//: my $b0 = $i * 8;
//: my $b1 = $i * 8 + 7;
//: &eperl::flop("-nodeclare -norst -q  wt_pre_data[${b1}:${b0}]  -en \"in_wt_pvld & wt_pre_mask_w[${i}]\" -d  \"wt_pre_data_w[${b1}:${b0}]\" -clk nvdla_core_clk");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [7:0] wt_pre_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_pre_nz <= 'b0;
   end else begin
       if ((in_wt_pvld) == 1'b1) begin
           wt_pre_nz <= wt_pre_mask_w;
       // VCS coverage off
       end else if ((in_wt_pvld) == 1'b0) begin
       end else begin
           wt_pre_nz <= 'bx;
       // VCS coverage on
       end
   end
end
reg [3:0] wt_pre_sel;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt_pre_sel <= 'b0;
   end else begin
       wt_pre_sel <= in_wt_sel&{4{in_wt_pvld}};
   end
end
always @(posedge nvdla_core_clk) begin
       if ((in_wt_pvld & wt_pre_mask_w[0]) == 1'b1) begin
           wt_pre_data[7:0] <= wt_pre_data_w[7:0];
       // VCS coverage off
       end else if ((in_wt_pvld & wt_pre_mask_w[0]) == 1'b0) begin
       end else begin
           wt_pre_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_wt_pvld & wt_pre_mask_w[1]) == 1'b1) begin
           wt_pre_data[15:8] <= wt_pre_data_w[15:8];
       // VCS coverage off
       end else if ((in_wt_pvld & wt_pre_mask_w[1]) == 1'b0) begin
       end else begin
           wt_pre_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_wt_pvld & wt_pre_mask_w[2]) == 1'b1) begin
           wt_pre_data[23:16] <= wt_pre_data_w[23:16];
       // VCS coverage off
       end else if ((in_wt_pvld & wt_pre_mask_w[2]) == 1'b0) begin
       end else begin
           wt_pre_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_wt_pvld & wt_pre_mask_w[3]) == 1'b1) begin
           wt_pre_data[31:24] <= wt_pre_data_w[31:24];
       // VCS coverage off
       end else if ((in_wt_pvld & wt_pre_mask_w[3]) == 1'b0) begin
       end else begin
           wt_pre_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_wt_pvld & wt_pre_mask_w[4]) == 1'b1) begin
           wt_pre_data[39:32] <= wt_pre_data_w[39:32];
       // VCS coverage off
       end else if ((in_wt_pvld & wt_pre_mask_w[4]) == 1'b0) begin
       end else begin
           wt_pre_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_wt_pvld & wt_pre_mask_w[5]) == 1'b1) begin
           wt_pre_data[47:40] <= wt_pre_data_w[47:40];
       // VCS coverage off
       end else if ((in_wt_pvld & wt_pre_mask_w[5]) == 1'b0) begin
       end else begin
           wt_pre_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_wt_pvld & wt_pre_mask_w[6]) == 1'b1) begin
           wt_pre_data[55:48] <= wt_pre_data_w[55:48];
       // VCS coverage off
       end else if ((in_wt_pvld & wt_pre_mask_w[6]) == 1'b0) begin
       end else begin
           wt_pre_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_wt_pvld & wt_pre_mask_w[7]) == 1'b1) begin
           wt_pre_data[63:56] <= wt_pre_data_w[63:56];
       // VCS coverage off
       end else if ((in_wt_pvld & wt_pre_mask_w[7]) == 1'b0) begin
       end else begin
           wt_pre_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// put input weight into shadow.
//: for(my $i = 0; $i < 8/2; $i ++) {
//: print qq (
//: reg wt${i}_sd_pvld;
//: wire wt${i}_sd_pvld_w = wt_pre_sel[${i}] ? 1'b1 : dat_pre_stripe_st ? 1'b0 : wt${i}_sd_pvld; );
//: my $kk=8;
//: &eperl::flop("-nodeclare -q  wt${i}_sd_pvld  -d \"wt${i}_sd_pvld_w\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop(" -q  wt${i}_sd_nz -en wt_pre_sel[${i}] -d  \"wt_pre_nz\" -wid ${kk} -clk nvdla_core_clk -rst nvdla_core_rstn");
//:
//: print qq(
//: reg [8*8 -1:0] wt${i}_sd_data; );
//: for(my $k = 0; $k < 8; $k ++) {
//: my $b0 = $k * 8;
//: my $b1 = $k * 8 + 7;
//: &eperl::flop("-nodeclare -norst -q  wt${i}_sd_data[${b1}:${b0}]  -en \"wt_pre_sel[${i}] & wt_pre_nz[${k}]\" -d  \"wt_pre_data[${b1}:${b0}] \" -clk nvdla_core_clk");
//: }
//: }
//: &eperl::flop(" -q  dat_actv_stripe_end  -d \"dat_pre_stripe_end\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//| eperl: generated_beg (DO NOT EDIT BELOW)

reg wt0_sd_pvld;
wire wt0_sd_pvld_w = wt_pre_sel[0] ? 1'b1 : dat_pre_stripe_st ? 1'b0 : wt0_sd_pvld; always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt0_sd_pvld <= 'b0;
   end else begin
       wt0_sd_pvld <= wt0_sd_pvld_w;
   end
end
reg [7:0] wt0_sd_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt0_sd_nz <= 'b0;
   end else begin
       if ((wt_pre_sel[0]) == 1'b1) begin
           wt0_sd_nz <= wt_pre_nz;
       // VCS coverage off
       end else if ((wt_pre_sel[0]) == 1'b0) begin
       end else begin
           wt0_sd_nz <= 'bx;
       // VCS coverage on
       end
   end
end

reg [8*8 -1:0] wt0_sd_data; always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[0] & wt_pre_nz[0]) == 1'b1) begin
           wt0_sd_data[7:0] <= wt_pre_data[7:0] ;
       // VCS coverage off
       end else if ((wt_pre_sel[0] & wt_pre_nz[0]) == 1'b0) begin
       end else begin
           wt0_sd_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[0] & wt_pre_nz[1]) == 1'b1) begin
           wt0_sd_data[15:8] <= wt_pre_data[15:8] ;
       // VCS coverage off
       end else if ((wt_pre_sel[0] & wt_pre_nz[1]) == 1'b0) begin
       end else begin
           wt0_sd_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[0] & wt_pre_nz[2]) == 1'b1) begin
           wt0_sd_data[23:16] <= wt_pre_data[23:16] ;
       // VCS coverage off
       end else if ((wt_pre_sel[0] & wt_pre_nz[2]) == 1'b0) begin
       end else begin
           wt0_sd_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[0] & wt_pre_nz[3]) == 1'b1) begin
           wt0_sd_data[31:24] <= wt_pre_data[31:24] ;
       // VCS coverage off
       end else if ((wt_pre_sel[0] & wt_pre_nz[3]) == 1'b0) begin
       end else begin
           wt0_sd_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[0] & wt_pre_nz[4]) == 1'b1) begin
           wt0_sd_data[39:32] <= wt_pre_data[39:32] ;
       // VCS coverage off
       end else if ((wt_pre_sel[0] & wt_pre_nz[4]) == 1'b0) begin
       end else begin
           wt0_sd_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[0] & wt_pre_nz[5]) == 1'b1) begin
           wt0_sd_data[47:40] <= wt_pre_data[47:40] ;
       // VCS coverage off
       end else if ((wt_pre_sel[0] & wt_pre_nz[5]) == 1'b0) begin
       end else begin
           wt0_sd_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[0] & wt_pre_nz[6]) == 1'b1) begin
           wt0_sd_data[55:48] <= wt_pre_data[55:48] ;
       // VCS coverage off
       end else if ((wt_pre_sel[0] & wt_pre_nz[6]) == 1'b0) begin
       end else begin
           wt0_sd_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[0] & wt_pre_nz[7]) == 1'b1) begin
           wt0_sd_data[63:56] <= wt_pre_data[63:56] ;
       // VCS coverage off
       end else if ((wt_pre_sel[0] & wt_pre_nz[7]) == 1'b0) begin
       end else begin
           wt0_sd_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

reg wt1_sd_pvld;
wire wt1_sd_pvld_w = wt_pre_sel[1] ? 1'b1 : dat_pre_stripe_st ? 1'b0 : wt1_sd_pvld; always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt1_sd_pvld <= 'b0;
   end else begin
       wt1_sd_pvld <= wt1_sd_pvld_w;
   end
end
reg [7:0] wt1_sd_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt1_sd_nz <= 'b0;
   end else begin
       if ((wt_pre_sel[1]) == 1'b1) begin
           wt1_sd_nz <= wt_pre_nz;
       // VCS coverage off
       end else if ((wt_pre_sel[1]) == 1'b0) begin
       end else begin
           wt1_sd_nz <= 'bx;
       // VCS coverage on
       end
   end
end

reg [8*8 -1:0] wt1_sd_data; always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[1] & wt_pre_nz[0]) == 1'b1) begin
           wt1_sd_data[7:0] <= wt_pre_data[7:0] ;
       // VCS coverage off
       end else if ((wt_pre_sel[1] & wt_pre_nz[0]) == 1'b0) begin
       end else begin
           wt1_sd_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[1] & wt_pre_nz[1]) == 1'b1) begin
           wt1_sd_data[15:8] <= wt_pre_data[15:8] ;
       // VCS coverage off
       end else if ((wt_pre_sel[1] & wt_pre_nz[1]) == 1'b0) begin
       end else begin
           wt1_sd_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[1] & wt_pre_nz[2]) == 1'b1) begin
           wt1_sd_data[23:16] <= wt_pre_data[23:16] ;
       // VCS coverage off
       end else if ((wt_pre_sel[1] & wt_pre_nz[2]) == 1'b0) begin
       end else begin
           wt1_sd_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[1] & wt_pre_nz[3]) == 1'b1) begin
           wt1_sd_data[31:24] <= wt_pre_data[31:24] ;
       // VCS coverage off
       end else if ((wt_pre_sel[1] & wt_pre_nz[3]) == 1'b0) begin
       end else begin
           wt1_sd_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[1] & wt_pre_nz[4]) == 1'b1) begin
           wt1_sd_data[39:32] <= wt_pre_data[39:32] ;
       // VCS coverage off
       end else if ((wt_pre_sel[1] & wt_pre_nz[4]) == 1'b0) begin
       end else begin
           wt1_sd_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[1] & wt_pre_nz[5]) == 1'b1) begin
           wt1_sd_data[47:40] <= wt_pre_data[47:40] ;
       // VCS coverage off
       end else if ((wt_pre_sel[1] & wt_pre_nz[5]) == 1'b0) begin
       end else begin
           wt1_sd_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[1] & wt_pre_nz[6]) == 1'b1) begin
           wt1_sd_data[55:48] <= wt_pre_data[55:48] ;
       // VCS coverage off
       end else if ((wt_pre_sel[1] & wt_pre_nz[6]) == 1'b0) begin
       end else begin
           wt1_sd_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[1] & wt_pre_nz[7]) == 1'b1) begin
           wt1_sd_data[63:56] <= wt_pre_data[63:56] ;
       // VCS coverage off
       end else if ((wt_pre_sel[1] & wt_pre_nz[7]) == 1'b0) begin
       end else begin
           wt1_sd_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

reg wt2_sd_pvld;
wire wt2_sd_pvld_w = wt_pre_sel[2] ? 1'b1 : dat_pre_stripe_st ? 1'b0 : wt2_sd_pvld; always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt2_sd_pvld <= 'b0;
   end else begin
       wt2_sd_pvld <= wt2_sd_pvld_w;
   end
end
reg [7:0] wt2_sd_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt2_sd_nz <= 'b0;
   end else begin
       if ((wt_pre_sel[2]) == 1'b1) begin
           wt2_sd_nz <= wt_pre_nz;
       // VCS coverage off
       end else if ((wt_pre_sel[2]) == 1'b0) begin
       end else begin
           wt2_sd_nz <= 'bx;
       // VCS coverage on
       end
   end
end

reg [8*8 -1:0] wt2_sd_data; always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[2] & wt_pre_nz[0]) == 1'b1) begin
           wt2_sd_data[7:0] <= wt_pre_data[7:0] ;
       // VCS coverage off
       end else if ((wt_pre_sel[2] & wt_pre_nz[0]) == 1'b0) begin
       end else begin
           wt2_sd_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[2] & wt_pre_nz[1]) == 1'b1) begin
           wt2_sd_data[15:8] <= wt_pre_data[15:8] ;
       // VCS coverage off
       end else if ((wt_pre_sel[2] & wt_pre_nz[1]) == 1'b0) begin
       end else begin
           wt2_sd_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[2] & wt_pre_nz[2]) == 1'b1) begin
           wt2_sd_data[23:16] <= wt_pre_data[23:16] ;
       // VCS coverage off
       end else if ((wt_pre_sel[2] & wt_pre_nz[2]) == 1'b0) begin
       end else begin
           wt2_sd_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[2] & wt_pre_nz[3]) == 1'b1) begin
           wt2_sd_data[31:24] <= wt_pre_data[31:24] ;
       // VCS coverage off
       end else if ((wt_pre_sel[2] & wt_pre_nz[3]) == 1'b0) begin
       end else begin
           wt2_sd_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[2] & wt_pre_nz[4]) == 1'b1) begin
           wt2_sd_data[39:32] <= wt_pre_data[39:32] ;
       // VCS coverage off
       end else if ((wt_pre_sel[2] & wt_pre_nz[4]) == 1'b0) begin
       end else begin
           wt2_sd_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[2] & wt_pre_nz[5]) == 1'b1) begin
           wt2_sd_data[47:40] <= wt_pre_data[47:40] ;
       // VCS coverage off
       end else if ((wt_pre_sel[2] & wt_pre_nz[5]) == 1'b0) begin
       end else begin
           wt2_sd_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[2] & wt_pre_nz[6]) == 1'b1) begin
           wt2_sd_data[55:48] <= wt_pre_data[55:48] ;
       // VCS coverage off
       end else if ((wt_pre_sel[2] & wt_pre_nz[6]) == 1'b0) begin
       end else begin
           wt2_sd_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[2] & wt_pre_nz[7]) == 1'b1) begin
           wt2_sd_data[63:56] <= wt_pre_data[63:56] ;
       // VCS coverage off
       end else if ((wt_pre_sel[2] & wt_pre_nz[7]) == 1'b0) begin
       end else begin
           wt2_sd_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

reg wt3_sd_pvld;
wire wt3_sd_pvld_w = wt_pre_sel[3] ? 1'b1 : dat_pre_stripe_st ? 1'b0 : wt3_sd_pvld; always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt3_sd_pvld <= 'b0;
   end else begin
       wt3_sd_pvld <= wt3_sd_pvld_w;
   end
end
reg [7:0] wt3_sd_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt3_sd_nz <= 'b0;
   end else begin
       if ((wt_pre_sel[3]) == 1'b1) begin
           wt3_sd_nz <= wt_pre_nz;
       // VCS coverage off
       end else if ((wt_pre_sel[3]) == 1'b0) begin
       end else begin
           wt3_sd_nz <= 'bx;
       // VCS coverage on
       end
   end
end

reg [8*8 -1:0] wt3_sd_data; always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[3] & wt_pre_nz[0]) == 1'b1) begin
           wt3_sd_data[7:0] <= wt_pre_data[7:0] ;
       // VCS coverage off
       end else if ((wt_pre_sel[3] & wt_pre_nz[0]) == 1'b0) begin
       end else begin
           wt3_sd_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[3] & wt_pre_nz[1]) == 1'b1) begin
           wt3_sd_data[15:8] <= wt_pre_data[15:8] ;
       // VCS coverage off
       end else if ((wt_pre_sel[3] & wt_pre_nz[1]) == 1'b0) begin
       end else begin
           wt3_sd_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[3] & wt_pre_nz[2]) == 1'b1) begin
           wt3_sd_data[23:16] <= wt_pre_data[23:16] ;
       // VCS coverage off
       end else if ((wt_pre_sel[3] & wt_pre_nz[2]) == 1'b0) begin
       end else begin
           wt3_sd_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[3] & wt_pre_nz[3]) == 1'b1) begin
           wt3_sd_data[31:24] <= wt_pre_data[31:24] ;
       // VCS coverage off
       end else if ((wt_pre_sel[3] & wt_pre_nz[3]) == 1'b0) begin
       end else begin
           wt3_sd_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[3] & wt_pre_nz[4]) == 1'b1) begin
           wt3_sd_data[39:32] <= wt_pre_data[39:32] ;
       // VCS coverage off
       end else if ((wt_pre_sel[3] & wt_pre_nz[4]) == 1'b0) begin
       end else begin
           wt3_sd_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[3] & wt_pre_nz[5]) == 1'b1) begin
           wt3_sd_data[47:40] <= wt_pre_data[47:40] ;
       // VCS coverage off
       end else if ((wt_pre_sel[3] & wt_pre_nz[5]) == 1'b0) begin
       end else begin
           wt3_sd_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[3] & wt_pre_nz[6]) == 1'b1) begin
           wt3_sd_data[55:48] <= wt_pre_data[55:48] ;
       // VCS coverage off
       end else if ((wt_pre_sel[3] & wt_pre_nz[6]) == 1'b0) begin
       end else begin
           wt3_sd_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((wt_pre_sel[3] & wt_pre_nz[7]) == 1'b1) begin
           wt3_sd_data[63:56] <= wt_pre_data[63:56] ;
       // VCS coverage off
       end else if ((wt_pre_sel[3] & wt_pre_nz[7]) == 1'b0) begin
       end else begin
           wt3_sd_data[63:56] <= 'bx;
       // VCS coverage on
       end
end
reg  dat_actv_stripe_end;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_stripe_end <= 'b0;
   end else begin
       dat_actv_stripe_end <= dat_pre_stripe_end;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// pop weight from shadow when new stripe begin.
//: for(my $i = 0; $i < 8/2; $i ++) {
//: print qq {
//: reg wt${i}_actv_vld;
//: reg [8*8 -1:0] wt${i}_actv_data;
//: wire wt${i}_actv_pvld_w = dat_pre_stripe_st ? wt${i}_sd_pvld : dat_actv_stripe_end ? 1'b0 : wt${i}_actv_vld;
//: };
//: my $cmac_atomc = 8;
//: &eperl::flop(" -q  wt${i}_actv_vld   -d \"wt${i}_actv_pvld_w\" -clk nvdla_core_clk -rst nvdla_core_rstn -nodeclare");
//: &eperl::flop(" -q  wt${i}_actv_pvld  -d \"{${cmac_atomc}{wt${i}_actv_pvld_w}}\" -clk nvdla_core_clk -rst nvdla_core_rstn -wid ${cmac_atomc}");
//: &eperl::flop(" -q  wt${i}_actv_nz    -en \"dat_pre_stripe_st & wt${i}_actv_pvld_w\" -d  \"wt${i}_sd_nz\" -clk nvdla_core_clk -rst nvdla_core_rstn -wid ${cmac_atomc}");
//:
//: for(my $k = 0; $k < 8; $k ++) {
//: my $b0 = $k * 8;
//: my $b1 = $k * 8 + 7;
//: &eperl::flop("-nodeclare -norst -q  wt${i}_actv_data[${b1}:${b0}]  -en \"dat_pre_stripe_st & wt${i}_actv_pvld_w\" -d  \"{8{wt${i}_sd_nz[${k}]}} & wt${i}_sd_data[${b1}:${b0}]\" -clk nvdla_core_clk");
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

reg wt0_actv_vld;
reg [8*8 -1:0] wt0_actv_data;
wire wt0_actv_pvld_w = dat_pre_stripe_st ? wt0_sd_pvld : dat_actv_stripe_end ? 1'b0 : wt0_actv_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt0_actv_vld <= 'b0;
   end else begin
       wt0_actv_vld <= wt0_actv_pvld_w;
   end
end
reg [7:0] wt0_actv_pvld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt0_actv_pvld <= 'b0;
   end else begin
       wt0_actv_pvld <= {8{wt0_actv_pvld_w}};
   end
end
reg [7:0] wt0_actv_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt0_actv_nz <= 'b0;
   end else begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_nz <= wt0_sd_nz;
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_nz <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_data[7:0] <= {8{wt0_sd_nz[0]}} & wt0_sd_data[7:0];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_data[15:8] <= {8{wt0_sd_nz[1]}} & wt0_sd_data[15:8];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_data[23:16] <= {8{wt0_sd_nz[2]}} & wt0_sd_data[23:16];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_data[31:24] <= {8{wt0_sd_nz[3]}} & wt0_sd_data[31:24];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_data[39:32] <= {8{wt0_sd_nz[4]}} & wt0_sd_data[39:32];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_data[47:40] <= {8{wt0_sd_nz[5]}} & wt0_sd_data[47:40];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_data[55:48] <= {8{wt0_sd_nz[6]}} & wt0_sd_data[55:48];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b1) begin
           wt0_actv_data[63:56] <= {8{wt0_sd_nz[7]}} & wt0_sd_data[63:56];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt0_actv_pvld_w) == 1'b0) begin
       end else begin
           wt0_actv_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

reg wt1_actv_vld;
reg [8*8 -1:0] wt1_actv_data;
wire wt1_actv_pvld_w = dat_pre_stripe_st ? wt1_sd_pvld : dat_actv_stripe_end ? 1'b0 : wt1_actv_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt1_actv_vld <= 'b0;
   end else begin
       wt1_actv_vld <= wt1_actv_pvld_w;
   end
end
reg [7:0] wt1_actv_pvld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt1_actv_pvld <= 'b0;
   end else begin
       wt1_actv_pvld <= {8{wt1_actv_pvld_w}};
   end
end
reg [7:0] wt1_actv_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt1_actv_nz <= 'b0;
   end else begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_nz <= wt1_sd_nz;
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_nz <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_data[7:0] <= {8{wt1_sd_nz[0]}} & wt1_sd_data[7:0];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_data[15:8] <= {8{wt1_sd_nz[1]}} & wt1_sd_data[15:8];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_data[23:16] <= {8{wt1_sd_nz[2]}} & wt1_sd_data[23:16];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_data[31:24] <= {8{wt1_sd_nz[3]}} & wt1_sd_data[31:24];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_data[39:32] <= {8{wt1_sd_nz[4]}} & wt1_sd_data[39:32];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_data[47:40] <= {8{wt1_sd_nz[5]}} & wt1_sd_data[47:40];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_data[55:48] <= {8{wt1_sd_nz[6]}} & wt1_sd_data[55:48];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b1) begin
           wt1_actv_data[63:56] <= {8{wt1_sd_nz[7]}} & wt1_sd_data[63:56];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt1_actv_pvld_w) == 1'b0) begin
       end else begin
           wt1_actv_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

reg wt2_actv_vld;
reg [8*8 -1:0] wt2_actv_data;
wire wt2_actv_pvld_w = dat_pre_stripe_st ? wt2_sd_pvld : dat_actv_stripe_end ? 1'b0 : wt2_actv_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt2_actv_vld <= 'b0;
   end else begin
       wt2_actv_vld <= wt2_actv_pvld_w;
   end
end
reg [7:0] wt2_actv_pvld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt2_actv_pvld <= 'b0;
   end else begin
       wt2_actv_pvld <= {8{wt2_actv_pvld_w}};
   end
end
reg [7:0] wt2_actv_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt2_actv_nz <= 'b0;
   end else begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_nz <= wt2_sd_nz;
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_nz <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_data[7:0] <= {8{wt2_sd_nz[0]}} & wt2_sd_data[7:0];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_data[15:8] <= {8{wt2_sd_nz[1]}} & wt2_sd_data[15:8];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_data[23:16] <= {8{wt2_sd_nz[2]}} & wt2_sd_data[23:16];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_data[31:24] <= {8{wt2_sd_nz[3]}} & wt2_sd_data[31:24];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_data[39:32] <= {8{wt2_sd_nz[4]}} & wt2_sd_data[39:32];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_data[47:40] <= {8{wt2_sd_nz[5]}} & wt2_sd_data[47:40];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_data[55:48] <= {8{wt2_sd_nz[6]}} & wt2_sd_data[55:48];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b1) begin
           wt2_actv_data[63:56] <= {8{wt2_sd_nz[7]}} & wt2_sd_data[63:56];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt2_actv_pvld_w) == 1'b0) begin
       end else begin
           wt2_actv_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

reg wt3_actv_vld;
reg [8*8 -1:0] wt3_actv_data;
wire wt3_actv_pvld_w = dat_pre_stripe_st ? wt3_sd_pvld : dat_actv_stripe_end ? 1'b0 : wt3_actv_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt3_actv_vld <= 'b0;
   end else begin
       wt3_actv_vld <= wt3_actv_pvld_w;
   end
end
reg [7:0] wt3_actv_pvld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt3_actv_pvld <= 'b0;
   end else begin
       wt3_actv_pvld <= {8{wt3_actv_pvld_w}};
   end
end
reg [7:0] wt3_actv_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wt3_actv_nz <= 'b0;
   end else begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_nz <= wt3_sd_nz;
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_nz <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_data[7:0] <= {8{wt3_sd_nz[0]}} & wt3_sd_data[7:0];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_data[15:8] <= {8{wt3_sd_nz[1]}} & wt3_sd_data[15:8];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_data[23:16] <= {8{wt3_sd_nz[2]}} & wt3_sd_data[23:16];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_data[31:24] <= {8{wt3_sd_nz[3]}} & wt3_sd_data[31:24];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_data[39:32] <= {8{wt3_sd_nz[4]}} & wt3_sd_data[39:32];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_data[47:40] <= {8{wt3_sd_nz[5]}} & wt3_sd_data[47:40];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_data[55:48] <= {8{wt3_sd_nz[6]}} & wt3_sd_data[55:48];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b1) begin
           wt3_actv_data[63:56] <= {8{wt3_sd_nz[7]}} & wt3_sd_data[63:56];
       // VCS coverage off
       end else if ((dat_pre_stripe_st & wt3_actv_pvld_w) == 1'b0) begin
       end else begin
           wt3_actv_data[63:56] <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////// handle data ///////////////
// data pack
//: print "assign    dat_pre_data_w  = {";
//: for(my $i = 8 -1; $i >= 0; $i --) {
//: print "in_dat_data${i}";
//: if($i == 0) {
//: print "};\n";
//: } elsif ($i % 8 == 0) {
//: print ",\n                       ";
//: } else {
//: print ", ";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign    dat_pre_data_w  = {in_dat_data7, in_dat_data6, in_dat_data5, in_dat_data4, in_dat_data3, in_dat_data2, in_dat_data1, in_dat_data0};

//| eperl: generated_end (DO NOT EDIT ABOVE)
// data mask pack
//: print "assign    dat_pre_mask_w = {";
//: for(my $i = 8 -1; $i >= 0; $i --) {
//: print "in_dat_mask[${i}]";
//: if($i == 0) {
//: print "};\n";
//: } elsif ($i % 8 == 0) {
//: print ",\n                       ";
//: } else {
//: print ", ";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign    dat_pre_mask_w = {in_dat_mask[7], in_dat_mask[6], in_dat_mask[5], in_dat_mask[4], in_dat_mask[3], in_dat_mask[2], in_dat_mask[1], in_dat_mask[0]};

//| eperl: generated_end (DO NOT EDIT ABOVE)
// 1 pipe for input data
//: my $kk= 8;
//: &eperl::flop(" -q  dat_pre_pvld   -d \"in_dat_pvld\"  -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop(" -q  dat_pre_nz     -en \"in_dat_pvld\" -d  \"dat_pre_mask_w\" -wid ${kk} -clk nvdla_core_clk -rst nvdla_core_rstn");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  dat_pre_pvld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_pre_pvld <= 'b0;
   end else begin
       dat_pre_pvld <= in_dat_pvld;
   end
end
reg [7:0] dat_pre_nz;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_pre_nz <= 'b0;
   end else begin
       if ((in_dat_pvld) == 1'b1) begin
           dat_pre_nz <= dat_pre_mask_w;
       // VCS coverage off
       end else if ((in_dat_pvld) == 1'b0) begin
       end else begin
           dat_pre_nz <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [8*8 -1:0] dat_pre_data;
//: for (my $i = 0; $i < 8; $i ++) {
//: my $b0 = $i * 8;
//: my $b1 = $i * 8 + 7;
//: &eperl::flop("-nodeclare -norst -q  dat_pre_data[${b1}:${b0}]  -en \"in_dat_pvld & dat_pre_mask_w[${i}]\" -d  \"dat_pre_data_w[${b1}:${b0}]\" -clk nvdla_core_clk");
//: }
//: &eperl::flop("-nodeclare -q  dat_pre_stripe_st   -d  \"in_dat_stripe_st & in_dat_pvld\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop("-nodeclare -q  dat_pre_stripe_end  -d  \"in_dat_stripe_end & in_dat_pvld \" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: for(my $i = 0; $i < 8/2; $i ++) {
//: print qq {
//: assign dat${i}_pre_pvld = dat_pre_pvld;
//: assign dat${i}_pre_stripe_st = dat_pre_stripe_st;
//: assign dat${i}_pre_stripe_end = dat_pre_stripe_end;
//: };
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk) begin
       if ((in_dat_pvld & dat_pre_mask_w[0]) == 1'b1) begin
           dat_pre_data[7:0] <= dat_pre_data_w[7:0];
       // VCS coverage off
       end else if ((in_dat_pvld & dat_pre_mask_w[0]) == 1'b0) begin
       end else begin
           dat_pre_data[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_dat_pvld & dat_pre_mask_w[1]) == 1'b1) begin
           dat_pre_data[15:8] <= dat_pre_data_w[15:8];
       // VCS coverage off
       end else if ((in_dat_pvld & dat_pre_mask_w[1]) == 1'b0) begin
       end else begin
           dat_pre_data[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_dat_pvld & dat_pre_mask_w[2]) == 1'b1) begin
           dat_pre_data[23:16] <= dat_pre_data_w[23:16];
       // VCS coverage off
       end else if ((in_dat_pvld & dat_pre_mask_w[2]) == 1'b0) begin
       end else begin
           dat_pre_data[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_dat_pvld & dat_pre_mask_w[3]) == 1'b1) begin
           dat_pre_data[31:24] <= dat_pre_data_w[31:24];
       // VCS coverage off
       end else if ((in_dat_pvld & dat_pre_mask_w[3]) == 1'b0) begin
       end else begin
           dat_pre_data[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_dat_pvld & dat_pre_mask_w[4]) == 1'b1) begin
           dat_pre_data[39:32] <= dat_pre_data_w[39:32];
       // VCS coverage off
       end else if ((in_dat_pvld & dat_pre_mask_w[4]) == 1'b0) begin
       end else begin
           dat_pre_data[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_dat_pvld & dat_pre_mask_w[5]) == 1'b1) begin
           dat_pre_data[47:40] <= dat_pre_data_w[47:40];
       // VCS coverage off
       end else if ((in_dat_pvld & dat_pre_mask_w[5]) == 1'b0) begin
       end else begin
           dat_pre_data[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_dat_pvld & dat_pre_mask_w[6]) == 1'b1) begin
           dat_pre_data[55:48] <= dat_pre_data_w[55:48];
       // VCS coverage off
       end else if ((in_dat_pvld & dat_pre_mask_w[6]) == 1'b0) begin
       end else begin
           dat_pre_data[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((in_dat_pvld & dat_pre_mask_w[7]) == 1'b1) begin
           dat_pre_data[63:56] <= dat_pre_data_w[63:56];
       // VCS coverage off
       end else if ((in_dat_pvld & dat_pre_mask_w[7]) == 1'b0) begin
       end else begin
           dat_pre_data[63:56] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_pre_stripe_st <= 'b0;
   end else begin
       dat_pre_stripe_st <= in_dat_stripe_st & in_dat_pvld;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_pre_stripe_end <= 'b0;
   end else begin
       dat_pre_stripe_end <= in_dat_stripe_end & in_dat_pvld ;
   end
end

assign dat0_pre_pvld = dat_pre_pvld;
assign dat0_pre_stripe_st = dat_pre_stripe_st;
assign dat0_pre_stripe_end = dat_pre_stripe_end;

assign dat1_pre_pvld = dat_pre_pvld;
assign dat1_pre_stripe_st = dat_pre_stripe_st;
assign dat1_pre_stripe_end = dat_pre_stripe_end;

assign dat2_pre_pvld = dat_pre_pvld;
assign dat2_pre_stripe_st = dat_pre_stripe_st;
assign dat2_pre_stripe_end = dat_pre_stripe_end;

assign dat3_pre_pvld = dat_pre_pvld;
assign dat3_pre_stripe_st = dat_pre_stripe_st;
assign dat3_pre_stripe_end = dat_pre_stripe_end;

//| eperl: generated_end (DO NOT EDIT ABOVE)
// get data for cmac, 1 pipe.
//: my $atomc= 8;
//: for(my $i = 0; $i < 8/2; $i ++) {
//: my $l = $i + 8;
//: &eperl::flop(" -q  dat_actv_pvld_reg${i}  -d \"{${atomc}{dat_pre_pvld}}\" -wid ${atomc} -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop(" -q  dat_actv_nz_reg${i}    -en dat_pre_pvld -d  dat_pre_nz -wid $atomc -clk nvdla_core_clk -rst nvdla_core_rstn");
//: for(my $k = 0; $k < 8; $k ++) {
//: my $j = int($k/2);
//: my $b0 = $k * 8;
//: my $b1 = $k * 8 + 7;
//: &eperl::flop("-nodeclare -norst -q  dat_actv_data_reg${i}[${b1}:${b0}]  -en \"dat_pre_pvld & dat_pre_nz[${k}]\" -d  \"dat_pre_data[${b1}:${b0}]\" -clk nvdla_core_clk");
//: }
//: }
//: for(my $i = 0; $i < 8/2; $i ++) {
//: print qq {
//: assign dat${i}_actv_pvld = dat_actv_pvld_reg${i};
//: assign dat${i}_actv_data = dat_actv_data_reg${i};
//: assign dat${i}_actv_nz = dat_actv_nz_reg${i};
//: };
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [7:0] dat_actv_pvld_reg0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_pvld_reg0 <= 'b0;
   end else begin
       dat_actv_pvld_reg0 <= {8{dat_pre_pvld}};
   end
end
reg [7:0] dat_actv_nz_reg0;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_nz_reg0 <= 'b0;
   end else begin
       if ((dat_pre_pvld) == 1'b1) begin
           dat_actv_nz_reg0 <= dat_pre_nz;
       // VCS coverage off
       end else if ((dat_pre_pvld) == 1'b0) begin
       end else begin
           dat_actv_nz_reg0 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[0]) == 1'b1) begin
           dat_actv_data_reg0[7:0] <= dat_pre_data[7:0];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[0]) == 1'b0) begin
       end else begin
           dat_actv_data_reg0[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[1]) == 1'b1) begin
           dat_actv_data_reg0[15:8] <= dat_pre_data[15:8];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[1]) == 1'b0) begin
       end else begin
           dat_actv_data_reg0[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[2]) == 1'b1) begin
           dat_actv_data_reg0[23:16] <= dat_pre_data[23:16];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[2]) == 1'b0) begin
       end else begin
           dat_actv_data_reg0[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[3]) == 1'b1) begin
           dat_actv_data_reg0[31:24] <= dat_pre_data[31:24];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[3]) == 1'b0) begin
       end else begin
           dat_actv_data_reg0[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[4]) == 1'b1) begin
           dat_actv_data_reg0[39:32] <= dat_pre_data[39:32];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[4]) == 1'b0) begin
       end else begin
           dat_actv_data_reg0[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[5]) == 1'b1) begin
           dat_actv_data_reg0[47:40] <= dat_pre_data[47:40];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[5]) == 1'b0) begin
       end else begin
           dat_actv_data_reg0[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[6]) == 1'b1) begin
           dat_actv_data_reg0[55:48] <= dat_pre_data[55:48];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[6]) == 1'b0) begin
       end else begin
           dat_actv_data_reg0[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[7]) == 1'b1) begin
           dat_actv_data_reg0[63:56] <= dat_pre_data[63:56];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[7]) == 1'b0) begin
       end else begin
           dat_actv_data_reg0[63:56] <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dat_actv_pvld_reg1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_pvld_reg1 <= 'b0;
   end else begin
       dat_actv_pvld_reg1 <= {8{dat_pre_pvld}};
   end
end
reg [7:0] dat_actv_nz_reg1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_nz_reg1 <= 'b0;
   end else begin
       if ((dat_pre_pvld) == 1'b1) begin
           dat_actv_nz_reg1 <= dat_pre_nz;
       // VCS coverage off
       end else if ((dat_pre_pvld) == 1'b0) begin
       end else begin
           dat_actv_nz_reg1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[0]) == 1'b1) begin
           dat_actv_data_reg1[7:0] <= dat_pre_data[7:0];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[0]) == 1'b0) begin
       end else begin
           dat_actv_data_reg1[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[1]) == 1'b1) begin
           dat_actv_data_reg1[15:8] <= dat_pre_data[15:8];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[1]) == 1'b0) begin
       end else begin
           dat_actv_data_reg1[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[2]) == 1'b1) begin
           dat_actv_data_reg1[23:16] <= dat_pre_data[23:16];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[2]) == 1'b0) begin
       end else begin
           dat_actv_data_reg1[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[3]) == 1'b1) begin
           dat_actv_data_reg1[31:24] <= dat_pre_data[31:24];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[3]) == 1'b0) begin
       end else begin
           dat_actv_data_reg1[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[4]) == 1'b1) begin
           dat_actv_data_reg1[39:32] <= dat_pre_data[39:32];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[4]) == 1'b0) begin
       end else begin
           dat_actv_data_reg1[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[5]) == 1'b1) begin
           dat_actv_data_reg1[47:40] <= dat_pre_data[47:40];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[5]) == 1'b0) begin
       end else begin
           dat_actv_data_reg1[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[6]) == 1'b1) begin
           dat_actv_data_reg1[55:48] <= dat_pre_data[55:48];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[6]) == 1'b0) begin
       end else begin
           dat_actv_data_reg1[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[7]) == 1'b1) begin
           dat_actv_data_reg1[63:56] <= dat_pre_data[63:56];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[7]) == 1'b0) begin
       end else begin
           dat_actv_data_reg1[63:56] <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dat_actv_pvld_reg2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_pvld_reg2 <= 'b0;
   end else begin
       dat_actv_pvld_reg2 <= {8{dat_pre_pvld}};
   end
end
reg [7:0] dat_actv_nz_reg2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_nz_reg2 <= 'b0;
   end else begin
       if ((dat_pre_pvld) == 1'b1) begin
           dat_actv_nz_reg2 <= dat_pre_nz;
       // VCS coverage off
       end else if ((dat_pre_pvld) == 1'b0) begin
       end else begin
           dat_actv_nz_reg2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[0]) == 1'b1) begin
           dat_actv_data_reg2[7:0] <= dat_pre_data[7:0];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[0]) == 1'b0) begin
       end else begin
           dat_actv_data_reg2[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[1]) == 1'b1) begin
           dat_actv_data_reg2[15:8] <= dat_pre_data[15:8];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[1]) == 1'b0) begin
       end else begin
           dat_actv_data_reg2[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[2]) == 1'b1) begin
           dat_actv_data_reg2[23:16] <= dat_pre_data[23:16];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[2]) == 1'b0) begin
       end else begin
           dat_actv_data_reg2[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[3]) == 1'b1) begin
           dat_actv_data_reg2[31:24] <= dat_pre_data[31:24];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[3]) == 1'b0) begin
       end else begin
           dat_actv_data_reg2[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[4]) == 1'b1) begin
           dat_actv_data_reg2[39:32] <= dat_pre_data[39:32];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[4]) == 1'b0) begin
       end else begin
           dat_actv_data_reg2[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[5]) == 1'b1) begin
           dat_actv_data_reg2[47:40] <= dat_pre_data[47:40];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[5]) == 1'b0) begin
       end else begin
           dat_actv_data_reg2[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[6]) == 1'b1) begin
           dat_actv_data_reg2[55:48] <= dat_pre_data[55:48];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[6]) == 1'b0) begin
       end else begin
           dat_actv_data_reg2[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[7]) == 1'b1) begin
           dat_actv_data_reg2[63:56] <= dat_pre_data[63:56];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[7]) == 1'b0) begin
       end else begin
           dat_actv_data_reg2[63:56] <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] dat_actv_pvld_reg3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_pvld_reg3 <= 'b0;
   end else begin
       dat_actv_pvld_reg3 <= {8{dat_pre_pvld}};
   end
end
reg [7:0] dat_actv_nz_reg3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dat_actv_nz_reg3 <= 'b0;
   end else begin
       if ((dat_pre_pvld) == 1'b1) begin
           dat_actv_nz_reg3 <= dat_pre_nz;
       // VCS coverage off
       end else if ((dat_pre_pvld) == 1'b0) begin
       end else begin
           dat_actv_nz_reg3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[0]) == 1'b1) begin
           dat_actv_data_reg3[7:0] <= dat_pre_data[7:0];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[0]) == 1'b0) begin
       end else begin
           dat_actv_data_reg3[7:0] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[1]) == 1'b1) begin
           dat_actv_data_reg3[15:8] <= dat_pre_data[15:8];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[1]) == 1'b0) begin
       end else begin
           dat_actv_data_reg3[15:8] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[2]) == 1'b1) begin
           dat_actv_data_reg3[23:16] <= dat_pre_data[23:16];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[2]) == 1'b0) begin
       end else begin
           dat_actv_data_reg3[23:16] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[3]) == 1'b1) begin
           dat_actv_data_reg3[31:24] <= dat_pre_data[31:24];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[3]) == 1'b0) begin
       end else begin
           dat_actv_data_reg3[31:24] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[4]) == 1'b1) begin
           dat_actv_data_reg3[39:32] <= dat_pre_data[39:32];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[4]) == 1'b0) begin
       end else begin
           dat_actv_data_reg3[39:32] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[5]) == 1'b1) begin
           dat_actv_data_reg3[47:40] <= dat_pre_data[47:40];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[5]) == 1'b0) begin
       end else begin
           dat_actv_data_reg3[47:40] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[6]) == 1'b1) begin
           dat_actv_data_reg3[55:48] <= dat_pre_data[55:48];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[6]) == 1'b0) begin
       end else begin
           dat_actv_data_reg3[55:48] <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((dat_pre_pvld & dat_pre_nz[7]) == 1'b1) begin
           dat_actv_data_reg3[63:56] <= dat_pre_data[63:56];
       // VCS coverage off
       end else if ((dat_pre_pvld & dat_pre_nz[7]) == 1'b0) begin
       end else begin
           dat_actv_data_reg3[63:56] <= 'bx;
       // VCS coverage on
       end
end

assign dat0_actv_pvld = dat_actv_pvld_reg0;
assign dat0_actv_data = dat_actv_data_reg0;
assign dat0_actv_nz = dat_actv_nz_reg0;

assign dat1_actv_pvld = dat_actv_pvld_reg1;
assign dat1_actv_data = dat_actv_data_reg1;
assign dat1_actv_nz = dat_actv_nz_reg1;

assign dat2_actv_pvld = dat_actv_pvld_reg2;
assign dat2_actv_data = dat_actv_data_reg2;
assign dat2_actv_nz = dat_actv_nz_reg2;

assign dat3_actv_pvld = dat_actv_pvld_reg3;
assign dat3_actv_data = dat_actv_data_reg3;
assign dat3_actv_nz = dat_actv_nz_reg3;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
