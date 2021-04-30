// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_WRITE_eg.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
`include "NV_NVDLA_MCIF_define.vh"
`include "simulate_x_tick.vh"
module NV_NVDLA_MCIF_WRITE_eg (
   nvdla_core_clk
  ,nvdla_core_rstn
//:for(my $i=0;$i<5;$i++) {
//:print"  ,cq_rd${i}_pvld \n";
//:print"  ,cq_rd${i}_pd   \n";
//:print"  ,cq_rd${i}_prdy \n";
//:}
//:my @wdma_name = ("sdp", "pdp","cdp");
//:foreach my $client (@wdma_name) {
//:print"  ,mcif2${client}_wr_rsp_complete\n";
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,cq_rd0_pvld 
  ,cq_rd0_pd   
  ,cq_rd0_prdy 
  ,cq_rd1_pvld 
  ,cq_rd1_pd   
  ,cq_rd1_prdy 
  ,cq_rd2_pvld 
  ,cq_rd2_pd   
  ,cq_rd2_prdy 
  ,cq_rd3_pvld 
  ,cq_rd3_pd   
  ,cq_rd3_prdy 
  ,cq_rd4_pvld 
  ,cq_rd4_pd   
  ,cq_rd4_prdy 
  ,mcif2sdp_wr_rsp_complete
  ,mcif2pdp_wr_rsp_complete
  ,mcif2cdp_wr_rsp_complete

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,eg2ig_axi_len
  ,eg2ig_axi_vld
  ,noc2mcif_axi_b_bid
  ,noc2mcif_axi_b_bvalid
  ,noc2mcif_axi_b_bready
);
input nvdla_core_clk;
input nvdla_core_rstn;
//:for(my $i=0;$i<5;$i++) {
//:print qq(
//:input cq_rd${i}_pvld;
//:output cq_rd${i}_prdy;
//:input [2:0] cq_rd${i}_pd;
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

input cq_rd0_pvld;
output cq_rd0_prdy;
input [2:0] cq_rd0_pd;

input cq_rd1_pvld;
output cq_rd1_prdy;
input [2:0] cq_rd1_pd;

input cq_rd2_pvld;
output cq_rd2_prdy;
input [2:0] cq_rd2_pd;

input cq_rd3_pvld;
output cq_rd3_prdy;
input [2:0] cq_rd3_pd;

input cq_rd4_pvld;
output cq_rd4_prdy;
input [2:0] cq_rd4_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output [1:0] eg2ig_axi_len;
output eg2ig_axi_vld;
input noc2mcif_axi_b_bvalid;
output noc2mcif_axi_b_bready;
input [7:0] noc2mcif_axi_b_bid;
//:my @wdma_name = ("sdp", "pdp","cdp");
//:foreach my $client (@wdma_name) {
//:print"output reg  mcif2${client}_wr_rsp_complete;\n";
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
output reg  mcif2sdp_wr_rsp_complete;
output reg  mcif2pdp_wr_rsp_complete;
output reg  mcif2cdp_wr_rsp_complete;

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [1:0] eg2ig_axi_len;
wire [2:0] iflop_axi_axid;
wire iflop_axi_vld;
wire iflop_axi_rdy;
NV_NVDLA_MCIF_WRITE_EG_pipe u_pipe(
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.iflop_axi_axid (iflop_axi_axid)
  ,.iflop_axi_vld (iflop_axi_vld)
  ,.iflop_axi_rdy (iflop_axi_rdy)
  ,.noc2mcif_axi_b_bid (noc2mcif_axi_b_bid[2:0])
  ,.noc2mcif_axi_b_bvalid (noc2mcif_axi_b_bvalid)
  ,.noc2mcif_axi_b_bready (noc2mcif_axi_b_bready)
  );
//:for(my $i=0;$i<5;$i++) {
//:print qq(
//:wire iflop_axi_rdy${i} = cq_rd${i}_pvld & (iflop_axi_axid == $i);
//:wire iflop_axi_vld${i} = iflop_axi_vld & (iflop_axi_axid == $i);
//:wire [1:0] cq_rd${i}_len = cq_rd${i}_pd[2:1];
//:assign cq_rd${i}_prdy = iflop_axi_vld${i};
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire iflop_axi_rdy0 = cq_rd0_pvld & (iflop_axi_axid == 0);
wire iflop_axi_vld0 = iflop_axi_vld & (iflop_axi_axid == 0);
wire [1:0] cq_rd0_len = cq_rd0_pd[2:1];
assign cq_rd0_prdy = iflop_axi_vld0;

wire iflop_axi_rdy1 = cq_rd1_pvld & (iflop_axi_axid == 1);
wire iflop_axi_vld1 = iflop_axi_vld & (iflop_axi_axid == 1);
wire [1:0] cq_rd1_len = cq_rd1_pd[2:1];
assign cq_rd1_prdy = iflop_axi_vld1;

wire iflop_axi_rdy2 = cq_rd2_pvld & (iflop_axi_axid == 2);
wire iflop_axi_vld2 = iflop_axi_vld & (iflop_axi_axid == 2);
wire [1:0] cq_rd2_len = cq_rd2_pd[2:1];
assign cq_rd2_prdy = iflop_axi_vld2;

wire iflop_axi_rdy3 = cq_rd3_pvld & (iflop_axi_axid == 3);
wire iflop_axi_vld3 = iflop_axi_vld & (iflop_axi_axid == 3);
wire [1:0] cq_rd3_len = cq_rd3_pd[2:1];
assign cq_rd3_prdy = iflop_axi_vld3;

wire iflop_axi_rdy4 = cq_rd4_pvld & (iflop_axi_axid == 4);
wire iflop_axi_vld4 = iflop_axi_vld & (iflop_axi_axid == 4);
wire [1:0] cq_rd4_len = cq_rd4_pd[2:1];
assign cq_rd4_prdy = iflop_axi_vld4;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign iflop_axi_rdy = iflop_axi_rdy0
//:for(my $i=1;$i<5;$i++) {
//:print " | iflop_axi_rdy${i} ";
//:}
//:print";\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 | iflop_axi_rdy1  | iflop_axi_rdy2  | iflop_axi_rdy3  | iflop_axi_rdy4 ;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign eg2ig_axi_vld = iflop_axi_vld & iflop_axi_rdy;
always @(
iflop_axi_vld0 or
cq_rd0_len
//:for(my $i=1;$i<5;$i++) {
//:print qq(
//:or iflop_axi_vld${i}
//:or cq_rd${i}_len);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

or iflop_axi_vld1
or cq_rd1_len
or iflop_axi_vld2
or cq_rd2_len
or iflop_axi_vld3
or cq_rd3_len
or iflop_axi_vld4
or cq_rd4_len
//| eperl: generated_end (DO NOT EDIT ABOVE)
) begin
//spyglass disable_block W171 W226
   case (1'b1)
//:for(my $i=0;$i<5;$i++) {
//:print" iflop_axi_vld${i}: eg2ig_axi_len = cq_rd${i}_len;\n";
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
 iflop_axi_vld0: eg2ig_axi_len = cq_rd0_len;
 iflop_axi_vld1: eg2ig_axi_len = cq_rd1_len;
 iflop_axi_vld2: eg2ig_axi_len = cq_rd2_len;
 iflop_axi_vld3: eg2ig_axi_len = cq_rd3_len;
 iflop_axi_vld4: eg2ig_axi_len = cq_rd4_len;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//VCS coverage off
    default : begin
                eg2ig_axi_len[1:0] = {2{`x_or_0}};
              end
//VCS coverage on
    endcase
//spyglass enable_block W171 W226
end
//:my $i;
//:my @wdma_name = ("sdp", "pdp","cdp");
//:foreach my $client (@wdma_name) {
//:print "wire  ${client}_cq_rd_pvld = (`tieoff_axid_${client} == 0 ) ? cq_rd0_pvld ";
//:for($i=1;$i<5;$i++) {
//:if($i==5 -1){
//:print ": cq_rd${i}_pvld;\n";
//:}
//:else {
//:print ": (`tieoff_axid_${client} == ${i}) ? cq_rd${i}_pvld ";
//:}
//:}
//:print "wire  ${client}_cq_rd_ack = (`tieoff_axid_${client} == 0 ) ? cq_rd0_pd[0] ";
//:for($i=1;$i<5;$i++) {
//:if($i==5 -1){
//:print ": cq_rd${i}_pd[0];\n";
//:}
//:else {
//:print ": (`tieoff_axid_${client} == ${i}) ? cq_rd${i}_pd[0] ";
//:}
//:}
//:print qq(
//:wire ${client}_axi_vld = iflop_axi_vld & (iflop_axi_axid == `tieoff_axid_${client});
//:always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn) begin
//: mcif2${client}_wr_rsp_complete <= 1'b0;
//: end else begin
//: mcif2${client}_wr_rsp_complete <= ${client}_axi_vld & ${client}_cq_rd_ack & ${client}_cq_rd_pvld; //dma${i}_vld & cq_rd${i}_pvld & cq_rd${i}_require_ack;
//: end
//:end
//:);
//:print"\n";
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire  sdp_cq_rd_pvld = (`tieoff_axid_sdp == 0 ) ? cq_rd0_pvld : (`tieoff_axid_sdp == 1) ? cq_rd1_pvld : (`tieoff_axid_sdp == 2) ? cq_rd2_pvld : (`tieoff_axid_sdp == 3) ? cq_rd3_pvld : cq_rd4_pvld;
wire  sdp_cq_rd_ack = (`tieoff_axid_sdp == 0 ) ? cq_rd0_pd[0] : (`tieoff_axid_sdp == 1) ? cq_rd1_pd[0] : (`tieoff_axid_sdp == 2) ? cq_rd2_pd[0] : (`tieoff_axid_sdp == 3) ? cq_rd3_pd[0] : cq_rd4_pd[0];

wire sdp_axi_vld = iflop_axi_vld & (iflop_axi_axid == `tieoff_axid_sdp);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
mcif2sdp_wr_rsp_complete <= 1'b0;
end else begin
mcif2sdp_wr_rsp_complete <= sdp_axi_vld & sdp_cq_rd_ack & sdp_cq_rd_pvld; //dma5_vld & cq_rd5_pvld & cq_rd5_require_ack;
end
end

wire  pdp_cq_rd_pvld = (`tieoff_axid_pdp == 0 ) ? cq_rd0_pvld : (`tieoff_axid_pdp == 1) ? cq_rd1_pvld : (`tieoff_axid_pdp == 2) ? cq_rd2_pvld : (`tieoff_axid_pdp == 3) ? cq_rd3_pvld : cq_rd4_pvld;
wire  pdp_cq_rd_ack = (`tieoff_axid_pdp == 0 ) ? cq_rd0_pd[0] : (`tieoff_axid_pdp == 1) ? cq_rd1_pd[0] : (`tieoff_axid_pdp == 2) ? cq_rd2_pd[0] : (`tieoff_axid_pdp == 3) ? cq_rd3_pd[0] : cq_rd4_pd[0];

wire pdp_axi_vld = iflop_axi_vld & (iflop_axi_axid == `tieoff_axid_pdp);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
mcif2pdp_wr_rsp_complete <= 1'b0;
end else begin
mcif2pdp_wr_rsp_complete <= pdp_axi_vld & pdp_cq_rd_ack & pdp_cq_rd_pvld; //dma5_vld & cq_rd5_pvld & cq_rd5_require_ack;
end
end

wire  cdp_cq_rd_pvld = (`tieoff_axid_cdp == 0 ) ? cq_rd0_pvld : (`tieoff_axid_cdp == 1) ? cq_rd1_pvld : (`tieoff_axid_cdp == 2) ? cq_rd2_pvld : (`tieoff_axid_cdp == 3) ? cq_rd3_pvld : cq_rd4_pvld;
wire  cdp_cq_rd_ack = (`tieoff_axid_cdp == 0 ) ? cq_rd0_pd[0] : (`tieoff_axid_cdp == 1) ? cq_rd1_pd[0] : (`tieoff_axid_cdp == 2) ? cq_rd2_pd[0] : (`tieoff_axid_cdp == 3) ? cq_rd3_pd[0] : cq_rd4_pd[0];

wire cdp_axi_vld = iflop_axi_vld & (iflop_axi_axid == `tieoff_axid_cdp);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
mcif2cdp_wr_rsp_complete <= 1'b0;
end else begin
mcif2cdp_wr_rsp_complete <= cdp_axi_vld & cdp_cq_rd_ack & cdp_cq_rd_pvld; //dma5_vld & cq_rd5_pvld & cq_rd5_require_ack;
end
end


//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_CVIF_WRITE_eg
module NV_NVDLA_MCIF_WRITE_EG_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,iflop_axi_axid
  ,iflop_axi_vld
  ,iflop_axi_rdy
  ,noc2mcif_axi_b_bid
  ,noc2mcif_axi_b_bvalid
  ,noc2mcif_axi_b_bready
  );
input nvdla_core_clk;
input nvdla_core_rstn;
output [2:0] iflop_axi_axid;
output iflop_axi_vld;
input iflop_axi_rdy;
input [2:0] noc2mcif_axi_b_bid;
input noc2mcif_axi_b_bvalid;
output noc2mcif_axi_b_bready;
//: &eperl::pipe(" -wid 3 -is -di noc2mcif_axi_b_bid -vi noc2mcif_axi_b_bvalid -ro noc2mcif_axi_b_bready -do iflop_axi_axid -vo iflop_axi_vld -ri iflop_axi_rdy ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg noc2mcif_axi_b_bready;
reg skid_flop_noc2mcif_axi_b_bready;
reg skid_flop_noc2mcif_axi_b_bvalid;
reg [3-1:0] skid_flop_noc2mcif_axi_b_bid;
reg pipe_skid_noc2mcif_axi_b_bvalid;
reg [3-1:0] pipe_skid_noc2mcif_axi_b_bid;
// Wire
wire skid_noc2mcif_axi_b_bvalid;
wire [3-1:0] skid_noc2mcif_axi_b_bid;
wire skid_noc2mcif_axi_b_bready;
wire pipe_skid_noc2mcif_axi_b_bready;
wire iflop_axi_vld;
wire [3-1:0] iflop_axi_axid;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       noc2mcif_axi_b_bready <= 1'b1;
       skid_flop_noc2mcif_axi_b_bready <= 1'b1;
   end else begin
       noc2mcif_axi_b_bready <= skid_noc2mcif_axi_b_bready;
       skid_flop_noc2mcif_axi_b_bready <= skid_noc2mcif_axi_b_bready;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_noc2mcif_axi_b_bvalid <= 1'b0;
    end else begin
        if (skid_flop_noc2mcif_axi_b_bready) begin
            skid_flop_noc2mcif_axi_b_bvalid <= noc2mcif_axi_b_bvalid;
        end
   end
end
assign skid_noc2mcif_axi_b_bvalid = (skid_flop_noc2mcif_axi_b_bready) ? noc2mcif_axi_b_bvalid : skid_flop_noc2mcif_axi_b_bvalid;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_noc2mcif_axi_b_bready & noc2mcif_axi_b_bvalid) begin
        skid_flop_noc2mcif_axi_b_bid[3-1:0] <= noc2mcif_axi_b_bid[3-1:0];
    end
end
assign skid_noc2mcif_axi_b_bid[3-1:0] = (skid_flop_noc2mcif_axi_b_bready) ? noc2mcif_axi_b_bid[3-1:0] : skid_flop_noc2mcif_axi_b_bid[3-1:0];


// PIPE READY
assign skid_noc2mcif_axi_b_bready = pipe_skid_noc2mcif_axi_b_bready || !pipe_skid_noc2mcif_axi_b_bvalid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_noc2mcif_axi_b_bvalid <= 1'b0;
    end else begin
        if (skid_noc2mcif_axi_b_bready) begin
            pipe_skid_noc2mcif_axi_b_bvalid <= skid_noc2mcif_axi_b_bvalid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_noc2mcif_axi_b_bready && skid_noc2mcif_axi_b_bvalid) begin
        pipe_skid_noc2mcif_axi_b_bid[3-1:0] <= skid_noc2mcif_axi_b_bid[3-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_noc2mcif_axi_b_bready = iflop_axi_rdy;
assign iflop_axi_vld = pipe_skid_noc2mcif_axi_b_bvalid;
assign iflop_axi_axid = pipe_skid_noc2mcif_axi_b_bid;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
