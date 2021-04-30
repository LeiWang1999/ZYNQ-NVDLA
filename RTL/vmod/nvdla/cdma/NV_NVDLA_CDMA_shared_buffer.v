// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDMA_shared_buffer.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDMA_define.h
//#define CDMA_SBUF_SDATA_BITS            256
//DorisL-S----------------
//
// #if ( NVDLA_MEMORY_ATOMIC_SIZE  ==  32 )
//     #define IMG_LARGE
// #endif
// #if ( NVDLA_MEMORY_ATOMIC_SIZE == 8 )
//     #define IMG_SMALL
// #endif
//DorisL-E----------------
//--------------------------------------------------
module NV_NVDLA_CDMA_shared_buffer (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,dc2sbuf_p0_wr_en //|< i
  ,dc2sbuf_p0_wr_addr //|< i
  ,dc2sbuf_p0_wr_data //|< i
  ,dc2sbuf_p1_wr_en //|< i
  ,dc2sbuf_p1_wr_addr //|< i
  ,dc2sbuf_p1_wr_data //|< i
  ,img2sbuf_p0_wr_en //|< i
  ,img2sbuf_p0_wr_addr //|< i
  ,img2sbuf_p0_wr_data //|< i
  ,img2sbuf_p1_wr_en //|< i
  ,img2sbuf_p1_wr_addr //|< i
  ,img2sbuf_p1_wr_data //|< i
  ,dc2sbuf_p0_rd_en //|< i
  ,dc2sbuf_p0_rd_addr //|< i
  ,dc2sbuf_p0_rd_data //|> o
  ,dc2sbuf_p1_rd_en //|< i
  ,dc2sbuf_p1_rd_addr //|< i
  ,dc2sbuf_p1_rd_data //|> o
  ,img2sbuf_p0_rd_en //|< i
  ,img2sbuf_p0_rd_addr //|< i
  ,img2sbuf_p0_rd_data //|> o
  ,img2sbuf_p1_rd_en //|< i
  ,img2sbuf_p1_rd_addr //|< i
  ,img2sbuf_p1_rd_data //|> o
  );
//
// NV_NVDLA_CDMA_shared_buffer_ports.v
//
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input dc2sbuf_p0_wr_en; /* data valid */
input [7:0] dc2sbuf_p0_wr_addr;
input [8*8 -1:0] dc2sbuf_p0_wr_data;
input dc2sbuf_p1_wr_en; /* data valid */
input [7:0] dc2sbuf_p1_wr_addr;
input [8*8 -1:0] dc2sbuf_p1_wr_data;
input img2sbuf_p0_wr_en; /* data valid */
input [7:0] img2sbuf_p0_wr_addr;
input [8*8 -1:0] img2sbuf_p0_wr_data;
input img2sbuf_p1_wr_en; /* data valid */
input [7:0] img2sbuf_p1_wr_addr;
input [8*8 -1:0] img2sbuf_p1_wr_data;
input dc2sbuf_p0_rd_en; /* data valid */
input [7:0] dc2sbuf_p0_rd_addr;
output [8*8 -1:0] dc2sbuf_p0_rd_data;
input dc2sbuf_p1_rd_en; /* data valid */
input [7:0] dc2sbuf_p1_rd_addr;
output [8*8 -1:0] dc2sbuf_p1_rd_data;
input img2sbuf_p0_rd_en; /* data valid */
input [7:0] img2sbuf_p0_rd_addr;
output [8*8 -1:0] img2sbuf_p0_rd_data;
input img2sbuf_p1_rd_en; /* data valid */
input [7:0] img2sbuf_p1_rd_addr;
output [8*8 -1:0] img2sbuf_p1_rd_data;
//////////////
// REGS //
//////////////
//: my $i;
//: my $j;
//: my $k;
//: my $serial;
//: my $b0;
//: my $val;
//: my @input_list;
//: my $def_wino = 0;
//: if($def_wino) {
//: @input_list = ("dc", "wg", "img");
//: } else {
//: @input_list = ("dc", "img");
//: }
//: my @input_list_1 = ("dc", "img");
//: my $name;
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: for($k = 0; $k < 2; $k ++) {
//: print qq(reg sbuf_p${k}_re_${serial}_norm_d1;\n);
//: }
//: }
//: $b0 = 8*8 - 1;
//: for($k = 0; $k < 2; $k ++) {
//: print qq(reg [${b0}:0] sbuf_p${k}_rdat_d2;\n);
//: print qq(reg sbuf_p${k}_rd_en_d1;\n);
//: }
//: if($def_wino) {
//: for($j = 0; $j < 16/4; $j ++) {
//: $val = sprintf("%02d", $j);
//: for($k = 0; $k < 2; $k ++) {
//: print qq(reg sbuf_p${k}_re_${val}_wg_d1;\n);
//: }
//: }
//: for($k = 0; $k < 2; $k ++) {
//: for($i = 0; $i < 4; $i ++) {
//: print qq(reg sbuf_p${k}_wg_sel_q${i}_d1;\n);
//: }
//: }
//: }
//: print qq (\n\n);
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg sbuf_p0_re_00_norm_d1;
reg sbuf_p1_re_00_norm_d1;
reg sbuf_p0_re_01_norm_d1;
reg sbuf_p1_re_01_norm_d1;
reg sbuf_p0_re_02_norm_d1;
reg sbuf_p1_re_02_norm_d1;
reg sbuf_p0_re_03_norm_d1;
reg sbuf_p1_re_03_norm_d1;
reg sbuf_p0_re_04_norm_d1;
reg sbuf_p1_re_04_norm_d1;
reg sbuf_p0_re_05_norm_d1;
reg sbuf_p1_re_05_norm_d1;
reg sbuf_p0_re_06_norm_d1;
reg sbuf_p1_re_06_norm_d1;
reg sbuf_p0_re_07_norm_d1;
reg sbuf_p1_re_07_norm_d1;
reg sbuf_p0_re_08_norm_d1;
reg sbuf_p1_re_08_norm_d1;
reg sbuf_p0_re_09_norm_d1;
reg sbuf_p1_re_09_norm_d1;
reg sbuf_p0_re_10_norm_d1;
reg sbuf_p1_re_10_norm_d1;
reg sbuf_p0_re_11_norm_d1;
reg sbuf_p1_re_11_norm_d1;
reg sbuf_p0_re_12_norm_d1;
reg sbuf_p1_re_12_norm_d1;
reg sbuf_p0_re_13_norm_d1;
reg sbuf_p1_re_13_norm_d1;
reg sbuf_p0_re_14_norm_d1;
reg sbuf_p1_re_14_norm_d1;
reg sbuf_p0_re_15_norm_d1;
reg sbuf_p1_re_15_norm_d1;
reg [63:0] sbuf_p0_rdat_d2;
reg sbuf_p0_rd_en_d1;
reg [63:0] sbuf_p1_rdat_d2;
reg sbuf_p1_rd_en_d1;



//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////
// WIRES //
//////////////
//: my $i;
//: my $j;
//: my $k;
//: my $serial;
//: my $b0;
//: my $val;
//: my @input_list;
//: my $def_wino = 0;
//: if($def_wino) {
//: @input_list = ("dc", "wg", "img");
//: } else {
//: @input_list = ("dc", "img");
//: }
//: my @input_list_1 = ("dc", "img");
//: my $name;
//: $b0 = int(log(16)/log(2)) - 1;
//: for($i = 0; $i < @input_list; $i ++) {
//: $name = $input_list[$i];
//: print qq (
//: wire [${b0}:0] ${name}2sbuf_p0_wr_bsel;
//: wire [${b0}:0] ${name}2sbuf_p1_wr_bsel;\n);
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: for($i = 0; $i < @input_list; $i ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $name = $input_list[$i];
//: print qq (wire ${name}2sbuf_p${k}_wr_sel_${serial};\n);
//: }
//: }
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: print qq (wire sbuf_we_${serial};\n);
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $b0 = int(log(256)/log(2)) - int(log(16)/log(2)) - 1;
//: print qq (wire [${b0}:0] sbuf_wa_${serial};\n);
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $b0 = 8*8 - 1;
//: print qq (wire [${b0}:0] sbuf_wdat_${serial};\n);
//: }
//: $b0 = int(log(16)/log(2)) - 1;
//: for($i = 0; $i < @input_list_1; $i ++) {
//: $name = $input_list_1[$i];
//: print qq (
//: wire [${b0}:0] ${name}2sbuf_p0_rd_bsel;
//: wire [${b0}:0] ${name}2sbuf_p1_rd_bsel;\n);
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: for($i = 0; $i < @input_list_1; $i ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $name = $input_list_1[$i];
//: print qq (wire ${name}2sbuf_p${k}_rd_sel_${serial};\n);
//: }
//: }
//: }
//: for($j = 0; $j < 16; $j ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $serial = sprintf("%02d", $j);
//: print qq (wire sbuf_p${k}_re_${serial};\n);
//: }
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: print qq (wire sbuf_re_${serial};\n);
//: }
//: $b0 = 8*8 - 1;
//: for($i = 0; $i < 16; $i ++) {
//: $serial = sprintf("%02d", $i);
//: print qq (wire [${b0}:0] sbuf_rdat_${serial};\n);
//: }
//: $b0 = int(log(256)/log(2)) - int(log(16)/log(2)) - 1;
//: for($i = 0; $i < @input_list_1; $i ++) {
//: $name = $input_list_1[$i];
//: print qq (
//: wire [${b0}:0] ${name}2sbuf_p0_rd_esel;
//: wire [${b0}:0] ${name}2sbuf_p1_rd_esel;\n);
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $b0 = int(log(256)/log(2)) - int(log(16)/log(2)) - 1;
//: print qq (wire [${b0}:0] sbuf_ra_${serial};\n);
//: }
//: $b0 = 8*8 - 1;
//: for($k = 0; $k < 2; $k ++) {
//: print qq (wire [${b0}:0] sbuf_p${k}_norm_rdat;\n);
//: }
//: for($k = 0; $k < 2; $k ++) {
//: print qq (wire [${b0}:0] sbuf_p${k}_rdat;\n);
//: }
//: if($def_wino) {
//: $b0 = int(log(16)/log(2)) - 3;
//: print qq (
//: wire [${b0}:0] wg2sbuf_p0_rd_bsel;
//: wire [${b0}:0] wg2sbuf_p1_rd_bsel;\n);
//:
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $i = int($j/4);
//: for($k = 0; $k < 2; $k ++) {
//: print qq (wire wg2sbuf_p${k}_rd_sel_${serial};\n);
//: }
//: }
//:
//: $b0 = int(log(256)/log(2)) - int(log(16)/log(2)) - 1;
//: print qq (
//: wire [${b0}:0] wg2sbuf_p0_rd_esel;
//: wire [${b0}:0] wg2sbuf_p1_rd_esel;\n);
//: $b0 = 8*8 - 1;
//: for($k = 0; $k < 2; $k ++) {
//: for($i = 0; $i < 4; $i ++) {
//: print qq (wire [${b0}:0] sbuf_p${k}_wg_rdat_src_${i};\n);
//: }
//: }
//: for($k = 0; $k < 2; $k ++) {
//: print qq(wire [${b0}:0] sbuf_p${k}_wg_rdat;\n);
//: }
//: for($k = 0; $k < 2; $k ++) {
//: for($i = 0; $i < 4; $i ++) {
//: print qq(wire sbuf_p${k}_wg_sel_q${i};\n);
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [3:0] dc2sbuf_p0_wr_bsel;
wire [3:0] dc2sbuf_p1_wr_bsel;

wire [3:0] img2sbuf_p0_wr_bsel;
wire [3:0] img2sbuf_p1_wr_bsel;
wire dc2sbuf_p0_wr_sel_00;
wire dc2sbuf_p1_wr_sel_00;
wire img2sbuf_p0_wr_sel_00;
wire img2sbuf_p1_wr_sel_00;
wire dc2sbuf_p0_wr_sel_01;
wire dc2sbuf_p1_wr_sel_01;
wire img2sbuf_p0_wr_sel_01;
wire img2sbuf_p1_wr_sel_01;
wire dc2sbuf_p0_wr_sel_02;
wire dc2sbuf_p1_wr_sel_02;
wire img2sbuf_p0_wr_sel_02;
wire img2sbuf_p1_wr_sel_02;
wire dc2sbuf_p0_wr_sel_03;
wire dc2sbuf_p1_wr_sel_03;
wire img2sbuf_p0_wr_sel_03;
wire img2sbuf_p1_wr_sel_03;
wire dc2sbuf_p0_wr_sel_04;
wire dc2sbuf_p1_wr_sel_04;
wire img2sbuf_p0_wr_sel_04;
wire img2sbuf_p1_wr_sel_04;
wire dc2sbuf_p0_wr_sel_05;
wire dc2sbuf_p1_wr_sel_05;
wire img2sbuf_p0_wr_sel_05;
wire img2sbuf_p1_wr_sel_05;
wire dc2sbuf_p0_wr_sel_06;
wire dc2sbuf_p1_wr_sel_06;
wire img2sbuf_p0_wr_sel_06;
wire img2sbuf_p1_wr_sel_06;
wire dc2sbuf_p0_wr_sel_07;
wire dc2sbuf_p1_wr_sel_07;
wire img2sbuf_p0_wr_sel_07;
wire img2sbuf_p1_wr_sel_07;
wire dc2sbuf_p0_wr_sel_08;
wire dc2sbuf_p1_wr_sel_08;
wire img2sbuf_p0_wr_sel_08;
wire img2sbuf_p1_wr_sel_08;
wire dc2sbuf_p0_wr_sel_09;
wire dc2sbuf_p1_wr_sel_09;
wire img2sbuf_p0_wr_sel_09;
wire img2sbuf_p1_wr_sel_09;
wire dc2sbuf_p0_wr_sel_10;
wire dc2sbuf_p1_wr_sel_10;
wire img2sbuf_p0_wr_sel_10;
wire img2sbuf_p1_wr_sel_10;
wire dc2sbuf_p0_wr_sel_11;
wire dc2sbuf_p1_wr_sel_11;
wire img2sbuf_p0_wr_sel_11;
wire img2sbuf_p1_wr_sel_11;
wire dc2sbuf_p0_wr_sel_12;
wire dc2sbuf_p1_wr_sel_12;
wire img2sbuf_p0_wr_sel_12;
wire img2sbuf_p1_wr_sel_12;
wire dc2sbuf_p0_wr_sel_13;
wire dc2sbuf_p1_wr_sel_13;
wire img2sbuf_p0_wr_sel_13;
wire img2sbuf_p1_wr_sel_13;
wire dc2sbuf_p0_wr_sel_14;
wire dc2sbuf_p1_wr_sel_14;
wire img2sbuf_p0_wr_sel_14;
wire img2sbuf_p1_wr_sel_14;
wire dc2sbuf_p0_wr_sel_15;
wire dc2sbuf_p1_wr_sel_15;
wire img2sbuf_p0_wr_sel_15;
wire img2sbuf_p1_wr_sel_15;
wire sbuf_we_00;
wire sbuf_we_01;
wire sbuf_we_02;
wire sbuf_we_03;
wire sbuf_we_04;
wire sbuf_we_05;
wire sbuf_we_06;
wire sbuf_we_07;
wire sbuf_we_08;
wire sbuf_we_09;
wire sbuf_we_10;
wire sbuf_we_11;
wire sbuf_we_12;
wire sbuf_we_13;
wire sbuf_we_14;
wire sbuf_we_15;
wire [3:0] sbuf_wa_00;
wire [3:0] sbuf_wa_01;
wire [3:0] sbuf_wa_02;
wire [3:0] sbuf_wa_03;
wire [3:0] sbuf_wa_04;
wire [3:0] sbuf_wa_05;
wire [3:0] sbuf_wa_06;
wire [3:0] sbuf_wa_07;
wire [3:0] sbuf_wa_08;
wire [3:0] sbuf_wa_09;
wire [3:0] sbuf_wa_10;
wire [3:0] sbuf_wa_11;
wire [3:0] sbuf_wa_12;
wire [3:0] sbuf_wa_13;
wire [3:0] sbuf_wa_14;
wire [3:0] sbuf_wa_15;
wire [63:0] sbuf_wdat_00;
wire [63:0] sbuf_wdat_01;
wire [63:0] sbuf_wdat_02;
wire [63:0] sbuf_wdat_03;
wire [63:0] sbuf_wdat_04;
wire [63:0] sbuf_wdat_05;
wire [63:0] sbuf_wdat_06;
wire [63:0] sbuf_wdat_07;
wire [63:0] sbuf_wdat_08;
wire [63:0] sbuf_wdat_09;
wire [63:0] sbuf_wdat_10;
wire [63:0] sbuf_wdat_11;
wire [63:0] sbuf_wdat_12;
wire [63:0] sbuf_wdat_13;
wire [63:0] sbuf_wdat_14;
wire [63:0] sbuf_wdat_15;

wire [3:0] dc2sbuf_p0_rd_bsel;
wire [3:0] dc2sbuf_p1_rd_bsel;

wire [3:0] img2sbuf_p0_rd_bsel;
wire [3:0] img2sbuf_p1_rd_bsel;
wire dc2sbuf_p0_rd_sel_00;
wire dc2sbuf_p1_rd_sel_00;
wire img2sbuf_p0_rd_sel_00;
wire img2sbuf_p1_rd_sel_00;
wire dc2sbuf_p0_rd_sel_01;
wire dc2sbuf_p1_rd_sel_01;
wire img2sbuf_p0_rd_sel_01;
wire img2sbuf_p1_rd_sel_01;
wire dc2sbuf_p0_rd_sel_02;
wire dc2sbuf_p1_rd_sel_02;
wire img2sbuf_p0_rd_sel_02;
wire img2sbuf_p1_rd_sel_02;
wire dc2sbuf_p0_rd_sel_03;
wire dc2sbuf_p1_rd_sel_03;
wire img2sbuf_p0_rd_sel_03;
wire img2sbuf_p1_rd_sel_03;
wire dc2sbuf_p0_rd_sel_04;
wire dc2sbuf_p1_rd_sel_04;
wire img2sbuf_p0_rd_sel_04;
wire img2sbuf_p1_rd_sel_04;
wire dc2sbuf_p0_rd_sel_05;
wire dc2sbuf_p1_rd_sel_05;
wire img2sbuf_p0_rd_sel_05;
wire img2sbuf_p1_rd_sel_05;
wire dc2sbuf_p0_rd_sel_06;
wire dc2sbuf_p1_rd_sel_06;
wire img2sbuf_p0_rd_sel_06;
wire img2sbuf_p1_rd_sel_06;
wire dc2sbuf_p0_rd_sel_07;
wire dc2sbuf_p1_rd_sel_07;
wire img2sbuf_p0_rd_sel_07;
wire img2sbuf_p1_rd_sel_07;
wire dc2sbuf_p0_rd_sel_08;
wire dc2sbuf_p1_rd_sel_08;
wire img2sbuf_p0_rd_sel_08;
wire img2sbuf_p1_rd_sel_08;
wire dc2sbuf_p0_rd_sel_09;
wire dc2sbuf_p1_rd_sel_09;
wire img2sbuf_p0_rd_sel_09;
wire img2sbuf_p1_rd_sel_09;
wire dc2sbuf_p0_rd_sel_10;
wire dc2sbuf_p1_rd_sel_10;
wire img2sbuf_p0_rd_sel_10;
wire img2sbuf_p1_rd_sel_10;
wire dc2sbuf_p0_rd_sel_11;
wire dc2sbuf_p1_rd_sel_11;
wire img2sbuf_p0_rd_sel_11;
wire img2sbuf_p1_rd_sel_11;
wire dc2sbuf_p0_rd_sel_12;
wire dc2sbuf_p1_rd_sel_12;
wire img2sbuf_p0_rd_sel_12;
wire img2sbuf_p1_rd_sel_12;
wire dc2sbuf_p0_rd_sel_13;
wire dc2sbuf_p1_rd_sel_13;
wire img2sbuf_p0_rd_sel_13;
wire img2sbuf_p1_rd_sel_13;
wire dc2sbuf_p0_rd_sel_14;
wire dc2sbuf_p1_rd_sel_14;
wire img2sbuf_p0_rd_sel_14;
wire img2sbuf_p1_rd_sel_14;
wire dc2sbuf_p0_rd_sel_15;
wire dc2sbuf_p1_rd_sel_15;
wire img2sbuf_p0_rd_sel_15;
wire img2sbuf_p1_rd_sel_15;
wire sbuf_p0_re_00;
wire sbuf_p1_re_00;
wire sbuf_p0_re_01;
wire sbuf_p1_re_01;
wire sbuf_p0_re_02;
wire sbuf_p1_re_02;
wire sbuf_p0_re_03;
wire sbuf_p1_re_03;
wire sbuf_p0_re_04;
wire sbuf_p1_re_04;
wire sbuf_p0_re_05;
wire sbuf_p1_re_05;
wire sbuf_p0_re_06;
wire sbuf_p1_re_06;
wire sbuf_p0_re_07;
wire sbuf_p1_re_07;
wire sbuf_p0_re_08;
wire sbuf_p1_re_08;
wire sbuf_p0_re_09;
wire sbuf_p1_re_09;
wire sbuf_p0_re_10;
wire sbuf_p1_re_10;
wire sbuf_p0_re_11;
wire sbuf_p1_re_11;
wire sbuf_p0_re_12;
wire sbuf_p1_re_12;
wire sbuf_p0_re_13;
wire sbuf_p1_re_13;
wire sbuf_p0_re_14;
wire sbuf_p1_re_14;
wire sbuf_p0_re_15;
wire sbuf_p1_re_15;
wire sbuf_re_00;
wire sbuf_re_01;
wire sbuf_re_02;
wire sbuf_re_03;
wire sbuf_re_04;
wire sbuf_re_05;
wire sbuf_re_06;
wire sbuf_re_07;
wire sbuf_re_08;
wire sbuf_re_09;
wire sbuf_re_10;
wire sbuf_re_11;
wire sbuf_re_12;
wire sbuf_re_13;
wire sbuf_re_14;
wire sbuf_re_15;
wire [63:0] sbuf_rdat_00;
wire [63:0] sbuf_rdat_01;
wire [63:0] sbuf_rdat_02;
wire [63:0] sbuf_rdat_03;
wire [63:0] sbuf_rdat_04;
wire [63:0] sbuf_rdat_05;
wire [63:0] sbuf_rdat_06;
wire [63:0] sbuf_rdat_07;
wire [63:0] sbuf_rdat_08;
wire [63:0] sbuf_rdat_09;
wire [63:0] sbuf_rdat_10;
wire [63:0] sbuf_rdat_11;
wire [63:0] sbuf_rdat_12;
wire [63:0] sbuf_rdat_13;
wire [63:0] sbuf_rdat_14;
wire [63:0] sbuf_rdat_15;

wire [3:0] dc2sbuf_p0_rd_esel;
wire [3:0] dc2sbuf_p1_rd_esel;

wire [3:0] img2sbuf_p0_rd_esel;
wire [3:0] img2sbuf_p1_rd_esel;
wire [3:0] sbuf_ra_00;
wire [3:0] sbuf_ra_01;
wire [3:0] sbuf_ra_02;
wire [3:0] sbuf_ra_03;
wire [3:0] sbuf_ra_04;
wire [3:0] sbuf_ra_05;
wire [3:0] sbuf_ra_06;
wire [3:0] sbuf_ra_07;
wire [3:0] sbuf_ra_08;
wire [3:0] sbuf_ra_09;
wire [3:0] sbuf_ra_10;
wire [3:0] sbuf_ra_11;
wire [3:0] sbuf_ra_12;
wire [3:0] sbuf_ra_13;
wire [3:0] sbuf_ra_14;
wire [3:0] sbuf_ra_15;
wire [63:0] sbuf_p0_norm_rdat;
wire [63:0] sbuf_p1_norm_rdat;
wire [63:0] sbuf_p0_rdat;
wire [63:0] sbuf_p1_rdat;

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// Input port to RAMS //
////////////////////////////////////////////////////////////////////////
//: my $i;
//: my $j;
//: my $k;
//: my $serial;
//: my $b1;
//: my $b0;
//: my $bits;
//: my @input_list;
//: my $def_wino = 0;
//: if($def_wino) {
//: @input_list = ("dc", "wg", "img");
//: } else {
//: @input_list = ("dc", "img");
//: }
//: my $name;
//:
//: $b1 = int(log(256)/log(2)) - 1;
//: $b0 = int(log(256)/log(2)) - int(log(16)/log(2));
//: for($i = 0; $i < @input_list; $i ++) {
//: $name = $input_list[$i];
//: print qq (
//: assign ${name}2sbuf_p0_wr_bsel = ${name}2sbuf_p0_wr_addr[${b1}:${b0}];
//: assign ${name}2sbuf_p1_wr_bsel = ${name}2sbuf_p1_wr_addr[${b1}:${b0}];\n);
//: }
//: print qq (\n\n);
//:
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $bits = int(log(16)/log(2));
//: for($i = 0; $i < @input_list; $i ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $name = $input_list[$i];
//: print qq (assign ${name}2sbuf_p${k}_wr_sel_${serial} = (${name}2sbuf_p${k}_wr_bsel == ${bits}'d${j}) & ${name}2sbuf_p${k}_wr_en;\n);
//: }
//: }
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: print qq (assign sbuf_we_${serial} = );
//: for($i = 0; $i < @input_list; $i ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $name = $input_list[$i];
//: print qq (${name}2sbuf_p${k}_wr_sel_${serial});
//: if($i != @input_list - 1 || $k != 1) {
//: print qq ( |\n );
//: } else {
//: print qq (;\n\n);
//: }
//: }
//: }
//: print qq (\n\n);
//: }
//:
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $bits = int(log(256)/log(2)) - int(log(16)/log(2));
//: $b1 = int(log(256)/log(2)) - int(log(16)/log(2)) - 1;
//: $b0 = 0;
//: print qq (assign sbuf_wa_${serial} = );
//: for($i = 0; $i < @input_list; $i ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $name = $input_list[$i];
//: print qq (({${bits}{${name}2sbuf_p${k}_wr_sel_${serial}}} & ${name}2sbuf_p${k}_wr_addr[${b1}:${b0}]));
//: if($i != @input_list - 1 || $k != 1) {
//: print qq ( |\n );
//: } else {
//: print qq (;\n\n);
//: }
//: }
//: }
//: print qq (\n\n);
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $bits = 8*8;
//: print qq (assign sbuf_wdat_${serial} = );
//: for($i = 0; $i < @input_list; $i ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $name = $input_list[$i];
//: print qq (({${bits}{${name}2sbuf_p${k}_wr_sel_${serial}}} & ${name}2sbuf_p${k}_wr_data));
//: if($i != @input_list - 1 || $k != 1) {
//: print qq ( |\n );
//: } else {
//: print qq (;\n\n);
//: }
//: }
//: }
//: print qq (\n\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dc2sbuf_p0_wr_bsel = dc2sbuf_p0_wr_addr[7:4];
assign dc2sbuf_p1_wr_bsel = dc2sbuf_p1_wr_addr[7:4];

assign img2sbuf_p0_wr_bsel = img2sbuf_p0_wr_addr[7:4];
assign img2sbuf_p1_wr_bsel = img2sbuf_p1_wr_addr[7:4];


assign dc2sbuf_p0_wr_sel_00 = (dc2sbuf_p0_wr_bsel == 4'd0) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_00 = (dc2sbuf_p1_wr_bsel == 4'd0) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_00 = (img2sbuf_p0_wr_bsel == 4'd0) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_00 = (img2sbuf_p1_wr_bsel == 4'd0) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_01 = (dc2sbuf_p0_wr_bsel == 4'd1) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_01 = (dc2sbuf_p1_wr_bsel == 4'd1) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_01 = (img2sbuf_p0_wr_bsel == 4'd1) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_01 = (img2sbuf_p1_wr_bsel == 4'd1) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_02 = (dc2sbuf_p0_wr_bsel == 4'd2) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_02 = (dc2sbuf_p1_wr_bsel == 4'd2) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_02 = (img2sbuf_p0_wr_bsel == 4'd2) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_02 = (img2sbuf_p1_wr_bsel == 4'd2) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_03 = (dc2sbuf_p0_wr_bsel == 4'd3) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_03 = (dc2sbuf_p1_wr_bsel == 4'd3) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_03 = (img2sbuf_p0_wr_bsel == 4'd3) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_03 = (img2sbuf_p1_wr_bsel == 4'd3) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_04 = (dc2sbuf_p0_wr_bsel == 4'd4) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_04 = (dc2sbuf_p1_wr_bsel == 4'd4) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_04 = (img2sbuf_p0_wr_bsel == 4'd4) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_04 = (img2sbuf_p1_wr_bsel == 4'd4) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_05 = (dc2sbuf_p0_wr_bsel == 4'd5) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_05 = (dc2sbuf_p1_wr_bsel == 4'd5) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_05 = (img2sbuf_p0_wr_bsel == 4'd5) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_05 = (img2sbuf_p1_wr_bsel == 4'd5) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_06 = (dc2sbuf_p0_wr_bsel == 4'd6) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_06 = (dc2sbuf_p1_wr_bsel == 4'd6) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_06 = (img2sbuf_p0_wr_bsel == 4'd6) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_06 = (img2sbuf_p1_wr_bsel == 4'd6) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_07 = (dc2sbuf_p0_wr_bsel == 4'd7) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_07 = (dc2sbuf_p1_wr_bsel == 4'd7) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_07 = (img2sbuf_p0_wr_bsel == 4'd7) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_07 = (img2sbuf_p1_wr_bsel == 4'd7) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_08 = (dc2sbuf_p0_wr_bsel == 4'd8) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_08 = (dc2sbuf_p1_wr_bsel == 4'd8) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_08 = (img2sbuf_p0_wr_bsel == 4'd8) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_08 = (img2sbuf_p1_wr_bsel == 4'd8) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_09 = (dc2sbuf_p0_wr_bsel == 4'd9) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_09 = (dc2sbuf_p1_wr_bsel == 4'd9) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_09 = (img2sbuf_p0_wr_bsel == 4'd9) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_09 = (img2sbuf_p1_wr_bsel == 4'd9) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_10 = (dc2sbuf_p0_wr_bsel == 4'd10) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_10 = (dc2sbuf_p1_wr_bsel == 4'd10) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_10 = (img2sbuf_p0_wr_bsel == 4'd10) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_10 = (img2sbuf_p1_wr_bsel == 4'd10) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_11 = (dc2sbuf_p0_wr_bsel == 4'd11) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_11 = (dc2sbuf_p1_wr_bsel == 4'd11) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_11 = (img2sbuf_p0_wr_bsel == 4'd11) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_11 = (img2sbuf_p1_wr_bsel == 4'd11) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_12 = (dc2sbuf_p0_wr_bsel == 4'd12) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_12 = (dc2sbuf_p1_wr_bsel == 4'd12) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_12 = (img2sbuf_p0_wr_bsel == 4'd12) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_12 = (img2sbuf_p1_wr_bsel == 4'd12) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_13 = (dc2sbuf_p0_wr_bsel == 4'd13) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_13 = (dc2sbuf_p1_wr_bsel == 4'd13) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_13 = (img2sbuf_p0_wr_bsel == 4'd13) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_13 = (img2sbuf_p1_wr_bsel == 4'd13) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_14 = (dc2sbuf_p0_wr_bsel == 4'd14) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_14 = (dc2sbuf_p1_wr_bsel == 4'd14) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_14 = (img2sbuf_p0_wr_bsel == 4'd14) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_14 = (img2sbuf_p1_wr_bsel == 4'd14) & img2sbuf_p1_wr_en;
assign dc2sbuf_p0_wr_sel_15 = (dc2sbuf_p0_wr_bsel == 4'd15) & dc2sbuf_p0_wr_en;
assign dc2sbuf_p1_wr_sel_15 = (dc2sbuf_p1_wr_bsel == 4'd15) & dc2sbuf_p1_wr_en;
assign img2sbuf_p0_wr_sel_15 = (img2sbuf_p0_wr_bsel == 4'd15) & img2sbuf_p0_wr_en;
assign img2sbuf_p1_wr_sel_15 = (img2sbuf_p1_wr_bsel == 4'd15) & img2sbuf_p1_wr_en;
assign sbuf_we_00 = dc2sbuf_p0_wr_sel_00 |
 dc2sbuf_p1_wr_sel_00 |
 img2sbuf_p0_wr_sel_00 |
 img2sbuf_p1_wr_sel_00;



assign sbuf_we_01 = dc2sbuf_p0_wr_sel_01 |
 dc2sbuf_p1_wr_sel_01 |
 img2sbuf_p0_wr_sel_01 |
 img2sbuf_p1_wr_sel_01;



assign sbuf_we_02 = dc2sbuf_p0_wr_sel_02 |
 dc2sbuf_p1_wr_sel_02 |
 img2sbuf_p0_wr_sel_02 |
 img2sbuf_p1_wr_sel_02;



assign sbuf_we_03 = dc2sbuf_p0_wr_sel_03 |
 dc2sbuf_p1_wr_sel_03 |
 img2sbuf_p0_wr_sel_03 |
 img2sbuf_p1_wr_sel_03;



assign sbuf_we_04 = dc2sbuf_p0_wr_sel_04 |
 dc2sbuf_p1_wr_sel_04 |
 img2sbuf_p0_wr_sel_04 |
 img2sbuf_p1_wr_sel_04;



assign sbuf_we_05 = dc2sbuf_p0_wr_sel_05 |
 dc2sbuf_p1_wr_sel_05 |
 img2sbuf_p0_wr_sel_05 |
 img2sbuf_p1_wr_sel_05;



assign sbuf_we_06 = dc2sbuf_p0_wr_sel_06 |
 dc2sbuf_p1_wr_sel_06 |
 img2sbuf_p0_wr_sel_06 |
 img2sbuf_p1_wr_sel_06;



assign sbuf_we_07 = dc2sbuf_p0_wr_sel_07 |
 dc2sbuf_p1_wr_sel_07 |
 img2sbuf_p0_wr_sel_07 |
 img2sbuf_p1_wr_sel_07;



assign sbuf_we_08 = dc2sbuf_p0_wr_sel_08 |
 dc2sbuf_p1_wr_sel_08 |
 img2sbuf_p0_wr_sel_08 |
 img2sbuf_p1_wr_sel_08;



assign sbuf_we_09 = dc2sbuf_p0_wr_sel_09 |
 dc2sbuf_p1_wr_sel_09 |
 img2sbuf_p0_wr_sel_09 |
 img2sbuf_p1_wr_sel_09;



assign sbuf_we_10 = dc2sbuf_p0_wr_sel_10 |
 dc2sbuf_p1_wr_sel_10 |
 img2sbuf_p0_wr_sel_10 |
 img2sbuf_p1_wr_sel_10;



assign sbuf_we_11 = dc2sbuf_p0_wr_sel_11 |
 dc2sbuf_p1_wr_sel_11 |
 img2sbuf_p0_wr_sel_11 |
 img2sbuf_p1_wr_sel_11;



assign sbuf_we_12 = dc2sbuf_p0_wr_sel_12 |
 dc2sbuf_p1_wr_sel_12 |
 img2sbuf_p0_wr_sel_12 |
 img2sbuf_p1_wr_sel_12;



assign sbuf_we_13 = dc2sbuf_p0_wr_sel_13 |
 dc2sbuf_p1_wr_sel_13 |
 img2sbuf_p0_wr_sel_13 |
 img2sbuf_p1_wr_sel_13;



assign sbuf_we_14 = dc2sbuf_p0_wr_sel_14 |
 dc2sbuf_p1_wr_sel_14 |
 img2sbuf_p0_wr_sel_14 |
 img2sbuf_p1_wr_sel_14;



assign sbuf_we_15 = dc2sbuf_p0_wr_sel_15 |
 dc2sbuf_p1_wr_sel_15 |
 img2sbuf_p0_wr_sel_15 |
 img2sbuf_p1_wr_sel_15;



assign sbuf_wa_00 = ({4{dc2sbuf_p0_wr_sel_00}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_00}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_00}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_00}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_01 = ({4{dc2sbuf_p0_wr_sel_01}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_01}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_01}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_01}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_02 = ({4{dc2sbuf_p0_wr_sel_02}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_02}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_02}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_02}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_03 = ({4{dc2sbuf_p0_wr_sel_03}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_03}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_03}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_03}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_04 = ({4{dc2sbuf_p0_wr_sel_04}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_04}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_04}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_04}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_05 = ({4{dc2sbuf_p0_wr_sel_05}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_05}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_05}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_05}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_06 = ({4{dc2sbuf_p0_wr_sel_06}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_06}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_06}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_06}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_07 = ({4{dc2sbuf_p0_wr_sel_07}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_07}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_07}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_07}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_08 = ({4{dc2sbuf_p0_wr_sel_08}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_08}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_08}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_08}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_09 = ({4{dc2sbuf_p0_wr_sel_09}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_09}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_09}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_09}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_10 = ({4{dc2sbuf_p0_wr_sel_10}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_10}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_10}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_10}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_11 = ({4{dc2sbuf_p0_wr_sel_11}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_11}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_11}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_11}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_12 = ({4{dc2sbuf_p0_wr_sel_12}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_12}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_12}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_12}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_13 = ({4{dc2sbuf_p0_wr_sel_13}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_13}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_13}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_13}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_14 = ({4{dc2sbuf_p0_wr_sel_14}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_14}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_14}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_14}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wa_15 = ({4{dc2sbuf_p0_wr_sel_15}} & dc2sbuf_p0_wr_addr[3:0]) |
 ({4{dc2sbuf_p1_wr_sel_15}} & dc2sbuf_p1_wr_addr[3:0]) |
 ({4{img2sbuf_p0_wr_sel_15}} & img2sbuf_p0_wr_addr[3:0]) |
 ({4{img2sbuf_p1_wr_sel_15}} & img2sbuf_p1_wr_addr[3:0]);



assign sbuf_wdat_00 = ({64{dc2sbuf_p0_wr_sel_00}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_00}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_00}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_00}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_01 = ({64{dc2sbuf_p0_wr_sel_01}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_01}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_01}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_01}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_02 = ({64{dc2sbuf_p0_wr_sel_02}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_02}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_02}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_02}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_03 = ({64{dc2sbuf_p0_wr_sel_03}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_03}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_03}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_03}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_04 = ({64{dc2sbuf_p0_wr_sel_04}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_04}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_04}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_04}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_05 = ({64{dc2sbuf_p0_wr_sel_05}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_05}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_05}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_05}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_06 = ({64{dc2sbuf_p0_wr_sel_06}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_06}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_06}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_06}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_07 = ({64{dc2sbuf_p0_wr_sel_07}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_07}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_07}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_07}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_08 = ({64{dc2sbuf_p0_wr_sel_08}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_08}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_08}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_08}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_09 = ({64{dc2sbuf_p0_wr_sel_09}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_09}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_09}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_09}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_10 = ({64{dc2sbuf_p0_wr_sel_10}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_10}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_10}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_10}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_11 = ({64{dc2sbuf_p0_wr_sel_11}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_11}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_11}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_11}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_12 = ({64{dc2sbuf_p0_wr_sel_12}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_12}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_12}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_12}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_13 = ({64{dc2sbuf_p0_wr_sel_13}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_13}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_13}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_13}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_14 = ({64{dc2sbuf_p0_wr_sel_14}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_14}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_14}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_14}} & img2sbuf_p1_wr_data);



assign sbuf_wdat_15 = ({64{dc2sbuf_p0_wr_sel_15}} & dc2sbuf_p0_wr_data) |
 ({64{dc2sbuf_p1_wr_sel_15}} & dc2sbuf_p1_wr_data) |
 ({64{img2sbuf_p0_wr_sel_15}} & img2sbuf_p0_wr_data) |
 ({64{img2sbuf_p1_wr_sel_15}} & img2sbuf_p1_wr_data);




//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////\n";
// Instance 16 256bx8 RAMs as local shared buffers //\n";
////////////////////////////////////////////////////////////////////////\n";
//: my $i;
//: my $serial;
//: my $bits;
//: my $depth;
//: $bits = 8*8;
//: $depth = 256 / 16;
//: for($i = 0; $i < 16; $i ++) {
//: $serial = sprintf("%02d", $i);
//: print qq {
//: nv_ram_rws_${depth}x${bits} u_shared_buffer_${serial} (
//: .clk (nvdla_core_clk) //|< i
//: ,.ra (sbuf_ra_${serial}) //|< r
//: ,.re (sbuf_re_${serial}) //|< r
//: ,.dout (sbuf_rdat_${serial}) //|> w
//: ,.wa (sbuf_wa_${serial}) //|< r
//: ,.we (sbuf_we_${serial}) //|< r
//: ,.di (sbuf_wdat_${serial}) //|< r
//: ,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
//: );\n\n};
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

nv_ram_rws_16x64 u_shared_buffer_00 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_00) //|< r
,.re (sbuf_re_00) //|< r
,.dout (sbuf_rdat_00) //|> w
,.wa (sbuf_wa_00) //|< r
,.we (sbuf_we_00) //|< r
,.di (sbuf_wdat_00) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_01 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_01) //|< r
,.re (sbuf_re_01) //|< r
,.dout (sbuf_rdat_01) //|> w
,.wa (sbuf_wa_01) //|< r
,.we (sbuf_we_01) //|< r
,.di (sbuf_wdat_01) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_02 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_02) //|< r
,.re (sbuf_re_02) //|< r
,.dout (sbuf_rdat_02) //|> w
,.wa (sbuf_wa_02) //|< r
,.we (sbuf_we_02) //|< r
,.di (sbuf_wdat_02) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_03 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_03) //|< r
,.re (sbuf_re_03) //|< r
,.dout (sbuf_rdat_03) //|> w
,.wa (sbuf_wa_03) //|< r
,.we (sbuf_we_03) //|< r
,.di (sbuf_wdat_03) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_04 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_04) //|< r
,.re (sbuf_re_04) //|< r
,.dout (sbuf_rdat_04) //|> w
,.wa (sbuf_wa_04) //|< r
,.we (sbuf_we_04) //|< r
,.di (sbuf_wdat_04) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_05 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_05) //|< r
,.re (sbuf_re_05) //|< r
,.dout (sbuf_rdat_05) //|> w
,.wa (sbuf_wa_05) //|< r
,.we (sbuf_we_05) //|< r
,.di (sbuf_wdat_05) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_06 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_06) //|< r
,.re (sbuf_re_06) //|< r
,.dout (sbuf_rdat_06) //|> w
,.wa (sbuf_wa_06) //|< r
,.we (sbuf_we_06) //|< r
,.di (sbuf_wdat_06) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_07 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_07) //|< r
,.re (sbuf_re_07) //|< r
,.dout (sbuf_rdat_07) //|> w
,.wa (sbuf_wa_07) //|< r
,.we (sbuf_we_07) //|< r
,.di (sbuf_wdat_07) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_08 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_08) //|< r
,.re (sbuf_re_08) //|< r
,.dout (sbuf_rdat_08) //|> w
,.wa (sbuf_wa_08) //|< r
,.we (sbuf_we_08) //|< r
,.di (sbuf_wdat_08) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_09 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_09) //|< r
,.re (sbuf_re_09) //|< r
,.dout (sbuf_rdat_09) //|> w
,.wa (sbuf_wa_09) //|< r
,.we (sbuf_we_09) //|< r
,.di (sbuf_wdat_09) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_10 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_10) //|< r
,.re (sbuf_re_10) //|< r
,.dout (sbuf_rdat_10) //|> w
,.wa (sbuf_wa_10) //|< r
,.we (sbuf_we_10) //|< r
,.di (sbuf_wdat_10) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_11 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_11) //|< r
,.re (sbuf_re_11) //|< r
,.dout (sbuf_rdat_11) //|> w
,.wa (sbuf_wa_11) //|< r
,.we (sbuf_we_11) //|< r
,.di (sbuf_wdat_11) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_12 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_12) //|< r
,.re (sbuf_re_12) //|< r
,.dout (sbuf_rdat_12) //|> w
,.wa (sbuf_wa_12) //|< r
,.we (sbuf_we_12) //|< r
,.di (sbuf_wdat_12) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_13 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_13) //|< r
,.re (sbuf_re_13) //|< r
,.dout (sbuf_rdat_13) //|> w
,.wa (sbuf_wa_13) //|< r
,.we (sbuf_we_13) //|< r
,.di (sbuf_wdat_13) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_14 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_14) //|< r
,.re (sbuf_re_14) //|< r
,.dout (sbuf_rdat_14) //|> w
,.wa (sbuf_wa_14) //|< r
,.we (sbuf_we_14) //|< r
,.di (sbuf_wdat_14) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


nv_ram_rws_16x64 u_shared_buffer_15 (
.clk (nvdla_core_clk) //|< i
,.ra (sbuf_ra_15) //|< r
,.re (sbuf_re_15) //|< r
,.dout (sbuf_rdat_15) //|> w
,.wa (sbuf_wa_15) //|< r
,.we (sbuf_we_15) //|< r
,.di (sbuf_wdat_15) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
);


//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////\n";
// RAMs to output port: stage 1 //\n";
////////////////////////////////////////////////////////////////////////\n";
//: my $i;
//: my $j;
//: my $k;
//: my $serial;
//: my @input_list;
//: my $def_wino = 0;
//: if($def_wino) {
//: @input_list = ("dc", "wg", "img");
//: } else {
//: @input_list = ("dc", "img");
//: }
//: my @input_list_1 = ("dc", "img");
//: my $name;
//: my $b1;
//: my $b0;
//: my $bits;
//:
//: $b1 = int(log(256)/log(2)) - 1;
//: $b0 = int(log(256)/log(2)) - int(log(16)/log(2));
//: for($i = 0; $i < @input_list_1; $i ++) {
//: $name = $input_list_1[$i];
//: print qq (
//: assign ${name}2sbuf_p0_rd_bsel = ${name}2sbuf_p0_rd_addr[${b1}:${b0}];
//: assign ${name}2sbuf_p1_rd_bsel = ${name}2sbuf_p1_rd_addr[${b1}:${b0}];\n);
//: }
//:
//: if($def_wino) {
//: $b1 = int(log(256)/log(2)) - 1;
//: $b0 = int(log(256)/log(2)) - int(log(16)/log(2)) + 2;
//: print qq (
//: assign wg2sbuf_p0_rd_bsel = wg2sbuf_p0_rd_addr[${b1}:${b0}];
//: assign wg2sbuf_p1_rd_bsel = wg2sbuf_p1_rd_addr[${b1}:${b0}];\n);
//: print qq (\n\n);
//:
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $bits = int(log(16)/log(2));
//: for($i = 0; $i < @input_list_1; $i ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $name = $input_list_1[$i];
//: print qq (assign ${name}2sbuf_p${k}_rd_sel_${serial} = (${name}2sbuf_p${k}_rd_bsel == ${bits}'d${j}) & ${name}2sbuf_p${k}_rd_en;\n);
//: }
//: }
//: }
//: print qq (\n\n);
//:
//: if($def_wino) {
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $bits = int(log(16)/log(2)) - 2;
//: $i = int($j/4);
//: for($k = 0; $k < 2; $k ++) {
//: print qq (assign wg2sbuf_p${k}_rd_sel_${serial} = (wg2sbuf_p${k}_rd_bsel == ${bits}'d${i}) & wg2sbuf_p${k}_rd_en;\n);
//: }
//: }
//: print qq (\n\n);
//:
//: }
//: for($j = 0; $j < 16; $j ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $serial = sprintf("%02d", $j);
//: print qq (assign sbuf_p${k}_re_${serial} = );
//: for($i = 0; $i < @input_list; $i ++) {
//: $name = $input_list[$i];
//: print qq (${name}2sbuf_p${k}_rd_sel_${serial});
//: if($i != @input_list - 1) {
//: print qq ( | );
//: } else {
//: print qq (;\n);
//: }
//: }
//: }
//: }
//: print qq (\n\n);
//:
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: print qq (assign sbuf_re_${serial} = sbuf_p0_re_${serial} | sbuf_p1_re_${serial};\n);
//: }
//: print qq (\n\n);
//:
//: $b1 = int(log(256)/log(2)) - int(log(16)/log(2)) - 1;
//: $b0 = 0;
//: for($i = 0; $i < @input_list_1; $i ++) {
//: $name = $input_list_1[$i];
//: print qq (
//: assign ${name}2sbuf_p0_rd_esel = ${name}2sbuf_p0_rd_addr[${b1}:${b0}];
//: assign ${name}2sbuf_p1_rd_esel = ${name}2sbuf_p1_rd_addr[${b1}:${b0}];\n);
//: }
//:
//: if($def_wino) {
//: $b1 = int(log(256)/log(2)) - int(log(16)/log(2)) + 1;
//: $b0 = 2;
//: print qq (
//: assign wg2sbuf_p0_rd_esel = wg2sbuf_p0_rd_addr[${b1}:${b0}];
//: assign wg2sbuf_p1_rd_esel = wg2sbuf_p1_rd_addr[${b1}:${b0}];\n);
//: print qq (\n\n);
//:
//: }
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: $bits = int(log(256)/log(2)) - int(log(16)/log(2));
//: print qq (assign sbuf_ra_${serial} = );
//: for($i = 0; $i < @input_list; $i ++) {
//: for($k = 0; $k < 2; $k ++) {
//: $name = $input_list[$i];
//: print qq (({${bits}{${name}2sbuf_p${k}_rd_sel_${serial}}} & ${name}2sbuf_p${k}_rd_esel));
//: if($i != @input_list - 1 || $k != 1) {
//: print qq ( |\n );
//: } else {
//: print qq (;\n\n);
//: }
//: }
//: }
//: }
//: print qq (\n\n);
//:
//: if($def_wino) {
//: for($k = 0; $k < 2; $k ++) {
//: for($i = 0; $i < 4; $i ++) {
//: print qq(assign sbuf_p${k}_wg_sel_q${i} = (wg2sbuf_p${k}_rd_addr[1:0] == 2'h${i}) & wg2sbuf_p${k}_rd_en;\n);
//: }
//: }
//: print qq (\n\n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dc2sbuf_p0_rd_bsel = dc2sbuf_p0_rd_addr[7:4];
assign dc2sbuf_p1_rd_bsel = dc2sbuf_p1_rd_addr[7:4];

assign img2sbuf_p0_rd_bsel = img2sbuf_p0_rd_addr[7:4];
assign img2sbuf_p1_rd_bsel = img2sbuf_p1_rd_addr[7:4];
assign dc2sbuf_p0_rd_sel_00 = (dc2sbuf_p0_rd_bsel == 4'd0) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_00 = (dc2sbuf_p1_rd_bsel == 4'd0) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_00 = (img2sbuf_p0_rd_bsel == 4'd0) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_00 = (img2sbuf_p1_rd_bsel == 4'd0) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_01 = (dc2sbuf_p0_rd_bsel == 4'd1) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_01 = (dc2sbuf_p1_rd_bsel == 4'd1) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_01 = (img2sbuf_p0_rd_bsel == 4'd1) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_01 = (img2sbuf_p1_rd_bsel == 4'd1) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_02 = (dc2sbuf_p0_rd_bsel == 4'd2) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_02 = (dc2sbuf_p1_rd_bsel == 4'd2) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_02 = (img2sbuf_p0_rd_bsel == 4'd2) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_02 = (img2sbuf_p1_rd_bsel == 4'd2) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_03 = (dc2sbuf_p0_rd_bsel == 4'd3) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_03 = (dc2sbuf_p1_rd_bsel == 4'd3) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_03 = (img2sbuf_p0_rd_bsel == 4'd3) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_03 = (img2sbuf_p1_rd_bsel == 4'd3) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_04 = (dc2sbuf_p0_rd_bsel == 4'd4) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_04 = (dc2sbuf_p1_rd_bsel == 4'd4) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_04 = (img2sbuf_p0_rd_bsel == 4'd4) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_04 = (img2sbuf_p1_rd_bsel == 4'd4) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_05 = (dc2sbuf_p0_rd_bsel == 4'd5) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_05 = (dc2sbuf_p1_rd_bsel == 4'd5) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_05 = (img2sbuf_p0_rd_bsel == 4'd5) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_05 = (img2sbuf_p1_rd_bsel == 4'd5) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_06 = (dc2sbuf_p0_rd_bsel == 4'd6) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_06 = (dc2sbuf_p1_rd_bsel == 4'd6) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_06 = (img2sbuf_p0_rd_bsel == 4'd6) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_06 = (img2sbuf_p1_rd_bsel == 4'd6) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_07 = (dc2sbuf_p0_rd_bsel == 4'd7) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_07 = (dc2sbuf_p1_rd_bsel == 4'd7) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_07 = (img2sbuf_p0_rd_bsel == 4'd7) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_07 = (img2sbuf_p1_rd_bsel == 4'd7) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_08 = (dc2sbuf_p0_rd_bsel == 4'd8) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_08 = (dc2sbuf_p1_rd_bsel == 4'd8) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_08 = (img2sbuf_p0_rd_bsel == 4'd8) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_08 = (img2sbuf_p1_rd_bsel == 4'd8) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_09 = (dc2sbuf_p0_rd_bsel == 4'd9) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_09 = (dc2sbuf_p1_rd_bsel == 4'd9) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_09 = (img2sbuf_p0_rd_bsel == 4'd9) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_09 = (img2sbuf_p1_rd_bsel == 4'd9) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_10 = (dc2sbuf_p0_rd_bsel == 4'd10) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_10 = (dc2sbuf_p1_rd_bsel == 4'd10) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_10 = (img2sbuf_p0_rd_bsel == 4'd10) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_10 = (img2sbuf_p1_rd_bsel == 4'd10) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_11 = (dc2sbuf_p0_rd_bsel == 4'd11) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_11 = (dc2sbuf_p1_rd_bsel == 4'd11) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_11 = (img2sbuf_p0_rd_bsel == 4'd11) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_11 = (img2sbuf_p1_rd_bsel == 4'd11) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_12 = (dc2sbuf_p0_rd_bsel == 4'd12) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_12 = (dc2sbuf_p1_rd_bsel == 4'd12) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_12 = (img2sbuf_p0_rd_bsel == 4'd12) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_12 = (img2sbuf_p1_rd_bsel == 4'd12) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_13 = (dc2sbuf_p0_rd_bsel == 4'd13) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_13 = (dc2sbuf_p1_rd_bsel == 4'd13) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_13 = (img2sbuf_p0_rd_bsel == 4'd13) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_13 = (img2sbuf_p1_rd_bsel == 4'd13) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_14 = (dc2sbuf_p0_rd_bsel == 4'd14) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_14 = (dc2sbuf_p1_rd_bsel == 4'd14) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_14 = (img2sbuf_p0_rd_bsel == 4'd14) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_14 = (img2sbuf_p1_rd_bsel == 4'd14) & img2sbuf_p1_rd_en;
assign dc2sbuf_p0_rd_sel_15 = (dc2sbuf_p0_rd_bsel == 4'd15) & dc2sbuf_p0_rd_en;
assign dc2sbuf_p1_rd_sel_15 = (dc2sbuf_p1_rd_bsel == 4'd15) & dc2sbuf_p1_rd_en;
assign img2sbuf_p0_rd_sel_15 = (img2sbuf_p0_rd_bsel == 4'd15) & img2sbuf_p0_rd_en;
assign img2sbuf_p1_rd_sel_15 = (img2sbuf_p1_rd_bsel == 4'd15) & img2sbuf_p1_rd_en;


assign sbuf_p0_re_00 = dc2sbuf_p0_rd_sel_00 | img2sbuf_p0_rd_sel_00;
assign sbuf_p1_re_00 = dc2sbuf_p1_rd_sel_00 | img2sbuf_p1_rd_sel_00;
assign sbuf_p0_re_01 = dc2sbuf_p0_rd_sel_01 | img2sbuf_p0_rd_sel_01;
assign sbuf_p1_re_01 = dc2sbuf_p1_rd_sel_01 | img2sbuf_p1_rd_sel_01;
assign sbuf_p0_re_02 = dc2sbuf_p0_rd_sel_02 | img2sbuf_p0_rd_sel_02;
assign sbuf_p1_re_02 = dc2sbuf_p1_rd_sel_02 | img2sbuf_p1_rd_sel_02;
assign sbuf_p0_re_03 = dc2sbuf_p0_rd_sel_03 | img2sbuf_p0_rd_sel_03;
assign sbuf_p1_re_03 = dc2sbuf_p1_rd_sel_03 | img2sbuf_p1_rd_sel_03;
assign sbuf_p0_re_04 = dc2sbuf_p0_rd_sel_04 | img2sbuf_p0_rd_sel_04;
assign sbuf_p1_re_04 = dc2sbuf_p1_rd_sel_04 | img2sbuf_p1_rd_sel_04;
assign sbuf_p0_re_05 = dc2sbuf_p0_rd_sel_05 | img2sbuf_p0_rd_sel_05;
assign sbuf_p1_re_05 = dc2sbuf_p1_rd_sel_05 | img2sbuf_p1_rd_sel_05;
assign sbuf_p0_re_06 = dc2sbuf_p0_rd_sel_06 | img2sbuf_p0_rd_sel_06;
assign sbuf_p1_re_06 = dc2sbuf_p1_rd_sel_06 | img2sbuf_p1_rd_sel_06;
assign sbuf_p0_re_07 = dc2sbuf_p0_rd_sel_07 | img2sbuf_p0_rd_sel_07;
assign sbuf_p1_re_07 = dc2sbuf_p1_rd_sel_07 | img2sbuf_p1_rd_sel_07;
assign sbuf_p0_re_08 = dc2sbuf_p0_rd_sel_08 | img2sbuf_p0_rd_sel_08;
assign sbuf_p1_re_08 = dc2sbuf_p1_rd_sel_08 | img2sbuf_p1_rd_sel_08;
assign sbuf_p0_re_09 = dc2sbuf_p0_rd_sel_09 | img2sbuf_p0_rd_sel_09;
assign sbuf_p1_re_09 = dc2sbuf_p1_rd_sel_09 | img2sbuf_p1_rd_sel_09;
assign sbuf_p0_re_10 = dc2sbuf_p0_rd_sel_10 | img2sbuf_p0_rd_sel_10;
assign sbuf_p1_re_10 = dc2sbuf_p1_rd_sel_10 | img2sbuf_p1_rd_sel_10;
assign sbuf_p0_re_11 = dc2sbuf_p0_rd_sel_11 | img2sbuf_p0_rd_sel_11;
assign sbuf_p1_re_11 = dc2sbuf_p1_rd_sel_11 | img2sbuf_p1_rd_sel_11;
assign sbuf_p0_re_12 = dc2sbuf_p0_rd_sel_12 | img2sbuf_p0_rd_sel_12;
assign sbuf_p1_re_12 = dc2sbuf_p1_rd_sel_12 | img2sbuf_p1_rd_sel_12;
assign sbuf_p0_re_13 = dc2sbuf_p0_rd_sel_13 | img2sbuf_p0_rd_sel_13;
assign sbuf_p1_re_13 = dc2sbuf_p1_rd_sel_13 | img2sbuf_p1_rd_sel_13;
assign sbuf_p0_re_14 = dc2sbuf_p0_rd_sel_14 | img2sbuf_p0_rd_sel_14;
assign sbuf_p1_re_14 = dc2sbuf_p1_rd_sel_14 | img2sbuf_p1_rd_sel_14;
assign sbuf_p0_re_15 = dc2sbuf_p0_rd_sel_15 | img2sbuf_p0_rd_sel_15;
assign sbuf_p1_re_15 = dc2sbuf_p1_rd_sel_15 | img2sbuf_p1_rd_sel_15;


assign sbuf_re_00 = sbuf_p0_re_00 | sbuf_p1_re_00;
assign sbuf_re_01 = sbuf_p0_re_01 | sbuf_p1_re_01;
assign sbuf_re_02 = sbuf_p0_re_02 | sbuf_p1_re_02;
assign sbuf_re_03 = sbuf_p0_re_03 | sbuf_p1_re_03;
assign sbuf_re_04 = sbuf_p0_re_04 | sbuf_p1_re_04;
assign sbuf_re_05 = sbuf_p0_re_05 | sbuf_p1_re_05;
assign sbuf_re_06 = sbuf_p0_re_06 | sbuf_p1_re_06;
assign sbuf_re_07 = sbuf_p0_re_07 | sbuf_p1_re_07;
assign sbuf_re_08 = sbuf_p0_re_08 | sbuf_p1_re_08;
assign sbuf_re_09 = sbuf_p0_re_09 | sbuf_p1_re_09;
assign sbuf_re_10 = sbuf_p0_re_10 | sbuf_p1_re_10;
assign sbuf_re_11 = sbuf_p0_re_11 | sbuf_p1_re_11;
assign sbuf_re_12 = sbuf_p0_re_12 | sbuf_p1_re_12;
assign sbuf_re_13 = sbuf_p0_re_13 | sbuf_p1_re_13;
assign sbuf_re_14 = sbuf_p0_re_14 | sbuf_p1_re_14;
assign sbuf_re_15 = sbuf_p0_re_15 | sbuf_p1_re_15;



assign dc2sbuf_p0_rd_esel = dc2sbuf_p0_rd_addr[3:0];
assign dc2sbuf_p1_rd_esel = dc2sbuf_p1_rd_addr[3:0];

assign img2sbuf_p0_rd_esel = img2sbuf_p0_rd_addr[3:0];
assign img2sbuf_p1_rd_esel = img2sbuf_p1_rd_addr[3:0];
assign sbuf_ra_00 = ({4{dc2sbuf_p0_rd_sel_00}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_00}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_00}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_00}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_01 = ({4{dc2sbuf_p0_rd_sel_01}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_01}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_01}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_01}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_02 = ({4{dc2sbuf_p0_rd_sel_02}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_02}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_02}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_02}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_03 = ({4{dc2sbuf_p0_rd_sel_03}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_03}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_03}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_03}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_04 = ({4{dc2sbuf_p0_rd_sel_04}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_04}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_04}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_04}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_05 = ({4{dc2sbuf_p0_rd_sel_05}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_05}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_05}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_05}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_06 = ({4{dc2sbuf_p0_rd_sel_06}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_06}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_06}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_06}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_07 = ({4{dc2sbuf_p0_rd_sel_07}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_07}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_07}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_07}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_08 = ({4{dc2sbuf_p0_rd_sel_08}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_08}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_08}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_08}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_09 = ({4{dc2sbuf_p0_rd_sel_09}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_09}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_09}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_09}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_10 = ({4{dc2sbuf_p0_rd_sel_10}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_10}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_10}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_10}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_11 = ({4{dc2sbuf_p0_rd_sel_11}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_11}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_11}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_11}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_12 = ({4{dc2sbuf_p0_rd_sel_12}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_12}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_12}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_12}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_13 = ({4{dc2sbuf_p0_rd_sel_13}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_13}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_13}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_13}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_14 = ({4{dc2sbuf_p0_rd_sel_14}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_14}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_14}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_14}} & img2sbuf_p1_rd_esel);

assign sbuf_ra_15 = ({4{dc2sbuf_p0_rd_sel_15}} & dc2sbuf_p0_rd_esel) |
 ({4{dc2sbuf_p1_rd_sel_15}} & dc2sbuf_p1_rd_esel) |
 ({4{img2sbuf_p0_rd_sel_15}} & img2sbuf_p0_rd_esel) |
 ({4{img2sbuf_p1_rd_sel_15}} & img2sbuf_p1_rd_esel);




//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////\n";
// RAMs to output port: stage1 register //\n";
////////////////////////////////////////////////////////////////////////\n";
//: my $i;
//: my $j;
//: my $k;
//: my $serial;
//: my $val;
//: my @input_list;
//: my $def_wino = 0;
//: if($def_wino) {
//: @input_list = ("dc", "wg", "img");
//: } else {
//: @input_list = ("dc", "img");
//: }
//: my $name;
//:
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: for($k = 0; $k < 2; $k ++) {
//: if($def_wino) {
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sbuf_p${k}_re_${serial} & ~wg2sbuf_p${k}_rd_en\" -q sbuf_p${k}_re_${serial}_norm_d1");
//: } else {
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sbuf_p${k}_re_${serial}\" -q sbuf_p${k}_re_${serial}_norm_d1");
//: }
//: }
//: }
//: print qq (\n\n);
//:
//: if($def_wino) {
//: for($j = 0; $j < 16/4; $j ++) {
//: $val = sprintf("%02d", $j);
//: $serial = sprintf("%02d", $j*4);
//: for($k = 0; $k < 2; $k ++) {
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sbuf_p${k}_re_${serial} & wg2sbuf_p${k}_rd_en\" -q sbuf_p${k}_re_${val}_wg_d1");
//: }
//: }
//: print qq (\n\n);
//:
//: for($k = 0; $k < 2; $k ++) {
//: for($i = 0; $i < 4; $i ++) {
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"sbuf_p${k}_wg_sel_q${i}\" -q sbuf_p${k}_wg_sel_q${i}_d1");
//: }
//: }
//: print qq (\n\n);
//:
//: }
//: if($def_wino) {
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dc2sbuf_p0_rd_en | wg2sbuf_p0_rd_en | img2sbuf_p0_rd_en\" -q sbuf_p0_rd_en_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dc2sbuf_p1_rd_en | wg2sbuf_p1_rd_en | img2sbuf_p1_rd_en\" -q sbuf_p1_rd_en_d1");
//: } else {
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dc2sbuf_p0_rd_en | img2sbuf_p0_rd_en\" -q sbuf_p0_rd_en_d1");
//: &eperl::flop("-nodeclare   -rval \"1'b0\"   -d \"dc2sbuf_p1_rd_en | img2sbuf_p1_rd_en\" -q sbuf_p1_rd_en_d1");
//: }
//: print qq (\n\n);
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_00_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_00_norm_d1 <= sbuf_p0_re_00;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_00_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_00_norm_d1 <= sbuf_p1_re_00;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_01_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_01_norm_d1 <= sbuf_p0_re_01;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_01_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_01_norm_d1 <= sbuf_p1_re_01;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_02_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_02_norm_d1 <= sbuf_p0_re_02;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_02_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_02_norm_d1 <= sbuf_p1_re_02;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_03_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_03_norm_d1 <= sbuf_p0_re_03;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_03_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_03_norm_d1 <= sbuf_p1_re_03;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_04_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_04_norm_d1 <= sbuf_p0_re_04;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_04_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_04_norm_d1 <= sbuf_p1_re_04;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_05_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_05_norm_d1 <= sbuf_p0_re_05;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_05_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_05_norm_d1 <= sbuf_p1_re_05;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_06_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_06_norm_d1 <= sbuf_p0_re_06;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_06_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_06_norm_d1 <= sbuf_p1_re_06;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_07_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_07_norm_d1 <= sbuf_p0_re_07;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_07_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_07_norm_d1 <= sbuf_p1_re_07;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_08_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_08_norm_d1 <= sbuf_p0_re_08;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_08_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_08_norm_d1 <= sbuf_p1_re_08;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_09_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_09_norm_d1 <= sbuf_p0_re_09;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_09_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_09_norm_d1 <= sbuf_p1_re_09;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_10_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_10_norm_d1 <= sbuf_p0_re_10;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_10_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_10_norm_d1 <= sbuf_p1_re_10;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_11_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_11_norm_d1 <= sbuf_p0_re_11;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_11_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_11_norm_d1 <= sbuf_p1_re_11;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_12_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_12_norm_d1 <= sbuf_p0_re_12;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_12_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_12_norm_d1 <= sbuf_p1_re_12;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_13_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_13_norm_d1 <= sbuf_p0_re_13;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_13_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_13_norm_d1 <= sbuf_p1_re_13;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_14_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_14_norm_d1 <= sbuf_p0_re_14;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_14_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_14_norm_d1 <= sbuf_p1_re_14;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_re_15_norm_d1 <= 1'b0;
   end else begin
       sbuf_p0_re_15_norm_d1 <= sbuf_p0_re_15;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_re_15_norm_d1 <= 1'b0;
   end else begin
       sbuf_p1_re_15_norm_d1 <= sbuf_p1_re_15;
   end
end


always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p0_rd_en_d1 <= 1'b0;
   end else begin
       sbuf_p0_rd_en_d1 <= dc2sbuf_p0_rd_en | img2sbuf_p0_rd_en;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sbuf_p1_rd_en_d1 <= 1'b0;
   end else begin
       sbuf_p1_rd_en_d1 <= dc2sbuf_p1_rd_en | img2sbuf_p1_rd_en;
   end
end



//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////\n";
// RAMs to output port: stage2 //\n";
////////////////////////////////////////////////////////////////////////\n";
//: my $i;
//: my $j;
//: my $k;
//: my $b1;
//: my $b0;
//: my $val;
//: my $serial;
//: my $def_wino = 0;
//:
//: for($k = 0; $k < 2; $k ++) {
//: print qq (assign sbuf_p${k}_norm_rdat = );
//: for($j = 0; $j < 16; $j ++) {
//: $serial = sprintf("%02d", $j);
//: print qq (({8*8{sbuf_p${k}_re_${serial}_norm_d1}} & sbuf_rdat_${serial}));
//: if($j != 16 - 1) {
//: print qq ( |\n );
//: } else {
//: print qq (;\n);
//: }
//: }
//: print qq (\n\n);
//: }
//: print qq (\n\n);
//:
//: if($def_wino) {
//: for($k = 0; $k < 2; $k ++) {
//: for($i = 0; $i < 4; $i ++) {
//: print qq (assign sbuf_p${k}_wg_rdat_src_${i} = );
//: for($j = 0; $j < 16/4; $j ++) {
//: $val = sprintf("%02d", $j);
//: $serial = sprintf("%02d", $j*4 + $i);
//: print qq (({8*8{sbuf_p${k}_re_${val}_wg_d1}} & sbuf_rdat_${serial}));
//: if($j != 16/4 - 1) {
//: print qq ( |\n );
//: } else {
//: print qq (;\n);
//: }
//: }
//: print qq (\n\n);
//: }
//: }
//: print qq (\n\n);
//:
//: for($k = 0; $k < 2; $k ++) {
//: print qq(assign sbuf_p${k}_wg_rdat = );
//: for($i = 0; $i < 4; $i ++) {
//: $b1 = int(8*8/4 * ($i + 1) - 1);
//: $b0 = int(8*8/4 * $i);
//: print qq(\({8*8{sbuf_p${k}_wg_sel_q${i}_d1}} & \{);
//: for($j = 3; $j >= 0; $j --) {
//: print qq(sbuf_p${k}_wg_rdat_src_${j}[${b1}:${b0}]);
//: if($j != 0) {
//: print qq(, );
//: } else {
//: print qq(\}\));
//: }
//: }
//: if($i != 3) {
//: print qq( |\n );
//: } else {
//: print qq(;\n);
//: }
//: }
//: print qq(\n);
//: }
//: print qq (\n\n);
//:
//: for($k = 0; $k < 2; $k ++) {
//: print qq (assign sbuf_p${k}_rdat = sbuf_p${k}_norm_rdat | sbuf_p${k}_wg_rdat;\n);
//: }
//: } else {
//: for($k = 0; $k < 2; $k ++) {
//: print qq (assign sbuf_p${k}_rdat = sbuf_p${k}_norm_rdat;\n);
//: }
//: }
//: print qq (\n\n);
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign sbuf_p0_norm_rdat = ({8*8{sbuf_p0_re_00_norm_d1}} & sbuf_rdat_00) |
 ({8*8{sbuf_p0_re_01_norm_d1}} & sbuf_rdat_01) |
 ({8*8{sbuf_p0_re_02_norm_d1}} & sbuf_rdat_02) |
 ({8*8{sbuf_p0_re_03_norm_d1}} & sbuf_rdat_03) |
 ({8*8{sbuf_p0_re_04_norm_d1}} & sbuf_rdat_04) |
 ({8*8{sbuf_p0_re_05_norm_d1}} & sbuf_rdat_05) |
 ({8*8{sbuf_p0_re_06_norm_d1}} & sbuf_rdat_06) |
 ({8*8{sbuf_p0_re_07_norm_d1}} & sbuf_rdat_07) |
 ({8*8{sbuf_p0_re_08_norm_d1}} & sbuf_rdat_08) |
 ({8*8{sbuf_p0_re_09_norm_d1}} & sbuf_rdat_09) |
 ({8*8{sbuf_p0_re_10_norm_d1}} & sbuf_rdat_10) |
 ({8*8{sbuf_p0_re_11_norm_d1}} & sbuf_rdat_11) |
 ({8*8{sbuf_p0_re_12_norm_d1}} & sbuf_rdat_12) |
 ({8*8{sbuf_p0_re_13_norm_d1}} & sbuf_rdat_13) |
 ({8*8{sbuf_p0_re_14_norm_d1}} & sbuf_rdat_14) |
 ({8*8{sbuf_p0_re_15_norm_d1}} & sbuf_rdat_15);


assign sbuf_p1_norm_rdat = ({8*8{sbuf_p1_re_00_norm_d1}} & sbuf_rdat_00) |
 ({8*8{sbuf_p1_re_01_norm_d1}} & sbuf_rdat_01) |
 ({8*8{sbuf_p1_re_02_norm_d1}} & sbuf_rdat_02) |
 ({8*8{sbuf_p1_re_03_norm_d1}} & sbuf_rdat_03) |
 ({8*8{sbuf_p1_re_04_norm_d1}} & sbuf_rdat_04) |
 ({8*8{sbuf_p1_re_05_norm_d1}} & sbuf_rdat_05) |
 ({8*8{sbuf_p1_re_06_norm_d1}} & sbuf_rdat_06) |
 ({8*8{sbuf_p1_re_07_norm_d1}} & sbuf_rdat_07) |
 ({8*8{sbuf_p1_re_08_norm_d1}} & sbuf_rdat_08) |
 ({8*8{sbuf_p1_re_09_norm_d1}} & sbuf_rdat_09) |
 ({8*8{sbuf_p1_re_10_norm_d1}} & sbuf_rdat_10) |
 ({8*8{sbuf_p1_re_11_norm_d1}} & sbuf_rdat_11) |
 ({8*8{sbuf_p1_re_12_norm_d1}} & sbuf_rdat_12) |
 ({8*8{sbuf_p1_re_13_norm_d1}} & sbuf_rdat_13) |
 ({8*8{sbuf_p1_re_14_norm_d1}} & sbuf_rdat_14) |
 ({8*8{sbuf_p1_re_15_norm_d1}} & sbuf_rdat_15);




assign sbuf_p0_rdat = sbuf_p0_norm_rdat;
assign sbuf_p1_rdat = sbuf_p1_norm_rdat;



//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////\n";
// RAMs to output port: stage2 register //\n";
////////////////////////////////////////////////////////////////////////\n";
//: my $k;
//: for($k = 0; $k < 2; $k ++) {
//: &eperl::flop("-nodeclare  -norst -en \"sbuf_p${k}_rd_en_d1\" -d \"sbuf_p${k}_rdat\" -q sbuf_p${k}_rdat_d2");
//: }
//: print qq (\n\n);
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk) begin
       if ((sbuf_p0_rd_en_d1) == 1'b1) begin
           sbuf_p0_rdat_d2 <= sbuf_p0_rdat;
       // VCS coverage off
       end else if ((sbuf_p0_rd_en_d1) == 1'b0) begin
       end else begin
           sbuf_p0_rdat_d2 <= 'bx;
       // VCS coverage on
       end
end
always @(posedge nvdla_core_clk) begin
       if ((sbuf_p1_rd_en_d1) == 1'b1) begin
           sbuf_p1_rdat_d2 <= sbuf_p1_rdat;
       // VCS coverage off
       end else if ((sbuf_p1_rd_en_d1) == 1'b0) begin
       end else begin
           sbuf_p1_rdat_d2 <= 'bx;
       // VCS coverage on
       end
end



//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////\n";
// RAMs to output port: connect output data signal //\n";
////////////////////////////////////////////////////////////////////////\n";
//: my $i;
//: my $k;
//: my @input_list;
//: my $def_wino = 0;
//: if($def_wino) {
//: @input_list = ("dc", "wg", "img");
//: } else {
//: @input_list = ("dc", "img");
//: }
//: my @input_list_1 = ("dc", "img");
//: my $name;
//: for($k = 0; $k < 2; $k ++) {
//: for($i = 0; $i < @input_list; $i ++) {
//: $name = $input_list[$i];
//: print qq (assign ${name}2sbuf_p${k}_rd_data = sbuf_p${k}_rdat_d2;\n);
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign dc2sbuf_p0_rd_data = sbuf_p0_rdat_d2;
assign img2sbuf_p0_rd_data = sbuf_p0_rdat_d2;
assign dc2sbuf_p1_rd_data = sbuf_p1_rdat_d2;
assign img2sbuf_p1_rd_data = sbuf_p1_rdat_d2;

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////////////////////////////
// Assertion //
////////////////////////////////////////////////////////////////////////
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
  nv_assert_never #(0,0,"multiple write to shared buffer") zzz_assert_never_1x (nvdla_core_clk, `ASSERT_RESET, ((dc2sbuf_p0_wr_en | dc2sbuf_p1_wr_en) & (img2sbuf_p0_wr_en | img2sbuf_p1_wr_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"multiple read to shared buffer") zzz_assert_never_2x (nvdla_core_clk, `ASSERT_RESET, ((dc2sbuf_p0_rd_en | dc2sbuf_p1_rd_en) & (img2sbuf_p0_rd_en | img2sbuf_p1_rd_en))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"dc write same buffer") zzz_assert_never_3x (nvdla_core_clk, `ASSERT_RESET, (dc2sbuf_p0_wr_en & dc2sbuf_p1_wr_en & (dc2sbuf_p0_wr_bsel == dc2sbuf_p1_wr_bsel))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"img write same buffer") zzz_assert_never_5x (nvdla_core_clk, `ASSERT_RESET, (img2sbuf_p0_wr_en & img2sbuf_p1_wr_en & (img2sbuf_p0_wr_bsel == img2sbuf_p1_wr_bsel))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"dc read same buffer") zzz_assert_never_6x (nvdla_core_clk, `ASSERT_RESET, (dc2sbuf_p0_rd_en & dc2sbuf_p1_rd_en & (dc2sbuf_p0_rd_bsel == dc2sbuf_p1_rd_bsel))); // spyglass disable W504 SelfDeterminedExpr-ML 
  nv_assert_never #(0,0,"img read same buffer") zzz_assert_never_8x (nvdla_core_clk, `ASSERT_RESET, (img2sbuf_p0_rd_en & img2sbuf_p1_rd_en & (img2sbuf_p0_rd_bsel == img2sbuf_p1_rd_bsel))); // spyglass disable W504 SelfDeterminedExpr-ML 
//for(my $i = 0; $i < 16; $i ++) {
// my $j = sprintf("%02d", $i);
// my $k = $i + 9;
// vprint qq {
// nv_assert_never #(0,0,"Error! shared ram ${j} read and write hazard!") zzz_assert_never_${k} (nvdla_core_clk, `ASSERT_RESET, (sbuf_re_${j} & sbuf_we_${j} & (sbuf_ra_${j} == sbuf_wa_${j}))); \/\/ spyglass disable W504 SelfDeterminedExpr-ML};
//}
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
endmodule // NV_NVDLA_CDMA_shared_buffer
