// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_MRDMA_EG_din.v
`include "simulate_x_tick.vh"
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_define.h
module NV_NVDLA_SDP_MRDMA_EG_din (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,reg2dp_src_ram_type //|< i
  ,cmd2dat_spt_prdy //|> o
  ,cmd2dat_spt_pd //|< i
  ,cmd2dat_spt_pvld //|< i
  ,dma_rd_cdt_lat_fifo_pop //|> o
  ,dma_rd_rsp_ram_type //|> o
  ,dma_rd_rsp_pd //|< i
  ,dma_rd_rsp_vld //|< i
  ,dma_rd_rsp_rdy //|> o
  ,pfifo0_rd_prdy //|< i
  ,pfifo1_rd_prdy //|< i
  ,pfifo2_rd_prdy //|< i
  ,pfifo3_rd_prdy //|< i
  ,pfifo0_rd_pd //|> o
  ,pfifo0_rd_pvld //|> o
  ,pfifo1_rd_pd //|> o
  ,pfifo1_rd_pvld //|> o
  ,pfifo2_rd_pd //|> o
  ,pfifo2_rd_pvld //|> o
  ,pfifo3_rd_pd //|> o
  ,pfifo3_rd_pvld //|> o
  );
//&Catenate "NV_NVDLA_SDP_MRDMA_EG_din_ports.v";
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input reg2dp_src_ram_type;
output dma_rd_rsp_ram_type;
input [65 -1:0] dma_rd_rsp_pd;
input dma_rd_rsp_vld;
output dma_rd_rsp_rdy;
output dma_rd_cdt_lat_fifo_pop;
input [12:0] cmd2dat_spt_pd;
input cmd2dat_spt_pvld;
output cmd2dat_spt_prdy;
input pfifo0_rd_prdy;
input pfifo1_rd_prdy;
input pfifo2_rd_prdy;
input pfifo3_rd_prdy;
output [8*8 -1:0] pfifo0_rd_pd;
output pfifo0_rd_pvld;
output [8*8 -1:0] pfifo1_rd_pd;
output pfifo1_rd_pvld;
output [8*8 -1:0] pfifo2_rd_pd;
output pfifo2_rd_pvld;
output [8*8 -1:0] pfifo3_rd_pd;
output pfifo3_rd_pvld;
wire cmd2dat_spt_primary;
wire [12:0] cmd2dat_spt_size;
wire [13:0] cmd_size;
wire is_last_beat;
reg [12:0] beat_cnt;
wire [13:0] beat_cnt_nxt;
reg mon_beat_cnt;
wire lat_ecc_rd_accept;
wire [64 -1:0] lat_ecc_rd_data;
wire [3:0] lat_ecc_rd_mask;
wire [65 -1:0] lat_ecc_rd_pd;
wire lat_ecc_rd_pvld;
wire lat_ecc_rd_prdy;
wire [8*8 -1:0] pfifo0_wr_pd;
wire pfifo0_wr_prdy;
wire pfifo0_wr_pvld;
wire [8*8 -1:0] pfifo1_wr_pd;
wire pfifo1_wr_prdy;
wire pfifo1_wr_pvld;
wire [8*8 -1:0] pfifo2_wr_pd;
wire pfifo2_wr_prdy;
wire pfifo2_wr_pvld;
wire [8*8 -1:0] pfifo3_wr_pd;
wire pfifo3_wr_prdy;
wire pfifo3_wr_pvld;
wire [4*8*8 +3:0] unpack_out_pd;
wire unpack_out_pvld;
wire unpack_out_prdy;
wire pfifo_wr_rdy;
wire pfifo_wr_vld;
wire [3:0] pfifo_wr_mask;
//==============
// Latency FIFO to buffer return DATA
//==============
assign dma_rd_rsp_ram_type = reg2dp_src_ram_type;
assign dma_rd_cdt_lat_fifo_pop = lat_ecc_rd_pvld & lat_ecc_rd_prdy;
//: my $depth = 8;
//: my $width = 65;
//: print "NV_NVDLA_SDP_MRDMA_EG_lat_fifo_${depth}x${width}  u_lat_fifo (\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
NV_NVDLA_SDP_MRDMA_EG_lat_fifo_8x65  u_lat_fifo (

//| eperl: generated_end (DO NOT EDIT ABOVE)
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.lat_wr_prdy (dma_rd_rsp_rdy)
  ,.lat_wr_pvld (dma_rd_rsp_vld)
  ,.lat_wr_pd (dma_rd_rsp_pd[65 -1:0])
  ,.lat_rd_prdy (lat_ecc_rd_prdy)
  ,.lat_rd_pvld (lat_ecc_rd_pvld)
  ,.lat_rd_pd (lat_ecc_rd_pd[65 -1:0])
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  );
assign lat_ecc_rd_accept = lat_ecc_rd_pvld & lat_ecc_rd_prdy;
assign lat_ecc_rd_data[64 -1:0] = lat_ecc_rd_pd[64 -1:0];
assign lat_ecc_rd_mask[3:0] = {{(4-1){1'b0}},lat_ecc_rd_pd[65 -1:64]};
wire [2:0] lat_ecc_rd_size = lat_ecc_rd_mask[3]+lat_ecc_rd_mask[2]+lat_ecc_rd_mask[1]+lat_ecc_rd_mask[0];
//========command for pfifo wr ====================
assign cmd2dat_spt_prdy = lat_ecc_rd_accept & is_last_beat;
assign cmd2dat_spt_size[12:0] = cmd2dat_spt_pd[12:0];
//assign cmd2dat_spt_primary = cmd2dat_spt_pd[12];
assign cmd_size = cmd2dat_spt_pvld ? (cmd2dat_spt_size+1) : 0;
assign beat_cnt_nxt = beat_cnt + lat_ecc_rd_size;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    {mon_beat_cnt,beat_cnt} <= 14'h0;
  end else begin
    if (lat_ecc_rd_accept) begin
        if (is_last_beat) begin
            {mon_beat_cnt,beat_cnt} <= 14'h0;
        end else begin
            {mon_beat_cnt,beat_cnt} <= beat_cnt_nxt;
        end
    end
  end
end
assign is_last_beat = beat_cnt_nxt == cmd_size;
/////////combine lat fifo pd to 4*atomic_m*bpe//////
wire lat_ecc_rd_beat_end = is_last_beat;
NV_NVDLA_SDP_RDMA_unpack u_rdma_unpack (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.inp_data (lat_ecc_rd_pd[65 -1:0])
  ,.inp_pvld (lat_ecc_rd_pvld)
  ,.inp_prdy (lat_ecc_rd_prdy)
  ,.inp_end (lat_ecc_rd_beat_end)
  ,.out_data (unpack_out_pd[4*8*8 +3:0])
  ,.out_pvld (unpack_out_pvld)
  ,.out_prdy (unpack_out_prdy)
  );
assign unpack_out_prdy = pfifo_wr_rdy;
assign pfifo_wr_mask = unpack_out_pd[4*8*8 +3:4*8*8];
assign pfifo_wr_vld = unpack_out_pvld;
//==================================
// FIFO WRITE
assign pfifo0_wr_pd = unpack_out_pd[8*8*0+8*8 -1:8*8*0];
assign pfifo1_wr_pd = unpack_out_pd[8*8*1+8*8 -1:8*8*1];
assign pfifo2_wr_pd = unpack_out_pd[8*8*2+8*8 -1:8*8*2];
assign pfifo3_wr_pd = unpack_out_pd[8*8*3+8*8 -1:8*8*3];
assign pfifo_wr_rdy = ~(pfifo_wr_mask[0] & ~pfifo0_wr_prdy |pfifo_wr_mask[1] & ~pfifo1_wr_prdy | pfifo_wr_mask[2] & ~pfifo2_wr_prdy | pfifo_wr_mask[3] & ~pfifo3_wr_prdy );
assign pfifo0_wr_pvld = pfifo_wr_vld & pfifo_wr_mask[0] & ~(pfifo_wr_mask[1] & ~pfifo1_wr_prdy | pfifo_wr_mask[2] & ~pfifo2_wr_prdy | pfifo_wr_mask[3] & ~pfifo3_wr_prdy );
assign pfifo1_wr_pvld = pfifo_wr_vld & pfifo_wr_mask[1] & ~(pfifo_wr_mask[0] & ~pfifo0_wr_prdy | pfifo_wr_mask[2] & ~pfifo2_wr_prdy | pfifo_wr_mask[3] & ~pfifo3_wr_prdy );
assign pfifo2_wr_pvld = pfifo_wr_vld & pfifo_wr_mask[2] & ~(pfifo_wr_mask[0] & ~pfifo0_wr_prdy | pfifo_wr_mask[1] & ~pfifo1_wr_prdy | pfifo_wr_mask[3] & ~pfifo3_wr_prdy );
assign pfifo3_wr_pvld = pfifo_wr_vld & pfifo_wr_mask[3] & ~(pfifo_wr_mask[0] & ~pfifo0_wr_prdy | pfifo_wr_mask[1] & ~pfifo1_wr_prdy | pfifo_wr_mask[2] & ~pfifo2_wr_prdy );
//==================================
// FIFO INSTANCE
NV_NVDLA_SDP_MRDMA_EG_pfifo u_pfifo0 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pfifo_wr_prdy (pfifo0_wr_prdy) //|> w
  ,.pfifo_wr_pvld (pfifo0_wr_pvld) //|< w
  ,.pfifo_wr_pd (pfifo0_wr_pd[8*8 -1:0]) //|< w
  ,.pfifo_rd_prdy (pfifo0_rd_prdy) //|< i
  ,.pfifo_rd_pvld (pfifo0_rd_pvld) //|> o
  ,.pfifo_rd_pd (pfifo0_rd_pd[8*8 -1:0]) //|> o
  );
NV_NVDLA_SDP_MRDMA_EG_pfifo u_pfifo1 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pfifo_wr_prdy (pfifo1_wr_prdy) //|> w
  ,.pfifo_wr_pvld (pfifo1_wr_pvld) //|< w
  ,.pfifo_wr_pd (pfifo1_wr_pd[8*8 -1:0]) //|< w
  ,.pfifo_rd_prdy (pfifo1_rd_prdy) //|< i
  ,.pfifo_rd_pvld (pfifo1_rd_pvld) //|> o
  ,.pfifo_rd_pd (pfifo1_rd_pd[8*8 -1:0]) //|> o
  );
NV_NVDLA_SDP_MRDMA_EG_pfifo u_pfifo2 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pfifo_wr_prdy (pfifo2_wr_prdy) //|> w
  ,.pfifo_wr_pvld (pfifo2_wr_pvld) //|< w
  ,.pfifo_wr_pd (pfifo2_wr_pd[8*8 -1:0]) //|< w
  ,.pfifo_rd_prdy (pfifo2_rd_prdy) //|< i
  ,.pfifo_rd_pvld (pfifo2_rd_pvld) //|> o
  ,.pfifo_rd_pd (pfifo2_rd_pd[8*8 -1:0]) //|> o
  );
NV_NVDLA_SDP_MRDMA_EG_pfifo u_pfifo3 (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pfifo_wr_prdy (pfifo3_wr_prdy) //|> w
  ,.pfifo_wr_pvld (pfifo3_wr_pvld) //|< w
  ,.pfifo_wr_pd (pfifo3_wr_pd[8*8 -1:0]) //|< w
  ,.pfifo_rd_prdy (pfifo3_rd_prdy) //|< i
  ,.pfifo_rd_pvld (pfifo3_rd_pvld) //|> o
  ,.pfifo_rd_pd (pfifo3_rd_pd[8*8 -1:0]) //|> o
  );
endmodule // NV_NVDLA_SDP_MRDMA_EG_din
module NV_NVDLA_SDP_MRDMA_EG_pfifo (
      nvdla_core_clk
    , nvdla_core_rstn
    , pfifo_wr_prdy
    , pfifo_wr_pvld
    , pfifo_wr_pd
    , pfifo_rd_prdy
    , pfifo_rd_pvld
    , pfifo_rd_pd
    );
input nvdla_core_clk;
input nvdla_core_rstn;
output pfifo_wr_prdy;
input pfifo_wr_pvld;
input [8*8 -1:0] pfifo_wr_pd;
input pfifo_rd_prdy;
output pfifo_rd_pvld;
output [8*8 -1:0] pfifo_rd_pd;
//: my $dw = 8*8;
//: &eperl::pipe("-is -wid $dw -do pfifo_rd_pd -vo pfifo_rd_pvld -ri pfifo_rd_prdy -di pfifo_wr_pd -vi pfifo_wr_pvld -ro pfifo_wr_prdy");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg pfifo_wr_prdy;
reg skid_flop_pfifo_wr_prdy;
reg skid_flop_pfifo_wr_pvld;
reg [64-1:0] skid_flop_pfifo_wr_pd;
reg pipe_skid_pfifo_wr_pvld;
reg [64-1:0] pipe_skid_pfifo_wr_pd;
// Wire
wire skid_pfifo_wr_pvld;
wire [64-1:0] skid_pfifo_wr_pd;
wire skid_pfifo_wr_prdy;
wire pipe_skid_pfifo_wr_prdy;
wire pfifo_rd_pvld;
wire [64-1:0] pfifo_rd_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       pfifo_wr_prdy <= 1'b1;
       skid_flop_pfifo_wr_prdy <= 1'b1;
   end else begin
       pfifo_wr_prdy <= skid_pfifo_wr_prdy;
       skid_flop_pfifo_wr_prdy <= skid_pfifo_wr_prdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_pfifo_wr_pvld <= 1'b0;
    end else begin
        if (skid_flop_pfifo_wr_prdy) begin
            skid_flop_pfifo_wr_pvld <= pfifo_wr_pvld;
        end
   end
end
assign skid_pfifo_wr_pvld = (skid_flop_pfifo_wr_prdy) ? pfifo_wr_pvld : skid_flop_pfifo_wr_pvld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_pfifo_wr_prdy & pfifo_wr_pvld) begin
        skid_flop_pfifo_wr_pd[64-1:0] <= pfifo_wr_pd[64-1:0];
    end
end
assign skid_pfifo_wr_pd[64-1:0] = (skid_flop_pfifo_wr_prdy) ? pfifo_wr_pd[64-1:0] : skid_flop_pfifo_wr_pd[64-1:0];


// PIPE READY
assign skid_pfifo_wr_prdy = pipe_skid_pfifo_wr_prdy || !pipe_skid_pfifo_wr_pvld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_pfifo_wr_pvld <= 1'b0;
    end else begin
        if (skid_pfifo_wr_prdy) begin
            pipe_skid_pfifo_wr_pvld <= skid_pfifo_wr_pvld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_pfifo_wr_prdy && skid_pfifo_wr_pvld) begin
        pipe_skid_pfifo_wr_pd[64-1:0] <= skid_pfifo_wr_pd[64-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_pfifo_wr_prdy = pfifo_rd_prdy;
assign pfifo_rd_pvld = pipe_skid_pfifo_wr_pvld;
assign pfifo_rd_pd = pipe_skid_pfifo_wr_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_SDP_MRDMA_EG_pfifo
