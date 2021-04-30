// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC_calculator.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC.h
module NV_NVDLA_CACC_calculator (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,abuf_rd_data //|< i
  ,accu_ctrl_pd //|< i
  ,accu_ctrl_ram_valid //|< i
  ,accu_ctrl_valid //|< i
  ,cfg_in_en_mask //|< i
  ,cfg_is_wg //|< i
  ,cfg_truncate //|< i
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,mac_a2accu_data${i} //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,mac_a2accu_data0 //|< i 
,mac_a2accu_data1 //|< i 
,mac_a2accu_data2 //|< i 
,mac_a2accu_data3 //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,mac_a2accu_mask //|< i
  ,mac_a2accu_mode //|< i
  ,mac_a2accu_pvld //|< i
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,mac_b2accu_data${i} //|< i )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,mac_b2accu_data0 //|< i 
,mac_b2accu_data1 //|< i 
,mac_b2accu_data2 //|< i 
,mac_b2accu_data3 //|< i 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,mac_b2accu_mask //|< i
  ,mac_b2accu_mode //|< i
  ,mac_b2accu_pvld //|< i
  ,nvdla_cell_clk //|< i
  ,abuf_wr_addr //|> o
  ,abuf_wr_data //|> o
  ,abuf_wr_en //|> o
  ,dlv_data //|> o
  ,dlv_mask //|> o
  ,dlv_pd //|> o
  ,dlv_valid //|> o
  ,dp2reg_sat_count //|> o
  );
input nvdla_cell_clk;
input nvdla_core_clk;
input nvdla_core_rstn;
input [34*8 -1:0] abuf_rd_data;
input [12:0] accu_ctrl_pd;
input accu_ctrl_ram_valid;
input accu_ctrl_valid;
input cfg_in_en_mask;
input cfg_is_wg;
input [4:0] cfg_truncate;
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: input [19 -1:0] mac_a2accu_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [19 -1:0] mac_a2accu_data0; 
input [19 -1:0] mac_a2accu_data1; 
input [19 -1:0] mac_a2accu_data2; 
input [19 -1:0] mac_a2accu_data3; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8/2-1:0] mac_a2accu_mask;
input mac_a2accu_mode;
input mac_a2accu_pvld;
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: input [19 -1:0] mac_b2accu_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [19 -1:0] mac_b2accu_data0; 
input [19 -1:0] mac_b2accu_data1; 
input [19 -1:0] mac_b2accu_data2; 
input [19 -1:0] mac_b2accu_data3; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8/2-1:0] mac_b2accu_mask;
input mac_b2accu_mode;
input mac_b2accu_pvld;
output [3 +1 -1:0] abuf_wr_addr;
output [34*8 -1:0] abuf_wr_data;
output abuf_wr_en;
output [32*8 -1:0] dlv_data;
output dlv_mask;
output [1:0] dlv_pd;
output dlv_valid;
output [31:0] dp2reg_sat_count;
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.1.6
// unpack abuffer read data
//: my $kk=34;
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: wire [${kk}-1:0] abuf_in_data_${i} = abuf_rd_data[($i+1)*${kk}-1:$i*${kk}]; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [34-1:0] abuf_in_data_0 = abuf_rd_data[(0+1)*34-1:0*34]; 
wire [34-1:0] abuf_in_data_1 = abuf_rd_data[(1+1)*34-1:1*34]; 
wire [34-1:0] abuf_in_data_2 = abuf_rd_data[(2+1)*34-1:2*34]; 
wire [34-1:0] abuf_in_data_3 = abuf_rd_data[(3+1)*34-1:3*34]; 
wire [34-1:0] abuf_in_data_4 = abuf_rd_data[(4+1)*34-1:4*34]; 
wire [34-1:0] abuf_in_data_5 = abuf_rd_data[(5+1)*34-1:5*34]; 
wire [34-1:0] abuf_in_data_6 = abuf_rd_data[(6+1)*34-1:6*34]; 
wire [34-1:0] abuf_in_data_7 = abuf_rd_data[(7+1)*34-1:7*34]; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//1T delay, the same T with data/mask
//: &eperl::flop("-wid 13 -q accu_ctrl_pd_d1 -en accu_ctrl_valid -d accu_ctrl_pd");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [12:0] accu_ctrl_pd_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ctrl_pd_d1 <= 'b0;
   end else begin
       if ((accu_ctrl_valid) == 1'b1) begin
           accu_ctrl_pd_d1 <= accu_ctrl_pd;
       // VCS coverage off
       end else if ((accu_ctrl_valid) == 1'b0) begin
       end else begin
           accu_ctrl_pd_d1 <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire calc_valid_in = (mac_b2accu_pvld | mac_a2accu_pvld);
// spyglass disable_block STARC05-3.3.1.4b
//: &eperl::retime("-stage 3 -o calc_valid -i calc_valid_in");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  calc_valid_in_d1;
always @(posedge nvdla_core_clk) begin
        calc_valid_in_d1 <= calc_valid_in;
end

reg  calc_valid_in_d2;
always @(posedge nvdla_core_clk) begin
        calc_valid_in_d2 <= calc_valid_in_d1;
end

reg  calc_valid_in_d3;
always @(posedge nvdla_core_clk) begin
        calc_valid_in_d3 <= calc_valid_in_d2;
end

wire  calc_valid;
assign calc_valid = calc_valid_in_d3;


//| eperl: generated_end (DO NOT EDIT ABOVE)
// spyglass enable_block STARC05-3.3.1.4b
// unpack pd form abuffer control
wire [5:0] calc_addr = accu_ctrl_pd_d1[5:0];
wire [2:0] calc_mode = accu_ctrl_pd_d1[8:6];
wire calc_stripe_end = accu_ctrl_pd_d1[9];
wire calc_channel_end = accu_ctrl_pd_d1[10];
wire calc_layer_end = accu_ctrl_pd_d1[11];
wire calc_dlv_elem_mask = accu_ctrl_pd_d1[12];
//: my $kk=19;
//: for(my $i = 0; $i < 8/2; $i ++) {
//: print "wire [${kk}-1:0] calc_elem_${i} = mac_a2accu_data${i}; \n";
//: }
//: for(my $i = 8/2; $i < 8; $i ++) {
//: my $j = $i - 8/2;
//: print "wire [${kk}-1:0] calc_elem_${i} = mac_b2accu_data${j}; \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [19-1:0] calc_elem_0 = mac_a2accu_data0; 
wire [19-1:0] calc_elem_1 = mac_a2accu_data1; 
wire [19-1:0] calc_elem_2 = mac_a2accu_data2; 
wire [19-1:0] calc_elem_3 = mac_a2accu_data3; 
wire [19-1:0] calc_elem_4 = mac_b2accu_data0; 
wire [19-1:0] calc_elem_5 = mac_b2accu_data1; 
wire [19-1:0] calc_elem_6 = mac_b2accu_data2; 
wire [19-1:0] calc_elem_7 = mac_b2accu_data3; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8 -1:0] calc_in_mask = {mac_b2accu_mask, mac_a2accu_mask};
wire [8 -1:0] calc_op_en = calc_in_mask & {8{cfg_in_en_mask}};
wire [8 -1:0] calc_op1_vld = calc_in_mask & {8{cfg_in_en_mask & accu_ctrl_ram_valid}};
wire calc_dlv_valid = calc_valid & calc_channel_end;
wire calc_wr_en = calc_valid & (~calc_channel_end);
//: my $hh= 22-19;
//: my $pp= 34;
//: my $bb= 19;
//: for(my $i = 0; $i <8; $i ++) {
//: if($hh == 0) {
//: print qq(
//: wire [21:0]calc_op0_${i} = {calc_elem_${i}};
//: wire [${pp}-1:0] calc_op1_${i} = abuf_in_data_${i};
//: );
//: }
//: elsif($hh > 0) {
//: print qq(
//: wire [21:0]calc_op0_${i} = {{${hh}{calc_elem_${i}[${bb}-1]}},calc_elem_${i}};
//: wire [${pp}-1:0] calc_op1_${i} = abuf_in_data_${i};
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [21:0]calc_op0_0 = {{3{calc_elem_0[19-1]}},calc_elem_0};
wire [34-1:0] calc_op1_0 = abuf_in_data_0;

wire [21:0]calc_op0_1 = {{3{calc_elem_1[19-1]}},calc_elem_1};
wire [34-1:0] calc_op1_1 = abuf_in_data_1;

wire [21:0]calc_op0_2 = {{3{calc_elem_2[19-1]}},calc_elem_2};
wire [34-1:0] calc_op1_2 = abuf_in_data_2;

wire [21:0]calc_op0_3 = {{3{calc_elem_3[19-1]}},calc_elem_3};
wire [34-1:0] calc_op1_3 = abuf_in_data_3;

wire [21:0]calc_op0_4 = {{3{calc_elem_4[19-1]}},calc_elem_4};
wire [34-1:0] calc_op1_4 = abuf_in_data_4;

wire [21:0]calc_op0_5 = {{3{calc_elem_5[19-1]}},calc_elem_5};
wire [34-1:0] calc_op1_5 = abuf_in_data_5;

wire [21:0]calc_op0_6 = {{3{calc_elem_6[19-1]}},calc_elem_6};
wire [34-1:0] calc_op1_6 = abuf_in_data_6;

wire [21:0]calc_op0_7 = {{3{calc_elem_7[19-1]}},calc_elem_7};
wire [34-1:0] calc_op1_7 = abuf_in_data_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
// instance int8 adders
wire [8 -1:0] calc_fout_sat;
wire [8 -1:0] calc_pout_vld;
wire [8 -1:0] calc_fout_vld;
//: for(my $i = 0; $i <8; $i ++) {
//: print qq(
//: wire [34 -1:0] calc_pout_${i}_sum;
//: wire [32 -1:0] calc_fout_${i}_sum;
//: )
//: }
//: for(my $i = 0; $i <8; $i ++) {
//: print qq(
//: NV_NVDLA_CACC_CALC_int8 u_cell_int8_${i} (
//: .cfg_truncate (cfg_truncate) //|< w
//: ,.in_data (calc_op0_${i}) //|< r
//: ,.in_op (calc_op1_${i}) //|< r
//: ,.in_op_valid (calc_op1_vld[${i}]) //|< r
//: ,.in_sel (calc_dlv_valid) //|< r
//: ,.in_valid (calc_op_en[${i}]) //|< r
//: ,.out_final_data (calc_fout_${i}_sum) //|> w
//: ,.out_final_sat (calc_fout_sat[${i}]) //|> w
//: ,.out_final_valid (calc_fout_vld[${i}]) //|> w
//: ,.out_partial_data (calc_pout_${i}_sum) //|> w
//: ,.out_partial_valid (calc_pout_vld[${i}]) //|> w
//: ,.nvdla_core_clk (nvdla_cell_clk) //|< i
//: ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//: );
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [34 -1:0] calc_pout_0_sum;
wire [32 -1:0] calc_fout_0_sum;

wire [34 -1:0] calc_pout_1_sum;
wire [32 -1:0] calc_fout_1_sum;

wire [34 -1:0] calc_pout_2_sum;
wire [32 -1:0] calc_fout_2_sum;

wire [34 -1:0] calc_pout_3_sum;
wire [32 -1:0] calc_fout_3_sum;

wire [34 -1:0] calc_pout_4_sum;
wire [32 -1:0] calc_fout_4_sum;

wire [34 -1:0] calc_pout_5_sum;
wire [32 -1:0] calc_fout_5_sum;

wire [34 -1:0] calc_pout_6_sum;
wire [32 -1:0] calc_fout_6_sum;

wire [34 -1:0] calc_pout_7_sum;
wire [32 -1:0] calc_fout_7_sum;

NV_NVDLA_CACC_CALC_int8 u_cell_int8_0 (
.cfg_truncate (cfg_truncate) //|< w
,.in_data (calc_op0_0) //|< r
,.in_op (calc_op1_0) //|< r
,.in_op_valid (calc_op1_vld[0]) //|< r
,.in_sel (calc_dlv_valid) //|< r
,.in_valid (calc_op_en[0]) //|< r
,.out_final_data (calc_fout_0_sum) //|> w
,.out_final_sat (calc_fout_sat[0]) //|> w
,.out_final_valid (calc_fout_vld[0]) //|> w
,.out_partial_data (calc_pout_0_sum) //|> w
,.out_partial_valid (calc_pout_vld[0]) //|> w
,.nvdla_core_clk (nvdla_cell_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
);

NV_NVDLA_CACC_CALC_int8 u_cell_int8_1 (
.cfg_truncate (cfg_truncate) //|< w
,.in_data (calc_op0_1) //|< r
,.in_op (calc_op1_1) //|< r
,.in_op_valid (calc_op1_vld[1]) //|< r
,.in_sel (calc_dlv_valid) //|< r
,.in_valid (calc_op_en[1]) //|< r
,.out_final_data (calc_fout_1_sum) //|> w
,.out_final_sat (calc_fout_sat[1]) //|> w
,.out_final_valid (calc_fout_vld[1]) //|> w
,.out_partial_data (calc_pout_1_sum) //|> w
,.out_partial_valid (calc_pout_vld[1]) //|> w
,.nvdla_core_clk (nvdla_cell_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
);

NV_NVDLA_CACC_CALC_int8 u_cell_int8_2 (
.cfg_truncate (cfg_truncate) //|< w
,.in_data (calc_op0_2) //|< r
,.in_op (calc_op1_2) //|< r
,.in_op_valid (calc_op1_vld[2]) //|< r
,.in_sel (calc_dlv_valid) //|< r
,.in_valid (calc_op_en[2]) //|< r
,.out_final_data (calc_fout_2_sum) //|> w
,.out_final_sat (calc_fout_sat[2]) //|> w
,.out_final_valid (calc_fout_vld[2]) //|> w
,.out_partial_data (calc_pout_2_sum) //|> w
,.out_partial_valid (calc_pout_vld[2]) //|> w
,.nvdla_core_clk (nvdla_cell_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
);

NV_NVDLA_CACC_CALC_int8 u_cell_int8_3 (
.cfg_truncate (cfg_truncate) //|< w
,.in_data (calc_op0_3) //|< r
,.in_op (calc_op1_3) //|< r
,.in_op_valid (calc_op1_vld[3]) //|< r
,.in_sel (calc_dlv_valid) //|< r
,.in_valid (calc_op_en[3]) //|< r
,.out_final_data (calc_fout_3_sum) //|> w
,.out_final_sat (calc_fout_sat[3]) //|> w
,.out_final_valid (calc_fout_vld[3]) //|> w
,.out_partial_data (calc_pout_3_sum) //|> w
,.out_partial_valid (calc_pout_vld[3]) //|> w
,.nvdla_core_clk (nvdla_cell_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
);

NV_NVDLA_CACC_CALC_int8 u_cell_int8_4 (
.cfg_truncate (cfg_truncate) //|< w
,.in_data (calc_op0_4) //|< r
,.in_op (calc_op1_4) //|< r
,.in_op_valid (calc_op1_vld[4]) //|< r
,.in_sel (calc_dlv_valid) //|< r
,.in_valid (calc_op_en[4]) //|< r
,.out_final_data (calc_fout_4_sum) //|> w
,.out_final_sat (calc_fout_sat[4]) //|> w
,.out_final_valid (calc_fout_vld[4]) //|> w
,.out_partial_data (calc_pout_4_sum) //|> w
,.out_partial_valid (calc_pout_vld[4]) //|> w
,.nvdla_core_clk (nvdla_cell_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
);

NV_NVDLA_CACC_CALC_int8 u_cell_int8_5 (
.cfg_truncate (cfg_truncate) //|< w
,.in_data (calc_op0_5) //|< r
,.in_op (calc_op1_5) //|< r
,.in_op_valid (calc_op1_vld[5]) //|< r
,.in_sel (calc_dlv_valid) //|< r
,.in_valid (calc_op_en[5]) //|< r
,.out_final_data (calc_fout_5_sum) //|> w
,.out_final_sat (calc_fout_sat[5]) //|> w
,.out_final_valid (calc_fout_vld[5]) //|> w
,.out_partial_data (calc_pout_5_sum) //|> w
,.out_partial_valid (calc_pout_vld[5]) //|> w
,.nvdla_core_clk (nvdla_cell_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
);

NV_NVDLA_CACC_CALC_int8 u_cell_int8_6 (
.cfg_truncate (cfg_truncate) //|< w
,.in_data (calc_op0_6) //|< r
,.in_op (calc_op1_6) //|< r
,.in_op_valid (calc_op1_vld[6]) //|< r
,.in_sel (calc_dlv_valid) //|< r
,.in_valid (calc_op_en[6]) //|< r
,.out_final_data (calc_fout_6_sum) //|> w
,.out_final_sat (calc_fout_sat[6]) //|> w
,.out_final_valid (calc_fout_vld[6]) //|> w
,.out_partial_data (calc_pout_6_sum) //|> w
,.out_partial_valid (calc_pout_vld[6]) //|> w
,.nvdla_core_clk (nvdla_cell_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
);

NV_NVDLA_CACC_CALC_int8 u_cell_int8_7 (
.cfg_truncate (cfg_truncate) //|< w
,.in_data (calc_op0_7) //|< r
,.in_op (calc_op1_7) //|< r
,.in_op_valid (calc_op1_vld[7]) //|< r
,.in_sel (calc_dlv_valid) //|< r
,.in_valid (calc_op_en[7]) //|< r
,.out_final_data (calc_fout_7_sum) //|> w
,.out_final_sat (calc_fout_sat[7]) //|> w
,.out_final_valid (calc_fout_vld[7]) //|> w
,.out_partial_data (calc_pout_7_sum) //|> w
,.out_partial_valid (calc_pout_vld[7]) //|> w
,.nvdla_core_clk (nvdla_cell_clk) //|< i
,.nvdla_core_rstn (nvdla_core_rstn) //|< i
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire calc_valid_d0 = calc_valid;
wire calc_wr_en_d0 = calc_wr_en;
wire [5:0] calc_addr_d0 = calc_addr;
wire calc_dlv_valid_d0 = calc_dlv_valid;
wire calc_stripe_end_d0 = calc_stripe_end;
wire calc_layer_end_d0 = calc_layer_end;
// Latency pipeline to balance with calc cells, signal for both abuffer & dbuffer
//: my $start = 0;
//: for(my $i = $start; $i < $start + 2; $i ++) {
//: my $j = $i + 1;
//: &eperl::flop(" -q  calc_valid_d${j}  -d \"calc_valid_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  calc_wr_en_d${j}  -d  \"calc_wr_en_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop("-wid 6 -q  calc_addr_d${j}  -en \"calc_valid_d${i}\" -d  \"calc_addr_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: }
//: my $pin = $start + 2;
//: print qq(
//: wire calc_valid_out = calc_valid_d${pin};
//: wire calc_wr_en_out = calc_wr_en_d${pin};
//: wire [5:0] calc_addr_out = calc_addr_d${pin};
//: );
//:
//: for(my $i = $start; $i < $start + 2; $i ++) {
//: my $j = $i + 1;
//: &eperl::flop(" -q  calc_dlv_valid_d${j}  -d \"calc_dlv_valid_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  calc_stripe_end_d${j}  -en \"calc_dlv_valid_d${i}\" -d  \"calc_stripe_end_d${i}\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  calc_layer_end_d${j}  -en \"calc_dlv_valid_d${i}\" -d  \"calc_layer_end_d${i} \" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: }
//: my $fin = $start + 2;
//: print qq(
//: wire calc_dlv_valid_out = calc_dlv_valid_d${fin};
//: wire calc_stripe_end_out = calc_stripe_end_d${fin};
//: wire calc_layer_end_out = calc_layer_end_d${fin};
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  calc_valid_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_valid_d1 <= 'b0;
   end else begin
       calc_valid_d1 <= calc_valid_d0;
   end
end
reg  calc_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_wr_en_d1 <= 'b0;
   end else begin
       calc_wr_en_d1 <= calc_wr_en_d0;
   end
end
reg [5:0] calc_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_addr_d1 <= 'b0;
   end else begin
       if ((calc_valid_d0) == 1'b1) begin
           calc_addr_d1 <= calc_addr_d0;
       // VCS coverage off
       end else if ((calc_valid_d0) == 1'b0) begin
       end else begin
           calc_addr_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  calc_valid_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_valid_d2 <= 'b0;
   end else begin
       calc_valid_d2 <= calc_valid_d1;
   end
end
reg  calc_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_wr_en_d2 <= 'b0;
   end else begin
       calc_wr_en_d2 <= calc_wr_en_d1;
   end
end
reg [5:0] calc_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_addr_d2 <= 'b0;
   end else begin
       if ((calc_valid_d1) == 1'b1) begin
           calc_addr_d2 <= calc_addr_d1;
       // VCS coverage off
       end else if ((calc_valid_d1) == 1'b0) begin
       end else begin
           calc_addr_d2 <= 'bx;
       // VCS coverage on
       end
   end
end

wire calc_valid_out = calc_valid_d2;
wire calc_wr_en_out = calc_wr_en_d2;
wire [5:0] calc_addr_out = calc_addr_d2;
reg  calc_dlv_valid_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_dlv_valid_d1 <= 'b0;
   end else begin
       calc_dlv_valid_d1 <= calc_dlv_valid_d0;
   end
end
reg  calc_stripe_end_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_stripe_end_d1 <= 'b0;
   end else begin
       if ((calc_dlv_valid_d0) == 1'b1) begin
           calc_stripe_end_d1 <= calc_stripe_end_d0;
       // VCS coverage off
       end else if ((calc_dlv_valid_d0) == 1'b0) begin
       end else begin
           calc_stripe_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  calc_layer_end_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_layer_end_d1 <= 'b0;
   end else begin
       if ((calc_dlv_valid_d0) == 1'b1) begin
           calc_layer_end_d1 <= calc_layer_end_d0 ;
       // VCS coverage off
       end else if ((calc_dlv_valid_d0) == 1'b0) begin
       end else begin
           calc_layer_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  calc_dlv_valid_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_dlv_valid_d2 <= 'b0;
   end else begin
       calc_dlv_valid_d2 <= calc_dlv_valid_d1;
   end
end
reg  calc_stripe_end_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_stripe_end_d2 <= 'b0;
   end else begin
       if ((calc_dlv_valid_d1) == 1'b1) begin
           calc_stripe_end_d2 <= calc_stripe_end_d1;
       // VCS coverage off
       end else if ((calc_dlv_valid_d1) == 1'b0) begin
       end else begin
           calc_stripe_end_d2 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  calc_layer_end_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       calc_layer_end_d2 <= 'b0;
   end else begin
       if ((calc_dlv_valid_d1) == 1'b1) begin
           calc_layer_end_d2 <= calc_layer_end_d1 ;
       // VCS coverage off
       end else if ((calc_dlv_valid_d1) == 1'b0) begin
       end else begin
           calc_layer_end_d2 <= 'bx;
       // VCS coverage on
       end
   end
end

wire calc_dlv_valid_out = calc_dlv_valid_d2;
wire calc_stripe_end_out = calc_stripe_end_d2;
wire calc_layer_end_out = calc_layer_end_d2;

//| eperl: generated_end (DO NOT EDIT ABOVE)
// Gather of accumulator result
//: my $int8_out = 34;
//: my $final_out = 32;
//: for(my $i=0; $i <8; $i ++) {
//: print qq(
//: wire [${int8_out}-1:0] calc_pout_${i} = ({${int8_out}{calc_pout_vld[${i}]}} & calc_pout_${i}_sum););
//: }
//: for(my $i = 0; $i <8; $i ++) {
//: print qq(
//: wire [${final_out}-1:0] calc_fout_${i} = ({${final_out}{calc_fout_vld[${i}]}} & calc_fout_${i}_sum););
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [34-1:0] calc_pout_0 = ({34{calc_pout_vld[0]}} & calc_pout_0_sum);
wire [34-1:0] calc_pout_1 = ({34{calc_pout_vld[1]}} & calc_pout_1_sum);
wire [34-1:0] calc_pout_2 = ({34{calc_pout_vld[2]}} & calc_pout_2_sum);
wire [34-1:0] calc_pout_3 = ({34{calc_pout_vld[3]}} & calc_pout_3_sum);
wire [34-1:0] calc_pout_4 = ({34{calc_pout_vld[4]}} & calc_pout_4_sum);
wire [34-1:0] calc_pout_5 = ({34{calc_pout_vld[5]}} & calc_pout_5_sum);
wire [34-1:0] calc_pout_6 = ({34{calc_pout_vld[6]}} & calc_pout_6_sum);
wire [34-1:0] calc_pout_7 = ({34{calc_pout_vld[7]}} & calc_pout_7_sum);
wire [32-1:0] calc_fout_0 = ({32{calc_fout_vld[0]}} & calc_fout_0_sum);
wire [32-1:0] calc_fout_1 = ({32{calc_fout_vld[1]}} & calc_fout_1_sum);
wire [32-1:0] calc_fout_2 = ({32{calc_fout_vld[2]}} & calc_fout_2_sum);
wire [32-1:0] calc_fout_3 = ({32{calc_fout_vld[3]}} & calc_fout_3_sum);
wire [32-1:0] calc_fout_4 = ({32{calc_fout_vld[4]}} & calc_fout_4_sum);
wire [32-1:0] calc_fout_5 = ({32{calc_fout_vld[5]}} & calc_fout_5_sum);
wire [32-1:0] calc_fout_6 = ({32{calc_fout_vld[6]}} & calc_fout_6_sum);
wire [32-1:0] calc_fout_7 = ({32{calc_fout_vld[7]}} & calc_fout_7_sum);
//| eperl: generated_end (DO NOT EDIT ABOVE)
// to abuffer, 1 pipe
wire [34*8 -1:0] abuf_wr_data_w;
// spyglass disable_block STARC05-3.3.1.4b
//: my $kk=34*8;
//: my $jj=3 +1;
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq (
//: assign abuf_wr_data_w[34*($i+1)-1:34*$i] = calc_pout_${i}; );
//: }
//: &eperl::flop(" -q  abuf_wr_en  -d \"calc_wr_en_out\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop("-wid ${jj} -q  abuf_wr_addr  -en \"calc_wr_en_out\" -d  \"calc_addr_out[${jj}-1:0]\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop("-wid ${kk} -q  abuf_wr_data  -en \"calc_wr_en_out\" -d  \"abuf_wr_data_w\" -clk nvdla_core_clk -norst");
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign abuf_wr_data_w[34*(0+1)-1:34*0] = calc_pout_0; 
assign abuf_wr_data_w[34*(1+1)-1:34*1] = calc_pout_1; 
assign abuf_wr_data_w[34*(2+1)-1:34*2] = calc_pout_2; 
assign abuf_wr_data_w[34*(3+1)-1:34*3] = calc_pout_3; 
assign abuf_wr_data_w[34*(4+1)-1:34*4] = calc_pout_4; 
assign abuf_wr_data_w[34*(5+1)-1:34*5] = calc_pout_5; 
assign abuf_wr_data_w[34*(6+1)-1:34*6] = calc_pout_6; 
assign abuf_wr_data_w[34*(7+1)-1:34*7] = calc_pout_7; reg  abuf_wr_en;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       abuf_wr_en <= 'b0;
   end else begin
       abuf_wr_en <= calc_wr_en_out;
   end
end
reg [3:0] abuf_wr_addr;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       abuf_wr_addr <= 'b0;
   end else begin
       if ((calc_wr_en_out) == 1'b1) begin
           abuf_wr_addr <= calc_addr_out[4-1:0];
       // VCS coverage off
       end else if ((calc_wr_en_out) == 1'b0) begin
       end else begin
           abuf_wr_addr <= 'bx;
       // VCS coverage on
       end
   end
end
reg [271:0] abuf_wr_data;
always @(posedge nvdla_core_clk) begin
       if ((calc_wr_en_out) == 1'b1) begin
           abuf_wr_data <= abuf_wr_data_w;
       // VCS coverage off
       end else if ((calc_wr_en_out) == 1'b0) begin
       end else begin
           abuf_wr_data <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// spyglass enable_block STARC05-3.3.1.4b
// to dbuffer, 1 pipe.
wire [32*8 -1:0] dlv_data_w;
// spyglass disable_block STARC05-3.3.1.4b
//: my $kk=32*8;
//: for(my $i = 0; $i < 8; $i ++) {
//: print qq(
//: assign dlv_data_w[32*($i+1)-1:32*$i] = calc_fout_${i};);
//: }
//:
//: &eperl::flop("-wid ${kk} -q  dlv_data  -en \"calc_dlv_valid_out\" -d  \"dlv_data_w\" -clk nvdla_core_clk -norst");
//: &eperl::flop(" -q  dlv_valid  -d \"calc_dlv_valid_out\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  dlv_mask   -d  \"calc_dlv_valid_out\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  dlv_stripe_end  -en \"calc_dlv_valid_out\" -d  \"calc_stripe_end_out\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  dlv_layer_end  -en \"calc_dlv_valid_out\" -d  \"calc_layer_end_out\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dlv_data_w[32*(0+1)-1:32*0] = calc_fout_0;
assign dlv_data_w[32*(1+1)-1:32*1] = calc_fout_1;
assign dlv_data_w[32*(2+1)-1:32*2] = calc_fout_2;
assign dlv_data_w[32*(3+1)-1:32*3] = calc_fout_3;
assign dlv_data_w[32*(4+1)-1:32*4] = calc_fout_4;
assign dlv_data_w[32*(5+1)-1:32*5] = calc_fout_5;
assign dlv_data_w[32*(6+1)-1:32*6] = calc_fout_6;
assign dlv_data_w[32*(7+1)-1:32*7] = calc_fout_7;reg [255:0] dlv_data;
always @(posedge nvdla_core_clk) begin
       if ((calc_dlv_valid_out) == 1'b1) begin
           dlv_data <= dlv_data_w;
       // VCS coverage off
       end else if ((calc_dlv_valid_out) == 1'b0) begin
       end else begin
           dlv_data <= 'bx;
       // VCS coverage on
       end
end
reg  dlv_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dlv_valid <= 'b0;
   end else begin
       dlv_valid <= calc_dlv_valid_out;
   end
end
reg  dlv_mask;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dlv_mask <= 'b0;
   end else begin
       dlv_mask <= calc_dlv_valid_out;
   end
end
reg  dlv_stripe_end;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dlv_stripe_end <= 'b0;
   end else begin
       if ((calc_dlv_valid_out) == 1'b1) begin
           dlv_stripe_end <= calc_stripe_end_out;
       // VCS coverage off
       end else if ((calc_dlv_valid_out) == 1'b0) begin
       end else begin
           dlv_stripe_end <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dlv_layer_end;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dlv_layer_end <= 'b0;
   end else begin
       if ((calc_dlv_valid_out) == 1'b1) begin
           dlv_layer_end <= calc_layer_end_out;
       // VCS coverage off
       end else if ((calc_dlv_valid_out) == 1'b0) begin
       end else begin
           dlv_layer_end <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// spyglass enable_block STARC05-3.3.1.4b
assign dlv_pd[0] = dlv_stripe_end ;
assign dlv_pd[1] = dlv_layer_end ;
// overflow count
reg dlv_sat_end_d1;
wire [8 -1:0] dlv_sat_bit = calc_fout_sat;
wire dlv_sat_end = calc_layer_end_out & calc_stripe_end_out;
wire dlv_sat_clr = calc_dlv_valid_out & ~dlv_sat_end & dlv_sat_end_d1;
//: my $kk= 8;
//: my $jj= 3;
//: &eperl::flop(" -q  dlv_sat_vld_d1  -d \"calc_dlv_valid_out\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop("-nodeclare  -q  dlv_sat_end_d1  -en \"calc_dlv_valid_out\" -d  \"dlv_sat_end\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 1");
//: &eperl::flop(" -wid ${kk} -q  dlv_sat_bit_d1  -en \"calc_dlv_valid_out\" -d  \"dlv_sat_bit\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  dlv_sat_clr_d1  -d \"dlv_sat_clr\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: print "wire [${jj}-1:0] sat_sum = ";
//: for(my $i=0; $i<8 -1 ; $i++){
//: print "dlv_sat_bit_d1[${i}]+";
//: }
//: my $i=8 -1;
//: print "dlv_sat_bit_d1[${i}]; \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  dlv_sat_vld_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dlv_sat_vld_d1 <= 'b0;
   end else begin
       dlv_sat_vld_d1 <= calc_dlv_valid_out;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dlv_sat_end_d1 <= 1;
   end else begin
       if ((calc_dlv_valid_out) == 1'b1) begin
           dlv_sat_end_d1 <= dlv_sat_end;
       // VCS coverage off
       end else if ((calc_dlv_valid_out) == 1'b0) begin
       end else begin
           dlv_sat_end_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg [7:0] dlv_sat_bit_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dlv_sat_bit_d1 <= 'b0;
   end else begin
       if ((calc_dlv_valid_out) == 1'b1) begin
           dlv_sat_bit_d1 <= dlv_sat_bit;
       // VCS coverage off
       end else if ((calc_dlv_valid_out) == 1'b0) begin
       end else begin
           dlv_sat_bit_d1 <= 'bx;
       // VCS coverage on
       end
   end
end
reg  dlv_sat_clr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dlv_sat_clr_d1 <= 'b0;
   end else begin
       dlv_sat_clr_d1 <= dlv_sat_clr;
   end
end
wire [3-1:0] sat_sum = dlv_sat_bit_d1[0]+dlv_sat_bit_d1[1]+dlv_sat_bit_d1[2]+dlv_sat_bit_d1[3]+dlv_sat_bit_d1[4]+dlv_sat_bit_d1[5]+dlv_sat_bit_d1[6]+dlv_sat_bit_d1[7]; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [31:0] sat_count_inc;
reg [31:0] sat_count;
wire sat_carry;
wire [31:0] sat_count_w;
wire sat_reg_en;
assign {sat_carry, sat_count_inc[31:0]} = sat_count + sat_sum;
assign sat_count_w = (dlv_sat_clr_d1) ? {24'b0, sat_sum} : sat_carry ? {32{1'b1}} : sat_count_inc;
assign sat_reg_en = dlv_sat_vld_d1 & ((|sat_sum) | dlv_sat_clr_d1);
//: &eperl::flop("-nodeclare -q  sat_count  -en \"sat_reg_en\" -d  \"sat_count_w\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sat_count <= 'b0;
   end else begin
       if ((sat_reg_en) == 1'b1) begin
           sat_count <= sat_count_w;
       // VCS coverage off
       end else if ((sat_reg_en) == 1'b0) begin
       end else begin
           sat_count <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.1.6
assign dp2reg_sat_count = sat_count;
endmodule
