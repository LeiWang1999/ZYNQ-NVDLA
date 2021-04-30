// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_RDMA_eg.v
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
`include "simulate_x_tick.vh"
module NV_NVDLA_CDP_RDMA_eg (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cdp_rdma2dp_ready //|< i
  ,cq_rd_pd //|< i
  ,cq_rd_pvld //|< i
  ,mcif2cdp_rd_rsp_pd //|< i
  ,mcif2cdp_rd_rsp_valid //|< i
  ,pwrbus_ram_pd //|< i
  ,reg2dp_channel //|< i
  ,reg2dp_input_data //|< i
  ,reg2dp_src_ram_type //|< i
  ,cdp2mcif_rd_cdt_lat_fifo_pop //|> o
  ,cdp_rdma2dp_pd //|> o
  ,cdp_rdma2dp_valid //|> o
  ,cq_rd_prdy //|> o
  ,dp2reg_done //|> o
  ,eg2ig_done //|> o
  ,mcif2cdp_rd_rsp_ready //|> o
  );
/////////////////////////////////////////////////////////////////////////////////////////
input [4:0] reg2dp_channel;
input [1:0] reg2dp_input_data;
input reg2dp_src_ram_type;
output dp2reg_done;
output eg2ig_done;
input nvdla_core_clk;
input nvdla_core_rstn;
input mcif2cdp_rd_rsp_valid; /* data valid */
output mcif2cdp_rd_rsp_ready; /* data return handshake */
//: my $k=64;
//: my $jx = 8*8; ##atomic_m BW
//: my $M = $k/$jx; ##atomic_m number per dma transaction
//: print "input [${k}+${M}-1:0] mcif2cdp_rd_rsp_pd;  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
input [64+1-1:0] mcif2cdp_rd_rsp_pd;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
output cdp2mcif_rd_cdt_lat_fifo_pop;
output cdp_rdma2dp_valid; /* data valid */
input cdp_rdma2dp_ready; /* data return handshake */
output [1*8 +24:0] cdp_rdma2dp_pd;
input cq_rd_pvld; /* data valid */
output cq_rd_prdy; /* data return handshake */
input [6:0] cq_rd_pd;
input [31:0] pwrbus_ram_pd;
/////////////////////////////////////////////////////////////////////////////////////////
//: my $Mnum = 64/8/8;
//: my $Mnumbit= int( log($Mnum)/log(2) );
//: if($Mnum > 1){
//: print " reg      [${Mnumbit}-1:0] beat_align; \n";
//: } else{
//: print " reg                       beat_align; \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
 reg                       beat_align; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [3:0] beat_cnt;
reg cdp2mcif_rd_cdt_lat_fifo_pop;
wire [1*8 +24:0] cdp_rdma2dp_pd;
//reg cdp_rdma2dp_valid_f;
wire dp2reg_done_flag;
reg [1*8 -1:0] dp_data;
wire dp_rdy;
reg dp_vld;
wire eg2ig_done_flag;
reg [1 -1:0] invalid_flag;
reg is_last_c;
reg is_last_h;
reg is_last_w;
reg [5:0] tran_cnt;
reg [3:0] width_cnt;
wire [4:0] ele_in_channel;
//wire cv_dma_rd_rsp_vld;
//wire cv_int_rd_rsp_ready;
//wire cv_int_rd_rsp_valid;
// #ifdef NVDLA_SECONDARY_MEMIF_ENABLE
//wire cvif2cdp_rd_rsp_ready_d0;
//wire cvif2cdp_rd_rsp_valid_d0;
//#endif
wire dma_rd_cdt_lat_fifo_pop;
wire dma_rd_rsp_rdy;
wire dma_rd_rsp_type;
wire dma_rd_rsp_vld;
wire dp2reg_done_f;
wire dp_b_sync;
wire [7:0] dp_invalid;
wire dp_last_c;
wire dp_last_h;
wire dp_last_w;
wire [1*8 +24:0] dp_pd;
wire [4:0] dp_pos_c;
wire [3:0] dp_pos_w;
wire [3:0] dp_width;
wire eg2ig_done_f;
//: my $kx = 1*8;
//: my $k = 64/$kx;
//: print " wire     [${k}-1:0] fifo_rd_pvld;  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 wire     [8-1:0] fifo_rd_pvld;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
//wire [7:0] fifo_rd_pvld;
wire [5:0] fifo_sel;
wire ig2eg_align;
wire ig2eg_last_c;
wire ig2eg_last_h;
wire ig2eg_last_w;
wire [2:0] ig2eg_width;
wire is_b_sync;
wire is_cube_end;
wire is_last_beat;
wire is_last_tran;
//: my $k=64;
//: my $jx = 8*8; ##atomic_m BW
//: my $M = $k/$jx; ##atomic_m number per dma transaction
//: ##print "wire [${k}+${M}-1:0] cv_dma_rd_rsp_pd;  \n";
//: ##print "wire [${k}+${M}-1:0] cv_int_rd_rsp_pd;  \n";
//: ##print "wire [${k}+${M}-1:0] cvif2cdp_rd_rsp_pd_d0;  \n";
//: print "wire [${k}+${M}-1:0] dma_rd_rsp_pd;  \n";
//: print "wire [${k}+${M}-1:0] lat_rd_pd;  \n";
//: ##print "wire [${k}+${M}-1:0] mc_dma_rd_rsp_pd;  \n";
//: ##print "wire [${k}+${M}-1:0] mc_int_rd_rsp_pd;  \n";
//: ##print "wire [${k}+${M}-1:0] mcif2cdp_rd_rsp_pd_d0;  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [64+1-1:0] dma_rd_rsp_pd;  
wire [64+1-1:0] lat_rd_pd;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [64 -1:0] lat_rd_data;
//: my $jx = 8*8; ##atomic_m BW
//: my $M = 64/$jx; ##atomic_m number per dma transaction
//: print "wire     [${M}-1:0] lat_rd_mask; \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire     [1-1:0] lat_rd_mask; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire lat_rd_prdy;
wire lat_rd_pvld;
//wire mc_dma_rd_rsp_vld;
//wire mc_int_rd_rsp_ready;
//wire mc_int_rd_rsp_valid;
//wire mcif2cdp_rd_rsp_ready_d0;
//wire mcif2cdp_rd_rsp_valid_d0;
wire [5:0] rest_channel;
//: my $kx = 1*8; ##throughput BW
//: my $jx = 8*8; ##atomic_m BW
//: my $k = 64/$kx; ##total fifo num
//: my $M = 64/$jx; ##atomic_m number per dma transaction
//: my $F = $k/$M; ##how many fifo contribute to one atomic_m
//: foreach my $m (0..$k-1) {
//: print qq(
//: wire [${kx}-1:0] ro${m}_rd_pd;
//: wire ro${m}_rd_prdy;
//: wire ro${m}_rd_pvld;
//: wire [${kx}-1:0] ro${m}_wr_pd;
//: );
//: }
//: foreach my $m (0..$M-1) {
//: print qq(
//: wire ro${m}_wr_pvld;
//: wire ro${m}_wr_rdy;
//: );
//: }
//: foreach my $i (0..$M-1) {
//: print qq(
//: wire [${F}-1:0] ro${i}_wr_rdys;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [8-1:0] ro0_rd_pd;
wire ro0_rd_prdy;
wire ro0_rd_pvld;
wire [8-1:0] ro0_wr_pd;

wire [8-1:0] ro1_rd_pd;
wire ro1_rd_prdy;
wire ro1_rd_pvld;
wire [8-1:0] ro1_wr_pd;

wire [8-1:0] ro2_rd_pd;
wire ro2_rd_prdy;
wire ro2_rd_pvld;
wire [8-1:0] ro2_wr_pd;

wire [8-1:0] ro3_rd_pd;
wire ro3_rd_prdy;
wire ro3_rd_pvld;
wire [8-1:0] ro3_wr_pd;

wire [8-1:0] ro4_rd_pd;
wire ro4_rd_prdy;
wire ro4_rd_pvld;
wire [8-1:0] ro4_wr_pd;

wire [8-1:0] ro5_rd_pd;
wire ro5_rd_prdy;
wire ro5_rd_pvld;
wire [8-1:0] ro5_wr_pd;

wire [8-1:0] ro6_rd_pd;
wire ro6_rd_prdy;
wire ro6_rd_pvld;
wire [8-1:0] ro6_wr_pd;

wire [8-1:0] ro7_rd_pd;
wire ro7_rd_prdy;
wire ro7_rd_pvld;
wire [8-1:0] ro7_wr_pd;

wire ro0_wr_pvld;
wire ro0_wr_rdy;

wire [8-1:0] ro0_wr_rdys;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire tran_cnt_idle;
wire [3:0] tran_num;
wire tran_rdy;
wire tran_vld;
///////////////////////////////////////////////////////////////////////////
//==============
// DMA Interface
//==============
NV_NVDLA_DMAIF_rdrsp NV_NVDLA_CDP_RDMA_rdrsp(
   .nvdla_core_clk (nvdla_core_clk )
  ,.nvdla_core_rstn (nvdla_core_rstn )
  ,.mcif_rd_rsp_pd (mcif2cdp_rd_rsp_pd )
  ,.mcif_rd_rsp_valid (mcif2cdp_rd_rsp_valid )
  ,.mcif_rd_rsp_ready (mcif2cdp_rd_rsp_ready )
  ,.dmaif_rd_rsp_pd (dma_rd_rsp_pd )
  ,.dmaif_rd_rsp_pvld (dma_rd_rsp_vld )
  ,.dmaif_rd_rsp_prdy (dma_rd_rsp_rdy )
);
///////////////////////////////////////////////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cdp2mcif_rd_cdt_lat_fifo_pop <= 1'b0;
  end else begin
  cdp2mcif_rd_cdt_lat_fifo_pop <= dma_rd_cdt_lat_fifo_pop & (dma_rd_rsp_type == 1'b1);
  end
end
assign dma_rd_rsp_type = reg2dp_src_ram_type;
//==============
// Latency FIFO to buffer return DATA
//==============
//: my $k=64;
//: my $jx = 8*8; ##atomic_m BW
//: my $M = $k/$jx; ##atomic_m number per dma transaction
//: my $s = $k + $M;
//: my $depth = 8;
//: print " NV_NVDLA_CDP_RDMA_lat_fifo_${s}x${depth} u_lat_fifo (  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 NV_NVDLA_CDP_RDMA_lat_fifo_65x8 u_lat_fifo (  

//| eperl: generated_end (DO NOT EDIT ABOVE)
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.lat_wr_prdy (dma_rd_rsp_rdy) //|> w
  ,.lat_wr_pvld (dma_rd_rsp_vld) //|< w
  ,.lat_wr_pd (dma_rd_rsp_pd) //|< w
  ,.lat_rd_prdy (lat_rd_prdy) //|< w
  ,.lat_rd_pvld (lat_rd_pvld) //|> w
  ,.lat_rd_pd (lat_rd_pd) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  );
assign lat_rd_data[64 -1:0] = lat_rd_pd[64 -1:0];
assign lat_rd_mask[1 -1:0] = lat_rd_pd[65 -1: 64];
assign dma_rd_cdt_lat_fifo_pop = lat_rd_pvld & lat_rd_prdy;
//==============
// Re-Order FIFO to send data to CDP-core in DP order(read NVDLA PP uARCH for details)
//==============
assign lat_rd_prdy = lat_rd_pvld
//: my $msk = 1;
//: foreach my $k (0..$msk-1) {
//: print " & (~lat_rd_mask[$k] | (lat_rd_mask[$k] & ro${k}_wr_rdy))  \n";
//: }
//: print " ; \n";
//:
//: my $tp = 1*8; ## throughput
//: my $atmm = 8*8; ## atomic_m
//: my $M = 64/$atmm; ## atomic_m number per dma transaction
//: my $F = $atmm/$tp; ## how many fifo contribute to one atomic_m
//:
//:
//: foreach my $i (0..$M-1){
//: print "    assign ro${i}_wr_pvld = lat_rd_pvld & (lat_rd_mask[${i}] & ro${i}_wr_rdy)  \n";
//: foreach my $s (0..$msk-1) {
//: if($s != $i) {
//: print "        & ( ~lat_rd_mask[${s}] | (lat_rd_mask[${s}] & ro${s}_wr_rdy))  \n";
//: }
//: }
//: print " ;  \n";
//: }
//:
//:
//: foreach my $m (0..$M-1) {
//: print "   assign ro${m}_wr_rdy = &ro${m}_wr_rdys;  \n";
//: foreach my $f (0..$F-1) {
//: my $r = $F * $m + $f;
//: print " assign ro${r}_wr_pd  = lat_rd_data[${tp}*${r}+${tp}-1:${tp}*${r}];  \n";
//: print " NV_NVDLA_CDP_RDMA_ro_fifo_32x${tp} u_ro${r}_fifo(     \n";
//: print "  .nvdla_core_clk      (nvdla_core_clk)       \n";
//: print " ,.nvdla_core_rstn     (nvdla_core_rstn)      \n";
//: print " ,.ro_wr_prdy          (ro${m}_wr_rdys[$f])   \n";
//: print " ,.ro_wr_pvld          (ro${m}_wr_pvld)       \n";
//: print " ,.ro_wr_pd            (ro${r}_wr_pd)         \n";
//: print " ,.ro_rd_prdy          (ro${r}_rd_prdy)       \n";
//: print " ,.ro_rd_pvld          (ro${r}_rd_pvld)       \n";
//: print " ,.ro_rd_pd            (ro${r}_rd_pd)         \n";
//: print " ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  \n";
//: print " ); \n";
//: }
//: }
//:
//:
//: my $Fbit = int( log($F)/log(2) );
//: if($M > 1) {
//: print " assign fifo_sel[5:0] = tran_cnt_idle ? 6'd0 : ((6'd${F}-tran_cnt) + {beat_align,{${Fbit}{1'b0}}}); \n";
//: } else {
//: print " assign fifo_sel[5:0] = tran_cnt_idle ? 6'd0 : ((6'd${F}-tran_cnt)); \n";
//: }
//:
//:
//: print " // DATA MUX out \n";
//: print " always @(*) begin \n";
//: print " case(fifo_sel) \n";
//: foreach my $m (0..$M-1) {
//: foreach my $f (0..$F-1) {
//: my $r = $F * $m + $f;
//: print "   6'd$r: begin \n";
//: print "       dp_vld = ro${r}_rd_pvld & (~tran_cnt_idle); \n";
//: print "   end \n";
//: }
//: }
//: print "default: begin \n";
//: print "       dp_vld = 1'b0; \n";
//: print "end \n";
//: print "endcase \n";
//: print "end \n";
//:
//:
//: foreach my $m (0..$M-1) {
//: foreach my $f (0..$F-1) {
//: my $r = $F * $m + $f;
//: print " assign ro${r}_rd_prdy = dp_rdy & (fifo_sel==$r) & (~tran_cnt_idle);  \n";
//: }
//: }
//: my $kx = 1*8; ##throughput BW
//: my $jx = 8*8; ##atomic_m BW
//: my $k = 64/$kx; ##total fifo num
//: my $M = 64/$jx; ##atomic_m number per dma trans
//: my $F = $k/$M; ##how many fifo contribute to one atomic_m
//: print "always @(*)      \n";
//: print "begin      \n";
//: print "case(fifo_sel)     \n";
//: foreach my $r (0..$k-1) {
//: print "   6'd$r: begin      \n";
//: print "               dp_data  = ro${r}_rd_pd[${kx}-1:0];      \n";
//: print "   end      \n";
//: }
//: print "default: dp_data = {${kx}{1'b0}};      \n";
//: print "endcase      \n";
//: print "end      \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 & (~lat_rd_mask[0] | (lat_rd_mask[0] & ro0_wr_rdy))  
 ; 
    assign ro0_wr_pvld = lat_rd_pvld & (lat_rd_mask[0] & ro0_wr_rdy)  
 ;  
   assign ro0_wr_rdy = &ro0_wr_rdys;  
 assign ro0_wr_pd  = lat_rd_data[8*0+8-1:8*0];  
 NV_NVDLA_CDP_RDMA_ro_fifo_32x8 u_ro0_fifo(     
  .nvdla_core_clk      (nvdla_core_clk)       
 ,.nvdla_core_rstn     (nvdla_core_rstn)      
 ,.ro_wr_prdy          (ro0_wr_rdys[0])   
 ,.ro_wr_pvld          (ro0_wr_pvld)       
 ,.ro_wr_pd            (ro0_wr_pd)         
 ,.ro_rd_prdy          (ro0_rd_prdy)       
 ,.ro_rd_pvld          (ro0_rd_pvld)       
 ,.ro_rd_pd            (ro0_rd_pd)         
 ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  
 ); 
 assign ro1_wr_pd  = lat_rd_data[8*1+8-1:8*1];  
 NV_NVDLA_CDP_RDMA_ro_fifo_32x8 u_ro1_fifo(     
  .nvdla_core_clk      (nvdla_core_clk)       
 ,.nvdla_core_rstn     (nvdla_core_rstn)      
 ,.ro_wr_prdy          (ro0_wr_rdys[1])   
 ,.ro_wr_pvld          (ro0_wr_pvld)       
 ,.ro_wr_pd            (ro1_wr_pd)         
 ,.ro_rd_prdy          (ro1_rd_prdy)       
 ,.ro_rd_pvld          (ro1_rd_pvld)       
 ,.ro_rd_pd            (ro1_rd_pd)         
 ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  
 ); 
 assign ro2_wr_pd  = lat_rd_data[8*2+8-1:8*2];  
 NV_NVDLA_CDP_RDMA_ro_fifo_32x8 u_ro2_fifo(     
  .nvdla_core_clk      (nvdla_core_clk)       
 ,.nvdla_core_rstn     (nvdla_core_rstn)      
 ,.ro_wr_prdy          (ro0_wr_rdys[2])   
 ,.ro_wr_pvld          (ro0_wr_pvld)       
 ,.ro_wr_pd            (ro2_wr_pd)         
 ,.ro_rd_prdy          (ro2_rd_prdy)       
 ,.ro_rd_pvld          (ro2_rd_pvld)       
 ,.ro_rd_pd            (ro2_rd_pd)         
 ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  
 ); 
 assign ro3_wr_pd  = lat_rd_data[8*3+8-1:8*3];  
 NV_NVDLA_CDP_RDMA_ro_fifo_32x8 u_ro3_fifo(     
  .nvdla_core_clk      (nvdla_core_clk)       
 ,.nvdla_core_rstn     (nvdla_core_rstn)      
 ,.ro_wr_prdy          (ro0_wr_rdys[3])   
 ,.ro_wr_pvld          (ro0_wr_pvld)       
 ,.ro_wr_pd            (ro3_wr_pd)         
 ,.ro_rd_prdy          (ro3_rd_prdy)       
 ,.ro_rd_pvld          (ro3_rd_pvld)       
 ,.ro_rd_pd            (ro3_rd_pd)         
 ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  
 ); 
 assign ro4_wr_pd  = lat_rd_data[8*4+8-1:8*4];  
 NV_NVDLA_CDP_RDMA_ro_fifo_32x8 u_ro4_fifo(     
  .nvdla_core_clk      (nvdla_core_clk)       
 ,.nvdla_core_rstn     (nvdla_core_rstn)      
 ,.ro_wr_prdy          (ro0_wr_rdys[4])   
 ,.ro_wr_pvld          (ro0_wr_pvld)       
 ,.ro_wr_pd            (ro4_wr_pd)         
 ,.ro_rd_prdy          (ro4_rd_prdy)       
 ,.ro_rd_pvld          (ro4_rd_pvld)       
 ,.ro_rd_pd            (ro4_rd_pd)         
 ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  
 ); 
 assign ro5_wr_pd  = lat_rd_data[8*5+8-1:8*5];  
 NV_NVDLA_CDP_RDMA_ro_fifo_32x8 u_ro5_fifo(     
  .nvdla_core_clk      (nvdla_core_clk)       
 ,.nvdla_core_rstn     (nvdla_core_rstn)      
 ,.ro_wr_prdy          (ro0_wr_rdys[5])   
 ,.ro_wr_pvld          (ro0_wr_pvld)       
 ,.ro_wr_pd            (ro5_wr_pd)         
 ,.ro_rd_prdy          (ro5_rd_prdy)       
 ,.ro_rd_pvld          (ro5_rd_pvld)       
 ,.ro_rd_pd            (ro5_rd_pd)         
 ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  
 ); 
 assign ro6_wr_pd  = lat_rd_data[8*6+8-1:8*6];  
 NV_NVDLA_CDP_RDMA_ro_fifo_32x8 u_ro6_fifo(     
  .nvdla_core_clk      (nvdla_core_clk)       
 ,.nvdla_core_rstn     (nvdla_core_rstn)      
 ,.ro_wr_prdy          (ro0_wr_rdys[6])   
 ,.ro_wr_pvld          (ro0_wr_pvld)       
 ,.ro_wr_pd            (ro6_wr_pd)         
 ,.ro_rd_prdy          (ro6_rd_prdy)       
 ,.ro_rd_pvld          (ro6_rd_pvld)       
 ,.ro_rd_pd            (ro6_rd_pd)         
 ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  
 ); 
 assign ro7_wr_pd  = lat_rd_data[8*7+8-1:8*7];  
 NV_NVDLA_CDP_RDMA_ro_fifo_32x8 u_ro7_fifo(     
  .nvdla_core_clk      (nvdla_core_clk)       
 ,.nvdla_core_rstn     (nvdla_core_rstn)      
 ,.ro_wr_prdy          (ro0_wr_rdys[7])   
 ,.ro_wr_pvld          (ro0_wr_pvld)       
 ,.ro_wr_pd            (ro7_wr_pd)         
 ,.ro_rd_prdy          (ro7_rd_prdy)       
 ,.ro_rd_pvld          (ro7_rd_pvld)       
 ,.ro_rd_pd            (ro7_rd_pd)         
 ,.pwrbus_ram_pd       (pwrbus_ram_pd[31:0])  
 ); 
 assign fifo_sel[5:0] = tran_cnt_idle ? 6'd0 : ((6'd8-tran_cnt)); 
 // DATA MUX out 
 always @(*) begin 
 case(fifo_sel) 
   6'd0: begin 
       dp_vld = ro0_rd_pvld & (~tran_cnt_idle); 
   end 
   6'd1: begin 
       dp_vld = ro1_rd_pvld & (~tran_cnt_idle); 
   end 
   6'd2: begin 
       dp_vld = ro2_rd_pvld & (~tran_cnt_idle); 
   end 
   6'd3: begin 
       dp_vld = ro3_rd_pvld & (~tran_cnt_idle); 
   end 
   6'd4: begin 
       dp_vld = ro4_rd_pvld & (~tran_cnt_idle); 
   end 
   6'd5: begin 
       dp_vld = ro5_rd_pvld & (~tran_cnt_idle); 
   end 
   6'd6: begin 
       dp_vld = ro6_rd_pvld & (~tran_cnt_idle); 
   end 
   6'd7: begin 
       dp_vld = ro7_rd_pvld & (~tran_cnt_idle); 
   end 
default: begin 
       dp_vld = 1'b0; 
end 
endcase 
end 
 assign ro0_rd_prdy = dp_rdy & (fifo_sel==0) & (~tran_cnt_idle);  
 assign ro1_rd_prdy = dp_rdy & (fifo_sel==1) & (~tran_cnt_idle);  
 assign ro2_rd_prdy = dp_rdy & (fifo_sel==2) & (~tran_cnt_idle);  
 assign ro3_rd_prdy = dp_rdy & (fifo_sel==3) & (~tran_cnt_idle);  
 assign ro4_rd_prdy = dp_rdy & (fifo_sel==4) & (~tran_cnt_idle);  
 assign ro5_rd_prdy = dp_rdy & (fifo_sel==5) & (~tran_cnt_idle);  
 assign ro6_rd_prdy = dp_rdy & (fifo_sel==6) & (~tran_cnt_idle);  
 assign ro7_rd_prdy = dp_rdy & (fifo_sel==7) & (~tran_cnt_idle);  
always @(*)      
begin      
case(fifo_sel)     
   6'd0: begin      
               dp_data  = ro0_rd_pd[8-1:0];      
   end      
   6'd1: begin      
               dp_data  = ro1_rd_pd[8-1:0];      
   end      
   6'd2: begin      
               dp_data  = ro2_rd_pd[8-1:0];      
   end      
   6'd3: begin      
               dp_data  = ro3_rd_pd[8-1:0];      
   end      
   6'd4: begin      
               dp_data  = ro4_rd_pd[8-1:0];      
   end      
   6'd5: begin      
               dp_data  = ro5_rd_pd[8-1:0];      
   end      
   6'd6: begin      
               dp_data  = ro6_rd_pd[8-1:0];      
   end      
   6'd7: begin      
               dp_data  = ro7_rd_pd[8-1:0];      
   end      
default: dp_data = {8{1'b0}};      
endcase      
end      

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////
//replacd by 0 value in invalid position
//////////////////////
//: my $tp = 1;
//: my $atmm = 8;
//: my $tt_fifo_num = 64/8/$tp;
//: my $M = 64/8/$atmm;
//: my $F = $atmm/$tp;
//:
//: my $tpbw = int(log($tp)/log(2));
//: my $atmmbw = int(log($atmm)/log(2));
//: if($atmmbw ==5) {
//: print " assign ele_in_channel = {reg2dp_channel[${atmmbw}-1:0]};   \n";
//: } else {
//: print " assign ele_in_channel = {{(5-${atmmbw}){1'b0}},reg2dp_channel[${atmmbw}-1:0]};   \n";
//: }
//: ##print " assign ele_in_channel = {{(5-${atmmbw}){1'b0}},reg2dp_channel[${atmmbw}-1:0]};   \n";
//: print " assign rest_channel=(6'd${F}-ele_in_channel[${atmmbw}-1:${tpbw}]);  \n";
//:
//: print " always @(*)  begin \n";
//: print " case(fifo_sel)  \n";
//: foreach my $r (0..$tt_fifo_num-1) {
//: print "   6'd$r: begin  \n";
//: print "       if(is_last_c) begin  \n";
//: print "           if(tran_cnt < rest_channel)  \n";
//: print "               invalid_flag  = {${tp}{1'b1}};  \n";
//: print "           else if(tran_cnt > rest_channel)  \n";
//: print "               invalid_flag  = {${tp}{1'b0}};  \n";
//: print "           else  \n";
//:
//: if($tp == 1) {
//: print "               invalid_flag  = {${tp}{1'b0}};  \n";
//: } else {
//: print "               invalid_flag = {${tp}{ele_in_channel[${tpbw}-1:0]==${tpbw}'d0}} & {{(${tp}-1){1'b1}},1'b0}  \n";
//: foreach my $i (0..$tp-2) {
//: my $j = $i + 1;
//: my $s = $j + 1;
//: if($s < $tp){
//: print "             | {${tp}{ele_in_channel[${tpbw}-1:0]==${tpbw}'d${j}}} & {{(${tp}-${s}){1'b1}},${s}'b0}  \n";
//: } else {
//: print "             | {${tp}{ele_in_channel[${tpbw}-1:0]==${tpbw}'d${j}}} & {${s}'b0}  \n";
//: }
//: ##print "             | {${tp}{ele_in_channel[${tpbw}-1:0]==${tpbw}'d${j}}} & {{(${tp}-${s}){1'b1}},${s}'b0}  \n";
//: }
//: print "     ;  \n";
//: }
//: print "       end else  \n";
//: print "           invalid_flag  = {${tp}{1'b0}};  \n";
//: print "   end  \n";
//: }
//: print "default: invalid_flag = {${tp}{1'b0}};  \n";
//: print "endcase  \n";
//: print "end  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 assign ele_in_channel = {{(5-3){1'b0}},reg2dp_channel[3-1:0]};   
 assign rest_channel=(6'd8-ele_in_channel[3-1:0]);  
 always @(*)  begin 
 case(fifo_sel)  
   6'd0: begin  
       if(is_last_c) begin  
           if(tran_cnt < rest_channel)  
               invalid_flag  = {1{1'b1}};  
           else if(tran_cnt > rest_channel)  
               invalid_flag  = {1{1'b0}};  
           else  
               invalid_flag  = {1{1'b0}};  
       end else  
           invalid_flag  = {1{1'b0}};  
   end  
   6'd1: begin  
       if(is_last_c) begin  
           if(tran_cnt < rest_channel)  
               invalid_flag  = {1{1'b1}};  
           else if(tran_cnt > rest_channel)  
               invalid_flag  = {1{1'b0}};  
           else  
               invalid_flag  = {1{1'b0}};  
       end else  
           invalid_flag  = {1{1'b0}};  
   end  
   6'd2: begin  
       if(is_last_c) begin  
           if(tran_cnt < rest_channel)  
               invalid_flag  = {1{1'b1}};  
           else if(tran_cnt > rest_channel)  
               invalid_flag  = {1{1'b0}};  
           else  
               invalid_flag  = {1{1'b0}};  
       end else  
           invalid_flag  = {1{1'b0}};  
   end  
   6'd3: begin  
       if(is_last_c) begin  
           if(tran_cnt < rest_channel)  
               invalid_flag  = {1{1'b1}};  
           else if(tran_cnt > rest_channel)  
               invalid_flag  = {1{1'b0}};  
           else  
               invalid_flag  = {1{1'b0}};  
       end else  
           invalid_flag  = {1{1'b0}};  
   end  
   6'd4: begin  
       if(is_last_c) begin  
           if(tran_cnt < rest_channel)  
               invalid_flag  = {1{1'b1}};  
           else if(tran_cnt > rest_channel)  
               invalid_flag  = {1{1'b0}};  
           else  
               invalid_flag  = {1{1'b0}};  
       end else  
           invalid_flag  = {1{1'b0}};  
   end  
   6'd5: begin  
       if(is_last_c) begin  
           if(tran_cnt < rest_channel)  
               invalid_flag  = {1{1'b1}};  
           else if(tran_cnt > rest_channel)  
               invalid_flag  = {1{1'b0}};  
           else  
               invalid_flag  = {1{1'b0}};  
       end else  
           invalid_flag  = {1{1'b0}};  
   end  
   6'd6: begin  
       if(is_last_c) begin  
           if(tran_cnt < rest_channel)  
               invalid_flag  = {1{1'b1}};  
           else if(tran_cnt > rest_channel)  
               invalid_flag  = {1{1'b0}};  
           else  
               invalid_flag  = {1{1'b0}};  
       end else  
           invalid_flag  = {1{1'b0}};  
   end  
   6'd7: begin  
       if(is_last_c) begin  
           if(tran_cnt < rest_channel)  
               invalid_flag  = {1{1'b1}};  
           else if(tran_cnt > rest_channel)  
               invalid_flag  = {1{1'b0}};  
           else  
               invalid_flag  = {1{1'b0}};  
       end else  
           invalid_flag  = {1{1'b0}};  
   end  
default: invalid_flag = {1{1'b0}};  
endcase  
end  

//| eperl: generated_end (DO NOT EDIT ABOVE)
//==============
// Return Data Counting
//==============
// unpack from rd_pd, which should be the same order as wr_pd
assign cq_rd_prdy = tran_rdy;
assign tran_vld = cq_rd_pvld;
assign ig2eg_width[2:0] = cq_rd_pd[2:0];
assign ig2eg_align = cq_rd_pd[3];
assign ig2eg_last_w = cq_rd_pd[4];
assign ig2eg_last_h = cq_rd_pd[5];
assign ig2eg_last_c = cq_rd_pd[6];
assign tran_num[3:0] = ig2eg_width + 1;
assign tran_cnt_idle = (tran_cnt==0);
assign is_last_tran = (tran_cnt==1);
assign is_last_beat = (beat_cnt==1);
//: my $kx = 1*8; ##throughput BW
//: my $jx = 8*8; ##atomic_m BW
//: my $k = 64/$kx; ##total fifo num
//: my $M = 64/$jx; ##atomic_m number per dma trans
//: my $F = $k/$M; ##how many fifo contribute to one atomic_m
//: foreach my $r (0..$k-1) {
//: print " assign fifo_rd_pvld[$r] = (fifo_sel==${r}) & ro${r}_rd_pvld;  \n";
//: }
//: print "wire     fifo_rd_pvld_active = |fifo_rd_pvld;    \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 assign fifo_rd_pvld[0] = (fifo_sel==0) & ro0_rd_pvld;  
 assign fifo_rd_pvld[1] = (fifo_sel==1) & ro1_rd_pvld;  
 assign fifo_rd_pvld[2] = (fifo_sel==2) & ro2_rd_pvld;  
 assign fifo_rd_pvld[3] = (fifo_sel==3) & ro3_rd_pvld;  
 assign fifo_rd_pvld[4] = (fifo_sel==4) & ro4_rd_pvld;  
 assign fifo_rd_pvld[5] = (fifo_sel==5) & ro5_rd_pvld;  
 assign fifo_rd_pvld[6] = (fifo_sel==6) & ro6_rd_pvld;  
 assign fifo_rd_pvld[7] = (fifo_sel==7) & ro7_rd_pvld;  
wire     fifo_rd_pvld_active = |fifo_rd_pvld;    

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire tran_accept;
//the first cq_rd_prdy should start when fifo have data to be read
assign tran_rdy = (tran_cnt_idle & fifo_rd_pvld_active/*(|fifo_rd_pvld)*/) || (is_last_tran & is_last_beat & dp_rdy);
assign tran_accept = tran_vld & tran_rdy;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    tran_cnt <= 0;
    beat_cnt <= 0;
  end else begin
    if(is_cube_end & tran_rdy) begin
            tran_cnt <= 0;
            beat_cnt <= 0;
    end else if(tran_rdy) begin
        if (tran_vld) begin
//: my $F = 8/1;
//: print " tran_cnt    <= 6'd${F}; \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 tran_cnt    <= 6'd8; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
            beat_cnt <= tran_num;
        end else begin
            tran_cnt <= 0;
            beat_cnt <= 0;
        end
    end else if (dp_rdy & fifo_rd_pvld_active/*(|fifo_rd_pvld)*/) begin
        beat_cnt <= (beat_cnt==1)? width_cnt : beat_cnt - 1;
        if (is_last_beat) begin
            tran_cnt <= tran_cnt - 1;
        end
    end
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    beat_align <= 0;
  end else begin
    if (tran_rdy) begin
        beat_align <= 0;
    end else if (dp_rdy & fifo_rd_pvld_active/*|fifo_rd_pvld*/) begin
        if (is_last_beat) begin
            beat_align <= 0;
        end else begin
            beat_align <= beat_align + 1'b1;
        end
    end
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    width_cnt <= {4{1'b0}};
  end else begin
  if ((tran_accept) == 1'b1) begin
    width_cnt <= tran_num;
// VCS coverage off
  end else if ((tran_accept) == 1'b0) begin
  end else begin
    width_cnt <= 'bx; // spyglass disable STARC-2.10.1.6 W443 NoWidthInBasedNum-ML -- (Constant containing x or z used, Based number `bx contains an X, Width specification missing for based number)
// VCS coverage on
  end
  end
end
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
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_2x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(tran_accept))); // spyglass disable W504 SelfDeterminedExpr-ML 
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
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    is_last_w <= 1'b0;
    is_last_h <= 1'b0;
    is_last_c <= 1'b0;
  end else begin
    if(is_cube_end & tran_rdy) begin
        is_last_w <= 1'b0;
        is_last_h <= 1'b0;
        is_last_c <= 1'b0;
    end else if(tran_accept) begin
        is_last_w <= ig2eg_last_w;
        is_last_h <= ig2eg_last_h;
        is_last_c <= ig2eg_last_c;
    end
  end
end
assign is_b_sync = is_last_beat;
assign dp_pos_w[3:0] = width_cnt - beat_cnt; //spyglass disable W484
assign dp_width[3:0] = width_cnt; //spyglass disable W484
wire mon_dp_pos_c;
//: my $tp = 1*8;
//: my $atmm = 8*8;
//: my $F = $atmm/$tp;
//: print " assign {mon_dp_pos_c,dp_pos_c[4:0]} = 6'd${F} - tran_cnt; \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 assign {mon_dp_pos_c,dp_pos_c[4:0]} = 6'd8 - tran_cnt; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dp_b_sync = is_b_sync;
assign dp_last_w = is_last_w;
assign dp_last_h = is_last_h;
assign dp_last_c = is_last_c;
assign is_cube_end = is_last_w & is_last_h & is_last_c;
assign dp2reg_done_f = is_cube_end & tran_rdy;
assign eg2ig_done_f = is_cube_end & tran_rdy;
//==============
// OUTPUT PACK and PIPE: To Data Processor
//==============
// PD Pack
//: my $tp = 1;
//: if($tp ==8) {
//: print " assign dp_invalid = {invalid_flag}; \n";
//: } else {
//: print " assign dp_invalid = {{(8-${tp}){1'b0}},invalid_flag}; \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
 assign dp_invalid = {{(8-1){1'b0}},invalid_flag}; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//assign dp_invalid = {{(8-1){1'b0}},invalid_flag};
// PKT_PACK_WIRE( cdp_rdma2dp , dp_ , dp_pd )
assign dp_pd[1*8 -1:0] = dp_data[1*8 -1:0];
assign dp_pd[1*8 +3:1*8] = dp_pos_w[3:0];
assign dp_pd[1*8 +7:1*8 +4] = dp_width[3:0];
assign dp_pd[1*8 +12:1*8 +8] = dp_pos_c[4:0];
assign dp_pd[1*8 +13] = dp_b_sync ;
assign dp_pd[1*8 +14] = dp_last_w ;
assign dp_pd[1*8 +15] = dp_last_h ;
assign dp_pd[1*8 +16] = dp_last_c ;
assign dp_pd[1*8 +24:1*8 +17] = dp_invalid[7:0];
wire [1*8 +27-1:0] cdp_rdma2dp_pd_i;
assign cdp_rdma2dp_pd_i = {dp_pd,dp2reg_done_f,eg2ig_done_f};
//: my $k=1*8 +27;
//: &eperl::pipe(" -wid $k -is -do cdp_rdma2dp_pd_o -vo cdp_rdma2dp_valid_f -ri cdp_rdma2dp_ready -di cdp_rdma2dp_pd_i  -vi dp_vld -ro dp_rdy_f ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg dp_rdy_f;
reg skid_flop_dp_rdy_f;
reg skid_flop_dp_vld;
reg [35-1:0] skid_flop_cdp_rdma2dp_pd_i;
reg pipe_skid_dp_vld;
reg [35-1:0] pipe_skid_cdp_rdma2dp_pd_i;
// Wire
wire skid_dp_vld;
wire [35-1:0] skid_cdp_rdma2dp_pd_i;
wire skid_dp_rdy_f;
wire pipe_skid_dp_rdy_f;
wire cdp_rdma2dp_valid_f;
wire [35-1:0] cdp_rdma2dp_pd_o;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dp_rdy_f <= 1'b1;
       skid_flop_dp_rdy_f <= 1'b1;
   end else begin
       dp_rdy_f <= skid_dp_rdy_f;
       skid_flop_dp_rdy_f <= skid_dp_rdy_f;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_dp_vld <= 1'b0;
    end else begin
        if (skid_flop_dp_rdy_f) begin
            skid_flop_dp_vld <= dp_vld;
        end
   end
end
assign skid_dp_vld = (skid_flop_dp_rdy_f) ? dp_vld : skid_flop_dp_vld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_dp_rdy_f & dp_vld) begin
        skid_flop_cdp_rdma2dp_pd_i[35-1:0] <= cdp_rdma2dp_pd_i[35-1:0];
    end
end
assign skid_cdp_rdma2dp_pd_i[35-1:0] = (skid_flop_dp_rdy_f) ? cdp_rdma2dp_pd_i[35-1:0] : skid_flop_cdp_rdma2dp_pd_i[35-1:0];


// PIPE READY
assign skid_dp_rdy_f = pipe_skid_dp_rdy_f || !pipe_skid_dp_vld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_dp_vld <= 1'b0;
    end else begin
        if (skid_dp_rdy_f) begin
            pipe_skid_dp_vld <= skid_dp_vld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_dp_rdy_f && skid_dp_vld) begin
        pipe_skid_cdp_rdma2dp_pd_i[35-1:0] <= skid_cdp_rdma2dp_pd_i[35-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_dp_rdy_f = cdp_rdma2dp_ready;
assign cdp_rdma2dp_valid_f = pipe_skid_dp_vld;
assign cdp_rdma2dp_pd_o = pipe_skid_cdp_rdma2dp_pd_i;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dp_rdy = dp_rdy_f;
assign {cdp_rdma2dp_pd,dp2reg_done_flag,eg2ig_done_flag} = cdp_rdma2dp_pd_o;
assign cdp_rdma2dp_valid = cdp_rdma2dp_valid_f;
assign dp2reg_done = (cdp_rdma2dp_valid_f & cdp_rdma2dp_ready & dp2reg_done_flag) ? 1'b1 : 1'b0;
assign eg2ig_done = (cdp_rdma2dp_valid_f & cdp_rdma2dp_ready & eg2ig_done_flag) ? 1'b1 : 1'b0;
//==============
//function points
//==============
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    reg funcpoint_cover_off;
    initial begin
        if ( $test$plusargs( "cover_off" ) ) begin
            funcpoint_cover_off = 1'b1;
        end else begin
            funcpoint_cover_off = 1'b0;
        end
    end
    property CDP_RDMA_eg__bsync_end_stall__0_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        is_b_sync & (~dp_rdy);
    endproperty
// Cover 0 : "is_b_sync & (~dp_rdy)"
    FUNCPOINT_CDP_RDMA_eg__bsync_end_stall__0_COV : cover property (CDP_RDMA_eg__bsync_end_stall__0_cov);
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    property CDP_RDMA_eg__widthe_end_stall__1_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        is_last_w & (~dp_rdy);
    endproperty
// Cover 1 : "is_last_w & (~dp_rdy)"
    FUNCPOINT_CDP_RDMA_eg__widthe_end_stall__1_COV : cover property (CDP_RDMA_eg__widthe_end_stall__1_cov);
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    property CDP_RDMA_eg__cube_end_stall__2_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        is_last_h & (~dp_rdy);
    endproperty
// Cover 2 : "is_last_h & (~dp_rdy)"
    FUNCPOINT_CDP_RDMA_eg__cube_end_stall__2_COV : cover property (CDP_RDMA_eg__cube_end_stall__2_cov);
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    property CDP_RDMA_eg__channel_end_stall__3_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        is_last_c & (~dp_rdy);
    endproperty
// Cover 3 : "is_last_c & (~dp_rdy)"
    FUNCPOINT_CDP_RDMA_eg__channel_end_stall__3_COV : cover property (CDP_RDMA_eg__channel_end_stall__3_cov);
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    property CDP_RDMA_eg_backpressure_cq__4_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        tran_rdy & (~tran_vld) & (~is_cube_end);
    endproperty
// Cover 4 : "tran_rdy & (~tran_vld) & (~is_cube_end)"
    FUNCPOINT_CDP_RDMA_eg_backpressure_cq__4_COV : cover property (CDP_RDMA_eg_backpressure_cq__4_cov);
  `endif
`endif
//VCS coverage on
endmodule // NV_NVDLA_CDP_RDMA_eg
//
// AUTOMATICALLY GENERATED -- DO NOT EDIT OR CHECK IN
//
// /home/nvtools/engr/2017/03/11_05_00_06/nvtools/scripts/fifogen
// fifogen -input_config_yaml ../../../../../../../socd/ip_chip_tools/1.0/defs/public/fifogen/golden/tlit5/fifogen.yml -no_make_ram -no_make_ram -stdout -m NV_NVDLA_CDP_RDMA_lat_fifo -clk_name nvdla_core_clk -reset_name nvdla_core_rstn -wr_pipebus lat_wr -rd_pipebus lat_rd -rd_reg -d 61 -w 514 -ram ra2 [Chosen ram type: ra2 - ramgen_generic (user specified, thus no other ram type is allowed)]
// chip config vars: assertion_module_prefix=nv_ strict_synchronizers=1 strict_synchronizers_use_lib_cells=1 strict_synchronizers_use_tm_lib_cells=1 strict_sync_randomizer=1 assertion_message_prefix=FIFOGEN_ASSERTION allow_async_fifola=0 ignore_ramgen_fifola_variant=1 uses_p_SSYNC=0 uses_prand=1 uses_rammake_inc=1 use_x_or_0=1 force_wr_reg_gated=1 no_force_reset=1 no_timescale=1 no_pli_ifdef=1 requires_full_throughput=1 ram_auto_ff_bits_cutoff=16 ram_auto_ff_width_cutoff=2 ram_auto_ff_width_cutoff_max_depth=32 ram_auto_ff_depth_cutoff=-1 ram_auto_ff_no_la2_depth_cutoff=5 ram_auto_la2_width_cutoff=8 ram_auto_la2_width_cutoff_max_depth=56 ram_auto_la2_depth_cutoff=16 flopram_emu_model=1 dslp_single_clamp_port=1 dslp_clamp_port=1 slp_single_clamp_port=1 slp_clamp_port=1 master_clk_gated=1 clk_gate_module=NV_CLK_gate_power redundant_timing_flops=0 hot_reset_async_force_ports_and_loopback=1 ram_sleep_en_width=1 async_cdc_reg_id=NV_AFIFO_ rd_reg_default_for_async=1 async_ram_instance_prefix=NV_ASYNC_RAM_ allow_rd_busy_reg_warning=0 do_dft_xelim_gating=1 add_dft_xelim_wr_clkgate=1 add_dft_xelim_rd_clkgate=1
//
// leda B_3208_NV OFF -- Unequal length LHS and RHS in assignment
// leda B_1405 OFF -- 2 asynchronous resets in this unit detected
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
// Re-Order Data
// if we have rd_reg, then depth = required - 1 ,so depth=4-1=3
//
// AUTOMATICALLY GENERATED -- DO NOT EDIT OR CHECK IN
//
// /home/nvtools/engr/2017/03/11_05_00_06/nvtools/scripts/fifogen
// fifogen -input_config_yaml ../../../../../../../socd/ip_chip_tools/1.0/defs/public/fifogen/golden/tlit5/fifogen.yml -no_make_ram -no_make_ram -stdout -m NV_NVDLA_CDP_RDMA_ro_fifo -clk_name nvdla_core_clk -reset_name nvdla_core_rstn -wr_pipebus ro_wr -rd_pipebus ro_rd -rd_reg -rand_none -ram_bypass -d 4 -w 64 -ram ff [Chosen ram type: ff - fifogen_flops (user specified, thus no other ram type is allowed)]
// chip config vars: assertion_module_prefix=nv_ strict_synchronizers=1 strict_synchronizers_use_lib_cells=1 strict_synchronizers_use_tm_lib_cells=1 strict_sync_randomizer=1 assertion_message_prefix=FIFOGEN_ASSERTION allow_async_fifola=0 ignore_ramgen_fifola_variant=1 uses_p_SSYNC=0 uses_prand=1 uses_rammake_inc=1 use_x_or_0=1 force_wr_reg_gated=1 no_force_reset=1 no_timescale=1 no_pli_ifdef=1 requires_full_throughput=1 ram_auto_ff_bits_cutoff=16 ram_auto_ff_width_cutoff=2 ram_auto_ff_width_cutoff_max_depth=32 ram_auto_ff_depth_cutoff=-1 ram_auto_ff_no_la2_depth_cutoff=5 ram_auto_la2_width_cutoff=8 ram_auto_la2_width_cutoff_max_depth=56 ram_auto_la2_depth_cutoff=16 flopram_emu_model=1 dslp_single_clamp_port=1 dslp_clamp_port=1 slp_single_clamp_port=1 slp_clamp_port=1 master_clk_gated=1 clk_gate_module=NV_CLK_gate_power redundant_timing_flops=0 hot_reset_async_force_ports_and_loopback=1 ram_sleep_en_width=1 async_cdc_reg_id=NV_AFIFO_ rd_reg_default_for_async=1 async_ram_instance_prefix=NV_ASYNC_RAM_ allow_rd_busy_reg_warning=0 do_dft_xelim_gating=1 add_dft_xelim_wr_clkgate=1 add_dft_xelim_rd_clkgate=1
//
// leda B_3208_NV OFF -- Unequal length LHS and RHS in assignment
// leda B_1405 OFF -- 2 asynchronous resets in this unit detected
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
