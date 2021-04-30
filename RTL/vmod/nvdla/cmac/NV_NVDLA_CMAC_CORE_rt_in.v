// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC_CORE_rt_in.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC.h
`define DESIGNWARE_NOEXIST 1
module NV_NVDLA_CMAC_CORE_rt_in (
   nvdla_core_clk
  ,nvdla_core_rstn
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: ,sc2mac_dat_data${i});
//: }
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: ,in_dat_data${i});
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,sc2mac_dat_data0
,sc2mac_dat_data1
,sc2mac_dat_data2
,sc2mac_dat_data3
,sc2mac_dat_data4
,sc2mac_dat_data5
,sc2mac_dat_data6
,sc2mac_dat_data7
,in_dat_data0
,in_dat_data1
,in_dat_data2
,in_dat_data3
,in_dat_data4
,in_dat_data5
,in_dat_data6
,in_dat_data7
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_dat_mask
  ,sc2mac_dat_pd
  ,sc2mac_dat_pvld
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: ,sc2mac_wt_data${i});
//: }
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: ,in_wt_data${i});
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,sc2mac_wt_data0
,sc2mac_wt_data1
,sc2mac_wt_data2
,sc2mac_wt_data3
,sc2mac_wt_data4
,sc2mac_wt_data5
,sc2mac_wt_data6
,sc2mac_wt_data7
,in_wt_data0
,in_wt_data1
,in_wt_data2
,in_wt_data3
,in_wt_data4
,in_wt_data5
,in_wt_data6
,in_wt_data7
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_wt_mask
  ,sc2mac_wt_pvld
  ,sc2mac_wt_sel
  ,in_dat_mask
  ,in_dat_pd
  ,in_dat_pvld
  ,in_dat_stripe_end
  ,in_dat_stripe_st
  ,in_wt_mask
  ,in_wt_pvld
  ,in_wt_sel
  );
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: input [8 -1:0] sc2mac_dat_data${i};);
//: }
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: output [8 -1:0] in_dat_data${i};);
//: }
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: input [8 -1:0] sc2mac_wt_data${i};);
//: }
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: output [8 -1:0] in_wt_data${i};);
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
output [8 -1:0] in_dat_data0;
output [8 -1:0] in_dat_data1;
output [8 -1:0] in_dat_data2;
output [8 -1:0] in_dat_data3;
output [8 -1:0] in_dat_data4;
output [8 -1:0] in_dat_data5;
output [8 -1:0] in_dat_data6;
output [8 -1:0] in_dat_data7;
input [8 -1:0] sc2mac_wt_data0;
input [8 -1:0] sc2mac_wt_data1;
input [8 -1:0] sc2mac_wt_data2;
input [8 -1:0] sc2mac_wt_data3;
input [8 -1:0] sc2mac_wt_data4;
input [8 -1:0] sc2mac_wt_data5;
input [8 -1:0] sc2mac_wt_data6;
input [8 -1:0] sc2mac_wt_data7;
output [8 -1:0] in_wt_data0;
output [8 -1:0] in_wt_data1;
output [8 -1:0] in_wt_data2;
output [8 -1:0] in_wt_data3;
output [8 -1:0] in_wt_data4;
output [8 -1:0] in_wt_data5;
output [8 -1:0] in_wt_data6;
output [8 -1:0] in_wt_data7;
//| eperl: generated_end (DO NOT EDIT ABOVE)
input nvdla_core_clk;
input nvdla_core_rstn;
input [8 -1:0] sc2mac_dat_mask;
input [8:0] sc2mac_dat_pd;
input sc2mac_dat_pvld;
input [8 -1:0] sc2mac_wt_mask;
input sc2mac_wt_pvld;
input [8/2 -1:0] sc2mac_wt_sel;
output [8 -1:0] in_dat_mask;
output [8:0] in_dat_pd;
output in_dat_pvld;
output in_dat_stripe_end;
output in_dat_stripe_st;
output [8 -1:0] in_wt_mask;
output in_wt_pvld;
output [8/2 -1:0] in_wt_sel;
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: wire [8 -1:0] in_dat_data${i};
//: wire [8 -1:0] in_wt_data${i};)
//: }
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
//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8 -1:0] in_dat_mask;
wire [8:0] in_dat_pd;
wire in_dat_pvld;
wire in_dat_stripe_end;
wire in_dat_stripe_st;
wire [8 -1:0] in_wt_mask;
wire in_wt_pvld;
wire [8/2 -1:0] in_wt_sel;
wire in_rt_dat_pvld_d0;
wire [8 -1:0] in_rt_dat_mask_d0;
wire [8:0] in_rt_dat_pd_d0;
wire [8*8 -1:0] in_rt_dat_data_d0;
//: for(my $i=1; $i<2 +1; $i++){
//: print qq(
//: reg in_rt_dat_pvld_d${i};
//: reg [8 -1:0] in_rt_dat_mask_d${i};
//: reg [8:0] in_rt_dat_pd_d${i};
//: reg [8*8 -1:0] in_rt_dat_data_d${i};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

reg in_rt_dat_pvld_d1;
reg [8 -1:0] in_rt_dat_mask_d1;
reg [8:0] in_rt_dat_pd_d1;
reg [8*8 -1:0] in_rt_dat_data_d1;

reg in_rt_dat_pvld_d2;
reg [8 -1:0] in_rt_dat_mask_d2;
reg [8:0] in_rt_dat_pd_d2;
reg [8*8 -1:0] in_rt_dat_data_d2;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8*8 -1:0] in_rt_wt_data_d0;
wire [8 -1:0] in_rt_wt_mask_d0;
wire in_rt_wt_pvld_d0;
wire [8/2 -1:0] in_rt_wt_sel_d0;
//: for(my $i=1; $i<2 +1; $i++){
//: print qq(
//: reg [8*8 -1:0] in_rt_wt_data_d${i};
//: reg [8 -1:0] in_rt_wt_mask_d${i};
//: reg in_rt_wt_pvld_d${i};
//: reg [8/2 -1:0] in_rt_wt_sel_d${i};
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

reg [8*8 -1:0] in_rt_wt_data_d1;
reg [8 -1:0] in_rt_wt_mask_d1;
reg in_rt_wt_pvld_d1;
reg [8/2 -1:0] in_rt_wt_sel_d1;

reg [8*8 -1:0] in_rt_wt_data_d2;
reg [8 -1:0] in_rt_wt_mask_d2;
reg in_rt_wt_pvld_d2;
reg [8/2 -1:0] in_rt_wt_sel_d2;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign in_rt_dat_pvld_d0 = sc2mac_dat_pvld;
assign in_rt_dat_mask_d0 = sc2mac_dat_mask;
assign in_rt_dat_pd_d0 = sc2mac_dat_pd;
assign in_rt_wt_pvld_d0 = sc2mac_wt_pvld;
assign in_rt_wt_mask_d0 = sc2mac_wt_mask;
assign in_rt_wt_sel_d0 = sc2mac_wt_sel;
//: my $kk=8;
//: for(my $k = 0; $k <8; $k ++) {
//: print "wire [$kk-1:0]  in_rt_dat_data${k}_d0 = sc2mac_dat_data${k}; \n";
//: }
//: for(my $k = 0; $k <8; $k ++) {
//: print "wire [$kk-1:0]  in_rt_wt_data${k}_d0 = sc2mac_wt_data${k}; \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [8-1:0]  in_rt_dat_data0_d0 = sc2mac_dat_data0; 
wire [8-1:0]  in_rt_dat_data1_d0 = sc2mac_dat_data1; 
wire [8-1:0]  in_rt_dat_data2_d0 = sc2mac_dat_data2; 
wire [8-1:0]  in_rt_dat_data3_d0 = sc2mac_dat_data3; 
wire [8-1:0]  in_rt_dat_data4_d0 = sc2mac_dat_data4; 
wire [8-1:0]  in_rt_dat_data5_d0 = sc2mac_dat_data5; 
wire [8-1:0]  in_rt_dat_data6_d0 = sc2mac_dat_data6; 
wire [8-1:0]  in_rt_dat_data7_d0 = sc2mac_dat_data7; 
wire [8-1:0]  in_rt_wt_data0_d0 = sc2mac_wt_data0; 
wire [8-1:0]  in_rt_wt_data1_d0 = sc2mac_wt_data1; 
wire [8-1:0]  in_rt_wt_data2_d0 = sc2mac_wt_data2; 
wire [8-1:0]  in_rt_wt_data3_d0 = sc2mac_wt_data3; 
wire [8-1:0]  in_rt_wt_data4_d0 = sc2mac_wt_data4; 
wire [8-1:0]  in_rt_wt_data5_d0 = sc2mac_wt_data5; 
wire [8-1:0]  in_rt_wt_data6_d0 = sc2mac_wt_data6; 
wire [8-1:0]  in_rt_wt_data7_d0 = sc2mac_wt_data7; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//==========================================================
// Retiming flops,add latency.
//==========================================================
//: my $latency = 2;
//: my $bpe=8;
//: for(my $i = 0; $i < $latency; $i ++) {
//: my $j = $i + 1;
//: &eperl::flop("-nodeclare -q  in_rt_dat_pvld_d${j}  -d \"in_rt_dat_pvld_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop("-nodeclare -q  in_rt_dat_mask_d${j}  -en \"in_rt_dat_pvld_d${i} | in_rt_dat_pvld_d${j}\" -d  \"in_rt_dat_mask_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop("-nodeclare -q  in_rt_dat_pd_d${j}    -en \"in_rt_dat_pvld_d${i} | in_rt_dat_pvld_d${j}\" -d  \"in_rt_dat_pd_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: for(my $k = 0; $k <8; $k ++) {
//: &eperl::flop("-norst -wid $bpe -q  in_rt_dat_data${k}_d${j}  -en \"in_rt_dat_mask_d${i}[${k}]\" -d  \"in_rt_dat_data${k}_d${i}\" -clk nvdla_core_clk");
//: }
//:
//: &eperl::flop("-nodeclare -q  in_rt_wt_pvld_d${j}  -d \"in_rt_wt_pvld_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop("-nodeclare -q  in_rt_wt_mask_d${j}  -en \"in_rt_wt_pvld_d${i} | in_rt_wt_pvld_d${j}\" -d  \"in_rt_wt_mask_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop("-nodeclare -q  in_rt_wt_sel_d${j} -en \"in_rt_wt_pvld_d${i} | in_rt_wt_pvld_d${j}\" -d  \"in_rt_wt_sel_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//:
//: my $bpe = 8;
//: for(my $k = 0; $k <8; $k ++) {
//: &eperl::flop("-norst -wid $bpe -q  in_rt_wt_data${k}_d${j}  -en \"in_rt_wt_mask_d${i}[${k}]\" -d  \"in_rt_wt_data${k}_d${i}\" -clk nvdla_core_clk");
//: }
//: }
//:
//: my $i = $latency;
//: print "assign    in_dat_pvld = in_rt_dat_pvld_d${i};\n";
//: print "assign    in_dat_mask = in_rt_dat_mask_d${i};\n";
//: print "assign    in_dat_pd   = in_rt_dat_pd_d${i};\n";
//: print "assign    in_wt_pvld = in_rt_wt_pvld_d${i};\n";
//: print "assign    in_wt_mask = in_rt_wt_mask_d${i};\n";
//: print "assign    in_wt_sel = in_rt_wt_sel_d${i};\n";
//:
//: my $k=$latency;
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: assign in_dat_data${i} = in_rt_dat_data${i}_d${k}; )
//: }
//: for(my $i=0; $i<8; $i++){
//: print qq(
//: assign in_wt_data${i} = in_rt_wt_data${i}_d${k};)
//: }
//: my $i= 5;
//: my $j= 6;
//: print qq(
//: assign in_dat_stripe_st = in_dat_pd[${i}];
//: assign in_dat_stripe_end = in_dat_pd[${j}]; );
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_dat_pvld_d1 <= 'b0;
   end else begin
       in_rt_dat_pvld_d1 <= in_rt_dat_pvld_d0;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_dat_mask_d1 <= 'b0;
   end else begin
       if ((in_rt_dat_pvld_d0 | in_rt_dat_pvld_d1) == 1'b1) begin
           in_rt_dat_mask_d1 <= in_rt_dat_mask_d0;
       // VCS coverage off
       end else if ((in_rt_dat_pvld_d0 | in_rt_dat_pvld_d1) == 1'b0) begin
       end else begin
           in_rt_dat_mask_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_dat_pd_d1 <= 'b0;
   end else begin
       if ((in_rt_dat_pvld_d0 | in_rt_dat_pvld_d1) == 1'b1) begin
           in_rt_dat_pd_d1 <= in_rt_dat_pd_d0;
       // VCS coverage off
       end else if ((in_rt_dat_pvld_d0 | in_rt_dat_pvld_d1) == 1'b0) begin
       end else begin
           in_rt_dat_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] in_rt_dat_data0_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d0[0]) == 1'b1) begin
           in_rt_dat_data0_d1 <= in_rt_dat_data0_d0;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d0[0]) == 1'b0) begin
       end else begin
           in_rt_dat_data0_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data1_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d0[1]) == 1'b1) begin
           in_rt_dat_data1_d1 <= in_rt_dat_data1_d0;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d0[1]) == 1'b0) begin
       end else begin
           in_rt_dat_data1_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data2_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d0[2]) == 1'b1) begin
           in_rt_dat_data2_d1 <= in_rt_dat_data2_d0;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d0[2]) == 1'b0) begin
       end else begin
           in_rt_dat_data2_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data3_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d0[3]) == 1'b1) begin
           in_rt_dat_data3_d1 <= in_rt_dat_data3_d0;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d0[3]) == 1'b0) begin
       end else begin
           in_rt_dat_data3_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data4_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d0[4]) == 1'b1) begin
           in_rt_dat_data4_d1 <= in_rt_dat_data4_d0;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d0[4]) == 1'b0) begin
       end else begin
           in_rt_dat_data4_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data5_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d0[5]) == 1'b1) begin
           in_rt_dat_data5_d1 <= in_rt_dat_data5_d0;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d0[5]) == 1'b0) begin
       end else begin
           in_rt_dat_data5_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data6_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d0[6]) == 1'b1) begin
           in_rt_dat_data6_d1 <= in_rt_dat_data6_d0;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d0[6]) == 1'b0) begin
       end else begin
           in_rt_dat_data6_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data7_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d0[7]) == 1'b1) begin
           in_rt_dat_data7_d1 <= in_rt_dat_data7_d0;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d0[7]) == 1'b0) begin
       end else begin
           in_rt_dat_data7_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_wt_pvld_d1 <= 'b0;
   end else begin
       in_rt_wt_pvld_d1 <= in_rt_wt_pvld_d0;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_wt_mask_d1 <= 'b0;
   end else begin
       if ((in_rt_wt_pvld_d0 | in_rt_wt_pvld_d1) == 1'b1) begin
           in_rt_wt_mask_d1 <= in_rt_wt_mask_d0;
       // VCS coverage off
       end else if ((in_rt_wt_pvld_d0 | in_rt_wt_pvld_d1) == 1'b0) begin
       end else begin
           in_rt_wt_mask_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_wt_sel_d1 <= 'b0;
   end else begin
       if ((in_rt_wt_pvld_d0 | in_rt_wt_pvld_d1) == 1'b1) begin
           in_rt_wt_sel_d1 <= in_rt_wt_sel_d0;
       // VCS coverage off
       end else if ((in_rt_wt_pvld_d0 | in_rt_wt_pvld_d1) == 1'b0) begin
       end else begin
           in_rt_wt_sel_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] in_rt_wt_data0_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d0[0]) == 1'b1) begin
           in_rt_wt_data0_d1 <= in_rt_wt_data0_d0;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d0[0]) == 1'b0) begin
       end else begin
           in_rt_wt_data0_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data1_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d0[1]) == 1'b1) begin
           in_rt_wt_data1_d1 <= in_rt_wt_data1_d0;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d0[1]) == 1'b0) begin
       end else begin
           in_rt_wt_data1_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data2_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d0[2]) == 1'b1) begin
           in_rt_wt_data2_d1 <= in_rt_wt_data2_d0;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d0[2]) == 1'b0) begin
       end else begin
           in_rt_wt_data2_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data3_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d0[3]) == 1'b1) begin
           in_rt_wt_data3_d1 <= in_rt_wt_data3_d0;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d0[3]) == 1'b0) begin
       end else begin
           in_rt_wt_data3_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data4_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d0[4]) == 1'b1) begin
           in_rt_wt_data4_d1 <= in_rt_wt_data4_d0;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d0[4]) == 1'b0) begin
       end else begin
           in_rt_wt_data4_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data5_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d0[5]) == 1'b1) begin
           in_rt_wt_data5_d1 <= in_rt_wt_data5_d0;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d0[5]) == 1'b0) begin
       end else begin
           in_rt_wt_data5_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data6_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d0[6]) == 1'b1) begin
           in_rt_wt_data6_d1 <= in_rt_wt_data6_d0;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d0[6]) == 1'b0) begin
       end else begin
           in_rt_wt_data6_d1 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data7_d1;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d0[7]) == 1'b1) begin
           in_rt_wt_data7_d1 <= in_rt_wt_data7_d0;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d0[7]) == 1'b0) begin
       end else begin
           in_rt_wt_data7_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_dat_pvld_d2 <= 'b0;
   end else begin
       in_rt_dat_pvld_d2 <= in_rt_dat_pvld_d1;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_dat_mask_d2 <= 'b0;
   end else begin
       if ((in_rt_dat_pvld_d1 | in_rt_dat_pvld_d2) == 1'b1) begin
           in_rt_dat_mask_d2 <= in_rt_dat_mask_d1;
       // VCS coverage off
       end else if ((in_rt_dat_pvld_d1 | in_rt_dat_pvld_d2) == 1'b0) begin
       end else begin
           in_rt_dat_mask_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_dat_pd_d2 <= 'b0;
   end else begin
       if ((in_rt_dat_pvld_d1 | in_rt_dat_pvld_d2) == 1'b1) begin
           in_rt_dat_pd_d2 <= in_rt_dat_pd_d1;
       // VCS coverage off
       end else if ((in_rt_dat_pvld_d1 | in_rt_dat_pvld_d2) == 1'b0) begin
       end else begin
           in_rt_dat_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] in_rt_dat_data0_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d1[0]) == 1'b1) begin
           in_rt_dat_data0_d2 <= in_rt_dat_data0_d1;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d1[0]) == 1'b0) begin
       end else begin
           in_rt_dat_data0_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data1_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d1[1]) == 1'b1) begin
           in_rt_dat_data1_d2 <= in_rt_dat_data1_d1;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d1[1]) == 1'b0) begin
       end else begin
           in_rt_dat_data1_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data2_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d1[2]) == 1'b1) begin
           in_rt_dat_data2_d2 <= in_rt_dat_data2_d1;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d1[2]) == 1'b0) begin
       end else begin
           in_rt_dat_data2_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data3_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d1[3]) == 1'b1) begin
           in_rt_dat_data3_d2 <= in_rt_dat_data3_d1;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d1[3]) == 1'b0) begin
       end else begin
           in_rt_dat_data3_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data4_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d1[4]) == 1'b1) begin
           in_rt_dat_data4_d2 <= in_rt_dat_data4_d1;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d1[4]) == 1'b0) begin
       end else begin
           in_rt_dat_data4_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data5_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d1[5]) == 1'b1) begin
           in_rt_dat_data5_d2 <= in_rt_dat_data5_d1;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d1[5]) == 1'b0) begin
       end else begin
           in_rt_dat_data5_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data6_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d1[6]) == 1'b1) begin
           in_rt_dat_data6_d2 <= in_rt_dat_data6_d1;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d1[6]) == 1'b0) begin
       end else begin
           in_rt_dat_data6_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_dat_data7_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_dat_mask_d1[7]) == 1'b1) begin
           in_rt_dat_data7_d2 <= in_rt_dat_data7_d1;
       // VCS coverage off
       end else if ((in_rt_dat_mask_d1[7]) == 1'b0) begin
       end else begin
           in_rt_dat_data7_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_wt_pvld_d2 <= 'b0;
   end else begin
       in_rt_wt_pvld_d2 <= in_rt_wt_pvld_d1;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_wt_mask_d2 <= 'b0;
   end else begin
       if ((in_rt_wt_pvld_d1 | in_rt_wt_pvld_d2) == 1'b1) begin
           in_rt_wt_mask_d2 <= in_rt_wt_mask_d1;
       // VCS coverage off
       end else if ((in_rt_wt_pvld_d1 | in_rt_wt_pvld_d2) == 1'b0) begin
       end else begin
           in_rt_wt_mask_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       in_rt_wt_sel_d2 <= 'b0;
   end else begin
       if ((in_rt_wt_pvld_d1 | in_rt_wt_pvld_d2) == 1'b1) begin
           in_rt_wt_sel_d2 <= in_rt_wt_sel_d1;
       // VCS coverage off
       end else if ((in_rt_wt_pvld_d1 | in_rt_wt_pvld_d2) == 1'b0) begin
       end else begin
           in_rt_wt_sel_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] in_rt_wt_data0_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d1[0]) == 1'b1) begin
           in_rt_wt_data0_d2 <= in_rt_wt_data0_d1;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d1[0]) == 1'b0) begin
       end else begin
           in_rt_wt_data0_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data1_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d1[1]) == 1'b1) begin
           in_rt_wt_data1_d2 <= in_rt_wt_data1_d1;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d1[1]) == 1'b0) begin
       end else begin
           in_rt_wt_data1_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data2_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d1[2]) == 1'b1) begin
           in_rt_wt_data2_d2 <= in_rt_wt_data2_d1;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d1[2]) == 1'b0) begin
       end else begin
           in_rt_wt_data2_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data3_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d1[3]) == 1'b1) begin
           in_rt_wt_data3_d2 <= in_rt_wt_data3_d1;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d1[3]) == 1'b0) begin
       end else begin
           in_rt_wt_data3_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data4_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d1[4]) == 1'b1) begin
           in_rt_wt_data4_d2 <= in_rt_wt_data4_d1;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d1[4]) == 1'b0) begin
       end else begin
           in_rt_wt_data4_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data5_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d1[5]) == 1'b1) begin
           in_rt_wt_data5_d2 <= in_rt_wt_data5_d1;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d1[5]) == 1'b0) begin
       end else begin
           in_rt_wt_data5_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data6_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d1[6]) == 1'b1) begin
           in_rt_wt_data6_d2 <= in_rt_wt_data6_d1;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d1[6]) == 1'b0) begin
       end else begin
           in_rt_wt_data6_d2 <= 'bx;
       // VCS coverage on
       end
end
reg [7:0] in_rt_wt_data7_d2;
always @(posedge nvdla_core_clk) begin
       if ((in_rt_wt_mask_d1[7]) == 1'b1) begin
           in_rt_wt_data7_d2 <= in_rt_wt_data7_d1;
       // VCS coverage off
       end else if ((in_rt_wt_mask_d1[7]) == 1'b0) begin
       end else begin
           in_rt_wt_data7_d2 <= 'bx;
       // VCS coverage on
       end
end
assign    in_dat_pvld = in_rt_dat_pvld_d2;
assign    in_dat_mask = in_rt_dat_mask_d2;
assign    in_dat_pd   = in_rt_dat_pd_d2;
assign    in_wt_pvld = in_rt_wt_pvld_d2;
assign    in_wt_mask = in_rt_wt_mask_d2;
assign    in_wt_sel = in_rt_wt_sel_d2;

assign in_dat_data0 = in_rt_dat_data0_d2; 
assign in_dat_data1 = in_rt_dat_data1_d2; 
assign in_dat_data2 = in_rt_dat_data2_d2; 
assign in_dat_data3 = in_rt_dat_data3_d2; 
assign in_dat_data4 = in_rt_dat_data4_d2; 
assign in_dat_data5 = in_rt_dat_data5_d2; 
assign in_dat_data6 = in_rt_dat_data6_d2; 
assign in_dat_data7 = in_rt_dat_data7_d2; 
assign in_wt_data0 = in_rt_wt_data0_d2;
assign in_wt_data1 = in_rt_wt_data1_d2;
assign in_wt_data2 = in_rt_wt_data2_d2;
assign in_wt_data3 = in_rt_wt_data3_d2;
assign in_wt_data4 = in_rt_wt_data4_d2;
assign in_wt_data5 = in_rt_wt_data5_d2;
assign in_wt_data6 = in_rt_wt_data6_d2;
assign in_wt_data7 = in_rt_wt_data7_d2;
assign in_dat_stripe_st = in_dat_pd[5];
assign in_dat_stripe_end = in_dat_pd[6]; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
