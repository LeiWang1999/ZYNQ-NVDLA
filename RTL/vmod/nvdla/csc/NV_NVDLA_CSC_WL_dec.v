// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CSC_WL_dec.v
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
module NV_NVDLA_CSC_WL_dec (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,input_data
  ,input_mask
  ,input_mask_en
  ,input_pipe_valid
  ,input_sel
  ,is_fp16
  ,is_int8
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq( ,output_data${i}\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
 ,output_data0
 ,output_data1
 ,output_data2
 ,output_data3
 ,output_data4
 ,output_data5
 ,output_data6
 ,output_data7

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,output_mask
  ,output_pvld
  ,output_sel
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [8*8 -1:0] input_data;
input [8 -1:0] input_mask;
input [9:0] input_mask_en;
input input_pipe_valid;
input [8 -1:0] input_sel;
input is_fp16;
input is_int8;
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq(output [8 -1:0] output_data${i};\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
output [8 -1:0] output_data0;
output [8 -1:0] output_data1;
output [8 -1:0] output_data2;
output [8 -1:0] output_data3;
output [8 -1:0] output_data4;
output [8 -1:0] output_data5;
output [8 -1:0] output_data6;
output [8 -1:0] output_data7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output [8 -1:0] output_mask;
output output_pvld;
output [8 -1:0] output_sel;
wire [8 -1:0] input_mask_gated;
reg [8*8 -1:0] data_d1;
reg [8 -1:0] mask_d1;
//reg [8 -1:0] mask_d2_fp16_w;
//reg [8 -1:0] mask_d2_int16_w;
wire [8 -1:0] mask_d2_int8_w;
wire [8 -1:0] mask_d2_w;
reg [8 -1:0] mask_d3;
reg [8 -1:0] sel_d1;
reg [8 -1:0] sel_d2;
reg [8 -1:0] sel_d3;
reg valid_d1;
reg valid_d2;
reg valid_d3;
//: my $kk=8;
//: for(my $i = 0; $i < 8; $i ++) {
//: my $series_no = sprintf("%02d", $i);
//: print qq(reg [8 -1:0] vec_data_${series_no};\n);
//: print qq(reg [8 -1:0] vec_data_${series_no}_d2;\n);
//: print qq(reg [8 -1:0] vec_data_${series_no}_d3;\n);
//: }
//: for(my $i = 0; $i < 8; $i ++) {
//: my $j = 1;
//: while(2**$j <= ($i + 1)) {
//: $j ++;
//: }
//: my $k = $j - 1;
//: my $series_no = sprintf("%02d", $i);
//: print qq(wire [${k}:0] vec_sum_${series_no};\n);
//: print qq(reg [${k}:0] vec_sum_${series_no}_d1;\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [8 -1:0] vec_data_00;
reg [8 -1:0] vec_data_00_d2;
reg [8 -1:0] vec_data_00_d3;
reg [8 -1:0] vec_data_01;
reg [8 -1:0] vec_data_01_d2;
reg [8 -1:0] vec_data_01_d3;
reg [8 -1:0] vec_data_02;
reg [8 -1:0] vec_data_02_d2;
reg [8 -1:0] vec_data_02_d3;
reg [8 -1:0] vec_data_03;
reg [8 -1:0] vec_data_03_d2;
reg [8 -1:0] vec_data_03_d3;
reg [8 -1:0] vec_data_04;
reg [8 -1:0] vec_data_04_d2;
reg [8 -1:0] vec_data_04_d3;
reg [8 -1:0] vec_data_05;
reg [8 -1:0] vec_data_05_d2;
reg [8 -1:0] vec_data_05_d3;
reg [8 -1:0] vec_data_06;
reg [8 -1:0] vec_data_06_d2;
reg [8 -1:0] vec_data_06_d3;
reg [8 -1:0] vec_data_07;
reg [8 -1:0] vec_data_07_d2;
reg [8 -1:0] vec_data_07_d3;
wire [0:0] vec_sum_00;
reg [0:0] vec_sum_00_d1;
wire [1:0] vec_sum_01;
reg [1:0] vec_sum_01_d1;
wire [1:0] vec_sum_02;
reg [1:0] vec_sum_02_d1;
wire [2:0] vec_sum_03;
reg [2:0] vec_sum_03_d1;
wire [2:0] vec_sum_04;
reg [2:0] vec_sum_04_d1;
wire [2:0] vec_sum_05;
reg [2:0] vec_sum_05_d1;
wire [2:0] vec_sum_06;
reg [2:0] vec_sum_06_d1;
wire [3:0] vec_sum_07;
reg [3:0] vec_sum_07_d1;

//| eperl: generated_end (DO NOT EDIT ABOVE)
/////////////////////////////////////////////////////////////////////////////////////////////
// Decoder of compressed weight
//
// data_mask input_data mac_sel
// | | |
// sums_for_sel register register
// | | |
// ------------------> mux register
// | |
// output_data output_sel
//
/////////////////////////////////////////////////////////////////////////////////////////////
//: my $i;
//: my $j;
//: my $k;
//: my $series_no;
//: my $series_no_1;
//: my $name;
//: my $name_1;
//: my $width;
//: my $st;
//: my $end;
//: my @bit_width_list;
//: $width = 8;
//: for($i = 0; $i < 8; $i ++) {
//: $j = 0;
//: while(2**$j <= ($i + 1)) {
//: $j ++;
//: }
//: $bit_width_list[$i] = $j;
//: }
//: print "////////////////////////////////// phase I: calculate sums for mux //////////////////////////////////\n";
//: print "assign input_mask_gated = ~input_mask_en[8] ? {${width}{1'b0}} : input_mask;\n\n";
//:
//: for($i = 0; $i < 8; $i ++) {
//: $series_no = sprintf("%02d", $i);
//: print "assign vec_sum_${series_no} = ";
//: for($j = 0; $j < $i + 1; $j ++) {
//: print "input_mask_gated[${j}]";
//: if($j == $i) {
//: print ";\n";
//: } elsif ($j % 8 == 7) {
//: print "\n                   + ";
//: } else {
//: print " + ";
//: }
//: }
//: print "\n\n";
//: }
//: print "\n\n";
//:
//: print "////////////////////////////////// phase I: registers //////////////////////////////////\n";
//: &eperl::flop("-nodeclare -rval \"1'b0\" -q valid_d1 -d input_pipe_valid ");
//: &eperl::flop("-nodeclare -norst -q data_d1 -en input_pipe_valid -d input_data ");
//: &eperl::flop("-nodeclare -norst -q mask_d1 -en input_pipe_valid -d input_mask ");
//: &eperl::flop("-nodeclare -q sel_d1 -en input_pipe_valid -d input_sel ");
//:
//: for($i = 0; $i < 8; $i ++) {
//: $series_no = sprintf("%02d", $i);
//: my $j = int($i / 8);
//: my $wid = $bit_width_list[$i];
//: &eperl::flop("-nodeclare -rval \"{${wid}{1'b0}}\" -q vec_sum_${series_no}_d1 -en \"(input_pipe_valid & input_mask_en[${j}])\" -d vec_sum_${series_no} ");
//: }
//: print "\n\n";
//:
//: print "////////////////////////////////// phase II: mux //////////////////////////////////\n";
//: for($i = 0; $i < 8; $i ++) {
//: $series_no = sprintf("%02d", $i);
//: $name = "vec_data_${series_no}";
//: $k = $bit_width_list[$i];
//:
//: print "always @ (*) begin\n";
//: print "    case(vec_sum_${series_no}_d1)\n";
//:
//: for($j = 1; $j <= $i + 1; $j ++) {
//: $st = $j * $width - 1;
//: $end = ($j - 1) * $width;
//: print "        ${k}'d${j}: $name = data_d1[${st}:${end}];\n";
//: }
//: print "    default: $name= ${width}'b0;\n";
//: print "    endcase\n";
//: print "end\n\n";
//: }
//: print "\n\n";
//:
//: print "////////////////////////////////// phase II: registers //////////////////////////////////\n";
//: &eperl::flop("-nodeclare -rval \"1'b0\" -q valid_d2 -d valid_d1 ");
//: &eperl::flop("-nodeclare -q sel_d2 -en valid_d1 -d sel_d1 ");
//: for($i = 0; $i < 8; $i ++) {
//: $series_no = sprintf("%02d", $i);
//: $name = "vec_data_${series_no}";
//: &eperl::flop("-nodeclare -norst -q ${name}_d2 -en \"valid_d1\" -d \"(${name} & {${width}{mask_d1[${i}]}})\" ");
//: }
//: print "\n\n";
//:
//: print "////////////////////////////////// phase III: registers //////////////////////////////////\n";
//: for($i = 0; $i < 8; $i ++) {
//: $series_no = sprintf("%02d", $i);
//: $name = "vec_data_${series_no}_d2";
//: print "assign mask_d2_int8_w[${i}] = (|${name});\n";
//: }
//: print "\n\n\n";
//:
//: #for($i = 0; $i < 8; $i += 2) {
//: # $j = $i + 1;
//: # $series_no = sprintf("%02d", $i);
//: # $series_no_1 = sprintf("%02d", $j);
//: # $name = "vec_data_${series_no}_d2";
//: # $name_1 = "vec_data_${series_no_1}_d2";
//: # print "assign mask_d2_int16_w[${j}:${i}] = {2{(|{${name_1}, ${name}})}};\n";
//: #}
//: #print "\n\n\n";
//:
//: #for($i = 0; $i < 8; $i += 2) {
//: # $j = $i + 1;
//: # $series_no = sprintf("%02d", $i);
//: # $series_no_1 = sprintf("%02d", $j);
//: # $name = "vec_data_${series_no}_d2";
//: # $name_1 = "vec_data_${series_no_1}_d2";
//: # print "assign mask_d2_fp16_w[${j}:${i}] = {2{(|{${name_1}[6:0], ${name}})}};\n";
//: #}
//: #print "\n\n\n";
//:
//: #print "assign mask_d2_w = is_int8 ? mask_d2_int8_w :\n";
//: #print "                   is_fp16 ? mask_d2_fp16_w :\n";
//: #print "                   mask_d2_int16_w;\n";
//: #print "\n\n\n";
//: print "assign mask_d2_w = mask_d2_int8_w ;\n"; #only for int8
//:
//: &eperl::flop("-nodeclare -rval \"1'b0\" -q valid_d3 -d valid_d2 ");
//: &eperl::flop("-nodeclare -norst -q mask_d3 -en valid_d2 -d mask_d2_w ");
//: &eperl::flop("-nodeclare -q sel_d3 -en valid_d2 -d sel_d2 ");
//: for($i = 0; $i < 8; $i ++) {
//: $series_no = sprintf("%02d", $i);
//: $name = "vec_data_${series_no}";
//: &eperl::flop("-nodeclare -q ${name}_d3 -en valid_d2 -d ${name}_d2 ");
//: }
//: print "\n\n";
//:
//: print "////////////////////////////////// output: rename //////////////////////////////////\n";
//: print "assign output_pvld = valid_d3;\n";
//: print "assign output_mask = mask_d3;\n";
//: print "assign output_sel = sel_d3;\n";
//: for($i = 0; $i < 8; $i ++) {
//: $series_no = sprintf("%02d", $i);
//: $name = "vec_data_${series_no}";
//: print "assign output_data${i} = ${name}_d3;\n";
//: }
//: print "\n\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
////////////////////////////////// phase I: calculate sums for mux //////////////////////////////////
assign input_mask_gated = ~input_mask_en[8] ? {8{1'b0}} : input_mask;

assign vec_sum_00 = input_mask_gated[0];


assign vec_sum_01 = input_mask_gated[0] + input_mask_gated[1];


assign vec_sum_02 = input_mask_gated[0] + input_mask_gated[1] + input_mask_gated[2];


assign vec_sum_03 = input_mask_gated[0] + input_mask_gated[1] + input_mask_gated[2] + input_mask_gated[3];


assign vec_sum_04 = input_mask_gated[0] + input_mask_gated[1] + input_mask_gated[2] + input_mask_gated[3] + input_mask_gated[4];


assign vec_sum_05 = input_mask_gated[0] + input_mask_gated[1] + input_mask_gated[2] + input_mask_gated[3] + input_mask_gated[4] + input_mask_gated[5];


assign vec_sum_06 = input_mask_gated[0] + input_mask_gated[1] + input_mask_gated[2] + input_mask_gated[3] + input_mask_gated[4] + input_mask_gated[5] + input_mask_gated[6];


assign vec_sum_07 = input_mask_gated[0] + input_mask_gated[1] + input_mask_gated[2] + input_mask_gated[3] + input_mask_gated[4] + input_mask_gated[5] + input_mask_gated[6] + input_mask_gated[7];




////////////////////////////////// phase I: registers //////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       valid_d1 <= 1'b0;
   end else begin
       valid_d1 <= input_pipe_valid;
   end
end
always @(posedge nvdla_core_clk) begin
       if ((input_pipe_valid) == 1'b1) begin
           data_d1 <= input_data;
       // VCS coverage off
       end else if ((input_pipe_valid) == 1'b0) begin
       end else begin
           data_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((input_pipe_valid) == 1'b1) begin
           mask_d1 <= input_mask;
       // VCS coverage off
       end else if ((input_pipe_valid) == 1'b0) begin
       end else begin
           mask_d1 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sel_d1 <= 'b0;
   end else begin
       if ((input_pipe_valid) == 1'b1) begin
           sel_d1 <= input_sel;
       // VCS coverage off
       end else if ((input_pipe_valid) == 1'b0) begin
       end else begin
           sel_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_sum_00_d1 <= {1{1'b0}};
   end else begin
       if (((input_pipe_valid & input_mask_en[0])) == 1'b1) begin
           vec_sum_00_d1 <= vec_sum_00;
       // VCS coverage off
       end else if (((input_pipe_valid & input_mask_en[0])) == 1'b0) begin
       end else begin
           vec_sum_00_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_sum_01_d1 <= {2{1'b0}};
   end else begin
       if (((input_pipe_valid & input_mask_en[0])) == 1'b1) begin
           vec_sum_01_d1 <= vec_sum_01;
       // VCS coverage off
       end else if (((input_pipe_valid & input_mask_en[0])) == 1'b0) begin
       end else begin
           vec_sum_01_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_sum_02_d1 <= {2{1'b0}};
   end else begin
       if (((input_pipe_valid & input_mask_en[0])) == 1'b1) begin
           vec_sum_02_d1 <= vec_sum_02;
       // VCS coverage off
       end else if (((input_pipe_valid & input_mask_en[0])) == 1'b0) begin
       end else begin
           vec_sum_02_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_sum_03_d1 <= {3{1'b0}};
   end else begin
       if (((input_pipe_valid & input_mask_en[0])) == 1'b1) begin
           vec_sum_03_d1 <= vec_sum_03;
       // VCS coverage off
       end else if (((input_pipe_valid & input_mask_en[0])) == 1'b0) begin
       end else begin
           vec_sum_03_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_sum_04_d1 <= {3{1'b0}};
   end else begin
       if (((input_pipe_valid & input_mask_en[0])) == 1'b1) begin
           vec_sum_04_d1 <= vec_sum_04;
       // VCS coverage off
       end else if (((input_pipe_valid & input_mask_en[0])) == 1'b0) begin
       end else begin
           vec_sum_04_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_sum_05_d1 <= {3{1'b0}};
   end else begin
       if (((input_pipe_valid & input_mask_en[0])) == 1'b1) begin
           vec_sum_05_d1 <= vec_sum_05;
       // VCS coverage off
       end else if (((input_pipe_valid & input_mask_en[0])) == 1'b0) begin
       end else begin
           vec_sum_05_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_sum_06_d1 <= {3{1'b0}};
   end else begin
       if (((input_pipe_valid & input_mask_en[0])) == 1'b1) begin
           vec_sum_06_d1 <= vec_sum_06;
       // VCS coverage off
       end else if (((input_pipe_valid & input_mask_en[0])) == 1'b0) begin
       end else begin
           vec_sum_06_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_sum_07_d1 <= {4{1'b0}};
   end else begin
       if (((input_pipe_valid & input_mask_en[0])) == 1'b1) begin
           vec_sum_07_d1 <= vec_sum_07;
       // VCS coverage off
       end else if (((input_pipe_valid & input_mask_en[0])) == 1'b0) begin
       end else begin
           vec_sum_07_d1 <= 'bx;
       // VCS coverage on
       end
   end
end


////////////////////////////////// phase II: mux //////////////////////////////////
always @ (*) begin
    case(vec_sum_00_d1)
        1'd1: vec_data_00 = data_d1[7:0];
    default: vec_data_00= 8'b0;
    endcase
end

always @ (*) begin
    case(vec_sum_01_d1)
        2'd1: vec_data_01 = data_d1[7:0];
        2'd2: vec_data_01 = data_d1[15:8];
    default: vec_data_01= 8'b0;
    endcase
end

always @ (*) begin
    case(vec_sum_02_d1)
        2'd1: vec_data_02 = data_d1[7:0];
        2'd2: vec_data_02 = data_d1[15:8];
        2'd3: vec_data_02 = data_d1[23:16];
    default: vec_data_02= 8'b0;
    endcase
end

always @ (*) begin
    case(vec_sum_03_d1)
        3'd1: vec_data_03 = data_d1[7:0];
        3'd2: vec_data_03 = data_d1[15:8];
        3'd3: vec_data_03 = data_d1[23:16];
        3'd4: vec_data_03 = data_d1[31:24];
    default: vec_data_03= 8'b0;
    endcase
end

always @ (*) begin
    case(vec_sum_04_d1)
        3'd1: vec_data_04 = data_d1[7:0];
        3'd2: vec_data_04 = data_d1[15:8];
        3'd3: vec_data_04 = data_d1[23:16];
        3'd4: vec_data_04 = data_d1[31:24];
        3'd5: vec_data_04 = data_d1[39:32];
    default: vec_data_04= 8'b0;
    endcase
end

always @ (*) begin
    case(vec_sum_05_d1)
        3'd1: vec_data_05 = data_d1[7:0];
        3'd2: vec_data_05 = data_d1[15:8];
        3'd3: vec_data_05 = data_d1[23:16];
        3'd4: vec_data_05 = data_d1[31:24];
        3'd5: vec_data_05 = data_d1[39:32];
        3'd6: vec_data_05 = data_d1[47:40];
    default: vec_data_05= 8'b0;
    endcase
end

always @ (*) begin
    case(vec_sum_06_d1)
        3'd1: vec_data_06 = data_d1[7:0];
        3'd2: vec_data_06 = data_d1[15:8];
        3'd3: vec_data_06 = data_d1[23:16];
        3'd4: vec_data_06 = data_d1[31:24];
        3'd5: vec_data_06 = data_d1[39:32];
        3'd6: vec_data_06 = data_d1[47:40];
        3'd7: vec_data_06 = data_d1[55:48];
    default: vec_data_06= 8'b0;
    endcase
end

always @ (*) begin
    case(vec_sum_07_d1)
        4'd1: vec_data_07 = data_d1[7:0];
        4'd2: vec_data_07 = data_d1[15:8];
        4'd3: vec_data_07 = data_d1[23:16];
        4'd4: vec_data_07 = data_d1[31:24];
        4'd5: vec_data_07 = data_d1[39:32];
        4'd6: vec_data_07 = data_d1[47:40];
        4'd7: vec_data_07 = data_d1[55:48];
        4'd8: vec_data_07 = data_d1[63:56];
    default: vec_data_07= 8'b0;
    endcase
end



////////////////////////////////// phase II: registers //////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       valid_d2 <= 1'b0;
   end else begin
       valid_d2 <= valid_d1;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sel_d2 <= 'b0;
   end else begin
       if ((valid_d1) == 1'b1) begin
           sel_d2 <= sel_d1;
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           sel_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d1) == 1'b1) begin
           vec_data_00_d2 <= (vec_data_00 & {8{mask_d1[0]}});
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           vec_data_00_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d1) == 1'b1) begin
           vec_data_01_d2 <= (vec_data_01 & {8{mask_d1[1]}});
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           vec_data_01_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d1) == 1'b1) begin
           vec_data_02_d2 <= (vec_data_02 & {8{mask_d1[2]}});
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           vec_data_02_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d1) == 1'b1) begin
           vec_data_03_d2 <= (vec_data_03 & {8{mask_d1[3]}});
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           vec_data_03_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d1) == 1'b1) begin
           vec_data_04_d2 <= (vec_data_04 & {8{mask_d1[4]}});
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           vec_data_04_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d1) == 1'b1) begin
           vec_data_05_d2 <= (vec_data_05 & {8{mask_d1[5]}});
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           vec_data_05_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d1) == 1'b1) begin
           vec_data_06_d2 <= (vec_data_06 & {8{mask_d1[6]}});
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           vec_data_06_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d1) == 1'b1) begin
           vec_data_07_d2 <= (vec_data_07 & {8{mask_d1[7]}});
       // VCS coverage off
       end else if ((valid_d1) == 1'b0) begin
       end else begin
           vec_data_07_d2 <= 'bx;
       // VCS coverage on
       end
end


////////////////////////////////// phase III: registers //////////////////////////////////
assign mask_d2_int8_w[0] = (|vec_data_00_d2);
assign mask_d2_int8_w[1] = (|vec_data_01_d2);
assign mask_d2_int8_w[2] = (|vec_data_02_d2);
assign mask_d2_int8_w[3] = (|vec_data_03_d2);
assign mask_d2_int8_w[4] = (|vec_data_04_d2);
assign mask_d2_int8_w[5] = (|vec_data_05_d2);
assign mask_d2_int8_w[6] = (|vec_data_06_d2);
assign mask_d2_int8_w[7] = (|vec_data_07_d2);



assign mask_d2_w = mask_d2_int8_w ;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       valid_d3 <= 1'b0;
   end else begin
       valid_d3 <= valid_d2;
   end
end
always @(posedge nvdla_core_clk) begin
       if ((valid_d2) == 1'b1) begin
           mask_d3 <= mask_d2_w;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           mask_d3 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sel_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           sel_d3 <= sel_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           sel_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_data_00_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           vec_data_00_d3 <= vec_data_00_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           vec_data_00_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_data_01_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           vec_data_01_d3 <= vec_data_01_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           vec_data_01_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_data_02_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           vec_data_02_d3 <= vec_data_02_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           vec_data_02_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_data_03_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           vec_data_03_d3 <= vec_data_03_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           vec_data_03_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_data_04_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           vec_data_04_d3 <= vec_data_04_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           vec_data_04_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_data_05_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           vec_data_05_d3 <= vec_data_05_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           vec_data_05_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_data_06_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           vec_data_06_d3 <= vec_data_06_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           vec_data_06_d3 <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       vec_data_07_d3 <= 'b0;
   end else begin
       if ((valid_d2) == 1'b1) begin
           vec_data_07_d3 <= vec_data_07_d2;
       // VCS coverage off
       end else if ((valid_d2) == 1'b0) begin
       end else begin
           vec_data_07_d3 <= 'bx;
       // VCS coverage on
       end
   end
end


////////////////////////////////// output: rename //////////////////////////////////
assign output_pvld = valid_d3;
assign output_mask = mask_d3;
assign output_sel = sel_d3;
assign output_data0 = vec_data_00_d3;
assign output_data1 = vec_data_01_d3;
assign output_data2 = vec_data_02_d3;
assign output_data3 = vec_data_03_d3;
assign output_data4 = vec_data_04_d3;
assign output_data5 = vec_data_05_d3;
assign output_data6 = vec_data_06_d3;
assign output_data7 = vec_data_07_d3;



//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_CSC_WL_dec
