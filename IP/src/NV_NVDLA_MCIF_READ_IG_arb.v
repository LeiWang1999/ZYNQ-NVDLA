// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_READ_IG_arb.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
`include "simulate_x_tick.vh"
module NV_NVDLA_MCIF_READ_IG_arb (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
//: for (my $i=0;$i<7;$i++) {
//: print("  ,reg2dp_rd_weight${i}\n");
//: }
//: for (my $i=0;$i<7;$i++) {
//: print("  ,bpt2arb_req${i}_valid\n");
//: print("  ,bpt2arb_req${i}_ready\n");
//: print("  ,bpt2arb_req${i}_pd\n");
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,reg2dp_rd_weight0
  ,reg2dp_rd_weight1
  ,reg2dp_rd_weight2
  ,reg2dp_rd_weight3
  ,reg2dp_rd_weight4
  ,reg2dp_rd_weight5
  ,reg2dp_rd_weight6
  ,bpt2arb_req0_valid
  ,bpt2arb_req0_ready
  ,bpt2arb_req0_pd
  ,bpt2arb_req1_valid
  ,bpt2arb_req1_ready
  ,bpt2arb_req1_pd
  ,bpt2arb_req2_valid
  ,bpt2arb_req2_ready
  ,bpt2arb_req2_pd
  ,bpt2arb_req3_valid
  ,bpt2arb_req3_ready
  ,bpt2arb_req3_pd
  ,bpt2arb_req4_valid
  ,bpt2arb_req4_ready
  ,bpt2arb_req4_pd
  ,bpt2arb_req5_valid
  ,bpt2arb_req5_ready
  ,bpt2arb_req5_pd
  ,bpt2arb_req6_valid
  ,bpt2arb_req6_ready
  ,bpt2arb_req6_pd

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,arb2spt_req_pd //|> o
  ,arb2spt_req_valid //|> o
  ,arb2spt_req_ready //|< i
  );
input nvdla_core_clk;
input nvdla_core_rstn;
//: for (my $i=0;$i<7;$i++) {
//: print "input   [7:0] reg2dp_rd_weight${i};\n";
//: }
//: for (my $i=0;$i<7;$i++) {
//: print qq(
//: input bpt2arb_req${i}_valid;
//: output bpt2arb_req${i}_ready;
//: input [32 +11 -1:0] bpt2arb_req${i}_pd;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
input   [7:0] reg2dp_rd_weight0;
input   [7:0] reg2dp_rd_weight1;
input   [7:0] reg2dp_rd_weight2;
input   [7:0] reg2dp_rd_weight3;
input   [7:0] reg2dp_rd_weight4;
input   [7:0] reg2dp_rd_weight5;
input   [7:0] reg2dp_rd_weight6;

input bpt2arb_req0_valid;
output bpt2arb_req0_ready;
input [32 +11 -1:0] bpt2arb_req0_pd;

input bpt2arb_req1_valid;
output bpt2arb_req1_ready;
input [32 +11 -1:0] bpt2arb_req1_pd;

input bpt2arb_req2_valid;
output bpt2arb_req2_ready;
input [32 +11 -1:0] bpt2arb_req2_pd;

input bpt2arb_req3_valid;
output bpt2arb_req3_ready;
input [32 +11 -1:0] bpt2arb_req3_pd;

input bpt2arb_req4_valid;
output bpt2arb_req4_ready;
input [32 +11 -1:0] bpt2arb_req4_pd;

input bpt2arb_req5_valid;
output bpt2arb_req5_ready;
input [32 +11 -1:0] bpt2arb_req5_pd;

input bpt2arb_req6_valid;
output bpt2arb_req6_ready;
input [32 +11 -1:0] bpt2arb_req6_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output arb2spt_req_valid;
input arb2spt_req_ready;
output [32 +11 -1:0] arb2spt_req_pd;
//: for (my $i=0;$i<7;$i++) {
//: print qq(
//: wire [32 +11 -1:0] arb_src${i}_pd;
//: wire arb_src${i}_rdy;
//: wire arb_src${i}_vld;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [32 +11 -1:0] arb_src0_pd;
wire arb_src0_rdy;
wire arb_src0_vld;

wire [32 +11 -1:0] arb_src1_pd;
wire arb_src1_rdy;
wire arb_src1_vld;

wire [32 +11 -1:0] arb_src2_pd;
wire arb_src2_rdy;
wire arb_src2_vld;

wire [32 +11 -1:0] arb_src3_pd;
wire arb_src3_rdy;
wire arb_src3_vld;

wire [32 +11 -1:0] arb_src4_pd;
wire arb_src4_rdy;
wire arb_src4_vld;

wire [32 +11 -1:0] arb_src5_pd;
wire arb_src5_rdy;
wire arb_src5_vld;

wire [32 +11 -1:0] arb_src6_pd;
wire arb_src6_rdy;
wire arb_src6_vld;

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [32 +11 -1:0] arb_pd;
wire [32 +11 -1:0] arb_out_pd;
wire arb_out_vld;
wire arb_out_rdy;
wire [9:0] arb_gnt;
wire gnt_busy;
wire src0_gnt;
wire src0_req;
wire src1_gnt;
wire src1_req;
wire src2_gnt;
wire src2_req;
wire src3_gnt;
wire src3_req;
wire src4_gnt;
wire src4_req;
wire src5_gnt;
wire src5_req;
wire src6_gnt;
wire src6_req;
wire src7_gnt;
wire src7_req;
wire src8_gnt;
wire src8_req;
wire src9_gnt;
wire src9_req;
wire [7:0] wt0;
wire [7:0] wt1;
wire [7:0] wt2;
wire [7:0] wt3;
wire [7:0] wt4;
wire [7:0] wt5;
wire [7:0] wt6;
wire [7:0] wt7;
wire [7:0] wt8;
wire [7:0] wt9;
//: for (my $i=0;$i<7;$i++) {
//: print qq(
//: NV_NVDLA_MCIF_READ_IG_ARB_pipe pipe_p${i} (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.bpt2arb_req_pd (bpt2arb_req${i}_pd)
//: ,.bpt2arb_req_valid (bpt2arb_req${i}_valid)
//: ,.bpt2arb_req_ready (bpt2arb_req${i}_ready)
//: ,.arb_src_pd (arb_src${i}_pd)
//: ,.arb_src_vld (arb_src${i}_vld)
//: ,.arb_src_rdy (arb_src${i}_rdy)
//: );
//: assign src${i}_req = arb_src${i}_vld;
//: assign arb_src${i}_rdy = src${i}_gnt;
//: );
//: }
//: print "\n";
//: for (my $i=7;$i<10;$i++) {
//: print "assign src${i}_req = 1'b0;\n";
//: }
//: for (my $i=0;$i<7;$i++) {
//: print "assign wt${i} = reg2dp_rd_weight${i};\n";
//: }
//: for (my $i=7;$i<10;$i++) {
//: print "assign wt${i} = 8'h0;\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

NV_NVDLA_MCIF_READ_IG_ARB_pipe pipe_p0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_req_pd (bpt2arb_req0_pd)
,.bpt2arb_req_valid (bpt2arb_req0_valid)
,.bpt2arb_req_ready (bpt2arb_req0_ready)
,.arb_src_pd (arb_src0_pd)
,.arb_src_vld (arb_src0_vld)
,.arb_src_rdy (arb_src0_rdy)
);
assign src0_req = arb_src0_vld;
assign arb_src0_rdy = src0_gnt;

NV_NVDLA_MCIF_READ_IG_ARB_pipe pipe_p1 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_req_pd (bpt2arb_req1_pd)
,.bpt2arb_req_valid (bpt2arb_req1_valid)
,.bpt2arb_req_ready (bpt2arb_req1_ready)
,.arb_src_pd (arb_src1_pd)
,.arb_src_vld (arb_src1_vld)
,.arb_src_rdy (arb_src1_rdy)
);
assign src1_req = arb_src1_vld;
assign arb_src1_rdy = src1_gnt;

NV_NVDLA_MCIF_READ_IG_ARB_pipe pipe_p2 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_req_pd (bpt2arb_req2_pd)
,.bpt2arb_req_valid (bpt2arb_req2_valid)
,.bpt2arb_req_ready (bpt2arb_req2_ready)
,.arb_src_pd (arb_src2_pd)
,.arb_src_vld (arb_src2_vld)
,.arb_src_rdy (arb_src2_rdy)
);
assign src2_req = arb_src2_vld;
assign arb_src2_rdy = src2_gnt;

NV_NVDLA_MCIF_READ_IG_ARB_pipe pipe_p3 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_req_pd (bpt2arb_req3_pd)
,.bpt2arb_req_valid (bpt2arb_req3_valid)
,.bpt2arb_req_ready (bpt2arb_req3_ready)
,.arb_src_pd (arb_src3_pd)
,.arb_src_vld (arb_src3_vld)
,.arb_src_rdy (arb_src3_rdy)
);
assign src3_req = arb_src3_vld;
assign arb_src3_rdy = src3_gnt;

NV_NVDLA_MCIF_READ_IG_ARB_pipe pipe_p4 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_req_pd (bpt2arb_req4_pd)
,.bpt2arb_req_valid (bpt2arb_req4_valid)
,.bpt2arb_req_ready (bpt2arb_req4_ready)
,.arb_src_pd (arb_src4_pd)
,.arb_src_vld (arb_src4_vld)
,.arb_src_rdy (arb_src4_rdy)
);
assign src4_req = arb_src4_vld;
assign arb_src4_rdy = src4_gnt;

NV_NVDLA_MCIF_READ_IG_ARB_pipe pipe_p5 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_req_pd (bpt2arb_req5_pd)
,.bpt2arb_req_valid (bpt2arb_req5_valid)
,.bpt2arb_req_ready (bpt2arb_req5_ready)
,.arb_src_pd (arb_src5_pd)
,.arb_src_vld (arb_src5_vld)
,.arb_src_rdy (arb_src5_rdy)
);
assign src5_req = arb_src5_vld;
assign arb_src5_rdy = src5_gnt;

NV_NVDLA_MCIF_READ_IG_ARB_pipe pipe_p6 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_req_pd (bpt2arb_req6_pd)
,.bpt2arb_req_valid (bpt2arb_req6_valid)
,.bpt2arb_req_ready (bpt2arb_req6_ready)
,.arb_src_pd (arb_src6_pd)
,.arb_src_vld (arb_src6_vld)
,.arb_src_rdy (arb_src6_rdy)
);
assign src6_req = arb_src6_vld;
assign arb_src6_rdy = src6_gnt;

assign src7_req = 1'b0;
assign src8_req = 1'b0;
assign src9_req = 1'b0;
assign wt0 = reg2dp_rd_weight0;
assign wt1 = reg2dp_rd_weight1;
assign wt2 = reg2dp_rd_weight2;
assign wt3 = reg2dp_rd_weight3;
assign wt4 = reg2dp_rd_weight4;
assign wt5 = reg2dp_rd_weight5;
assign wt6 = reg2dp_rd_weight6;
assign wt7 = 8'h0;
assign wt8 = 8'h0;
assign wt9 = 8'h0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
read_ig_arb u_read_ig_arb (
   .req0 (src0_req) //|< w
  ,.req1 (src1_req) //|< w
  ,.req2 (src2_req) //|< w
  ,.req3 (src3_req) //|< w
  ,.req4 (src4_req) //|< w
  ,.req5 (src5_req) //|< w
  ,.req6 (src6_req) //|< w
  ,.req7 (src7_req) //|< w
  ,.req8 (src8_req) //|< w
  ,.req9 (src9_req) //|< w
  ,.wt0 (wt0[7:0]) //|< w
  ,.wt1 (wt1[7:0]) //|< w
  ,.wt2 (wt2[7:0]) //|< w
  ,.wt3 (wt3[7:0]) //|< w
  ,.wt4 (wt4[7:0]) //|< w
  ,.wt5 (wt5[7:0]) //|< w
  ,.wt6 (wt6[7:0]) //|< w
  ,.wt7 (wt7[7:0]) //|< w
  ,.wt8 (wt8[7:0]) //|< w
  ,.wt9 (wt9[7:0]) //|< w
  ,.gnt_busy (gnt_busy) //|< w
  ,.clk (nvdla_core_clk) //|< i
  ,.reset_ (nvdla_core_rstn) //|< i
  ,.gnt0 (src0_gnt) //|> w
  ,.gnt1 (src1_gnt) //|> w
  ,.gnt2 (src2_gnt) //|> w
  ,.gnt3 (src3_gnt) //|> w
  ,.gnt4 (src4_gnt) //|> w
  ,.gnt5 (src5_gnt) //|> w
  ,.gnt6 (src6_gnt) //|> w
  ,.gnt7 (src7_gnt) //|> w
  ,.gnt8 (src8_gnt) //|> w
  ,.gnt9 (src9_gnt) //|> w
  );
// MUX OUT
always @(
  src0_gnt
  or arb_src0_pd
//: for (my $i=1;$i<7;$i++) {
//: print "  or src${i}_gnt \n";
//: print "  or arb_src${i}_pd\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
  or src1_gnt 
  or arb_src1_pd
  or src2_gnt 
  or arb_src2_pd
  or src3_gnt 
  or arb_src3_pd
  or src4_gnt 
  or arb_src4_pd
  or src5_gnt 
  or arb_src5_pd
  or src6_gnt 
  or arb_src6_pd

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ) begin
//spyglass disable_block W171 W226
    case (1'b1 )
       src0_gnt: arb_pd = arb_src0_pd;
//: for (my $i=1;$i<7;$i++) {
//: print"       src${i}_gnt: arb_pd = arb_src${i}_pd;\n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
       src1_gnt: arb_pd = arb_src1_pd;
       src2_gnt: arb_pd = arb_src2_pd;
       src3_gnt: arb_pd = arb_src3_pd;
       src4_gnt: arb_pd = arb_src4_pd;
       src5_gnt: arb_pd = arb_src5_pd;
       src6_gnt: arb_pd = arb_src6_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
    default : begin
                arb_pd[32 +11 -1:0] = {32 +11{`x_or_0}};
              end
    endcase
//spyglass enable_block W171 W226
end
assign arb_gnt = {src9_gnt, src8_gnt, src7_gnt, src6_gnt, src5_gnt, src4_gnt, src3_gnt, src2_gnt, src1_gnt, src0_gnt};
assign arb_out_vld = |arb_gnt;
assign gnt_busy = !arb_out_rdy;
assign arb_out_pd = arb_pd;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_out pipe_out (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.arb_out_pd (arb_out_pd)
  ,.arb_out_vld (arb_out_vld)
  ,.arb_out_rdy (arb_out_rdy)
  ,.arb2spt_req_pd (arb2spt_req_pd)
  ,.arb2spt_req_valid (arb2spt_req_valid)
  ,.arb2spt_req_ready (arb2spt_req_ready)
  );
endmodule // NV_NVDLA_MCIF_READ_IG_arb
// **************************************************************************************************************
// Generated by ::pipe -m -rand none -bc -is arb_src_pd (arb_src_vld,arb_src_rdy) <= bpt2arb_req_pd[32 +11 -1:0] (bpt2arb_req_valid,bpt2arb_req_ready)
// **************************************************************************************************************
module NV_NVDLA_MCIF_READ_IG_ARB_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,bpt2arb_req_pd
  ,bpt2arb_req_valid
  ,bpt2arb_req_ready
  ,arb_src_pd
  ,arb_src_vld
  ,arb_src_rdy
);
input nvdla_core_clk;
input nvdla_core_rstn;
input [32 +11 -1:0] bpt2arb_req_pd;
input bpt2arb_req_valid;
output bpt2arb_req_ready;
output [32 +11 -1:0] arb_src_pd;
output arb_src_vld;
input arb_src_rdy;
//: my $mem = 32 +11;
//: &eperl::pipe(" -wid $mem -is -do arb_src_pd -vo arb_src_vld -ri arb_src_rdy -di bpt2arb_req_pd -vi bpt2arb_req_valid -ro bpt2arb_req_ready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg bpt2arb_req_ready;
reg skid_flop_bpt2arb_req_ready;
reg skid_flop_bpt2arb_req_valid;
reg [43-1:0] skid_flop_bpt2arb_req_pd;
reg pipe_skid_bpt2arb_req_valid;
reg [43-1:0] pipe_skid_bpt2arb_req_pd;
// Wire
wire skid_bpt2arb_req_valid;
wire [43-1:0] skid_bpt2arb_req_pd;
wire skid_bpt2arb_req_ready;
wire pipe_skid_bpt2arb_req_ready;
wire arb_src_vld;
wire [43-1:0] arb_src_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       bpt2arb_req_ready <= 1'b1;
       skid_flop_bpt2arb_req_ready <= 1'b1;
   end else begin
       bpt2arb_req_ready <= skid_bpt2arb_req_ready;
       skid_flop_bpt2arb_req_ready <= skid_bpt2arb_req_ready;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_bpt2arb_req_valid <= 1'b0;
    end else begin
        if (skid_flop_bpt2arb_req_ready) begin
            skid_flop_bpt2arb_req_valid <= bpt2arb_req_valid;
        end
   end
end
assign skid_bpt2arb_req_valid = (skid_flop_bpt2arb_req_ready) ? bpt2arb_req_valid : skid_flop_bpt2arb_req_valid;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_bpt2arb_req_ready & bpt2arb_req_valid) begin
        skid_flop_bpt2arb_req_pd[43-1:0] <= bpt2arb_req_pd[43-1:0];
    end
end
assign skid_bpt2arb_req_pd[43-1:0] = (skid_flop_bpt2arb_req_ready) ? bpt2arb_req_pd[43-1:0] : skid_flop_bpt2arb_req_pd[43-1:0];


// PIPE READY
assign skid_bpt2arb_req_ready = pipe_skid_bpt2arb_req_ready || !pipe_skid_bpt2arb_req_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_bpt2arb_req_valid <= 1'b0;
    end else begin
        if (skid_bpt2arb_req_ready) begin
            pipe_skid_bpt2arb_req_valid <= skid_bpt2arb_req_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_bpt2arb_req_ready && skid_bpt2arb_req_valid) begin
        pipe_skid_bpt2arb_req_pd[43-1:0] <= skid_bpt2arb_req_pd[43-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_bpt2arb_req_ready = arb_src_rdy;
assign arb_src_vld = pipe_skid_bpt2arb_req_valid;
assign arb_src_pd = pipe_skid_bpt2arb_req_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_READ_IG_ARB_pipe
module NV_NVDLA_MCIF_READ_IG_ARB_pipe_out (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,arb_out_pd
  ,arb_out_vld
  ,arb_out_rdy
  ,arb2spt_req_pd
  ,arb2spt_req_valid
  ,arb2spt_req_ready
);
input nvdla_core_clk;
input nvdla_core_rstn;
output [32 +11 -1:0] arb2spt_req_pd;
output arb2spt_req_valid;
input arb2spt_req_ready;
input [32 +11 -1:0] arb_out_pd;
input arb_out_vld;
output arb_out_rdy;
//: my $mem = 32 +11;
//: &eperl::pipe(" -wid $mem -is -di arb_out_pd -vi arb_out_vld -ro arb_out_rdy -do arb2spt_req_pd -vo arb2spt_req_valid -ri arb2spt_req_ready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg arb_out_rdy;
reg skid_flop_arb_out_rdy;
reg skid_flop_arb_out_vld;
reg [43-1:0] skid_flop_arb_out_pd;
reg pipe_skid_arb_out_vld;
reg [43-1:0] pipe_skid_arb_out_pd;
// Wire
wire skid_arb_out_vld;
wire [43-1:0] skid_arb_out_pd;
wire skid_arb_out_rdy;
wire pipe_skid_arb_out_rdy;
wire arb2spt_req_valid;
wire [43-1:0] arb2spt_req_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       arb_out_rdy <= 1'b1;
       skid_flop_arb_out_rdy <= 1'b1;
   end else begin
       arb_out_rdy <= skid_arb_out_rdy;
       skid_flop_arb_out_rdy <= skid_arb_out_rdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_arb_out_vld <= 1'b0;
    end else begin
        if (skid_flop_arb_out_rdy) begin
            skid_flop_arb_out_vld <= arb_out_vld;
        end
   end
end
assign skid_arb_out_vld = (skid_flop_arb_out_rdy) ? arb_out_vld : skid_flop_arb_out_vld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_arb_out_rdy & arb_out_vld) begin
        skid_flop_arb_out_pd[43-1:0] <= arb_out_pd[43-1:0];
    end
end
assign skid_arb_out_pd[43-1:0] = (skid_flop_arb_out_rdy) ? arb_out_pd[43-1:0] : skid_flop_arb_out_pd[43-1:0];


// PIPE READY
assign skid_arb_out_rdy = pipe_skid_arb_out_rdy || !pipe_skid_arb_out_vld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_arb_out_vld <= 1'b0;
    end else begin
        if (skid_arb_out_rdy) begin
            pipe_skid_arb_out_vld <= skid_arb_out_vld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_arb_out_rdy && skid_arb_out_vld) begin
        pipe_skid_arb_out_pd[43-1:0] <= skid_arb_out_pd[43-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_arb_out_rdy = arb2spt_req_ready;
assign arb2spt_req_valid = pipe_skid_arb_out_vld;
assign arb2spt_req_pd = pipe_skid_arb_out_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // NV_NVDLA_MCIF_READ_IG_ARB_pipe
