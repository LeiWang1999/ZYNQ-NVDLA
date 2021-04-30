// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_DP_cvtout.v
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
module NV_NVDLA_CDP_DP_cvtout (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cvtout_prdy //|< i
  ,mul2ocvt_pd //|< i
  ,mul2ocvt_pvld //|< i
  ,reg2dp_datout_offset //|< i
  ,reg2dp_datout_scale //|< i
  ,reg2dp_datout_shifter //|< i
  ,sync2ocvt_pd //|< i
  ,sync2ocvt_pvld //|< i
  ,cvtout_pd //|> o
  ,cvtout_pvld //|> o
  ,mul2ocvt_prdy //|> o
  ,sync2ocvt_prdy //|> o
  );
///////////////////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
input cvtout_prdy;
//: my $k = 1;
//: my $icvto = (8 +1);
//: my $ocvti = $icvto + 16;
//: my $ocvto = 8;
//: print "input  [${k}*${ocvti}-1:0] mul2ocvt_pd;  \n";
//: print "output  [${k}*${ocvto}+16:0] cvtout_pd;  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
input  [1*25-1:0] mul2ocvt_pd;  
output  [1*8+16:0] cvtout_pd;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
input mul2ocvt_pvld;
input [31:0] reg2dp_datout_offset;
input [15:0] reg2dp_datout_scale;
input [5:0] reg2dp_datout_shifter;
input [16:0] sync2ocvt_pd;
input sync2ocvt_pvld;
output cvtout_pvld;
output mul2ocvt_prdy;
output sync2ocvt_prdy;
///////////////////////////////////////////////////////////////////
reg layer_flag;
reg [31:0] reg2dp_datout_offset_use;
reg [15:0] reg2dp_datout_scale_use;
reg [5:0] reg2dp_datout_shifter_use;
wire cdp_cvtout_in_ready;
wire cdp_cvtout_in_valid;
//: my $k = 1;
//: my $icvto = (8 +1);
//: my $ocvti = $icvto + 16;
//: my $ocvto = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: wire [${ocvti}-1:0] cdp_cvtout_input_pd_$m;
//: wire [${ocvto}-1:0] cdp_cvtout_output_pd_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [25-1:0] cdp_cvtout_input_pd_0;
wire [8-1:0] cdp_cvtout_output_pd_0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire cdp_cvtout_input_rdy;
wire cdp_cvtout_input_vld;
wire [1 -1:0] cdp_cvtout_input_rdys;
wire [1 -1:0] cdp_cvtout_input_vlds;
wire [1*8 -1:0] cdp_cvtout_output_pd;
wire [1 -1:0] cdp_cvtout_output_rdys;
wire [1 -1:0] cdp_cvtout_output_vlds;
wire cdp_cvtout_output_rdy;
wire cdp_cvtout_output_vld;
wire [16:0] data_info_in_pd;
wire [16:0] data_info_in_pd_d0;
//wire [16:0] data_info_in_pd_d1;
//wire [16:0] data_info_in_pd_d2;
//wire [16:0] data_info_in_pd_d3;
//wire [16:0] data_info_in_pd_d4;
wire data_info_in_rdy;
//wire data_info_in_rdy_d0;
//wire data_info_in_rdy_d1;
//wire data_info_in_rdy_d2;
//wire data_info_in_rdy_d3;
wire data_info_in_rdy_d4;
wire data_info_in_rdy_d1_f;
wire data_info_in_rdy_d2_f;
wire data_info_in_rdy_d3_f;
wire data_info_in_vld;
wire data_info_in_vld_d0;
//wire data_info_in_vld_d1;
//wire data_info_in_vld_d2;
//wire data_info_in_vld_d3;
//wire data_info_in_vld_d4;
wire [16:0] data_info_out_pd;
wire data_info_out_rdy;
wire data_info_out_vld;
///////////////////////////////////////////////////////////////////
//----------------------------------------
//interlock between data and info
assign cdp_cvtout_in_valid = sync2ocvt_pvld & mul2ocvt_pvld;
assign mul2ocvt_prdy = cdp_cvtout_in_ready & sync2ocvt_pvld;
assign sync2ocvt_prdy = cdp_cvtout_in_ready & mul2ocvt_pvld;
/////////////////////////////
assign cdp_cvtout_in_ready = cdp_cvtout_input_rdy & data_info_in_rdy;
//===============================================
//pipeline delay for data info to sync with data path
//-----------------------------------------------
//data info valid in
assign data_info_in_vld = cdp_cvtout_in_valid & cdp_cvtout_input_rdy;
//data info data in
assign data_info_in_pd[16:0] = sync2ocvt_pd[16:0];
assign data_info_in_vld_d0 = data_info_in_vld;
//assign data_info_in_rdy = data_info_in_rdy_d0;
assign data_info_in_pd_d0[16:0] = data_info_in_pd[16:0];
//: &eperl::pipe(" -wid 17 -is -do data_info_in_pd_d1 -vo data_info_in_vld_d1 -ri data_info_in_rdy_d1_f -di data_info_in_pd_d0  -vi data_info_in_vld_d0 -ro data_info_in_rdy_d0 ");
//: &eperl::pipe(" -wid 17 -is -do data_info_in_pd_d2 -vo data_info_in_vld_d2 -ri data_info_in_rdy_d2_f -di data_info_in_pd_d1  -vi data_info_in_vld_d1 -ro data_info_in_rdy_d1 ");
//: &eperl::pipe(" -wid 17 -is -do data_info_in_pd_d3 -vo data_info_in_vld_d3 -ri data_info_in_rdy_d3_f -di data_info_in_pd_d2  -vi data_info_in_vld_d2 -ro data_info_in_rdy_d2 ");
//: &eperl::pipe(" -wid 17 -is -do data_info_in_pd_d4 -vo data_info_in_vld_d4 -ri data_info_in_rdy_d4 -di data_info_in_pd_d3  -vi data_info_in_vld_d3 -ro data_info_in_rdy_d3 ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg data_info_in_rdy_d0;
reg skid_flop_data_info_in_rdy_d0;
reg skid_flop_data_info_in_vld_d0;
reg [17-1:0] skid_flop_data_info_in_pd_d0;
reg pipe_skid_data_info_in_vld_d0;
reg [17-1:0] pipe_skid_data_info_in_pd_d0;
// Wire
wire skid_data_info_in_vld_d0;
wire [17-1:0] skid_data_info_in_pd_d0;
wire skid_data_info_in_rdy_d0;
wire pipe_skid_data_info_in_rdy_d0;
wire data_info_in_vld_d1;
wire [17-1:0] data_info_in_pd_d1;
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
        skid_flop_data_info_in_pd_d0[17-1:0] <= data_info_in_pd_d0[17-1:0];
    end
end
assign skid_data_info_in_pd_d0[17-1:0] = (skid_flop_data_info_in_rdy_d0) ? data_info_in_pd_d0[17-1:0] : skid_flop_data_info_in_pd_d0[17-1:0];


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
        pipe_skid_data_info_in_pd_d0[17-1:0] <= skid_data_info_in_pd_d0[17-1:0];
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
reg [17-1:0] skid_flop_data_info_in_pd_d1;
reg pipe_skid_data_info_in_vld_d1;
reg [17-1:0] pipe_skid_data_info_in_pd_d1;
// Wire
wire skid_data_info_in_vld_d1;
wire [17-1:0] skid_data_info_in_pd_d1;
wire skid_data_info_in_rdy_d1;
wire pipe_skid_data_info_in_rdy_d1;
wire data_info_in_vld_d2;
wire [17-1:0] data_info_in_pd_d2;
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
        skid_flop_data_info_in_pd_d1[17-1:0] <= data_info_in_pd_d1[17-1:0];
    end
end
assign skid_data_info_in_pd_d1[17-1:0] = (skid_flop_data_info_in_rdy_d1) ? data_info_in_pd_d1[17-1:0] : skid_flop_data_info_in_pd_d1[17-1:0];


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
        pipe_skid_data_info_in_pd_d1[17-1:0] <= skid_data_info_in_pd_d1[17-1:0];
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
reg [17-1:0] skid_flop_data_info_in_pd_d2;
reg pipe_skid_data_info_in_vld_d2;
reg [17-1:0] pipe_skid_data_info_in_pd_d2;
// Wire
wire skid_data_info_in_vld_d2;
wire [17-1:0] skid_data_info_in_pd_d2;
wire skid_data_info_in_rdy_d2;
wire pipe_skid_data_info_in_rdy_d2;
wire data_info_in_vld_d3;
wire [17-1:0] data_info_in_pd_d3;
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
        skid_flop_data_info_in_pd_d2[17-1:0] <= data_info_in_pd_d2[17-1:0];
    end
end
assign skid_data_info_in_pd_d2[17-1:0] = (skid_flop_data_info_in_rdy_d2) ? data_info_in_pd_d2[17-1:0] : skid_flop_data_info_in_pd_d2[17-1:0];


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
        pipe_skid_data_info_in_pd_d2[17-1:0] <= skid_data_info_in_pd_d2[17-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_data_info_in_rdy_d2 = data_info_in_rdy_d3_f;
assign data_info_in_vld_d3 = pipe_skid_data_info_in_vld_d2;
assign data_info_in_pd_d3 = pipe_skid_data_info_in_pd_d2;
// Reg
reg data_info_in_rdy_d3;
reg skid_flop_data_info_in_rdy_d3;
reg skid_flop_data_info_in_vld_d3;
reg [17-1:0] skid_flop_data_info_in_pd_d3;
reg pipe_skid_data_info_in_vld_d3;
reg [17-1:0] pipe_skid_data_info_in_pd_d3;
// Wire
wire skid_data_info_in_vld_d3;
wire [17-1:0] skid_data_info_in_pd_d3;
wire skid_data_info_in_rdy_d3;
wire pipe_skid_data_info_in_rdy_d3;
wire data_info_in_vld_d4;
wire [17-1:0] data_info_in_pd_d4;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_info_in_rdy_d3 <= 1'b1;
       skid_flop_data_info_in_rdy_d3 <= 1'b1;
   end else begin
       data_info_in_rdy_d3 <= skid_data_info_in_rdy_d3;
       skid_flop_data_info_in_rdy_d3 <= skid_data_info_in_rdy_d3;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_data_info_in_vld_d3 <= 1'b0;
    end else begin
        if (skid_flop_data_info_in_rdy_d3) begin
            skid_flop_data_info_in_vld_d3 <= data_info_in_vld_d3;
        end
   end
end
assign skid_data_info_in_vld_d3 = (skid_flop_data_info_in_rdy_d3) ? data_info_in_vld_d3 : skid_flop_data_info_in_vld_d3;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_data_info_in_rdy_d3 & data_info_in_vld_d3) begin
        skid_flop_data_info_in_pd_d3[17-1:0] <= data_info_in_pd_d3[17-1:0];
    end
end
assign skid_data_info_in_pd_d3[17-1:0] = (skid_flop_data_info_in_rdy_d3) ? data_info_in_pd_d3[17-1:0] : skid_flop_data_info_in_pd_d3[17-1:0];


// PIPE READY
assign skid_data_info_in_rdy_d3 = pipe_skid_data_info_in_rdy_d3 || !pipe_skid_data_info_in_vld_d3;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_data_info_in_vld_d3 <= 1'b0;
    end else begin
        if (skid_data_info_in_rdy_d3) begin
            pipe_skid_data_info_in_vld_d3 <= skid_data_info_in_vld_d3;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_data_info_in_rdy_d3 && skid_data_info_in_vld_d3) begin
        pipe_skid_data_info_in_pd_d3[17-1:0] <= skid_data_info_in_pd_d3[17-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_data_info_in_rdy_d3 = data_info_in_rdy_d4;
assign data_info_in_vld_d4 = pipe_skid_data_info_in_vld_d3;
assign data_info_in_pd_d4 = pipe_skid_data_info_in_pd_d3;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign data_info_in_rdy = data_info_in_rdy_d0;
assign data_info_in_rdy_d1_f = data_info_in_rdy_d1;
assign data_info_in_rdy_d2_f = data_info_in_rdy_d2;
assign data_info_in_rdy_d3_f = data_info_in_rdy_d3;
assign data_info_out_vld = data_info_in_vld_d4;
assign data_info_in_rdy_d4 = data_info_out_rdy;
assign data_info_out_pd[16:0] = data_info_in_pd_d4[16:0];
//===============================================
//convertor process
//-----------------------------------------------
//cvtout valid input
assign cdp_cvtout_input_vld = cdp_cvtout_in_valid & data_info_in_rdy;
//cvtout ready input
assign cdp_cvtout_input_rdy = &cdp_cvtout_input_rdys;
//cvt sub-unit valid in
//cvt sub-unit data in
//: my $k = 1;
//: my $icvto = (8 +1);
//: my $ocvti = $icvto + 16;
//: my $ocvto = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: assign cdp_cvtout_input_pd_$m = mul2ocvt_pd[${m}*${ocvti}+${ocvti}-1:${m}*${ocvti}];
//: assign cdp_cvtout_input_vlds[$m] = cdp_cvtout_input_vld
//: );
//: foreach my $i (0..$k-1) {
//: print qq(
//: & cdp_cvtout_input_rdys[$i]
//: );
//: }
//: print qq(
//: ;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign cdp_cvtout_input_pd_0 = mul2ocvt_pd[0*25+25-1:0*25];
assign cdp_cvtout_input_vlds[0] = cdp_cvtout_input_vld

& cdp_cvtout_input_rdys[0]

;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//cvt sub-unit data in
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_datout_offset_use[31:0] <= {32{1'b0}};
  end else begin
  reg2dp_datout_offset_use[31:0] <= reg2dp_datout_offset[31:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_datout_scale_use[15:0] <= {16{1'b0}};
  end else begin
  reg2dp_datout_scale_use[15:0] <= reg2dp_datout_scale[15:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_datout_shifter_use[5:0] <= {6{1'b0}};
  end else begin
  reg2dp_datout_shifter_use[5:0] <= reg2dp_datout_shifter[5:0];
  end
end
//: my $k = 1;
//: my $icvto = (8 +1);
//: my $ocvti = $icvto + 16;
//: my $ocvto = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: HLS_cdp_ocvt u_HLS_cdp_ocvt_$m (
//: .nvdla_core_clk (nvdla_core_clk) //|< i
//: ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//: ,.chn_data_in_rsc_z (cdp_cvtout_input_pd_${m}) //|< w
//: ,.chn_data_in_rsc_vz (cdp_cvtout_input_vlds[$m]) //|< w
//: ,.chn_data_in_rsc_lz (cdp_cvtout_input_rdys[$m]) //|> w
//: ,.cfg_alu_in_rsc_z (reg2dp_datout_offset_use[${ocvti}-1:0]) //|< r
//: ,.cfg_mul_in_rsc_z (reg2dp_datout_scale_use[15:0]) //|< r
//: ,.cfg_truncate_rsc_z (reg2dp_datout_shifter_use[5:0]) //|< r
//: ,.chn_data_out_rsc_z (cdp_cvtout_output_pd_${m}) //|> ?
//: ,.chn_data_out_rsc_vz (cdp_cvtout_output_rdys[$m]) //|< w
//: ,.chn_data_out_rsc_lz (cdp_cvtout_output_vlds[$m]) //|> w
//: );
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

HLS_cdp_ocvt u_HLS_cdp_ocvt_0 (
.nvdla_core_clk (nvdla_core_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
,.chn_data_in_rsc_z (cdp_cvtout_input_pd_0) //|< w
,.chn_data_in_rsc_vz (cdp_cvtout_input_vlds[0]) //|< w
,.chn_data_in_rsc_lz (cdp_cvtout_input_rdys[0]) //|> w
,.cfg_alu_in_rsc_z (reg2dp_datout_offset_use[25-1:0]) //|< r
,.cfg_mul_in_rsc_z (reg2dp_datout_scale_use[15:0]) //|< r
,.cfg_truncate_rsc_z (reg2dp_datout_shifter_use[5:0]) //|< r
,.chn_data_out_rsc_z (cdp_cvtout_output_pd_0) //|> ?
,.chn_data_out_rsc_vz (cdp_cvtout_output_rdys[0]) //|< w
,.chn_data_out_rsc_lz (cdp_cvtout_output_vlds[0]) //|> w
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//sub-unit output ready
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: assign cdp_cvtout_output_rdys[$m] = cdp_cvtout_output_rdy
//: );
//: foreach my $i (0..$k-1) {
//: print qq(
//: & cdp_cvtout_output_vlds[$i]
//: );
//: }
//: print qq(
//: ;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign cdp_cvtout_output_rdys[0] = cdp_cvtout_output_rdy

& cdp_cvtout_output_vlds[0]

;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//output valid
assign cdp_cvtout_output_vld = &cdp_cvtout_output_vlds;
//output ready
assign cdp_cvtout_output_rdy = cvtout_prdy & data_info_out_vld;
//output data
assign cdp_cvtout_output_pd = {
//: my $k = 1;
//: if($k > 1) {
//: foreach my $m (0..$k-2) {
//: my $i = $k -$m -1;
//: print qq(
//: cdp_cvtout_output_pd_$i,
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

//| eperl: generated_end (DO NOT EDIT ABOVE)
cdp_cvtout_output_pd_0};
//===============================================
//data info output
//-----------------------------------------------
//data info output ready
assign data_info_out_rdy = cvtout_prdy & cdp_cvtout_output_vld;
//===============================================
//convertor output
//-----------------------------------------------
assign cvtout_pvld = cdp_cvtout_output_vld & data_info_out_vld;
assign cvtout_pd = {data_info_out_pd[16:0],cdp_cvtout_output_pd};
//////////////////////////////////////////////////////////////////////
endmodule // NV_NVDLA_CDP_DP_cvtout
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none data_info_in_pd_d1[14:0] (data_info_in_vld_d1,data_info_in_rdy_d1) <= data_info_in_pd_d0[14:0] (data_info_in_vld_d0,data_info_in_rdy_d0)
// **************************************************************************************************************
module NV_NVDLA_CDP_DP_CVTOUT_pipe_p1 (
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
input [14:0] data_info_in_pd_d0;
input data_info_in_rdy_d1;
input data_info_in_vld_d0;
output [14:0] data_info_in_pd_d1;
output data_info_in_rdy_d0;
output data_info_in_vld_d1;
reg [14:0] data_info_in_pd_d1;
reg data_info_in_rdy_d0;
reg data_info_in_vld_d1;
reg [14:0] p1_pipe_data;
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
  p1_pipe_data <= (p1_pipe_ready_bc && data_info_in_vld_d0)? data_info_in_pd_d0[14:0] : p1_pipe_data;
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
  data_info_in_pd_d1[14:0] = p1_pipe_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_5x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (data_info_in_vld_d1^data_info_in_rdy_d1^data_info_in_vld_d0^data_info_in_rdy_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_6x (nvdla_core_clk, `ASSERT_RESET, (data_info_in_vld_d0 && !data_info_in_rdy_d0), (data_info_in_vld_d0), (data_info_in_rdy_d0)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_DP_CVTOUT_pipe_p1
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none data_info_in_pd_d2[14:0] (data_info_in_vld_d2,data_info_in_rdy_d2) <= data_info_in_pd_d1[14:0] (data_info_in_vld_d1,data_info_in_rdy_d1)
// **************************************************************************************************************
module NV_NVDLA_CDP_DP_CVTOUT_pipe_p2 (
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
input [14:0] data_info_in_pd_d1;
input data_info_in_rdy_d2;
input data_info_in_vld_d1;
output [14:0] data_info_in_pd_d2;
output data_info_in_rdy_d1;
output data_info_in_vld_d2;
reg [14:0] data_info_in_pd_d2;
reg data_info_in_rdy_d1;
reg data_info_in_vld_d2;
reg [14:0] p2_pipe_data;
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
  p2_pipe_data <= (p2_pipe_ready_bc && data_info_in_vld_d1)? data_info_in_pd_d1[14:0] : p2_pipe_data;
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
  data_info_in_pd_d2[14:0] = p2_pipe_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_7x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (data_info_in_vld_d2^data_info_in_rdy_d2^data_info_in_vld_d1^data_info_in_rdy_d1)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_8x (nvdla_core_clk, `ASSERT_RESET, (data_info_in_vld_d1 && !data_info_in_rdy_d1), (data_info_in_vld_d1), (data_info_in_rdy_d1)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_DP_CVTOUT_pipe_p2
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none data_info_in_pd_d3[14:0] (data_info_in_vld_d3,data_info_in_rdy_d3) <= data_info_in_pd_d2[14:0] (data_info_in_vld_d2,data_info_in_rdy_d2)
// **************************************************************************************************************
module NV_NVDLA_CDP_DP_CVTOUT_pipe_p3 (
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
input [14:0] data_info_in_pd_d2;
input data_info_in_rdy_d3;
input data_info_in_vld_d2;
output [14:0] data_info_in_pd_d3;
output data_info_in_rdy_d2;
output data_info_in_vld_d3;
reg [14:0] data_info_in_pd_d3;
reg data_info_in_rdy_d2;
reg data_info_in_vld_d3;
reg [14:0] p3_pipe_data;
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
  p3_pipe_data <= (p3_pipe_ready_bc && data_info_in_vld_d2)? data_info_in_pd_d2[14:0] : p3_pipe_data;
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
  data_info_in_pd_d3[14:0] = p3_pipe_data;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_9x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (data_info_in_vld_d3^data_info_in_rdy_d3^data_info_in_vld_d2^data_info_in_rdy_d2)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_10x (nvdla_core_clk, `ASSERT_RESET, (data_info_in_vld_d2 && !data_info_in_rdy_d2), (data_info_in_vld_d2), (data_info_in_rdy_d2)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_DP_CVTOUT_pipe_p3
// **************************************************************************************************************
// Generated by ::pipe -m -bc -rand none data_info_in_pd_d4[14:0] (data_info_in_vld_d4,data_info_in_rdy_d4) <= data_info_in_pd_d3[14:0] (data_info_in_vld_d3,data_info_in_rdy_d3)
// **************************************************************************************************************
module NV_NVDLA_CDP_DP_CVTOUT_pipe_p4 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,data_info_in_pd_d3
  ,data_info_in_rdy_d4
  ,data_info_in_vld_d3
  ,data_info_in_pd_d4
  ,data_info_in_rdy_d3
  ,data_info_in_vld_d4
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [14:0] data_info_in_pd_d3;
input data_info_in_rdy_d4;
input data_info_in_vld_d3;
output [14:0] data_info_in_pd_d4;
output data_info_in_rdy_d3;
output data_info_in_vld_d4;
reg [14:0] data_info_in_pd_d4;
reg data_info_in_rdy_d3;
reg data_info_in_vld_d4;
reg [14:0] p4_pipe_data;
reg p4_pipe_ready;
reg p4_pipe_ready_bc;
reg p4_pipe_valid;
//## pipe (4) valid-ready-bubble-collapse
always @(
  p4_pipe_ready
  or p4_pipe_valid
  ) begin
  p4_pipe_ready_bc = p4_pipe_ready || !p4_pipe_valid;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    p4_pipe_valid <= 1'b0;
  end else begin
  p4_pipe_valid <= (p4_pipe_ready_bc)? data_info_in_vld_d3 : 1'd1;
  end
end
always @(posedge nvdla_core_clk) begin
// VCS sop_coverage_off start
  p4_pipe_data <= (p4_pipe_ready_bc && data_info_in_vld_d3)? data_info_in_pd_d3[14:0] : p4_pipe_data;
// VCS sop_coverage_off end
end
always @(
  p4_pipe_ready_bc
  ) begin
  data_info_in_rdy_d3 = p4_pipe_ready_bc;
end
//## pipe (4) output
always @(
  p4_pipe_valid
  or data_info_in_rdy_d4
  or p4_pipe_data
  ) begin
  data_info_in_vld_d4 = p4_pipe_valid;
  p4_pipe_ready = data_info_in_rdy_d4;
  data_info_in_pd_d4[14:0] = p4_pipe_data;
end
//## pipe (4) assertions/testpoints
`ifndef VIVA_PLUGIN_PIPE_DISABLE_ASSERTIONS
wire p4_assert_clk = nvdla_core_clk;
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, nvdla_core_rstn, (data_info_in_vld_d4^data_info_in_rdy_d4^data_info_in_vld_d3^data_info_in_rdy_d3)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
  nv_assert_hold_throughout_event_interval #(0,1,0,"valid removed before ready") zzz_assert_hold_throughout_event_interval_12x (nvdla_core_clk, `ASSERT_RESET, (data_info_in_vld_d3 && !data_info_in_rdy_d3), (data_info_in_vld_d3), (data_info_in_rdy_d3)); // spyglass disable W504 SelfDeterminedExpr-ML 
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
endmodule // NV_NVDLA_CDP_DP_CVTOUT_pipe_p4
