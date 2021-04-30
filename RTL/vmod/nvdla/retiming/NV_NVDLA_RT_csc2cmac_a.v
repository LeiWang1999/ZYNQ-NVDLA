// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_RT_csc2cmac_a.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CSC.h
    //entry bits
    //atomC
    //in bytes, entry/8
    //CSC_ENTRY_HEX/2
    //CSC_ENTRY_HEX/4
    //CSC_ENTRY_HEX-1
    //atomK
    //atomK
    //atomK*2
    //atomK*4
//notice, for image case, first atom OP within one strip OP must fetch from entry align place, in the middle of an entry is not supported.
//thus, when atomC/atomK=4, stripe=4*atomK, feature data still keeps atomK*2
    `define CC_ATOMC_DIV_ATOMK_EQUAL_1
//batch keep 1
module NV_NVDLA_RT_csc2cmac_a (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,sc2mac_wt_src_pvld
  ,sc2mac_wt_src_mask
//: for(my $i=0; $i<8; $i++){
//: print ",sc2mac_wt_src_data${i} \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
,sc2mac_wt_src_data0 
,sc2mac_wt_src_data1 
,sc2mac_wt_src_data2 
,sc2mac_wt_src_data3 
,sc2mac_wt_src_data4 
,sc2mac_wt_src_data5 
,sc2mac_wt_src_data6 
,sc2mac_wt_src_data7 

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_wt_src_sel
  ,sc2mac_dat_src_pvld
  ,sc2mac_dat_src_mask
//: for(my $i=0; $i<8; $i++){
//: print ",sc2mac_dat_src_data${i} \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
,sc2mac_dat_src_data0 
,sc2mac_dat_src_data1 
,sc2mac_dat_src_data2 
,sc2mac_dat_src_data3 
,sc2mac_dat_src_data4 
,sc2mac_dat_src_data5 
,sc2mac_dat_src_data6 
,sc2mac_dat_src_data7 

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_dat_src_pd
  ,sc2mac_wt_dst_pvld
  ,sc2mac_wt_dst_mask
//: for(my $i=0; $i<8; $i++){
//: print ",sc2mac_wt_dst_data${i} \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
,sc2mac_wt_dst_data0 
,sc2mac_wt_dst_data1 
,sc2mac_wt_dst_data2 
,sc2mac_wt_dst_data3 
,sc2mac_wt_dst_data4 
,sc2mac_wt_dst_data5 
,sc2mac_wt_dst_data6 
,sc2mac_wt_dst_data7 

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_wt_dst_sel
  ,sc2mac_dat_dst_pvld
  ,sc2mac_dat_dst_mask
//: for(my $i=0; $i<8; $i++){
//: print ",sc2mac_dat_dst_data${i} \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
,sc2mac_dat_dst_data0 
,sc2mac_dat_dst_data1 
,sc2mac_dat_dst_data2 
,sc2mac_dat_dst_data3 
,sc2mac_dat_dst_data4 
,sc2mac_dat_dst_data5 
,sc2mac_dat_dst_data6 
,sc2mac_dat_dst_data7 

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,sc2mac_dat_dst_pd
  );
//
// NV_NVDLA_RT_csc2cmac_ports.v
//
input nvdla_core_clk;
input nvdla_core_rstn;
input sc2mac_wt_src_pvld; /* data valid */
input [8 -1:0] sc2mac_wt_src_mask;
//: my $bb=8;
//: for(my $i=0; $i<8; $i++){
//: print "input   [${bb}-1:0] sc2mac_wt_src_data${i};  \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
input   [8-1:0] sc2mac_wt_src_data0;  
input   [8-1:0] sc2mac_wt_src_data1;  
input   [8-1:0] sc2mac_wt_src_data2;  
input   [8-1:0] sc2mac_wt_src_data3;  
input   [8-1:0] sc2mac_wt_src_data4;  
input   [8-1:0] sc2mac_wt_src_data5;  
input   [8-1:0] sc2mac_wt_src_data6;  
input   [8-1:0] sc2mac_wt_src_data7;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8/2 -1:0] sc2mac_wt_src_sel;
input sc2mac_dat_src_pvld; /* data valid */
input [8 -1:0] sc2mac_dat_src_mask;
//: my $bb=8;
//: for(my $i=0; $i<8; $i++){
//: print "input   [${bb}-1:0] sc2mac_dat_src_data${i};  \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
input   [8-1:0] sc2mac_dat_src_data0;  
input   [8-1:0] sc2mac_dat_src_data1;  
input   [8-1:0] sc2mac_dat_src_data2;  
input   [8-1:0] sc2mac_dat_src_data3;  
input   [8-1:0] sc2mac_dat_src_data4;  
input   [8-1:0] sc2mac_dat_src_data5;  
input   [8-1:0] sc2mac_dat_src_data6;  
input   [8-1:0] sc2mac_dat_src_data7;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8:0] sc2mac_dat_src_pd;
output sc2mac_wt_dst_pvld; /* data valid */
output [8 -1:0] sc2mac_wt_dst_mask;
//: my $bb=8;
//: for(my $i=0; $i<8; $i++){
//: print "output   [${bb}-1:0] sc2mac_wt_dst_data${i};  \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
output   [8-1:0] sc2mac_wt_dst_data0;  
output   [8-1:0] sc2mac_wt_dst_data1;  
output   [8-1:0] sc2mac_wt_dst_data2;  
output   [8-1:0] sc2mac_wt_dst_data3;  
output   [8-1:0] sc2mac_wt_dst_data4;  
output   [8-1:0] sc2mac_wt_dst_data5;  
output   [8-1:0] sc2mac_wt_dst_data6;  
output   [8-1:0] sc2mac_wt_dst_data7;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
output [8/2 -1:0] sc2mac_wt_dst_sel;
output sc2mac_dat_dst_pvld; /* data valid */
output [8 -1:0] sc2mac_dat_dst_mask;
//: my $bb=8;
//: for(my $i=0; $i<8; $i++){
//: print "output   [${bb}-1:0] sc2mac_dat_dst_data${i};  \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
output   [8-1:0] sc2mac_dat_dst_data0;  
output   [8-1:0] sc2mac_dat_dst_data1;  
output   [8-1:0] sc2mac_dat_dst_data2;  
output   [8-1:0] sc2mac_dat_dst_data3;  
output   [8-1:0] sc2mac_dat_dst_data4;  
output   [8-1:0] sc2mac_dat_dst_data5;  
output   [8-1:0] sc2mac_dat_dst_data6;  
output   [8-1:0] sc2mac_dat_dst_data7;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
output [8:0] sc2mac_dat_dst_pd;
//: my $delay = 2;
//: my $i;
//: my $j;
//: my $k;
//: my $bb=8;
//: my $kk=8/2;
//: my $cc=8;
//: print "wire sc2mac_wt_pvld_d0 = sc2mac_wt_src_pvld;\n";
//: print "wire[${kk}-1:0] sc2mac_wt_sel_d0 = sc2mac_wt_src_sel;\n";
//: print "wire[${cc}-1:0] sc2mac_wt_mask_d0 = sc2mac_wt_src_mask;\n";
//: for($k = 0; $k <8; $k ++) {
//: print "wire sc2mac_wt_data${k}_d0 = sc2mac_wt_src_data${k};\n";
//: }
//:
//: print "wire sc2mac_dat_pvld_d0 = sc2mac_dat_src_pvld;\n";
//: print "wire[8:0] sc2mac_dat_pd_d0 = sc2mac_dat_src_pd;\n";
//: print "wire[${cc}-1:0] sc2mac_dat_mask_d0 = sc2mac_dat_src_mask;\n";
//: for($k = 0; $k <8; $k ++) {
//: print "wire[${bb}-1:0] sc2mac_dat_data${k}_d0 = sc2mac_dat_src_data${k};\n";
//: }
//:
//: for($i = 0; $i < $delay; $i ++) {
//: $j = $i + 1;
//: &eperl::flop("-q sc2mac_wt_pvld_d${j} -d sc2mac_wt_pvld_d${i}");
//: &eperl::flop("-wid ${kk} -q sc2mac_wt_sel_d${j}  -en \"(sc2mac_wt_pvld_d${i} | sc2mac_wt_pvld_d${j})\" -d sc2mac_wt_sel_d${i}");
//: &eperl::flop("-wid ${cc} -q sc2mac_wt_mask_d${j} -en \"(sc2mac_wt_pvld_d${i} | sc2mac_wt_pvld_d${j})\" -d sc2mac_wt_mask_d${i}");
//: for($k = 0; $k <8; $k ++) {
//: &eperl::flop("-wid ${bb} -q sc2mac_wt_data${k}_d${j} -en sc2mac_wt_mask_d${i}[${k}] -d sc2mac_wt_data${k}_d${i}");
//: }
//:
//: &eperl::flop("-q sc2mac_dat_pvld_d${j} -d sc2mac_dat_pvld_d${i}");
//: &eperl::flop("-wid 9 -q sc2mac_dat_pd_d${j} -en \"(sc2mac_dat_pvld_d${i} | sc2mac_dat_pvld_d${j})\" -d sc2mac_dat_pd_d${i}");
//: &eperl::flop("-wid ${cc} -q sc2mac_dat_mask_d${j} -en \"(sc2mac_dat_pvld_d${i} | sc2mac_dat_pvld_d${j})\" -d sc2mac_dat_mask_d${i}");
//: for($k = 0; $k <8; $k ++) {
//: &eperl::flop("-wid ${bb} -q sc2mac_dat_data${k}_d${j} -en \"(sc2mac_dat_mask_d${i}[${k}])\" -d sc2mac_dat_data${k}_d${i}");
//: }
//: }
//:
//: $i = $delay;
//: print "wire sc2mac_wt_dst_pvld = sc2mac_wt_pvld_d${i};\n";
//: print "wire[${kk}-1:0] sc2mac_wt_dst_sel = sc2mac_wt_sel_d${i};\n";
//: print "wire[${cc}-1:0] sc2mac_wt_dst_mask = sc2mac_wt_mask_d${i};\n";
//: for($k = 0; $k <8; $k ++) {
//: print "wire[${bb}-1:0] sc2mac_wt_dst_data${k} = sc2mac_wt_data${k}_d${i};\n";
//: }
//:
//: print "wire sc2mac_dat_dst_pvld = sc2mac_dat_pvld_d${i};\n";
//: print "wire[8:0] sc2mac_dat_dst_pd = sc2mac_dat_pd_d${i};\n";
//: print "wire[${cc}-1:0] sc2mac_dat_dst_mask = sc2mac_dat_mask_d${i};\n";
//: for($k = 0; $k <8; $k ++) {
//: print "wire[${bb}-1:0] sc2mac_dat_dst_data${k} = sc2mac_dat_data${k}_d${i};\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire sc2mac_wt_pvld_d0 = sc2mac_wt_src_pvld;
wire[4-1:0] sc2mac_wt_sel_d0 = sc2mac_wt_src_sel;
wire[8-1:0] sc2mac_wt_mask_d0 = sc2mac_wt_src_mask;
wire sc2mac_wt_data0_d0 = sc2mac_wt_src_data0;
wire sc2mac_wt_data1_d0 = sc2mac_wt_src_data1;
wire sc2mac_wt_data2_d0 = sc2mac_wt_src_data2;
wire sc2mac_wt_data3_d0 = sc2mac_wt_src_data3;
wire sc2mac_wt_data4_d0 = sc2mac_wt_src_data4;
wire sc2mac_wt_data5_d0 = sc2mac_wt_src_data5;
wire sc2mac_wt_data6_d0 = sc2mac_wt_src_data6;
wire sc2mac_wt_data7_d0 = sc2mac_wt_src_data7;
wire sc2mac_dat_pvld_d0 = sc2mac_dat_src_pvld;
wire[8:0] sc2mac_dat_pd_d0 = sc2mac_dat_src_pd;
wire[8-1:0] sc2mac_dat_mask_d0 = sc2mac_dat_src_mask;
wire[8-1:0] sc2mac_dat_data0_d0 = sc2mac_dat_src_data0;
wire[8-1:0] sc2mac_dat_data1_d0 = sc2mac_dat_src_data1;
wire[8-1:0] sc2mac_dat_data2_d0 = sc2mac_dat_src_data2;
wire[8-1:0] sc2mac_dat_data3_d0 = sc2mac_dat_src_data3;
wire[8-1:0] sc2mac_dat_data4_d0 = sc2mac_dat_src_data4;
wire[8-1:0] sc2mac_dat_data5_d0 = sc2mac_dat_src_data5;
wire[8-1:0] sc2mac_dat_data6_d0 = sc2mac_dat_src_data6;
wire[8-1:0] sc2mac_dat_data7_d0 = sc2mac_dat_src_data7;
reg  sc2mac_wt_pvld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_pvld_d1 <= 'b0;
   end else begin
       sc2mac_wt_pvld_d1 <= sc2mac_wt_pvld_d0;
   end
end
reg [3:0] sc2mac_wt_sel_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_sel_d1 <= 'b0;
   end else begin
       if (((sc2mac_wt_pvld_d0 | sc2mac_wt_pvld_d1)) == 1'b1) begin
           sc2mac_wt_sel_d1 <= sc2mac_wt_sel_d0;
       // VCS coverage off
       end else if (((sc2mac_wt_pvld_d0 | sc2mac_wt_pvld_d1)) == 1'b0) begin
       end else begin
           sc2mac_wt_sel_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_mask_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_mask_d1 <= 'b0;
   end else begin
       if (((sc2mac_wt_pvld_d0 | sc2mac_wt_pvld_d1)) == 1'b1) begin
           sc2mac_wt_mask_d1 <= sc2mac_wt_mask_d0;
       // VCS coverage off
       end else if (((sc2mac_wt_pvld_d0 | sc2mac_wt_pvld_d1)) == 1'b0) begin
       end else begin
           sc2mac_wt_mask_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data0_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data0_d1 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d0[0]) == 1'b1) begin
           sc2mac_wt_data0_d1 <= sc2mac_wt_data0_d0;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d0[0]) == 1'b0) begin
       end else begin
           sc2mac_wt_data0_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data1_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data1_d1 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d0[1]) == 1'b1) begin
           sc2mac_wt_data1_d1 <= sc2mac_wt_data1_d0;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d0[1]) == 1'b0) begin
       end else begin
           sc2mac_wt_data1_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data2_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data2_d1 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d0[2]) == 1'b1) begin
           sc2mac_wt_data2_d1 <= sc2mac_wt_data2_d0;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d0[2]) == 1'b0) begin
       end else begin
           sc2mac_wt_data2_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data3_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data3_d1 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d0[3]) == 1'b1) begin
           sc2mac_wt_data3_d1 <= sc2mac_wt_data3_d0;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d0[3]) == 1'b0) begin
       end else begin
           sc2mac_wt_data3_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data4_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data4_d1 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d0[4]) == 1'b1) begin
           sc2mac_wt_data4_d1 <= sc2mac_wt_data4_d0;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d0[4]) == 1'b0) begin
       end else begin
           sc2mac_wt_data4_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data5_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data5_d1 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d0[5]) == 1'b1) begin
           sc2mac_wt_data5_d1 <= sc2mac_wt_data5_d0;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d0[5]) == 1'b0) begin
       end else begin
           sc2mac_wt_data5_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data6_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data6_d1 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d0[6]) == 1'b1) begin
           sc2mac_wt_data6_d1 <= sc2mac_wt_data6_d0;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d0[6]) == 1'b0) begin
       end else begin
           sc2mac_wt_data6_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data7_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data7_d1 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d0[7]) == 1'b1) begin
           sc2mac_wt_data7_d1 <= sc2mac_wt_data7_d0;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d0[7]) == 1'b0) begin
       end else begin
           sc2mac_wt_data7_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  sc2mac_dat_pvld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_pvld_d1 <= 'b0;
   end else begin
       sc2mac_dat_pvld_d1 <= sc2mac_dat_pvld_d0;
   end
end
reg [8:0] sc2mac_dat_pd_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_pd_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_pvld_d0 | sc2mac_dat_pvld_d1)) == 1'b1) begin
           sc2mac_dat_pd_d1 <= sc2mac_dat_pd_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_pvld_d0 | sc2mac_dat_pvld_d1)) == 1'b0) begin
       end else begin
           sc2mac_dat_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_mask_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_mask_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_pvld_d0 | sc2mac_dat_pvld_d1)) == 1'b1) begin
           sc2mac_dat_mask_d1 <= sc2mac_dat_mask_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_pvld_d0 | sc2mac_dat_pvld_d1)) == 1'b0) begin
       end else begin
           sc2mac_dat_mask_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data0_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data0_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d0[0])) == 1'b1) begin
           sc2mac_dat_data0_d1 <= sc2mac_dat_data0_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d0[0])) == 1'b0) begin
       end else begin
           sc2mac_dat_data0_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data1_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data1_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d0[1])) == 1'b1) begin
           sc2mac_dat_data1_d1 <= sc2mac_dat_data1_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d0[1])) == 1'b0) begin
       end else begin
           sc2mac_dat_data1_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data2_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data2_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d0[2])) == 1'b1) begin
           sc2mac_dat_data2_d1 <= sc2mac_dat_data2_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d0[2])) == 1'b0) begin
       end else begin
           sc2mac_dat_data2_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data3_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data3_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d0[3])) == 1'b1) begin
           sc2mac_dat_data3_d1 <= sc2mac_dat_data3_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d0[3])) == 1'b0) begin
       end else begin
           sc2mac_dat_data3_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data4_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data4_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d0[4])) == 1'b1) begin
           sc2mac_dat_data4_d1 <= sc2mac_dat_data4_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d0[4])) == 1'b0) begin
       end else begin
           sc2mac_dat_data4_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data5_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data5_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d0[5])) == 1'b1) begin
           sc2mac_dat_data5_d1 <= sc2mac_dat_data5_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d0[5])) == 1'b0) begin
       end else begin
           sc2mac_dat_data5_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data6_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data6_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d0[6])) == 1'b1) begin
           sc2mac_dat_data6_d1 <= sc2mac_dat_data6_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d0[6])) == 1'b0) begin
       end else begin
           sc2mac_dat_data6_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data7_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data7_d1 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d0[7])) == 1'b1) begin
           sc2mac_dat_data7_d1 <= sc2mac_dat_data7_d0;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d0[7])) == 1'b0) begin
       end else begin
           sc2mac_dat_data7_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  sc2mac_wt_pvld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_pvld_d2 <= 'b0;
   end else begin
       sc2mac_wt_pvld_d2 <= sc2mac_wt_pvld_d1;
   end
end
reg [3:0] sc2mac_wt_sel_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_sel_d2 <= 'b0;
   end else begin
       if (((sc2mac_wt_pvld_d1 | sc2mac_wt_pvld_d2)) == 1'b1) begin
           sc2mac_wt_sel_d2 <= sc2mac_wt_sel_d1;
       // VCS coverage off
       end else if (((sc2mac_wt_pvld_d1 | sc2mac_wt_pvld_d2)) == 1'b0) begin
       end else begin
           sc2mac_wt_sel_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_mask_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_mask_d2 <= 'b0;
   end else begin
       if (((sc2mac_wt_pvld_d1 | sc2mac_wt_pvld_d2)) == 1'b1) begin
           sc2mac_wt_mask_d2 <= sc2mac_wt_mask_d1;
       // VCS coverage off
       end else if (((sc2mac_wt_pvld_d1 | sc2mac_wt_pvld_d2)) == 1'b0) begin
       end else begin
           sc2mac_wt_mask_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data0_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data0_d2 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d1[0]) == 1'b1) begin
           sc2mac_wt_data0_d2 <= sc2mac_wt_data0_d1;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d1[0]) == 1'b0) begin
       end else begin
           sc2mac_wt_data0_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data1_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data1_d2 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d1[1]) == 1'b1) begin
           sc2mac_wt_data1_d2 <= sc2mac_wt_data1_d1;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d1[1]) == 1'b0) begin
       end else begin
           sc2mac_wt_data1_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data2_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data2_d2 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d1[2]) == 1'b1) begin
           sc2mac_wt_data2_d2 <= sc2mac_wt_data2_d1;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d1[2]) == 1'b0) begin
       end else begin
           sc2mac_wt_data2_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data3_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data3_d2 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d1[3]) == 1'b1) begin
           sc2mac_wt_data3_d2 <= sc2mac_wt_data3_d1;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d1[3]) == 1'b0) begin
       end else begin
           sc2mac_wt_data3_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data4_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data4_d2 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d1[4]) == 1'b1) begin
           sc2mac_wt_data4_d2 <= sc2mac_wt_data4_d1;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d1[4]) == 1'b0) begin
       end else begin
           sc2mac_wt_data4_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data5_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data5_d2 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d1[5]) == 1'b1) begin
           sc2mac_wt_data5_d2 <= sc2mac_wt_data5_d1;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d1[5]) == 1'b0) begin
       end else begin
           sc2mac_wt_data5_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data6_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data6_d2 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d1[6]) == 1'b1) begin
           sc2mac_wt_data6_d2 <= sc2mac_wt_data6_d1;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d1[6]) == 1'b0) begin
       end else begin
           sc2mac_wt_data6_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_wt_data7_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_wt_data7_d2 <= 'b0;
   end else begin
       if ((sc2mac_wt_mask_d1[7]) == 1'b1) begin
           sc2mac_wt_data7_d2 <= sc2mac_wt_data7_d1;
       // VCS coverage off
       end else if ((sc2mac_wt_mask_d1[7]) == 1'b0) begin
       end else begin
           sc2mac_wt_data7_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  sc2mac_dat_pvld_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_pvld_d2 <= 'b0;
   end else begin
       sc2mac_dat_pvld_d2 <= sc2mac_dat_pvld_d1;
   end
end
reg [8:0] sc2mac_dat_pd_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_pd_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_pvld_d1 | sc2mac_dat_pvld_d2)) == 1'b1) begin
           sc2mac_dat_pd_d2 <= sc2mac_dat_pd_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_pvld_d1 | sc2mac_dat_pvld_d2)) == 1'b0) begin
       end else begin
           sc2mac_dat_pd_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_mask_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_mask_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_pvld_d1 | sc2mac_dat_pvld_d2)) == 1'b1) begin
           sc2mac_dat_mask_d2 <= sc2mac_dat_mask_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_pvld_d1 | sc2mac_dat_pvld_d2)) == 1'b0) begin
       end else begin
           sc2mac_dat_mask_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data0_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data0_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d1[0])) == 1'b1) begin
           sc2mac_dat_data0_d2 <= sc2mac_dat_data0_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d1[0])) == 1'b0) begin
       end else begin
           sc2mac_dat_data0_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data1_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data1_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d1[1])) == 1'b1) begin
           sc2mac_dat_data1_d2 <= sc2mac_dat_data1_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d1[1])) == 1'b0) begin
       end else begin
           sc2mac_dat_data1_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data2_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data2_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d1[2])) == 1'b1) begin
           sc2mac_dat_data2_d2 <= sc2mac_dat_data2_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d1[2])) == 1'b0) begin
       end else begin
           sc2mac_dat_data2_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data3_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data3_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d1[3])) == 1'b1) begin
           sc2mac_dat_data3_d2 <= sc2mac_dat_data3_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d1[3])) == 1'b0) begin
       end else begin
           sc2mac_dat_data3_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data4_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data4_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d1[4])) == 1'b1) begin
           sc2mac_dat_data4_d2 <= sc2mac_dat_data4_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d1[4])) == 1'b0) begin
       end else begin
           sc2mac_dat_data4_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data5_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data5_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d1[5])) == 1'b1) begin
           sc2mac_dat_data5_d2 <= sc2mac_dat_data5_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d1[5])) == 1'b0) begin
       end else begin
           sc2mac_dat_data5_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data6_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data6_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d1[6])) == 1'b1) begin
           sc2mac_dat_data6_d2 <= sc2mac_dat_data6_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d1[6])) == 1'b0) begin
       end else begin
           sc2mac_dat_data6_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] sc2mac_dat_data7_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sc2mac_dat_data7_d2 <= 'b0;
   end else begin
       if (((sc2mac_dat_mask_d1[7])) == 1'b1) begin
           sc2mac_dat_data7_d2 <= sc2mac_dat_data7_d1;
       // VCS coverage off
       end else if (((sc2mac_dat_mask_d1[7])) == 1'b0) begin
       end else begin
           sc2mac_dat_data7_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
wire sc2mac_wt_dst_pvld = sc2mac_wt_pvld_d2;
wire[4-1:0] sc2mac_wt_dst_sel = sc2mac_wt_sel_d2;
wire[8-1:0] sc2mac_wt_dst_mask = sc2mac_wt_mask_d2;
wire[8-1:0] sc2mac_wt_dst_data0 = sc2mac_wt_data0_d2;
wire[8-1:0] sc2mac_wt_dst_data1 = sc2mac_wt_data1_d2;
wire[8-1:0] sc2mac_wt_dst_data2 = sc2mac_wt_data2_d2;
wire[8-1:0] sc2mac_wt_dst_data3 = sc2mac_wt_data3_d2;
wire[8-1:0] sc2mac_wt_dst_data4 = sc2mac_wt_data4_d2;
wire[8-1:0] sc2mac_wt_dst_data5 = sc2mac_wt_data5_d2;
wire[8-1:0] sc2mac_wt_dst_data6 = sc2mac_wt_data6_d2;
wire[8-1:0] sc2mac_wt_dst_data7 = sc2mac_wt_data7_d2;
wire sc2mac_dat_dst_pvld = sc2mac_dat_pvld_d2;
wire[8:0] sc2mac_dat_dst_pd = sc2mac_dat_pd_d2;
wire[8-1:0] sc2mac_dat_dst_mask = sc2mac_dat_mask_d2;
wire[8-1:0] sc2mac_dat_dst_data0 = sc2mac_dat_data0_d2;
wire[8-1:0] sc2mac_dat_dst_data1 = sc2mac_dat_data1_d2;
wire[8-1:0] sc2mac_dat_dst_data2 = sc2mac_dat_data2_d2;
wire[8-1:0] sc2mac_dat_dst_data3 = sc2mac_dat_data3_d2;
wire[8-1:0] sc2mac_dat_dst_data4 = sc2mac_dat_data4_d2;
wire[8-1:0] sc2mac_dat_dst_data5 = sc2mac_dat_data5_d2;
wire[8-1:0] sc2mac_dat_dst_data6 = sc2mac_dat_data6_d2;
wire[8-1:0] sc2mac_dat_dst_data7 = sc2mac_dat_data7_d2;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_RT_csc2cmac_a
