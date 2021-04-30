// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_DP_LUT_ctrl.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_define.h
///////////////////////////////////////////////////
//#ifdef NVDLA_FEATURE_DATA_TYPE_INT8
//#if ( NVDLA_CDP_THROUGHPUT  ==  8 )
//    #define LARGE_FIFO_RAM
//#endif
//#if ( NVDLA_CDP_THROUGHPUT == 1 )
//    #define SMALL_FIFO_RAM
//#endif
//#endif
module NV_NVDLA_CDP_DP_LUT_ctrl (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,dp2lut_prdy //|< i
  ,reg2dp_lut_le_function //|< i
  ,reg2dp_lut_le_index_offset //|< i
  ,reg2dp_lut_le_index_select //|< i
  ,reg2dp_lut_le_start_high //|< i
  ,reg2dp_lut_le_start_low //|< i
  ,reg2dp_lut_lo_index_select //|< i
  ,reg2dp_lut_lo_start_high //|< i
  ,reg2dp_lut_lo_start_low //|< i
  ,reg2dp_sqsum_bypass //|< i
  ,sum2itp_pd //|< i
  ,sum2itp_pvld //|< i
  ,sum2sync_prdy //|< i
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,dp2lut_X_entry_${m}
//: ,dp2lut_Xinfo_${m}
//: ,dp2lut_Y_entry_${m}
//: ,dp2lut_Yinfo_${m}
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,dp2lut_X_entry_0
,dp2lut_Xinfo_0
,dp2lut_Y_entry_0
,dp2lut_Yinfo_0

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,dp2lut_pvld //|> o
  ,sum2itp_prdy //|> o
  ,sum2sync_pd //|> o
  ,sum2sync_pvld //|> o
  );
////////////////////////////////////////////////////////////////////////////////////////
//parameter pINT8_BW = 9;//int8 bitwidth after icvt
//parameter pPP_BW = (pINT8_BW + pINT8_BW) -1 + 4;
////////////////////////////////////////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
input reg2dp_lut_le_function;
input [7:0] reg2dp_lut_le_index_offset;
input [7:0] reg2dp_lut_le_index_select;
input [5:0] reg2dp_lut_le_start_high;
input [31:0] reg2dp_lut_le_start_low;
input [7:0] reg2dp_lut_lo_index_select;
input [5:0] reg2dp_lut_lo_start_high;
input [31:0] reg2dp_lut_lo_start_low;
input reg2dp_sqsum_bypass;
//: my $tp=1;
//: my $icvto=(8 +1);
//: my $sqsumo = $icvto *2 -1+4; ##(${tp}*2) -1 is for x^2, +4 is after 9 lrn
//: print "input  [${tp}*${sqsumo}-1:0] sum2itp_pd;  \n";
//: print "output [${tp}*${sqsumo}-1:0] sum2sync_pd; \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
input  [1*21-1:0] sum2itp_pd;  
output [1*21-1:0] sum2sync_pd; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
input sum2itp_pvld;
output sum2itp_prdy;
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: output [9:0] dp2lut_X_entry_${m};
//: output [17:0] dp2lut_Xinfo_${m};
//: output [9:0] dp2lut_Y_entry_${m};
//: output [17:0] dp2lut_Yinfo_${m};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [9:0] dp2lut_X_entry_0;
output [17:0] dp2lut_Xinfo_0;
output [9:0] dp2lut_Y_entry_0;
output [17:0] dp2lut_Yinfo_0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output dp2lut_pvld;
input dp2lut_prdy;
output sum2sync_pvld;
input sum2sync_prdy;
////////////////////////////////////////////////////////////////////////////////////////
//: my $tp=1;
//: my $icvto=(8 +1);
//: my $sqsumo = $icvto *2 -1+4;
//: foreach my $m (0..${tp}-1) {
//: print qq(
//: wire [17:0] dp2lut_X_info_$m;
//: wire [9:0] dp2lut_X_pd_$m;
//: wire [17:0] dp2lut_Y_info_$m;
//: wire [9:0] dp2lut_Y_pd_$m;
//: wire [${sqsumo}-1:0] sum2itp_pd_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [17:0] dp2lut_X_info_0;
wire [9:0] dp2lut_X_pd_0;
wire [17:0] dp2lut_Y_info_0;
wire [9:0] dp2lut_Y_pd_0;
wire [21-1:0] sum2itp_pd_0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [1 -1:0] dp2lut_rdy;
wire [1 -1:0] dp2lut_vld;
wire [1 -1:0] sum2itp_rdy;
wire [1 -1:0] sum2itp_vld;
////////////////////////////////////////////////////////////////////////////////////////
assign sum2itp_prdy = (&sum2itp_rdy) & sum2sync_prdy;
//////////////////////////////////////////////////////////////////////
//from intp_ctrl input port to sync fifo for interpolation
assign sum2sync_pvld = sum2itp_pvld & (&sum2itp_rdy);
assign sum2sync_pd = sum2itp_pd;
///////////////////////////////////////////
//: my $tp=1;
//: my $icvto=(8 +1);
//: my $sqsumo = $icvto *2 -1+4;
//: foreach my $m (0..${tp} -1) {
//: print qq(
//: assign sum2itp_vld[$m] = sum2itp_pvld & sum2sync_prdy
//: );
//: foreach my $j (0..${tp} -1) {
//: if(${j} != ${m}) {
//: print qq(
//: & sum2itp_rdy[$j]
//: );
//: }
//: }
//: print qq(
//: ;
//: );
//: print qq(
//: assign sum2itp_pd_${m} = sum2itp_pd[${sqsumo}*${m}+${sqsumo}-1:${sqsumo}*${m}];
//: NV_NVDLA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit$m (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.sum2itp_pd (sum2itp_pd_${m})
//: ,.sum2itp_pvld (sum2itp_vld[${m}])
//: ,.sum2itp_prdy (sum2itp_rdy[${m}])
//: ,.reg2dp_lut_le_function (reg2dp_lut_le_function)
//: ,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
//: ,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
//: ,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
//: ,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
//: ,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
//: ,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
//: ,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
//: ,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
//: ,.dp2lut_X_info (dp2lut_X_info_${m})
//: ,.dp2lut_X_pd (dp2lut_X_pd_${m})
//: ,.dp2lut_Y_info (dp2lut_Y_info_${m})
//: ,.dp2lut_Y_pd (dp2lut_Y_pd_${m})
//: ,.dp2lut_pvld (dp2lut_vld[${m}])
//: ,.dp2lut_prdy (dp2lut_rdy[${m}])
//: );
//: );
//: }
//: my $k = 1;
//: foreach my $m (0..$k -1) {
//: print qq(
//: assign dp2lut_X_entry_$m = dp2lut_X_pd_$m;
//: assign dp2lut_Y_entry_$m = dp2lut_Y_pd_$m;
//: assign dp2lut_Xinfo_$m = dp2lut_X_info_$m;
//: assign dp2lut_Yinfo_$m = dp2lut_Y_info_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign sum2itp_vld[0] = sum2itp_pvld & sum2sync_prdy

;

assign sum2itp_pd_0 = sum2itp_pd[21*0+21-1:21*0];
NV_NVDLA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.sum2itp_pd (sum2itp_pd_0)
,.sum2itp_pvld (sum2itp_vld[0])
,.sum2itp_prdy (sum2itp_rdy[0])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_0)
,.dp2lut_X_pd (dp2lut_X_pd_0)
,.dp2lut_Y_info (dp2lut_Y_info_0)
,.dp2lut_Y_pd (dp2lut_Y_pd_0)
,.dp2lut_pvld (dp2lut_vld[0])
,.dp2lut_prdy (dp2lut_rdy[0])
);

assign dp2lut_X_entry_0 = dp2lut_X_pd_0;
assign dp2lut_Y_entry_0 = dp2lut_Y_pd_0;
assign dp2lut_Xinfo_0 = dp2lut_X_info_0;
assign dp2lut_Yinfo_0 = dp2lut_Y_info_0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dp2lut_pvld = &dp2lut_vld;
//: my $k = 1;
//: foreach my $m (0..$k -1) {
//: print qq(
//: assign dp2lut_rdy[${m}] = dp2lut_prdy
//: );
//: foreach my $j (0..$k -1) {
//: if(${j} != ${m}) {
//: print qq(
//: & dp2lut_vld[$j]
//: );
//: }
//: }
//: print qq(
//: ;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dp2lut_rdy[0] = dp2lut_prdy

;

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////////////////////////////////////
endmodule // NV_NVDLA_CDP_DP_LUT_ctrl
