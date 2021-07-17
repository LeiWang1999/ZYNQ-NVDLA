// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_cbuf.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CBUF.h
    `define CBUF_BANK_RAM_CASE1
    `define CBUF_SUPPORT_READ_JUMPING
//ram case could be 0/1/2/3/4/5  0:1ram/bank; 1:1*2ram/bank; 2:2*1ram/bank; 3:2*2ram/bank  4:4*1ram/bank  5:4*2ram/bank
`define CDMA2CBUF_DEBUG_PRINT //open debug print
`include "simulate_x_tick.vh"
module NV_NVDLA_cbuf (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
//port 0 for data, 1 for weight
//: for(my $i=0; $i<2 ; $i++){
//: print qq(
//: ,cdma2buf_wr_addr${i} //|< i
//: ,cdma2buf_wr_data${i} //|< i
//: ,cdma2buf_wr_en${i} //|< i
//: ,cdma2buf_wr_sel${i} //|< i
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,cdma2buf_wr_addr0 //|< i
,cdma2buf_wr_data0 //|< i
,cdma2buf_wr_en0 //|< i
,cdma2buf_wr_sel0 //|< i

,cdma2buf_wr_addr1 //|< i
,cdma2buf_wr_data1 //|< i
,cdma2buf_wr_en1 //|< i
,cdma2buf_wr_sel1 //|< i

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,pwrbus_ram_pd //|< i
  ,sc2buf_dat_rd_addr //|< i
  ,sc2buf_dat_rd_en //|< i
  ,sc2buf_dat_rd_shift //|< i
  ,sc2buf_dat_rd_next1_en //< i
  ,sc2buf_dat_rd_next1_addr //< i
  ,sc2buf_dat_rd_data //|> o
  ,sc2buf_dat_rd_valid //|> o
  ,sc2buf_wt_rd_addr //|< i
  ,sc2buf_wt_rd_en //|< i
  ,sc2buf_wt_rd_data //|> o
  ,sc2buf_wt_rd_valid //|> o
  `ifdef CBUF_WEIGHT_COMPRESSED
  ,sc2buf_wmb_rd_addr //|< i
  ,sc2buf_wmb_rd_en //|< i
  ,sc2buf_wmb_rd_data //|> o
  ,sc2buf_wmb_rd_valid //|> o
  `endif
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
//: for(my $i=0; $i<2 ; $i++) {
//: print qq(
//: input[14 -1:0] cdma2buf_wr_addr${i}; //|< i
//: input[64 -1:0] cdma2buf_wr_data${i}; //|< i
//: input cdma2buf_wr_en${i}; //|< i
//: input[1 -1:0] cdma2buf_wr_sel${i}; //|< i
//: )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input[14 -1:0] cdma2buf_wr_addr0; //|< i
input[64 -1:0] cdma2buf_wr_data0; //|< i
input cdma2buf_wr_en0; //|< i
input[1 -1:0] cdma2buf_wr_sel0; //|< i

input[14 -1:0] cdma2buf_wr_addr1; //|< i
input[64 -1:0] cdma2buf_wr_data1; //|< i
input cdma2buf_wr_en1; //|< i
input[1 -1:0] cdma2buf_wr_sel1; //|< i

//| eperl: generated_end (DO NOT EDIT ABOVE)
input sc2buf_dat_rd_en; /* data valid */
input [14 -1:0] sc2buf_dat_rd_addr;
input [7 -1:0] sc2buf_dat_rd_shift; //|< i
input sc2buf_dat_rd_next1_en; //< i
input [14 -1:0] sc2buf_dat_rd_next1_addr; //< i
output sc2buf_dat_rd_valid; /* data valid */
output [64 -1:0] sc2buf_dat_rd_data;
input sc2buf_wt_rd_en; /* data valid */
input [14 -1:0] sc2buf_wt_rd_addr;
output sc2buf_wt_rd_valid; /* data valid */
output [64 -1:0] sc2buf_wt_rd_data;
`ifdef CBUF_WEIGHT_COMPRESSED
input sc2buf_wmb_rd_en; /* data valid */
input [14 -1:0] sc2buf_wmb_rd_addr;
output sc2buf_wmb_rd_valid; /* data valid */
output [64 -1:0] sc2buf_wmb_rd_data;
`endif
`ifndef SYNTHESIS
`ifdef CDMA2CBUF_DEBUG_PRINT
`ifdef VERILATOR
`else
reg cdma2cbuf_data_begin, cdma2cbuf_wt_begin;
integer data_file, wt_file;
initial begin
    assign cdma2cbuf_wt_begin=0;
    assign cdma2cbuf_data_begin=0;
    @(negedge cdma2buf_wr_en1) assign cdma2cbuf_wt_begin=1;
    @(negedge cdma2buf_wr_en0) assign cdma2cbuf_data_begin=1;
    data_file = $fopen("cdma2cbuf_data_rtl.dat");
    wt_file = $fopen("cdma2cbuf_weight_rtl.dat");
    if(cdma2cbuf_data_begin & cdma2cbuf_wt_begin) begin
        forever @(posedge nvdla_core_clk) begin
            if(cdma2buf_wr_en0) begin
                $fwrite(data_file,"%h\n",cdma2buf_wr_data0);
            end
            if (cdma2buf_wr_en1) begin
                $fwrite(wt_file,"%h\n",cdma2buf_wr_data1);
            end
        end
    end
end
`endif
`endif
`endif
//////////step1:write handle
//decode write address to sram
//: my $bank_slice= "13:9"; #address part for select bank
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: my $kmod2 = $k%2;
//: my $kmod4 = $k%4;
//: for(my $i=0; $i<2 ; $i++){
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire bank${j}_ram${k}_wr${i}_en_d0 = cdma2buf_wr_en${i}&&(cdma2buf_wr_addr${i}[${bank_slice}]==${j}) &&(cdma2buf_wr_sel${i}[${k}]==1'b1); );
//: }
//: if(1==1){
//: print qq(
//: wire bank${j}_ram${k}_wr${i}_en_d0 = cdma2buf_wr_en${i}&&(cdma2buf_wr_addr${i}[${bank_slice}]==${j})&&(cdma2buf_wr_addr${i}[0]==${k}); );
//: }
//: if(1==3){
//: print qq(
//: wire bank${j}_ram${k}_wr${i}_en_d0 = cdma2buf_wr_en${i}&&(cdma2buf_wr_addr${i}[${bank_slice}]==${j})&&(cdma2buf_wr_addr${i}[0]==${k})&&(cdma2buf_wr_sel${i}[${kmod2}]==1'b1 ); );
//: }
//: if(1==5){
//: print qq(
//: wire bank${j}_ram${k}_wr${i}_en_d0 = cdma2buf_wr_en${i}&&(cdma2buf_wr_addr${i}[${bank_slice}]==${j})&&(cdma2buf_wr_addr${i}[0]==${k})&&(cdma2buf_wr_sel${i}[${kmod4}]==1'b1 ); );
//: }
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire bank0_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==0)&&(cdma2buf_wr_addr0[0]==0); 
wire bank0_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==0)&&(cdma2buf_wr_addr1[0]==0); 
wire bank0_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==0)&&(cdma2buf_wr_addr0[0]==1); 
wire bank0_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==0)&&(cdma2buf_wr_addr1[0]==1); 
wire bank1_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==1)&&(cdma2buf_wr_addr0[0]==0); 
wire bank1_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==1)&&(cdma2buf_wr_addr1[0]==0); 
wire bank1_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==1)&&(cdma2buf_wr_addr0[0]==1); 
wire bank1_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==1)&&(cdma2buf_wr_addr1[0]==1); 
wire bank2_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==2)&&(cdma2buf_wr_addr0[0]==0); 
wire bank2_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==2)&&(cdma2buf_wr_addr1[0]==0); 
wire bank2_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==2)&&(cdma2buf_wr_addr0[0]==1); 
wire bank2_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==2)&&(cdma2buf_wr_addr1[0]==1); 
wire bank3_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==3)&&(cdma2buf_wr_addr0[0]==0); 
wire bank3_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==3)&&(cdma2buf_wr_addr1[0]==0); 
wire bank3_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==3)&&(cdma2buf_wr_addr0[0]==1); 
wire bank3_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==3)&&(cdma2buf_wr_addr1[0]==1); 
wire bank4_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==4)&&(cdma2buf_wr_addr0[0]==0); 
wire bank4_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==4)&&(cdma2buf_wr_addr1[0]==0); 
wire bank4_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==4)&&(cdma2buf_wr_addr0[0]==1); 
wire bank4_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==4)&&(cdma2buf_wr_addr1[0]==1); 
wire bank5_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==5)&&(cdma2buf_wr_addr0[0]==0); 
wire bank5_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==5)&&(cdma2buf_wr_addr1[0]==0); 
wire bank5_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==5)&&(cdma2buf_wr_addr0[0]==1); 
wire bank5_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==5)&&(cdma2buf_wr_addr1[0]==1); 
wire bank6_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==6)&&(cdma2buf_wr_addr0[0]==0); 
wire bank6_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==6)&&(cdma2buf_wr_addr1[0]==0); 
wire bank6_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==6)&&(cdma2buf_wr_addr0[0]==1); 
wire bank6_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==6)&&(cdma2buf_wr_addr1[0]==1); 
wire bank7_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==7)&&(cdma2buf_wr_addr0[0]==0); 
wire bank7_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==7)&&(cdma2buf_wr_addr1[0]==0); 
wire bank7_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==7)&&(cdma2buf_wr_addr0[0]==1); 
wire bank7_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==7)&&(cdma2buf_wr_addr1[0]==1); 
wire bank8_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==8)&&(cdma2buf_wr_addr0[0]==0); 
wire bank8_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==8)&&(cdma2buf_wr_addr1[0]==0); 
wire bank8_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==8)&&(cdma2buf_wr_addr0[0]==1); 
wire bank8_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==8)&&(cdma2buf_wr_addr1[0]==1); 
wire bank9_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==9)&&(cdma2buf_wr_addr0[0]==0); 
wire bank9_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==9)&&(cdma2buf_wr_addr1[0]==0); 
wire bank9_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==9)&&(cdma2buf_wr_addr0[0]==1); 
wire bank9_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==9)&&(cdma2buf_wr_addr1[0]==1); 
wire bank10_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==10)&&(cdma2buf_wr_addr0[0]==0); 
wire bank10_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==10)&&(cdma2buf_wr_addr1[0]==0); 
wire bank10_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==10)&&(cdma2buf_wr_addr0[0]==1); 
wire bank10_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==10)&&(cdma2buf_wr_addr1[0]==1); 
wire bank11_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==11)&&(cdma2buf_wr_addr0[0]==0); 
wire bank11_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==11)&&(cdma2buf_wr_addr1[0]==0); 
wire bank11_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==11)&&(cdma2buf_wr_addr0[0]==1); 
wire bank11_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==11)&&(cdma2buf_wr_addr1[0]==1); 
wire bank12_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==12)&&(cdma2buf_wr_addr0[0]==0); 
wire bank12_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==12)&&(cdma2buf_wr_addr1[0]==0); 
wire bank12_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==12)&&(cdma2buf_wr_addr0[0]==1); 
wire bank12_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==12)&&(cdma2buf_wr_addr1[0]==1); 
wire bank13_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==13)&&(cdma2buf_wr_addr0[0]==0); 
wire bank13_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==13)&&(cdma2buf_wr_addr1[0]==0); 
wire bank13_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==13)&&(cdma2buf_wr_addr0[0]==1); 
wire bank13_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==13)&&(cdma2buf_wr_addr1[0]==1); 
wire bank14_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==14)&&(cdma2buf_wr_addr0[0]==0); 
wire bank14_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==14)&&(cdma2buf_wr_addr1[0]==0); 
wire bank14_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==14)&&(cdma2buf_wr_addr0[0]==1); 
wire bank14_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==14)&&(cdma2buf_wr_addr1[0]==1); 
wire bank15_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==15)&&(cdma2buf_wr_addr0[0]==0); 
wire bank15_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==15)&&(cdma2buf_wr_addr1[0]==0); 
wire bank15_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==15)&&(cdma2buf_wr_addr0[0]==1); 
wire bank15_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==15)&&(cdma2buf_wr_addr1[0]==1); 
wire bank16_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==16)&&(cdma2buf_wr_addr0[0]==0); 
wire bank16_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==16)&&(cdma2buf_wr_addr1[0]==0); 
wire bank16_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==16)&&(cdma2buf_wr_addr0[0]==1); 
wire bank16_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==16)&&(cdma2buf_wr_addr1[0]==1); 
wire bank17_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==17)&&(cdma2buf_wr_addr0[0]==0); 
wire bank17_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==17)&&(cdma2buf_wr_addr1[0]==0); 
wire bank17_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==17)&&(cdma2buf_wr_addr0[0]==1); 
wire bank17_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==17)&&(cdma2buf_wr_addr1[0]==1); 
wire bank18_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==18)&&(cdma2buf_wr_addr0[0]==0); 
wire bank18_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==18)&&(cdma2buf_wr_addr1[0]==0); 
wire bank18_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==18)&&(cdma2buf_wr_addr0[0]==1); 
wire bank18_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==18)&&(cdma2buf_wr_addr1[0]==1); 
wire bank19_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==19)&&(cdma2buf_wr_addr0[0]==0); 
wire bank19_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==19)&&(cdma2buf_wr_addr1[0]==0); 
wire bank19_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==19)&&(cdma2buf_wr_addr0[0]==1); 
wire bank19_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==19)&&(cdma2buf_wr_addr1[0]==1); 
wire bank20_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==20)&&(cdma2buf_wr_addr0[0]==0); 
wire bank20_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==20)&&(cdma2buf_wr_addr1[0]==0); 
wire bank20_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==20)&&(cdma2buf_wr_addr0[0]==1); 
wire bank20_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==20)&&(cdma2buf_wr_addr1[0]==1); 
wire bank21_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==21)&&(cdma2buf_wr_addr0[0]==0); 
wire bank21_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==21)&&(cdma2buf_wr_addr1[0]==0); 
wire bank21_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==21)&&(cdma2buf_wr_addr0[0]==1); 
wire bank21_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==21)&&(cdma2buf_wr_addr1[0]==1); 
wire bank22_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==22)&&(cdma2buf_wr_addr0[0]==0); 
wire bank22_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==22)&&(cdma2buf_wr_addr1[0]==0); 
wire bank22_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==22)&&(cdma2buf_wr_addr0[0]==1); 
wire bank22_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==22)&&(cdma2buf_wr_addr1[0]==1); 
wire bank23_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==23)&&(cdma2buf_wr_addr0[0]==0); 
wire bank23_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==23)&&(cdma2buf_wr_addr1[0]==0); 
wire bank23_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==23)&&(cdma2buf_wr_addr0[0]==1); 
wire bank23_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==23)&&(cdma2buf_wr_addr1[0]==1); 
wire bank24_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==24)&&(cdma2buf_wr_addr0[0]==0); 
wire bank24_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==24)&&(cdma2buf_wr_addr1[0]==0); 
wire bank24_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==24)&&(cdma2buf_wr_addr0[0]==1); 
wire bank24_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==24)&&(cdma2buf_wr_addr1[0]==1); 
wire bank25_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==25)&&(cdma2buf_wr_addr0[0]==0); 
wire bank25_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==25)&&(cdma2buf_wr_addr1[0]==0); 
wire bank25_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==25)&&(cdma2buf_wr_addr0[0]==1); 
wire bank25_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==25)&&(cdma2buf_wr_addr1[0]==1); 
wire bank26_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==26)&&(cdma2buf_wr_addr0[0]==0); 
wire bank26_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==26)&&(cdma2buf_wr_addr1[0]==0); 
wire bank26_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==26)&&(cdma2buf_wr_addr0[0]==1); 
wire bank26_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==26)&&(cdma2buf_wr_addr1[0]==1); 
wire bank27_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==27)&&(cdma2buf_wr_addr0[0]==0); 
wire bank27_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==27)&&(cdma2buf_wr_addr1[0]==0); 
wire bank27_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==27)&&(cdma2buf_wr_addr0[0]==1); 
wire bank27_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==27)&&(cdma2buf_wr_addr1[0]==1); 
wire bank28_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==28)&&(cdma2buf_wr_addr0[0]==0); 
wire bank28_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==28)&&(cdma2buf_wr_addr1[0]==0); 
wire bank28_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==28)&&(cdma2buf_wr_addr0[0]==1); 
wire bank28_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==28)&&(cdma2buf_wr_addr1[0]==1); 
wire bank29_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==29)&&(cdma2buf_wr_addr0[0]==0); 
wire bank29_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==29)&&(cdma2buf_wr_addr1[0]==0); 
wire bank29_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==29)&&(cdma2buf_wr_addr0[0]==1); 
wire bank29_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==29)&&(cdma2buf_wr_addr1[0]==1); 
wire bank30_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==30)&&(cdma2buf_wr_addr0[0]==0); 
wire bank30_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==30)&&(cdma2buf_wr_addr1[0]==0); 
wire bank30_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==30)&&(cdma2buf_wr_addr0[0]==1); 
wire bank30_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==30)&&(cdma2buf_wr_addr1[0]==1); 
wire bank31_ram0_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==31)&&(cdma2buf_wr_addr0[0]==0); 
wire bank31_ram0_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==31)&&(cdma2buf_wr_addr1[0]==0); 
wire bank31_ram1_wr0_en_d0 = cdma2buf_wr_en0&&(cdma2buf_wr_addr0[13:9]==31)&&(cdma2buf_wr_addr0[0]==1); 
wire bank31_ram1_wr1_en_d0 = cdma2buf_wr_en1&&(cdma2buf_wr_addr1[13:9]==31)&&(cdma2buf_wr_addr1[0]==1); 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//generate sram write en
//: my $t1="";
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: for(my $i=0; $i<2; $i++){
//: ${t1} .= "bank${j}_ram${k}_wr${i}_en_d0 |";
//: }
//: print "wire bank${j}_ram${k}_wr_en_d0  = ${t1}"."1'b0; \n";
//: $t1="";
//: &eperl::flop("-q bank${j}_ram${k}_wr_en_d1 -d bank${j}_ram${k}_wr_en_d0");
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire bank0_ram0_wr_en_d0  = bank0_ram0_wr0_en_d0 |bank0_ram0_wr1_en_d0 |1'b0; 
reg  bank0_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank0_ram0_wr_en_d1 <= bank0_ram0_wr_en_d0;
   end
end
wire bank0_ram1_wr_en_d0  = bank0_ram1_wr0_en_d0 |bank0_ram1_wr1_en_d0 |1'b0; 
reg  bank0_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank0_ram1_wr_en_d1 <= bank0_ram1_wr_en_d0;
   end
end
wire bank1_ram0_wr_en_d0  = bank1_ram0_wr0_en_d0 |bank1_ram0_wr1_en_d0 |1'b0; 
reg  bank1_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank1_ram0_wr_en_d1 <= bank1_ram0_wr_en_d0;
   end
end
wire bank1_ram1_wr_en_d0  = bank1_ram1_wr0_en_d0 |bank1_ram1_wr1_en_d0 |1'b0; 
reg  bank1_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank1_ram1_wr_en_d1 <= bank1_ram1_wr_en_d0;
   end
end
wire bank2_ram0_wr_en_d0  = bank2_ram0_wr0_en_d0 |bank2_ram0_wr1_en_d0 |1'b0; 
reg  bank2_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank2_ram0_wr_en_d1 <= bank2_ram0_wr_en_d0;
   end
end
wire bank2_ram1_wr_en_d0  = bank2_ram1_wr0_en_d0 |bank2_ram1_wr1_en_d0 |1'b0; 
reg  bank2_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank2_ram1_wr_en_d1 <= bank2_ram1_wr_en_d0;
   end
end
wire bank3_ram0_wr_en_d0  = bank3_ram0_wr0_en_d0 |bank3_ram0_wr1_en_d0 |1'b0; 
reg  bank3_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank3_ram0_wr_en_d1 <= bank3_ram0_wr_en_d0;
   end
end
wire bank3_ram1_wr_en_d0  = bank3_ram1_wr0_en_d0 |bank3_ram1_wr1_en_d0 |1'b0; 
reg  bank3_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank3_ram1_wr_en_d1 <= bank3_ram1_wr_en_d0;
   end
end
wire bank4_ram0_wr_en_d0  = bank4_ram0_wr0_en_d0 |bank4_ram0_wr1_en_d0 |1'b0; 
reg  bank4_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank4_ram0_wr_en_d1 <= bank4_ram0_wr_en_d0;
   end
end
wire bank4_ram1_wr_en_d0  = bank4_ram1_wr0_en_d0 |bank4_ram1_wr1_en_d0 |1'b0; 
reg  bank4_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank4_ram1_wr_en_d1 <= bank4_ram1_wr_en_d0;
   end
end
wire bank5_ram0_wr_en_d0  = bank5_ram0_wr0_en_d0 |bank5_ram0_wr1_en_d0 |1'b0; 
reg  bank5_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank5_ram0_wr_en_d1 <= bank5_ram0_wr_en_d0;
   end
end
wire bank5_ram1_wr_en_d0  = bank5_ram1_wr0_en_d0 |bank5_ram1_wr1_en_d0 |1'b0; 
reg  bank5_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank5_ram1_wr_en_d1 <= bank5_ram1_wr_en_d0;
   end
end
wire bank6_ram0_wr_en_d0  = bank6_ram0_wr0_en_d0 |bank6_ram0_wr1_en_d0 |1'b0; 
reg  bank6_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank6_ram0_wr_en_d1 <= bank6_ram0_wr_en_d0;
   end
end
wire bank6_ram1_wr_en_d0  = bank6_ram1_wr0_en_d0 |bank6_ram1_wr1_en_d0 |1'b0; 
reg  bank6_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank6_ram1_wr_en_d1 <= bank6_ram1_wr_en_d0;
   end
end
wire bank7_ram0_wr_en_d0  = bank7_ram0_wr0_en_d0 |bank7_ram0_wr1_en_d0 |1'b0; 
reg  bank7_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank7_ram0_wr_en_d1 <= bank7_ram0_wr_en_d0;
   end
end
wire bank7_ram1_wr_en_d0  = bank7_ram1_wr0_en_d0 |bank7_ram1_wr1_en_d0 |1'b0; 
reg  bank7_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank7_ram1_wr_en_d1 <= bank7_ram1_wr_en_d0;
   end
end
wire bank8_ram0_wr_en_d0  = bank8_ram0_wr0_en_d0 |bank8_ram0_wr1_en_d0 |1'b0; 
reg  bank8_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank8_ram0_wr_en_d1 <= bank8_ram0_wr_en_d0;
   end
end
wire bank8_ram1_wr_en_d0  = bank8_ram1_wr0_en_d0 |bank8_ram1_wr1_en_d0 |1'b0; 
reg  bank8_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank8_ram1_wr_en_d1 <= bank8_ram1_wr_en_d0;
   end
end
wire bank9_ram0_wr_en_d0  = bank9_ram0_wr0_en_d0 |bank9_ram0_wr1_en_d0 |1'b0; 
reg  bank9_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank9_ram0_wr_en_d1 <= bank9_ram0_wr_en_d0;
   end
end
wire bank9_ram1_wr_en_d0  = bank9_ram1_wr0_en_d0 |bank9_ram1_wr1_en_d0 |1'b0; 
reg  bank9_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank9_ram1_wr_en_d1 <= bank9_ram1_wr_en_d0;
   end
end
wire bank10_ram0_wr_en_d0  = bank10_ram0_wr0_en_d0 |bank10_ram0_wr1_en_d0 |1'b0; 
reg  bank10_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank10_ram0_wr_en_d1 <= bank10_ram0_wr_en_d0;
   end
end
wire bank10_ram1_wr_en_d0  = bank10_ram1_wr0_en_d0 |bank10_ram1_wr1_en_d0 |1'b0; 
reg  bank10_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank10_ram1_wr_en_d1 <= bank10_ram1_wr_en_d0;
   end
end
wire bank11_ram0_wr_en_d0  = bank11_ram0_wr0_en_d0 |bank11_ram0_wr1_en_d0 |1'b0; 
reg  bank11_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank11_ram0_wr_en_d1 <= bank11_ram0_wr_en_d0;
   end
end
wire bank11_ram1_wr_en_d0  = bank11_ram1_wr0_en_d0 |bank11_ram1_wr1_en_d0 |1'b0; 
reg  bank11_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank11_ram1_wr_en_d1 <= bank11_ram1_wr_en_d0;
   end
end
wire bank12_ram0_wr_en_d0  = bank12_ram0_wr0_en_d0 |bank12_ram0_wr1_en_d0 |1'b0; 
reg  bank12_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank12_ram0_wr_en_d1 <= bank12_ram0_wr_en_d0;
   end
end
wire bank12_ram1_wr_en_d0  = bank12_ram1_wr0_en_d0 |bank12_ram1_wr1_en_d0 |1'b0; 
reg  bank12_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank12_ram1_wr_en_d1 <= bank12_ram1_wr_en_d0;
   end
end
wire bank13_ram0_wr_en_d0  = bank13_ram0_wr0_en_d0 |bank13_ram0_wr1_en_d0 |1'b0; 
reg  bank13_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank13_ram0_wr_en_d1 <= bank13_ram0_wr_en_d0;
   end
end
wire bank13_ram1_wr_en_d0  = bank13_ram1_wr0_en_d0 |bank13_ram1_wr1_en_d0 |1'b0; 
reg  bank13_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank13_ram1_wr_en_d1 <= bank13_ram1_wr_en_d0;
   end
end
wire bank14_ram0_wr_en_d0  = bank14_ram0_wr0_en_d0 |bank14_ram0_wr1_en_d0 |1'b0; 
reg  bank14_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank14_ram0_wr_en_d1 <= bank14_ram0_wr_en_d0;
   end
end
wire bank14_ram1_wr_en_d0  = bank14_ram1_wr0_en_d0 |bank14_ram1_wr1_en_d0 |1'b0; 
reg  bank14_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank14_ram1_wr_en_d1 <= bank14_ram1_wr_en_d0;
   end
end
wire bank15_ram0_wr_en_d0  = bank15_ram0_wr0_en_d0 |bank15_ram0_wr1_en_d0 |1'b0; 
reg  bank15_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank15_ram0_wr_en_d1 <= bank15_ram0_wr_en_d0;
   end
end
wire bank15_ram1_wr_en_d0  = bank15_ram1_wr0_en_d0 |bank15_ram1_wr1_en_d0 |1'b0; 
reg  bank15_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank15_ram1_wr_en_d1 <= bank15_ram1_wr_en_d0;
   end
end
wire bank16_ram0_wr_en_d0  = bank16_ram0_wr0_en_d0 |bank16_ram0_wr1_en_d0 |1'b0; 
reg  bank16_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank16_ram0_wr_en_d1 <= bank16_ram0_wr_en_d0;
   end
end
wire bank16_ram1_wr_en_d0  = bank16_ram1_wr0_en_d0 |bank16_ram1_wr1_en_d0 |1'b0; 
reg  bank16_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank16_ram1_wr_en_d1 <= bank16_ram1_wr_en_d0;
   end
end
wire bank17_ram0_wr_en_d0  = bank17_ram0_wr0_en_d0 |bank17_ram0_wr1_en_d0 |1'b0; 
reg  bank17_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank17_ram0_wr_en_d1 <= bank17_ram0_wr_en_d0;
   end
end
wire bank17_ram1_wr_en_d0  = bank17_ram1_wr0_en_d0 |bank17_ram1_wr1_en_d0 |1'b0; 
reg  bank17_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank17_ram1_wr_en_d1 <= bank17_ram1_wr_en_d0;
   end
end
wire bank18_ram0_wr_en_d0  = bank18_ram0_wr0_en_d0 |bank18_ram0_wr1_en_d0 |1'b0; 
reg  bank18_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank18_ram0_wr_en_d1 <= bank18_ram0_wr_en_d0;
   end
end
wire bank18_ram1_wr_en_d0  = bank18_ram1_wr0_en_d0 |bank18_ram1_wr1_en_d0 |1'b0; 
reg  bank18_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank18_ram1_wr_en_d1 <= bank18_ram1_wr_en_d0;
   end
end
wire bank19_ram0_wr_en_d0  = bank19_ram0_wr0_en_d0 |bank19_ram0_wr1_en_d0 |1'b0; 
reg  bank19_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank19_ram0_wr_en_d1 <= bank19_ram0_wr_en_d0;
   end
end
wire bank19_ram1_wr_en_d0  = bank19_ram1_wr0_en_d0 |bank19_ram1_wr1_en_d0 |1'b0; 
reg  bank19_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank19_ram1_wr_en_d1 <= bank19_ram1_wr_en_d0;
   end
end
wire bank20_ram0_wr_en_d0  = bank20_ram0_wr0_en_d0 |bank20_ram0_wr1_en_d0 |1'b0; 
reg  bank20_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank20_ram0_wr_en_d1 <= bank20_ram0_wr_en_d0;
   end
end
wire bank20_ram1_wr_en_d0  = bank20_ram1_wr0_en_d0 |bank20_ram1_wr1_en_d0 |1'b0; 
reg  bank20_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank20_ram1_wr_en_d1 <= bank20_ram1_wr_en_d0;
   end
end
wire bank21_ram0_wr_en_d0  = bank21_ram0_wr0_en_d0 |bank21_ram0_wr1_en_d0 |1'b0; 
reg  bank21_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank21_ram0_wr_en_d1 <= bank21_ram0_wr_en_d0;
   end
end
wire bank21_ram1_wr_en_d0  = bank21_ram1_wr0_en_d0 |bank21_ram1_wr1_en_d0 |1'b0; 
reg  bank21_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank21_ram1_wr_en_d1 <= bank21_ram1_wr_en_d0;
   end
end
wire bank22_ram0_wr_en_d0  = bank22_ram0_wr0_en_d0 |bank22_ram0_wr1_en_d0 |1'b0; 
reg  bank22_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank22_ram0_wr_en_d1 <= bank22_ram0_wr_en_d0;
   end
end
wire bank22_ram1_wr_en_d0  = bank22_ram1_wr0_en_d0 |bank22_ram1_wr1_en_d0 |1'b0; 
reg  bank22_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank22_ram1_wr_en_d1 <= bank22_ram1_wr_en_d0;
   end
end
wire bank23_ram0_wr_en_d0  = bank23_ram0_wr0_en_d0 |bank23_ram0_wr1_en_d0 |1'b0; 
reg  bank23_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank23_ram0_wr_en_d1 <= bank23_ram0_wr_en_d0;
   end
end
wire bank23_ram1_wr_en_d0  = bank23_ram1_wr0_en_d0 |bank23_ram1_wr1_en_d0 |1'b0; 
reg  bank23_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank23_ram1_wr_en_d1 <= bank23_ram1_wr_en_d0;
   end
end
wire bank24_ram0_wr_en_d0  = bank24_ram0_wr0_en_d0 |bank24_ram0_wr1_en_d0 |1'b0; 
reg  bank24_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank24_ram0_wr_en_d1 <= bank24_ram0_wr_en_d0;
   end
end
wire bank24_ram1_wr_en_d0  = bank24_ram1_wr0_en_d0 |bank24_ram1_wr1_en_d0 |1'b0; 
reg  bank24_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank24_ram1_wr_en_d1 <= bank24_ram1_wr_en_d0;
   end
end
wire bank25_ram0_wr_en_d0  = bank25_ram0_wr0_en_d0 |bank25_ram0_wr1_en_d0 |1'b0; 
reg  bank25_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank25_ram0_wr_en_d1 <= bank25_ram0_wr_en_d0;
   end
end
wire bank25_ram1_wr_en_d0  = bank25_ram1_wr0_en_d0 |bank25_ram1_wr1_en_d0 |1'b0; 
reg  bank25_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank25_ram1_wr_en_d1 <= bank25_ram1_wr_en_d0;
   end
end
wire bank26_ram0_wr_en_d0  = bank26_ram0_wr0_en_d0 |bank26_ram0_wr1_en_d0 |1'b0; 
reg  bank26_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank26_ram0_wr_en_d1 <= bank26_ram0_wr_en_d0;
   end
end
wire bank26_ram1_wr_en_d0  = bank26_ram1_wr0_en_d0 |bank26_ram1_wr1_en_d0 |1'b0; 
reg  bank26_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank26_ram1_wr_en_d1 <= bank26_ram1_wr_en_d0;
   end
end
wire bank27_ram0_wr_en_d0  = bank27_ram0_wr0_en_d0 |bank27_ram0_wr1_en_d0 |1'b0; 
reg  bank27_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank27_ram0_wr_en_d1 <= bank27_ram0_wr_en_d0;
   end
end
wire bank27_ram1_wr_en_d0  = bank27_ram1_wr0_en_d0 |bank27_ram1_wr1_en_d0 |1'b0; 
reg  bank27_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank27_ram1_wr_en_d1 <= bank27_ram1_wr_en_d0;
   end
end
wire bank28_ram0_wr_en_d0  = bank28_ram0_wr0_en_d0 |bank28_ram0_wr1_en_d0 |1'b0; 
reg  bank28_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank28_ram0_wr_en_d1 <= bank28_ram0_wr_en_d0;
   end
end
wire bank28_ram1_wr_en_d0  = bank28_ram1_wr0_en_d0 |bank28_ram1_wr1_en_d0 |1'b0; 
reg  bank28_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank28_ram1_wr_en_d1 <= bank28_ram1_wr_en_d0;
   end
end
wire bank29_ram0_wr_en_d0  = bank29_ram0_wr0_en_d0 |bank29_ram0_wr1_en_d0 |1'b0; 
reg  bank29_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank29_ram0_wr_en_d1 <= bank29_ram0_wr_en_d0;
   end
end
wire bank29_ram1_wr_en_d0  = bank29_ram1_wr0_en_d0 |bank29_ram1_wr1_en_d0 |1'b0; 
reg  bank29_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank29_ram1_wr_en_d1 <= bank29_ram1_wr_en_d0;
   end
end
wire bank30_ram0_wr_en_d0  = bank30_ram0_wr0_en_d0 |bank30_ram0_wr1_en_d0 |1'b0; 
reg  bank30_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank30_ram0_wr_en_d1 <= bank30_ram0_wr_en_d0;
   end
end
wire bank30_ram1_wr_en_d0  = bank30_ram1_wr0_en_d0 |bank30_ram1_wr1_en_d0 |1'b0; 
reg  bank30_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank30_ram1_wr_en_d1 <= bank30_ram1_wr_en_d0;
   end
end
wire bank31_ram0_wr_en_d0  = bank31_ram0_wr0_en_d0 |bank31_ram0_wr1_en_d0 |1'b0; 
reg  bank31_ram0_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_wr_en_d1 <= 'b0;
   end else begin
       bank31_ram0_wr_en_d1 <= bank31_ram0_wr_en_d0;
   end
end
wire bank31_ram1_wr_en_d0  = bank31_ram1_wr0_en_d0 |bank31_ram1_wr1_en_d0 |1'b0; 
reg  bank31_ram1_wr_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_wr_en_d1 <= 'b0;
   end else begin
       bank31_ram1_wr_en_d1 <= bank31_ram1_wr_en_d0;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// 1 pipe for timing
//: my $kk=14;
//: my $jj=64;
//: for(my $i=0; $i<2 ; $i++){
//: &eperl::flop("-wid ${kk} -q cdma2buf_wr_addr${i}_d1 -d cdma2buf_wr_addr${i}");
//: &eperl::flop("-wid ${jj} -norst -q cdma2buf_wr_data${i}_d1 -d cdma2buf_wr_data${i}");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [13:0] cdma2buf_wr_addr0_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cdma2buf_wr_addr0_d1 <= 'b0;
   end else begin
       cdma2buf_wr_addr0_d1 <= cdma2buf_wr_addr0;
   end
end
reg [63:0] cdma2buf_wr_data0_d1;
always @(posedge nvdla_core_clk) begin
       cdma2buf_wr_data0_d1 <= cdma2buf_wr_data0;
end
reg [13:0] cdma2buf_wr_addr1_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cdma2buf_wr_addr1_d1 <= 'b0;
   end else begin
       cdma2buf_wr_addr1_d1 <= cdma2buf_wr_addr1;
   end
end
reg [63:0] cdma2buf_wr_data1_d1;
always @(posedge nvdla_core_clk) begin
       cdma2buf_wr_data1_d1 <= cdma2buf_wr_data1;
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//generate bank write en
//: my $t1="";
//: for(my $i=0; $i<2; $i++){
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2; $k++){
//: $t1 .= "bank${j}_ram${k}_wr${i}_en_d0 |";
//: }
//: print "wire bank${j}_wr${i}_en_d0 = ${t1}"."1'b0; \n";
//: &eperl::flop("-q bank${j}_wr${i}_en_d1 -d bank${j}_wr${i}_en_d0");
//: $t1="";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire bank0_wr0_en_d0 = bank0_ram0_wr0_en_d0 |bank0_ram1_wr0_en_d0 |1'b0; 
reg  bank0_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_wr0_en_d1 <= 'b0;
   end else begin
       bank0_wr0_en_d1 <= bank0_wr0_en_d0;
   end
end
wire bank1_wr0_en_d0 = bank1_ram0_wr0_en_d0 |bank1_ram1_wr0_en_d0 |1'b0; 
reg  bank1_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_wr0_en_d1 <= 'b0;
   end else begin
       bank1_wr0_en_d1 <= bank1_wr0_en_d0;
   end
end
wire bank2_wr0_en_d0 = bank2_ram0_wr0_en_d0 |bank2_ram1_wr0_en_d0 |1'b0; 
reg  bank2_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_wr0_en_d1 <= 'b0;
   end else begin
       bank2_wr0_en_d1 <= bank2_wr0_en_d0;
   end
end
wire bank3_wr0_en_d0 = bank3_ram0_wr0_en_d0 |bank3_ram1_wr0_en_d0 |1'b0; 
reg  bank3_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_wr0_en_d1 <= 'b0;
   end else begin
       bank3_wr0_en_d1 <= bank3_wr0_en_d0;
   end
end
wire bank4_wr0_en_d0 = bank4_ram0_wr0_en_d0 |bank4_ram1_wr0_en_d0 |1'b0; 
reg  bank4_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_wr0_en_d1 <= 'b0;
   end else begin
       bank4_wr0_en_d1 <= bank4_wr0_en_d0;
   end
end
wire bank5_wr0_en_d0 = bank5_ram0_wr0_en_d0 |bank5_ram1_wr0_en_d0 |1'b0; 
reg  bank5_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_wr0_en_d1 <= 'b0;
   end else begin
       bank5_wr0_en_d1 <= bank5_wr0_en_d0;
   end
end
wire bank6_wr0_en_d0 = bank6_ram0_wr0_en_d0 |bank6_ram1_wr0_en_d0 |1'b0; 
reg  bank6_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_wr0_en_d1 <= 'b0;
   end else begin
       bank6_wr0_en_d1 <= bank6_wr0_en_d0;
   end
end
wire bank7_wr0_en_d0 = bank7_ram0_wr0_en_d0 |bank7_ram1_wr0_en_d0 |1'b0; 
reg  bank7_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_wr0_en_d1 <= 'b0;
   end else begin
       bank7_wr0_en_d1 <= bank7_wr0_en_d0;
   end
end
wire bank8_wr0_en_d0 = bank8_ram0_wr0_en_d0 |bank8_ram1_wr0_en_d0 |1'b0; 
reg  bank8_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_wr0_en_d1 <= 'b0;
   end else begin
       bank8_wr0_en_d1 <= bank8_wr0_en_d0;
   end
end
wire bank9_wr0_en_d0 = bank9_ram0_wr0_en_d0 |bank9_ram1_wr0_en_d0 |1'b0; 
reg  bank9_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_wr0_en_d1 <= 'b0;
   end else begin
       bank9_wr0_en_d1 <= bank9_wr0_en_d0;
   end
end
wire bank10_wr0_en_d0 = bank10_ram0_wr0_en_d0 |bank10_ram1_wr0_en_d0 |1'b0; 
reg  bank10_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_wr0_en_d1 <= 'b0;
   end else begin
       bank10_wr0_en_d1 <= bank10_wr0_en_d0;
   end
end
wire bank11_wr0_en_d0 = bank11_ram0_wr0_en_d0 |bank11_ram1_wr0_en_d0 |1'b0; 
reg  bank11_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_wr0_en_d1 <= 'b0;
   end else begin
       bank11_wr0_en_d1 <= bank11_wr0_en_d0;
   end
end
wire bank12_wr0_en_d0 = bank12_ram0_wr0_en_d0 |bank12_ram1_wr0_en_d0 |1'b0; 
reg  bank12_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_wr0_en_d1 <= 'b0;
   end else begin
       bank12_wr0_en_d1 <= bank12_wr0_en_d0;
   end
end
wire bank13_wr0_en_d0 = bank13_ram0_wr0_en_d0 |bank13_ram1_wr0_en_d0 |1'b0; 
reg  bank13_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_wr0_en_d1 <= 'b0;
   end else begin
       bank13_wr0_en_d1 <= bank13_wr0_en_d0;
   end
end
wire bank14_wr0_en_d0 = bank14_ram0_wr0_en_d0 |bank14_ram1_wr0_en_d0 |1'b0; 
reg  bank14_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_wr0_en_d1 <= 'b0;
   end else begin
       bank14_wr0_en_d1 <= bank14_wr0_en_d0;
   end
end
wire bank15_wr0_en_d0 = bank15_ram0_wr0_en_d0 |bank15_ram1_wr0_en_d0 |1'b0; 
reg  bank15_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_wr0_en_d1 <= 'b0;
   end else begin
       bank15_wr0_en_d1 <= bank15_wr0_en_d0;
   end
end
wire bank16_wr0_en_d0 = bank16_ram0_wr0_en_d0 |bank16_ram1_wr0_en_d0 |1'b0; 
reg  bank16_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_wr0_en_d1 <= 'b0;
   end else begin
       bank16_wr0_en_d1 <= bank16_wr0_en_d0;
   end
end
wire bank17_wr0_en_d0 = bank17_ram0_wr0_en_d0 |bank17_ram1_wr0_en_d0 |1'b0; 
reg  bank17_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_wr0_en_d1 <= 'b0;
   end else begin
       bank17_wr0_en_d1 <= bank17_wr0_en_d0;
   end
end
wire bank18_wr0_en_d0 = bank18_ram0_wr0_en_d0 |bank18_ram1_wr0_en_d0 |1'b0; 
reg  bank18_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_wr0_en_d1 <= 'b0;
   end else begin
       bank18_wr0_en_d1 <= bank18_wr0_en_d0;
   end
end
wire bank19_wr0_en_d0 = bank19_ram0_wr0_en_d0 |bank19_ram1_wr0_en_d0 |1'b0; 
reg  bank19_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_wr0_en_d1 <= 'b0;
   end else begin
       bank19_wr0_en_d1 <= bank19_wr0_en_d0;
   end
end
wire bank20_wr0_en_d0 = bank20_ram0_wr0_en_d0 |bank20_ram1_wr0_en_d0 |1'b0; 
reg  bank20_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_wr0_en_d1 <= 'b0;
   end else begin
       bank20_wr0_en_d1 <= bank20_wr0_en_d0;
   end
end
wire bank21_wr0_en_d0 = bank21_ram0_wr0_en_d0 |bank21_ram1_wr0_en_d0 |1'b0; 
reg  bank21_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_wr0_en_d1 <= 'b0;
   end else begin
       bank21_wr0_en_d1 <= bank21_wr0_en_d0;
   end
end
wire bank22_wr0_en_d0 = bank22_ram0_wr0_en_d0 |bank22_ram1_wr0_en_d0 |1'b0; 
reg  bank22_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_wr0_en_d1 <= 'b0;
   end else begin
       bank22_wr0_en_d1 <= bank22_wr0_en_d0;
   end
end
wire bank23_wr0_en_d0 = bank23_ram0_wr0_en_d0 |bank23_ram1_wr0_en_d0 |1'b0; 
reg  bank23_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_wr0_en_d1 <= 'b0;
   end else begin
       bank23_wr0_en_d1 <= bank23_wr0_en_d0;
   end
end
wire bank24_wr0_en_d0 = bank24_ram0_wr0_en_d0 |bank24_ram1_wr0_en_d0 |1'b0; 
reg  bank24_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_wr0_en_d1 <= 'b0;
   end else begin
       bank24_wr0_en_d1 <= bank24_wr0_en_d0;
   end
end
wire bank25_wr0_en_d0 = bank25_ram0_wr0_en_d0 |bank25_ram1_wr0_en_d0 |1'b0; 
reg  bank25_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_wr0_en_d1 <= 'b0;
   end else begin
       bank25_wr0_en_d1 <= bank25_wr0_en_d0;
   end
end
wire bank26_wr0_en_d0 = bank26_ram0_wr0_en_d0 |bank26_ram1_wr0_en_d0 |1'b0; 
reg  bank26_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_wr0_en_d1 <= 'b0;
   end else begin
       bank26_wr0_en_d1 <= bank26_wr0_en_d0;
   end
end
wire bank27_wr0_en_d0 = bank27_ram0_wr0_en_d0 |bank27_ram1_wr0_en_d0 |1'b0; 
reg  bank27_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_wr0_en_d1 <= 'b0;
   end else begin
       bank27_wr0_en_d1 <= bank27_wr0_en_d0;
   end
end
wire bank28_wr0_en_d0 = bank28_ram0_wr0_en_d0 |bank28_ram1_wr0_en_d0 |1'b0; 
reg  bank28_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_wr0_en_d1 <= 'b0;
   end else begin
       bank28_wr0_en_d1 <= bank28_wr0_en_d0;
   end
end
wire bank29_wr0_en_d0 = bank29_ram0_wr0_en_d0 |bank29_ram1_wr0_en_d0 |1'b0; 
reg  bank29_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_wr0_en_d1 <= 'b0;
   end else begin
       bank29_wr0_en_d1 <= bank29_wr0_en_d0;
   end
end
wire bank30_wr0_en_d0 = bank30_ram0_wr0_en_d0 |bank30_ram1_wr0_en_d0 |1'b0; 
reg  bank30_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_wr0_en_d1 <= 'b0;
   end else begin
       bank30_wr0_en_d1 <= bank30_wr0_en_d0;
   end
end
wire bank31_wr0_en_d0 = bank31_ram0_wr0_en_d0 |bank31_ram1_wr0_en_d0 |1'b0; 
reg  bank31_wr0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_wr0_en_d1 <= 'b0;
   end else begin
       bank31_wr0_en_d1 <= bank31_wr0_en_d0;
   end
end
wire bank0_wr1_en_d0 = bank0_ram0_wr1_en_d0 |bank0_ram1_wr1_en_d0 |1'b0; 
reg  bank0_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_wr1_en_d1 <= 'b0;
   end else begin
       bank0_wr1_en_d1 <= bank0_wr1_en_d0;
   end
end
wire bank1_wr1_en_d0 = bank1_ram0_wr1_en_d0 |bank1_ram1_wr1_en_d0 |1'b0; 
reg  bank1_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_wr1_en_d1 <= 'b0;
   end else begin
       bank1_wr1_en_d1 <= bank1_wr1_en_d0;
   end
end
wire bank2_wr1_en_d0 = bank2_ram0_wr1_en_d0 |bank2_ram1_wr1_en_d0 |1'b0; 
reg  bank2_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_wr1_en_d1 <= 'b0;
   end else begin
       bank2_wr1_en_d1 <= bank2_wr1_en_d0;
   end
end
wire bank3_wr1_en_d0 = bank3_ram0_wr1_en_d0 |bank3_ram1_wr1_en_d0 |1'b0; 
reg  bank3_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_wr1_en_d1 <= 'b0;
   end else begin
       bank3_wr1_en_d1 <= bank3_wr1_en_d0;
   end
end
wire bank4_wr1_en_d0 = bank4_ram0_wr1_en_d0 |bank4_ram1_wr1_en_d0 |1'b0; 
reg  bank4_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_wr1_en_d1 <= 'b0;
   end else begin
       bank4_wr1_en_d1 <= bank4_wr1_en_d0;
   end
end
wire bank5_wr1_en_d0 = bank5_ram0_wr1_en_d0 |bank5_ram1_wr1_en_d0 |1'b0; 
reg  bank5_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_wr1_en_d1 <= 'b0;
   end else begin
       bank5_wr1_en_d1 <= bank5_wr1_en_d0;
   end
end
wire bank6_wr1_en_d0 = bank6_ram0_wr1_en_d0 |bank6_ram1_wr1_en_d0 |1'b0; 
reg  bank6_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_wr1_en_d1 <= 'b0;
   end else begin
       bank6_wr1_en_d1 <= bank6_wr1_en_d0;
   end
end
wire bank7_wr1_en_d0 = bank7_ram0_wr1_en_d0 |bank7_ram1_wr1_en_d0 |1'b0; 
reg  bank7_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_wr1_en_d1 <= 'b0;
   end else begin
       bank7_wr1_en_d1 <= bank7_wr1_en_d0;
   end
end
wire bank8_wr1_en_d0 = bank8_ram0_wr1_en_d0 |bank8_ram1_wr1_en_d0 |1'b0; 
reg  bank8_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_wr1_en_d1 <= 'b0;
   end else begin
       bank8_wr1_en_d1 <= bank8_wr1_en_d0;
   end
end
wire bank9_wr1_en_d0 = bank9_ram0_wr1_en_d0 |bank9_ram1_wr1_en_d0 |1'b0; 
reg  bank9_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_wr1_en_d1 <= 'b0;
   end else begin
       bank9_wr1_en_d1 <= bank9_wr1_en_d0;
   end
end
wire bank10_wr1_en_d0 = bank10_ram0_wr1_en_d0 |bank10_ram1_wr1_en_d0 |1'b0; 
reg  bank10_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_wr1_en_d1 <= 'b0;
   end else begin
       bank10_wr1_en_d1 <= bank10_wr1_en_d0;
   end
end
wire bank11_wr1_en_d0 = bank11_ram0_wr1_en_d0 |bank11_ram1_wr1_en_d0 |1'b0; 
reg  bank11_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_wr1_en_d1 <= 'b0;
   end else begin
       bank11_wr1_en_d1 <= bank11_wr1_en_d0;
   end
end
wire bank12_wr1_en_d0 = bank12_ram0_wr1_en_d0 |bank12_ram1_wr1_en_d0 |1'b0; 
reg  bank12_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_wr1_en_d1 <= 'b0;
   end else begin
       bank12_wr1_en_d1 <= bank12_wr1_en_d0;
   end
end
wire bank13_wr1_en_d0 = bank13_ram0_wr1_en_d0 |bank13_ram1_wr1_en_d0 |1'b0; 
reg  bank13_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_wr1_en_d1 <= 'b0;
   end else begin
       bank13_wr1_en_d1 <= bank13_wr1_en_d0;
   end
end
wire bank14_wr1_en_d0 = bank14_ram0_wr1_en_d0 |bank14_ram1_wr1_en_d0 |1'b0; 
reg  bank14_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_wr1_en_d1 <= 'b0;
   end else begin
       bank14_wr1_en_d1 <= bank14_wr1_en_d0;
   end
end
wire bank15_wr1_en_d0 = bank15_ram0_wr1_en_d0 |bank15_ram1_wr1_en_d0 |1'b0; 
reg  bank15_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_wr1_en_d1 <= 'b0;
   end else begin
       bank15_wr1_en_d1 <= bank15_wr1_en_d0;
   end
end
wire bank16_wr1_en_d0 = bank16_ram0_wr1_en_d0 |bank16_ram1_wr1_en_d0 |1'b0; 
reg  bank16_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_wr1_en_d1 <= 'b0;
   end else begin
       bank16_wr1_en_d1 <= bank16_wr1_en_d0;
   end
end
wire bank17_wr1_en_d0 = bank17_ram0_wr1_en_d0 |bank17_ram1_wr1_en_d0 |1'b0; 
reg  bank17_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_wr1_en_d1 <= 'b0;
   end else begin
       bank17_wr1_en_d1 <= bank17_wr1_en_d0;
   end
end
wire bank18_wr1_en_d0 = bank18_ram0_wr1_en_d0 |bank18_ram1_wr1_en_d0 |1'b0; 
reg  bank18_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_wr1_en_d1 <= 'b0;
   end else begin
       bank18_wr1_en_d1 <= bank18_wr1_en_d0;
   end
end
wire bank19_wr1_en_d0 = bank19_ram0_wr1_en_d0 |bank19_ram1_wr1_en_d0 |1'b0; 
reg  bank19_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_wr1_en_d1 <= 'b0;
   end else begin
       bank19_wr1_en_d1 <= bank19_wr1_en_d0;
   end
end
wire bank20_wr1_en_d0 = bank20_ram0_wr1_en_d0 |bank20_ram1_wr1_en_d0 |1'b0; 
reg  bank20_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_wr1_en_d1 <= 'b0;
   end else begin
       bank20_wr1_en_d1 <= bank20_wr1_en_d0;
   end
end
wire bank21_wr1_en_d0 = bank21_ram0_wr1_en_d0 |bank21_ram1_wr1_en_d0 |1'b0; 
reg  bank21_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_wr1_en_d1 <= 'b0;
   end else begin
       bank21_wr1_en_d1 <= bank21_wr1_en_d0;
   end
end
wire bank22_wr1_en_d0 = bank22_ram0_wr1_en_d0 |bank22_ram1_wr1_en_d0 |1'b0; 
reg  bank22_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_wr1_en_d1 <= 'b0;
   end else begin
       bank22_wr1_en_d1 <= bank22_wr1_en_d0;
   end
end
wire bank23_wr1_en_d0 = bank23_ram0_wr1_en_d0 |bank23_ram1_wr1_en_d0 |1'b0; 
reg  bank23_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_wr1_en_d1 <= 'b0;
   end else begin
       bank23_wr1_en_d1 <= bank23_wr1_en_d0;
   end
end
wire bank24_wr1_en_d0 = bank24_ram0_wr1_en_d0 |bank24_ram1_wr1_en_d0 |1'b0; 
reg  bank24_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_wr1_en_d1 <= 'b0;
   end else begin
       bank24_wr1_en_d1 <= bank24_wr1_en_d0;
   end
end
wire bank25_wr1_en_d0 = bank25_ram0_wr1_en_d0 |bank25_ram1_wr1_en_d0 |1'b0; 
reg  bank25_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_wr1_en_d1 <= 'b0;
   end else begin
       bank25_wr1_en_d1 <= bank25_wr1_en_d0;
   end
end
wire bank26_wr1_en_d0 = bank26_ram0_wr1_en_d0 |bank26_ram1_wr1_en_d0 |1'b0; 
reg  bank26_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_wr1_en_d1 <= 'b0;
   end else begin
       bank26_wr1_en_d1 <= bank26_wr1_en_d0;
   end
end
wire bank27_wr1_en_d0 = bank27_ram0_wr1_en_d0 |bank27_ram1_wr1_en_d0 |1'b0; 
reg  bank27_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_wr1_en_d1 <= 'b0;
   end else begin
       bank27_wr1_en_d1 <= bank27_wr1_en_d0;
   end
end
wire bank28_wr1_en_d0 = bank28_ram0_wr1_en_d0 |bank28_ram1_wr1_en_d0 |1'b0; 
reg  bank28_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_wr1_en_d1 <= 'b0;
   end else begin
       bank28_wr1_en_d1 <= bank28_wr1_en_d0;
   end
end
wire bank29_wr1_en_d0 = bank29_ram0_wr1_en_d0 |bank29_ram1_wr1_en_d0 |1'b0; 
reg  bank29_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_wr1_en_d1 <= 'b0;
   end else begin
       bank29_wr1_en_d1 <= bank29_wr1_en_d0;
   end
end
wire bank30_wr1_en_d0 = bank30_ram0_wr1_en_d0 |bank30_ram1_wr1_en_d0 |1'b0; 
reg  bank30_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_wr1_en_d1 <= 'b0;
   end else begin
       bank30_wr1_en_d1 <= bank30_wr1_en_d0;
   end
end
wire bank31_wr1_en_d0 = bank31_ram0_wr1_en_d0 |bank31_ram1_wr1_en_d0 |1'b0; 
reg  bank31_wr1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_wr1_en_d1 <= 'b0;
   end else begin
       bank31_wr1_en_d1 <= bank31_wr1_en_d0;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//generate bank write addr/data
//: my $t1="";
//: my $d1="";
//: my $kk= 14;
//: my $jj= 64;
//: for(my $j=0; $j<32 ; $j++){
//: for(my $i=0; $i<2; $i++){
//: $t1 .="({${kk}{bank${j}_wr${i}_en_d1}}&cdma2buf_wr_addr${i}_d1)|";
//: $d1 .="({${jj}{bank${j}_wr${i}_en_d1}}&cdma2buf_wr_data${i}_d1)|";
//: }
//: my $t2 .="{${kk}{1'b0}}";
//: my $d2 .="{${jj}{1'b0}}";
//: print "wire [${kk}-1:0] bank${j}_wr_addr_d1 = ${t1}${t2}; \n";
//: print "wire [${jj}-1:0] bank${j}_wr_data_d1 = ${d1}${d2}; \n";
//: $t1="";
//: $d1="";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [14-1:0] bank0_wr_addr_d1 = ({14{bank0_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank0_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank0_wr_data_d1 = ({64{bank0_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank0_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank1_wr_addr_d1 = ({14{bank1_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank1_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank1_wr_data_d1 = ({64{bank1_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank1_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank2_wr_addr_d1 = ({14{bank2_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank2_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank2_wr_data_d1 = ({64{bank2_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank2_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank3_wr_addr_d1 = ({14{bank3_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank3_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank3_wr_data_d1 = ({64{bank3_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank3_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank4_wr_addr_d1 = ({14{bank4_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank4_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank4_wr_data_d1 = ({64{bank4_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank4_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank5_wr_addr_d1 = ({14{bank5_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank5_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank5_wr_data_d1 = ({64{bank5_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank5_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank6_wr_addr_d1 = ({14{bank6_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank6_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank6_wr_data_d1 = ({64{bank6_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank6_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank7_wr_addr_d1 = ({14{bank7_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank7_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank7_wr_data_d1 = ({64{bank7_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank7_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank8_wr_addr_d1 = ({14{bank8_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank8_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank8_wr_data_d1 = ({64{bank8_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank8_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank9_wr_addr_d1 = ({14{bank9_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank9_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank9_wr_data_d1 = ({64{bank9_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank9_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank10_wr_addr_d1 = ({14{bank10_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank10_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank10_wr_data_d1 = ({64{bank10_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank10_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank11_wr_addr_d1 = ({14{bank11_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank11_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank11_wr_data_d1 = ({64{bank11_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank11_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank12_wr_addr_d1 = ({14{bank12_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank12_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank12_wr_data_d1 = ({64{bank12_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank12_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank13_wr_addr_d1 = ({14{bank13_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank13_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank13_wr_data_d1 = ({64{bank13_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank13_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank14_wr_addr_d1 = ({14{bank14_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank14_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank14_wr_data_d1 = ({64{bank14_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank14_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank15_wr_addr_d1 = ({14{bank15_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank15_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank15_wr_data_d1 = ({64{bank15_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank15_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank16_wr_addr_d1 = ({14{bank16_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank16_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank16_wr_data_d1 = ({64{bank16_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank16_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank17_wr_addr_d1 = ({14{bank17_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank17_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank17_wr_data_d1 = ({64{bank17_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank17_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank18_wr_addr_d1 = ({14{bank18_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank18_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank18_wr_data_d1 = ({64{bank18_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank18_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank19_wr_addr_d1 = ({14{bank19_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank19_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank19_wr_data_d1 = ({64{bank19_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank19_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank20_wr_addr_d1 = ({14{bank20_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank20_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank20_wr_data_d1 = ({64{bank20_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank20_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank21_wr_addr_d1 = ({14{bank21_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank21_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank21_wr_data_d1 = ({64{bank21_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank21_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank22_wr_addr_d1 = ({14{bank22_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank22_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank22_wr_data_d1 = ({64{bank22_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank22_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank23_wr_addr_d1 = ({14{bank23_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank23_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank23_wr_data_d1 = ({64{bank23_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank23_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank24_wr_addr_d1 = ({14{bank24_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank24_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank24_wr_data_d1 = ({64{bank24_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank24_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank25_wr_addr_d1 = ({14{bank25_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank25_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank25_wr_data_d1 = ({64{bank25_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank25_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank26_wr_addr_d1 = ({14{bank26_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank26_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank26_wr_data_d1 = ({64{bank26_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank26_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank27_wr_addr_d1 = ({14{bank27_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank27_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank27_wr_data_d1 = ({64{bank27_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank27_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank28_wr_addr_d1 = ({14{bank28_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank28_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank28_wr_data_d1 = ({64{bank28_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank28_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank29_wr_addr_d1 = ({14{bank29_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank29_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank29_wr_data_d1 = ({64{bank29_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank29_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank30_wr_addr_d1 = ({14{bank30_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank30_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank30_wr_data_d1 = ({64{bank30_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank30_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 
wire [14-1:0] bank31_wr_addr_d1 = ({14{bank31_wr0_en_d1}}&cdma2buf_wr_addr0_d1)|({14{bank31_wr1_en_d1}}&cdma2buf_wr_addr1_d1)|{14{1'b0}}; 
wire [64-1:0] bank31_wr_data_d1 = ({64{bank31_wr0_en_d1}}&cdma2buf_wr_data0_d1)|({64{bank31_wr1_en_d1}}&cdma2buf_wr_data1_d1)|{64{1'b0}}; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//map bank to sram.
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire[9 -1 -1:0] bank${j}_ram${k}_wr_addr_d1 = bank${j}_wr_addr_d1[9 -1 -1:0];
//: wire[64 -1:0] bank${j}_ram${k}_wr_data_d1 = bank${j}_wr_data_d1;
//: )
//: }
//: if((1==1)||(1==3)||(1==5)){
//: print qq(
//: wire[9 -1 -1:0] bank${j}_ram${k}_wr_addr_d1 = bank${j}_wr_addr_d1[9 -1:1];
//: wire[64 -1:0] bank${j}_ram${k}_wr_data_d1 = bank${j}_wr_data_d1;
//: )
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire[9 -1 -1:0] bank0_ram0_wr_addr_d1 = bank0_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank0_ram0_wr_data_d1 = bank0_wr_data_d1;

wire[9 -1 -1:0] bank0_ram1_wr_addr_d1 = bank0_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank0_ram1_wr_data_d1 = bank0_wr_data_d1;

wire[9 -1 -1:0] bank1_ram0_wr_addr_d1 = bank1_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank1_ram0_wr_data_d1 = bank1_wr_data_d1;

wire[9 -1 -1:0] bank1_ram1_wr_addr_d1 = bank1_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank1_ram1_wr_data_d1 = bank1_wr_data_d1;

wire[9 -1 -1:0] bank2_ram0_wr_addr_d1 = bank2_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank2_ram0_wr_data_d1 = bank2_wr_data_d1;

wire[9 -1 -1:0] bank2_ram1_wr_addr_d1 = bank2_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank2_ram1_wr_data_d1 = bank2_wr_data_d1;

wire[9 -1 -1:0] bank3_ram0_wr_addr_d1 = bank3_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank3_ram0_wr_data_d1 = bank3_wr_data_d1;

wire[9 -1 -1:0] bank3_ram1_wr_addr_d1 = bank3_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank3_ram1_wr_data_d1 = bank3_wr_data_d1;

wire[9 -1 -1:0] bank4_ram0_wr_addr_d1 = bank4_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank4_ram0_wr_data_d1 = bank4_wr_data_d1;

wire[9 -1 -1:0] bank4_ram1_wr_addr_d1 = bank4_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank4_ram1_wr_data_d1 = bank4_wr_data_d1;

wire[9 -1 -1:0] bank5_ram0_wr_addr_d1 = bank5_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank5_ram0_wr_data_d1 = bank5_wr_data_d1;

wire[9 -1 -1:0] bank5_ram1_wr_addr_d1 = bank5_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank5_ram1_wr_data_d1 = bank5_wr_data_d1;

wire[9 -1 -1:0] bank6_ram0_wr_addr_d1 = bank6_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank6_ram0_wr_data_d1 = bank6_wr_data_d1;

wire[9 -1 -1:0] bank6_ram1_wr_addr_d1 = bank6_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank6_ram1_wr_data_d1 = bank6_wr_data_d1;

wire[9 -1 -1:0] bank7_ram0_wr_addr_d1 = bank7_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank7_ram0_wr_data_d1 = bank7_wr_data_d1;

wire[9 -1 -1:0] bank7_ram1_wr_addr_d1 = bank7_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank7_ram1_wr_data_d1 = bank7_wr_data_d1;

wire[9 -1 -1:0] bank8_ram0_wr_addr_d1 = bank8_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank8_ram0_wr_data_d1 = bank8_wr_data_d1;

wire[9 -1 -1:0] bank8_ram1_wr_addr_d1 = bank8_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank8_ram1_wr_data_d1 = bank8_wr_data_d1;

wire[9 -1 -1:0] bank9_ram0_wr_addr_d1 = bank9_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank9_ram0_wr_data_d1 = bank9_wr_data_d1;

wire[9 -1 -1:0] bank9_ram1_wr_addr_d1 = bank9_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank9_ram1_wr_data_d1 = bank9_wr_data_d1;

wire[9 -1 -1:0] bank10_ram0_wr_addr_d1 = bank10_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank10_ram0_wr_data_d1 = bank10_wr_data_d1;

wire[9 -1 -1:0] bank10_ram1_wr_addr_d1 = bank10_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank10_ram1_wr_data_d1 = bank10_wr_data_d1;

wire[9 -1 -1:0] bank11_ram0_wr_addr_d1 = bank11_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank11_ram0_wr_data_d1 = bank11_wr_data_d1;

wire[9 -1 -1:0] bank11_ram1_wr_addr_d1 = bank11_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank11_ram1_wr_data_d1 = bank11_wr_data_d1;

wire[9 -1 -1:0] bank12_ram0_wr_addr_d1 = bank12_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank12_ram0_wr_data_d1 = bank12_wr_data_d1;

wire[9 -1 -1:0] bank12_ram1_wr_addr_d1 = bank12_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank12_ram1_wr_data_d1 = bank12_wr_data_d1;

wire[9 -1 -1:0] bank13_ram0_wr_addr_d1 = bank13_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank13_ram0_wr_data_d1 = bank13_wr_data_d1;

wire[9 -1 -1:0] bank13_ram1_wr_addr_d1 = bank13_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank13_ram1_wr_data_d1 = bank13_wr_data_d1;

wire[9 -1 -1:0] bank14_ram0_wr_addr_d1 = bank14_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank14_ram0_wr_data_d1 = bank14_wr_data_d1;

wire[9 -1 -1:0] bank14_ram1_wr_addr_d1 = bank14_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank14_ram1_wr_data_d1 = bank14_wr_data_d1;

wire[9 -1 -1:0] bank15_ram0_wr_addr_d1 = bank15_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank15_ram0_wr_data_d1 = bank15_wr_data_d1;

wire[9 -1 -1:0] bank15_ram1_wr_addr_d1 = bank15_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank15_ram1_wr_data_d1 = bank15_wr_data_d1;

wire[9 -1 -1:0] bank16_ram0_wr_addr_d1 = bank16_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank16_ram0_wr_data_d1 = bank16_wr_data_d1;

wire[9 -1 -1:0] bank16_ram1_wr_addr_d1 = bank16_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank16_ram1_wr_data_d1 = bank16_wr_data_d1;

wire[9 -1 -1:0] bank17_ram0_wr_addr_d1 = bank17_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank17_ram0_wr_data_d1 = bank17_wr_data_d1;

wire[9 -1 -1:0] bank17_ram1_wr_addr_d1 = bank17_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank17_ram1_wr_data_d1 = bank17_wr_data_d1;

wire[9 -1 -1:0] bank18_ram0_wr_addr_d1 = bank18_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank18_ram0_wr_data_d1 = bank18_wr_data_d1;

wire[9 -1 -1:0] bank18_ram1_wr_addr_d1 = bank18_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank18_ram1_wr_data_d1 = bank18_wr_data_d1;

wire[9 -1 -1:0] bank19_ram0_wr_addr_d1 = bank19_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank19_ram0_wr_data_d1 = bank19_wr_data_d1;

wire[9 -1 -1:0] bank19_ram1_wr_addr_d1 = bank19_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank19_ram1_wr_data_d1 = bank19_wr_data_d1;

wire[9 -1 -1:0] bank20_ram0_wr_addr_d1 = bank20_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank20_ram0_wr_data_d1 = bank20_wr_data_d1;

wire[9 -1 -1:0] bank20_ram1_wr_addr_d1 = bank20_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank20_ram1_wr_data_d1 = bank20_wr_data_d1;

wire[9 -1 -1:0] bank21_ram0_wr_addr_d1 = bank21_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank21_ram0_wr_data_d1 = bank21_wr_data_d1;

wire[9 -1 -1:0] bank21_ram1_wr_addr_d1 = bank21_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank21_ram1_wr_data_d1 = bank21_wr_data_d1;

wire[9 -1 -1:0] bank22_ram0_wr_addr_d1 = bank22_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank22_ram0_wr_data_d1 = bank22_wr_data_d1;

wire[9 -1 -1:0] bank22_ram1_wr_addr_d1 = bank22_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank22_ram1_wr_data_d1 = bank22_wr_data_d1;

wire[9 -1 -1:0] bank23_ram0_wr_addr_d1 = bank23_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank23_ram0_wr_data_d1 = bank23_wr_data_d1;

wire[9 -1 -1:0] bank23_ram1_wr_addr_d1 = bank23_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank23_ram1_wr_data_d1 = bank23_wr_data_d1;

wire[9 -1 -1:0] bank24_ram0_wr_addr_d1 = bank24_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank24_ram0_wr_data_d1 = bank24_wr_data_d1;

wire[9 -1 -1:0] bank24_ram1_wr_addr_d1 = bank24_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank24_ram1_wr_data_d1 = bank24_wr_data_d1;

wire[9 -1 -1:0] bank25_ram0_wr_addr_d1 = bank25_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank25_ram0_wr_data_d1 = bank25_wr_data_d1;

wire[9 -1 -1:0] bank25_ram1_wr_addr_d1 = bank25_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank25_ram1_wr_data_d1 = bank25_wr_data_d1;

wire[9 -1 -1:0] bank26_ram0_wr_addr_d1 = bank26_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank26_ram0_wr_data_d1 = bank26_wr_data_d1;

wire[9 -1 -1:0] bank26_ram1_wr_addr_d1 = bank26_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank26_ram1_wr_data_d1 = bank26_wr_data_d1;

wire[9 -1 -1:0] bank27_ram0_wr_addr_d1 = bank27_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank27_ram0_wr_data_d1 = bank27_wr_data_d1;

wire[9 -1 -1:0] bank27_ram1_wr_addr_d1 = bank27_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank27_ram1_wr_data_d1 = bank27_wr_data_d1;

wire[9 -1 -1:0] bank28_ram0_wr_addr_d1 = bank28_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank28_ram0_wr_data_d1 = bank28_wr_data_d1;

wire[9 -1 -1:0] bank28_ram1_wr_addr_d1 = bank28_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank28_ram1_wr_data_d1 = bank28_wr_data_d1;

wire[9 -1 -1:0] bank29_ram0_wr_addr_d1 = bank29_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank29_ram0_wr_data_d1 = bank29_wr_data_d1;

wire[9 -1 -1:0] bank29_ram1_wr_addr_d1 = bank29_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank29_ram1_wr_data_d1 = bank29_wr_data_d1;

wire[9 -1 -1:0] bank30_ram0_wr_addr_d1 = bank30_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank30_ram0_wr_data_d1 = bank30_wr_data_d1;

wire[9 -1 -1:0] bank30_ram1_wr_addr_d1 = bank30_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank30_ram1_wr_data_d1 = bank30_wr_data_d1;

wire[9 -1 -1:0] bank31_ram0_wr_addr_d1 = bank31_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank31_ram0_wr_data_d1 = bank31_wr_data_d1;

wire[9 -1 -1:0] bank31_ram1_wr_addr_d1 = bank31_wr_addr_d1[9 -1:1];
wire[64 -1:0] bank31_ram1_wr_data_d1 = bank31_wr_data_d1;

//| eperl: generated_end (DO NOT EDIT ABOVE)
// 1 pipe before write to sram, for timing
//: my $kk=9 -1;
//: my $jj=64;
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: &eperl::flop("-q bank${j}_ram${k}_wr_en_d2 -d bank${j}_ram${k}_wr_en_d1");
//: &eperl::flop("-wid ${kk} -q bank${j}_ram${k}_wr_addr_d2 -d bank${j}_ram${k}_wr_addr_d1");
//: &eperl::flop("-wid ${jj} -norst -q bank${j}_ram${k}_wr_data_d2 -d bank${j}_ram${k}_wr_data_d1");
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  bank0_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank0_ram0_wr_en_d2 <= bank0_ram0_wr_en_d1;
   end
end
reg [7:0] bank0_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank0_ram0_wr_addr_d2 <= bank0_ram0_wr_addr_d1;
   end
end
reg [63:0] bank0_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank0_ram0_wr_data_d2 <= bank0_ram0_wr_data_d1;
end
reg  bank0_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank0_ram1_wr_en_d2 <= bank0_ram1_wr_en_d1;
   end
end
reg [7:0] bank0_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank0_ram1_wr_addr_d2 <= bank0_ram1_wr_addr_d1;
   end
end
reg [63:0] bank0_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank0_ram1_wr_data_d2 <= bank0_ram1_wr_data_d1;
end
reg  bank1_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank1_ram0_wr_en_d2 <= bank1_ram0_wr_en_d1;
   end
end
reg [7:0] bank1_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank1_ram0_wr_addr_d2 <= bank1_ram0_wr_addr_d1;
   end
end
reg [63:0] bank1_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank1_ram0_wr_data_d2 <= bank1_ram0_wr_data_d1;
end
reg  bank1_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank1_ram1_wr_en_d2 <= bank1_ram1_wr_en_d1;
   end
end
reg [7:0] bank1_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank1_ram1_wr_addr_d2 <= bank1_ram1_wr_addr_d1;
   end
end
reg [63:0] bank1_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank1_ram1_wr_data_d2 <= bank1_ram1_wr_data_d1;
end
reg  bank2_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank2_ram0_wr_en_d2 <= bank2_ram0_wr_en_d1;
   end
end
reg [7:0] bank2_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank2_ram0_wr_addr_d2 <= bank2_ram0_wr_addr_d1;
   end
end
reg [63:0] bank2_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank2_ram0_wr_data_d2 <= bank2_ram0_wr_data_d1;
end
reg  bank2_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank2_ram1_wr_en_d2 <= bank2_ram1_wr_en_d1;
   end
end
reg [7:0] bank2_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank2_ram1_wr_addr_d2 <= bank2_ram1_wr_addr_d1;
   end
end
reg [63:0] bank2_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank2_ram1_wr_data_d2 <= bank2_ram1_wr_data_d1;
end
reg  bank3_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank3_ram0_wr_en_d2 <= bank3_ram0_wr_en_d1;
   end
end
reg [7:0] bank3_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank3_ram0_wr_addr_d2 <= bank3_ram0_wr_addr_d1;
   end
end
reg [63:0] bank3_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank3_ram0_wr_data_d2 <= bank3_ram0_wr_data_d1;
end
reg  bank3_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank3_ram1_wr_en_d2 <= bank3_ram1_wr_en_d1;
   end
end
reg [7:0] bank3_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank3_ram1_wr_addr_d2 <= bank3_ram1_wr_addr_d1;
   end
end
reg [63:0] bank3_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank3_ram1_wr_data_d2 <= bank3_ram1_wr_data_d1;
end
reg  bank4_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank4_ram0_wr_en_d2 <= bank4_ram0_wr_en_d1;
   end
end
reg [7:0] bank4_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank4_ram0_wr_addr_d2 <= bank4_ram0_wr_addr_d1;
   end
end
reg [63:0] bank4_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank4_ram0_wr_data_d2 <= bank4_ram0_wr_data_d1;
end
reg  bank4_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank4_ram1_wr_en_d2 <= bank4_ram1_wr_en_d1;
   end
end
reg [7:0] bank4_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank4_ram1_wr_addr_d2 <= bank4_ram1_wr_addr_d1;
   end
end
reg [63:0] bank4_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank4_ram1_wr_data_d2 <= bank4_ram1_wr_data_d1;
end
reg  bank5_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank5_ram0_wr_en_d2 <= bank5_ram0_wr_en_d1;
   end
end
reg [7:0] bank5_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank5_ram0_wr_addr_d2 <= bank5_ram0_wr_addr_d1;
   end
end
reg [63:0] bank5_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank5_ram0_wr_data_d2 <= bank5_ram0_wr_data_d1;
end
reg  bank5_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank5_ram1_wr_en_d2 <= bank5_ram1_wr_en_d1;
   end
end
reg [7:0] bank5_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank5_ram1_wr_addr_d2 <= bank5_ram1_wr_addr_d1;
   end
end
reg [63:0] bank5_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank5_ram1_wr_data_d2 <= bank5_ram1_wr_data_d1;
end
reg  bank6_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank6_ram0_wr_en_d2 <= bank6_ram0_wr_en_d1;
   end
end
reg [7:0] bank6_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank6_ram0_wr_addr_d2 <= bank6_ram0_wr_addr_d1;
   end
end
reg [63:0] bank6_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank6_ram0_wr_data_d2 <= bank6_ram0_wr_data_d1;
end
reg  bank6_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank6_ram1_wr_en_d2 <= bank6_ram1_wr_en_d1;
   end
end
reg [7:0] bank6_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank6_ram1_wr_addr_d2 <= bank6_ram1_wr_addr_d1;
   end
end
reg [63:0] bank6_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank6_ram1_wr_data_d2 <= bank6_ram1_wr_data_d1;
end
reg  bank7_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank7_ram0_wr_en_d2 <= bank7_ram0_wr_en_d1;
   end
end
reg [7:0] bank7_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank7_ram0_wr_addr_d2 <= bank7_ram0_wr_addr_d1;
   end
end
reg [63:0] bank7_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank7_ram0_wr_data_d2 <= bank7_ram0_wr_data_d1;
end
reg  bank7_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank7_ram1_wr_en_d2 <= bank7_ram1_wr_en_d1;
   end
end
reg [7:0] bank7_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank7_ram1_wr_addr_d2 <= bank7_ram1_wr_addr_d1;
   end
end
reg [63:0] bank7_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank7_ram1_wr_data_d2 <= bank7_ram1_wr_data_d1;
end
reg  bank8_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank8_ram0_wr_en_d2 <= bank8_ram0_wr_en_d1;
   end
end
reg [7:0] bank8_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank8_ram0_wr_addr_d2 <= bank8_ram0_wr_addr_d1;
   end
end
reg [63:0] bank8_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank8_ram0_wr_data_d2 <= bank8_ram0_wr_data_d1;
end
reg  bank8_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank8_ram1_wr_en_d2 <= bank8_ram1_wr_en_d1;
   end
end
reg [7:0] bank8_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank8_ram1_wr_addr_d2 <= bank8_ram1_wr_addr_d1;
   end
end
reg [63:0] bank8_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank8_ram1_wr_data_d2 <= bank8_ram1_wr_data_d1;
end
reg  bank9_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank9_ram0_wr_en_d2 <= bank9_ram0_wr_en_d1;
   end
end
reg [7:0] bank9_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank9_ram0_wr_addr_d2 <= bank9_ram0_wr_addr_d1;
   end
end
reg [63:0] bank9_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank9_ram0_wr_data_d2 <= bank9_ram0_wr_data_d1;
end
reg  bank9_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank9_ram1_wr_en_d2 <= bank9_ram1_wr_en_d1;
   end
end
reg [7:0] bank9_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank9_ram1_wr_addr_d2 <= bank9_ram1_wr_addr_d1;
   end
end
reg [63:0] bank9_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank9_ram1_wr_data_d2 <= bank9_ram1_wr_data_d1;
end
reg  bank10_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank10_ram0_wr_en_d2 <= bank10_ram0_wr_en_d1;
   end
end
reg [7:0] bank10_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank10_ram0_wr_addr_d2 <= bank10_ram0_wr_addr_d1;
   end
end
reg [63:0] bank10_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank10_ram0_wr_data_d2 <= bank10_ram0_wr_data_d1;
end
reg  bank10_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank10_ram1_wr_en_d2 <= bank10_ram1_wr_en_d1;
   end
end
reg [7:0] bank10_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank10_ram1_wr_addr_d2 <= bank10_ram1_wr_addr_d1;
   end
end
reg [63:0] bank10_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank10_ram1_wr_data_d2 <= bank10_ram1_wr_data_d1;
end
reg  bank11_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank11_ram0_wr_en_d2 <= bank11_ram0_wr_en_d1;
   end
end
reg [7:0] bank11_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank11_ram0_wr_addr_d2 <= bank11_ram0_wr_addr_d1;
   end
end
reg [63:0] bank11_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank11_ram0_wr_data_d2 <= bank11_ram0_wr_data_d1;
end
reg  bank11_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank11_ram1_wr_en_d2 <= bank11_ram1_wr_en_d1;
   end
end
reg [7:0] bank11_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank11_ram1_wr_addr_d2 <= bank11_ram1_wr_addr_d1;
   end
end
reg [63:0] bank11_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank11_ram1_wr_data_d2 <= bank11_ram1_wr_data_d1;
end
reg  bank12_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank12_ram0_wr_en_d2 <= bank12_ram0_wr_en_d1;
   end
end
reg [7:0] bank12_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank12_ram0_wr_addr_d2 <= bank12_ram0_wr_addr_d1;
   end
end
reg [63:0] bank12_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank12_ram0_wr_data_d2 <= bank12_ram0_wr_data_d1;
end
reg  bank12_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank12_ram1_wr_en_d2 <= bank12_ram1_wr_en_d1;
   end
end
reg [7:0] bank12_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank12_ram1_wr_addr_d2 <= bank12_ram1_wr_addr_d1;
   end
end
reg [63:0] bank12_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank12_ram1_wr_data_d2 <= bank12_ram1_wr_data_d1;
end
reg  bank13_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank13_ram0_wr_en_d2 <= bank13_ram0_wr_en_d1;
   end
end
reg [7:0] bank13_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank13_ram0_wr_addr_d2 <= bank13_ram0_wr_addr_d1;
   end
end
reg [63:0] bank13_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank13_ram0_wr_data_d2 <= bank13_ram0_wr_data_d1;
end
reg  bank13_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank13_ram1_wr_en_d2 <= bank13_ram1_wr_en_d1;
   end
end
reg [7:0] bank13_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank13_ram1_wr_addr_d2 <= bank13_ram1_wr_addr_d1;
   end
end
reg [63:0] bank13_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank13_ram1_wr_data_d2 <= bank13_ram1_wr_data_d1;
end
reg  bank14_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank14_ram0_wr_en_d2 <= bank14_ram0_wr_en_d1;
   end
end
reg [7:0] bank14_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank14_ram0_wr_addr_d2 <= bank14_ram0_wr_addr_d1;
   end
end
reg [63:0] bank14_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank14_ram0_wr_data_d2 <= bank14_ram0_wr_data_d1;
end
reg  bank14_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank14_ram1_wr_en_d2 <= bank14_ram1_wr_en_d1;
   end
end
reg [7:0] bank14_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank14_ram1_wr_addr_d2 <= bank14_ram1_wr_addr_d1;
   end
end
reg [63:0] bank14_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank14_ram1_wr_data_d2 <= bank14_ram1_wr_data_d1;
end
reg  bank15_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank15_ram0_wr_en_d2 <= bank15_ram0_wr_en_d1;
   end
end
reg [7:0] bank15_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank15_ram0_wr_addr_d2 <= bank15_ram0_wr_addr_d1;
   end
end
reg [63:0] bank15_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank15_ram0_wr_data_d2 <= bank15_ram0_wr_data_d1;
end
reg  bank15_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank15_ram1_wr_en_d2 <= bank15_ram1_wr_en_d1;
   end
end
reg [7:0] bank15_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank15_ram1_wr_addr_d2 <= bank15_ram1_wr_addr_d1;
   end
end
reg [63:0] bank15_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank15_ram1_wr_data_d2 <= bank15_ram1_wr_data_d1;
end
reg  bank16_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank16_ram0_wr_en_d2 <= bank16_ram0_wr_en_d1;
   end
end
reg [7:0] bank16_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank16_ram0_wr_addr_d2 <= bank16_ram0_wr_addr_d1;
   end
end
reg [63:0] bank16_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank16_ram0_wr_data_d2 <= bank16_ram0_wr_data_d1;
end
reg  bank16_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank16_ram1_wr_en_d2 <= bank16_ram1_wr_en_d1;
   end
end
reg [7:0] bank16_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank16_ram1_wr_addr_d2 <= bank16_ram1_wr_addr_d1;
   end
end
reg [63:0] bank16_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank16_ram1_wr_data_d2 <= bank16_ram1_wr_data_d1;
end
reg  bank17_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank17_ram0_wr_en_d2 <= bank17_ram0_wr_en_d1;
   end
end
reg [7:0] bank17_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank17_ram0_wr_addr_d2 <= bank17_ram0_wr_addr_d1;
   end
end
reg [63:0] bank17_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank17_ram0_wr_data_d2 <= bank17_ram0_wr_data_d1;
end
reg  bank17_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank17_ram1_wr_en_d2 <= bank17_ram1_wr_en_d1;
   end
end
reg [7:0] bank17_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank17_ram1_wr_addr_d2 <= bank17_ram1_wr_addr_d1;
   end
end
reg [63:0] bank17_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank17_ram1_wr_data_d2 <= bank17_ram1_wr_data_d1;
end
reg  bank18_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank18_ram0_wr_en_d2 <= bank18_ram0_wr_en_d1;
   end
end
reg [7:0] bank18_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank18_ram0_wr_addr_d2 <= bank18_ram0_wr_addr_d1;
   end
end
reg [63:0] bank18_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank18_ram0_wr_data_d2 <= bank18_ram0_wr_data_d1;
end
reg  bank18_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank18_ram1_wr_en_d2 <= bank18_ram1_wr_en_d1;
   end
end
reg [7:0] bank18_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank18_ram1_wr_addr_d2 <= bank18_ram1_wr_addr_d1;
   end
end
reg [63:0] bank18_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank18_ram1_wr_data_d2 <= bank18_ram1_wr_data_d1;
end
reg  bank19_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank19_ram0_wr_en_d2 <= bank19_ram0_wr_en_d1;
   end
end
reg [7:0] bank19_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank19_ram0_wr_addr_d2 <= bank19_ram0_wr_addr_d1;
   end
end
reg [63:0] bank19_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank19_ram0_wr_data_d2 <= bank19_ram0_wr_data_d1;
end
reg  bank19_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank19_ram1_wr_en_d2 <= bank19_ram1_wr_en_d1;
   end
end
reg [7:0] bank19_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank19_ram1_wr_addr_d2 <= bank19_ram1_wr_addr_d1;
   end
end
reg [63:0] bank19_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank19_ram1_wr_data_d2 <= bank19_ram1_wr_data_d1;
end
reg  bank20_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank20_ram0_wr_en_d2 <= bank20_ram0_wr_en_d1;
   end
end
reg [7:0] bank20_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank20_ram0_wr_addr_d2 <= bank20_ram0_wr_addr_d1;
   end
end
reg [63:0] bank20_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank20_ram0_wr_data_d2 <= bank20_ram0_wr_data_d1;
end
reg  bank20_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank20_ram1_wr_en_d2 <= bank20_ram1_wr_en_d1;
   end
end
reg [7:0] bank20_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank20_ram1_wr_addr_d2 <= bank20_ram1_wr_addr_d1;
   end
end
reg [63:0] bank20_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank20_ram1_wr_data_d2 <= bank20_ram1_wr_data_d1;
end
reg  bank21_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank21_ram0_wr_en_d2 <= bank21_ram0_wr_en_d1;
   end
end
reg [7:0] bank21_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank21_ram0_wr_addr_d2 <= bank21_ram0_wr_addr_d1;
   end
end
reg [63:0] bank21_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank21_ram0_wr_data_d2 <= bank21_ram0_wr_data_d1;
end
reg  bank21_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank21_ram1_wr_en_d2 <= bank21_ram1_wr_en_d1;
   end
end
reg [7:0] bank21_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank21_ram1_wr_addr_d2 <= bank21_ram1_wr_addr_d1;
   end
end
reg [63:0] bank21_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank21_ram1_wr_data_d2 <= bank21_ram1_wr_data_d1;
end
reg  bank22_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank22_ram0_wr_en_d2 <= bank22_ram0_wr_en_d1;
   end
end
reg [7:0] bank22_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank22_ram0_wr_addr_d2 <= bank22_ram0_wr_addr_d1;
   end
end
reg [63:0] bank22_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank22_ram0_wr_data_d2 <= bank22_ram0_wr_data_d1;
end
reg  bank22_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank22_ram1_wr_en_d2 <= bank22_ram1_wr_en_d1;
   end
end
reg [7:0] bank22_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank22_ram1_wr_addr_d2 <= bank22_ram1_wr_addr_d1;
   end
end
reg [63:0] bank22_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank22_ram1_wr_data_d2 <= bank22_ram1_wr_data_d1;
end
reg  bank23_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank23_ram0_wr_en_d2 <= bank23_ram0_wr_en_d1;
   end
end
reg [7:0] bank23_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank23_ram0_wr_addr_d2 <= bank23_ram0_wr_addr_d1;
   end
end
reg [63:0] bank23_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank23_ram0_wr_data_d2 <= bank23_ram0_wr_data_d1;
end
reg  bank23_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank23_ram1_wr_en_d2 <= bank23_ram1_wr_en_d1;
   end
end
reg [7:0] bank23_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank23_ram1_wr_addr_d2 <= bank23_ram1_wr_addr_d1;
   end
end
reg [63:0] bank23_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank23_ram1_wr_data_d2 <= bank23_ram1_wr_data_d1;
end
reg  bank24_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank24_ram0_wr_en_d2 <= bank24_ram0_wr_en_d1;
   end
end
reg [7:0] bank24_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank24_ram0_wr_addr_d2 <= bank24_ram0_wr_addr_d1;
   end
end
reg [63:0] bank24_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank24_ram0_wr_data_d2 <= bank24_ram0_wr_data_d1;
end
reg  bank24_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank24_ram1_wr_en_d2 <= bank24_ram1_wr_en_d1;
   end
end
reg [7:0] bank24_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank24_ram1_wr_addr_d2 <= bank24_ram1_wr_addr_d1;
   end
end
reg [63:0] bank24_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank24_ram1_wr_data_d2 <= bank24_ram1_wr_data_d1;
end
reg  bank25_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank25_ram0_wr_en_d2 <= bank25_ram0_wr_en_d1;
   end
end
reg [7:0] bank25_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank25_ram0_wr_addr_d2 <= bank25_ram0_wr_addr_d1;
   end
end
reg [63:0] bank25_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank25_ram0_wr_data_d2 <= bank25_ram0_wr_data_d1;
end
reg  bank25_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank25_ram1_wr_en_d2 <= bank25_ram1_wr_en_d1;
   end
end
reg [7:0] bank25_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank25_ram1_wr_addr_d2 <= bank25_ram1_wr_addr_d1;
   end
end
reg [63:0] bank25_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank25_ram1_wr_data_d2 <= bank25_ram1_wr_data_d1;
end
reg  bank26_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank26_ram0_wr_en_d2 <= bank26_ram0_wr_en_d1;
   end
end
reg [7:0] bank26_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank26_ram0_wr_addr_d2 <= bank26_ram0_wr_addr_d1;
   end
end
reg [63:0] bank26_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank26_ram0_wr_data_d2 <= bank26_ram0_wr_data_d1;
end
reg  bank26_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank26_ram1_wr_en_d2 <= bank26_ram1_wr_en_d1;
   end
end
reg [7:0] bank26_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank26_ram1_wr_addr_d2 <= bank26_ram1_wr_addr_d1;
   end
end
reg [63:0] bank26_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank26_ram1_wr_data_d2 <= bank26_ram1_wr_data_d1;
end
reg  bank27_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank27_ram0_wr_en_d2 <= bank27_ram0_wr_en_d1;
   end
end
reg [7:0] bank27_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank27_ram0_wr_addr_d2 <= bank27_ram0_wr_addr_d1;
   end
end
reg [63:0] bank27_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank27_ram0_wr_data_d2 <= bank27_ram0_wr_data_d1;
end
reg  bank27_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank27_ram1_wr_en_d2 <= bank27_ram1_wr_en_d1;
   end
end
reg [7:0] bank27_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank27_ram1_wr_addr_d2 <= bank27_ram1_wr_addr_d1;
   end
end
reg [63:0] bank27_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank27_ram1_wr_data_d2 <= bank27_ram1_wr_data_d1;
end
reg  bank28_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank28_ram0_wr_en_d2 <= bank28_ram0_wr_en_d1;
   end
end
reg [7:0] bank28_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank28_ram0_wr_addr_d2 <= bank28_ram0_wr_addr_d1;
   end
end
reg [63:0] bank28_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank28_ram0_wr_data_d2 <= bank28_ram0_wr_data_d1;
end
reg  bank28_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank28_ram1_wr_en_d2 <= bank28_ram1_wr_en_d1;
   end
end
reg [7:0] bank28_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank28_ram1_wr_addr_d2 <= bank28_ram1_wr_addr_d1;
   end
end
reg [63:0] bank28_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank28_ram1_wr_data_d2 <= bank28_ram1_wr_data_d1;
end
reg  bank29_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank29_ram0_wr_en_d2 <= bank29_ram0_wr_en_d1;
   end
end
reg [7:0] bank29_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank29_ram0_wr_addr_d2 <= bank29_ram0_wr_addr_d1;
   end
end
reg [63:0] bank29_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank29_ram0_wr_data_d2 <= bank29_ram0_wr_data_d1;
end
reg  bank29_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank29_ram1_wr_en_d2 <= bank29_ram1_wr_en_d1;
   end
end
reg [7:0] bank29_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank29_ram1_wr_addr_d2 <= bank29_ram1_wr_addr_d1;
   end
end
reg [63:0] bank29_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank29_ram1_wr_data_d2 <= bank29_ram1_wr_data_d1;
end
reg  bank30_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank30_ram0_wr_en_d2 <= bank30_ram0_wr_en_d1;
   end
end
reg [7:0] bank30_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank30_ram0_wr_addr_d2 <= bank30_ram0_wr_addr_d1;
   end
end
reg [63:0] bank30_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank30_ram0_wr_data_d2 <= bank30_ram0_wr_data_d1;
end
reg  bank30_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank30_ram1_wr_en_d2 <= bank30_ram1_wr_en_d1;
   end
end
reg [7:0] bank30_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank30_ram1_wr_addr_d2 <= bank30_ram1_wr_addr_d1;
   end
end
reg [63:0] bank30_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank30_ram1_wr_data_d2 <= bank30_ram1_wr_data_d1;
end
reg  bank31_ram0_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_wr_en_d2 <= 'b0;
   end else begin
       bank31_ram0_wr_en_d2 <= bank31_ram0_wr_en_d1;
   end
end
reg [7:0] bank31_ram0_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_wr_addr_d2 <= 'b0;
   end else begin
       bank31_ram0_wr_addr_d2 <= bank31_ram0_wr_addr_d1;
   end
end
reg [63:0] bank31_ram0_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank31_ram0_wr_data_d2 <= bank31_ram0_wr_data_d1;
end
reg  bank31_ram1_wr_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_wr_en_d2 <= 'b0;
   end else begin
       bank31_ram1_wr_en_d2 <= bank31_ram1_wr_en_d1;
   end
end
reg [7:0] bank31_ram1_wr_addr_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_wr_addr_d2 <= 'b0;
   end else begin
       bank31_ram1_wr_addr_d2 <= bank31_ram1_wr_addr_d1;
   end
end
reg [63:0] bank31_ram1_wr_data_d2;
always @(posedge nvdla_core_clk) begin
       bank31_ram1_wr_data_d2 <= bank31_ram1_wr_data_d1;
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////step2: read data handle
//decode read data address to sram.
wire sc2buf_dat_rd_en0 = sc2buf_dat_rd_en;
wire sc2buf_dat_rd_en1 = sc2buf_dat_rd_en & sc2buf_dat_rd_next1_en;
wire[14 -1:0] sc2buf_dat_rd_addr0 = sc2buf_dat_rd_addr;
wire[14 -1:0] sc2buf_dat_rd_addr1 = sc2buf_dat_rd_next1_addr;
//: my $bank_slice= "13:9"; #address part for select bank
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: my $kdiv2 = int($k/2);
//: my $kdiv4 = int($k/4);
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire bank${j}_ram${k}_data_rd_en = sc2buf_dat_rd_en&&(sc2buf_dat_rd_addr[${bank_slice}]==${j}); );
//: }
//: for(my $i=0; $i<2; $i++){
//: if(1==1){
//: print qq(
//: wire bank${j}_ram${k}_data_rd${i}_en = sc2buf_dat_rd_en${i}&&(sc2buf_dat_rd_addr${i}[${bank_slice}]==${j})&&(sc2buf_dat_rd_addr${i}[0]==${k}); );
//: }
//: if(1==3){
//: print qq(
//: wire bank${j}_ram${k}_data_rd${i}_en = sc2buf_dat_rd_en${i}&&(sc2buf_dat_rd_addr${i}[${bank_slice}]==${j})&&(sc2buf_dat_rd_addr${i}[0]==${kdiv2}); );
//: }
//: if(1==5){
//: print qq(
//: wire bank${j}_ram${k}_data_rd${i}_en = sc2buf_dat_rd_en${i}&&(sc2buf_dat_rd_addr${i}[${bank_slice}]==${j})&&(sc2buf_dat_rd_addr${i}[0]==${kdiv4}); );
//: }
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire bank0_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==0)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank0_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==0)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank0_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==0)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank0_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==0)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank1_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==1)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank1_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==1)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank1_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==1)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank1_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==1)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank2_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==2)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank2_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==2)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank2_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==2)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank2_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==2)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank3_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==3)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank3_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==3)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank3_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==3)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank3_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==3)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank4_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==4)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank4_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==4)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank4_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==4)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank4_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==4)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank5_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==5)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank5_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==5)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank5_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==5)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank5_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==5)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank6_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==6)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank6_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==6)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank6_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==6)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank6_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==6)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank7_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==7)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank7_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==7)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank7_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==7)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank7_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==7)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank8_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==8)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank8_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==8)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank8_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==8)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank8_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==8)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank9_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==9)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank9_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==9)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank9_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==9)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank9_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==9)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank10_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==10)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank10_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==10)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank10_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==10)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank10_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==10)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank11_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==11)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank11_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==11)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank11_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==11)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank11_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==11)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank12_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==12)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank12_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==12)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank12_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==12)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank12_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==12)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank13_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==13)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank13_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==13)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank13_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==13)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank13_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==13)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank14_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==14)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank14_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==14)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank14_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==14)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank14_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==14)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank15_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==15)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank15_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==15)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank15_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==15)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank15_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==15)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank16_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==16)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank16_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==16)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank16_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==16)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank16_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==16)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank17_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==17)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank17_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==17)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank17_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==17)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank17_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==17)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank18_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==18)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank18_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==18)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank18_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==18)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank18_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==18)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank19_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==19)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank19_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==19)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank19_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==19)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank19_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==19)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank20_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==20)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank20_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==20)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank20_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==20)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank20_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==20)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank21_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==21)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank21_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==21)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank21_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==21)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank21_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==21)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank22_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==22)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank22_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==22)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank22_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==22)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank22_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==22)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank23_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==23)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank23_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==23)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank23_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==23)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank23_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==23)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank24_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==24)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank24_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==24)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank24_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==24)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank24_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==24)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank25_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==25)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank25_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==25)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank25_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==25)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank25_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==25)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank26_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==26)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank26_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==26)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank26_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==26)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank26_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==26)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank27_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==27)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank27_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==27)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank27_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==27)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank27_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==27)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank28_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==28)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank28_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==28)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank28_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==28)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank28_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==28)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank29_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==29)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank29_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==29)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank29_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==29)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank29_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==29)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank30_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==30)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank30_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==30)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank30_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==30)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank30_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==30)&&(sc2buf_dat_rd_addr1[0]==1); 
wire bank31_ram0_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==31)&&(sc2buf_dat_rd_addr0[0]==0); 
wire bank31_ram0_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==31)&&(sc2buf_dat_rd_addr1[0]==0); 
wire bank31_ram1_data_rd0_en = sc2buf_dat_rd_en0&&(sc2buf_dat_rd_addr0[13:9]==31)&&(sc2buf_dat_rd_addr0[0]==1); 
wire bank31_ram1_data_rd1_en = sc2buf_dat_rd_en1&&(sc2buf_dat_rd_addr1[13:9]==31)&&(sc2buf_dat_rd_addr1[0]==1); 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sram data read address.
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire [9 -1 -1:0] bank${j}_ram${k}_data_rd_addr = {9 -1{bank${j}_ram${k}_data_rd_en}}&(sc2buf_dat_rd_addr[9 -1 -1:0]); );
//: }
//: for(my $i=0; $i<2; $i++){
//: if((1==1)||(1==3)||(1==5)){
//: print qq(
//: wire [9 -1 -1:0] bank${j}_ram${k}_data_rd${i}_addr = {9 -1{bank${j}_ram${k}_data_rd${i}_en}}&(sc2buf_dat_rd_addr${i}[9 -1:1]); );
//: }
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [9 -1 -1:0] bank0_ram0_data_rd0_addr = {9 -1{bank0_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank0_ram0_data_rd1_addr = {9 -1{bank0_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank0_ram1_data_rd0_addr = {9 -1{bank0_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank0_ram1_data_rd1_addr = {9 -1{bank0_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank1_ram0_data_rd0_addr = {9 -1{bank1_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank1_ram0_data_rd1_addr = {9 -1{bank1_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank1_ram1_data_rd0_addr = {9 -1{bank1_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank1_ram1_data_rd1_addr = {9 -1{bank1_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank2_ram0_data_rd0_addr = {9 -1{bank2_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank2_ram0_data_rd1_addr = {9 -1{bank2_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank2_ram1_data_rd0_addr = {9 -1{bank2_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank2_ram1_data_rd1_addr = {9 -1{bank2_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank3_ram0_data_rd0_addr = {9 -1{bank3_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank3_ram0_data_rd1_addr = {9 -1{bank3_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank3_ram1_data_rd0_addr = {9 -1{bank3_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank3_ram1_data_rd1_addr = {9 -1{bank3_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank4_ram0_data_rd0_addr = {9 -1{bank4_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank4_ram0_data_rd1_addr = {9 -1{bank4_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank4_ram1_data_rd0_addr = {9 -1{bank4_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank4_ram1_data_rd1_addr = {9 -1{bank4_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank5_ram0_data_rd0_addr = {9 -1{bank5_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank5_ram0_data_rd1_addr = {9 -1{bank5_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank5_ram1_data_rd0_addr = {9 -1{bank5_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank5_ram1_data_rd1_addr = {9 -1{bank5_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank6_ram0_data_rd0_addr = {9 -1{bank6_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank6_ram0_data_rd1_addr = {9 -1{bank6_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank6_ram1_data_rd0_addr = {9 -1{bank6_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank6_ram1_data_rd1_addr = {9 -1{bank6_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank7_ram0_data_rd0_addr = {9 -1{bank7_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank7_ram0_data_rd1_addr = {9 -1{bank7_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank7_ram1_data_rd0_addr = {9 -1{bank7_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank7_ram1_data_rd1_addr = {9 -1{bank7_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank8_ram0_data_rd0_addr = {9 -1{bank8_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank8_ram0_data_rd1_addr = {9 -1{bank8_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank8_ram1_data_rd0_addr = {9 -1{bank8_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank8_ram1_data_rd1_addr = {9 -1{bank8_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank9_ram0_data_rd0_addr = {9 -1{bank9_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank9_ram0_data_rd1_addr = {9 -1{bank9_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank9_ram1_data_rd0_addr = {9 -1{bank9_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank9_ram1_data_rd1_addr = {9 -1{bank9_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank10_ram0_data_rd0_addr = {9 -1{bank10_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank10_ram0_data_rd1_addr = {9 -1{bank10_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank10_ram1_data_rd0_addr = {9 -1{bank10_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank10_ram1_data_rd1_addr = {9 -1{bank10_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank11_ram0_data_rd0_addr = {9 -1{bank11_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank11_ram0_data_rd1_addr = {9 -1{bank11_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank11_ram1_data_rd0_addr = {9 -1{bank11_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank11_ram1_data_rd1_addr = {9 -1{bank11_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank12_ram0_data_rd0_addr = {9 -1{bank12_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank12_ram0_data_rd1_addr = {9 -1{bank12_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank12_ram1_data_rd0_addr = {9 -1{bank12_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank12_ram1_data_rd1_addr = {9 -1{bank12_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank13_ram0_data_rd0_addr = {9 -1{bank13_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank13_ram0_data_rd1_addr = {9 -1{bank13_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank13_ram1_data_rd0_addr = {9 -1{bank13_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank13_ram1_data_rd1_addr = {9 -1{bank13_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank14_ram0_data_rd0_addr = {9 -1{bank14_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank14_ram0_data_rd1_addr = {9 -1{bank14_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank14_ram1_data_rd0_addr = {9 -1{bank14_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank14_ram1_data_rd1_addr = {9 -1{bank14_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank15_ram0_data_rd0_addr = {9 -1{bank15_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank15_ram0_data_rd1_addr = {9 -1{bank15_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank15_ram1_data_rd0_addr = {9 -1{bank15_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank15_ram1_data_rd1_addr = {9 -1{bank15_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank16_ram0_data_rd0_addr = {9 -1{bank16_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank16_ram0_data_rd1_addr = {9 -1{bank16_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank16_ram1_data_rd0_addr = {9 -1{bank16_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank16_ram1_data_rd1_addr = {9 -1{bank16_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank17_ram0_data_rd0_addr = {9 -1{bank17_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank17_ram0_data_rd1_addr = {9 -1{bank17_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank17_ram1_data_rd0_addr = {9 -1{bank17_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank17_ram1_data_rd1_addr = {9 -1{bank17_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank18_ram0_data_rd0_addr = {9 -1{bank18_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank18_ram0_data_rd1_addr = {9 -1{bank18_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank18_ram1_data_rd0_addr = {9 -1{bank18_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank18_ram1_data_rd1_addr = {9 -1{bank18_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank19_ram0_data_rd0_addr = {9 -1{bank19_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank19_ram0_data_rd1_addr = {9 -1{bank19_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank19_ram1_data_rd0_addr = {9 -1{bank19_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank19_ram1_data_rd1_addr = {9 -1{bank19_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank20_ram0_data_rd0_addr = {9 -1{bank20_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank20_ram0_data_rd1_addr = {9 -1{bank20_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank20_ram1_data_rd0_addr = {9 -1{bank20_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank20_ram1_data_rd1_addr = {9 -1{bank20_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank21_ram0_data_rd0_addr = {9 -1{bank21_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank21_ram0_data_rd1_addr = {9 -1{bank21_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank21_ram1_data_rd0_addr = {9 -1{bank21_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank21_ram1_data_rd1_addr = {9 -1{bank21_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank22_ram0_data_rd0_addr = {9 -1{bank22_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank22_ram0_data_rd1_addr = {9 -1{bank22_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank22_ram1_data_rd0_addr = {9 -1{bank22_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank22_ram1_data_rd1_addr = {9 -1{bank22_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank23_ram0_data_rd0_addr = {9 -1{bank23_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank23_ram0_data_rd1_addr = {9 -1{bank23_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank23_ram1_data_rd0_addr = {9 -1{bank23_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank23_ram1_data_rd1_addr = {9 -1{bank23_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank24_ram0_data_rd0_addr = {9 -1{bank24_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank24_ram0_data_rd1_addr = {9 -1{bank24_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank24_ram1_data_rd0_addr = {9 -1{bank24_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank24_ram1_data_rd1_addr = {9 -1{bank24_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank25_ram0_data_rd0_addr = {9 -1{bank25_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank25_ram0_data_rd1_addr = {9 -1{bank25_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank25_ram1_data_rd0_addr = {9 -1{bank25_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank25_ram1_data_rd1_addr = {9 -1{bank25_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank26_ram0_data_rd0_addr = {9 -1{bank26_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank26_ram0_data_rd1_addr = {9 -1{bank26_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank26_ram1_data_rd0_addr = {9 -1{bank26_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank26_ram1_data_rd1_addr = {9 -1{bank26_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank27_ram0_data_rd0_addr = {9 -1{bank27_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank27_ram0_data_rd1_addr = {9 -1{bank27_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank27_ram1_data_rd0_addr = {9 -1{bank27_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank27_ram1_data_rd1_addr = {9 -1{bank27_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank28_ram0_data_rd0_addr = {9 -1{bank28_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank28_ram0_data_rd1_addr = {9 -1{bank28_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank28_ram1_data_rd0_addr = {9 -1{bank28_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank28_ram1_data_rd1_addr = {9 -1{bank28_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank29_ram0_data_rd0_addr = {9 -1{bank29_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank29_ram0_data_rd1_addr = {9 -1{bank29_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank29_ram1_data_rd0_addr = {9 -1{bank29_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank29_ram1_data_rd1_addr = {9 -1{bank29_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank30_ram0_data_rd0_addr = {9 -1{bank30_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank30_ram0_data_rd1_addr = {9 -1{bank30_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank30_ram1_data_rd0_addr = {9 -1{bank30_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank30_ram1_data_rd1_addr = {9 -1{bank30_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank31_ram0_data_rd0_addr = {9 -1{bank31_ram0_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank31_ram0_data_rd1_addr = {9 -1{bank31_ram0_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
wire [9 -1 -1:0] bank31_ram1_data_rd0_addr = {9 -1{bank31_ram1_data_rd0_en}}&(sc2buf_dat_rd_addr0[9 -1:1]); 
wire [9 -1 -1:0] bank31_ram1_data_rd1_addr = {9 -1{bank31_ram1_data_rd1_en}}&(sc2buf_dat_rd_addr1[9 -1:1]); 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//add flop for sram data read en
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: if((1==0)||(1==2)||(1==4)){
//: &eperl::flop("-q bank${j}_ram${k}_data_rd_en_d1 -d  bank${j}_ram${k}_data_rd_en");
//: &eperl::flop("-q bank${j}_ram${k}_data_rd_en_d2 -d  bank${j}_ram${k}_data_rd_en_d1");
//: }
//: for(my $i=0; $i<2; $i++){
//: if((1==1)||(1==3)||(1==5)){
//: &eperl::flop("-q bank${j}_ram${k}_data_rd${i}_en_d1 -d bank${j}_ram${k}_data_rd${i}_en");
//: &eperl::flop("-q bank${j}_ram${k}_data_rd${i}_en_d2 -d bank${j}_ram${k}_data_rd${i}_en_d1");
//: }
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  bank0_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank0_ram0_data_rd0_en_d1 <= bank0_ram0_data_rd0_en;
   end
end
reg  bank0_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank0_ram0_data_rd0_en_d2 <= bank0_ram0_data_rd0_en_d1;
   end
end
reg  bank0_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank0_ram0_data_rd1_en_d1 <= bank0_ram0_data_rd1_en;
   end
end
reg  bank0_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank0_ram0_data_rd1_en_d2 <= bank0_ram0_data_rd1_en_d1;
   end
end
reg  bank0_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank0_ram1_data_rd0_en_d1 <= bank0_ram1_data_rd0_en;
   end
end
reg  bank0_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank0_ram1_data_rd0_en_d2 <= bank0_ram1_data_rd0_en_d1;
   end
end
reg  bank0_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank0_ram1_data_rd1_en_d1 <= bank0_ram1_data_rd1_en;
   end
end
reg  bank0_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank0_ram1_data_rd1_en_d2 <= bank0_ram1_data_rd1_en_d1;
   end
end
reg  bank1_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank1_ram0_data_rd0_en_d1 <= bank1_ram0_data_rd0_en;
   end
end
reg  bank1_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank1_ram0_data_rd0_en_d2 <= bank1_ram0_data_rd0_en_d1;
   end
end
reg  bank1_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank1_ram0_data_rd1_en_d1 <= bank1_ram0_data_rd1_en;
   end
end
reg  bank1_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank1_ram0_data_rd1_en_d2 <= bank1_ram0_data_rd1_en_d1;
   end
end
reg  bank1_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank1_ram1_data_rd0_en_d1 <= bank1_ram1_data_rd0_en;
   end
end
reg  bank1_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank1_ram1_data_rd0_en_d2 <= bank1_ram1_data_rd0_en_d1;
   end
end
reg  bank1_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank1_ram1_data_rd1_en_d1 <= bank1_ram1_data_rd1_en;
   end
end
reg  bank1_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank1_ram1_data_rd1_en_d2 <= bank1_ram1_data_rd1_en_d1;
   end
end
reg  bank2_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank2_ram0_data_rd0_en_d1 <= bank2_ram0_data_rd0_en;
   end
end
reg  bank2_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank2_ram0_data_rd0_en_d2 <= bank2_ram0_data_rd0_en_d1;
   end
end
reg  bank2_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank2_ram0_data_rd1_en_d1 <= bank2_ram0_data_rd1_en;
   end
end
reg  bank2_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank2_ram0_data_rd1_en_d2 <= bank2_ram0_data_rd1_en_d1;
   end
end
reg  bank2_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank2_ram1_data_rd0_en_d1 <= bank2_ram1_data_rd0_en;
   end
end
reg  bank2_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank2_ram1_data_rd0_en_d2 <= bank2_ram1_data_rd0_en_d1;
   end
end
reg  bank2_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank2_ram1_data_rd1_en_d1 <= bank2_ram1_data_rd1_en;
   end
end
reg  bank2_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank2_ram1_data_rd1_en_d2 <= bank2_ram1_data_rd1_en_d1;
   end
end
reg  bank3_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank3_ram0_data_rd0_en_d1 <= bank3_ram0_data_rd0_en;
   end
end
reg  bank3_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank3_ram0_data_rd0_en_d2 <= bank3_ram0_data_rd0_en_d1;
   end
end
reg  bank3_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank3_ram0_data_rd1_en_d1 <= bank3_ram0_data_rd1_en;
   end
end
reg  bank3_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank3_ram0_data_rd1_en_d2 <= bank3_ram0_data_rd1_en_d1;
   end
end
reg  bank3_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank3_ram1_data_rd0_en_d1 <= bank3_ram1_data_rd0_en;
   end
end
reg  bank3_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank3_ram1_data_rd0_en_d2 <= bank3_ram1_data_rd0_en_d1;
   end
end
reg  bank3_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank3_ram1_data_rd1_en_d1 <= bank3_ram1_data_rd1_en;
   end
end
reg  bank3_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank3_ram1_data_rd1_en_d2 <= bank3_ram1_data_rd1_en_d1;
   end
end
reg  bank4_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank4_ram0_data_rd0_en_d1 <= bank4_ram0_data_rd0_en;
   end
end
reg  bank4_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank4_ram0_data_rd0_en_d2 <= bank4_ram0_data_rd0_en_d1;
   end
end
reg  bank4_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank4_ram0_data_rd1_en_d1 <= bank4_ram0_data_rd1_en;
   end
end
reg  bank4_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank4_ram0_data_rd1_en_d2 <= bank4_ram0_data_rd1_en_d1;
   end
end
reg  bank4_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank4_ram1_data_rd0_en_d1 <= bank4_ram1_data_rd0_en;
   end
end
reg  bank4_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank4_ram1_data_rd0_en_d2 <= bank4_ram1_data_rd0_en_d1;
   end
end
reg  bank4_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank4_ram1_data_rd1_en_d1 <= bank4_ram1_data_rd1_en;
   end
end
reg  bank4_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank4_ram1_data_rd1_en_d2 <= bank4_ram1_data_rd1_en_d1;
   end
end
reg  bank5_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank5_ram0_data_rd0_en_d1 <= bank5_ram0_data_rd0_en;
   end
end
reg  bank5_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank5_ram0_data_rd0_en_d2 <= bank5_ram0_data_rd0_en_d1;
   end
end
reg  bank5_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank5_ram0_data_rd1_en_d1 <= bank5_ram0_data_rd1_en;
   end
end
reg  bank5_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank5_ram0_data_rd1_en_d2 <= bank5_ram0_data_rd1_en_d1;
   end
end
reg  bank5_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank5_ram1_data_rd0_en_d1 <= bank5_ram1_data_rd0_en;
   end
end
reg  bank5_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank5_ram1_data_rd0_en_d2 <= bank5_ram1_data_rd0_en_d1;
   end
end
reg  bank5_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank5_ram1_data_rd1_en_d1 <= bank5_ram1_data_rd1_en;
   end
end
reg  bank5_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank5_ram1_data_rd1_en_d2 <= bank5_ram1_data_rd1_en_d1;
   end
end
reg  bank6_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank6_ram0_data_rd0_en_d1 <= bank6_ram0_data_rd0_en;
   end
end
reg  bank6_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank6_ram0_data_rd0_en_d2 <= bank6_ram0_data_rd0_en_d1;
   end
end
reg  bank6_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank6_ram0_data_rd1_en_d1 <= bank6_ram0_data_rd1_en;
   end
end
reg  bank6_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank6_ram0_data_rd1_en_d2 <= bank6_ram0_data_rd1_en_d1;
   end
end
reg  bank6_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank6_ram1_data_rd0_en_d1 <= bank6_ram1_data_rd0_en;
   end
end
reg  bank6_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank6_ram1_data_rd0_en_d2 <= bank6_ram1_data_rd0_en_d1;
   end
end
reg  bank6_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank6_ram1_data_rd1_en_d1 <= bank6_ram1_data_rd1_en;
   end
end
reg  bank6_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank6_ram1_data_rd1_en_d2 <= bank6_ram1_data_rd1_en_d1;
   end
end
reg  bank7_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank7_ram0_data_rd0_en_d1 <= bank7_ram0_data_rd0_en;
   end
end
reg  bank7_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank7_ram0_data_rd0_en_d2 <= bank7_ram0_data_rd0_en_d1;
   end
end
reg  bank7_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank7_ram0_data_rd1_en_d1 <= bank7_ram0_data_rd1_en;
   end
end
reg  bank7_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank7_ram0_data_rd1_en_d2 <= bank7_ram0_data_rd1_en_d1;
   end
end
reg  bank7_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank7_ram1_data_rd0_en_d1 <= bank7_ram1_data_rd0_en;
   end
end
reg  bank7_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank7_ram1_data_rd0_en_d2 <= bank7_ram1_data_rd0_en_d1;
   end
end
reg  bank7_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank7_ram1_data_rd1_en_d1 <= bank7_ram1_data_rd1_en;
   end
end
reg  bank7_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank7_ram1_data_rd1_en_d2 <= bank7_ram1_data_rd1_en_d1;
   end
end
reg  bank8_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank8_ram0_data_rd0_en_d1 <= bank8_ram0_data_rd0_en;
   end
end
reg  bank8_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank8_ram0_data_rd0_en_d2 <= bank8_ram0_data_rd0_en_d1;
   end
end
reg  bank8_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank8_ram0_data_rd1_en_d1 <= bank8_ram0_data_rd1_en;
   end
end
reg  bank8_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank8_ram0_data_rd1_en_d2 <= bank8_ram0_data_rd1_en_d1;
   end
end
reg  bank8_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank8_ram1_data_rd0_en_d1 <= bank8_ram1_data_rd0_en;
   end
end
reg  bank8_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank8_ram1_data_rd0_en_d2 <= bank8_ram1_data_rd0_en_d1;
   end
end
reg  bank8_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank8_ram1_data_rd1_en_d1 <= bank8_ram1_data_rd1_en;
   end
end
reg  bank8_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank8_ram1_data_rd1_en_d2 <= bank8_ram1_data_rd1_en_d1;
   end
end
reg  bank9_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank9_ram0_data_rd0_en_d1 <= bank9_ram0_data_rd0_en;
   end
end
reg  bank9_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank9_ram0_data_rd0_en_d2 <= bank9_ram0_data_rd0_en_d1;
   end
end
reg  bank9_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank9_ram0_data_rd1_en_d1 <= bank9_ram0_data_rd1_en;
   end
end
reg  bank9_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank9_ram0_data_rd1_en_d2 <= bank9_ram0_data_rd1_en_d1;
   end
end
reg  bank9_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank9_ram1_data_rd0_en_d1 <= bank9_ram1_data_rd0_en;
   end
end
reg  bank9_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank9_ram1_data_rd0_en_d2 <= bank9_ram1_data_rd0_en_d1;
   end
end
reg  bank9_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank9_ram1_data_rd1_en_d1 <= bank9_ram1_data_rd1_en;
   end
end
reg  bank9_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank9_ram1_data_rd1_en_d2 <= bank9_ram1_data_rd1_en_d1;
   end
end
reg  bank10_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank10_ram0_data_rd0_en_d1 <= bank10_ram0_data_rd0_en;
   end
end
reg  bank10_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank10_ram0_data_rd0_en_d2 <= bank10_ram0_data_rd0_en_d1;
   end
end
reg  bank10_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank10_ram0_data_rd1_en_d1 <= bank10_ram0_data_rd1_en;
   end
end
reg  bank10_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank10_ram0_data_rd1_en_d2 <= bank10_ram0_data_rd1_en_d1;
   end
end
reg  bank10_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank10_ram1_data_rd0_en_d1 <= bank10_ram1_data_rd0_en;
   end
end
reg  bank10_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank10_ram1_data_rd0_en_d2 <= bank10_ram1_data_rd0_en_d1;
   end
end
reg  bank10_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank10_ram1_data_rd1_en_d1 <= bank10_ram1_data_rd1_en;
   end
end
reg  bank10_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank10_ram1_data_rd1_en_d2 <= bank10_ram1_data_rd1_en_d1;
   end
end
reg  bank11_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank11_ram0_data_rd0_en_d1 <= bank11_ram0_data_rd0_en;
   end
end
reg  bank11_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank11_ram0_data_rd0_en_d2 <= bank11_ram0_data_rd0_en_d1;
   end
end
reg  bank11_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank11_ram0_data_rd1_en_d1 <= bank11_ram0_data_rd1_en;
   end
end
reg  bank11_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank11_ram0_data_rd1_en_d2 <= bank11_ram0_data_rd1_en_d1;
   end
end
reg  bank11_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank11_ram1_data_rd0_en_d1 <= bank11_ram1_data_rd0_en;
   end
end
reg  bank11_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank11_ram1_data_rd0_en_d2 <= bank11_ram1_data_rd0_en_d1;
   end
end
reg  bank11_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank11_ram1_data_rd1_en_d1 <= bank11_ram1_data_rd1_en;
   end
end
reg  bank11_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank11_ram1_data_rd1_en_d2 <= bank11_ram1_data_rd1_en_d1;
   end
end
reg  bank12_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank12_ram0_data_rd0_en_d1 <= bank12_ram0_data_rd0_en;
   end
end
reg  bank12_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank12_ram0_data_rd0_en_d2 <= bank12_ram0_data_rd0_en_d1;
   end
end
reg  bank12_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank12_ram0_data_rd1_en_d1 <= bank12_ram0_data_rd1_en;
   end
end
reg  bank12_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank12_ram0_data_rd1_en_d2 <= bank12_ram0_data_rd1_en_d1;
   end
end
reg  bank12_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank12_ram1_data_rd0_en_d1 <= bank12_ram1_data_rd0_en;
   end
end
reg  bank12_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank12_ram1_data_rd0_en_d2 <= bank12_ram1_data_rd0_en_d1;
   end
end
reg  bank12_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank12_ram1_data_rd1_en_d1 <= bank12_ram1_data_rd1_en;
   end
end
reg  bank12_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank12_ram1_data_rd1_en_d2 <= bank12_ram1_data_rd1_en_d1;
   end
end
reg  bank13_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank13_ram0_data_rd0_en_d1 <= bank13_ram0_data_rd0_en;
   end
end
reg  bank13_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank13_ram0_data_rd0_en_d2 <= bank13_ram0_data_rd0_en_d1;
   end
end
reg  bank13_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank13_ram0_data_rd1_en_d1 <= bank13_ram0_data_rd1_en;
   end
end
reg  bank13_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank13_ram0_data_rd1_en_d2 <= bank13_ram0_data_rd1_en_d1;
   end
end
reg  bank13_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank13_ram1_data_rd0_en_d1 <= bank13_ram1_data_rd0_en;
   end
end
reg  bank13_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank13_ram1_data_rd0_en_d2 <= bank13_ram1_data_rd0_en_d1;
   end
end
reg  bank13_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank13_ram1_data_rd1_en_d1 <= bank13_ram1_data_rd1_en;
   end
end
reg  bank13_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank13_ram1_data_rd1_en_d2 <= bank13_ram1_data_rd1_en_d1;
   end
end
reg  bank14_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank14_ram0_data_rd0_en_d1 <= bank14_ram0_data_rd0_en;
   end
end
reg  bank14_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank14_ram0_data_rd0_en_d2 <= bank14_ram0_data_rd0_en_d1;
   end
end
reg  bank14_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank14_ram0_data_rd1_en_d1 <= bank14_ram0_data_rd1_en;
   end
end
reg  bank14_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank14_ram0_data_rd1_en_d2 <= bank14_ram0_data_rd1_en_d1;
   end
end
reg  bank14_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank14_ram1_data_rd0_en_d1 <= bank14_ram1_data_rd0_en;
   end
end
reg  bank14_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank14_ram1_data_rd0_en_d2 <= bank14_ram1_data_rd0_en_d1;
   end
end
reg  bank14_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank14_ram1_data_rd1_en_d1 <= bank14_ram1_data_rd1_en;
   end
end
reg  bank14_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank14_ram1_data_rd1_en_d2 <= bank14_ram1_data_rd1_en_d1;
   end
end
reg  bank15_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank15_ram0_data_rd0_en_d1 <= bank15_ram0_data_rd0_en;
   end
end
reg  bank15_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank15_ram0_data_rd0_en_d2 <= bank15_ram0_data_rd0_en_d1;
   end
end
reg  bank15_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank15_ram0_data_rd1_en_d1 <= bank15_ram0_data_rd1_en;
   end
end
reg  bank15_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank15_ram0_data_rd1_en_d2 <= bank15_ram0_data_rd1_en_d1;
   end
end
reg  bank15_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank15_ram1_data_rd0_en_d1 <= bank15_ram1_data_rd0_en;
   end
end
reg  bank15_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank15_ram1_data_rd0_en_d2 <= bank15_ram1_data_rd0_en_d1;
   end
end
reg  bank15_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank15_ram1_data_rd1_en_d1 <= bank15_ram1_data_rd1_en;
   end
end
reg  bank15_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank15_ram1_data_rd1_en_d2 <= bank15_ram1_data_rd1_en_d1;
   end
end
reg  bank16_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank16_ram0_data_rd0_en_d1 <= bank16_ram0_data_rd0_en;
   end
end
reg  bank16_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank16_ram0_data_rd0_en_d2 <= bank16_ram0_data_rd0_en_d1;
   end
end
reg  bank16_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank16_ram0_data_rd1_en_d1 <= bank16_ram0_data_rd1_en;
   end
end
reg  bank16_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank16_ram0_data_rd1_en_d2 <= bank16_ram0_data_rd1_en_d1;
   end
end
reg  bank16_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank16_ram1_data_rd0_en_d1 <= bank16_ram1_data_rd0_en;
   end
end
reg  bank16_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank16_ram1_data_rd0_en_d2 <= bank16_ram1_data_rd0_en_d1;
   end
end
reg  bank16_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank16_ram1_data_rd1_en_d1 <= bank16_ram1_data_rd1_en;
   end
end
reg  bank16_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank16_ram1_data_rd1_en_d2 <= bank16_ram1_data_rd1_en_d1;
   end
end
reg  bank17_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank17_ram0_data_rd0_en_d1 <= bank17_ram0_data_rd0_en;
   end
end
reg  bank17_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank17_ram0_data_rd0_en_d2 <= bank17_ram0_data_rd0_en_d1;
   end
end
reg  bank17_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank17_ram0_data_rd1_en_d1 <= bank17_ram0_data_rd1_en;
   end
end
reg  bank17_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank17_ram0_data_rd1_en_d2 <= bank17_ram0_data_rd1_en_d1;
   end
end
reg  bank17_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank17_ram1_data_rd0_en_d1 <= bank17_ram1_data_rd0_en;
   end
end
reg  bank17_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank17_ram1_data_rd0_en_d2 <= bank17_ram1_data_rd0_en_d1;
   end
end
reg  bank17_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank17_ram1_data_rd1_en_d1 <= bank17_ram1_data_rd1_en;
   end
end
reg  bank17_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank17_ram1_data_rd1_en_d2 <= bank17_ram1_data_rd1_en_d1;
   end
end
reg  bank18_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank18_ram0_data_rd0_en_d1 <= bank18_ram0_data_rd0_en;
   end
end
reg  bank18_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank18_ram0_data_rd0_en_d2 <= bank18_ram0_data_rd0_en_d1;
   end
end
reg  bank18_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank18_ram0_data_rd1_en_d1 <= bank18_ram0_data_rd1_en;
   end
end
reg  bank18_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank18_ram0_data_rd1_en_d2 <= bank18_ram0_data_rd1_en_d1;
   end
end
reg  bank18_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank18_ram1_data_rd0_en_d1 <= bank18_ram1_data_rd0_en;
   end
end
reg  bank18_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank18_ram1_data_rd0_en_d2 <= bank18_ram1_data_rd0_en_d1;
   end
end
reg  bank18_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank18_ram1_data_rd1_en_d1 <= bank18_ram1_data_rd1_en;
   end
end
reg  bank18_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank18_ram1_data_rd1_en_d2 <= bank18_ram1_data_rd1_en_d1;
   end
end
reg  bank19_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank19_ram0_data_rd0_en_d1 <= bank19_ram0_data_rd0_en;
   end
end
reg  bank19_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank19_ram0_data_rd0_en_d2 <= bank19_ram0_data_rd0_en_d1;
   end
end
reg  bank19_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank19_ram0_data_rd1_en_d1 <= bank19_ram0_data_rd1_en;
   end
end
reg  bank19_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank19_ram0_data_rd1_en_d2 <= bank19_ram0_data_rd1_en_d1;
   end
end
reg  bank19_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank19_ram1_data_rd0_en_d1 <= bank19_ram1_data_rd0_en;
   end
end
reg  bank19_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank19_ram1_data_rd0_en_d2 <= bank19_ram1_data_rd0_en_d1;
   end
end
reg  bank19_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank19_ram1_data_rd1_en_d1 <= bank19_ram1_data_rd1_en;
   end
end
reg  bank19_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank19_ram1_data_rd1_en_d2 <= bank19_ram1_data_rd1_en_d1;
   end
end
reg  bank20_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank20_ram0_data_rd0_en_d1 <= bank20_ram0_data_rd0_en;
   end
end
reg  bank20_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank20_ram0_data_rd0_en_d2 <= bank20_ram0_data_rd0_en_d1;
   end
end
reg  bank20_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank20_ram0_data_rd1_en_d1 <= bank20_ram0_data_rd1_en;
   end
end
reg  bank20_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank20_ram0_data_rd1_en_d2 <= bank20_ram0_data_rd1_en_d1;
   end
end
reg  bank20_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank20_ram1_data_rd0_en_d1 <= bank20_ram1_data_rd0_en;
   end
end
reg  bank20_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank20_ram1_data_rd0_en_d2 <= bank20_ram1_data_rd0_en_d1;
   end
end
reg  bank20_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank20_ram1_data_rd1_en_d1 <= bank20_ram1_data_rd1_en;
   end
end
reg  bank20_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank20_ram1_data_rd1_en_d2 <= bank20_ram1_data_rd1_en_d1;
   end
end
reg  bank21_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank21_ram0_data_rd0_en_d1 <= bank21_ram0_data_rd0_en;
   end
end
reg  bank21_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank21_ram0_data_rd0_en_d2 <= bank21_ram0_data_rd0_en_d1;
   end
end
reg  bank21_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank21_ram0_data_rd1_en_d1 <= bank21_ram0_data_rd1_en;
   end
end
reg  bank21_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank21_ram0_data_rd1_en_d2 <= bank21_ram0_data_rd1_en_d1;
   end
end
reg  bank21_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank21_ram1_data_rd0_en_d1 <= bank21_ram1_data_rd0_en;
   end
end
reg  bank21_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank21_ram1_data_rd0_en_d2 <= bank21_ram1_data_rd0_en_d1;
   end
end
reg  bank21_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank21_ram1_data_rd1_en_d1 <= bank21_ram1_data_rd1_en;
   end
end
reg  bank21_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank21_ram1_data_rd1_en_d2 <= bank21_ram1_data_rd1_en_d1;
   end
end
reg  bank22_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank22_ram0_data_rd0_en_d1 <= bank22_ram0_data_rd0_en;
   end
end
reg  bank22_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank22_ram0_data_rd0_en_d2 <= bank22_ram0_data_rd0_en_d1;
   end
end
reg  bank22_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank22_ram0_data_rd1_en_d1 <= bank22_ram0_data_rd1_en;
   end
end
reg  bank22_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank22_ram0_data_rd1_en_d2 <= bank22_ram0_data_rd1_en_d1;
   end
end
reg  bank22_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank22_ram1_data_rd0_en_d1 <= bank22_ram1_data_rd0_en;
   end
end
reg  bank22_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank22_ram1_data_rd0_en_d2 <= bank22_ram1_data_rd0_en_d1;
   end
end
reg  bank22_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank22_ram1_data_rd1_en_d1 <= bank22_ram1_data_rd1_en;
   end
end
reg  bank22_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank22_ram1_data_rd1_en_d2 <= bank22_ram1_data_rd1_en_d1;
   end
end
reg  bank23_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank23_ram0_data_rd0_en_d1 <= bank23_ram0_data_rd0_en;
   end
end
reg  bank23_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank23_ram0_data_rd0_en_d2 <= bank23_ram0_data_rd0_en_d1;
   end
end
reg  bank23_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank23_ram0_data_rd1_en_d1 <= bank23_ram0_data_rd1_en;
   end
end
reg  bank23_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank23_ram0_data_rd1_en_d2 <= bank23_ram0_data_rd1_en_d1;
   end
end
reg  bank23_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank23_ram1_data_rd0_en_d1 <= bank23_ram1_data_rd0_en;
   end
end
reg  bank23_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank23_ram1_data_rd0_en_d2 <= bank23_ram1_data_rd0_en_d1;
   end
end
reg  bank23_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank23_ram1_data_rd1_en_d1 <= bank23_ram1_data_rd1_en;
   end
end
reg  bank23_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank23_ram1_data_rd1_en_d2 <= bank23_ram1_data_rd1_en_d1;
   end
end
reg  bank24_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank24_ram0_data_rd0_en_d1 <= bank24_ram0_data_rd0_en;
   end
end
reg  bank24_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank24_ram0_data_rd0_en_d2 <= bank24_ram0_data_rd0_en_d1;
   end
end
reg  bank24_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank24_ram0_data_rd1_en_d1 <= bank24_ram0_data_rd1_en;
   end
end
reg  bank24_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank24_ram0_data_rd1_en_d2 <= bank24_ram0_data_rd1_en_d1;
   end
end
reg  bank24_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank24_ram1_data_rd0_en_d1 <= bank24_ram1_data_rd0_en;
   end
end
reg  bank24_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank24_ram1_data_rd0_en_d2 <= bank24_ram1_data_rd0_en_d1;
   end
end
reg  bank24_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank24_ram1_data_rd1_en_d1 <= bank24_ram1_data_rd1_en;
   end
end
reg  bank24_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank24_ram1_data_rd1_en_d2 <= bank24_ram1_data_rd1_en_d1;
   end
end
reg  bank25_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank25_ram0_data_rd0_en_d1 <= bank25_ram0_data_rd0_en;
   end
end
reg  bank25_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank25_ram0_data_rd0_en_d2 <= bank25_ram0_data_rd0_en_d1;
   end
end
reg  bank25_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank25_ram0_data_rd1_en_d1 <= bank25_ram0_data_rd1_en;
   end
end
reg  bank25_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank25_ram0_data_rd1_en_d2 <= bank25_ram0_data_rd1_en_d1;
   end
end
reg  bank25_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank25_ram1_data_rd0_en_d1 <= bank25_ram1_data_rd0_en;
   end
end
reg  bank25_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank25_ram1_data_rd0_en_d2 <= bank25_ram1_data_rd0_en_d1;
   end
end
reg  bank25_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank25_ram1_data_rd1_en_d1 <= bank25_ram1_data_rd1_en;
   end
end
reg  bank25_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank25_ram1_data_rd1_en_d2 <= bank25_ram1_data_rd1_en_d1;
   end
end
reg  bank26_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank26_ram0_data_rd0_en_d1 <= bank26_ram0_data_rd0_en;
   end
end
reg  bank26_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank26_ram0_data_rd0_en_d2 <= bank26_ram0_data_rd0_en_d1;
   end
end
reg  bank26_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank26_ram0_data_rd1_en_d1 <= bank26_ram0_data_rd1_en;
   end
end
reg  bank26_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank26_ram0_data_rd1_en_d2 <= bank26_ram0_data_rd1_en_d1;
   end
end
reg  bank26_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank26_ram1_data_rd0_en_d1 <= bank26_ram1_data_rd0_en;
   end
end
reg  bank26_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank26_ram1_data_rd0_en_d2 <= bank26_ram1_data_rd0_en_d1;
   end
end
reg  bank26_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank26_ram1_data_rd1_en_d1 <= bank26_ram1_data_rd1_en;
   end
end
reg  bank26_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank26_ram1_data_rd1_en_d2 <= bank26_ram1_data_rd1_en_d1;
   end
end
reg  bank27_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank27_ram0_data_rd0_en_d1 <= bank27_ram0_data_rd0_en;
   end
end
reg  bank27_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank27_ram0_data_rd0_en_d2 <= bank27_ram0_data_rd0_en_d1;
   end
end
reg  bank27_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank27_ram0_data_rd1_en_d1 <= bank27_ram0_data_rd1_en;
   end
end
reg  bank27_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank27_ram0_data_rd1_en_d2 <= bank27_ram0_data_rd1_en_d1;
   end
end
reg  bank27_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank27_ram1_data_rd0_en_d1 <= bank27_ram1_data_rd0_en;
   end
end
reg  bank27_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank27_ram1_data_rd0_en_d2 <= bank27_ram1_data_rd0_en_d1;
   end
end
reg  bank27_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank27_ram1_data_rd1_en_d1 <= bank27_ram1_data_rd1_en;
   end
end
reg  bank27_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank27_ram1_data_rd1_en_d2 <= bank27_ram1_data_rd1_en_d1;
   end
end
reg  bank28_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank28_ram0_data_rd0_en_d1 <= bank28_ram0_data_rd0_en;
   end
end
reg  bank28_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank28_ram0_data_rd0_en_d2 <= bank28_ram0_data_rd0_en_d1;
   end
end
reg  bank28_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank28_ram0_data_rd1_en_d1 <= bank28_ram0_data_rd1_en;
   end
end
reg  bank28_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank28_ram0_data_rd1_en_d2 <= bank28_ram0_data_rd1_en_d1;
   end
end
reg  bank28_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank28_ram1_data_rd0_en_d1 <= bank28_ram1_data_rd0_en;
   end
end
reg  bank28_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank28_ram1_data_rd0_en_d2 <= bank28_ram1_data_rd0_en_d1;
   end
end
reg  bank28_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank28_ram1_data_rd1_en_d1 <= bank28_ram1_data_rd1_en;
   end
end
reg  bank28_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank28_ram1_data_rd1_en_d2 <= bank28_ram1_data_rd1_en_d1;
   end
end
reg  bank29_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank29_ram0_data_rd0_en_d1 <= bank29_ram0_data_rd0_en;
   end
end
reg  bank29_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank29_ram0_data_rd0_en_d2 <= bank29_ram0_data_rd0_en_d1;
   end
end
reg  bank29_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank29_ram0_data_rd1_en_d1 <= bank29_ram0_data_rd1_en;
   end
end
reg  bank29_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank29_ram0_data_rd1_en_d2 <= bank29_ram0_data_rd1_en_d1;
   end
end
reg  bank29_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank29_ram1_data_rd0_en_d1 <= bank29_ram1_data_rd0_en;
   end
end
reg  bank29_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank29_ram1_data_rd0_en_d2 <= bank29_ram1_data_rd0_en_d1;
   end
end
reg  bank29_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank29_ram1_data_rd1_en_d1 <= bank29_ram1_data_rd1_en;
   end
end
reg  bank29_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank29_ram1_data_rd1_en_d2 <= bank29_ram1_data_rd1_en_d1;
   end
end
reg  bank30_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank30_ram0_data_rd0_en_d1 <= bank30_ram0_data_rd0_en;
   end
end
reg  bank30_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank30_ram0_data_rd0_en_d2 <= bank30_ram0_data_rd0_en_d1;
   end
end
reg  bank30_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank30_ram0_data_rd1_en_d1 <= bank30_ram0_data_rd1_en;
   end
end
reg  bank30_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank30_ram0_data_rd1_en_d2 <= bank30_ram0_data_rd1_en_d1;
   end
end
reg  bank30_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank30_ram1_data_rd0_en_d1 <= bank30_ram1_data_rd0_en;
   end
end
reg  bank30_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank30_ram1_data_rd0_en_d2 <= bank30_ram1_data_rd0_en_d1;
   end
end
reg  bank30_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank30_ram1_data_rd1_en_d1 <= bank30_ram1_data_rd1_en;
   end
end
reg  bank30_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank30_ram1_data_rd1_en_d2 <= bank30_ram1_data_rd1_en_d1;
   end
end
reg  bank31_ram0_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_data_rd0_en_d1 <= 'b0;
   end else begin
       bank31_ram0_data_rd0_en_d1 <= bank31_ram0_data_rd0_en;
   end
end
reg  bank31_ram0_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_data_rd0_en_d2 <= 'b0;
   end else begin
       bank31_ram0_data_rd0_en_d2 <= bank31_ram0_data_rd0_en_d1;
   end
end
reg  bank31_ram0_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_data_rd1_en_d1 <= 'b0;
   end else begin
       bank31_ram0_data_rd1_en_d1 <= bank31_ram0_data_rd1_en;
   end
end
reg  bank31_ram0_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_data_rd1_en_d2 <= 'b0;
   end else begin
       bank31_ram0_data_rd1_en_d2 <= bank31_ram0_data_rd1_en_d1;
   end
end
reg  bank31_ram1_data_rd0_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_data_rd0_en_d1 <= 'b0;
   end else begin
       bank31_ram1_data_rd0_en_d1 <= bank31_ram1_data_rd0_en;
   end
end
reg  bank31_ram1_data_rd0_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_data_rd0_en_d2 <= 'b0;
   end else begin
       bank31_ram1_data_rd0_en_d2 <= bank31_ram1_data_rd0_en_d1;
   end
end
reg  bank31_ram1_data_rd1_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_data_rd1_en_d1 <= 'b0;
   end else begin
       bank31_ram1_data_rd1_en_d1 <= bank31_ram1_data_rd1_en;
   end
end
reg  bank31_ram1_data_rd1_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_data_rd1_en_d2 <= 'b0;
   end else begin
       bank31_ram1_data_rd1_en_d2 <= bank31_ram1_data_rd1_en_d1;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sram data read valid.
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire bank${j}_ram${k}_data_rd_valid = bank${j}_ram${k}_data_rd_en_d2; )
//: }
//: for(my $i=0; $i<2; $i++){
//: if((1==1)||(1==3)||(1==5)){
//: print qq(
//: wire bank${j}_ram${k}_data_rd${i}_valid = bank${j}_ram${k}_data_rd${i}_en_d2; )
//: }
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire bank0_ram0_data_rd0_valid = bank0_ram0_data_rd0_en_d2; 
wire bank0_ram0_data_rd1_valid = bank0_ram0_data_rd1_en_d2; 
wire bank0_ram1_data_rd0_valid = bank0_ram1_data_rd0_en_d2; 
wire bank0_ram1_data_rd1_valid = bank0_ram1_data_rd1_en_d2; 
wire bank1_ram0_data_rd0_valid = bank1_ram0_data_rd0_en_d2; 
wire bank1_ram0_data_rd1_valid = bank1_ram0_data_rd1_en_d2; 
wire bank1_ram1_data_rd0_valid = bank1_ram1_data_rd0_en_d2; 
wire bank1_ram1_data_rd1_valid = bank1_ram1_data_rd1_en_d2; 
wire bank2_ram0_data_rd0_valid = bank2_ram0_data_rd0_en_d2; 
wire bank2_ram0_data_rd1_valid = bank2_ram0_data_rd1_en_d2; 
wire bank2_ram1_data_rd0_valid = bank2_ram1_data_rd0_en_d2; 
wire bank2_ram1_data_rd1_valid = bank2_ram1_data_rd1_en_d2; 
wire bank3_ram0_data_rd0_valid = bank3_ram0_data_rd0_en_d2; 
wire bank3_ram0_data_rd1_valid = bank3_ram0_data_rd1_en_d2; 
wire bank3_ram1_data_rd0_valid = bank3_ram1_data_rd0_en_d2; 
wire bank3_ram1_data_rd1_valid = bank3_ram1_data_rd1_en_d2; 
wire bank4_ram0_data_rd0_valid = bank4_ram0_data_rd0_en_d2; 
wire bank4_ram0_data_rd1_valid = bank4_ram0_data_rd1_en_d2; 
wire bank4_ram1_data_rd0_valid = bank4_ram1_data_rd0_en_d2; 
wire bank4_ram1_data_rd1_valid = bank4_ram1_data_rd1_en_d2; 
wire bank5_ram0_data_rd0_valid = bank5_ram0_data_rd0_en_d2; 
wire bank5_ram0_data_rd1_valid = bank5_ram0_data_rd1_en_d2; 
wire bank5_ram1_data_rd0_valid = bank5_ram1_data_rd0_en_d2; 
wire bank5_ram1_data_rd1_valid = bank5_ram1_data_rd1_en_d2; 
wire bank6_ram0_data_rd0_valid = bank6_ram0_data_rd0_en_d2; 
wire bank6_ram0_data_rd1_valid = bank6_ram0_data_rd1_en_d2; 
wire bank6_ram1_data_rd0_valid = bank6_ram1_data_rd0_en_d2; 
wire bank6_ram1_data_rd1_valid = bank6_ram1_data_rd1_en_d2; 
wire bank7_ram0_data_rd0_valid = bank7_ram0_data_rd0_en_d2; 
wire bank7_ram0_data_rd1_valid = bank7_ram0_data_rd1_en_d2; 
wire bank7_ram1_data_rd0_valid = bank7_ram1_data_rd0_en_d2; 
wire bank7_ram1_data_rd1_valid = bank7_ram1_data_rd1_en_d2; 
wire bank8_ram0_data_rd0_valid = bank8_ram0_data_rd0_en_d2; 
wire bank8_ram0_data_rd1_valid = bank8_ram0_data_rd1_en_d2; 
wire bank8_ram1_data_rd0_valid = bank8_ram1_data_rd0_en_d2; 
wire bank8_ram1_data_rd1_valid = bank8_ram1_data_rd1_en_d2; 
wire bank9_ram0_data_rd0_valid = bank9_ram0_data_rd0_en_d2; 
wire bank9_ram0_data_rd1_valid = bank9_ram0_data_rd1_en_d2; 
wire bank9_ram1_data_rd0_valid = bank9_ram1_data_rd0_en_d2; 
wire bank9_ram1_data_rd1_valid = bank9_ram1_data_rd1_en_d2; 
wire bank10_ram0_data_rd0_valid = bank10_ram0_data_rd0_en_d2; 
wire bank10_ram0_data_rd1_valid = bank10_ram0_data_rd1_en_d2; 
wire bank10_ram1_data_rd0_valid = bank10_ram1_data_rd0_en_d2; 
wire bank10_ram1_data_rd1_valid = bank10_ram1_data_rd1_en_d2; 
wire bank11_ram0_data_rd0_valid = bank11_ram0_data_rd0_en_d2; 
wire bank11_ram0_data_rd1_valid = bank11_ram0_data_rd1_en_d2; 
wire bank11_ram1_data_rd0_valid = bank11_ram1_data_rd0_en_d2; 
wire bank11_ram1_data_rd1_valid = bank11_ram1_data_rd1_en_d2; 
wire bank12_ram0_data_rd0_valid = bank12_ram0_data_rd0_en_d2; 
wire bank12_ram0_data_rd1_valid = bank12_ram0_data_rd1_en_d2; 
wire bank12_ram1_data_rd0_valid = bank12_ram1_data_rd0_en_d2; 
wire bank12_ram1_data_rd1_valid = bank12_ram1_data_rd1_en_d2; 
wire bank13_ram0_data_rd0_valid = bank13_ram0_data_rd0_en_d2; 
wire bank13_ram0_data_rd1_valid = bank13_ram0_data_rd1_en_d2; 
wire bank13_ram1_data_rd0_valid = bank13_ram1_data_rd0_en_d2; 
wire bank13_ram1_data_rd1_valid = bank13_ram1_data_rd1_en_d2; 
wire bank14_ram0_data_rd0_valid = bank14_ram0_data_rd0_en_d2; 
wire bank14_ram0_data_rd1_valid = bank14_ram0_data_rd1_en_d2; 
wire bank14_ram1_data_rd0_valid = bank14_ram1_data_rd0_en_d2; 
wire bank14_ram1_data_rd1_valid = bank14_ram1_data_rd1_en_d2; 
wire bank15_ram0_data_rd0_valid = bank15_ram0_data_rd0_en_d2; 
wire bank15_ram0_data_rd1_valid = bank15_ram0_data_rd1_en_d2; 
wire bank15_ram1_data_rd0_valid = bank15_ram1_data_rd0_en_d2; 
wire bank15_ram1_data_rd1_valid = bank15_ram1_data_rd1_en_d2; 
wire bank16_ram0_data_rd0_valid = bank16_ram0_data_rd0_en_d2; 
wire bank16_ram0_data_rd1_valid = bank16_ram0_data_rd1_en_d2; 
wire bank16_ram1_data_rd0_valid = bank16_ram1_data_rd0_en_d2; 
wire bank16_ram1_data_rd1_valid = bank16_ram1_data_rd1_en_d2; 
wire bank17_ram0_data_rd0_valid = bank17_ram0_data_rd0_en_d2; 
wire bank17_ram0_data_rd1_valid = bank17_ram0_data_rd1_en_d2; 
wire bank17_ram1_data_rd0_valid = bank17_ram1_data_rd0_en_d2; 
wire bank17_ram1_data_rd1_valid = bank17_ram1_data_rd1_en_d2; 
wire bank18_ram0_data_rd0_valid = bank18_ram0_data_rd0_en_d2; 
wire bank18_ram0_data_rd1_valid = bank18_ram0_data_rd1_en_d2; 
wire bank18_ram1_data_rd0_valid = bank18_ram1_data_rd0_en_d2; 
wire bank18_ram1_data_rd1_valid = bank18_ram1_data_rd1_en_d2; 
wire bank19_ram0_data_rd0_valid = bank19_ram0_data_rd0_en_d2; 
wire bank19_ram0_data_rd1_valid = bank19_ram0_data_rd1_en_d2; 
wire bank19_ram1_data_rd0_valid = bank19_ram1_data_rd0_en_d2; 
wire bank19_ram1_data_rd1_valid = bank19_ram1_data_rd1_en_d2; 
wire bank20_ram0_data_rd0_valid = bank20_ram0_data_rd0_en_d2; 
wire bank20_ram0_data_rd1_valid = bank20_ram0_data_rd1_en_d2; 
wire bank20_ram1_data_rd0_valid = bank20_ram1_data_rd0_en_d2; 
wire bank20_ram1_data_rd1_valid = bank20_ram1_data_rd1_en_d2; 
wire bank21_ram0_data_rd0_valid = bank21_ram0_data_rd0_en_d2; 
wire bank21_ram0_data_rd1_valid = bank21_ram0_data_rd1_en_d2; 
wire bank21_ram1_data_rd0_valid = bank21_ram1_data_rd0_en_d2; 
wire bank21_ram1_data_rd1_valid = bank21_ram1_data_rd1_en_d2; 
wire bank22_ram0_data_rd0_valid = bank22_ram0_data_rd0_en_d2; 
wire bank22_ram0_data_rd1_valid = bank22_ram0_data_rd1_en_d2; 
wire bank22_ram1_data_rd0_valid = bank22_ram1_data_rd0_en_d2; 
wire bank22_ram1_data_rd1_valid = bank22_ram1_data_rd1_en_d2; 
wire bank23_ram0_data_rd0_valid = bank23_ram0_data_rd0_en_d2; 
wire bank23_ram0_data_rd1_valid = bank23_ram0_data_rd1_en_d2; 
wire bank23_ram1_data_rd0_valid = bank23_ram1_data_rd0_en_d2; 
wire bank23_ram1_data_rd1_valid = bank23_ram1_data_rd1_en_d2; 
wire bank24_ram0_data_rd0_valid = bank24_ram0_data_rd0_en_d2; 
wire bank24_ram0_data_rd1_valid = bank24_ram0_data_rd1_en_d2; 
wire bank24_ram1_data_rd0_valid = bank24_ram1_data_rd0_en_d2; 
wire bank24_ram1_data_rd1_valid = bank24_ram1_data_rd1_en_d2; 
wire bank25_ram0_data_rd0_valid = bank25_ram0_data_rd0_en_d2; 
wire bank25_ram0_data_rd1_valid = bank25_ram0_data_rd1_en_d2; 
wire bank25_ram1_data_rd0_valid = bank25_ram1_data_rd0_en_d2; 
wire bank25_ram1_data_rd1_valid = bank25_ram1_data_rd1_en_d2; 
wire bank26_ram0_data_rd0_valid = bank26_ram0_data_rd0_en_d2; 
wire bank26_ram0_data_rd1_valid = bank26_ram0_data_rd1_en_d2; 
wire bank26_ram1_data_rd0_valid = bank26_ram1_data_rd0_en_d2; 
wire bank26_ram1_data_rd1_valid = bank26_ram1_data_rd1_en_d2; 
wire bank27_ram0_data_rd0_valid = bank27_ram0_data_rd0_en_d2; 
wire bank27_ram0_data_rd1_valid = bank27_ram0_data_rd1_en_d2; 
wire bank27_ram1_data_rd0_valid = bank27_ram1_data_rd0_en_d2; 
wire bank27_ram1_data_rd1_valid = bank27_ram1_data_rd1_en_d2; 
wire bank28_ram0_data_rd0_valid = bank28_ram0_data_rd0_en_d2; 
wire bank28_ram0_data_rd1_valid = bank28_ram0_data_rd1_en_d2; 
wire bank28_ram1_data_rd0_valid = bank28_ram1_data_rd0_en_d2; 
wire bank28_ram1_data_rd1_valid = bank28_ram1_data_rd1_en_d2; 
wire bank29_ram0_data_rd0_valid = bank29_ram0_data_rd0_en_d2; 
wire bank29_ram0_data_rd1_valid = bank29_ram0_data_rd1_en_d2; 
wire bank29_ram1_data_rd0_valid = bank29_ram1_data_rd0_en_d2; 
wire bank29_ram1_data_rd1_valid = bank29_ram1_data_rd1_en_d2; 
wire bank30_ram0_data_rd0_valid = bank30_ram0_data_rd0_en_d2; 
wire bank30_ram0_data_rd1_valid = bank30_ram0_data_rd1_en_d2; 
wire bank30_ram1_data_rd0_valid = bank30_ram1_data_rd0_en_d2; 
wire bank30_ram1_data_rd1_valid = bank30_ram1_data_rd1_en_d2; 
wire bank31_ram0_data_rd0_valid = bank31_ram0_data_rd0_en_d2; 
wire bank31_ram0_data_rd1_valid = bank31_ram0_data_rd1_en_d2; 
wire bank31_ram1_data_rd0_valid = bank31_ram1_data_rd0_en_d2; 
wire bank31_ram1_data_rd1_valid = bank31_ram1_data_rd1_en_d2; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sc data read valid.
//: my $t1="";
//: my $t2="";
//: if((1==0)||(1==2)||(1==4)){
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: $t1 .= "bank${j}_ram${k}_data_rd_valid|";
//: }
//: }
//: print "wire [0:0] sc2buf_dat_rd_valid_w = $t1"."1'b0; \n";
//: }
//: if((1==1)||(1==3)||(1==5)){
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: $t1 .= "bank${j}_ram${k}_data_rd0_valid|";
//: $t2 .= "bank${j}_ram${k}_data_rd1_valid|";
//: }
//: }
//: print "wire sc2buf_dat_rd_valid0 = ${t1}"."1'b0; \n";
//: print "wire sc2buf_dat_rd_valid1 = ${t2}"."1'b0; \n";
//: print "wire [0:0] sc2buf_dat_rd_valid_w = sc2buf_dat_rd_valid0 || sc2buf_dat_rd_valid1; \n";
//: }
//: &eperl::retime("-O sc2buf_dat_rd_valid -i sc2buf_dat_rd_valid_w -stage 4 -clk nvdla_core_clk");
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: print qq(
//: wire [64 -1:0] bank${j}_ram${k}_rd_data; );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire sc2buf_dat_rd_valid0 = bank0_ram0_data_rd0_valid|bank0_ram1_data_rd0_valid|bank1_ram0_data_rd0_valid|bank1_ram1_data_rd0_valid|bank2_ram0_data_rd0_valid|bank2_ram1_data_rd0_valid|bank3_ram0_data_rd0_valid|bank3_ram1_data_rd0_valid|bank4_ram0_data_rd0_valid|bank4_ram1_data_rd0_valid|bank5_ram0_data_rd0_valid|bank5_ram1_data_rd0_valid|bank6_ram0_data_rd0_valid|bank6_ram1_data_rd0_valid|bank7_ram0_data_rd0_valid|bank7_ram1_data_rd0_valid|bank8_ram0_data_rd0_valid|bank8_ram1_data_rd0_valid|bank9_ram0_data_rd0_valid|bank9_ram1_data_rd0_valid|bank10_ram0_data_rd0_valid|bank10_ram1_data_rd0_valid|bank11_ram0_data_rd0_valid|bank11_ram1_data_rd0_valid|bank12_ram0_data_rd0_valid|bank12_ram1_data_rd0_valid|bank13_ram0_data_rd0_valid|bank13_ram1_data_rd0_valid|bank14_ram0_data_rd0_valid|bank14_ram1_data_rd0_valid|bank15_ram0_data_rd0_valid|bank15_ram1_data_rd0_valid|bank16_ram0_data_rd0_valid|bank16_ram1_data_rd0_valid|bank17_ram0_data_rd0_valid|bank17_ram1_data_rd0_valid|bank18_ram0_data_rd0_valid|bank18_ram1_data_rd0_valid|bank19_ram0_data_rd0_valid|bank19_ram1_data_rd0_valid|bank20_ram0_data_rd0_valid|bank20_ram1_data_rd0_valid|bank21_ram0_data_rd0_valid|bank21_ram1_data_rd0_valid|bank22_ram0_data_rd0_valid|bank22_ram1_data_rd0_valid|bank23_ram0_data_rd0_valid|bank23_ram1_data_rd0_valid|bank24_ram0_data_rd0_valid|bank24_ram1_data_rd0_valid|bank25_ram0_data_rd0_valid|bank25_ram1_data_rd0_valid|bank26_ram0_data_rd0_valid|bank26_ram1_data_rd0_valid|bank27_ram0_data_rd0_valid|bank27_ram1_data_rd0_valid|bank28_ram0_data_rd0_valid|bank28_ram1_data_rd0_valid|bank29_ram0_data_rd0_valid|bank29_ram1_data_rd0_valid|bank30_ram0_data_rd0_valid|bank30_ram1_data_rd0_valid|bank31_ram0_data_rd0_valid|bank31_ram1_data_rd0_valid|1'b0; 
wire sc2buf_dat_rd_valid1 = bank0_ram0_data_rd1_valid|bank0_ram1_data_rd1_valid|bank1_ram0_data_rd1_valid|bank1_ram1_data_rd1_valid|bank2_ram0_data_rd1_valid|bank2_ram1_data_rd1_valid|bank3_ram0_data_rd1_valid|bank3_ram1_data_rd1_valid|bank4_ram0_data_rd1_valid|bank4_ram1_data_rd1_valid|bank5_ram0_data_rd1_valid|bank5_ram1_data_rd1_valid|bank6_ram0_data_rd1_valid|bank6_ram1_data_rd1_valid|bank7_ram0_data_rd1_valid|bank7_ram1_data_rd1_valid|bank8_ram0_data_rd1_valid|bank8_ram1_data_rd1_valid|bank9_ram0_data_rd1_valid|bank9_ram1_data_rd1_valid|bank10_ram0_data_rd1_valid|bank10_ram1_data_rd1_valid|bank11_ram0_data_rd1_valid|bank11_ram1_data_rd1_valid|bank12_ram0_data_rd1_valid|bank12_ram1_data_rd1_valid|bank13_ram0_data_rd1_valid|bank13_ram1_data_rd1_valid|bank14_ram0_data_rd1_valid|bank14_ram1_data_rd1_valid|bank15_ram0_data_rd1_valid|bank15_ram1_data_rd1_valid|bank16_ram0_data_rd1_valid|bank16_ram1_data_rd1_valid|bank17_ram0_data_rd1_valid|bank17_ram1_data_rd1_valid|bank18_ram0_data_rd1_valid|bank18_ram1_data_rd1_valid|bank19_ram0_data_rd1_valid|bank19_ram1_data_rd1_valid|bank20_ram0_data_rd1_valid|bank20_ram1_data_rd1_valid|bank21_ram0_data_rd1_valid|bank21_ram1_data_rd1_valid|bank22_ram0_data_rd1_valid|bank22_ram1_data_rd1_valid|bank23_ram0_data_rd1_valid|bank23_ram1_data_rd1_valid|bank24_ram0_data_rd1_valid|bank24_ram1_data_rd1_valid|bank25_ram0_data_rd1_valid|bank25_ram1_data_rd1_valid|bank26_ram0_data_rd1_valid|bank26_ram1_data_rd1_valid|bank27_ram0_data_rd1_valid|bank27_ram1_data_rd1_valid|bank28_ram0_data_rd1_valid|bank28_ram1_data_rd1_valid|bank29_ram0_data_rd1_valid|bank29_ram1_data_rd1_valid|bank30_ram0_data_rd1_valid|bank30_ram1_data_rd1_valid|bank31_ram0_data_rd1_valid|bank31_ram1_data_rd1_valid|1'b0; 
wire [0:0] sc2buf_dat_rd_valid_w = sc2buf_dat_rd_valid0 || sc2buf_dat_rd_valid1; 
reg  sc2buf_dat_rd_valid_w_d1;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_valid_w_d1 <= sc2buf_dat_rd_valid_w;
end

reg  sc2buf_dat_rd_valid_w_d2;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_valid_w_d2 <= sc2buf_dat_rd_valid_w_d1;
end

reg  sc2buf_dat_rd_valid_w_d3;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_valid_w_d3 <= sc2buf_dat_rd_valid_w_d2;
end

reg  sc2buf_dat_rd_valid_w_d4;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_valid_w_d4 <= sc2buf_dat_rd_valid_w_d3;
end

wire  sc2buf_dat_rd_valid;
assign sc2buf_dat_rd_valid = sc2buf_dat_rd_valid_w_d4;


wire [64 -1:0] bank0_ram0_rd_data; 
wire [64 -1:0] bank0_ram1_rd_data; 
wire [64 -1:0] bank1_ram0_rd_data; 
wire [64 -1:0] bank1_ram1_rd_data; 
wire [64 -1:0] bank2_ram0_rd_data; 
wire [64 -1:0] bank2_ram1_rd_data; 
wire [64 -1:0] bank3_ram0_rd_data; 
wire [64 -1:0] bank3_ram1_rd_data; 
wire [64 -1:0] bank4_ram0_rd_data; 
wire [64 -1:0] bank4_ram1_rd_data; 
wire [64 -1:0] bank5_ram0_rd_data; 
wire [64 -1:0] bank5_ram1_rd_data; 
wire [64 -1:0] bank6_ram0_rd_data; 
wire [64 -1:0] bank6_ram1_rd_data; 
wire [64 -1:0] bank7_ram0_rd_data; 
wire [64 -1:0] bank7_ram1_rd_data; 
wire [64 -1:0] bank8_ram0_rd_data; 
wire [64 -1:0] bank8_ram1_rd_data; 
wire [64 -1:0] bank9_ram0_rd_data; 
wire [64 -1:0] bank9_ram1_rd_data; 
wire [64 -1:0] bank10_ram0_rd_data; 
wire [64 -1:0] bank10_ram1_rd_data; 
wire [64 -1:0] bank11_ram0_rd_data; 
wire [64 -1:0] bank11_ram1_rd_data; 
wire [64 -1:0] bank12_ram0_rd_data; 
wire [64 -1:0] bank12_ram1_rd_data; 
wire [64 -1:0] bank13_ram0_rd_data; 
wire [64 -1:0] bank13_ram1_rd_data; 
wire [64 -1:0] bank14_ram0_rd_data; 
wire [64 -1:0] bank14_ram1_rd_data; 
wire [64 -1:0] bank15_ram0_rd_data; 
wire [64 -1:0] bank15_ram1_rd_data; 
wire [64 -1:0] bank16_ram0_rd_data; 
wire [64 -1:0] bank16_ram1_rd_data; 
wire [64 -1:0] bank17_ram0_rd_data; 
wire [64 -1:0] bank17_ram1_rd_data; 
wire [64 -1:0] bank18_ram0_rd_data; 
wire [64 -1:0] bank18_ram1_rd_data; 
wire [64 -1:0] bank19_ram0_rd_data; 
wire [64 -1:0] bank19_ram1_rd_data; 
wire [64 -1:0] bank20_ram0_rd_data; 
wire [64 -1:0] bank20_ram1_rd_data; 
wire [64 -1:0] bank21_ram0_rd_data; 
wire [64 -1:0] bank21_ram1_rd_data; 
wire [64 -1:0] bank22_ram0_rd_data; 
wire [64 -1:0] bank22_ram1_rd_data; 
wire [64 -1:0] bank23_ram0_rd_data; 
wire [64 -1:0] bank23_ram1_rd_data; 
wire [64 -1:0] bank24_ram0_rd_data; 
wire [64 -1:0] bank24_ram1_rd_data; 
wire [64 -1:0] bank25_ram0_rd_data; 
wire [64 -1:0] bank25_ram1_rd_data; 
wire [64 -1:0] bank26_ram0_rd_data; 
wire [64 -1:0] bank26_ram1_rd_data; 
wire [64 -1:0] bank27_ram0_rd_data; 
wire [64 -1:0] bank27_ram1_rd_data; 
wire [64 -1:0] bank28_ram0_rd_data; 
wire [64 -1:0] bank28_ram1_rd_data; 
wire [64 -1:0] bank29_ram0_rd_data; 
wire [64 -1:0] bank29_ram1_rd_data; 
wire [64 -1:0] bank30_ram0_rd_data; 
wire [64 -1:0] bank30_ram1_rd_data; 
wire [64 -1:0] bank31_ram0_rd_data; 
wire [64 -1:0] bank31_ram1_rd_data; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sc data read bank output data.
//: my $t1="";
//: my $kk=64;
//: if(1==0){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_data_rd_data = bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd_valid}}; );
//: }
//: }
//: if(1==1){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_data_rd0_data = (bank${j}_ram1_rd_data&{64{bank${j}_ram1_data_rd0_valid}})|
//: (bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd0_valid}});
//: wire [${kk}-1:0] bank${j}_data_rd1_data = (bank${j}_ram1_rd_data&{64{bank${j}_ram1_data_rd1_valid}})|
//: (bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd1_valid}});
//: );
//: }
//: }
//: if(1==2){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_data_rd_data = {bank${j}_ram1_rd_data&{64{bank${j}_ram1_data_rd_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd_valid}}};
//: );
//: }
//: }
//: if(1==3){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_data_rd0_data = {bank${j}_ram1_rd_data&{64{bank${j}_ram1_data_rd0_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd0_valid}}}|
//: {bank${j}_ram3_rd_data&{64{bank${j}_ram3_data_rd0_valid}},
//: bank${j}_ram2_rd_data&{64{bank${j}_ram2_data_rd0_valid}}};
//: wire [${kk}-1:0] bank${j}_data_rd1_data = {bank${j}_ram1_rd_data&{64{bank${j}_ram1_data_rd1_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd1_valid}}}|
//: {bank${j}_ram3_rd_data&{64{bank${j}_ram3_data_rd1_valid}},
//: bank${j}_ram2_rd_data&{64{bank${j}_ram2_data_rd1_valid}}};
//: );
//: }
//: }
//: if(1==4){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_data_rd_data = {bank${j}_ram3_rd_data&{64{bank${j}_ram3_data_rd_valid}},
//: bank${j}_ram2_rd_data&{64{bank${j}_ram2_data_rd_valid}},
//: bank${j}_ram1_rd_data&{64{bank${j}_ram1_data_rd_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd_valid}}};
//: );
//: }
//: }
//: if(1==5){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_data_rd0_data = {
//: bank${j}_ram3_rd_data&{64{bank${j}_ram3_data_rd0_valid}},
//: bank${j}_ram2_rd_data&{64{bank${j}_ram2_data_rd0_valid}},
//: bank${j}_ram1_rd_data&{64{bank${j}_ram1_data_rd0_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd0_valid}}}|
//: {bank${j}_ram7_rd_data&{64{bank${j}_ram7_data_rd0_valid}},
//: bank${j}_ram6_rd_data&{64{bank${j}_ram6_data_rd0_valid}},
//: bank${j}_ram5_rd_data&{64{bank${j}_ram5_data_rd0_valid}},
//: bank${j}_ram4_rd_data&{64{bank${j}_ram4_data_rd0_valid}}};
//: wire [${kk}-1:0] bank${j}_data_rd1_data = {
//: bank${j}_ram3_rd_data&{64{bank${j}_ram3_data_rd1_valid}},
//: bank${j}_ram2_rd_data&{64{bank${j}_ram2_data_rd1_valid}},
//: bank${j}_ram1_rd_data&{64{bank${j}_ram1_data_rd1_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_data_rd1_valid}}}|
//: {bank${j}_ram7_rd_data&{64{bank${j}_ram7_data_rd1_valid}},
//: bank${j}_ram6_rd_data&{64{bank${j}_ram6_data_rd1_valid}},
//: bank${j}_ram5_rd_data&{64{bank${j}_ram5_data_rd1_valid}},
//: bank${j}_ram4_rd_data&{64{bank${j}_ram4_data_rd1_valid}}};
//: );
//: }
//: }
//: my $kk=7;
//: &eperl::retime("-O sc2buf_dat_rd_shift_5T -i sc2buf_dat_rd_shift -wid ${kk} -stage 5 -clk nvdla_core_clk");
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [64-1:0] bank0_data_rd0_data = (bank0_ram1_rd_data&{64{bank0_ram1_data_rd0_valid}})|
(bank0_ram0_rd_data&{64{bank0_ram0_data_rd0_valid}});
wire [64-1:0] bank0_data_rd1_data = (bank0_ram1_rd_data&{64{bank0_ram1_data_rd1_valid}})|
(bank0_ram0_rd_data&{64{bank0_ram0_data_rd1_valid}});

wire [64-1:0] bank1_data_rd0_data = (bank1_ram1_rd_data&{64{bank1_ram1_data_rd0_valid}})|
(bank1_ram0_rd_data&{64{bank1_ram0_data_rd0_valid}});
wire [64-1:0] bank1_data_rd1_data = (bank1_ram1_rd_data&{64{bank1_ram1_data_rd1_valid}})|
(bank1_ram0_rd_data&{64{bank1_ram0_data_rd1_valid}});

wire [64-1:0] bank2_data_rd0_data = (bank2_ram1_rd_data&{64{bank2_ram1_data_rd0_valid}})|
(bank2_ram0_rd_data&{64{bank2_ram0_data_rd0_valid}});
wire [64-1:0] bank2_data_rd1_data = (bank2_ram1_rd_data&{64{bank2_ram1_data_rd1_valid}})|
(bank2_ram0_rd_data&{64{bank2_ram0_data_rd1_valid}});

wire [64-1:0] bank3_data_rd0_data = (bank3_ram1_rd_data&{64{bank3_ram1_data_rd0_valid}})|
(bank3_ram0_rd_data&{64{bank3_ram0_data_rd0_valid}});
wire [64-1:0] bank3_data_rd1_data = (bank3_ram1_rd_data&{64{bank3_ram1_data_rd1_valid}})|
(bank3_ram0_rd_data&{64{bank3_ram0_data_rd1_valid}});

wire [64-1:0] bank4_data_rd0_data = (bank4_ram1_rd_data&{64{bank4_ram1_data_rd0_valid}})|
(bank4_ram0_rd_data&{64{bank4_ram0_data_rd0_valid}});
wire [64-1:0] bank4_data_rd1_data = (bank4_ram1_rd_data&{64{bank4_ram1_data_rd1_valid}})|
(bank4_ram0_rd_data&{64{bank4_ram0_data_rd1_valid}});

wire [64-1:0] bank5_data_rd0_data = (bank5_ram1_rd_data&{64{bank5_ram1_data_rd0_valid}})|
(bank5_ram0_rd_data&{64{bank5_ram0_data_rd0_valid}});
wire [64-1:0] bank5_data_rd1_data = (bank5_ram1_rd_data&{64{bank5_ram1_data_rd1_valid}})|
(bank5_ram0_rd_data&{64{bank5_ram0_data_rd1_valid}});

wire [64-1:0] bank6_data_rd0_data = (bank6_ram1_rd_data&{64{bank6_ram1_data_rd0_valid}})|
(bank6_ram0_rd_data&{64{bank6_ram0_data_rd0_valid}});
wire [64-1:0] bank6_data_rd1_data = (bank6_ram1_rd_data&{64{bank6_ram1_data_rd1_valid}})|
(bank6_ram0_rd_data&{64{bank6_ram0_data_rd1_valid}});

wire [64-1:0] bank7_data_rd0_data = (bank7_ram1_rd_data&{64{bank7_ram1_data_rd0_valid}})|
(bank7_ram0_rd_data&{64{bank7_ram0_data_rd0_valid}});
wire [64-1:0] bank7_data_rd1_data = (bank7_ram1_rd_data&{64{bank7_ram1_data_rd1_valid}})|
(bank7_ram0_rd_data&{64{bank7_ram0_data_rd1_valid}});

wire [64-1:0] bank8_data_rd0_data = (bank8_ram1_rd_data&{64{bank8_ram1_data_rd0_valid}})|
(bank8_ram0_rd_data&{64{bank8_ram0_data_rd0_valid}});
wire [64-1:0] bank8_data_rd1_data = (bank8_ram1_rd_data&{64{bank8_ram1_data_rd1_valid}})|
(bank8_ram0_rd_data&{64{bank8_ram0_data_rd1_valid}});

wire [64-1:0] bank9_data_rd0_data = (bank9_ram1_rd_data&{64{bank9_ram1_data_rd0_valid}})|
(bank9_ram0_rd_data&{64{bank9_ram0_data_rd0_valid}});
wire [64-1:0] bank9_data_rd1_data = (bank9_ram1_rd_data&{64{bank9_ram1_data_rd1_valid}})|
(bank9_ram0_rd_data&{64{bank9_ram0_data_rd1_valid}});

wire [64-1:0] bank10_data_rd0_data = (bank10_ram1_rd_data&{64{bank10_ram1_data_rd0_valid}})|
(bank10_ram0_rd_data&{64{bank10_ram0_data_rd0_valid}});
wire [64-1:0] bank10_data_rd1_data = (bank10_ram1_rd_data&{64{bank10_ram1_data_rd1_valid}})|
(bank10_ram0_rd_data&{64{bank10_ram0_data_rd1_valid}});

wire [64-1:0] bank11_data_rd0_data = (bank11_ram1_rd_data&{64{bank11_ram1_data_rd0_valid}})|
(bank11_ram0_rd_data&{64{bank11_ram0_data_rd0_valid}});
wire [64-1:0] bank11_data_rd1_data = (bank11_ram1_rd_data&{64{bank11_ram1_data_rd1_valid}})|
(bank11_ram0_rd_data&{64{bank11_ram0_data_rd1_valid}});

wire [64-1:0] bank12_data_rd0_data = (bank12_ram1_rd_data&{64{bank12_ram1_data_rd0_valid}})|
(bank12_ram0_rd_data&{64{bank12_ram0_data_rd0_valid}});
wire [64-1:0] bank12_data_rd1_data = (bank12_ram1_rd_data&{64{bank12_ram1_data_rd1_valid}})|
(bank12_ram0_rd_data&{64{bank12_ram0_data_rd1_valid}});

wire [64-1:0] bank13_data_rd0_data = (bank13_ram1_rd_data&{64{bank13_ram1_data_rd0_valid}})|
(bank13_ram0_rd_data&{64{bank13_ram0_data_rd0_valid}});
wire [64-1:0] bank13_data_rd1_data = (bank13_ram1_rd_data&{64{bank13_ram1_data_rd1_valid}})|
(bank13_ram0_rd_data&{64{bank13_ram0_data_rd1_valid}});

wire [64-1:0] bank14_data_rd0_data = (bank14_ram1_rd_data&{64{bank14_ram1_data_rd0_valid}})|
(bank14_ram0_rd_data&{64{bank14_ram0_data_rd0_valid}});
wire [64-1:0] bank14_data_rd1_data = (bank14_ram1_rd_data&{64{bank14_ram1_data_rd1_valid}})|
(bank14_ram0_rd_data&{64{bank14_ram0_data_rd1_valid}});

wire [64-1:0] bank15_data_rd0_data = (bank15_ram1_rd_data&{64{bank15_ram1_data_rd0_valid}})|
(bank15_ram0_rd_data&{64{bank15_ram0_data_rd0_valid}});
wire [64-1:0] bank15_data_rd1_data = (bank15_ram1_rd_data&{64{bank15_ram1_data_rd1_valid}})|
(bank15_ram0_rd_data&{64{bank15_ram0_data_rd1_valid}});

wire [64-1:0] bank16_data_rd0_data = (bank16_ram1_rd_data&{64{bank16_ram1_data_rd0_valid}})|
(bank16_ram0_rd_data&{64{bank16_ram0_data_rd0_valid}});
wire [64-1:0] bank16_data_rd1_data = (bank16_ram1_rd_data&{64{bank16_ram1_data_rd1_valid}})|
(bank16_ram0_rd_data&{64{bank16_ram0_data_rd1_valid}});

wire [64-1:0] bank17_data_rd0_data = (bank17_ram1_rd_data&{64{bank17_ram1_data_rd0_valid}})|
(bank17_ram0_rd_data&{64{bank17_ram0_data_rd0_valid}});
wire [64-1:0] bank17_data_rd1_data = (bank17_ram1_rd_data&{64{bank17_ram1_data_rd1_valid}})|
(bank17_ram0_rd_data&{64{bank17_ram0_data_rd1_valid}});

wire [64-1:0] bank18_data_rd0_data = (bank18_ram1_rd_data&{64{bank18_ram1_data_rd0_valid}})|
(bank18_ram0_rd_data&{64{bank18_ram0_data_rd0_valid}});
wire [64-1:0] bank18_data_rd1_data = (bank18_ram1_rd_data&{64{bank18_ram1_data_rd1_valid}})|
(bank18_ram0_rd_data&{64{bank18_ram0_data_rd1_valid}});

wire [64-1:0] bank19_data_rd0_data = (bank19_ram1_rd_data&{64{bank19_ram1_data_rd0_valid}})|
(bank19_ram0_rd_data&{64{bank19_ram0_data_rd0_valid}});
wire [64-1:0] bank19_data_rd1_data = (bank19_ram1_rd_data&{64{bank19_ram1_data_rd1_valid}})|
(bank19_ram0_rd_data&{64{bank19_ram0_data_rd1_valid}});

wire [64-1:0] bank20_data_rd0_data = (bank20_ram1_rd_data&{64{bank20_ram1_data_rd0_valid}})|
(bank20_ram0_rd_data&{64{bank20_ram0_data_rd0_valid}});
wire [64-1:0] bank20_data_rd1_data = (bank20_ram1_rd_data&{64{bank20_ram1_data_rd1_valid}})|
(bank20_ram0_rd_data&{64{bank20_ram0_data_rd1_valid}});

wire [64-1:0] bank21_data_rd0_data = (bank21_ram1_rd_data&{64{bank21_ram1_data_rd0_valid}})|
(bank21_ram0_rd_data&{64{bank21_ram0_data_rd0_valid}});
wire [64-1:0] bank21_data_rd1_data = (bank21_ram1_rd_data&{64{bank21_ram1_data_rd1_valid}})|
(bank21_ram0_rd_data&{64{bank21_ram0_data_rd1_valid}});

wire [64-1:0] bank22_data_rd0_data = (bank22_ram1_rd_data&{64{bank22_ram1_data_rd0_valid}})|
(bank22_ram0_rd_data&{64{bank22_ram0_data_rd0_valid}});
wire [64-1:0] bank22_data_rd1_data = (bank22_ram1_rd_data&{64{bank22_ram1_data_rd1_valid}})|
(bank22_ram0_rd_data&{64{bank22_ram0_data_rd1_valid}});

wire [64-1:0] bank23_data_rd0_data = (bank23_ram1_rd_data&{64{bank23_ram1_data_rd0_valid}})|
(bank23_ram0_rd_data&{64{bank23_ram0_data_rd0_valid}});
wire [64-1:0] bank23_data_rd1_data = (bank23_ram1_rd_data&{64{bank23_ram1_data_rd1_valid}})|
(bank23_ram0_rd_data&{64{bank23_ram0_data_rd1_valid}});

wire [64-1:0] bank24_data_rd0_data = (bank24_ram1_rd_data&{64{bank24_ram1_data_rd0_valid}})|
(bank24_ram0_rd_data&{64{bank24_ram0_data_rd0_valid}});
wire [64-1:0] bank24_data_rd1_data = (bank24_ram1_rd_data&{64{bank24_ram1_data_rd1_valid}})|
(bank24_ram0_rd_data&{64{bank24_ram0_data_rd1_valid}});

wire [64-1:0] bank25_data_rd0_data = (bank25_ram1_rd_data&{64{bank25_ram1_data_rd0_valid}})|
(bank25_ram0_rd_data&{64{bank25_ram0_data_rd0_valid}});
wire [64-1:0] bank25_data_rd1_data = (bank25_ram1_rd_data&{64{bank25_ram1_data_rd1_valid}})|
(bank25_ram0_rd_data&{64{bank25_ram0_data_rd1_valid}});

wire [64-1:0] bank26_data_rd0_data = (bank26_ram1_rd_data&{64{bank26_ram1_data_rd0_valid}})|
(bank26_ram0_rd_data&{64{bank26_ram0_data_rd0_valid}});
wire [64-1:0] bank26_data_rd1_data = (bank26_ram1_rd_data&{64{bank26_ram1_data_rd1_valid}})|
(bank26_ram0_rd_data&{64{bank26_ram0_data_rd1_valid}});

wire [64-1:0] bank27_data_rd0_data = (bank27_ram1_rd_data&{64{bank27_ram1_data_rd0_valid}})|
(bank27_ram0_rd_data&{64{bank27_ram0_data_rd0_valid}});
wire [64-1:0] bank27_data_rd1_data = (bank27_ram1_rd_data&{64{bank27_ram1_data_rd1_valid}})|
(bank27_ram0_rd_data&{64{bank27_ram0_data_rd1_valid}});

wire [64-1:0] bank28_data_rd0_data = (bank28_ram1_rd_data&{64{bank28_ram1_data_rd0_valid}})|
(bank28_ram0_rd_data&{64{bank28_ram0_data_rd0_valid}});
wire [64-1:0] bank28_data_rd1_data = (bank28_ram1_rd_data&{64{bank28_ram1_data_rd1_valid}})|
(bank28_ram0_rd_data&{64{bank28_ram0_data_rd1_valid}});

wire [64-1:0] bank29_data_rd0_data = (bank29_ram1_rd_data&{64{bank29_ram1_data_rd0_valid}})|
(bank29_ram0_rd_data&{64{bank29_ram0_data_rd0_valid}});
wire [64-1:0] bank29_data_rd1_data = (bank29_ram1_rd_data&{64{bank29_ram1_data_rd1_valid}})|
(bank29_ram0_rd_data&{64{bank29_ram0_data_rd1_valid}});

wire [64-1:0] bank30_data_rd0_data = (bank30_ram1_rd_data&{64{bank30_ram1_data_rd0_valid}})|
(bank30_ram0_rd_data&{64{bank30_ram0_data_rd0_valid}});
wire [64-1:0] bank30_data_rd1_data = (bank30_ram1_rd_data&{64{bank30_ram1_data_rd1_valid}})|
(bank30_ram0_rd_data&{64{bank30_ram0_data_rd1_valid}});

wire [64-1:0] bank31_data_rd0_data = (bank31_ram1_rd_data&{64{bank31_ram1_data_rd0_valid}})|
(bank31_ram0_rd_data&{64{bank31_ram0_data_rd0_valid}});
wire [64-1:0] bank31_data_rd1_data = (bank31_ram1_rd_data&{64{bank31_ram1_data_rd1_valid}})|
(bank31_ram0_rd_data&{64{bank31_ram0_data_rd1_valid}});
reg [7-1:0] sc2buf_dat_rd_shift_d1;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_shift_d1[7-1:0] <= sc2buf_dat_rd_shift[7-1:0];
end

reg [7-1:0] sc2buf_dat_rd_shift_d2;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_shift_d2[7-1:0] <= sc2buf_dat_rd_shift_d1[7-1:0];
end

reg [7-1:0] sc2buf_dat_rd_shift_d3;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_shift_d3[7-1:0] <= sc2buf_dat_rd_shift_d2[7-1:0];
end

reg [7-1:0] sc2buf_dat_rd_shift_d4;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_shift_d4[7-1:0] <= sc2buf_dat_rd_shift_d3[7-1:0];
end

reg [7-1:0] sc2buf_dat_rd_shift_d5;
always @(posedge nvdla_core_clk) begin
        sc2buf_dat_rd_shift_d5[7-1:0] <= sc2buf_dat_rd_shift_d4[7-1:0];
end

wire [7-1:0] sc2buf_dat_rd_shift_5T;
assign sc2buf_dat_rd_shift_5T = sc2buf_dat_rd_shift_d5;


//| eperl: generated_end (DO NOT EDIT ABOVE)
// pipe solution. for timing concern, 4 level pipe.
//: my $kk=64;
//: if((1==0)||(1==2)||(1==4)){
//: for (my $i=0; $i<32; $i++){
//: &eperl::flop("-wid ${kk} -norst -q l1group${i}_data_rd_data   -d bank${i}_data_rd_data");
//: }
//:
//: for (my $i=0; $i<32/4; $i++){
//: my $ni=$i*4;
//: my $nii=$i*4+1;
//: my $niii=$i*4+2;
//: my $niiii=$i*4+3;
//: print qq(
//: wire [${kk}-1:0] l2group${i}_data_rd_data_w = l1group${ni}_data_rd_data | l1group${nii}_data_rd_data | l1group${niii}_data_rd_data | l1group${niiii}_data_rd_data;
//: );
//: &eperl::flop("-wid ${kk} -norst -q l2group${i}_data_rd_data   -d l2group${i}_data_rd_data_w");
//: }
//:
//: for (my $i=0; $i<32/16; $i++){
//: my $ni=$i*4;
//: my $nii=$i*4+1;
//: my $niii=$i*4+2;
//: my $niiii=$i*4+3;
//: print qq(
//: wire [${kk}-1:0] l3group${i}_data_rd_data_w = l2group${ni}_data_rd_data | l2group${nii}_data_rd_data | l2group${niii}_data_rd_data | l2group${niiii}_data_rd_data;
//: );
//: &eperl::flop("-wid ${kk} -norst -q l3group${i}_data_rd_data   -d l3group${i}_data_rd_data_w");
//: }
//:
//: if(32==16){
//: &eperl::flop("-wid ${kk} -norst -q l4group_data_rd_data   -d l3group0_data_rd_data");
//: }
//: if(32==32) {
//: print qq(
//: wire [${kk}-1:0] l4group_data_rd_data_w = l3group0_data_rd_data | l3group1_data_rd_data;
//: );
//: &eperl::flop("-wid ${kk} -norst -q l4group_data_rd_data   -d l4group_data_rd_data_w");
//: }
//: print "wire[${kk}-1:0] sc2buf_dat_rd_data = l4group_data_rd_data[${kk}-1:0]; \n";
//: }
//:
//:
//: my $kk=64;
//: if((1==1)||(1==3)||(1==5)){
//: for (my $i=0; $i<32; $i++){
//: &eperl::flop("-wid ${kk} -norst -q l1group${i}_data_rd0_data   -d bank${i}_data_rd0_data");
//: &eperl::flop("-wid ${kk} -norst -q l1group${i}_data_rd1_data   -d bank${i}_data_rd1_data");
//: }
//:
//: for (my $i=0; $i<32/4; $i++){
//: my $ni=$i*4;
//: my $nii=$i*4+1;
//: my $niii=$i*4+2;
//: my $niiii=$i*4+3;
//: print qq(
//: wire [${kk}-1:0] l2group${i}_data_rd0_data_w = l1group${ni}_data_rd0_data | l1group${nii}_data_rd0_data | l1group${niii}_data_rd0_data | l1group${niiii}_data_rd0_data;
//: wire [${kk}-1:0] l2group${i}_data_rd1_data_w = l1group${ni}_data_rd1_data | l1group${nii}_data_rd1_data | l1group${niii}_data_rd1_data | l1group${niiii}_data_rd1_data;
//: );
//: &eperl::flop("-wid ${kk} -norst -q l2group${i}_data_rd0_data   -d l2group${i}_data_rd0_data_w");
//: &eperl::flop("-wid ${kk} -norst -q l2group${i}_data_rd1_data   -d l2group${i}_data_rd1_data_w");
//: }
//:
//: for (my $i=0; $i<32/16; $i++){
//: my $ni=$i*4;
//: my $nii=$i*4+1;
//: my $niii=$i*4+2;
//: my $niiii=$i*4+3;
//: print qq(
//: wire [${kk}-1:0] l3group${i}_data_rd0_data_w = l2group${ni}_data_rd0_data | l2group${nii}_data_rd0_data | l2group${niii}_data_rd0_data | l2group${niiii}_data_rd0_data;
//: wire [${kk}-1:0] l3group${i}_data_rd1_data_w = l2group${ni}_data_rd1_data | l2group${nii}_data_rd1_data | l2group${niii}_data_rd1_data | l2group${niiii}_data_rd1_data;
//: );
//: &eperl::flop("-wid ${kk} -norst -q l3group${i}_data_rd0_data   -d l3group${i}_data_rd0_data_w");
//: &eperl::flop("-wid ${kk} -norst -q l3group${i}_data_rd1_data   -d l3group${i}_data_rd1_data_w");
//: }
//:
//: if(32==16){
//: print qq(
//: wire [${kk}-1:0] l4group_data_rd0_data = l3group0_data_rd0_data;
//: wire [${kk}-1:0] l4group_data_rd1_data = l3group0_data_rd1_data;
//: );
//: }
//: if(32==32) {
//: print qq(
//: wire [${kk}-1:0] l4group_data_rd0_data = l3group0_data_rd0_data | l3group1_data_rd0_data;
//: wire [${kk}-1:0] l4group_data_rd1_data = l3group0_data_rd1_data | l3group1_data_rd1_data;
//: );
//: }
//: print qq(
//: wire [${kk}*2-1:0] l4group_data_rd_data_w = {l4group_data_rd1_data,l4group_data_rd0_data}>>{sc2buf_dat_rd_shift_5T,3'b0};
//: );
//: &eperl::flop("-wid ${kk} -norst -q l4group_data_rd_data   -d l4group_data_rd_data_w[${kk}-1:0]");
//: print "wire[${kk}-1:0] sc2buf_dat_rd_data = l4group_data_rd_data[${kk}-1:0]; \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [63:0] l1group0_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group0_data_rd0_data <= bank0_data_rd0_data;
end
reg [63:0] l1group0_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group0_data_rd1_data <= bank0_data_rd1_data;
end
reg [63:0] l1group1_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group1_data_rd0_data <= bank1_data_rd0_data;
end
reg [63:0] l1group1_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group1_data_rd1_data <= bank1_data_rd1_data;
end
reg [63:0] l1group2_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group2_data_rd0_data <= bank2_data_rd0_data;
end
reg [63:0] l1group2_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group2_data_rd1_data <= bank2_data_rd1_data;
end
reg [63:0] l1group3_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group3_data_rd0_data <= bank3_data_rd0_data;
end
reg [63:0] l1group3_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group3_data_rd1_data <= bank3_data_rd1_data;
end
reg [63:0] l1group4_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group4_data_rd0_data <= bank4_data_rd0_data;
end
reg [63:0] l1group4_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group4_data_rd1_data <= bank4_data_rd1_data;
end
reg [63:0] l1group5_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group5_data_rd0_data <= bank5_data_rd0_data;
end
reg [63:0] l1group5_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group5_data_rd1_data <= bank5_data_rd1_data;
end
reg [63:0] l1group6_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group6_data_rd0_data <= bank6_data_rd0_data;
end
reg [63:0] l1group6_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group6_data_rd1_data <= bank6_data_rd1_data;
end
reg [63:0] l1group7_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group7_data_rd0_data <= bank7_data_rd0_data;
end
reg [63:0] l1group7_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group7_data_rd1_data <= bank7_data_rd1_data;
end
reg [63:0] l1group8_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group8_data_rd0_data <= bank8_data_rd0_data;
end
reg [63:0] l1group8_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group8_data_rd1_data <= bank8_data_rd1_data;
end
reg [63:0] l1group9_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group9_data_rd0_data <= bank9_data_rd0_data;
end
reg [63:0] l1group9_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group9_data_rd1_data <= bank9_data_rd1_data;
end
reg [63:0] l1group10_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group10_data_rd0_data <= bank10_data_rd0_data;
end
reg [63:0] l1group10_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group10_data_rd1_data <= bank10_data_rd1_data;
end
reg [63:0] l1group11_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group11_data_rd0_data <= bank11_data_rd0_data;
end
reg [63:0] l1group11_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group11_data_rd1_data <= bank11_data_rd1_data;
end
reg [63:0] l1group12_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group12_data_rd0_data <= bank12_data_rd0_data;
end
reg [63:0] l1group12_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group12_data_rd1_data <= bank12_data_rd1_data;
end
reg [63:0] l1group13_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group13_data_rd0_data <= bank13_data_rd0_data;
end
reg [63:0] l1group13_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group13_data_rd1_data <= bank13_data_rd1_data;
end
reg [63:0] l1group14_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group14_data_rd0_data <= bank14_data_rd0_data;
end
reg [63:0] l1group14_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group14_data_rd1_data <= bank14_data_rd1_data;
end
reg [63:0] l1group15_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group15_data_rd0_data <= bank15_data_rd0_data;
end
reg [63:0] l1group15_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group15_data_rd1_data <= bank15_data_rd1_data;
end
reg [63:0] l1group16_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group16_data_rd0_data <= bank16_data_rd0_data;
end
reg [63:0] l1group16_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group16_data_rd1_data <= bank16_data_rd1_data;
end
reg [63:0] l1group17_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group17_data_rd0_data <= bank17_data_rd0_data;
end
reg [63:0] l1group17_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group17_data_rd1_data <= bank17_data_rd1_data;
end
reg [63:0] l1group18_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group18_data_rd0_data <= bank18_data_rd0_data;
end
reg [63:0] l1group18_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group18_data_rd1_data <= bank18_data_rd1_data;
end
reg [63:0] l1group19_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group19_data_rd0_data <= bank19_data_rd0_data;
end
reg [63:0] l1group19_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group19_data_rd1_data <= bank19_data_rd1_data;
end
reg [63:0] l1group20_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group20_data_rd0_data <= bank20_data_rd0_data;
end
reg [63:0] l1group20_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group20_data_rd1_data <= bank20_data_rd1_data;
end
reg [63:0] l1group21_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group21_data_rd0_data <= bank21_data_rd0_data;
end
reg [63:0] l1group21_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group21_data_rd1_data <= bank21_data_rd1_data;
end
reg [63:0] l1group22_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group22_data_rd0_data <= bank22_data_rd0_data;
end
reg [63:0] l1group22_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group22_data_rd1_data <= bank22_data_rd1_data;
end
reg [63:0] l1group23_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group23_data_rd0_data <= bank23_data_rd0_data;
end
reg [63:0] l1group23_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group23_data_rd1_data <= bank23_data_rd1_data;
end
reg [63:0] l1group24_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group24_data_rd0_data <= bank24_data_rd0_data;
end
reg [63:0] l1group24_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group24_data_rd1_data <= bank24_data_rd1_data;
end
reg [63:0] l1group25_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group25_data_rd0_data <= bank25_data_rd0_data;
end
reg [63:0] l1group25_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group25_data_rd1_data <= bank25_data_rd1_data;
end
reg [63:0] l1group26_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group26_data_rd0_data <= bank26_data_rd0_data;
end
reg [63:0] l1group26_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group26_data_rd1_data <= bank26_data_rd1_data;
end
reg [63:0] l1group27_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group27_data_rd0_data <= bank27_data_rd0_data;
end
reg [63:0] l1group27_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group27_data_rd1_data <= bank27_data_rd1_data;
end
reg [63:0] l1group28_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group28_data_rd0_data <= bank28_data_rd0_data;
end
reg [63:0] l1group28_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group28_data_rd1_data <= bank28_data_rd1_data;
end
reg [63:0] l1group29_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group29_data_rd0_data <= bank29_data_rd0_data;
end
reg [63:0] l1group29_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group29_data_rd1_data <= bank29_data_rd1_data;
end
reg [63:0] l1group30_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group30_data_rd0_data <= bank30_data_rd0_data;
end
reg [63:0] l1group30_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group30_data_rd1_data <= bank30_data_rd1_data;
end
reg [63:0] l1group31_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l1group31_data_rd0_data <= bank31_data_rd0_data;
end
reg [63:0] l1group31_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l1group31_data_rd1_data <= bank31_data_rd1_data;
end

wire [64-1:0] l2group0_data_rd0_data_w = l1group0_data_rd0_data | l1group1_data_rd0_data | l1group2_data_rd0_data | l1group3_data_rd0_data;
wire [64-1:0] l2group0_data_rd1_data_w = l1group0_data_rd1_data | l1group1_data_rd1_data | l1group2_data_rd1_data | l1group3_data_rd1_data;
reg [63:0] l2group0_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l2group0_data_rd0_data <= l2group0_data_rd0_data_w;
end
reg [63:0] l2group0_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l2group0_data_rd1_data <= l2group0_data_rd1_data_w;
end

wire [64-1:0] l2group1_data_rd0_data_w = l1group4_data_rd0_data | l1group5_data_rd0_data | l1group6_data_rd0_data | l1group7_data_rd0_data;
wire [64-1:0] l2group1_data_rd1_data_w = l1group4_data_rd1_data | l1group5_data_rd1_data | l1group6_data_rd1_data | l1group7_data_rd1_data;
reg [63:0] l2group1_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l2group1_data_rd0_data <= l2group1_data_rd0_data_w;
end
reg [63:0] l2group1_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l2group1_data_rd1_data <= l2group1_data_rd1_data_w;
end

wire [64-1:0] l2group2_data_rd0_data_w = l1group8_data_rd0_data | l1group9_data_rd0_data | l1group10_data_rd0_data | l1group11_data_rd0_data;
wire [64-1:0] l2group2_data_rd1_data_w = l1group8_data_rd1_data | l1group9_data_rd1_data | l1group10_data_rd1_data | l1group11_data_rd1_data;
reg [63:0] l2group2_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l2group2_data_rd0_data <= l2group2_data_rd0_data_w;
end
reg [63:0] l2group2_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l2group2_data_rd1_data <= l2group2_data_rd1_data_w;
end

wire [64-1:0] l2group3_data_rd0_data_w = l1group12_data_rd0_data | l1group13_data_rd0_data | l1group14_data_rd0_data | l1group15_data_rd0_data;
wire [64-1:0] l2group3_data_rd1_data_w = l1group12_data_rd1_data | l1group13_data_rd1_data | l1group14_data_rd1_data | l1group15_data_rd1_data;
reg [63:0] l2group3_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l2group3_data_rd0_data <= l2group3_data_rd0_data_w;
end
reg [63:0] l2group3_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l2group3_data_rd1_data <= l2group3_data_rd1_data_w;
end

wire [64-1:0] l2group4_data_rd0_data_w = l1group16_data_rd0_data | l1group17_data_rd0_data | l1group18_data_rd0_data | l1group19_data_rd0_data;
wire [64-1:0] l2group4_data_rd1_data_w = l1group16_data_rd1_data | l1group17_data_rd1_data | l1group18_data_rd1_data | l1group19_data_rd1_data;
reg [63:0] l2group4_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l2group4_data_rd0_data <= l2group4_data_rd0_data_w;
end
reg [63:0] l2group4_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l2group4_data_rd1_data <= l2group4_data_rd1_data_w;
end

wire [64-1:0] l2group5_data_rd0_data_w = l1group20_data_rd0_data | l1group21_data_rd0_data | l1group22_data_rd0_data | l1group23_data_rd0_data;
wire [64-1:0] l2group5_data_rd1_data_w = l1group20_data_rd1_data | l1group21_data_rd1_data | l1group22_data_rd1_data | l1group23_data_rd1_data;
reg [63:0] l2group5_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l2group5_data_rd0_data <= l2group5_data_rd0_data_w;
end
reg [63:0] l2group5_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l2group5_data_rd1_data <= l2group5_data_rd1_data_w;
end

wire [64-1:0] l2group6_data_rd0_data_w = l1group24_data_rd0_data | l1group25_data_rd0_data | l1group26_data_rd0_data | l1group27_data_rd0_data;
wire [64-1:0] l2group6_data_rd1_data_w = l1group24_data_rd1_data | l1group25_data_rd1_data | l1group26_data_rd1_data | l1group27_data_rd1_data;
reg [63:0] l2group6_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l2group6_data_rd0_data <= l2group6_data_rd0_data_w;
end
reg [63:0] l2group6_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l2group6_data_rd1_data <= l2group6_data_rd1_data_w;
end

wire [64-1:0] l2group7_data_rd0_data_w = l1group28_data_rd0_data | l1group29_data_rd0_data | l1group30_data_rd0_data | l1group31_data_rd0_data;
wire [64-1:0] l2group7_data_rd1_data_w = l1group28_data_rd1_data | l1group29_data_rd1_data | l1group30_data_rd1_data | l1group31_data_rd1_data;
reg [63:0] l2group7_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l2group7_data_rd0_data <= l2group7_data_rd0_data_w;
end
reg [63:0] l2group7_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l2group7_data_rd1_data <= l2group7_data_rd1_data_w;
end

wire [64-1:0] l3group0_data_rd0_data_w = l2group0_data_rd0_data | l2group1_data_rd0_data | l2group2_data_rd0_data | l2group3_data_rd0_data;
wire [64-1:0] l3group0_data_rd1_data_w = l2group0_data_rd1_data | l2group1_data_rd1_data | l2group2_data_rd1_data | l2group3_data_rd1_data;
reg [63:0] l3group0_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l3group0_data_rd0_data <= l3group0_data_rd0_data_w;
end
reg [63:0] l3group0_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l3group0_data_rd1_data <= l3group0_data_rd1_data_w;
end

wire [64-1:0] l3group1_data_rd0_data_w = l2group4_data_rd0_data | l2group5_data_rd0_data | l2group6_data_rd0_data | l2group7_data_rd0_data;
wire [64-1:0] l3group1_data_rd1_data_w = l2group4_data_rd1_data | l2group5_data_rd1_data | l2group6_data_rd1_data | l2group7_data_rd1_data;
reg [63:0] l3group1_data_rd0_data;
always @(posedge nvdla_core_clk) begin
       l3group1_data_rd0_data <= l3group1_data_rd0_data_w;
end
reg [63:0] l3group1_data_rd1_data;
always @(posedge nvdla_core_clk) begin
       l3group1_data_rd1_data <= l3group1_data_rd1_data_w;
end

wire [64-1:0] l4group_data_rd0_data = l3group0_data_rd0_data | l3group1_data_rd0_data;
wire [64-1:0] l4group_data_rd1_data = l3group0_data_rd1_data | l3group1_data_rd1_data;

wire [64*2-1:0] l4group_data_rd_data_w = {l4group_data_rd1_data,l4group_data_rd0_data}>>{sc2buf_dat_rd_shift_5T,3'b0};
reg [63:0] l4group_data_rd_data;
always @(posedge nvdla_core_clk) begin
       l4group_data_rd_data <= l4group_data_rd_data_w[64-1:0];
end
wire[64-1:0] sc2buf_dat_rd_data = l4group_data_rd_data[64-1:0]; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
////get sc data read data. no pipe
////: my $t1="";
////: my $t2="";
////: my $kk=CBUF_RD_PORT_WIDTH;
////: if((CBUF_BANK_RAM_CASE==0)||(CBUF_BANK_RAM_CASE==2)||(CBUF_BANK_RAM_CASE==4)){
////:     for(my $j=0; $j<CBUF_BANK_NUMBER ; $j++){
////:         $t1 .= "bank${j}_data_rd_data|";    
////:     }
////: print "wire[${kk}-1:0] sc2buf_dat_rd_data =".${t1}."{${kk}{1'b0}}; \n";
////: }
////:     
////: if((CBUF_BANK_RAM_CASE==1)|(CBUF_BANK_RAM_CASE==3)||(CBUF_BANK_RAM_CASE==5)){
////:     for(my $j=0; $j<CBUF_BANK_NUMBER ; $j++){
////:         $t1 .= "bank${j}_data_rd0_data|";    
////:         $t2 .= "bank${j}_data_rd1_data|";    
////:     }
////: print "wire[${kk}-1:0] sc2buf_dat_rd_data0 =".${t1}."{${kk}{1'b0}}; \n";
////: print "wire[${kk}-1:0] sc2buf_dat_rd_data1 =".${t2}."{${kk}{1'b0}}; \n";
////: }
////:
//wire[64*2-1:0] sc2buf_dat_rd_data_temp = {sc2buf_dat_rd_data1,sc2buf_dat_rd_data0} >> {sc2buf_dat_rd_shift_5T,3'b0};
//wire[64 -1:0] sc2buf_dat_rd_data = sc2buf_dat_rd_data_temp[64 -1:0];
/////////////////////step3: read weight handle
//decode read weight address to sram.
//: my $bank_slice= "13:9"; #address part for select bank
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: my $kdiv2 = int($k/2);
//: my $kdiv4 = int($k/4);
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire bank${j}_ram${k}_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[${bank_slice}]==${j}); )
//: }
//: if(1==1){
//: print qq(
//: wire bank${j}_ram${k}_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[${bank_slice}]==${j})&&(sc2buf_wt_rd_addr[0]==${k}); )
//: }
//: if(1==3){
//: print qq(
//: wire bank${j}_ram${k}_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[${bank_slice}]==${j})&&(sc2buf_wt_rd_addr[0]==${kdiv2}); )
//: }
//: if(1==5){
//: print qq(
//: wire bank${j}_ram${k}_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[${bank_slice}]==${j})&&(sc2buf_wt_rd_addr[0]==${kdiv4}); )
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire bank0_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==0)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank0_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==0)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank1_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==1)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank1_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==1)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank2_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==2)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank2_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==2)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank3_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==3)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank3_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==3)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank4_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==4)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank4_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==4)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank5_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==5)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank5_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==5)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank6_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==6)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank6_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==6)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank7_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==7)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank7_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==7)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank8_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==8)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank8_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==8)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank9_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==9)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank9_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==9)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank10_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==10)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank10_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==10)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank11_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==11)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank11_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==11)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank12_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==12)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank12_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==12)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank13_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==13)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank13_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==13)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank14_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==14)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank14_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==14)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank15_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==15)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank15_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==15)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank16_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==16)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank16_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==16)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank17_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==17)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank17_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==17)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank18_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==18)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank18_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==18)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank19_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==19)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank19_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==19)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank20_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==20)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank20_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==20)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank21_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==21)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank21_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==21)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank22_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==22)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank22_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==22)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank23_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==23)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank23_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==23)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank24_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==24)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank24_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==24)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank25_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==25)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank25_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==25)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank26_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==26)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank26_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==26)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank27_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==27)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank27_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==27)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank28_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==28)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank28_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==28)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank29_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==29)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank29_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==29)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank30_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==30)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank30_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==30)&&(sc2buf_wt_rd_addr[0]==1); 
wire bank31_ram0_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==31)&&(sc2buf_wt_rd_addr[0]==0); 
wire bank31_ram1_wt_rd_en = sc2buf_wt_rd_en&&(sc2buf_wt_rd_addr[13:9]==31)&&(sc2buf_wt_rd_addr[0]==1); 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sram weight read address.
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire [9 -1 -1:0] bank${j}_ram${k}_wt_rd_addr = {9 -1{bank${j}_ram${k}_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1 -1:0]); )
//: }
//: if((1==1)||(1==3)||(1==5)){
//: print qq(
//: wire [9 -1 -1:0] bank${j}_ram${k}_wt_rd_addr = {9 -1{bank${j}_ram${k}_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); )
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [9 -1 -1:0] bank0_ram0_wt_rd_addr = {9 -1{bank0_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank0_ram1_wt_rd_addr = {9 -1{bank0_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank1_ram0_wt_rd_addr = {9 -1{bank1_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank1_ram1_wt_rd_addr = {9 -1{bank1_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank2_ram0_wt_rd_addr = {9 -1{bank2_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank2_ram1_wt_rd_addr = {9 -1{bank2_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank3_ram0_wt_rd_addr = {9 -1{bank3_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank3_ram1_wt_rd_addr = {9 -1{bank3_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank4_ram0_wt_rd_addr = {9 -1{bank4_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank4_ram1_wt_rd_addr = {9 -1{bank4_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank5_ram0_wt_rd_addr = {9 -1{bank5_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank5_ram1_wt_rd_addr = {9 -1{bank5_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank6_ram0_wt_rd_addr = {9 -1{bank6_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank6_ram1_wt_rd_addr = {9 -1{bank6_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank7_ram0_wt_rd_addr = {9 -1{bank7_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank7_ram1_wt_rd_addr = {9 -1{bank7_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank8_ram0_wt_rd_addr = {9 -1{bank8_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank8_ram1_wt_rd_addr = {9 -1{bank8_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank9_ram0_wt_rd_addr = {9 -1{bank9_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank9_ram1_wt_rd_addr = {9 -1{bank9_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank10_ram0_wt_rd_addr = {9 -1{bank10_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank10_ram1_wt_rd_addr = {9 -1{bank10_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank11_ram0_wt_rd_addr = {9 -1{bank11_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank11_ram1_wt_rd_addr = {9 -1{bank11_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank12_ram0_wt_rd_addr = {9 -1{bank12_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank12_ram1_wt_rd_addr = {9 -1{bank12_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank13_ram0_wt_rd_addr = {9 -1{bank13_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank13_ram1_wt_rd_addr = {9 -1{bank13_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank14_ram0_wt_rd_addr = {9 -1{bank14_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank14_ram1_wt_rd_addr = {9 -1{bank14_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank15_ram0_wt_rd_addr = {9 -1{bank15_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank15_ram1_wt_rd_addr = {9 -1{bank15_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank16_ram0_wt_rd_addr = {9 -1{bank16_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank16_ram1_wt_rd_addr = {9 -1{bank16_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank17_ram0_wt_rd_addr = {9 -1{bank17_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank17_ram1_wt_rd_addr = {9 -1{bank17_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank18_ram0_wt_rd_addr = {9 -1{bank18_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank18_ram1_wt_rd_addr = {9 -1{bank18_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank19_ram0_wt_rd_addr = {9 -1{bank19_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank19_ram1_wt_rd_addr = {9 -1{bank19_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank20_ram0_wt_rd_addr = {9 -1{bank20_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank20_ram1_wt_rd_addr = {9 -1{bank20_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank21_ram0_wt_rd_addr = {9 -1{bank21_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank21_ram1_wt_rd_addr = {9 -1{bank21_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank22_ram0_wt_rd_addr = {9 -1{bank22_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank22_ram1_wt_rd_addr = {9 -1{bank22_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank23_ram0_wt_rd_addr = {9 -1{bank23_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank23_ram1_wt_rd_addr = {9 -1{bank23_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank24_ram0_wt_rd_addr = {9 -1{bank24_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank24_ram1_wt_rd_addr = {9 -1{bank24_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank25_ram0_wt_rd_addr = {9 -1{bank25_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank25_ram1_wt_rd_addr = {9 -1{bank25_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank26_ram0_wt_rd_addr = {9 -1{bank26_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank26_ram1_wt_rd_addr = {9 -1{bank26_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank27_ram0_wt_rd_addr = {9 -1{bank27_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank27_ram1_wt_rd_addr = {9 -1{bank27_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank28_ram0_wt_rd_addr = {9 -1{bank28_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank28_ram1_wt_rd_addr = {9 -1{bank28_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank29_ram0_wt_rd_addr = {9 -1{bank29_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank29_ram1_wt_rd_addr = {9 -1{bank29_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank30_ram0_wt_rd_addr = {9 -1{bank30_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank30_ram1_wt_rd_addr = {9 -1{bank30_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank31_ram0_wt_rd_addr = {9 -1{bank31_ram0_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank31_ram1_wt_rd_addr = {9 -1{bank31_ram1_wt_rd_en}}&(sc2buf_wt_rd_addr[9 -1:1]); 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//add flop for sram weight read en
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: &eperl::flop("-q bank${j}_ram${k}_wt_rd_en_d1 -d  bank${j}_ram${k}_wt_rd_en");
//: &eperl::flop("-q bank${j}_ram${k}_wt_rd_en_d2 -d  bank${j}_ram${k}_wt_rd_en_d1");
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  bank0_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank0_ram0_wt_rd_en_d1 <= bank0_ram0_wt_rd_en;
   end
end
reg  bank0_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank0_ram0_wt_rd_en_d2 <= bank0_ram0_wt_rd_en_d1;
   end
end
reg  bank0_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank0_ram1_wt_rd_en_d1 <= bank0_ram1_wt_rd_en;
   end
end
reg  bank0_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank0_ram1_wt_rd_en_d2 <= bank0_ram1_wt_rd_en_d1;
   end
end
reg  bank1_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank1_ram0_wt_rd_en_d1 <= bank1_ram0_wt_rd_en;
   end
end
reg  bank1_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank1_ram0_wt_rd_en_d2 <= bank1_ram0_wt_rd_en_d1;
   end
end
reg  bank1_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank1_ram1_wt_rd_en_d1 <= bank1_ram1_wt_rd_en;
   end
end
reg  bank1_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank1_ram1_wt_rd_en_d2 <= bank1_ram1_wt_rd_en_d1;
   end
end
reg  bank2_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank2_ram0_wt_rd_en_d1 <= bank2_ram0_wt_rd_en;
   end
end
reg  bank2_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank2_ram0_wt_rd_en_d2 <= bank2_ram0_wt_rd_en_d1;
   end
end
reg  bank2_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank2_ram1_wt_rd_en_d1 <= bank2_ram1_wt_rd_en;
   end
end
reg  bank2_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank2_ram1_wt_rd_en_d2 <= bank2_ram1_wt_rd_en_d1;
   end
end
reg  bank3_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank3_ram0_wt_rd_en_d1 <= bank3_ram0_wt_rd_en;
   end
end
reg  bank3_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank3_ram0_wt_rd_en_d2 <= bank3_ram0_wt_rd_en_d1;
   end
end
reg  bank3_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank3_ram1_wt_rd_en_d1 <= bank3_ram1_wt_rd_en;
   end
end
reg  bank3_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank3_ram1_wt_rd_en_d2 <= bank3_ram1_wt_rd_en_d1;
   end
end
reg  bank4_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank4_ram0_wt_rd_en_d1 <= bank4_ram0_wt_rd_en;
   end
end
reg  bank4_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank4_ram0_wt_rd_en_d2 <= bank4_ram0_wt_rd_en_d1;
   end
end
reg  bank4_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank4_ram1_wt_rd_en_d1 <= bank4_ram1_wt_rd_en;
   end
end
reg  bank4_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank4_ram1_wt_rd_en_d2 <= bank4_ram1_wt_rd_en_d1;
   end
end
reg  bank5_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank5_ram0_wt_rd_en_d1 <= bank5_ram0_wt_rd_en;
   end
end
reg  bank5_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank5_ram0_wt_rd_en_d2 <= bank5_ram0_wt_rd_en_d1;
   end
end
reg  bank5_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank5_ram1_wt_rd_en_d1 <= bank5_ram1_wt_rd_en;
   end
end
reg  bank5_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank5_ram1_wt_rd_en_d2 <= bank5_ram1_wt_rd_en_d1;
   end
end
reg  bank6_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank6_ram0_wt_rd_en_d1 <= bank6_ram0_wt_rd_en;
   end
end
reg  bank6_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank6_ram0_wt_rd_en_d2 <= bank6_ram0_wt_rd_en_d1;
   end
end
reg  bank6_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank6_ram1_wt_rd_en_d1 <= bank6_ram1_wt_rd_en;
   end
end
reg  bank6_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank6_ram1_wt_rd_en_d2 <= bank6_ram1_wt_rd_en_d1;
   end
end
reg  bank7_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank7_ram0_wt_rd_en_d1 <= bank7_ram0_wt_rd_en;
   end
end
reg  bank7_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank7_ram0_wt_rd_en_d2 <= bank7_ram0_wt_rd_en_d1;
   end
end
reg  bank7_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank7_ram1_wt_rd_en_d1 <= bank7_ram1_wt_rd_en;
   end
end
reg  bank7_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank7_ram1_wt_rd_en_d2 <= bank7_ram1_wt_rd_en_d1;
   end
end
reg  bank8_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank8_ram0_wt_rd_en_d1 <= bank8_ram0_wt_rd_en;
   end
end
reg  bank8_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank8_ram0_wt_rd_en_d2 <= bank8_ram0_wt_rd_en_d1;
   end
end
reg  bank8_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank8_ram1_wt_rd_en_d1 <= bank8_ram1_wt_rd_en;
   end
end
reg  bank8_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank8_ram1_wt_rd_en_d2 <= bank8_ram1_wt_rd_en_d1;
   end
end
reg  bank9_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank9_ram0_wt_rd_en_d1 <= bank9_ram0_wt_rd_en;
   end
end
reg  bank9_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank9_ram0_wt_rd_en_d2 <= bank9_ram0_wt_rd_en_d1;
   end
end
reg  bank9_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank9_ram1_wt_rd_en_d1 <= bank9_ram1_wt_rd_en;
   end
end
reg  bank9_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank9_ram1_wt_rd_en_d2 <= bank9_ram1_wt_rd_en_d1;
   end
end
reg  bank10_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank10_ram0_wt_rd_en_d1 <= bank10_ram0_wt_rd_en;
   end
end
reg  bank10_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank10_ram0_wt_rd_en_d2 <= bank10_ram0_wt_rd_en_d1;
   end
end
reg  bank10_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank10_ram1_wt_rd_en_d1 <= bank10_ram1_wt_rd_en;
   end
end
reg  bank10_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank10_ram1_wt_rd_en_d2 <= bank10_ram1_wt_rd_en_d1;
   end
end
reg  bank11_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank11_ram0_wt_rd_en_d1 <= bank11_ram0_wt_rd_en;
   end
end
reg  bank11_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank11_ram0_wt_rd_en_d2 <= bank11_ram0_wt_rd_en_d1;
   end
end
reg  bank11_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank11_ram1_wt_rd_en_d1 <= bank11_ram1_wt_rd_en;
   end
end
reg  bank11_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank11_ram1_wt_rd_en_d2 <= bank11_ram1_wt_rd_en_d1;
   end
end
reg  bank12_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank12_ram0_wt_rd_en_d1 <= bank12_ram0_wt_rd_en;
   end
end
reg  bank12_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank12_ram0_wt_rd_en_d2 <= bank12_ram0_wt_rd_en_d1;
   end
end
reg  bank12_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank12_ram1_wt_rd_en_d1 <= bank12_ram1_wt_rd_en;
   end
end
reg  bank12_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank12_ram1_wt_rd_en_d2 <= bank12_ram1_wt_rd_en_d1;
   end
end
reg  bank13_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank13_ram0_wt_rd_en_d1 <= bank13_ram0_wt_rd_en;
   end
end
reg  bank13_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank13_ram0_wt_rd_en_d2 <= bank13_ram0_wt_rd_en_d1;
   end
end
reg  bank13_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank13_ram1_wt_rd_en_d1 <= bank13_ram1_wt_rd_en;
   end
end
reg  bank13_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank13_ram1_wt_rd_en_d2 <= bank13_ram1_wt_rd_en_d1;
   end
end
reg  bank14_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank14_ram0_wt_rd_en_d1 <= bank14_ram0_wt_rd_en;
   end
end
reg  bank14_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank14_ram0_wt_rd_en_d2 <= bank14_ram0_wt_rd_en_d1;
   end
end
reg  bank14_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank14_ram1_wt_rd_en_d1 <= bank14_ram1_wt_rd_en;
   end
end
reg  bank14_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank14_ram1_wt_rd_en_d2 <= bank14_ram1_wt_rd_en_d1;
   end
end
reg  bank15_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank15_ram0_wt_rd_en_d1 <= bank15_ram0_wt_rd_en;
   end
end
reg  bank15_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank15_ram0_wt_rd_en_d2 <= bank15_ram0_wt_rd_en_d1;
   end
end
reg  bank15_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank15_ram1_wt_rd_en_d1 <= bank15_ram1_wt_rd_en;
   end
end
reg  bank15_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank15_ram1_wt_rd_en_d2 <= bank15_ram1_wt_rd_en_d1;
   end
end
reg  bank16_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank16_ram0_wt_rd_en_d1 <= bank16_ram0_wt_rd_en;
   end
end
reg  bank16_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank16_ram0_wt_rd_en_d2 <= bank16_ram0_wt_rd_en_d1;
   end
end
reg  bank16_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank16_ram1_wt_rd_en_d1 <= bank16_ram1_wt_rd_en;
   end
end
reg  bank16_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank16_ram1_wt_rd_en_d2 <= bank16_ram1_wt_rd_en_d1;
   end
end
reg  bank17_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank17_ram0_wt_rd_en_d1 <= bank17_ram0_wt_rd_en;
   end
end
reg  bank17_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank17_ram0_wt_rd_en_d2 <= bank17_ram0_wt_rd_en_d1;
   end
end
reg  bank17_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank17_ram1_wt_rd_en_d1 <= bank17_ram1_wt_rd_en;
   end
end
reg  bank17_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank17_ram1_wt_rd_en_d2 <= bank17_ram1_wt_rd_en_d1;
   end
end
reg  bank18_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank18_ram0_wt_rd_en_d1 <= bank18_ram0_wt_rd_en;
   end
end
reg  bank18_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank18_ram0_wt_rd_en_d2 <= bank18_ram0_wt_rd_en_d1;
   end
end
reg  bank18_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank18_ram1_wt_rd_en_d1 <= bank18_ram1_wt_rd_en;
   end
end
reg  bank18_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank18_ram1_wt_rd_en_d2 <= bank18_ram1_wt_rd_en_d1;
   end
end
reg  bank19_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank19_ram0_wt_rd_en_d1 <= bank19_ram0_wt_rd_en;
   end
end
reg  bank19_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank19_ram0_wt_rd_en_d2 <= bank19_ram0_wt_rd_en_d1;
   end
end
reg  bank19_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank19_ram1_wt_rd_en_d1 <= bank19_ram1_wt_rd_en;
   end
end
reg  bank19_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank19_ram1_wt_rd_en_d2 <= bank19_ram1_wt_rd_en_d1;
   end
end
reg  bank20_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank20_ram0_wt_rd_en_d1 <= bank20_ram0_wt_rd_en;
   end
end
reg  bank20_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank20_ram0_wt_rd_en_d2 <= bank20_ram0_wt_rd_en_d1;
   end
end
reg  bank20_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank20_ram1_wt_rd_en_d1 <= bank20_ram1_wt_rd_en;
   end
end
reg  bank20_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank20_ram1_wt_rd_en_d2 <= bank20_ram1_wt_rd_en_d1;
   end
end
reg  bank21_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank21_ram0_wt_rd_en_d1 <= bank21_ram0_wt_rd_en;
   end
end
reg  bank21_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank21_ram0_wt_rd_en_d2 <= bank21_ram0_wt_rd_en_d1;
   end
end
reg  bank21_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank21_ram1_wt_rd_en_d1 <= bank21_ram1_wt_rd_en;
   end
end
reg  bank21_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank21_ram1_wt_rd_en_d2 <= bank21_ram1_wt_rd_en_d1;
   end
end
reg  bank22_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank22_ram0_wt_rd_en_d1 <= bank22_ram0_wt_rd_en;
   end
end
reg  bank22_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank22_ram0_wt_rd_en_d2 <= bank22_ram0_wt_rd_en_d1;
   end
end
reg  bank22_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank22_ram1_wt_rd_en_d1 <= bank22_ram1_wt_rd_en;
   end
end
reg  bank22_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank22_ram1_wt_rd_en_d2 <= bank22_ram1_wt_rd_en_d1;
   end
end
reg  bank23_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank23_ram0_wt_rd_en_d1 <= bank23_ram0_wt_rd_en;
   end
end
reg  bank23_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank23_ram0_wt_rd_en_d2 <= bank23_ram0_wt_rd_en_d1;
   end
end
reg  bank23_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank23_ram1_wt_rd_en_d1 <= bank23_ram1_wt_rd_en;
   end
end
reg  bank23_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank23_ram1_wt_rd_en_d2 <= bank23_ram1_wt_rd_en_d1;
   end
end
reg  bank24_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank24_ram0_wt_rd_en_d1 <= bank24_ram0_wt_rd_en;
   end
end
reg  bank24_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank24_ram0_wt_rd_en_d2 <= bank24_ram0_wt_rd_en_d1;
   end
end
reg  bank24_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank24_ram1_wt_rd_en_d1 <= bank24_ram1_wt_rd_en;
   end
end
reg  bank24_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank24_ram1_wt_rd_en_d2 <= bank24_ram1_wt_rd_en_d1;
   end
end
reg  bank25_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank25_ram0_wt_rd_en_d1 <= bank25_ram0_wt_rd_en;
   end
end
reg  bank25_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank25_ram0_wt_rd_en_d2 <= bank25_ram0_wt_rd_en_d1;
   end
end
reg  bank25_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank25_ram1_wt_rd_en_d1 <= bank25_ram1_wt_rd_en;
   end
end
reg  bank25_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank25_ram1_wt_rd_en_d2 <= bank25_ram1_wt_rd_en_d1;
   end
end
reg  bank26_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank26_ram0_wt_rd_en_d1 <= bank26_ram0_wt_rd_en;
   end
end
reg  bank26_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank26_ram0_wt_rd_en_d2 <= bank26_ram0_wt_rd_en_d1;
   end
end
reg  bank26_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank26_ram1_wt_rd_en_d1 <= bank26_ram1_wt_rd_en;
   end
end
reg  bank26_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank26_ram1_wt_rd_en_d2 <= bank26_ram1_wt_rd_en_d1;
   end
end
reg  bank27_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank27_ram0_wt_rd_en_d1 <= bank27_ram0_wt_rd_en;
   end
end
reg  bank27_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank27_ram0_wt_rd_en_d2 <= bank27_ram0_wt_rd_en_d1;
   end
end
reg  bank27_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank27_ram1_wt_rd_en_d1 <= bank27_ram1_wt_rd_en;
   end
end
reg  bank27_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank27_ram1_wt_rd_en_d2 <= bank27_ram1_wt_rd_en_d1;
   end
end
reg  bank28_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank28_ram0_wt_rd_en_d1 <= bank28_ram0_wt_rd_en;
   end
end
reg  bank28_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank28_ram0_wt_rd_en_d2 <= bank28_ram0_wt_rd_en_d1;
   end
end
reg  bank28_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank28_ram1_wt_rd_en_d1 <= bank28_ram1_wt_rd_en;
   end
end
reg  bank28_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank28_ram1_wt_rd_en_d2 <= bank28_ram1_wt_rd_en_d1;
   end
end
reg  bank29_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank29_ram0_wt_rd_en_d1 <= bank29_ram0_wt_rd_en;
   end
end
reg  bank29_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank29_ram0_wt_rd_en_d2 <= bank29_ram0_wt_rd_en_d1;
   end
end
reg  bank29_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank29_ram1_wt_rd_en_d1 <= bank29_ram1_wt_rd_en;
   end
end
reg  bank29_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank29_ram1_wt_rd_en_d2 <= bank29_ram1_wt_rd_en_d1;
   end
end
reg  bank30_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank30_ram0_wt_rd_en_d1 <= bank30_ram0_wt_rd_en;
   end
end
reg  bank30_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank30_ram0_wt_rd_en_d2 <= bank30_ram0_wt_rd_en_d1;
   end
end
reg  bank30_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank30_ram1_wt_rd_en_d1 <= bank30_ram1_wt_rd_en;
   end
end
reg  bank30_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank30_ram1_wt_rd_en_d2 <= bank30_ram1_wt_rd_en_d1;
   end
end
reg  bank31_ram0_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_wt_rd_en_d1 <= 'b0;
   end else begin
       bank31_ram0_wt_rd_en_d1 <= bank31_ram0_wt_rd_en;
   end
end
reg  bank31_ram0_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_wt_rd_en_d2 <= 'b0;
   end else begin
       bank31_ram0_wt_rd_en_d2 <= bank31_ram0_wt_rd_en_d1;
   end
end
reg  bank31_ram1_wt_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_wt_rd_en_d1 <= 'b0;
   end else begin
       bank31_ram1_wt_rd_en_d1 <= bank31_ram1_wt_rd_en;
   end
end
reg  bank31_ram1_wt_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_wt_rd_en_d2 <= 'b0;
   end else begin
       bank31_ram1_wt_rd_en_d2 <= bank31_ram1_wt_rd_en_d1;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sram weight read valid.
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: print qq(
//: wire bank${j}_ram${k}_wt_rd_valid = bank${j}_ram${k}_wt_rd_en_d2; )
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire bank0_ram0_wt_rd_valid = bank0_ram0_wt_rd_en_d2; 
wire bank0_ram1_wt_rd_valid = bank0_ram1_wt_rd_en_d2; 
wire bank1_ram0_wt_rd_valid = bank1_ram0_wt_rd_en_d2; 
wire bank1_ram1_wt_rd_valid = bank1_ram1_wt_rd_en_d2; 
wire bank2_ram0_wt_rd_valid = bank2_ram0_wt_rd_en_d2; 
wire bank2_ram1_wt_rd_valid = bank2_ram1_wt_rd_en_d2; 
wire bank3_ram0_wt_rd_valid = bank3_ram0_wt_rd_en_d2; 
wire bank3_ram1_wt_rd_valid = bank3_ram1_wt_rd_en_d2; 
wire bank4_ram0_wt_rd_valid = bank4_ram0_wt_rd_en_d2; 
wire bank4_ram1_wt_rd_valid = bank4_ram1_wt_rd_en_d2; 
wire bank5_ram0_wt_rd_valid = bank5_ram0_wt_rd_en_d2; 
wire bank5_ram1_wt_rd_valid = bank5_ram1_wt_rd_en_d2; 
wire bank6_ram0_wt_rd_valid = bank6_ram0_wt_rd_en_d2; 
wire bank6_ram1_wt_rd_valid = bank6_ram1_wt_rd_en_d2; 
wire bank7_ram0_wt_rd_valid = bank7_ram0_wt_rd_en_d2; 
wire bank7_ram1_wt_rd_valid = bank7_ram1_wt_rd_en_d2; 
wire bank8_ram0_wt_rd_valid = bank8_ram0_wt_rd_en_d2; 
wire bank8_ram1_wt_rd_valid = bank8_ram1_wt_rd_en_d2; 
wire bank9_ram0_wt_rd_valid = bank9_ram0_wt_rd_en_d2; 
wire bank9_ram1_wt_rd_valid = bank9_ram1_wt_rd_en_d2; 
wire bank10_ram0_wt_rd_valid = bank10_ram0_wt_rd_en_d2; 
wire bank10_ram1_wt_rd_valid = bank10_ram1_wt_rd_en_d2; 
wire bank11_ram0_wt_rd_valid = bank11_ram0_wt_rd_en_d2; 
wire bank11_ram1_wt_rd_valid = bank11_ram1_wt_rd_en_d2; 
wire bank12_ram0_wt_rd_valid = bank12_ram0_wt_rd_en_d2; 
wire bank12_ram1_wt_rd_valid = bank12_ram1_wt_rd_en_d2; 
wire bank13_ram0_wt_rd_valid = bank13_ram0_wt_rd_en_d2; 
wire bank13_ram1_wt_rd_valid = bank13_ram1_wt_rd_en_d2; 
wire bank14_ram0_wt_rd_valid = bank14_ram0_wt_rd_en_d2; 
wire bank14_ram1_wt_rd_valid = bank14_ram1_wt_rd_en_d2; 
wire bank15_ram0_wt_rd_valid = bank15_ram0_wt_rd_en_d2; 
wire bank15_ram1_wt_rd_valid = bank15_ram1_wt_rd_en_d2; 
wire bank16_ram0_wt_rd_valid = bank16_ram0_wt_rd_en_d2; 
wire bank16_ram1_wt_rd_valid = bank16_ram1_wt_rd_en_d2; 
wire bank17_ram0_wt_rd_valid = bank17_ram0_wt_rd_en_d2; 
wire bank17_ram1_wt_rd_valid = bank17_ram1_wt_rd_en_d2; 
wire bank18_ram0_wt_rd_valid = bank18_ram0_wt_rd_en_d2; 
wire bank18_ram1_wt_rd_valid = bank18_ram1_wt_rd_en_d2; 
wire bank19_ram0_wt_rd_valid = bank19_ram0_wt_rd_en_d2; 
wire bank19_ram1_wt_rd_valid = bank19_ram1_wt_rd_en_d2; 
wire bank20_ram0_wt_rd_valid = bank20_ram0_wt_rd_en_d2; 
wire bank20_ram1_wt_rd_valid = bank20_ram1_wt_rd_en_d2; 
wire bank21_ram0_wt_rd_valid = bank21_ram0_wt_rd_en_d2; 
wire bank21_ram1_wt_rd_valid = bank21_ram1_wt_rd_en_d2; 
wire bank22_ram0_wt_rd_valid = bank22_ram0_wt_rd_en_d2; 
wire bank22_ram1_wt_rd_valid = bank22_ram1_wt_rd_en_d2; 
wire bank23_ram0_wt_rd_valid = bank23_ram0_wt_rd_en_d2; 
wire bank23_ram1_wt_rd_valid = bank23_ram1_wt_rd_en_d2; 
wire bank24_ram0_wt_rd_valid = bank24_ram0_wt_rd_en_d2; 
wire bank24_ram1_wt_rd_valid = bank24_ram1_wt_rd_en_d2; 
wire bank25_ram0_wt_rd_valid = bank25_ram0_wt_rd_en_d2; 
wire bank25_ram1_wt_rd_valid = bank25_ram1_wt_rd_en_d2; 
wire bank26_ram0_wt_rd_valid = bank26_ram0_wt_rd_en_d2; 
wire bank26_ram1_wt_rd_valid = bank26_ram1_wt_rd_en_d2; 
wire bank27_ram0_wt_rd_valid = bank27_ram0_wt_rd_en_d2; 
wire bank27_ram1_wt_rd_valid = bank27_ram1_wt_rd_en_d2; 
wire bank28_ram0_wt_rd_valid = bank28_ram0_wt_rd_en_d2; 
wire bank28_ram1_wt_rd_valid = bank28_ram1_wt_rd_en_d2; 
wire bank29_ram0_wt_rd_valid = bank29_ram0_wt_rd_en_d2; 
wire bank29_ram1_wt_rd_valid = bank29_ram1_wt_rd_en_d2; 
wire bank30_ram0_wt_rd_valid = bank30_ram0_wt_rd_en_d2; 
wire bank30_ram1_wt_rd_valid = bank30_ram1_wt_rd_en_d2; 
wire bank31_ram0_wt_rd_valid = bank31_ram0_wt_rd_en_d2; 
wire bank31_ram1_wt_rd_valid = bank31_ram1_wt_rd_en_d2; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sc weight read valid.
//: my $t1="";
//: for(my $j=0; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: $t1 .= "bank${j}_ram${k}_wt_rd_valid|";
//: }
//: }
//: print "wire [0:0] sc2buf_wt_rd_valid_w ="."${t1}"."1'b0 ;\n";
//: &eperl::retime("-O sc2buf_wt_rd_valid -i sc2buf_wt_rd_valid_w -stage 4 -clk nvdla_core_clk");
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [0:0] sc2buf_wt_rd_valid_w =bank0_ram0_wt_rd_valid|bank0_ram1_wt_rd_valid|bank1_ram0_wt_rd_valid|bank1_ram1_wt_rd_valid|bank2_ram0_wt_rd_valid|bank2_ram1_wt_rd_valid|bank3_ram0_wt_rd_valid|bank3_ram1_wt_rd_valid|bank4_ram0_wt_rd_valid|bank4_ram1_wt_rd_valid|bank5_ram0_wt_rd_valid|bank5_ram1_wt_rd_valid|bank6_ram0_wt_rd_valid|bank6_ram1_wt_rd_valid|bank7_ram0_wt_rd_valid|bank7_ram1_wt_rd_valid|bank8_ram0_wt_rd_valid|bank8_ram1_wt_rd_valid|bank9_ram0_wt_rd_valid|bank9_ram1_wt_rd_valid|bank10_ram0_wt_rd_valid|bank10_ram1_wt_rd_valid|bank11_ram0_wt_rd_valid|bank11_ram1_wt_rd_valid|bank12_ram0_wt_rd_valid|bank12_ram1_wt_rd_valid|bank13_ram0_wt_rd_valid|bank13_ram1_wt_rd_valid|bank14_ram0_wt_rd_valid|bank14_ram1_wt_rd_valid|bank15_ram0_wt_rd_valid|bank15_ram1_wt_rd_valid|bank16_ram0_wt_rd_valid|bank16_ram1_wt_rd_valid|bank17_ram0_wt_rd_valid|bank17_ram1_wt_rd_valid|bank18_ram0_wt_rd_valid|bank18_ram1_wt_rd_valid|bank19_ram0_wt_rd_valid|bank19_ram1_wt_rd_valid|bank20_ram0_wt_rd_valid|bank20_ram1_wt_rd_valid|bank21_ram0_wt_rd_valid|bank21_ram1_wt_rd_valid|bank22_ram0_wt_rd_valid|bank22_ram1_wt_rd_valid|bank23_ram0_wt_rd_valid|bank23_ram1_wt_rd_valid|bank24_ram0_wt_rd_valid|bank24_ram1_wt_rd_valid|bank25_ram0_wt_rd_valid|bank25_ram1_wt_rd_valid|bank26_ram0_wt_rd_valid|bank26_ram1_wt_rd_valid|bank27_ram0_wt_rd_valid|bank27_ram1_wt_rd_valid|bank28_ram0_wt_rd_valid|bank28_ram1_wt_rd_valid|bank29_ram0_wt_rd_valid|bank29_ram1_wt_rd_valid|bank30_ram0_wt_rd_valid|bank30_ram1_wt_rd_valid|bank31_ram0_wt_rd_valid|bank31_ram1_wt_rd_valid|1'b0 ;
reg  sc2buf_wt_rd_valid_w_d1;
always @(posedge nvdla_core_clk) begin
        sc2buf_wt_rd_valid_w_d1 <= sc2buf_wt_rd_valid_w;
end

reg  sc2buf_wt_rd_valid_w_d2;
always @(posedge nvdla_core_clk) begin
        sc2buf_wt_rd_valid_w_d2 <= sc2buf_wt_rd_valid_w_d1;
end

reg  sc2buf_wt_rd_valid_w_d3;
always @(posedge nvdla_core_clk) begin
        sc2buf_wt_rd_valid_w_d3 <= sc2buf_wt_rd_valid_w_d2;
end

reg  sc2buf_wt_rd_valid_w_d4;
always @(posedge nvdla_core_clk) begin
        sc2buf_wt_rd_valid_w_d4 <= sc2buf_wt_rd_valid_w_d3;
end

wire  sc2buf_wt_rd_valid;
assign sc2buf_wt_rd_valid = sc2buf_wt_rd_valid_w_d4;


//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sc weight read bank output data.
//: my $t1="";
//: my $kk=64;
//: if(1==0){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_wt_rd_data = bank${j}_ram0_rd_data&{64{bank${j}_ram0_wt_rd_valid}}; );
//: }
//: }
//: if(1==1){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_wt_rd_data = (bank${j}_ram1_rd_data&{64{bank${j}_ram1_wt_rd_valid}})|
//: (bank${j}_ram0_rd_data&{64{bank${j}_ram0_wt_rd_valid}});
//: );
//: }
//: }
//: if(1==2){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_wt_rd_data = {bank${j}_ram1_rd_data&{64{bank${j}_ram1_wt_rd_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_wt_rd_valid}}}; );
//: }
//: }
//: if(1==3){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_wt_rd_data = {bank${j}_ram1_rd_data&{64{bank${j}_ram1_wt_rd_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_wt_rd_valid}}}|
//: {bank${j}_ram3_rd_data&{64{bank${j}_ram3_wt_rd_valid}},
//: bank${j}_ram2_rd_data&{64{bank${j}_ram2_wt_rd_valid}}};
//: );
//: }
//: }
//: if(1==4){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_wt_rd_data = {bank${j}_ram3_rd_data&{64{bank${j}_ram3_wt_rd_valid}},
//: bank${j}_ram2_rd_data&{64{bank${j}_ram2_wt_rd_valid}},
//: bank${j}_ram1_rd_data&{64{bank${j}_ram1_wt_rd_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_wt_rd_valid}}};
//: );
//: }
//: }
//: if(1==5){
//: for(my $j=0; $j<32 ; $j++){
//: print qq(
//: wire [${kk}-1:0] bank${j}_wt_rd_data = {bank${j}_ram7_rd_data&{64{bank${j}_ram7_wt_rd_valid}},
//: bank${j}_ram6_rd_data&{64{bank${j}_ram6_wt_rd_valid}},
//: bank${j}_ram5_rd_data&{64{bank${j}_ram5_wt_rd_valid}},
//: bank${j}_ram4_rd_data&{64{bank${j}_ram4_wt_rd_valid}}}|
//: {bank${j}_ram3_rd_data&{64{bank${j}_ram3_wt_rd_valid}},
//: bank${j}_ram2_rd_data&{64{bank${j}_ram2_wt_rd_valid}},
//: bank${j}_ram1_rd_data&{64{bank${j}_ram1_wt_rd_valid}},
//: bank${j}_ram0_rd_data&{64{bank${j}_ram0_wt_rd_valid}}};
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [64-1:0] bank0_wt_rd_data = (bank0_ram1_rd_data&{64{bank0_ram1_wt_rd_valid}})|
(bank0_ram0_rd_data&{64{bank0_ram0_wt_rd_valid}});

wire [64-1:0] bank1_wt_rd_data = (bank1_ram1_rd_data&{64{bank1_ram1_wt_rd_valid}})|
(bank1_ram0_rd_data&{64{bank1_ram0_wt_rd_valid}});

wire [64-1:0] bank2_wt_rd_data = (bank2_ram1_rd_data&{64{bank2_ram1_wt_rd_valid}})|
(bank2_ram0_rd_data&{64{bank2_ram0_wt_rd_valid}});

wire [64-1:0] bank3_wt_rd_data = (bank3_ram1_rd_data&{64{bank3_ram1_wt_rd_valid}})|
(bank3_ram0_rd_data&{64{bank3_ram0_wt_rd_valid}});

wire [64-1:0] bank4_wt_rd_data = (bank4_ram1_rd_data&{64{bank4_ram1_wt_rd_valid}})|
(bank4_ram0_rd_data&{64{bank4_ram0_wt_rd_valid}});

wire [64-1:0] bank5_wt_rd_data = (bank5_ram1_rd_data&{64{bank5_ram1_wt_rd_valid}})|
(bank5_ram0_rd_data&{64{bank5_ram0_wt_rd_valid}});

wire [64-1:0] bank6_wt_rd_data = (bank6_ram1_rd_data&{64{bank6_ram1_wt_rd_valid}})|
(bank6_ram0_rd_data&{64{bank6_ram0_wt_rd_valid}});

wire [64-1:0] bank7_wt_rd_data = (bank7_ram1_rd_data&{64{bank7_ram1_wt_rd_valid}})|
(bank7_ram0_rd_data&{64{bank7_ram0_wt_rd_valid}});

wire [64-1:0] bank8_wt_rd_data = (bank8_ram1_rd_data&{64{bank8_ram1_wt_rd_valid}})|
(bank8_ram0_rd_data&{64{bank8_ram0_wt_rd_valid}});

wire [64-1:0] bank9_wt_rd_data = (bank9_ram1_rd_data&{64{bank9_ram1_wt_rd_valid}})|
(bank9_ram0_rd_data&{64{bank9_ram0_wt_rd_valid}});

wire [64-1:0] bank10_wt_rd_data = (bank10_ram1_rd_data&{64{bank10_ram1_wt_rd_valid}})|
(bank10_ram0_rd_data&{64{bank10_ram0_wt_rd_valid}});

wire [64-1:0] bank11_wt_rd_data = (bank11_ram1_rd_data&{64{bank11_ram1_wt_rd_valid}})|
(bank11_ram0_rd_data&{64{bank11_ram0_wt_rd_valid}});

wire [64-1:0] bank12_wt_rd_data = (bank12_ram1_rd_data&{64{bank12_ram1_wt_rd_valid}})|
(bank12_ram0_rd_data&{64{bank12_ram0_wt_rd_valid}});

wire [64-1:0] bank13_wt_rd_data = (bank13_ram1_rd_data&{64{bank13_ram1_wt_rd_valid}})|
(bank13_ram0_rd_data&{64{bank13_ram0_wt_rd_valid}});

wire [64-1:0] bank14_wt_rd_data = (bank14_ram1_rd_data&{64{bank14_ram1_wt_rd_valid}})|
(bank14_ram0_rd_data&{64{bank14_ram0_wt_rd_valid}});

wire [64-1:0] bank15_wt_rd_data = (bank15_ram1_rd_data&{64{bank15_ram1_wt_rd_valid}})|
(bank15_ram0_rd_data&{64{bank15_ram0_wt_rd_valid}});

wire [64-1:0] bank16_wt_rd_data = (bank16_ram1_rd_data&{64{bank16_ram1_wt_rd_valid}})|
(bank16_ram0_rd_data&{64{bank16_ram0_wt_rd_valid}});

wire [64-1:0] bank17_wt_rd_data = (bank17_ram1_rd_data&{64{bank17_ram1_wt_rd_valid}})|
(bank17_ram0_rd_data&{64{bank17_ram0_wt_rd_valid}});

wire [64-1:0] bank18_wt_rd_data = (bank18_ram1_rd_data&{64{bank18_ram1_wt_rd_valid}})|
(bank18_ram0_rd_data&{64{bank18_ram0_wt_rd_valid}});

wire [64-1:0] bank19_wt_rd_data = (bank19_ram1_rd_data&{64{bank19_ram1_wt_rd_valid}})|
(bank19_ram0_rd_data&{64{bank19_ram0_wt_rd_valid}});

wire [64-1:0] bank20_wt_rd_data = (bank20_ram1_rd_data&{64{bank20_ram1_wt_rd_valid}})|
(bank20_ram0_rd_data&{64{bank20_ram0_wt_rd_valid}});

wire [64-1:0] bank21_wt_rd_data = (bank21_ram1_rd_data&{64{bank21_ram1_wt_rd_valid}})|
(bank21_ram0_rd_data&{64{bank21_ram0_wt_rd_valid}});

wire [64-1:0] bank22_wt_rd_data = (bank22_ram1_rd_data&{64{bank22_ram1_wt_rd_valid}})|
(bank22_ram0_rd_data&{64{bank22_ram0_wt_rd_valid}});

wire [64-1:0] bank23_wt_rd_data = (bank23_ram1_rd_data&{64{bank23_ram1_wt_rd_valid}})|
(bank23_ram0_rd_data&{64{bank23_ram0_wt_rd_valid}});

wire [64-1:0] bank24_wt_rd_data = (bank24_ram1_rd_data&{64{bank24_ram1_wt_rd_valid}})|
(bank24_ram0_rd_data&{64{bank24_ram0_wt_rd_valid}});

wire [64-1:0] bank25_wt_rd_data = (bank25_ram1_rd_data&{64{bank25_ram1_wt_rd_valid}})|
(bank25_ram0_rd_data&{64{bank25_ram0_wt_rd_valid}});

wire [64-1:0] bank26_wt_rd_data = (bank26_ram1_rd_data&{64{bank26_ram1_wt_rd_valid}})|
(bank26_ram0_rd_data&{64{bank26_ram0_wt_rd_valid}});

wire [64-1:0] bank27_wt_rd_data = (bank27_ram1_rd_data&{64{bank27_ram1_wt_rd_valid}})|
(bank27_ram0_rd_data&{64{bank27_ram0_wt_rd_valid}});

wire [64-1:0] bank28_wt_rd_data = (bank28_ram1_rd_data&{64{bank28_ram1_wt_rd_valid}})|
(bank28_ram0_rd_data&{64{bank28_ram0_wt_rd_valid}});

wire [64-1:0] bank29_wt_rd_data = (bank29_ram1_rd_data&{64{bank29_ram1_wt_rd_valid}})|
(bank29_ram0_rd_data&{64{bank29_ram0_wt_rd_valid}});

wire [64-1:0] bank30_wt_rd_data = (bank30_ram1_rd_data&{64{bank30_ram1_wt_rd_valid}})|
(bank30_ram0_rd_data&{64{bank30_ram0_wt_rd_valid}});

wire [64-1:0] bank31_wt_rd_data = (bank31_ram1_rd_data&{64{bank31_ram1_wt_rd_valid}})|
(bank31_ram0_rd_data&{64{bank31_ram0_wt_rd_valid}});

//| eperl: generated_end (DO NOT EDIT ABOVE)
// pipe solution. for timing concern, 4 level pipe.
//: my $kk=64;
//: for (my $i=0; $i<32; $i++){
//: &eperl::flop("-wid ${kk} -norst -q l1group${i}_wt_rd_data   -d bank${i}_wt_rd_data");
//: }
//:
//: for (my $i=0; $i<32/4; $i++){
//: my $ni=$i*4;
//: my $nii=$i*4+1;
//: my $niii=$i*4+2;
//: my $niiii=$i*4+3;
//: print qq(
//: wire [${kk}-1:0] l2group${i}_wt_rd_data_w = l1group${ni}_wt_rd_data | l1group${nii}_wt_rd_data | l1group${niii}_wt_rd_data | l1group${niiii}_wt_rd_data;
//: );
//: &eperl::flop("-wid ${kk} -norst -q l2group${i}_wt_rd_data   -d l2group${i}_wt_rd_data_w");
//: }
//:
//: for (my $i=0; $i<32/16; $i++){
//: my $ni=$i*4;
//: my $nii=$i*4+1;
//: my $niii=$i*4+2;
//: my $niiii=$i*4+3;
//: print qq(
//: wire [${kk}-1:0] l3group${i}_wt_rd_data_w = l2group${ni}_wt_rd_data | l2group${nii}_wt_rd_data | l2group${niii}_wt_rd_data | l2group${niiii}_wt_rd_data;
//: );
//: &eperl::flop("-wid ${kk} -norst -q l3group${i}_wt_rd_data   -d l3group${i}_wt_rd_data_w");
//: }
//:
//: if(32==16){
//: &eperl::flop("-wid ${kk} -norst -q l4group_wt_rd_data   -d l3group0_wt_rd_data");
//: }
//: if(32==32) {
//: print qq(
//: wire [${kk}-1:0] l4group_wt_rd_data_w = l3group0_wt_rd_data | l3group1_wt_rd_data;
//: );
//: &eperl::flop("-wid ${kk} -norst -q l4group_wt_rd_data   -d l4group_wt_rd_data_w");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [63:0] l1group0_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group0_wt_rd_data <= bank0_wt_rd_data;
end
reg [63:0] l1group1_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group1_wt_rd_data <= bank1_wt_rd_data;
end
reg [63:0] l1group2_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group2_wt_rd_data <= bank2_wt_rd_data;
end
reg [63:0] l1group3_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group3_wt_rd_data <= bank3_wt_rd_data;
end
reg [63:0] l1group4_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group4_wt_rd_data <= bank4_wt_rd_data;
end
reg [63:0] l1group5_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group5_wt_rd_data <= bank5_wt_rd_data;
end
reg [63:0] l1group6_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group6_wt_rd_data <= bank6_wt_rd_data;
end
reg [63:0] l1group7_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group7_wt_rd_data <= bank7_wt_rd_data;
end
reg [63:0] l1group8_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group8_wt_rd_data <= bank8_wt_rd_data;
end
reg [63:0] l1group9_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group9_wt_rd_data <= bank9_wt_rd_data;
end
reg [63:0] l1group10_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group10_wt_rd_data <= bank10_wt_rd_data;
end
reg [63:0] l1group11_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group11_wt_rd_data <= bank11_wt_rd_data;
end
reg [63:0] l1group12_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group12_wt_rd_data <= bank12_wt_rd_data;
end
reg [63:0] l1group13_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group13_wt_rd_data <= bank13_wt_rd_data;
end
reg [63:0] l1group14_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group14_wt_rd_data <= bank14_wt_rd_data;
end
reg [63:0] l1group15_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group15_wt_rd_data <= bank15_wt_rd_data;
end
reg [63:0] l1group16_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group16_wt_rd_data <= bank16_wt_rd_data;
end
reg [63:0] l1group17_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group17_wt_rd_data <= bank17_wt_rd_data;
end
reg [63:0] l1group18_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group18_wt_rd_data <= bank18_wt_rd_data;
end
reg [63:0] l1group19_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group19_wt_rd_data <= bank19_wt_rd_data;
end
reg [63:0] l1group20_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group20_wt_rd_data <= bank20_wt_rd_data;
end
reg [63:0] l1group21_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group21_wt_rd_data <= bank21_wt_rd_data;
end
reg [63:0] l1group22_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group22_wt_rd_data <= bank22_wt_rd_data;
end
reg [63:0] l1group23_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group23_wt_rd_data <= bank23_wt_rd_data;
end
reg [63:0] l1group24_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group24_wt_rd_data <= bank24_wt_rd_data;
end
reg [63:0] l1group25_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group25_wt_rd_data <= bank25_wt_rd_data;
end
reg [63:0] l1group26_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group26_wt_rd_data <= bank26_wt_rd_data;
end
reg [63:0] l1group27_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group27_wt_rd_data <= bank27_wt_rd_data;
end
reg [63:0] l1group28_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group28_wt_rd_data <= bank28_wt_rd_data;
end
reg [63:0] l1group29_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group29_wt_rd_data <= bank29_wt_rd_data;
end
reg [63:0] l1group30_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group30_wt_rd_data <= bank30_wt_rd_data;
end
reg [63:0] l1group31_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l1group31_wt_rd_data <= bank31_wt_rd_data;
end

wire [64-1:0] l2group0_wt_rd_data_w = l1group0_wt_rd_data | l1group1_wt_rd_data | l1group2_wt_rd_data | l1group3_wt_rd_data;
reg [63:0] l2group0_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l2group0_wt_rd_data <= l2group0_wt_rd_data_w;
end

wire [64-1:0] l2group1_wt_rd_data_w = l1group4_wt_rd_data | l1group5_wt_rd_data | l1group6_wt_rd_data | l1group7_wt_rd_data;
reg [63:0] l2group1_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l2group1_wt_rd_data <= l2group1_wt_rd_data_w;
end

wire [64-1:0] l2group2_wt_rd_data_w = l1group8_wt_rd_data | l1group9_wt_rd_data | l1group10_wt_rd_data | l1group11_wt_rd_data;
reg [63:0] l2group2_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l2group2_wt_rd_data <= l2group2_wt_rd_data_w;
end

wire [64-1:0] l2group3_wt_rd_data_w = l1group12_wt_rd_data | l1group13_wt_rd_data | l1group14_wt_rd_data | l1group15_wt_rd_data;
reg [63:0] l2group3_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l2group3_wt_rd_data <= l2group3_wt_rd_data_w;
end

wire [64-1:0] l2group4_wt_rd_data_w = l1group16_wt_rd_data | l1group17_wt_rd_data | l1group18_wt_rd_data | l1group19_wt_rd_data;
reg [63:0] l2group4_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l2group4_wt_rd_data <= l2group4_wt_rd_data_w;
end

wire [64-1:0] l2group5_wt_rd_data_w = l1group20_wt_rd_data | l1group21_wt_rd_data | l1group22_wt_rd_data | l1group23_wt_rd_data;
reg [63:0] l2group5_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l2group5_wt_rd_data <= l2group5_wt_rd_data_w;
end

wire [64-1:0] l2group6_wt_rd_data_w = l1group24_wt_rd_data | l1group25_wt_rd_data | l1group26_wt_rd_data | l1group27_wt_rd_data;
reg [63:0] l2group6_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l2group6_wt_rd_data <= l2group6_wt_rd_data_w;
end

wire [64-1:0] l2group7_wt_rd_data_w = l1group28_wt_rd_data | l1group29_wt_rd_data | l1group30_wt_rd_data | l1group31_wt_rd_data;
reg [63:0] l2group7_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l2group7_wt_rd_data <= l2group7_wt_rd_data_w;
end

wire [64-1:0] l3group0_wt_rd_data_w = l2group0_wt_rd_data | l2group1_wt_rd_data | l2group2_wt_rd_data | l2group3_wt_rd_data;
reg [63:0] l3group0_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l3group0_wt_rd_data <= l3group0_wt_rd_data_w;
end

wire [64-1:0] l3group1_wt_rd_data_w = l2group4_wt_rd_data | l2group5_wt_rd_data | l2group6_wt_rd_data | l2group7_wt_rd_data;
reg [63:0] l3group1_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l3group1_wt_rd_data <= l3group1_wt_rd_data_w;
end

wire [64-1:0] l4group_wt_rd_data_w = l3group0_wt_rd_data | l3group1_wt_rd_data;
reg [63:0] l4group_wt_rd_data;
always @(posedge nvdla_core_clk) begin
       l4group_wt_rd_data <= l4group_wt_rd_data_w;
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire[64 -1:0] sc2buf_wt_rd_data = l4group_wt_rd_data[64 -1:0];
////get sc weight read data.
////: my $t1="";
////: my $kk=CBUF_RD_PORT_WIDTH;
////: for(my $j=0; $j<CBUF_BANK_NUMBER ; $j++){
////:         $t1 .= "bank${j}_wt_rd_data|";    
////:     }
////: print "wire[${kk}-1:0] sc2buf_wt_rd_data =".${t1}."{${kk}{1'b0}}; \n";
/////////////////step4: read WMB handle
//decode read wmb address to sram.
//: my $bank_slice= "13:9"; #address part for select bank
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: for(my $j=32 -1; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: my $kdiv2 = int($k/2);
//: my $kdiv4 = int($k/4);
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire bank${j}_ram${k}_wmb_rd_en = sc2buf_wmb_rd_en&&(sc2buf_wmb_rd_addr[${bank_slice}]==${j}); )
//: }
//: if(1==1){
//: print qq(
//: wire bank${j}_ram${k}_wmb_rd_en = sc2buf_wmb_rd_en&&(sc2buf_wmb_rd_addr[${bank_slice}]==${j})&&(sc2buf_wmb_rd_addr[0]==${k}); )
//: }
//: if(1==3){
//: print qq(
//: wire bank${j}_ram${k}_wmb_rd_en = sc2buf_wmb_rd_en&&(sc2buf_wmb_rd_addr[${bank_slice}]==${j})&&(sc2buf_wmb_rd_addr[0]==${kdiv2}); )
//: }
//: if(1==5){
//: print qq(
//: wire bank${j}_ram${k}_wmb_rd_en = sc2buf_wmb_rd_en&&(sc2buf_wmb_rd_addr[${bank_slice}]==${j})&&(sc2buf_wmb_rd_addr[0]==${kdiv4}); )
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
`ifdef  CBUF_WEIGHT_COMPRESSED
wire bank31_ram0_wmb_rd_en = sc2buf_wmb_rd_en&&(sc2buf_wmb_rd_addr[13:9]==31)&&(sc2buf_wmb_rd_addr[0]==0); 
wire bank31_ram1_wmb_rd_en = sc2buf_wmb_rd_en&&(sc2buf_wmb_rd_addr[13:9]==31)&&(sc2buf_wmb_rd_addr[0]==1); 
//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
//get sram wmb read address.
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: for(my $j=32 -1; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: if((1==0)||(1==2)||(1==4)){
//: print qq(
//: wire [9 -1 -1:0] bank${j}_ram${k}_wmb_rd_addr = {9 -1{bank${j}_ram${k}_wmb_rd_en}}&(sc2buf_wmb_rd_addr[9 -1 -1:0]); )
//: }
//: if((1==1)||(1==3)||(1==5)){
//: print qq(
//: wire [9 -1 -1:0] bank${j}_ram${k}_wmb_rd_addr = {9 -1{bank${j}_ram${k}_wmb_rd_en}}&(sc2buf_wmb_rd_addr[9 -1:1]); )
//: }
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
`ifdef  CBUF_WEIGHT_COMPRESSED
wire [9 -1 -1:0] bank31_ram0_wmb_rd_addr = {9 -1{bank31_ram0_wmb_rd_en}}&(sc2buf_wmb_rd_addr[9 -1:1]); 
wire [9 -1 -1:0] bank31_ram1_wmb_rd_addr = {9 -1{bank31_ram1_wmb_rd_en}}&(sc2buf_wmb_rd_addr[9 -1:1]); 
//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
//add flop for sram wmb read en
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED \n";
//: for(my $j=32 -1; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: &eperl::flop("-q bank${j}_ram${k}_wmb_rd_en_d1 -d  bank${j}_ram${k}_wmb_rd_en");
//: &eperl::flop("-q bank${j}_ram${k}_wmb_rd_en_d2 -d  bank${j}_ram${k}_wmb_rd_en_d1");
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
`ifdef  CBUF_WEIGHT_COMPRESSED 
reg  bank31_ram0_wmb_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_wmb_rd_en_d1 <= 'b0;
   end else begin
       bank31_ram0_wmb_rd_en_d1 <= bank31_ram0_wmb_rd_en;
   end
end
reg  bank31_ram0_wmb_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_wmb_rd_en_d2 <= 'b0;
   end else begin
       bank31_ram0_wmb_rd_en_d2 <= bank31_ram0_wmb_rd_en_d1;
   end
end
reg  bank31_ram1_wmb_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_wmb_rd_en_d1 <= 'b0;
   end else begin
       bank31_ram1_wmb_rd_en_d1 <= bank31_ram1_wmb_rd_en;
   end
end
reg  bank31_ram1_wmb_rd_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_wmb_rd_en_d2 <= 'b0;
   end else begin
       bank31_ram1_wmb_rd_en_d2 <= bank31_ram1_wmb_rd_en_d1;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
//get sram wmb read valid.
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: for(my $j=32 -1; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: print qq(
//: wire bank${j}_ram${k}_wmb_rd_valid = bank${j}_ram${k}_wmb_rd_en_d2; )
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
`ifdef  CBUF_WEIGHT_COMPRESSED
wire bank31_ram0_wmb_rd_valid = bank31_ram0_wmb_rd_en_d2; 
wire bank31_ram1_wmb_rd_valid = bank31_ram1_wmb_rd_en_d2; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
//get sc wmb read valid.
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: my $t1="";
//: for(my $j=32 -1; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: $t1 .= "bank${j}_ram${k}_wmb_rd_valid|";
//: }
//: }
//: print " wire [0:0] sc2buf_wmb_rd_valid_w ="." ${t1}"."1'b0; \n";
//: &eperl::retime("-O sc2buf_wmb_rd_valid -i sc2buf_wmb_rd_valid_w -stage 4 -clk nvdla_core_clk");
//| eperl: generated_beg (DO NOT EDIT BELOW)
`ifdef  CBUF_WEIGHT_COMPRESSED wire [0:0] sc2buf_wmb_rd_valid_w = bank31_ram0_wmb_rd_valid|bank31_ram1_wmb_rd_valid|1'b0; 
reg  sc2buf_wmb_rd_valid_w_d1;
always @(posedge nvdla_core_clk) begin
        sc2buf_wmb_rd_valid_w_d1 <= sc2buf_wmb_rd_valid_w;
end

reg  sc2buf_wmb_rd_valid_w_d2;
always @(posedge nvdla_core_clk) begin
        sc2buf_wmb_rd_valid_w_d2 <= sc2buf_wmb_rd_valid_w_d1;
end

reg  sc2buf_wmb_rd_valid_w_d3;
always @(posedge nvdla_core_clk) begin
        sc2buf_wmb_rd_valid_w_d3 <= sc2buf_wmb_rd_valid_w_d2;
end

reg  sc2buf_wmb_rd_valid_w_d4;
always @(posedge nvdla_core_clk) begin
        sc2buf_wmb_rd_valid_w_d4 <= sc2buf_wmb_rd_valid_w_d3;
end

wire  sc2buf_wmb_rd_valid;
assign sc2buf_wmb_rd_valid = sc2buf_wmb_rd_valid_w_d4;


//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
//get sc wmb read data.
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: my $t1="";
//: my $t2="";
//: my $kk=64;
//: for(my $j=32 -1; $j<32 ; $j++){
//: for(my $k=0; $k<2 ; $k++){
//: if((1==0)||(1==2)||(1==4)){
//: $t1 .="{CBUF_RAM_WIDTH{bank${j}_ram${k}_wmb_rd_valid}} & bank${j}_ram${k}_wmb_rd_data ,";
//: }
//: }
//: }
//: print "wire[${kk}-1:0] sc2buf_wmb_rd_data ="."{"."${t1}"."}; \n";
//: for(my $j=32 -1; $j<32 ; $j++){
//: if(1==1){
//: $t1 .="{CBUF_RAM_WIDTH{bank${j}_ram0_wmb_rd_valid}} & bank${j}_ram0_wmb_rd_data";
//: $t2 .="{CBUF_RAM_WIDTH{bank${j}_ram1_wmb_rd_valid}} & bank${j}_ram1_wmb_rd_data";
//: }
//: if(1==3){
//: $t1 .="{{CBUF_RAM_WIDTH{bank${j}_ram1_wmb_rd_valid}} & bank${j}_ram1_wmb_rd_data,{CBUF_RAM_WIDTH{bank${j}_ram0_wmb_rd_valid}} & bank${j}_ram0_wmb_rd_data}";
//: $t2 .="{{CBUF_RAM_WIDTH{bank${j}_ram3_wmb_rd_valid}} & bank${j}_ram3_wmb_rd_data,{CBUF_RAM_WIDTH{bank${j}_ram2_wmb_rd_valid}} & bank${j}_ram2_wmb_rd_data}";
//: }
//: if(1==5){
//: $t1 .="{{CBUF_RAM_WIDTH{bank${j}_ram3_wmb_rd_valid}} & bank${j}_ram3_wmb_rd_data,{CBUF_RAM_WIDTH{bank${j}_ram2_wmb_rd_valid}} & bank${j}_ram2_wmb_rd_data,{CBUF_RAM_WIDTH{bank${j}_ram1_wmb_rd_valid}} & bank${j}_ram1_wmb_rd_data,{CBUF_RAM_WIDTH{bank${j}_ram0_wmb_rd_valid}} & bank${j}_ram0_wmb_rd_data}";
//: $t2 .="{{CBUF_RAM_WIDTH{bank${j}_ram7_wmb_rd_valid}} & bank${j}_ram7_wmb_rd_data,{CBUF_RAM_WIDTH{bank${j}_ram6_wmb_rd_valid}} & bank${j}_ram6_wmb_rd_data,{CBUF_RAM_WIDTH{bank${j}_ram5_wmb_rd_valid}} & bank${j}_ram5_wmb_rd_data,{CBUF_RAM_WIDTH{bank${j}_ram4_wmb_rd_valid}} & bank${j}_ram4_wmb_rd_data}";
//: }
//: }
//: print "wire[${kk}-1:0] wmb_rd_data ="."(${t1})|(${t2}); \n";
//: &eperl::retime("-wid ${kk} -o sc2buf_wmb_rd_data -i wmb_rd_data -stage 4 -clk nvdla_core_clk");
//| eperl: generated_beg (DO NOT EDIT BELOW)
`ifdef  CBUF_WEIGHT_COMPRESSEDwire[64-1:0] sc2buf_wmb_rd_data ={}; 
wire[64-1:0] wmb_rd_data =({CBUF_RAM_WIDTH{bank31_ram0_wmb_rd_valid}} & bank31_ram0_wmb_rd_data)|({CBUF_RAM_WIDTH{bank31_ram1_wmb_rd_valid}} & bank31_ram1_wmb_rd_data); 
reg [64-1:0] wmb_rd_data_d1;
always @(posedge nvdla_core_clk) begin
        wmb_rd_data_d1[64-1:0] <= wmb_rd_data[64-1:0];
end

reg [64-1:0] wmb_rd_data_d2;
always @(posedge nvdla_core_clk) begin
        wmb_rd_data_d2[64-1:0] <= wmb_rd_data_d1[64-1:0];
end

reg [64-1:0] wmb_rd_data_d3;
always @(posedge nvdla_core_clk) begin
        wmb_rd_data_d3[64-1:0] <= wmb_rd_data_d2[64-1:0];
end

reg [64-1:0] wmb_rd_data_d4;
always @(posedge nvdla_core_clk) begin
        wmb_rd_data_d4[64-1:0] <= wmb_rd_data_d3[64-1:0];
end

wire [64-1:0] sc2buf_wmb_rd_data;
assign sc2buf_wmb_rd_data = wmb_rd_data_d4;


//| eperl: generated_end (DO NOT EDIT ABOVE)
`endif
//get sram read en, data_rd0/data_rd1/weight/wmb
//: if ((1==0)|(1==2)|(1==4)){
//: for (my $i=0; $i<32 -1; $i++){
//: for (my $j=0; $j<2; $j++){
//: print qq(
//: wire bank${i}_ram${j}_rd_en = bank${i}_ram${j}_data_rd_en|bank${i}_ram${j}_wt_rd_en;
//: );
//: }
//: }
//: my $i=32 -1;
//: for (my $j=0; $j<2; $j++){
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: print qq(
//: wire bank${i}_ram${j}_rd_en = bank${i}_ram${j}_data_rd_en|bank${i}_ram${j}_wt_rd_en|bank${i}_ram${j}_wmb_rd_en;
//: `else
//: wire bank${i}_ram${j}_rd_en = bank${i}_ram${j}_data_rd_en|bank${i}_ram${j}_wt_rd_en;
//: `endif
//: );
//: }
//: }
//:
//: if ((1==1)||(1==3)||(1==5)){
//: for (my $i=0; $i<32 -1; $i++){
//: for (my $j=0; $j<2; $j++){
//: print qq(
//: wire bank${i}_ram${j}_rd_en = bank${i}_ram${j}_data_rd0_en|bank${i}_ram${j}_data_rd1_en|bank${i}_ram${j}_wt_rd_en;
//: );
//: }
//: }
//: my $i=32 -1;
//: for (my $j=0; $j<2; $j++){
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: print qq(
//: wire bank${i}_ram${j}_rd_en = bank${i}_ram${j}_data_rd0_en|bank${i}_ram${j}_data_rd1_en|bank${i}_ram${j}_wt_rd_en|bank${i}_ram${j}_wmb_rd_en;
//: `else
//: wire bank${i}_ram${j}_rd_en = bank${i}_ram${j}_data_rd0_en|bank${i}_ram${j}_data_rd1_en|bank${i}_ram${j}_wt_rd_en;
//: `endif
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire bank0_ram0_rd_en = bank0_ram0_data_rd0_en|bank0_ram0_data_rd1_en|bank0_ram0_wt_rd_en;

wire bank0_ram1_rd_en = bank0_ram1_data_rd0_en|bank0_ram1_data_rd1_en|bank0_ram1_wt_rd_en;

wire bank1_ram0_rd_en = bank1_ram0_data_rd0_en|bank1_ram0_data_rd1_en|bank1_ram0_wt_rd_en;

wire bank1_ram1_rd_en = bank1_ram1_data_rd0_en|bank1_ram1_data_rd1_en|bank1_ram1_wt_rd_en;

wire bank2_ram0_rd_en = bank2_ram0_data_rd0_en|bank2_ram0_data_rd1_en|bank2_ram0_wt_rd_en;

wire bank2_ram1_rd_en = bank2_ram1_data_rd0_en|bank2_ram1_data_rd1_en|bank2_ram1_wt_rd_en;

wire bank3_ram0_rd_en = bank3_ram0_data_rd0_en|bank3_ram0_data_rd1_en|bank3_ram0_wt_rd_en;

wire bank3_ram1_rd_en = bank3_ram1_data_rd0_en|bank3_ram1_data_rd1_en|bank3_ram1_wt_rd_en;

wire bank4_ram0_rd_en = bank4_ram0_data_rd0_en|bank4_ram0_data_rd1_en|bank4_ram0_wt_rd_en;

wire bank4_ram1_rd_en = bank4_ram1_data_rd0_en|bank4_ram1_data_rd1_en|bank4_ram1_wt_rd_en;

wire bank5_ram0_rd_en = bank5_ram0_data_rd0_en|bank5_ram0_data_rd1_en|bank5_ram0_wt_rd_en;

wire bank5_ram1_rd_en = bank5_ram1_data_rd0_en|bank5_ram1_data_rd1_en|bank5_ram1_wt_rd_en;

wire bank6_ram0_rd_en = bank6_ram0_data_rd0_en|bank6_ram0_data_rd1_en|bank6_ram0_wt_rd_en;

wire bank6_ram1_rd_en = bank6_ram1_data_rd0_en|bank6_ram1_data_rd1_en|bank6_ram1_wt_rd_en;

wire bank7_ram0_rd_en = bank7_ram0_data_rd0_en|bank7_ram0_data_rd1_en|bank7_ram0_wt_rd_en;

wire bank7_ram1_rd_en = bank7_ram1_data_rd0_en|bank7_ram1_data_rd1_en|bank7_ram1_wt_rd_en;

wire bank8_ram0_rd_en = bank8_ram0_data_rd0_en|bank8_ram0_data_rd1_en|bank8_ram0_wt_rd_en;

wire bank8_ram1_rd_en = bank8_ram1_data_rd0_en|bank8_ram1_data_rd1_en|bank8_ram1_wt_rd_en;

wire bank9_ram0_rd_en = bank9_ram0_data_rd0_en|bank9_ram0_data_rd1_en|bank9_ram0_wt_rd_en;

wire bank9_ram1_rd_en = bank9_ram1_data_rd0_en|bank9_ram1_data_rd1_en|bank9_ram1_wt_rd_en;

wire bank10_ram0_rd_en = bank10_ram0_data_rd0_en|bank10_ram0_data_rd1_en|bank10_ram0_wt_rd_en;

wire bank10_ram1_rd_en = bank10_ram1_data_rd0_en|bank10_ram1_data_rd1_en|bank10_ram1_wt_rd_en;

wire bank11_ram0_rd_en = bank11_ram0_data_rd0_en|bank11_ram0_data_rd1_en|bank11_ram0_wt_rd_en;

wire bank11_ram1_rd_en = bank11_ram1_data_rd0_en|bank11_ram1_data_rd1_en|bank11_ram1_wt_rd_en;

wire bank12_ram0_rd_en = bank12_ram0_data_rd0_en|bank12_ram0_data_rd1_en|bank12_ram0_wt_rd_en;

wire bank12_ram1_rd_en = bank12_ram1_data_rd0_en|bank12_ram1_data_rd1_en|bank12_ram1_wt_rd_en;

wire bank13_ram0_rd_en = bank13_ram0_data_rd0_en|bank13_ram0_data_rd1_en|bank13_ram0_wt_rd_en;

wire bank13_ram1_rd_en = bank13_ram1_data_rd0_en|bank13_ram1_data_rd1_en|bank13_ram1_wt_rd_en;

wire bank14_ram0_rd_en = bank14_ram0_data_rd0_en|bank14_ram0_data_rd1_en|bank14_ram0_wt_rd_en;

wire bank14_ram1_rd_en = bank14_ram1_data_rd0_en|bank14_ram1_data_rd1_en|bank14_ram1_wt_rd_en;

wire bank15_ram0_rd_en = bank15_ram0_data_rd0_en|bank15_ram0_data_rd1_en|bank15_ram0_wt_rd_en;

wire bank15_ram1_rd_en = bank15_ram1_data_rd0_en|bank15_ram1_data_rd1_en|bank15_ram1_wt_rd_en;

wire bank16_ram0_rd_en = bank16_ram0_data_rd0_en|bank16_ram0_data_rd1_en|bank16_ram0_wt_rd_en;

wire bank16_ram1_rd_en = bank16_ram1_data_rd0_en|bank16_ram1_data_rd1_en|bank16_ram1_wt_rd_en;

wire bank17_ram0_rd_en = bank17_ram0_data_rd0_en|bank17_ram0_data_rd1_en|bank17_ram0_wt_rd_en;

wire bank17_ram1_rd_en = bank17_ram1_data_rd0_en|bank17_ram1_data_rd1_en|bank17_ram1_wt_rd_en;

wire bank18_ram0_rd_en = bank18_ram0_data_rd0_en|bank18_ram0_data_rd1_en|bank18_ram0_wt_rd_en;

wire bank18_ram1_rd_en = bank18_ram1_data_rd0_en|bank18_ram1_data_rd1_en|bank18_ram1_wt_rd_en;

wire bank19_ram0_rd_en = bank19_ram0_data_rd0_en|bank19_ram0_data_rd1_en|bank19_ram0_wt_rd_en;

wire bank19_ram1_rd_en = bank19_ram1_data_rd0_en|bank19_ram1_data_rd1_en|bank19_ram1_wt_rd_en;

wire bank20_ram0_rd_en = bank20_ram0_data_rd0_en|bank20_ram0_data_rd1_en|bank20_ram0_wt_rd_en;

wire bank20_ram1_rd_en = bank20_ram1_data_rd0_en|bank20_ram1_data_rd1_en|bank20_ram1_wt_rd_en;

wire bank21_ram0_rd_en = bank21_ram0_data_rd0_en|bank21_ram0_data_rd1_en|bank21_ram0_wt_rd_en;

wire bank21_ram1_rd_en = bank21_ram1_data_rd0_en|bank21_ram1_data_rd1_en|bank21_ram1_wt_rd_en;

wire bank22_ram0_rd_en = bank22_ram0_data_rd0_en|bank22_ram0_data_rd1_en|bank22_ram0_wt_rd_en;

wire bank22_ram1_rd_en = bank22_ram1_data_rd0_en|bank22_ram1_data_rd1_en|bank22_ram1_wt_rd_en;

wire bank23_ram0_rd_en = bank23_ram0_data_rd0_en|bank23_ram0_data_rd1_en|bank23_ram0_wt_rd_en;

wire bank23_ram1_rd_en = bank23_ram1_data_rd0_en|bank23_ram1_data_rd1_en|bank23_ram1_wt_rd_en;

wire bank24_ram0_rd_en = bank24_ram0_data_rd0_en|bank24_ram0_data_rd1_en|bank24_ram0_wt_rd_en;

wire bank24_ram1_rd_en = bank24_ram1_data_rd0_en|bank24_ram1_data_rd1_en|bank24_ram1_wt_rd_en;

wire bank25_ram0_rd_en = bank25_ram0_data_rd0_en|bank25_ram0_data_rd1_en|bank25_ram0_wt_rd_en;

wire bank25_ram1_rd_en = bank25_ram1_data_rd0_en|bank25_ram1_data_rd1_en|bank25_ram1_wt_rd_en;

wire bank26_ram0_rd_en = bank26_ram0_data_rd0_en|bank26_ram0_data_rd1_en|bank26_ram0_wt_rd_en;

wire bank26_ram1_rd_en = bank26_ram1_data_rd0_en|bank26_ram1_data_rd1_en|bank26_ram1_wt_rd_en;

wire bank27_ram0_rd_en = bank27_ram0_data_rd0_en|bank27_ram0_data_rd1_en|bank27_ram0_wt_rd_en;

wire bank27_ram1_rd_en = bank27_ram1_data_rd0_en|bank27_ram1_data_rd1_en|bank27_ram1_wt_rd_en;

wire bank28_ram0_rd_en = bank28_ram0_data_rd0_en|bank28_ram0_data_rd1_en|bank28_ram0_wt_rd_en;

wire bank28_ram1_rd_en = bank28_ram1_data_rd0_en|bank28_ram1_data_rd1_en|bank28_ram1_wt_rd_en;

wire bank29_ram0_rd_en = bank29_ram0_data_rd0_en|bank29_ram0_data_rd1_en|bank29_ram0_wt_rd_en;

wire bank29_ram1_rd_en = bank29_ram1_data_rd0_en|bank29_ram1_data_rd1_en|bank29_ram1_wt_rd_en;

wire bank30_ram0_rd_en = bank30_ram0_data_rd0_en|bank30_ram0_data_rd1_en|bank30_ram0_wt_rd_en;

wire bank30_ram1_rd_en = bank30_ram1_data_rd0_en|bank30_ram1_data_rd1_en|bank30_ram1_wt_rd_en;
`ifdef  CBUF_WEIGHT_COMPRESSED
wire bank31_ram0_rd_en = bank31_ram0_data_rd0_en|bank31_ram0_data_rd1_en|bank31_ram0_wt_rd_en|bank31_ram0_wmb_rd_en;
`else
wire bank31_ram0_rd_en = bank31_ram0_data_rd0_en|bank31_ram0_data_rd1_en|bank31_ram0_wt_rd_en;
`endif
`ifdef  CBUF_WEIGHT_COMPRESSED
wire bank31_ram1_rd_en = bank31_ram1_data_rd0_en|bank31_ram1_data_rd1_en|bank31_ram1_wt_rd_en|bank31_ram1_wmb_rd_en;
`else
wire bank31_ram1_rd_en = bank31_ram1_data_rd0_en|bank31_ram1_data_rd1_en|bank31_ram1_wt_rd_en;
`endif

//| eperl: generated_end (DO NOT EDIT ABOVE)
//get sram read addr, data_rd0/data_rd1/weight/wmb
//: my $kk=9 -1;
//: if ((1==0)|(1==2)|(1==4)){
//: for (my $i=0; $i<32 -1; $i++){
//: for (my $j=0; $j<2; $j++){
//: print qq(
//: wire[${kk}-1:0] bank${i}_ram${j}_rd_addr = {${kk}{bank${i}_ram${j}_data_rd_en}}&bank${i}_ram${j}_data_rd_addr|
//: {${kk}{bank${i}_ram${j}_wt_rd_en}}&bank${i}_ram${j}_wt_rd_addr;
//: );
//: }
//: }
//: my $i=32 -1;
//: for (my $j=0; $j<2; $j++){
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: print qq(
//: wire[${kk}-1:0] bank${i}_ram${j}_rd_addr = {${kk}{bank${i}_ram${j}_data_rd_en}}&bank${i}_ram${j}_data_rd_addr|
//: {${kk}{bank${i}_ram${j}_wt_rd_en}}&bank${i}_ram${j}_wt_rd_addr|
//: {${kk}{bank${i}_ram${j}_wmb_rd_en}}&bank${i}_ram${j}_wmb_rd_addr;
//: `else
//: wire[${kk}-1:0] bank${i}_ram${j}_rd_addr = {${kk}{bank${i}_ram${j}_data_rd_en}}&bank${i}_ram${j}_data_rd_addr|
//: {${kk}{bank${i}_ram${j}_wt_rd_en}}&bank${i}_ram${j}_wt_rd_addr;
//: `endif
//: );
//: }
//: }
//:
//: if ((1==1)||(1==3)||(1==5)){
//: for (my $i=0; $i<32 -1; $i++){
//: for (my $j=0; $j<2; $j++){
//: print qq(
//: wire[${kk}-1:0] bank${i}_ram${j}_rd_addr = {${kk}{bank${i}_ram${j}_data_rd0_en}}&bank${i}_ram${j}_data_rd0_addr|
//: {${kk}{bank${i}_ram${j}_data_rd1_en}}&bank${i}_ram${j}_data_rd1_addr|
//: {${kk}{bank${i}_ram${j}_wt_rd_en}}&bank${i}_ram${j}_wt_rd_addr;
//: );
//: }
//: }
//: my $i=32 -1;
//: for (my $j=0; $j<2; $j++){
//: print "`ifdef  CBUF_WEIGHT_COMPRESSED";
//: print qq(
//: wire[${kk}-1:0] bank${i}_ram${j}_rd_addr = {${kk}{bank${i}_ram${j}_data_rd0_en}}&bank${i}_ram${j}_data_rd0_addr|
//: {${kk}{bank${i}_ram${j}_data_rd1_en}}&bank${i}_ram${j}_data_rd1_addr|
//: {${kk}{bank${i}_ram${j}_wt_rd_en}}&bank${i}_ram${j}_wt_rd_addr|
//: {${kk}{bank${i}_ram${j}_wmb_rd_en}}&bank${i}_ram${j}_wmb_rd_addr;
//: `else
//: wire[${kk}-1:0] bank${i}_ram${j}_rd_addr = {${kk}{bank${i}_ram${j}_data_rd0_en}}&bank${i}_ram${j}_data_rd0_addr|
//: {${kk}{bank${i}_ram${j}_data_rd1_en}}&bank${i}_ram${j}_data_rd1_addr|
//: {${kk}{bank${i}_ram${j}_wt_rd_en}}&bank${i}_ram${j}_wt_rd_addr;
//: `endif
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire[8-1:0] bank0_ram0_rd_addr = {8{bank0_ram0_data_rd0_en}}&bank0_ram0_data_rd0_addr|
{8{bank0_ram0_data_rd1_en}}&bank0_ram0_data_rd1_addr|
{8{bank0_ram0_wt_rd_en}}&bank0_ram0_wt_rd_addr;

wire[8-1:0] bank0_ram1_rd_addr = {8{bank0_ram1_data_rd0_en}}&bank0_ram1_data_rd0_addr|
{8{bank0_ram1_data_rd1_en}}&bank0_ram1_data_rd1_addr|
{8{bank0_ram1_wt_rd_en}}&bank0_ram1_wt_rd_addr;

wire[8-1:0] bank1_ram0_rd_addr = {8{bank1_ram0_data_rd0_en}}&bank1_ram0_data_rd0_addr|
{8{bank1_ram0_data_rd1_en}}&bank1_ram0_data_rd1_addr|
{8{bank1_ram0_wt_rd_en}}&bank1_ram0_wt_rd_addr;

wire[8-1:0] bank1_ram1_rd_addr = {8{bank1_ram1_data_rd0_en}}&bank1_ram1_data_rd0_addr|
{8{bank1_ram1_data_rd1_en}}&bank1_ram1_data_rd1_addr|
{8{bank1_ram1_wt_rd_en}}&bank1_ram1_wt_rd_addr;

wire[8-1:0] bank2_ram0_rd_addr = {8{bank2_ram0_data_rd0_en}}&bank2_ram0_data_rd0_addr|
{8{bank2_ram0_data_rd1_en}}&bank2_ram0_data_rd1_addr|
{8{bank2_ram0_wt_rd_en}}&bank2_ram0_wt_rd_addr;

wire[8-1:0] bank2_ram1_rd_addr = {8{bank2_ram1_data_rd0_en}}&bank2_ram1_data_rd0_addr|
{8{bank2_ram1_data_rd1_en}}&bank2_ram1_data_rd1_addr|
{8{bank2_ram1_wt_rd_en}}&bank2_ram1_wt_rd_addr;

wire[8-1:0] bank3_ram0_rd_addr = {8{bank3_ram0_data_rd0_en}}&bank3_ram0_data_rd0_addr|
{8{bank3_ram0_data_rd1_en}}&bank3_ram0_data_rd1_addr|
{8{bank3_ram0_wt_rd_en}}&bank3_ram0_wt_rd_addr;

wire[8-1:0] bank3_ram1_rd_addr = {8{bank3_ram1_data_rd0_en}}&bank3_ram1_data_rd0_addr|
{8{bank3_ram1_data_rd1_en}}&bank3_ram1_data_rd1_addr|
{8{bank3_ram1_wt_rd_en}}&bank3_ram1_wt_rd_addr;

wire[8-1:0] bank4_ram0_rd_addr = {8{bank4_ram0_data_rd0_en}}&bank4_ram0_data_rd0_addr|
{8{bank4_ram0_data_rd1_en}}&bank4_ram0_data_rd1_addr|
{8{bank4_ram0_wt_rd_en}}&bank4_ram0_wt_rd_addr;

wire[8-1:0] bank4_ram1_rd_addr = {8{bank4_ram1_data_rd0_en}}&bank4_ram1_data_rd0_addr|
{8{bank4_ram1_data_rd1_en}}&bank4_ram1_data_rd1_addr|
{8{bank4_ram1_wt_rd_en}}&bank4_ram1_wt_rd_addr;

wire[8-1:0] bank5_ram0_rd_addr = {8{bank5_ram0_data_rd0_en}}&bank5_ram0_data_rd0_addr|
{8{bank5_ram0_data_rd1_en}}&bank5_ram0_data_rd1_addr|
{8{bank5_ram0_wt_rd_en}}&bank5_ram0_wt_rd_addr;

wire[8-1:0] bank5_ram1_rd_addr = {8{bank5_ram1_data_rd0_en}}&bank5_ram1_data_rd0_addr|
{8{bank5_ram1_data_rd1_en}}&bank5_ram1_data_rd1_addr|
{8{bank5_ram1_wt_rd_en}}&bank5_ram1_wt_rd_addr;

wire[8-1:0] bank6_ram0_rd_addr = {8{bank6_ram0_data_rd0_en}}&bank6_ram0_data_rd0_addr|
{8{bank6_ram0_data_rd1_en}}&bank6_ram0_data_rd1_addr|
{8{bank6_ram0_wt_rd_en}}&bank6_ram0_wt_rd_addr;

wire[8-1:0] bank6_ram1_rd_addr = {8{bank6_ram1_data_rd0_en}}&bank6_ram1_data_rd0_addr|
{8{bank6_ram1_data_rd1_en}}&bank6_ram1_data_rd1_addr|
{8{bank6_ram1_wt_rd_en}}&bank6_ram1_wt_rd_addr;

wire[8-1:0] bank7_ram0_rd_addr = {8{bank7_ram0_data_rd0_en}}&bank7_ram0_data_rd0_addr|
{8{bank7_ram0_data_rd1_en}}&bank7_ram0_data_rd1_addr|
{8{bank7_ram0_wt_rd_en}}&bank7_ram0_wt_rd_addr;

wire[8-1:0] bank7_ram1_rd_addr = {8{bank7_ram1_data_rd0_en}}&bank7_ram1_data_rd0_addr|
{8{bank7_ram1_data_rd1_en}}&bank7_ram1_data_rd1_addr|
{8{bank7_ram1_wt_rd_en}}&bank7_ram1_wt_rd_addr;

wire[8-1:0] bank8_ram0_rd_addr = {8{bank8_ram0_data_rd0_en}}&bank8_ram0_data_rd0_addr|
{8{bank8_ram0_data_rd1_en}}&bank8_ram0_data_rd1_addr|
{8{bank8_ram0_wt_rd_en}}&bank8_ram0_wt_rd_addr;

wire[8-1:0] bank8_ram1_rd_addr = {8{bank8_ram1_data_rd0_en}}&bank8_ram1_data_rd0_addr|
{8{bank8_ram1_data_rd1_en}}&bank8_ram1_data_rd1_addr|
{8{bank8_ram1_wt_rd_en}}&bank8_ram1_wt_rd_addr;

wire[8-1:0] bank9_ram0_rd_addr = {8{bank9_ram0_data_rd0_en}}&bank9_ram0_data_rd0_addr|
{8{bank9_ram0_data_rd1_en}}&bank9_ram0_data_rd1_addr|
{8{bank9_ram0_wt_rd_en}}&bank9_ram0_wt_rd_addr;

wire[8-1:0] bank9_ram1_rd_addr = {8{bank9_ram1_data_rd0_en}}&bank9_ram1_data_rd0_addr|
{8{bank9_ram1_data_rd1_en}}&bank9_ram1_data_rd1_addr|
{8{bank9_ram1_wt_rd_en}}&bank9_ram1_wt_rd_addr;

wire[8-1:0] bank10_ram0_rd_addr = {8{bank10_ram0_data_rd0_en}}&bank10_ram0_data_rd0_addr|
{8{bank10_ram0_data_rd1_en}}&bank10_ram0_data_rd1_addr|
{8{bank10_ram0_wt_rd_en}}&bank10_ram0_wt_rd_addr;

wire[8-1:0] bank10_ram1_rd_addr = {8{bank10_ram1_data_rd0_en}}&bank10_ram1_data_rd0_addr|
{8{bank10_ram1_data_rd1_en}}&bank10_ram1_data_rd1_addr|
{8{bank10_ram1_wt_rd_en}}&bank10_ram1_wt_rd_addr;

wire[8-1:0] bank11_ram0_rd_addr = {8{bank11_ram0_data_rd0_en}}&bank11_ram0_data_rd0_addr|
{8{bank11_ram0_data_rd1_en}}&bank11_ram0_data_rd1_addr|
{8{bank11_ram0_wt_rd_en}}&bank11_ram0_wt_rd_addr;

wire[8-1:0] bank11_ram1_rd_addr = {8{bank11_ram1_data_rd0_en}}&bank11_ram1_data_rd0_addr|
{8{bank11_ram1_data_rd1_en}}&bank11_ram1_data_rd1_addr|
{8{bank11_ram1_wt_rd_en}}&bank11_ram1_wt_rd_addr;

wire[8-1:0] bank12_ram0_rd_addr = {8{bank12_ram0_data_rd0_en}}&bank12_ram0_data_rd0_addr|
{8{bank12_ram0_data_rd1_en}}&bank12_ram0_data_rd1_addr|
{8{bank12_ram0_wt_rd_en}}&bank12_ram0_wt_rd_addr;

wire[8-1:0] bank12_ram1_rd_addr = {8{bank12_ram1_data_rd0_en}}&bank12_ram1_data_rd0_addr|
{8{bank12_ram1_data_rd1_en}}&bank12_ram1_data_rd1_addr|
{8{bank12_ram1_wt_rd_en}}&bank12_ram1_wt_rd_addr;

wire[8-1:0] bank13_ram0_rd_addr = {8{bank13_ram0_data_rd0_en}}&bank13_ram0_data_rd0_addr|
{8{bank13_ram0_data_rd1_en}}&bank13_ram0_data_rd1_addr|
{8{bank13_ram0_wt_rd_en}}&bank13_ram0_wt_rd_addr;

wire[8-1:0] bank13_ram1_rd_addr = {8{bank13_ram1_data_rd0_en}}&bank13_ram1_data_rd0_addr|
{8{bank13_ram1_data_rd1_en}}&bank13_ram1_data_rd1_addr|
{8{bank13_ram1_wt_rd_en}}&bank13_ram1_wt_rd_addr;

wire[8-1:0] bank14_ram0_rd_addr = {8{bank14_ram0_data_rd0_en}}&bank14_ram0_data_rd0_addr|
{8{bank14_ram0_data_rd1_en}}&bank14_ram0_data_rd1_addr|
{8{bank14_ram0_wt_rd_en}}&bank14_ram0_wt_rd_addr;

wire[8-1:0] bank14_ram1_rd_addr = {8{bank14_ram1_data_rd0_en}}&bank14_ram1_data_rd0_addr|
{8{bank14_ram1_data_rd1_en}}&bank14_ram1_data_rd1_addr|
{8{bank14_ram1_wt_rd_en}}&bank14_ram1_wt_rd_addr;

wire[8-1:0] bank15_ram0_rd_addr = {8{bank15_ram0_data_rd0_en}}&bank15_ram0_data_rd0_addr|
{8{bank15_ram0_data_rd1_en}}&bank15_ram0_data_rd1_addr|
{8{bank15_ram0_wt_rd_en}}&bank15_ram0_wt_rd_addr;

wire[8-1:0] bank15_ram1_rd_addr = {8{bank15_ram1_data_rd0_en}}&bank15_ram1_data_rd0_addr|
{8{bank15_ram1_data_rd1_en}}&bank15_ram1_data_rd1_addr|
{8{bank15_ram1_wt_rd_en}}&bank15_ram1_wt_rd_addr;

wire[8-1:0] bank16_ram0_rd_addr = {8{bank16_ram0_data_rd0_en}}&bank16_ram0_data_rd0_addr|
{8{bank16_ram0_data_rd1_en}}&bank16_ram0_data_rd1_addr|
{8{bank16_ram0_wt_rd_en}}&bank16_ram0_wt_rd_addr;

wire[8-1:0] bank16_ram1_rd_addr = {8{bank16_ram1_data_rd0_en}}&bank16_ram1_data_rd0_addr|
{8{bank16_ram1_data_rd1_en}}&bank16_ram1_data_rd1_addr|
{8{bank16_ram1_wt_rd_en}}&bank16_ram1_wt_rd_addr;

wire[8-1:0] bank17_ram0_rd_addr = {8{bank17_ram0_data_rd0_en}}&bank17_ram0_data_rd0_addr|
{8{bank17_ram0_data_rd1_en}}&bank17_ram0_data_rd1_addr|
{8{bank17_ram0_wt_rd_en}}&bank17_ram0_wt_rd_addr;

wire[8-1:0] bank17_ram1_rd_addr = {8{bank17_ram1_data_rd0_en}}&bank17_ram1_data_rd0_addr|
{8{bank17_ram1_data_rd1_en}}&bank17_ram1_data_rd1_addr|
{8{bank17_ram1_wt_rd_en}}&bank17_ram1_wt_rd_addr;

wire[8-1:0] bank18_ram0_rd_addr = {8{bank18_ram0_data_rd0_en}}&bank18_ram0_data_rd0_addr|
{8{bank18_ram0_data_rd1_en}}&bank18_ram0_data_rd1_addr|
{8{bank18_ram0_wt_rd_en}}&bank18_ram0_wt_rd_addr;

wire[8-1:0] bank18_ram1_rd_addr = {8{bank18_ram1_data_rd0_en}}&bank18_ram1_data_rd0_addr|
{8{bank18_ram1_data_rd1_en}}&bank18_ram1_data_rd1_addr|
{8{bank18_ram1_wt_rd_en}}&bank18_ram1_wt_rd_addr;

wire[8-1:0] bank19_ram0_rd_addr = {8{bank19_ram0_data_rd0_en}}&bank19_ram0_data_rd0_addr|
{8{bank19_ram0_data_rd1_en}}&bank19_ram0_data_rd1_addr|
{8{bank19_ram0_wt_rd_en}}&bank19_ram0_wt_rd_addr;

wire[8-1:0] bank19_ram1_rd_addr = {8{bank19_ram1_data_rd0_en}}&bank19_ram1_data_rd0_addr|
{8{bank19_ram1_data_rd1_en}}&bank19_ram1_data_rd1_addr|
{8{bank19_ram1_wt_rd_en}}&bank19_ram1_wt_rd_addr;

wire[8-1:0] bank20_ram0_rd_addr = {8{bank20_ram0_data_rd0_en}}&bank20_ram0_data_rd0_addr|
{8{bank20_ram0_data_rd1_en}}&bank20_ram0_data_rd1_addr|
{8{bank20_ram0_wt_rd_en}}&bank20_ram0_wt_rd_addr;

wire[8-1:0] bank20_ram1_rd_addr = {8{bank20_ram1_data_rd0_en}}&bank20_ram1_data_rd0_addr|
{8{bank20_ram1_data_rd1_en}}&bank20_ram1_data_rd1_addr|
{8{bank20_ram1_wt_rd_en}}&bank20_ram1_wt_rd_addr;

wire[8-1:0] bank21_ram0_rd_addr = {8{bank21_ram0_data_rd0_en}}&bank21_ram0_data_rd0_addr|
{8{bank21_ram0_data_rd1_en}}&bank21_ram0_data_rd1_addr|
{8{bank21_ram0_wt_rd_en}}&bank21_ram0_wt_rd_addr;

wire[8-1:0] bank21_ram1_rd_addr = {8{bank21_ram1_data_rd0_en}}&bank21_ram1_data_rd0_addr|
{8{bank21_ram1_data_rd1_en}}&bank21_ram1_data_rd1_addr|
{8{bank21_ram1_wt_rd_en}}&bank21_ram1_wt_rd_addr;

wire[8-1:0] bank22_ram0_rd_addr = {8{bank22_ram0_data_rd0_en}}&bank22_ram0_data_rd0_addr|
{8{bank22_ram0_data_rd1_en}}&bank22_ram0_data_rd1_addr|
{8{bank22_ram0_wt_rd_en}}&bank22_ram0_wt_rd_addr;

wire[8-1:0] bank22_ram1_rd_addr = {8{bank22_ram1_data_rd0_en}}&bank22_ram1_data_rd0_addr|
{8{bank22_ram1_data_rd1_en}}&bank22_ram1_data_rd1_addr|
{8{bank22_ram1_wt_rd_en}}&bank22_ram1_wt_rd_addr;

wire[8-1:0] bank23_ram0_rd_addr = {8{bank23_ram0_data_rd0_en}}&bank23_ram0_data_rd0_addr|
{8{bank23_ram0_data_rd1_en}}&bank23_ram0_data_rd1_addr|
{8{bank23_ram0_wt_rd_en}}&bank23_ram0_wt_rd_addr;

wire[8-1:0] bank23_ram1_rd_addr = {8{bank23_ram1_data_rd0_en}}&bank23_ram1_data_rd0_addr|
{8{bank23_ram1_data_rd1_en}}&bank23_ram1_data_rd1_addr|
{8{bank23_ram1_wt_rd_en}}&bank23_ram1_wt_rd_addr;

wire[8-1:0] bank24_ram0_rd_addr = {8{bank24_ram0_data_rd0_en}}&bank24_ram0_data_rd0_addr|
{8{bank24_ram0_data_rd1_en}}&bank24_ram0_data_rd1_addr|
{8{bank24_ram0_wt_rd_en}}&bank24_ram0_wt_rd_addr;

wire[8-1:0] bank24_ram1_rd_addr = {8{bank24_ram1_data_rd0_en}}&bank24_ram1_data_rd0_addr|
{8{bank24_ram1_data_rd1_en}}&bank24_ram1_data_rd1_addr|
{8{bank24_ram1_wt_rd_en}}&bank24_ram1_wt_rd_addr;

wire[8-1:0] bank25_ram0_rd_addr = {8{bank25_ram0_data_rd0_en}}&bank25_ram0_data_rd0_addr|
{8{bank25_ram0_data_rd1_en}}&bank25_ram0_data_rd1_addr|
{8{bank25_ram0_wt_rd_en}}&bank25_ram0_wt_rd_addr;

wire[8-1:0] bank25_ram1_rd_addr = {8{bank25_ram1_data_rd0_en}}&bank25_ram1_data_rd0_addr|
{8{bank25_ram1_data_rd1_en}}&bank25_ram1_data_rd1_addr|
{8{bank25_ram1_wt_rd_en}}&bank25_ram1_wt_rd_addr;

wire[8-1:0] bank26_ram0_rd_addr = {8{bank26_ram0_data_rd0_en}}&bank26_ram0_data_rd0_addr|
{8{bank26_ram0_data_rd1_en}}&bank26_ram0_data_rd1_addr|
{8{bank26_ram0_wt_rd_en}}&bank26_ram0_wt_rd_addr;

wire[8-1:0] bank26_ram1_rd_addr = {8{bank26_ram1_data_rd0_en}}&bank26_ram1_data_rd0_addr|
{8{bank26_ram1_data_rd1_en}}&bank26_ram1_data_rd1_addr|
{8{bank26_ram1_wt_rd_en}}&bank26_ram1_wt_rd_addr;

wire[8-1:0] bank27_ram0_rd_addr = {8{bank27_ram0_data_rd0_en}}&bank27_ram0_data_rd0_addr|
{8{bank27_ram0_data_rd1_en}}&bank27_ram0_data_rd1_addr|
{8{bank27_ram0_wt_rd_en}}&bank27_ram0_wt_rd_addr;

wire[8-1:0] bank27_ram1_rd_addr = {8{bank27_ram1_data_rd0_en}}&bank27_ram1_data_rd0_addr|
{8{bank27_ram1_data_rd1_en}}&bank27_ram1_data_rd1_addr|
{8{bank27_ram1_wt_rd_en}}&bank27_ram1_wt_rd_addr;

wire[8-1:0] bank28_ram0_rd_addr = {8{bank28_ram0_data_rd0_en}}&bank28_ram0_data_rd0_addr|
{8{bank28_ram0_data_rd1_en}}&bank28_ram0_data_rd1_addr|
{8{bank28_ram0_wt_rd_en}}&bank28_ram0_wt_rd_addr;

wire[8-1:0] bank28_ram1_rd_addr = {8{bank28_ram1_data_rd0_en}}&bank28_ram1_data_rd0_addr|
{8{bank28_ram1_data_rd1_en}}&bank28_ram1_data_rd1_addr|
{8{bank28_ram1_wt_rd_en}}&bank28_ram1_wt_rd_addr;

wire[8-1:0] bank29_ram0_rd_addr = {8{bank29_ram0_data_rd0_en}}&bank29_ram0_data_rd0_addr|
{8{bank29_ram0_data_rd1_en}}&bank29_ram0_data_rd1_addr|
{8{bank29_ram0_wt_rd_en}}&bank29_ram0_wt_rd_addr;

wire[8-1:0] bank29_ram1_rd_addr = {8{bank29_ram1_data_rd0_en}}&bank29_ram1_data_rd0_addr|
{8{bank29_ram1_data_rd1_en}}&bank29_ram1_data_rd1_addr|
{8{bank29_ram1_wt_rd_en}}&bank29_ram1_wt_rd_addr;

wire[8-1:0] bank30_ram0_rd_addr = {8{bank30_ram0_data_rd0_en}}&bank30_ram0_data_rd0_addr|
{8{bank30_ram0_data_rd1_en}}&bank30_ram0_data_rd1_addr|
{8{bank30_ram0_wt_rd_en}}&bank30_ram0_wt_rd_addr;

wire[8-1:0] bank30_ram1_rd_addr = {8{bank30_ram1_data_rd0_en}}&bank30_ram1_data_rd0_addr|
{8{bank30_ram1_data_rd1_en}}&bank30_ram1_data_rd1_addr|
{8{bank30_ram1_wt_rd_en}}&bank30_ram1_wt_rd_addr;
`ifdef  CBUF_WEIGHT_COMPRESSED
wire[8-1:0] bank31_ram0_rd_addr = {8{bank31_ram0_data_rd0_en}}&bank31_ram0_data_rd0_addr|
{8{bank31_ram0_data_rd1_en}}&bank31_ram0_data_rd1_addr|
{8{bank31_ram0_wt_rd_en}}&bank31_ram0_wt_rd_addr|
{8{bank31_ram0_wmb_rd_en}}&bank31_ram0_wmb_rd_addr;
`else
wire[8-1:0] bank31_ram0_rd_addr = {8{bank31_ram0_data_rd0_en}}&bank31_ram0_data_rd0_addr|
{8{bank31_ram0_data_rd1_en}}&bank31_ram0_data_rd1_addr|
{8{bank31_ram0_wt_rd_en}}&bank31_ram0_wt_rd_addr;
`endif
`ifdef  CBUF_WEIGHT_COMPRESSED
wire[8-1:0] bank31_ram1_rd_addr = {8{bank31_ram1_data_rd0_en}}&bank31_ram1_data_rd0_addr|
{8{bank31_ram1_data_rd1_en}}&bank31_ram1_data_rd1_addr|
{8{bank31_ram1_wt_rd_en}}&bank31_ram1_wt_rd_addr|
{8{bank31_ram1_wmb_rd_en}}&bank31_ram1_wmb_rd_addr;
`else
wire[8-1:0] bank31_ram1_rd_addr = {8{bank31_ram1_data_rd0_en}}&bank31_ram1_data_rd0_addr|
{8{bank31_ram1_data_rd1_en}}&bank31_ram1_data_rd1_addr|
{8{bank31_ram1_wt_rd_en}}&bank31_ram1_wt_rd_addr;
`endif

//| eperl: generated_end (DO NOT EDIT ABOVE)
// add 1 pipe for sram read control signal.
//: my $kk=9 -1;
//: for(my $i=0; $i<32 ; $i++){
//: for(my $j=0; $j<2 ; $j++){
//: &eperl::flop("-q bank${i}_ram${j}_rd_en_d1 -d bank${i}_ram${j}_rd_en");
//: &eperl::flop("-wid ${kk} -q bank${i}_ram${j}_rd_addr_d1 -d bank${i}_ram${j}_rd_addr");
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  bank0_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank0_ram0_rd_en_d1 <= bank0_ram0_rd_en;
   end
end
reg [7:0] bank0_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank0_ram0_rd_addr_d1 <= bank0_ram0_rd_addr;
   end
end
reg  bank0_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank0_ram1_rd_en_d1 <= bank0_ram1_rd_en;
   end
end
reg [7:0] bank0_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank0_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank0_ram1_rd_addr_d1 <= bank0_ram1_rd_addr;
   end
end
reg  bank1_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank1_ram0_rd_en_d1 <= bank1_ram0_rd_en;
   end
end
reg [7:0] bank1_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank1_ram0_rd_addr_d1 <= bank1_ram0_rd_addr;
   end
end
reg  bank1_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank1_ram1_rd_en_d1 <= bank1_ram1_rd_en;
   end
end
reg [7:0] bank1_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank1_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank1_ram1_rd_addr_d1 <= bank1_ram1_rd_addr;
   end
end
reg  bank2_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank2_ram0_rd_en_d1 <= bank2_ram0_rd_en;
   end
end
reg [7:0] bank2_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank2_ram0_rd_addr_d1 <= bank2_ram0_rd_addr;
   end
end
reg  bank2_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank2_ram1_rd_en_d1 <= bank2_ram1_rd_en;
   end
end
reg [7:0] bank2_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank2_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank2_ram1_rd_addr_d1 <= bank2_ram1_rd_addr;
   end
end
reg  bank3_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank3_ram0_rd_en_d1 <= bank3_ram0_rd_en;
   end
end
reg [7:0] bank3_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank3_ram0_rd_addr_d1 <= bank3_ram0_rd_addr;
   end
end
reg  bank3_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank3_ram1_rd_en_d1 <= bank3_ram1_rd_en;
   end
end
reg [7:0] bank3_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank3_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank3_ram1_rd_addr_d1 <= bank3_ram1_rd_addr;
   end
end
reg  bank4_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank4_ram0_rd_en_d1 <= bank4_ram0_rd_en;
   end
end
reg [7:0] bank4_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank4_ram0_rd_addr_d1 <= bank4_ram0_rd_addr;
   end
end
reg  bank4_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank4_ram1_rd_en_d1 <= bank4_ram1_rd_en;
   end
end
reg [7:0] bank4_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank4_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank4_ram1_rd_addr_d1 <= bank4_ram1_rd_addr;
   end
end
reg  bank5_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank5_ram0_rd_en_d1 <= bank5_ram0_rd_en;
   end
end
reg [7:0] bank5_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank5_ram0_rd_addr_d1 <= bank5_ram0_rd_addr;
   end
end
reg  bank5_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank5_ram1_rd_en_d1 <= bank5_ram1_rd_en;
   end
end
reg [7:0] bank5_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank5_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank5_ram1_rd_addr_d1 <= bank5_ram1_rd_addr;
   end
end
reg  bank6_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank6_ram0_rd_en_d1 <= bank6_ram0_rd_en;
   end
end
reg [7:0] bank6_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank6_ram0_rd_addr_d1 <= bank6_ram0_rd_addr;
   end
end
reg  bank6_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank6_ram1_rd_en_d1 <= bank6_ram1_rd_en;
   end
end
reg [7:0] bank6_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank6_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank6_ram1_rd_addr_d1 <= bank6_ram1_rd_addr;
   end
end
reg  bank7_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank7_ram0_rd_en_d1 <= bank7_ram0_rd_en;
   end
end
reg [7:0] bank7_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank7_ram0_rd_addr_d1 <= bank7_ram0_rd_addr;
   end
end
reg  bank7_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank7_ram1_rd_en_d1 <= bank7_ram1_rd_en;
   end
end
reg [7:0] bank7_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank7_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank7_ram1_rd_addr_d1 <= bank7_ram1_rd_addr;
   end
end
reg  bank8_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank8_ram0_rd_en_d1 <= bank8_ram0_rd_en;
   end
end
reg [7:0] bank8_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank8_ram0_rd_addr_d1 <= bank8_ram0_rd_addr;
   end
end
reg  bank8_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank8_ram1_rd_en_d1 <= bank8_ram1_rd_en;
   end
end
reg [7:0] bank8_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank8_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank8_ram1_rd_addr_d1 <= bank8_ram1_rd_addr;
   end
end
reg  bank9_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank9_ram0_rd_en_d1 <= bank9_ram0_rd_en;
   end
end
reg [7:0] bank9_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank9_ram0_rd_addr_d1 <= bank9_ram0_rd_addr;
   end
end
reg  bank9_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank9_ram1_rd_en_d1 <= bank9_ram1_rd_en;
   end
end
reg [7:0] bank9_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank9_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank9_ram1_rd_addr_d1 <= bank9_ram1_rd_addr;
   end
end
reg  bank10_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank10_ram0_rd_en_d1 <= bank10_ram0_rd_en;
   end
end
reg [7:0] bank10_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank10_ram0_rd_addr_d1 <= bank10_ram0_rd_addr;
   end
end
reg  bank10_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank10_ram1_rd_en_d1 <= bank10_ram1_rd_en;
   end
end
reg [7:0] bank10_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank10_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank10_ram1_rd_addr_d1 <= bank10_ram1_rd_addr;
   end
end
reg  bank11_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank11_ram0_rd_en_d1 <= bank11_ram0_rd_en;
   end
end
reg [7:0] bank11_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank11_ram0_rd_addr_d1 <= bank11_ram0_rd_addr;
   end
end
reg  bank11_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank11_ram1_rd_en_d1 <= bank11_ram1_rd_en;
   end
end
reg [7:0] bank11_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank11_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank11_ram1_rd_addr_d1 <= bank11_ram1_rd_addr;
   end
end
reg  bank12_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank12_ram0_rd_en_d1 <= bank12_ram0_rd_en;
   end
end
reg [7:0] bank12_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank12_ram0_rd_addr_d1 <= bank12_ram0_rd_addr;
   end
end
reg  bank12_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank12_ram1_rd_en_d1 <= bank12_ram1_rd_en;
   end
end
reg [7:0] bank12_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank12_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank12_ram1_rd_addr_d1 <= bank12_ram1_rd_addr;
   end
end
reg  bank13_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank13_ram0_rd_en_d1 <= bank13_ram0_rd_en;
   end
end
reg [7:0] bank13_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank13_ram0_rd_addr_d1 <= bank13_ram0_rd_addr;
   end
end
reg  bank13_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank13_ram1_rd_en_d1 <= bank13_ram1_rd_en;
   end
end
reg [7:0] bank13_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank13_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank13_ram1_rd_addr_d1 <= bank13_ram1_rd_addr;
   end
end
reg  bank14_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank14_ram0_rd_en_d1 <= bank14_ram0_rd_en;
   end
end
reg [7:0] bank14_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank14_ram0_rd_addr_d1 <= bank14_ram0_rd_addr;
   end
end
reg  bank14_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank14_ram1_rd_en_d1 <= bank14_ram1_rd_en;
   end
end
reg [7:0] bank14_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank14_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank14_ram1_rd_addr_d1 <= bank14_ram1_rd_addr;
   end
end
reg  bank15_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank15_ram0_rd_en_d1 <= bank15_ram0_rd_en;
   end
end
reg [7:0] bank15_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank15_ram0_rd_addr_d1 <= bank15_ram0_rd_addr;
   end
end
reg  bank15_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank15_ram1_rd_en_d1 <= bank15_ram1_rd_en;
   end
end
reg [7:0] bank15_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank15_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank15_ram1_rd_addr_d1 <= bank15_ram1_rd_addr;
   end
end
reg  bank16_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank16_ram0_rd_en_d1 <= bank16_ram0_rd_en;
   end
end
reg [7:0] bank16_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank16_ram0_rd_addr_d1 <= bank16_ram0_rd_addr;
   end
end
reg  bank16_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank16_ram1_rd_en_d1 <= bank16_ram1_rd_en;
   end
end
reg [7:0] bank16_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank16_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank16_ram1_rd_addr_d1 <= bank16_ram1_rd_addr;
   end
end
reg  bank17_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank17_ram0_rd_en_d1 <= bank17_ram0_rd_en;
   end
end
reg [7:0] bank17_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank17_ram0_rd_addr_d1 <= bank17_ram0_rd_addr;
   end
end
reg  bank17_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank17_ram1_rd_en_d1 <= bank17_ram1_rd_en;
   end
end
reg [7:0] bank17_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank17_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank17_ram1_rd_addr_d1 <= bank17_ram1_rd_addr;
   end
end
reg  bank18_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank18_ram0_rd_en_d1 <= bank18_ram0_rd_en;
   end
end
reg [7:0] bank18_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank18_ram0_rd_addr_d1 <= bank18_ram0_rd_addr;
   end
end
reg  bank18_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank18_ram1_rd_en_d1 <= bank18_ram1_rd_en;
   end
end
reg [7:0] bank18_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank18_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank18_ram1_rd_addr_d1 <= bank18_ram1_rd_addr;
   end
end
reg  bank19_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank19_ram0_rd_en_d1 <= bank19_ram0_rd_en;
   end
end
reg [7:0] bank19_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank19_ram0_rd_addr_d1 <= bank19_ram0_rd_addr;
   end
end
reg  bank19_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank19_ram1_rd_en_d1 <= bank19_ram1_rd_en;
   end
end
reg [7:0] bank19_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank19_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank19_ram1_rd_addr_d1 <= bank19_ram1_rd_addr;
   end
end
reg  bank20_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank20_ram0_rd_en_d1 <= bank20_ram0_rd_en;
   end
end
reg [7:0] bank20_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank20_ram0_rd_addr_d1 <= bank20_ram0_rd_addr;
   end
end
reg  bank20_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank20_ram1_rd_en_d1 <= bank20_ram1_rd_en;
   end
end
reg [7:0] bank20_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank20_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank20_ram1_rd_addr_d1 <= bank20_ram1_rd_addr;
   end
end
reg  bank21_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank21_ram0_rd_en_d1 <= bank21_ram0_rd_en;
   end
end
reg [7:0] bank21_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank21_ram0_rd_addr_d1 <= bank21_ram0_rd_addr;
   end
end
reg  bank21_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank21_ram1_rd_en_d1 <= bank21_ram1_rd_en;
   end
end
reg [7:0] bank21_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank21_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank21_ram1_rd_addr_d1 <= bank21_ram1_rd_addr;
   end
end
reg  bank22_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank22_ram0_rd_en_d1 <= bank22_ram0_rd_en;
   end
end
reg [7:0] bank22_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank22_ram0_rd_addr_d1 <= bank22_ram0_rd_addr;
   end
end
reg  bank22_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank22_ram1_rd_en_d1 <= bank22_ram1_rd_en;
   end
end
reg [7:0] bank22_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank22_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank22_ram1_rd_addr_d1 <= bank22_ram1_rd_addr;
   end
end
reg  bank23_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank23_ram0_rd_en_d1 <= bank23_ram0_rd_en;
   end
end
reg [7:0] bank23_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank23_ram0_rd_addr_d1 <= bank23_ram0_rd_addr;
   end
end
reg  bank23_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank23_ram1_rd_en_d1 <= bank23_ram1_rd_en;
   end
end
reg [7:0] bank23_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank23_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank23_ram1_rd_addr_d1 <= bank23_ram1_rd_addr;
   end
end
reg  bank24_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank24_ram0_rd_en_d1 <= bank24_ram0_rd_en;
   end
end
reg [7:0] bank24_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank24_ram0_rd_addr_d1 <= bank24_ram0_rd_addr;
   end
end
reg  bank24_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank24_ram1_rd_en_d1 <= bank24_ram1_rd_en;
   end
end
reg [7:0] bank24_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank24_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank24_ram1_rd_addr_d1 <= bank24_ram1_rd_addr;
   end
end
reg  bank25_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank25_ram0_rd_en_d1 <= bank25_ram0_rd_en;
   end
end
reg [7:0] bank25_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank25_ram0_rd_addr_d1 <= bank25_ram0_rd_addr;
   end
end
reg  bank25_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank25_ram1_rd_en_d1 <= bank25_ram1_rd_en;
   end
end
reg [7:0] bank25_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank25_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank25_ram1_rd_addr_d1 <= bank25_ram1_rd_addr;
   end
end
reg  bank26_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank26_ram0_rd_en_d1 <= bank26_ram0_rd_en;
   end
end
reg [7:0] bank26_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank26_ram0_rd_addr_d1 <= bank26_ram0_rd_addr;
   end
end
reg  bank26_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank26_ram1_rd_en_d1 <= bank26_ram1_rd_en;
   end
end
reg [7:0] bank26_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank26_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank26_ram1_rd_addr_d1 <= bank26_ram1_rd_addr;
   end
end
reg  bank27_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank27_ram0_rd_en_d1 <= bank27_ram0_rd_en;
   end
end
reg [7:0] bank27_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank27_ram0_rd_addr_d1 <= bank27_ram0_rd_addr;
   end
end
reg  bank27_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank27_ram1_rd_en_d1 <= bank27_ram1_rd_en;
   end
end
reg [7:0] bank27_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank27_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank27_ram1_rd_addr_d1 <= bank27_ram1_rd_addr;
   end
end
reg  bank28_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank28_ram0_rd_en_d1 <= bank28_ram0_rd_en;
   end
end
reg [7:0] bank28_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank28_ram0_rd_addr_d1 <= bank28_ram0_rd_addr;
   end
end
reg  bank28_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank28_ram1_rd_en_d1 <= bank28_ram1_rd_en;
   end
end
reg [7:0] bank28_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank28_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank28_ram1_rd_addr_d1 <= bank28_ram1_rd_addr;
   end
end
reg  bank29_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank29_ram0_rd_en_d1 <= bank29_ram0_rd_en;
   end
end
reg [7:0] bank29_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank29_ram0_rd_addr_d1 <= bank29_ram0_rd_addr;
   end
end
reg  bank29_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank29_ram1_rd_en_d1 <= bank29_ram1_rd_en;
   end
end
reg [7:0] bank29_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank29_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank29_ram1_rd_addr_d1 <= bank29_ram1_rd_addr;
   end
end
reg  bank30_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank30_ram0_rd_en_d1 <= bank30_ram0_rd_en;
   end
end
reg [7:0] bank30_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank30_ram0_rd_addr_d1 <= bank30_ram0_rd_addr;
   end
end
reg  bank30_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank30_ram1_rd_en_d1 <= bank30_ram1_rd_en;
   end
end
reg [7:0] bank30_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank30_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank30_ram1_rd_addr_d1 <= bank30_ram1_rd_addr;
   end
end
reg  bank31_ram0_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_rd_en_d1 <= 'b0;
   end else begin
       bank31_ram0_rd_en_d1 <= bank31_ram0_rd_en;
   end
end
reg [7:0] bank31_ram0_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram0_rd_addr_d1 <= 'b0;
   end else begin
       bank31_ram0_rd_addr_d1 <= bank31_ram0_rd_addr;
   end
end
reg  bank31_ram1_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_rd_en_d1 <= 'b0;
   end else begin
       bank31_ram1_rd_en_d1 <= bank31_ram1_rd_en;
   end
end
reg [7:0] bank31_ram1_rd_addr_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bank31_ram1_rd_addr_d1 <= 'b0;
   end else begin
       bank31_ram1_rd_addr_d1 <= bank31_ram1_rd_addr;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//instance SRAM.
//: my $dep= 512/2;
//: my $wid= 64;
//: for (my $i=0; $i<32; $i++){
//: for (my $j=0; $j<2; $j++){
//: print qq(
//: nv_ram_rws_${dep}x${wid} u_cbuf_ram_bank${i}_ram${j} (
//: .clk (nvdla_core_clk) //|< i
//: ,.ra (bank${i}_ram${j}_rd_addr_d1[9 -1 -1:0]) //|< r
//: ,.re (bank${i}_ram${j}_rd_en_d1) //|< r
//: ,.dout (bank${i}_ram${j}_rd_data) //|> w
//: ,.wa (bank${i}_ram${j}_wr_addr_d2[9 -1 -1:0]) //|< r
//: ,.we (bank${i}_ram${j}_wr_en_d2) //|< r
//: ,.di (bank${i}_ram${j}_wr_data_d2) //|< r
//: ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
//: );
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

nv_ram_rws_256x64 u_cbuf_ram_bank0_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank0_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank0_ram0_rd_en_d1) //|< r
,.dout (bank0_ram0_rd_data) //|> w
,.wa (bank0_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank0_ram0_wr_en_d2) //|< r
,.di (bank0_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank0_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank0_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank0_ram1_rd_en_d1) //|< r
,.dout (bank0_ram1_rd_data) //|> w
,.wa (bank0_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank0_ram1_wr_en_d2) //|< r
,.di (bank0_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank1_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank1_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank1_ram0_rd_en_d1) //|< r
,.dout (bank1_ram0_rd_data) //|> w
,.wa (bank1_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank1_ram0_wr_en_d2) //|< r
,.di (bank1_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank1_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank1_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank1_ram1_rd_en_d1) //|< r
,.dout (bank1_ram1_rd_data) //|> w
,.wa (bank1_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank1_ram1_wr_en_d2) //|< r
,.di (bank1_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank2_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank2_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank2_ram0_rd_en_d1) //|< r
,.dout (bank2_ram0_rd_data) //|> w
,.wa (bank2_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank2_ram0_wr_en_d2) //|< r
,.di (bank2_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank2_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank2_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank2_ram1_rd_en_d1) //|< r
,.dout (bank2_ram1_rd_data) //|> w
,.wa (bank2_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank2_ram1_wr_en_d2) //|< r
,.di (bank2_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank3_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank3_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank3_ram0_rd_en_d1) //|< r
,.dout (bank3_ram0_rd_data) //|> w
,.wa (bank3_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank3_ram0_wr_en_d2) //|< r
,.di (bank3_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank3_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank3_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank3_ram1_rd_en_d1) //|< r
,.dout (bank3_ram1_rd_data) //|> w
,.wa (bank3_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank3_ram1_wr_en_d2) //|< r
,.di (bank3_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank4_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank4_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank4_ram0_rd_en_d1) //|< r
,.dout (bank4_ram0_rd_data) //|> w
,.wa (bank4_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank4_ram0_wr_en_d2) //|< r
,.di (bank4_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank4_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank4_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank4_ram1_rd_en_d1) //|< r
,.dout (bank4_ram1_rd_data) //|> w
,.wa (bank4_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank4_ram1_wr_en_d2) //|< r
,.di (bank4_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank5_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank5_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank5_ram0_rd_en_d1) //|< r
,.dout (bank5_ram0_rd_data) //|> w
,.wa (bank5_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank5_ram0_wr_en_d2) //|< r
,.di (bank5_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank5_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank5_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank5_ram1_rd_en_d1) //|< r
,.dout (bank5_ram1_rd_data) //|> w
,.wa (bank5_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank5_ram1_wr_en_d2) //|< r
,.di (bank5_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank6_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank6_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank6_ram0_rd_en_d1) //|< r
,.dout (bank6_ram0_rd_data) //|> w
,.wa (bank6_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank6_ram0_wr_en_d2) //|< r
,.di (bank6_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank6_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank6_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank6_ram1_rd_en_d1) //|< r
,.dout (bank6_ram1_rd_data) //|> w
,.wa (bank6_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank6_ram1_wr_en_d2) //|< r
,.di (bank6_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank7_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank7_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank7_ram0_rd_en_d1) //|< r
,.dout (bank7_ram0_rd_data) //|> w
,.wa (bank7_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank7_ram0_wr_en_d2) //|< r
,.di (bank7_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank7_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank7_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank7_ram1_rd_en_d1) //|< r
,.dout (bank7_ram1_rd_data) //|> w
,.wa (bank7_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank7_ram1_wr_en_d2) //|< r
,.di (bank7_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank8_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank8_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank8_ram0_rd_en_d1) //|< r
,.dout (bank8_ram0_rd_data) //|> w
,.wa (bank8_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank8_ram0_wr_en_d2) //|< r
,.di (bank8_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank8_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank8_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank8_ram1_rd_en_d1) //|< r
,.dout (bank8_ram1_rd_data) //|> w
,.wa (bank8_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank8_ram1_wr_en_d2) //|< r
,.di (bank8_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank9_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank9_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank9_ram0_rd_en_d1) //|< r
,.dout (bank9_ram0_rd_data) //|> w
,.wa (bank9_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank9_ram0_wr_en_d2) //|< r
,.di (bank9_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank9_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank9_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank9_ram1_rd_en_d1) //|< r
,.dout (bank9_ram1_rd_data) //|> w
,.wa (bank9_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank9_ram1_wr_en_d2) //|< r
,.di (bank9_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank10_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank10_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank10_ram0_rd_en_d1) //|< r
,.dout (bank10_ram0_rd_data) //|> w
,.wa (bank10_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank10_ram0_wr_en_d2) //|< r
,.di (bank10_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank10_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank10_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank10_ram1_rd_en_d1) //|< r
,.dout (bank10_ram1_rd_data) //|> w
,.wa (bank10_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank10_ram1_wr_en_d2) //|< r
,.di (bank10_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank11_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank11_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank11_ram0_rd_en_d1) //|< r
,.dout (bank11_ram0_rd_data) //|> w
,.wa (bank11_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank11_ram0_wr_en_d2) //|< r
,.di (bank11_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank11_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank11_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank11_ram1_rd_en_d1) //|< r
,.dout (bank11_ram1_rd_data) //|> w
,.wa (bank11_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank11_ram1_wr_en_d2) //|< r
,.di (bank11_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank12_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank12_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank12_ram0_rd_en_d1) //|< r
,.dout (bank12_ram0_rd_data) //|> w
,.wa (bank12_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank12_ram0_wr_en_d2) //|< r
,.di (bank12_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank12_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank12_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank12_ram1_rd_en_d1) //|< r
,.dout (bank12_ram1_rd_data) //|> w
,.wa (bank12_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank12_ram1_wr_en_d2) //|< r
,.di (bank12_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank13_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank13_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank13_ram0_rd_en_d1) //|< r
,.dout (bank13_ram0_rd_data) //|> w
,.wa (bank13_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank13_ram0_wr_en_d2) //|< r
,.di (bank13_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank13_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank13_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank13_ram1_rd_en_d1) //|< r
,.dout (bank13_ram1_rd_data) //|> w
,.wa (bank13_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank13_ram1_wr_en_d2) //|< r
,.di (bank13_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank14_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank14_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank14_ram0_rd_en_d1) //|< r
,.dout (bank14_ram0_rd_data) //|> w
,.wa (bank14_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank14_ram0_wr_en_d2) //|< r
,.di (bank14_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank14_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank14_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank14_ram1_rd_en_d1) //|< r
,.dout (bank14_ram1_rd_data) //|> w
,.wa (bank14_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank14_ram1_wr_en_d2) //|< r
,.di (bank14_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank15_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank15_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank15_ram0_rd_en_d1) //|< r
,.dout (bank15_ram0_rd_data) //|> w
,.wa (bank15_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank15_ram0_wr_en_d2) //|< r
,.di (bank15_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank15_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank15_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank15_ram1_rd_en_d1) //|< r
,.dout (bank15_ram1_rd_data) //|> w
,.wa (bank15_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank15_ram1_wr_en_d2) //|< r
,.di (bank15_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank16_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank16_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank16_ram0_rd_en_d1) //|< r
,.dout (bank16_ram0_rd_data) //|> w
,.wa (bank16_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank16_ram0_wr_en_d2) //|< r
,.di (bank16_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank16_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank16_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank16_ram1_rd_en_d1) //|< r
,.dout (bank16_ram1_rd_data) //|> w
,.wa (bank16_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank16_ram1_wr_en_d2) //|< r
,.di (bank16_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank17_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank17_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank17_ram0_rd_en_d1) //|< r
,.dout (bank17_ram0_rd_data) //|> w
,.wa (bank17_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank17_ram0_wr_en_d2) //|< r
,.di (bank17_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank17_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank17_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank17_ram1_rd_en_d1) //|< r
,.dout (bank17_ram1_rd_data) //|> w
,.wa (bank17_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank17_ram1_wr_en_d2) //|< r
,.di (bank17_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank18_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank18_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank18_ram0_rd_en_d1) //|< r
,.dout (bank18_ram0_rd_data) //|> w
,.wa (bank18_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank18_ram0_wr_en_d2) //|< r
,.di (bank18_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank18_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank18_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank18_ram1_rd_en_d1) //|< r
,.dout (bank18_ram1_rd_data) //|> w
,.wa (bank18_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank18_ram1_wr_en_d2) //|< r
,.di (bank18_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank19_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank19_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank19_ram0_rd_en_d1) //|< r
,.dout (bank19_ram0_rd_data) //|> w
,.wa (bank19_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank19_ram0_wr_en_d2) //|< r
,.di (bank19_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank19_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank19_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank19_ram1_rd_en_d1) //|< r
,.dout (bank19_ram1_rd_data) //|> w
,.wa (bank19_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank19_ram1_wr_en_d2) //|< r
,.di (bank19_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank20_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank20_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank20_ram0_rd_en_d1) //|< r
,.dout (bank20_ram0_rd_data) //|> w
,.wa (bank20_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank20_ram0_wr_en_d2) //|< r
,.di (bank20_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank20_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank20_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank20_ram1_rd_en_d1) //|< r
,.dout (bank20_ram1_rd_data) //|> w
,.wa (bank20_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank20_ram1_wr_en_d2) //|< r
,.di (bank20_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank21_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank21_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank21_ram0_rd_en_d1) //|< r
,.dout (bank21_ram0_rd_data) //|> w
,.wa (bank21_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank21_ram0_wr_en_d2) //|< r
,.di (bank21_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank21_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank21_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank21_ram1_rd_en_d1) //|< r
,.dout (bank21_ram1_rd_data) //|> w
,.wa (bank21_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank21_ram1_wr_en_d2) //|< r
,.di (bank21_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank22_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank22_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank22_ram0_rd_en_d1) //|< r
,.dout (bank22_ram0_rd_data) //|> w
,.wa (bank22_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank22_ram0_wr_en_d2) //|< r
,.di (bank22_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank22_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank22_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank22_ram1_rd_en_d1) //|< r
,.dout (bank22_ram1_rd_data) //|> w
,.wa (bank22_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank22_ram1_wr_en_d2) //|< r
,.di (bank22_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank23_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank23_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank23_ram0_rd_en_d1) //|< r
,.dout (bank23_ram0_rd_data) //|> w
,.wa (bank23_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank23_ram0_wr_en_d2) //|< r
,.di (bank23_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank23_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank23_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank23_ram1_rd_en_d1) //|< r
,.dout (bank23_ram1_rd_data) //|> w
,.wa (bank23_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank23_ram1_wr_en_d2) //|< r
,.di (bank23_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank24_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank24_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank24_ram0_rd_en_d1) //|< r
,.dout (bank24_ram0_rd_data) //|> w
,.wa (bank24_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank24_ram0_wr_en_d2) //|< r
,.di (bank24_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank24_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank24_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank24_ram1_rd_en_d1) //|< r
,.dout (bank24_ram1_rd_data) //|> w
,.wa (bank24_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank24_ram1_wr_en_d2) //|< r
,.di (bank24_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank25_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank25_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank25_ram0_rd_en_d1) //|< r
,.dout (bank25_ram0_rd_data) //|> w
,.wa (bank25_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank25_ram0_wr_en_d2) //|< r
,.di (bank25_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank25_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank25_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank25_ram1_rd_en_d1) //|< r
,.dout (bank25_ram1_rd_data) //|> w
,.wa (bank25_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank25_ram1_wr_en_d2) //|< r
,.di (bank25_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank26_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank26_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank26_ram0_rd_en_d1) //|< r
,.dout (bank26_ram0_rd_data) //|> w
,.wa (bank26_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank26_ram0_wr_en_d2) //|< r
,.di (bank26_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank26_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank26_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank26_ram1_rd_en_d1) //|< r
,.dout (bank26_ram1_rd_data) //|> w
,.wa (bank26_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank26_ram1_wr_en_d2) //|< r
,.di (bank26_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank27_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank27_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank27_ram0_rd_en_d1) //|< r
,.dout (bank27_ram0_rd_data) //|> w
,.wa (bank27_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank27_ram0_wr_en_d2) //|< r
,.di (bank27_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank27_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank27_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank27_ram1_rd_en_d1) //|< r
,.dout (bank27_ram1_rd_data) //|> w
,.wa (bank27_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank27_ram1_wr_en_d2) //|< r
,.di (bank27_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank28_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank28_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank28_ram0_rd_en_d1) //|< r
,.dout (bank28_ram0_rd_data) //|> w
,.wa (bank28_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank28_ram0_wr_en_d2) //|< r
,.di (bank28_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank28_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank28_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank28_ram1_rd_en_d1) //|< r
,.dout (bank28_ram1_rd_data) //|> w
,.wa (bank28_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank28_ram1_wr_en_d2) //|< r
,.di (bank28_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank29_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank29_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank29_ram0_rd_en_d1) //|< r
,.dout (bank29_ram0_rd_data) //|> w
,.wa (bank29_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank29_ram0_wr_en_d2) //|< r
,.di (bank29_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank29_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank29_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank29_ram1_rd_en_d1) //|< r
,.dout (bank29_ram1_rd_data) //|> w
,.wa (bank29_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank29_ram1_wr_en_d2) //|< r
,.di (bank29_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank30_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank30_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank30_ram0_rd_en_d1) //|< r
,.dout (bank30_ram0_rd_data) //|> w
,.wa (bank30_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank30_ram0_wr_en_d2) //|< r
,.di (bank30_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank30_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank30_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank30_ram1_rd_en_d1) //|< r
,.dout (bank30_ram1_rd_data) //|> w
,.wa (bank30_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank30_ram1_wr_en_d2) //|< r
,.di (bank30_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank31_ram0 (
.clk (nvdla_core_clk) //|< i
,.ra (bank31_ram0_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank31_ram0_rd_en_d1) //|< r
,.dout (bank31_ram0_rd_data) //|> w
,.wa (bank31_ram0_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank31_ram0_wr_en_d2) //|< r
,.di (bank31_ram0_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

nv_ram_rws_256x64 u_cbuf_ram_bank31_ram1 (
.clk (nvdla_core_clk) //|< i
,.ra (bank31_ram1_rd_addr_d1[9 -1 -1:0]) //|< r
,.re (bank31_ram1_rd_en_d1) //|< r
,.dout (bank31_ram1_rd_data) //|> w
,.wa (bank31_ram1_wr_addr_d2[9 -1 -1:0]) //|< r
,.we (bank31_ram1_wr_en_d2) //|< r
,.di (bank31_ram1_wr_data_d2) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
