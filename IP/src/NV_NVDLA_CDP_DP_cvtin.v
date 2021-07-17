// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_DP_cvtin.v
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
module NV_NVDLA_CDP_DP_cvtin (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cdp_rdma2dp_pd //|< i
  ,cdp_rdma2dp_valid //|< i
  ,cvt2buf_prdy //|< i
  ,cvt2sync_prdy //|< i
  ,reg2dp_datin_offset //|< i
  ,reg2dp_datin_scale //|< i
  ,reg2dp_datin_shifter //|< i
  ,cdp_rdma2dp_ready //|> o
  ,cvt2buf_pd //|> o
  ,cvt2buf_pvld //|> o
  ,cvt2sync_pd //|> o
  ,cvt2sync_pvld //|> o
  );
////////////////////////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
input [1*8 +24:0] cdp_rdma2dp_pd;
input cdp_rdma2dp_valid;
output cdp_rdma2dp_ready;
input [15:0] reg2dp_datin_offset;// need fix to bw, 8bits at int8 mode
input [15:0] reg2dp_datin_scale;
input [4:0] reg2dp_datin_shifter;
output [1*(8 +1)+16:0] cvt2buf_pd;
output cvt2buf_pvld;
input cvt2buf_prdy;
output [1*(8 +1)+16:0] cvt2sync_pd;
output cvt2sync_pvld;
input cvt2sync_prdy;
////////////////////////////////////////////////////////////////////////
reg [15:0] reg2dp_datin_offset_use;
reg [15:0] reg2dp_datin_scale_use;
reg [4:0] reg2dp_datin_shifter_use;
//: my $k=1;
//: my $icvti=8;
//: my $icvto=(8 +1);
//: foreach my $m (0..$k-1) {
//: print "wire   [${icvti}-1:0] cdp_cvtin_input_pd_$m;  \n";
//: print "wire   [${icvto}-1:0] cdp_cvtin_output_pd_$m;// bw   \n";
//: }
//: print "wire   [${k}-1:0]      cdp_cvtin_input_rdy;  \n";
//: print "wire   [${k}-1:0]      cdp_cvtin_input_vld;  \n";
//: print "wire   [${k}-1:0]      cdp_cvtin_output_rdy;  \n";
//: print "wire   [${k}-1:0]      cdp_cvtin_output_vld;  \n";
//: print "wire   [${k}*${icvto}-1:0]    cdp_cvtin_output_pd;  \n";
//: print "wire   [${k}*${icvto}-1:0]    icvt_out_pd;  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire   [8-1:0] cdp_cvtin_input_pd_0;  
wire   [9-1:0] cdp_cvtin_output_pd_0;// bw   
wire   [1-1:0]      cdp_cvtin_input_rdy;  
wire   [1-1:0]      cdp_cvtin_input_vld;  
wire   [1-1:0]      cdp_cvtin_output_rdy;  
wire   [1-1:0]      cdp_cvtin_output_vld;  
wire   [1*9-1:0]    cdp_cvtin_output_pd;  
wire   [1*9-1:0]    icvt_out_pd;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire cdp_cvtin_input_rdy_f;
wire cdp_cvtin_input_vld_f;
wire cdp_cvtin_output_rdy_f;
wire cdp_cvtin_output_vld_f;
wire cvtin_o_prdy;
wire cvtin_o_pvld;
wire [24:0] data_info_in_pd;
wire [24:0] data_info_in_pd_d0;
//wire [24:0] data_info_in_pd_d1;
//wire [24:0] data_info_in_pd_d2;
//wire [24:0] data_info_in_pd_d3;
wire data_info_in_rdy;
//wire data_info_in_rdy_d0;
//wire data_info_in_rdy_d1;
//wire data_info_in_rdy_d2;
wire data_info_in_rdy_d1_f ;
wire data_info_in_rdy_d2_f ;
wire data_info_in_rdy_d3;
wire data_info_in_vld;
wire data_info_in_vld_d0;
//wire data_info_in_vld_d1;
//wire data_info_in_vld_d2;
//wire data_info_in_vld_d3;
wire [24:0] data_info_out_pd;
wire data_info_out_rdy;
wire data_info_out_vld;
wire [1 -1:0] invalid_flag;
//////////////////////////////////
assign cdp_rdma2dp_ready = cdp_cvtin_input_rdy_f & data_info_in_rdy;
//===============================================
//pipeline delay for data info to sync with data path
//-----------------------------------------------
//data info valid in
assign data_info_in_vld = cdp_rdma2dp_valid & cdp_cvtin_input_rdy_f;
assign data_info_in_pd = cdp_rdma2dp_pd[1*8 +24:1*8];
assign data_info_in_vld_d0 = data_info_in_vld;
//assign data_info_in_rdy = data_info_in_rdy_d0;
assign data_info_in_pd_d0[24:0] = data_info_in_pd[24:0];
//: &eperl::pipe(" -wid 25 -is -do data_info_in_pd_d1 -vo data_info_in_vld_d1 -ri data_info_in_rdy_d1_f -di data_info_in_pd_d0  -vi data_info_in_vld_d0 -ro data_info_in_rdy_d0 ");
//: &eperl::pipe(" -wid 25 -is -do data_info_in_pd_d2 -vo data_info_in_vld_d2 -ri data_info_in_rdy_d2_f -di data_info_in_pd_d1  -vi data_info_in_vld_d1 -ro data_info_in_rdy_d1 ");
//: &eperl::pipe(" -wid 25 -is -do data_info_in_pd_d3 -vo data_info_in_vld_d3 -ri data_info_in_rdy_d3 -di data_info_in_pd_d2  -vi data_info_in_vld_d2 -ro data_info_in_rdy_d2 ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg data_info_in_rdy_d0;
reg skid_flop_data_info_in_rdy_d0;
reg skid_flop_data_info_in_vld_d0;
reg [25-1:0] skid_flop_data_info_in_pd_d0;
reg pipe_skid_data_info_in_vld_d0;
reg [25-1:0] pipe_skid_data_info_in_pd_d0;
// Wire
wire skid_data_info_in_vld_d0;
wire [25-1:0] skid_data_info_in_pd_d0;
wire skid_data_info_in_rdy_d0;
wire pipe_skid_data_info_in_rdy_d0;
wire data_info_in_vld_d1;
wire [25-1:0] data_info_in_pd_d1;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_info_in_rdy_d0 <= 1'b1;
       skid_flop_data_info_in_rdy_d0 <= 1'b1;
   end else begin
       data_info_in_rdy_d0 <= skid_data_info_in_rdy_d0;
       skid_flop_data_info_in_rdy_d0 <= skid_data_info_in_rdy_d0;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_data_info_in_vld_d0 <= 1'b0;
    end else begin
        if (skid_flop_data_info_in_rdy_d0) begin
            skid_flop_data_info_in_vld_d0 <= data_info_in_vld_d0;
        end
   end
end
assign skid_data_info_in_vld_d0 = (skid_flop_data_info_in_rdy_d0) ? data_info_in_vld_d0 : skid_flop_data_info_in_vld_d0;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_data_info_in_rdy_d0 & data_info_in_vld_d0) begin
        skid_flop_data_info_in_pd_d0[25-1:0] <= data_info_in_pd_d0[25-1:0];
    end
end
assign skid_data_info_in_pd_d0[25-1:0] = (skid_flop_data_info_in_rdy_d0) ? data_info_in_pd_d0[25-1:0] : skid_flop_data_info_in_pd_d0[25-1:0];


// PIPE READY
assign skid_data_info_in_rdy_d0 = pipe_skid_data_info_in_rdy_d0 || !pipe_skid_data_info_in_vld_d0;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_data_info_in_vld_d0 <= 1'b0;
    end else begin
        if (skid_data_info_in_rdy_d0) begin
            pipe_skid_data_info_in_vld_d0 <= skid_data_info_in_vld_d0;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_data_info_in_rdy_d0 && skid_data_info_in_vld_d0) begin
        pipe_skid_data_info_in_pd_d0[25-1:0] <= skid_data_info_in_pd_d0[25-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_data_info_in_rdy_d0 = data_info_in_rdy_d1_f;
assign data_info_in_vld_d1 = pipe_skid_data_info_in_vld_d0;
assign data_info_in_pd_d1 = pipe_skid_data_info_in_pd_d0;
// Reg
reg data_info_in_rdy_d1;
reg skid_flop_data_info_in_rdy_d1;
reg skid_flop_data_info_in_vld_d1;
reg [25-1:0] skid_flop_data_info_in_pd_d1;
reg pipe_skid_data_info_in_vld_d1;
reg [25-1:0] pipe_skid_data_info_in_pd_d1;
// Wire
wire skid_data_info_in_vld_d1;
wire [25-1:0] skid_data_info_in_pd_d1;
wire skid_data_info_in_rdy_d1;
wire pipe_skid_data_info_in_rdy_d1;
wire data_info_in_vld_d2;
wire [25-1:0] data_info_in_pd_d2;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_info_in_rdy_d1 <= 1'b1;
       skid_flop_data_info_in_rdy_d1 <= 1'b1;
   end else begin
       data_info_in_rdy_d1 <= skid_data_info_in_rdy_d1;
       skid_flop_data_info_in_rdy_d1 <= skid_data_info_in_rdy_d1;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_data_info_in_vld_d1 <= 1'b0;
    end else begin
        if (skid_flop_data_info_in_rdy_d1) begin
            skid_flop_data_info_in_vld_d1 <= data_info_in_vld_d1;
        end
   end
end
assign skid_data_info_in_vld_d1 = (skid_flop_data_info_in_rdy_d1) ? data_info_in_vld_d1 : skid_flop_data_info_in_vld_d1;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_data_info_in_rdy_d1 & data_info_in_vld_d1) begin
        skid_flop_data_info_in_pd_d1[25-1:0] <= data_info_in_pd_d1[25-1:0];
    end
end
assign skid_data_info_in_pd_d1[25-1:0] = (skid_flop_data_info_in_rdy_d1) ? data_info_in_pd_d1[25-1:0] : skid_flop_data_info_in_pd_d1[25-1:0];


// PIPE READY
assign skid_data_info_in_rdy_d1 = pipe_skid_data_info_in_rdy_d1 || !pipe_skid_data_info_in_vld_d1;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_data_info_in_vld_d1 <= 1'b0;
    end else begin
        if (skid_data_info_in_rdy_d1) begin
            pipe_skid_data_info_in_vld_d1 <= skid_data_info_in_vld_d1;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_data_info_in_rdy_d1 && skid_data_info_in_vld_d1) begin
        pipe_skid_data_info_in_pd_d1[25-1:0] <= skid_data_info_in_pd_d1[25-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_data_info_in_rdy_d1 = data_info_in_rdy_d2_f;
assign data_info_in_vld_d2 = pipe_skid_data_info_in_vld_d1;
assign data_info_in_pd_d2 = pipe_skid_data_info_in_pd_d1;
// Reg
reg data_info_in_rdy_d2;
reg skid_flop_data_info_in_rdy_d2;
reg skid_flop_data_info_in_vld_d2;
reg [25-1:0] skid_flop_data_info_in_pd_d2;
reg pipe_skid_data_info_in_vld_d2;
reg [25-1:0] pipe_skid_data_info_in_pd_d2;
// Wire
wire skid_data_info_in_vld_d2;
wire [25-1:0] skid_data_info_in_pd_d2;
wire skid_data_info_in_rdy_d2;
wire pipe_skid_data_info_in_rdy_d2;
wire data_info_in_vld_d3;
wire [25-1:0] data_info_in_pd_d3;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_info_in_rdy_d2 <= 1'b1;
       skid_flop_data_info_in_rdy_d2 <= 1'b1;
   end else begin
       data_info_in_rdy_d2 <= skid_data_info_in_rdy_d2;
       skid_flop_data_info_in_rdy_d2 <= skid_data_info_in_rdy_d2;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_data_info_in_vld_d2 <= 1'b0;
    end else begin
        if (skid_flop_data_info_in_rdy_d2) begin
            skid_flop_data_info_in_vld_d2 <= data_info_in_vld_d2;
        end
   end
end
assign skid_data_info_in_vld_d2 = (skid_flop_data_info_in_rdy_d2) ? data_info_in_vld_d2 : skid_flop_data_info_in_vld_d2;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_data_info_in_rdy_d2 & data_info_in_vld_d2) begin
        skid_flop_data_info_in_pd_d2[25-1:0] <= data_info_in_pd_d2[25-1:0];
    end
end
assign skid_data_info_in_pd_d2[25-1:0] = (skid_flop_data_info_in_rdy_d2) ? data_info_in_pd_d2[25-1:0] : skid_flop_data_info_in_pd_d2[25-1:0];


// PIPE READY
assign skid_data_info_in_rdy_d2 = pipe_skid_data_info_in_rdy_d2 || !pipe_skid_data_info_in_vld_d2;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_data_info_in_vld_d2 <= 1'b0;
    end else begin
        if (skid_data_info_in_rdy_d2) begin
            pipe_skid_data_info_in_vld_d2 <= skid_data_info_in_vld_d2;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_data_info_in_rdy_d2 && skid_data_info_in_vld_d2) begin
        pipe_skid_data_info_in_pd_d2[25-1:0] <= skid_data_info_in_pd_d2[25-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_data_info_in_rdy_d2 = data_info_in_rdy_d3;
assign data_info_in_vld_d3 = pipe_skid_data_info_in_vld_d2;
assign data_info_in_pd_d3 = pipe_skid_data_info_in_pd_d2;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign data_info_in_rdy = data_info_in_rdy_d0;
assign data_info_in_rdy_d1_f = data_info_in_rdy_d1;
assign data_info_in_rdy_d2_f = data_info_in_rdy_d2;
assign data_info_out_vld = data_info_in_vld_d3;
assign data_info_in_rdy_d3 = data_info_out_rdy;
assign data_info_out_pd[24:0] = data_info_in_pd_d3[24:0];
//===============================================
//convertor process
//-----------------------------------------------
//cvtin valid input
assign cdp_cvtin_input_vld_f = cdp_rdma2dp_valid & data_info_in_rdy;
//cvtin ready input
assign cdp_cvtin_input_rdy_f = &cdp_cvtin_input_rdy[1 -1:0];
//cvt sub-unit valid in
//: my $k=1;
//: if(${k}>1) {
//: foreach my $m (0..$k-1) {
//: print "assign cdp_cvtin_input_vld[${m}] = cdp_cvtin_input_vld_f ";
//: foreach my $n (0..$k-1) {
//: if($n != $m) {
//: print "& cdp_cvtin_input_rdy[$n] ";
//: }
//: }
//: print ";   \n";
//: }
//: }
//: elsif(${k}==1) {
//: print "assign cdp_cvtin_input_vld = cdp_cvtin_input_vld_f;    \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign cdp_cvtin_input_vld = cdp_cvtin_input_vld_f;    

//| eperl: generated_end (DO NOT EDIT ABOVE)
//cvt sub-unit data in
//: my $k=1;
//: my $cdpbw=8;
//: foreach my $m (0..$k-1) {
//: print "assign cdp_cvtin_input_pd_${m} = cdp_rdma2dp_pd[${cdpbw}*${m}+${cdpbw}-1:${cdpbw}*${m}];  \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign cdp_cvtin_input_pd_0 = cdp_rdma2dp_pd[8*0+8-1:8*0];  

//| eperl: generated_end (DO NOT EDIT ABOVE)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_datin_offset_use <= {16{1'b0}};
  end else begin
  reg2dp_datin_offset_use <= reg2dp_datin_offset[15:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_datin_scale_use <= {16{1'b0}};
  end else begin
  reg2dp_datin_scale_use <= reg2dp_datin_scale[15:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_datin_shifter_use <= {5{1'b0}};
  end else begin
  reg2dp_datin_shifter_use <= reg2dp_datin_shifter[4:0];
  end
end
//: my $k=1;
//: my $icvti=8;
//: my $icvto=(8 +1);
//: foreach my $m (0..$k-1) {
//: print qq(
//: HLS_cdp_icvt u_HLS_cdp_icvt_$m (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.chn_data_in_rsc_z (cdp_cvtin_input_pd_${m})
//: ,.chn_data_in_rsc_vz (cdp_cvtin_input_vld[$m])
//: ,.chn_data_in_rsc_lz (cdp_cvtin_input_rdy[$m])
//: ,.cfg_alu_in_rsc_z (reg2dp_datin_offset_use[7:0]) // need change bw 
//: ,.cfg_mul_in_rsc_z (reg2dp_datin_scale_use[15:0])
//: ,.cfg_truncate_rsc_z (reg2dp_datin_shifter_use[4:0])
//: ,.chn_data_out_rsc_z (cdp_cvtin_output_pd_${m})
//: ,.chn_data_out_rsc_vz (cdp_cvtin_output_rdy[$m])
//: ,.chn_data_out_rsc_lz (cdp_cvtin_output_vld[$m])
//: );
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

HLS_cdp_icvt u_HLS_cdp_icvt_0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.chn_data_in_rsc_z (cdp_cvtin_input_pd_0)
,.chn_data_in_rsc_vz (cdp_cvtin_input_vld[0])
,.chn_data_in_rsc_lz (cdp_cvtin_input_rdy[0])
,.cfg_alu_in_rsc_z (reg2dp_datin_offset_use[7:0]) // need change bw 
,.cfg_mul_in_rsc_z (reg2dp_datin_scale_use[15:0])
,.cfg_truncate_rsc_z (reg2dp_datin_shifter_use[4:0])
,.chn_data_out_rsc_z (cdp_cvtin_output_pd_0)
,.chn_data_out_rsc_vz (cdp_cvtin_output_rdy[0])
,.chn_data_out_rsc_lz (cdp_cvtin_output_vld[0])
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//sub-unit output ready
//: my $k=1;
//: if(${k}>1) {
//: foreach my $m (0..$k-1) {
//: print "assign cdp_cvtin_output_rdy[${m}] = cdp_cvtin_output_rdy_f ";
//: foreach my $n (0..$k-1) {
//: if($n != $m) {
//: print "& cdp_cvtin_output_vld[$n] ";
//: }
//: }
//: print ";   \n";
//: }
//: }
//: elsif(${k}==1) {
//: print "assign cdp_cvtin_output_rdy = cdp_cvtin_output_rdy_f;    \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign cdp_cvtin_output_rdy = cdp_cvtin_output_rdy_f;    

//| eperl: generated_end (DO NOT EDIT ABOVE)
//output valid
assign cdp_cvtin_output_vld_f = &cdp_cvtin_output_vld;
//output ready
assign cdp_cvtin_output_rdy_f = cvtin_o_prdy & data_info_out_vld;
//output data
//: my $k=1;
//: print "assign cdp_cvtin_output_pd  = { ";
//: if(${k}>1) {
//: foreach my $n (0..$k-2) {
//: my $i=$k-$n -1;
//: print "cdp_cvtin_output_pd_${i}, ";
//: }
//: }
//: print "cdp_cvtin_output_pd_0};   \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign cdp_cvtin_output_pd  = { cdp_cvtin_output_pd_0};   

//| eperl: generated_end (DO NOT EDIT ABOVE)
//===============================================
//data info output
//-----------------------------------------------
//data info output ready
assign data_info_out_rdy = cvtin_o_prdy & cdp_cvtin_output_vld_f;
//===============================================
//convertor output
//-----------------------------------------------
assign cvtin_o_prdy = cvt2buf_prdy & cvt2sync_prdy;
assign cvtin_o_pvld = cdp_cvtin_output_vld_f & data_info_out_vld;
assign invalid_flag = data_info_out_pd[17+1 -1:17];
//: my $k=1;
//: my $cdpbw=(8 +1);
//: print "assign icvt_out_pd = {   ";
//: if(${k}>1) {
//: foreach my $m (0..$k-2) {
//: my $i = $k -$m -1;
//: print "(invalid_flag[$i] ? {${cdpbw}{1'b0}} : cdp_cvtin_output_pd[${cdpbw}*${i}+${cdpbw}-1:${cdpbw}*${i}]), \n";
//: }
//: }
//: print " ({${cdpbw}{(~invalid_flag[0])}} & cdp_cvtin_output_pd[${cdpbw}-1:0])};  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign icvt_out_pd = {    ({9{(~invalid_flag[0])}} & cdp_cvtin_output_pd[9-1:0])};  

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign cvt2buf_pd = {data_info_out_pd[16:0],icvt_out_pd};
assign cvt2buf_pvld = cvtin_o_pvld & cvt2sync_prdy;
assign cvt2sync_pvld = cvtin_o_pvld & cvt2buf_prdy;
assign cvt2sync_pd = {data_info_out_pd[16:0],icvt_out_pd};
//////////////////////////////////////////////////////////////////////
endmodule // NV_NVDLA_CDP_DP_cvtin
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none data_info_in_pd_d1[22:0] (data_info_in_vld_d1,data_info_in_rdy_d1) <= data_info_in_pd_d0[22:0] (data_info_in_vld_d0,data_info_in_rdy_d0)
// **************************************************************************************************************
module NV_NVDLA_CDP_DP_CVTIN_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,data_info_in_pd_d0
  ,data_info_in_rdy_d1
  ,data_info_in_vld_d0
  ,data_info_in_pd_d1
  ,data_info_in_rdy_d0
  ,data_info_in_vld_d1
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [22:0] data_info_in_pd_d0;
input data_info_in_rdy_d1;
input data_info_in_vld_d0;
output [22:0] data_info_in_pd_d1;
output data_info_in_rdy_d0;
output data_info_in_vld_d1;
reg [22:0] data_info_in_pd_d1;
reg data_info_in_rdy_d0;
reg data_info_in_vld_d1;
reg [22:0] p1_pipe_data;
reg p1_pipe_ready;
reg p1_pipe_ready_bc;
reg p1_pipe_valid;
//## pipe (1) valid-ready-bubble-collapse
always @(
  p1_pipe_ready
  or p1_pipe_valid
  ) begin
  p1_pipe_ready_bc = p1_pipe_ready || !p1_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p1_pipe_valid <= 1'b0;
  end else begin
  p1_pipe_valid <= (p1_pipe_ready_bc)? data_info_in_vld_d0 : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p1_pipe_data <= (p1_pipe_ready_bc && data_info_in_vld_d0)? data_info_in_pd_d0[22:0] : p1_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p1_pipe_ready_bc
  ) begin
  data_info_in_rdy_d0 = p1_pipe_ready_bc;
end
//## pipe (1) output
always @(
  p1_pipe_valid
  or data_info_in_rdy_d1
  or p1_pipe_data
  ) begin
  data_info_in_vld_d1 = p1_pipe_valid;
  p1_pipe_ready = data_info_in_rdy_d1;
  data_info_in_pd_d1[22:0] = p1_pipe_data;
end
//## pipe (1) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p1_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_1x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (data_info_in_vld_d1^data_info_in_rdy_d1^data_info_in_vld_d0^data_info_in_rdy_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_2x (nvdla_core_clk, `ASSERT_RESET, (data_info_in_vld_d0 && !data_info_in_rdy_d0), (data_info_in_vld_d0), (data_info_in_rdy_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
`endif
endmodule // NV_NVDLA_CDP_DP_CVTIN_pipe_p1
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none data_info_in_pd_d2[22:0] (data_info_in_vld_d2,data_info_in_rdy_d2) <= data_info_in_pd_d1[22:0] (data_info_in_vld_d1,data_info_in_rdy_d1)
// **************************************************************************************************************
module NV_NVDLA_CDP_DP_CVTIN_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,data_info_in_pd_d1
  ,data_info_in_rdy_d2
  ,data_info_in_vld_d1
  ,data_info_in_pd_d2
  ,data_info_in_rdy_d1
  ,data_info_in_vld_d2
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [22:0] data_info_in_pd_d1;
input data_info_in_rdy_d2;
input data_info_in_vld_d1;
output [22:0] data_info_in_pd_d2;
output data_info_in_rdy_d1;
output data_info_in_vld_d2;
reg [22:0] data_info_in_pd_d2;
reg data_info_in_rdy_d1;
reg data_info_in_vld_d2;
reg [22:0] p2_pipe_data;
reg p2_pipe_ready;
reg p2_pipe_ready_bc;
reg p2_pipe_valid;
//## pipe (2) valid-ready-bubble-collapse
always @(
  p2_pipe_ready
  or p2_pipe_valid
  ) begin
  p2_pipe_ready_bc = p2_pipe_ready || !p2_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p2_pipe_valid <= 1'b0;
  end else begin
  p2_pipe_valid <= (p2_pipe_ready_bc)? data_info_in_vld_d1 : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p2_pipe_data <= (p2_pipe_ready_bc && data_info_in_vld_d1)? data_info_in_pd_d1[22:0] : p2_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p2_pipe_ready_bc
  ) begin
  data_info_in_rdy_d1 = p2_pipe_ready_bc;
end
//## pipe (2) output
always @(
  p2_pipe_valid
  or data_info_in_rdy_d2
  or p2_pipe_data
  ) begin
  data_info_in_vld_d2 = p2_pipe_valid;
  p2_pipe_ready = data_info_in_rdy_d2;
  data_info_in_pd_d2[22:0] = p2_pipe_data;
end
//## pipe (2) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p2_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (data_info_in_vld_d2^data_info_in_rdy_d2^data_info_in_vld_d1^data_info_in_rdy_d1)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_4x (nvdla_core_clk, `ASSERT_RESET, (data_info_in_vld_d1 && !data_info_in_rdy_d1), (data_info_in_vld_d1), (data_info_in_rdy_d1)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
`endif
endmodule // NV_NVDLA_CDP_DP_CVTIN_pipe_p2
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none data_info_in_pd_d3[22:0] (data_info_in_vld_d3,data_info_in_rdy_d3) <= data_info_in_pd_d2[22:0] (data_info_in_vld_d2,data_info_in_rdy_d2)
// **************************************************************************************************************
module NV_NVDLA_CDP_DP_CVTIN_pipe_p3 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,data_info_in_pd_d2
  ,data_info_in_rdy_d3
  ,data_info_in_vld_d2
  ,data_info_in_pd_d3
  ,data_info_in_rdy_d2
  ,data_info_in_vld_d3
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [22:0] data_info_in_pd_d2;
input data_info_in_rdy_d3;
input data_info_in_vld_d2;
output [22:0] data_info_in_pd_d3;
output data_info_in_rdy_d2;
output data_info_in_vld_d3;
reg [22:0] data_info_in_pd_d3;
reg data_info_in_rdy_d2;
reg data_info_in_vld_d3;
reg [22:0] p3_pipe_data;
reg p3_pipe_ready;
reg p3_pipe_ready_bc;
reg p3_pipe_valid;
//## pipe (3) valid-ready-bubble-collapse
always @(
  p3_pipe_ready
  or p3_pipe_valid
  ) begin
  p3_pipe_ready_bc = p3_pipe_ready || !p3_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p3_pipe_valid <= 1'b0;
  end else begin
  p3_pipe_valid <= (p3_pipe_ready_bc)? data_info_in_vld_d2 : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p3_pipe_data <= (p3_pipe_ready_bc && data_info_in_vld_d2)? data_info_in_pd_d2[22:0] : p3_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p3_pipe_ready_bc
  ) begin
  data_info_in_rdy_d2 = p3_pipe_ready_bc;
end
//## pipe (3) output
always @(
  p3_pipe_valid
  or data_info_in_rdy_d3
  or p3_pipe_data
  ) begin
  data_info_in_vld_d3 = p3_pipe_valid;
  p3_pipe_ready = data_info_in_rdy_d3;
  data_info_in_pd_d3[22:0] = p3_pipe_data;
end
//## pipe (3) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p3_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_5x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (data_info_in_vld_d3^data_info_in_rdy_d3^data_info_in_vld_d2^data_info_in_rdy_d2)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_6x (nvdla_core_clk, `ASSERT_RESET, (data_info_in_vld_d2 && !data_info_in_rdy_d2), (data_info_in_vld_d2), (data_info_in_rdy_d2)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
`endif
endmodule // NV_NVDLA_CDP_DP_CVTIN_pipe_p3
