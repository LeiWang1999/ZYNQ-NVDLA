// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_DP_sum.v
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
module NV_NVDLA_CDP_DP_sum (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,normalz_buf_data //|< i
  ,normalz_buf_data_pvld //|< i
  ,reg2dp_normalz_len //|< i
  ,sum2itp_prdy //|< i
  ,normalz_buf_data_prdy //|> o
  ,sum2itp_pd //|> o
  ,sum2itp_pvld //|> o
  );
/////////////////////////////////////////////////////
// parameter pINT8_BW = 9;
/////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
//: my $tp=1;
//: my $icvto=(8 +1);
//: my $k = ${icvto}*(${tp}+8)+17;
//: print qq(
//: input [${k}-1:0] normalz_buf_data;
//: output [${tp}*(${icvto}*2+3)-1:0] sum2itp_pd;
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [98-1:0] normalz_buf_data;
output [1*(9*2+3)-1:0] sum2itp_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input normalz_buf_data_pvld;
input [1:0] reg2dp_normalz_len;
input sum2itp_prdy;
output normalz_buf_data_prdy;
output sum2itp_pvld;
/////////////////////////////////////////////////////
reg buf2sum_2d_vld;
reg buf2sum_3d_vld;
reg buf2sum_d_vld;
wire buf2sum_2d_rdy;
wire buf2sum_3d_rdy;
wire buf2sum_d_rdy;
wire buf2sum_din_prdy;
wire buf2sum_rdy_f;
wire cdp_buf2sum_ready;
//: my $icvto=(8 +1);
//: my $tp=1 +8;
//: foreach my $i (0..${tp}-1) {
//: print qq(
//: wire [${icvto}-1:0] buf2sum_int8_$i;
//: wire [${icvto}-1:0] inv_${i};
//: wire [${icvto}-1:0] int8_abs_${i};
//: reg [${icvto}*2-2:0] int8_sq_${i};
//: reg mon_int8_sq_${i};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [9-1:0] buf2sum_int8_0;
wire [9-1:0] inv_0;
wire [9-1:0] int8_abs_0;
reg [9*2-2:0] int8_sq_0;
reg mon_int8_sq_0;

wire [9-1:0] buf2sum_int8_1;
wire [9-1:0] inv_1;
wire [9-1:0] int8_abs_1;
reg [9*2-2:0] int8_sq_1;
reg mon_int8_sq_1;

wire [9-1:0] buf2sum_int8_2;
wire [9-1:0] inv_2;
wire [9-1:0] int8_abs_2;
reg [9*2-2:0] int8_sq_2;
reg mon_int8_sq_2;

wire [9-1:0] buf2sum_int8_3;
wire [9-1:0] inv_3;
wire [9-1:0] int8_abs_3;
reg [9*2-2:0] int8_sq_3;
reg mon_int8_sq_3;

wire [9-1:0] buf2sum_int8_4;
wire [9-1:0] inv_4;
wire [9-1:0] int8_abs_4;
reg [9*2-2:0] int8_sq_4;
reg mon_int8_sq_4;

wire [9-1:0] buf2sum_int8_5;
wire [9-1:0] inv_5;
wire [9-1:0] int8_abs_5;
reg [9*2-2:0] int8_sq_5;
reg mon_int8_sq_5;

wire [9-1:0] buf2sum_int8_6;
wire [9-1:0] inv_6;
wire [9-1:0] int8_abs_6;
reg [9*2-2:0] int8_sq_6;
reg mon_int8_sq_6;

wire [9-1:0] buf2sum_int8_7;
wire [9-1:0] inv_7;
wire [9-1:0] int8_abs_7;
reg [9*2-2:0] int8_sq_7;
reg mon_int8_sq_7;

wire [9-1:0] buf2sum_int8_8;
wire [9-1:0] inv_8;
wire [9-1:0] int8_abs_8;
reg [9*2-2:0] int8_sq_8;
reg mon_int8_sq_8;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [7:0] int8_inv_2;
wire [7:0] int8_inv_3;
wire [7:0] int8_inv_4;
wire [7:0] int8_inv_5;
wire [7:0] int8_inv_6;
wire [7:0] int8_inv_7;
wire [7:0] int8_inv_8;
wire [7:0] int8_inv_9;
//: my $tp=1;
//: my $icvto=(8 +1);
//: my $k = ${tp}*(${icvto}*2+3);
//: print qq(
//: wire [${k}-1:0] sum_out_pd;
//: wire [${k}-1:0] sum2itp_data;
//: );
//: foreach my $i (0..$tp-1){
//: print qq(
//: wire [${icvto}*2-1+4-1:0] int8_sum_$i;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [21-1:0] sum_out_pd;
wire [21-1:0] sum2itp_data;

wire [9*2-1+4-1:0] int8_sum_0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [41:0] int8_sum_1st;
wire [41:0] int8_sum_2nd;
wire [41:0] int8_sum_3rd;
wire [41:0] int8_sum_4th;
wire [15:0] int_ivt_2;
wire [15:0] int_ivt_3;
wire [15:0] int_ivt_4;
wire [15:0] int_ivt_5;
wire [15:0] int_ivt_6;
wire [15:0] int_ivt_7;
wire [15:0] int_ivt_8;
wire [15:0] int_ivt_9;
wire [16:0] int_sq_datin_2;
wire [16:0] int_sq_datin_3;
wire [16:0] int_sq_datin_4;
wire [16:0] int_sq_datin_5;
wire [16:0] int_sq_datin_6;
wire [16:0] int_sq_datin_7;
wire [16:0] int_sq_datin_8;
wire [16:0] int_sq_datin_9;
wire [16:0] int_sq_datin_abs_2;
wire [16:0] int_sq_datin_abs_3;
wire [16:0] int_sq_datin_abs_4;
wire [16:0] int_sq_datin_abs_5;
wire [16:0] int_sq_datin_abs_6;
wire [16:0] int_sq_datin_abs_7;
wire [16:0] int_sq_datin_abs_8;
wire [16:0] int_sq_datin_abs_9;
wire len3;
wire len5;
wire len7;
wire len9;
wire load_din;
wire load_din_2d;
wire load_din_d;
wire sum2itp_valid;
wire sum_out_prdy;
wire sum_out_pvld;
///////////////////////////////////////////
//==========================================
//----------------------------------------
//: my $tp=1;
//: my $icvto=(8 +1);
//: my $k = ${icvto}*(${tp}+8)+17;
//: &eperl::pipe(" -wid $k -do cdp_buf2sum_pd -vo cdp_buf2sum_valid -ri cdp_buf2sum_ready -di normalz_buf_data -vi normalz_buf_data_pvld -ro normalz_buf_data_prdy ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg pipe_normalz_buf_data_pvld;
reg [98-1:0] pipe_normalz_buf_data;
// Wire
wire normalz_buf_data_prdy;
wire pipe_normalz_buf_data_prdy;
wire cdp_buf2sum_valid;
wire [98-1:0] cdp_buf2sum_pd;
// Code
// PIPE READY
assign normalz_buf_data_prdy = pipe_normalz_buf_data_prdy || !pipe_normalz_buf_data_pvld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_normalz_buf_data_pvld <= 1'b0;
    end else begin
        if (normalz_buf_data_prdy) begin
            pipe_normalz_buf_data_pvld <= normalz_buf_data_pvld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (normalz_buf_data_prdy && normalz_buf_data_pvld) begin
        pipe_normalz_buf_data[98-1:0] <= normalz_buf_data[98-1:0];
    end
end


// PIPE OUTPUT
assign pipe_normalz_buf_data_prdy = cdp_buf2sum_ready;
assign cdp_buf2sum_valid = pipe_normalz_buf_data_pvld;
assign cdp_buf2sum_pd = pipe_normalz_buf_data;

//| eperl: generated_end (DO NOT EDIT ABOVE)
/////////////////////////////////////////////
assign load_din = (cdp_buf2sum_valid & buf2sum_rdy_f);
assign cdp_buf2sum_ready = buf2sum_rdy_f;
assign buf2sum_rdy_f = buf2sum_din_prdy;
//==========================================
//: my $icvto=(8 +1);
//: my $tp=1 +8;
//: foreach my $i (0..${tp}-1) {
//: print qq(
//: assign buf2sum_int8_$i = cdp_buf2sum_pd[${icvto}*${i}+${icvto}-1:${icvto}*${i}];
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign buf2sum_int8_0 = cdp_buf2sum_pd[9*0+9-1:9*0];

assign buf2sum_int8_1 = cdp_buf2sum_pd[9*1+9-1:9*1];

assign buf2sum_int8_2 = cdp_buf2sum_pd[9*2+9-1:9*2];

assign buf2sum_int8_3 = cdp_buf2sum_pd[9*3+9-1:9*3];

assign buf2sum_int8_4 = cdp_buf2sum_pd[9*4+9-1:9*4];

assign buf2sum_int8_5 = cdp_buf2sum_pd[9*5+9-1:9*5];

assign buf2sum_int8_6 = cdp_buf2sum_pd[9*6+9-1:9*6];

assign buf2sum_int8_7 = cdp_buf2sum_pd[9*7+9-1:9*7];

assign buf2sum_int8_8 = cdp_buf2sum_pd[9*8+9-1:9*8];

//| eperl: generated_end (DO NOT EDIT ABOVE)
//========================================================
//int mode
//--------------------------------------------------------
//: my $tp=1;
//: my $icvto=(8 +1);
//: foreach my $i (0..${tp}+8-1) {
//: print qq(
//: assign inv_${i} = buf2sum_int8_${i}[${icvto}-1] ? (~buf2sum_int8_${i}[${icvto}-2:0]) : {(${icvto}-1){1'b0}};
//: assign int8_abs_${i} = buf2sum_int8_${i}[${icvto}-1] ? (inv_${i}[${icvto}-2:0] + {{(${icvto}-2){1'b0}},1'b1}) : buf2sum_int8_${i};
//: );
//: }
//:
//: print qq(
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn) begin
//: );
//: foreach my $i (0..${tp}+8-1) {
//: print qq(
//: {mon_int8_sq_${i},int8_sq_${i}} <= {(${icvto}*2-1){1'b0}};
//: );
//: }
//: print qq(
//: end else if(load_din) begin
//: {mon_int8_sq_0,int8_sq_0} <= len9 ? (int8_abs_0 * int8_abs_0) : {(${icvto}*2){1'b0}};
//: {mon_int8_sq_1,int8_sq_1} <= ( len7|len9)? (int8_abs_1 * int8_abs_1) : {(${icvto}*2){1'b0}};
//: {mon_int8_sq_2,int8_sq_2} <= (len5|len7|len9)? (int8_abs_2 * int8_abs_2) : {(${icvto}*2){1'b0}};
//: {mon_int8_sq_3,int8_sq_3} <= (int8_abs_3 * int8_abs_3);
//: );
//: foreach my $i (0..${tp}-1) {
//: my $j = 4 + $i;
//: print "{mon_int8_sq_${j},int8_sq_${j}} <= (int8_abs_${j} * int8_abs_${j});  \n";
//: }
//: my $b0 = ${tp}+4+0;
//: my $b1 = ${tp}+4+1;
//: my $b2 = ${tp}+4+2;
//: my $b3 = ${tp}+4+3;
//: print qq(
//: {mon_int8_sq_${b0},int8_sq_${b0}} <= (int8_abs_${b0} * int8_abs_${b0});
//: {mon_int8_sq_${b1},int8_sq_${b1}} <= (len5|len7|len9)? (int8_abs_${b1} * int8_abs_${b1}) : {(${icvto}*2){1'b0}};
//: {mon_int8_sq_${b2},int8_sq_${b2}} <= ( len7|len9)? (int8_abs_${b2} * int8_abs_${b2}) : {(${icvto}*2){1'b0}};
//: {mon_int8_sq_${b3},int8_sq_${b3}} <= len9 ? (int8_abs_${b3} * int8_abs_${b3}) : {(${icvto}*2){1'b0}};
//: end
//: end
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign inv_0 = buf2sum_int8_0[9-1] ? (~buf2sum_int8_0[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_0 = buf2sum_int8_0[9-1] ? (inv_0[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_0;

assign inv_1 = buf2sum_int8_1[9-1] ? (~buf2sum_int8_1[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_1 = buf2sum_int8_1[9-1] ? (inv_1[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_1;

assign inv_2 = buf2sum_int8_2[9-1] ? (~buf2sum_int8_2[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_2 = buf2sum_int8_2[9-1] ? (inv_2[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_2;

assign inv_3 = buf2sum_int8_3[9-1] ? (~buf2sum_int8_3[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_3 = buf2sum_int8_3[9-1] ? (inv_3[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_3;

assign inv_4 = buf2sum_int8_4[9-1] ? (~buf2sum_int8_4[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_4 = buf2sum_int8_4[9-1] ? (inv_4[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_4;

assign inv_5 = buf2sum_int8_5[9-1] ? (~buf2sum_int8_5[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_5 = buf2sum_int8_5[9-1] ? (inv_5[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_5;

assign inv_6 = buf2sum_int8_6[9-1] ? (~buf2sum_int8_6[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_6 = buf2sum_int8_6[9-1] ? (inv_6[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_6;

assign inv_7 = buf2sum_int8_7[9-1] ? (~buf2sum_int8_7[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_7 = buf2sum_int8_7[9-1] ? (inv_7[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_7;

assign inv_8 = buf2sum_int8_8[9-1] ? (~buf2sum_int8_8[9-2:0]) : {(9-1){1'b0}};
assign int8_abs_8 = buf2sum_int8_8[9-1] ? (inv_8[9-2:0] + {{(9-2){1'b0}},1'b1}) : buf2sum_int8_8;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin

{mon_int8_sq_0,int8_sq_0} <= {(9*2-1){1'b0}};

{mon_int8_sq_1,int8_sq_1} <= {(9*2-1){1'b0}};

{mon_int8_sq_2,int8_sq_2} <= {(9*2-1){1'b0}};

{mon_int8_sq_3,int8_sq_3} <= {(9*2-1){1'b0}};

{mon_int8_sq_4,int8_sq_4} <= {(9*2-1){1'b0}};

{mon_int8_sq_5,int8_sq_5} <= {(9*2-1){1'b0}};

{mon_int8_sq_6,int8_sq_6} <= {(9*2-1){1'b0}};

{mon_int8_sq_7,int8_sq_7} <= {(9*2-1){1'b0}};

{mon_int8_sq_8,int8_sq_8} <= {(9*2-1){1'b0}};

end else if(load_din) begin
{mon_int8_sq_0,int8_sq_0} <= len9 ? (int8_abs_0 * int8_abs_0) : {(9*2){1'b0}};
{mon_int8_sq_1,int8_sq_1} <= ( len7|len9)? (int8_abs_1 * int8_abs_1) : {(9*2){1'b0}};
{mon_int8_sq_2,int8_sq_2} <= (len5|len7|len9)? (int8_abs_2 * int8_abs_2) : {(9*2){1'b0}};
{mon_int8_sq_3,int8_sq_3} <= (int8_abs_3 * int8_abs_3);
{mon_int8_sq_4,int8_sq_4} <= (int8_abs_4 * int8_abs_4);  

{mon_int8_sq_5,int8_sq_5} <= (int8_abs_5 * int8_abs_5);
{mon_int8_sq_6,int8_sq_6} <= (len5|len7|len9)? (int8_abs_6 * int8_abs_6) : {(9*2){1'b0}};
{mon_int8_sq_7,int8_sq_7} <= ( len7|len9)? (int8_abs_7 * int8_abs_7) : {(9*2){1'b0}};
{mon_int8_sq_8,int8_sq_8} <= len9 ? (int8_abs_8 * int8_abs_8) : {(9*2){1'b0}};
end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign buf2sum_din_prdy = ~buf2sum_d_vld | buf2sum_d_rdy;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    buf2sum_d_vld <= 1'b0;
  end else begin
    if(cdp_buf2sum_valid)
        buf2sum_d_vld <= 1'b1;
    else if(buf2sum_d_rdy)
        buf2sum_d_vld <= 1'b0;
  end
end
assign buf2sum_d_rdy = ~buf2sum_2d_vld | buf2sum_2d_rdy;
//===========
//sum process
//-----------
assign len3 = (reg2dp_normalz_len[1:0] == 2'h0 );
assign len5 = (reg2dp_normalz_len[1:0] == 2'h1 );
assign len7 = (reg2dp_normalz_len[1:0] == 2'h2 );
assign len9 = (reg2dp_normalz_len[1:0] == 2'h3 );
assign load_din_d = buf2sum_d_vld & buf2sum_d_rdy;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    buf2sum_2d_vld <= 1'b0;
  end else begin
    if(buf2sum_d_vld)
        buf2sum_2d_vld <= 1'b1;
    else if(buf2sum_2d_rdy)
        buf2sum_2d_vld <= 1'b0;
  end
end
assign buf2sum_2d_rdy = ~buf2sum_3d_vld | buf2sum_3d_rdy ;
assign load_din_2d = buf2sum_2d_vld & buf2sum_2d_rdy;
//: my $tp=1;
//: my $icvto=(8 +1);
//: foreach my $i (0..${tp}-1) {
//: print "int_sum_block_tp1 u_sum_block_$i ( \n";
//: print qq(
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.len5 (len5)
//: ,.len7 (len7)
//: ,.len9 (len9)
//: ,.load_din_2d (load_din_2d)
//: ,.load_din_d (load_din_d)
//: ,.reg2dp_normalz_len (reg2dp_normalz_len[1:0])
//: );
//:
//: foreach my $k (0..8) {
//: my $j = $k + $i;
//: print " ,.sq_pd_int8_${k}       (int8_sq_${j})  \n";
//: }
//: print qq(
//: ,.int8_sum (int8_sum_${i})
//: );
//: print "    ); \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
int_sum_block_tp1 u_sum_block_0 ( 

.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.len5 (len5)
,.len7 (len7)
,.len9 (len9)
,.load_din_2d (load_din_2d)
,.load_din_d (load_din_d)
,.reg2dp_normalz_len (reg2dp_normalz_len[1:0])
 ,.sq_pd_int8_0       (int8_sq_0)  
 ,.sq_pd_int8_1       (int8_sq_1)  
 ,.sq_pd_int8_2       (int8_sq_2)  
 ,.sq_pd_int8_3       (int8_sq_3)  
 ,.sq_pd_int8_4       (int8_sq_4)  
 ,.sq_pd_int8_5       (int8_sq_5)  
 ,.sq_pd_int8_6       (int8_sq_6)  
 ,.sq_pd_int8_7       (int8_sq_7)  
 ,.sq_pd_int8_8       (int8_sq_8)  

,.int8_sum (int8_sum_0)
    ); 

//| eperl: generated_end (DO NOT EDIT ABOVE)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    buf2sum_3d_vld <= 1'b0;
  end else begin
    if(buf2sum_2d_vld)
        buf2sum_3d_vld <= 1'b1;
    else if(buf2sum_3d_rdy)
        buf2sum_3d_vld <= 1'b0;
  end
end
assign buf2sum_3d_rdy = sum_out_prdy;
//=======================================================
//data output select
//-------------------------------------------------------
assign sum_out_pd = {
//: my $tp=1;
//: if($tp > 1){
//: foreach my $i (0..${tp}-2) {
//: my $j = ${tp} - $i -1;
//: print "int8_sum_${j}, ";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

//| eperl: generated_end (DO NOT EDIT ABOVE)
int8_sum_0};
assign sum_out_pvld = buf2sum_3d_vld;
////////////////////////////////////
//assign sum_out_prdy = sum2itp_ready;
////////////////////////////////////
assign sum2itp_valid = sum_out_pvld;
assign sum2itp_data = sum_out_pd;
//=======================================================
////////::pipe -bc -is sum2itp_pd (sum2itp_pvld,sum2itp_prdy) <= sum2itp_data (sum2itp_valid,sum2itp_ready);
//: my $k = 1*21;
//: &eperl::pipe("-wid $k -is -do sum2itp_pd -vo sum2itp_pvld -ri sum2itp_prdy -di sum2itp_data -vi sum2itp_valid -ro sum2itp_ready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg sum2itp_ready;
reg skid_flop_sum2itp_ready;
reg skid_flop_sum2itp_valid;
reg [21-1:0] skid_flop_sum2itp_data;
reg pipe_skid_sum2itp_valid;
reg [21-1:0] pipe_skid_sum2itp_data;
// Wire
wire skid_sum2itp_valid;
wire [21-1:0] skid_sum2itp_data;
wire skid_sum2itp_ready;
wire pipe_skid_sum2itp_ready;
wire sum2itp_pvld;
wire [21-1:0] sum2itp_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sum2itp_ready <= 1'b1;
       skid_flop_sum2itp_ready <= 1'b1;
   end else begin
       sum2itp_ready <= skid_sum2itp_ready;
       skid_flop_sum2itp_ready <= skid_sum2itp_ready;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_sum2itp_valid <= 1'b0;
    end else begin
        if (skid_flop_sum2itp_ready) begin
            skid_flop_sum2itp_valid <= sum2itp_valid;
        end
   end
end
assign skid_sum2itp_valid = (skid_flop_sum2itp_ready) ? sum2itp_valid : skid_flop_sum2itp_valid;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_sum2itp_ready & sum2itp_valid) begin
        skid_flop_sum2itp_data[21-1:0] <= sum2itp_data[21-1:0];
    end
end
assign skid_sum2itp_data[21-1:0] = (skid_flop_sum2itp_ready) ? sum2itp_data[21-1:0] : skid_flop_sum2itp_data[21-1:0];


// PIPE READY
assign skid_sum2itp_ready = pipe_skid_sum2itp_ready || !pipe_skid_sum2itp_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_sum2itp_valid <= 1'b0;
    end else begin
        if (skid_sum2itp_ready) begin
            pipe_skid_sum2itp_valid <= skid_sum2itp_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_sum2itp_ready && skid_sum2itp_valid) begin
        pipe_skid_sum2itp_data[21-1:0] <= skid_sum2itp_data[21-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_sum2itp_ready = sum2itp_prdy;
assign sum2itp_pvld = pipe_skid_sum2itp_valid;
assign sum2itp_pd = pipe_skid_sum2itp_data;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign sum_out_prdy = sum2itp_ready;
/////////////////////////////////////////////////////////
endmodule // NV_NVDLA_CDP_DP_sum
