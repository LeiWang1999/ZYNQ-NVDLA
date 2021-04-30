// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_DMAIF_wr.v
`include "simulate_x_tick.vh"
module NV_NVDLA_DMAIF_wr (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,reg2dp_dst_ram_type
  ,mcif_wr_req_pd
  ,mcif_wr_req_valid
  ,mcif_wr_req_ready
  ,mcif_wr_rsp_complete
  ,dmaif_wr_req_pd
  ,dmaif_wr_req_pvld
  ,dmaif_wr_req_prdy
  ,dmaif_wr_rsp_complete
);
//////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
input reg2dp_dst_ram_type;
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $dmabw = ( $dmaif + $mask );
//: print qq( output [${dmabw}:0] mcif_wr_req_pd; \n);
//| eperl: generated_beg (DO NOT EDIT BELOW)
 output [65:0] mcif_wr_req_pd; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
output mcif_wr_req_valid;
input mcif_wr_req_ready;
input mcif_wr_rsp_complete;
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $dmabw = ( $dmaif + $mask );
//: print qq( input [${dmabw}:0] dmaif_wr_req_pd; \n);
//| eperl: generated_beg (DO NOT EDIT BELOW)
 input [65:0] dmaif_wr_req_pd; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
input dmaif_wr_req_pvld;
output dmaif_wr_req_prdy;
output dmaif_wr_rsp_complete;
//////////////////////////////////////////////
reg dmaif_wr_rsp_complete;
wire dma_wr_req_type;
wire mc_dma_wr_req_vld;
wire mc_dma_wr_req_rdy;
wire mc_wr_req_rdyi;
wire wr_req_rdyi;
//==============
// DMA Interface
//==============
assign dma_wr_req_type = reg2dp_dst_ram_type;
// wr Channel: Request
assign wr_req_rdyi = mc_wr_req_rdyi;
assign mc_dma_wr_req_vld = dmaif_wr_req_pvld & (dma_wr_req_type == 1'b1);
assign mc_wr_req_rdyi = mc_dma_wr_req_rdy & (dma_wr_req_type == 1'b1);
assign dmaif_wr_req_prdy= wr_req_rdyi;
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $dmabw = ( $dmaif + $mask + 1 );
//: &eperl::pipe(" -wid $dmabw -is -do mcif_wr_req_pd -vo mcif_wr_req_valid -ri mcif_wr_req_ready -di dmaif_wr_req_pd -vi mc_dma_wr_req_vld -ro mc_dma_wr_req_rdy_f  ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg mc_dma_wr_req_rdy_f;
reg skid_flop_mc_dma_wr_req_rdy_f;
reg skid_flop_mc_dma_wr_req_vld;
reg [66-1:0] skid_flop_dmaif_wr_req_pd;
reg pipe_skid_mc_dma_wr_req_vld;
reg [66-1:0] pipe_skid_dmaif_wr_req_pd;
// Wire
wire skid_mc_dma_wr_req_vld;
wire [66-1:0] skid_dmaif_wr_req_pd;
wire skid_mc_dma_wr_req_rdy_f;
wire pipe_skid_mc_dma_wr_req_rdy_f;
wire mcif_wr_req_valid;
wire [66-1:0] mcif_wr_req_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       mc_dma_wr_req_rdy_f <= 1'b1;
       skid_flop_mc_dma_wr_req_rdy_f <= 1'b1;
   end else begin
       mc_dma_wr_req_rdy_f <= skid_mc_dma_wr_req_rdy_f;
       skid_flop_mc_dma_wr_req_rdy_f <= skid_mc_dma_wr_req_rdy_f;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_mc_dma_wr_req_vld <= 1'b0;
    end else begin
        if (skid_flop_mc_dma_wr_req_rdy_f) begin
            skid_flop_mc_dma_wr_req_vld <= mc_dma_wr_req_vld;
        end
   end
end
assign skid_mc_dma_wr_req_vld = (skid_flop_mc_dma_wr_req_rdy_f) ? mc_dma_wr_req_vld : skid_flop_mc_dma_wr_req_vld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_mc_dma_wr_req_rdy_f & mc_dma_wr_req_vld) begin
        skid_flop_dmaif_wr_req_pd[66-1:0] <= dmaif_wr_req_pd[66-1:0];
    end
end
assign skid_dmaif_wr_req_pd[66-1:0] = (skid_flop_mc_dma_wr_req_rdy_f) ? dmaif_wr_req_pd[66-1:0] : skid_flop_dmaif_wr_req_pd[66-1:0];


// PIPE READY
assign skid_mc_dma_wr_req_rdy_f = pipe_skid_mc_dma_wr_req_rdy_f || !pipe_skid_mc_dma_wr_req_vld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_mc_dma_wr_req_vld <= 1'b0;
    end else begin
        if (skid_mc_dma_wr_req_rdy_f) begin
            pipe_skid_mc_dma_wr_req_vld <= skid_mc_dma_wr_req_vld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_mc_dma_wr_req_rdy_f && skid_mc_dma_wr_req_vld) begin
        pipe_skid_dmaif_wr_req_pd[66-1:0] <= skid_dmaif_wr_req_pd[66-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_mc_dma_wr_req_rdy_f = mcif_wr_req_ready;
assign mcif_wr_req_valid = pipe_skid_mc_dma_wr_req_vld;
assign mcif_wr_req_pd = pipe_skid_dmaif_wr_req_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign mc_dma_wr_req_rdy = mc_dma_wr_req_rdy_f;
// wr Channel: Response
wire ack_top_rdy;
wire releasing;
reg ack_top_vld ;
reg ack_top_id ;
wire ack_bot_rdy;
reg ack_bot_vld ;
reg ack_bot_id ;
wire ack_raw_rdy;
wire ack_raw_id;
wire ack_raw_vld;
wire require_ack;
wire mc_int_wr_rsp_complete;
assign mc_int_wr_rsp_complete = mcif_wr_rsp_complete;
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $dmabw = ( $dmaif + $mask + 1 );
//: if($dmaif > 64) {
//: print qq( assign require_ack = (dmaif_wr_req_pd[${dmabw}-1]==0) & (dmaif_wr_req_pd[77]==1); \n);
//: } else {
//: print qq( assign require_ack = (dmaif_wr_req_pd[${dmabw}-1]==0) & (dmaif_wr_req_pd[45]==1); \n);
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
 assign require_ack = (dmaif_wr_req_pd[66-1]==0) & (dmaif_wr_req_pd[45]==1); 

//| eperl: generated_end (DO NOT EDIT ABOVE)
// assign require_ack = (dmaif_wr_req_pd[${dmabw}-1]==0) & (dmaif_wr_req_pd[77:77]==1);
assign ack_raw_vld = dmaif_wr_req_pvld & wr_req_rdyi & require_ack;
assign ack_raw_id = dma_wr_req_type;
// stage1: bot
assign ack_raw_rdy = ack_bot_rdy || !ack_bot_vld;
always @(posedge nvdla_core_clk) begin
  if (ack_raw_vld & ack_raw_rdy)
    ack_bot_id <= ack_raw_id;
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    ack_bot_vld <= 1'b0;
  end else if (ack_raw_rdy) begin
    ack_bot_vld <= ack_raw_vld;
  end
end
////: &eperl::assert(" -type never -desc `dmaif bot never push back` -expr `ack_raw_vld & !ack_raw_rdy`  "); 
// stage2: top
assign ack_bot_rdy = ack_top_rdy || !ack_top_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    ack_top_id <= 1'b0;
  end else if (ack_bot_vld & ack_bot_rdy) begin
    ack_top_id <= ack_bot_id;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    ack_top_vld <= 1'b0;
  end else if (ack_bot_rdy) begin
    ack_top_vld <= ack_bot_vld;
  end
end
assign ack_top_rdy = releasing;
reg mc_dma_wr_rsp_complete;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    mc_dma_wr_rsp_complete <= 1'b0;
  end else begin
    mc_dma_wr_rsp_complete <= mc_int_wr_rsp_complete;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dmaif_wr_rsp_complete <= 1'b0;
  end else begin
    dmaif_wr_rsp_complete <= releasing;
  end
end
reg mc_pending;
wire mc_releasing;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    mc_pending <= 1'b0;
  end else begin
        if (ack_top_id==0) begin
            if (mc_dma_wr_rsp_complete) begin
                mc_pending <= 1'b1;
            end
        end else if (ack_top_id==1) begin
            if (mc_pending) begin
                mc_pending <= 1'b0;
            end
        end
  end
end
assign mc_releasing = ack_top_id==1'b1 & (mc_dma_wr_rsp_complete | mc_pending);
assign releasing = mc_releasing;
////: &eperl::assert("  -type never -desc 'no mc resp back and pending together' -expr 'mc_pending & mc_dma_wr_rsp_complete'  );
////: &eperl::assert("  -type never -desc 'no ack_top_vld when resp from mc'     -expr '(mc_pending | mc_dma_wr_rsp_complete) & !ack_top_vld'  );
//////////////////////////
endmodule
