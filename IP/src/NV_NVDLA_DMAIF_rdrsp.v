// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_DMAIF_rdrsp.v
`include "simulate_x_tick.vh"
module NV_NVDLA_DMAIF_rdrsp (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,mcif_rd_rsp_pd
  ,mcif_rd_rsp_valid
  ,mcif_rd_rsp_ready
  ,dmaif_rd_rsp_pd
  ,dmaif_rd_rsp_pvld
  ,dmaif_rd_rsp_prdy
);
//////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $maskbw;
//: $maskbw = $mask;
//: my $dmabw = ( $dmaif + $maskbw );
//: print qq( input [${dmabw}-1:0] mcif_rd_rsp_pd; \n);
//: print qq( output [${dmabw}-1:0] dmaif_rd_rsp_pd; \n);
//| eperl: generated_beg (DO NOT EDIT BELOW)
 input [65-1:0] mcif_rd_rsp_pd; 
 output [65-1:0] dmaif_rd_rsp_pd; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
input mcif_rd_rsp_valid;
output mcif_rd_rsp_ready;
output dmaif_rd_rsp_pvld;
input dmaif_rd_rsp_prdy;
//////////////////////////////////////////////
wire dma_rd_rsp_rdy;
wire dma_rd_rsp_vld;
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $maskbw;
//: $maskbw = $mask;
//: my $dmabw = ( $dmaif + $maskbw );
//: print qq( wire [${dmabw}-1:0] dma_rd_rsp_pd; \n);
//| eperl: generated_beg (DO NOT EDIT BELOW)
 wire [65-1:0] dma_rd_rsp_pd; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////
///////////////////////////////////////
// pipe before mux
///////////////////////////////////////
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $maskbw;
//: $maskbw = $mask;
//: my $dmabw = ( $dmaif + $maskbw );
//: &eperl::pipe(" -wid $dmabw -is -do mcif_rd_rsp_pd_d0 -vo mcif_rd_rsp_valid_d0 -ri dma_rd_rsp_rdy -di mcif_rd_rsp_pd -vi mcif_rd_rsp_valid -ro mcif_rd_rsp_ready  ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg mcif_rd_rsp_ready;
reg skid_flop_mcif_rd_rsp_ready;
reg skid_flop_mcif_rd_rsp_valid;
reg [65-1:0] skid_flop_mcif_rd_rsp_pd;
reg pipe_skid_mcif_rd_rsp_valid;
reg [65-1:0] pipe_skid_mcif_rd_rsp_pd;
// Wire
wire skid_mcif_rd_rsp_valid;
wire [65-1:0] skid_mcif_rd_rsp_pd;
wire skid_mcif_rd_rsp_ready;
wire pipe_skid_mcif_rd_rsp_ready;
wire mcif_rd_rsp_valid_d0;
wire [65-1:0] mcif_rd_rsp_pd_d0;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       mcif_rd_rsp_ready <= 1'b1;
       skid_flop_mcif_rd_rsp_ready <= 1'b1;
   end else begin
       mcif_rd_rsp_ready <= skid_mcif_rd_rsp_ready;
       skid_flop_mcif_rd_rsp_ready <= skid_mcif_rd_rsp_ready;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_mcif_rd_rsp_valid <= 1'b0;
    end else begin
        if (skid_flop_mcif_rd_rsp_ready) begin
            skid_flop_mcif_rd_rsp_valid <= mcif_rd_rsp_valid;
        end
   end
end
assign skid_mcif_rd_rsp_valid = (skid_flop_mcif_rd_rsp_ready) ? mcif_rd_rsp_valid : skid_flop_mcif_rd_rsp_valid;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_mcif_rd_rsp_ready & mcif_rd_rsp_valid) begin
        skid_flop_mcif_rd_rsp_pd[65-1:0] <= mcif_rd_rsp_pd[65-1:0];
    end
end
assign skid_mcif_rd_rsp_pd[65-1:0] = (skid_flop_mcif_rd_rsp_ready) ? mcif_rd_rsp_pd[65-1:0] : skid_flop_mcif_rd_rsp_pd[65-1:0];


// PIPE READY
assign skid_mcif_rd_rsp_ready = pipe_skid_mcif_rd_rsp_ready || !pipe_skid_mcif_rd_rsp_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_mcif_rd_rsp_valid <= 1'b0;
    end else begin
        if (skid_mcif_rd_rsp_ready) begin
            pipe_skid_mcif_rd_rsp_valid <= skid_mcif_rd_rsp_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_mcif_rd_rsp_ready && skid_mcif_rd_rsp_valid) begin
        pipe_skid_mcif_rd_rsp_pd[65-1:0] <= skid_mcif_rd_rsp_pd[65-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_mcif_rd_rsp_ready = dma_rd_rsp_rdy;
assign mcif_rd_rsp_valid_d0 = pipe_skid_mcif_rd_rsp_valid;
assign mcif_rd_rsp_pd_d0 = pipe_skid_mcif_rd_rsp_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////////////////////////////////
//mux
///////////////////////////////////////
assign dma_rd_rsp_vld = mcif_rd_rsp_valid_d0;
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $maskbw;
//: $maskbw = $mask;
//: my $dmabw = ( $dmaif + $maskbw );
//: print qq(
//: assign dma_rd_rsp_pd = ({${dmabw}{mcif_rd_rsp_valid_d0}} & mcif_rd_rsp_pd_d0);
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dma_rd_rsp_pd = ({65{mcif_rd_rsp_valid_d0}} & mcif_rd_rsp_pd_d0);

//| eperl: generated_end (DO NOT EDIT ABOVE)
// //: &eperl::assert(" -type never -desc 'DMAIF: mcif and cvif should never return data both' -expr 'mcif_rd_rsp_valid_d0 & cvif_rd_rsp_valid_d0' ");
///////////////////////////////////////
// pipe after mux
///////////////////////////////////////
//: my $dmaif = 64;
//: my $mask = int($dmaif/8/8);
//: my $maskbw;
//: $maskbw = $mask;
//: my $dmabw = ( $dmaif + $maskbw );
//: &eperl::pipe(" -wid $dmabw -is -do dmaif_rd_rsp_pd -vo dmaif_rd_rsp_pvld -ri dmaif_rd_rsp_prdy -di dma_rd_rsp_pd -vi dma_rd_rsp_vld -ro dma_rd_rsp_rdy_f  ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg dma_rd_rsp_rdy_f;
reg skid_flop_dma_rd_rsp_rdy_f;
reg skid_flop_dma_rd_rsp_vld;
reg [65-1:0] skid_flop_dma_rd_rsp_pd;
reg pipe_skid_dma_rd_rsp_vld;
reg [65-1:0] pipe_skid_dma_rd_rsp_pd;
// Wire
wire skid_dma_rd_rsp_vld;
wire [65-1:0] skid_dma_rd_rsp_pd;
wire skid_dma_rd_rsp_rdy_f;
wire pipe_skid_dma_rd_rsp_rdy_f;
wire dmaif_rd_rsp_pvld;
wire [65-1:0] dmaif_rd_rsp_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dma_rd_rsp_rdy_f <= 1'b1;
       skid_flop_dma_rd_rsp_rdy_f <= 1'b1;
   end else begin
       dma_rd_rsp_rdy_f <= skid_dma_rd_rsp_rdy_f;
       skid_flop_dma_rd_rsp_rdy_f <= skid_dma_rd_rsp_rdy_f;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_dma_rd_rsp_vld <= 1'b0;
    end else begin
        if (skid_flop_dma_rd_rsp_rdy_f) begin
            skid_flop_dma_rd_rsp_vld <= dma_rd_rsp_vld;
        end
   end
end
assign skid_dma_rd_rsp_vld = (skid_flop_dma_rd_rsp_rdy_f) ? dma_rd_rsp_vld : skid_flop_dma_rd_rsp_vld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_dma_rd_rsp_rdy_f & dma_rd_rsp_vld) begin
        skid_flop_dma_rd_rsp_pd[65-1:0] <= dma_rd_rsp_pd[65-1:0];
    end
end
assign skid_dma_rd_rsp_pd[65-1:0] = (skid_flop_dma_rd_rsp_rdy_f) ? dma_rd_rsp_pd[65-1:0] : skid_flop_dma_rd_rsp_pd[65-1:0];


// PIPE READY
assign skid_dma_rd_rsp_rdy_f = pipe_skid_dma_rd_rsp_rdy_f || !pipe_skid_dma_rd_rsp_vld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_dma_rd_rsp_vld <= 1'b0;
    end else begin
        if (skid_dma_rd_rsp_rdy_f) begin
            pipe_skid_dma_rd_rsp_vld <= skid_dma_rd_rsp_vld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_dma_rd_rsp_rdy_f && skid_dma_rd_rsp_vld) begin
        pipe_skid_dma_rd_rsp_pd[65-1:0] <= skid_dma_rd_rsp_pd[65-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_dma_rd_rsp_rdy_f = dmaif_rd_rsp_prdy;
assign dmaif_rd_rsp_pvld = pipe_skid_dma_rd_rsp_vld;
assign dmaif_rd_rsp_pd = pipe_skid_dma_rd_rsp_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dma_rd_rsp_rdy = dma_rd_rsp_rdy_f;
endmodule
