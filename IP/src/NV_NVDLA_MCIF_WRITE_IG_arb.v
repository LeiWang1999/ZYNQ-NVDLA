// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_MCIF_WRITE_IG_arb.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
`include "simulate_x_tick.vh"
module NV_NVDLA_MCIF_WRITE_IG_arb (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd
  ,arb2spt_cmd_pd //|> o
  ,arb2spt_cmd_valid //|> o
  ,arb2spt_cmd_ready //|< i
  ,arb2spt_dat_pd //|> o
  ,arb2spt_dat_valid //|> o
  ,arb2spt_dat_ready //|< i
//:for(my $i=0;$i<3;$i++) {
//: print "  ,bpt2arb_cmd${i}_pd    \n";
//: print "  ,bpt2arb_cmd${i}_valid \n";
//: print "  ,bpt2arb_cmd${i}_ready \n";
//: print "  ,bpt2arb_dat${i}_pd    \n";
//: print "  ,bpt2arb_dat${i}_valid \n";
//: print "  ,bpt2arb_dat${i}_ready \n";
//: print "  ,reg2dp_wr_weight${i}  \n";
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
  ,bpt2arb_cmd0_pd    
  ,bpt2arb_cmd0_valid 
  ,bpt2arb_cmd0_ready 
  ,bpt2arb_dat0_pd    
  ,bpt2arb_dat0_valid 
  ,bpt2arb_dat0_ready 
  ,reg2dp_wr_weight0  
  ,bpt2arb_cmd1_pd    
  ,bpt2arb_cmd1_valid 
  ,bpt2arb_cmd1_ready 
  ,bpt2arb_dat1_pd    
  ,bpt2arb_dat1_valid 
  ,bpt2arb_dat1_ready 
  ,reg2dp_wr_weight1  
  ,bpt2arb_cmd2_pd    
  ,bpt2arb_cmd2_valid 
  ,bpt2arb_cmd2_ready 
  ,bpt2arb_dat2_pd    
  ,bpt2arb_dat2_valid 
  ,bpt2arb_dat2_ready 
  ,reg2dp_wr_weight2  

//| eperl: generated_end (DO NOT EDIT ABOVE)
);
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
output arb2spt_cmd_valid;
input arb2spt_cmd_ready;
output [32 +13 -1:0] arb2spt_cmd_pd;
output arb2spt_dat_valid;
input arb2spt_dat_ready;
output [66 -2:0] arb2spt_dat_pd;
//:for(my $i=0;$i<3;$i++) {
//: print qq(
//: input bpt2arb_cmd${i}_valid;
//: output bpt2arb_cmd${i}_ready;
//: input [32 +13 -1:0] bpt2arb_cmd${i}_pd;
//: input bpt2arb_dat${i}_valid;
//: output bpt2arb_dat${i}_ready;
//: input [66 -2:0] bpt2arb_dat${i}_pd;
//: input [7:0] reg2dp_wr_weight${i};
//: );
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

input bpt2arb_cmd0_valid;
output bpt2arb_cmd0_ready;
input [32 +13 -1:0] bpt2arb_cmd0_pd;
input bpt2arb_dat0_valid;
output bpt2arb_dat0_ready;
input [66 -2:0] bpt2arb_dat0_pd;
input [7:0] reg2dp_wr_weight0;

input bpt2arb_cmd1_valid;
output bpt2arb_cmd1_ready;
input [32 +13 -1:0] bpt2arb_cmd1_pd;
input bpt2arb_dat1_valid;
output bpt2arb_dat1_ready;
input [66 -2:0] bpt2arb_dat1_pd;
input [7:0] reg2dp_wr_weight1;

input bpt2arb_cmd2_valid;
output bpt2arb_cmd2_ready;
input [32 +13 -1:0] bpt2arb_cmd2_pd;
input bpt2arb_dat2_valid;
output bpt2arb_dat2_ready;
input [66 -2:0] bpt2arb_dat2_pd;
input [7:0] reg2dp_wr_weight2;

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [32 +13 -1:0] arb_cmd_pd;
reg [66 -2:0] arb_dat_pd;
reg sticky;
wire any_arb_gnt;
reg [4:0] stick_gnts;
wire [4:0] all_gnts;
wire [4:0] arb_gnts;
wire [4:0] arb_reqs;
wire gnt_busy;
wire spt_is_busy;
wire is_last_beat;
reg [2:0] gnt_count;
wire [2:0] arb_cmd_size;
//:for(my $i=0;$i<3;$i++) {
//: print qq(
//: wire [2:0] src_cmd${i}_beats;
//: wire src_cmd${i}_camp_vld;
//: wire [32 +13 -1:0] src_cmd${i}_pd;
//: wire src_cmd${i}_rdy;
//: wire [2:0] src_cmd${i}_size;
//: wire src_cmd${i}_vld;
//: wire [66 -2:0] src_dat${i}_pd;
//: wire src_dat${i}_rdy;
//: wire src_dat${i}_vld;
//: wire [2:0] dfifo${i}_wr_count;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [2:0] src_cmd0_beats;
wire src_cmd0_camp_vld;
wire [32 +13 -1:0] src_cmd0_pd;
wire src_cmd0_rdy;
wire [2:0] src_cmd0_size;
wire src_cmd0_vld;
wire [66 -2:0] src_dat0_pd;
wire src_dat0_rdy;
wire src_dat0_vld;
wire [2:0] dfifo0_wr_count;

wire [2:0] src_cmd1_beats;
wire src_cmd1_camp_vld;
wire [32 +13 -1:0] src_cmd1_pd;
wire src_cmd1_rdy;
wire [2:0] src_cmd1_size;
wire src_cmd1_vld;
wire [66 -2:0] src_dat1_pd;
wire src_dat1_rdy;
wire src_dat1_vld;
wire [2:0] dfifo1_wr_count;

wire [2:0] src_cmd2_beats;
wire src_cmd2_camp_vld;
wire [32 +13 -1:0] src_cmd2_pd;
wire src_cmd2_rdy;
wire [2:0] src_cmd2_size;
wire src_cmd2_vld;
wire [66 -2:0] src_dat2_pd;
wire src_dat2_rdy;
wire src_dat2_vld;
wire [2:0] dfifo2_wr_count;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [4:0] src_cmd_vlds;
wire [4:0] src_dat_gnts;
wire src_dat_vld;
wire src_dat_rdy;
wire [4:0] src_dat_vlds;
wire [7:0] wt0;
wire [7:0] wt1;
wire [7:0] wt2;
wire [7:0] wt3;
wire [7:0] wt4;
//:for(my $i=0;$i<3;$i++) {
//: print qq(
//: NV_NVDLA_MCIF_WRITE_IG_ARB_pipe pipe_${i} (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.bpt2arb_cmd_pd (bpt2arb_cmd${i}_pd)
//: ,.bpt2arb_cmd_valid (bpt2arb_cmd${i}_valid)
//: ,.bpt2arb_cmd_ready (bpt2arb_cmd${i}_ready)
//: ,.src_cmd_pd (src_cmd${i}_pd)
//: ,.src_cmd_vld (src_cmd${i}_vld)
//: ,.src_cmd_rdy (src_cmd${i}_rdy)
//: );
//:
//: NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo u_dfifo${i} (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.dfifo_wr_count (dfifo${i}_wr_count[2:0])
//: ,.dfifo_wr_prdy (bpt2arb_dat${i}_ready)
//: ,.dfifo_wr_pvld (bpt2arb_dat${i}_valid)
//: ,.dfifo_wr_pd (bpt2arb_dat${i}_pd)
//: ,.dfifo_rd_prdy (src_dat${i}_rdy)
//: ,.dfifo_rd_pvld (src_dat${i}_vld)
//: ,.dfifo_rd_pd (src_dat${i}_pd)
//: ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
//: );
//: );
//: print "\n";
//: print qq(
//: assign src_cmd${i}_size= {3{src_cmd${i}_vld}} & src_cmd${i}_pd[32 +7:32 +5];
//: assign src_cmd${i}_rdy = is_last_beat & src_dat_rdy & src_dat_gnts[$i];
//: assign src_dat${i}_rdy = src_dat_rdy & all_gnts[${i}];
//: assign src_cmd${i}_beats = src_cmd${i}_size;
//: assign src_cmd${i}_camp_vld = src_cmd${i}_vld & (dfifo${i}_wr_count > src_cmd${i}_beats);
//: );
//:}
//:for(my $i=3;$i<5;$i++) {
//: print "wire   src_cmd${i}_camp_vld = 1'b0;\n";
//: print "wire   src_dat${i}_vld = 1'b0;\n";
//: print qq(wire [32 +13 -1:0] src_cmd${i}_pd = 1'b0;\n);
//: print qq(wire [66 -2:0] src_dat${i}_pd = 1'b0;\n);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

NV_NVDLA_MCIF_WRITE_IG_ARB_pipe pipe_0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_cmd_pd (bpt2arb_cmd0_pd)
,.bpt2arb_cmd_valid (bpt2arb_cmd0_valid)
,.bpt2arb_cmd_ready (bpt2arb_cmd0_ready)
,.src_cmd_pd (src_cmd0_pd)
,.src_cmd_vld (src_cmd0_vld)
,.src_cmd_rdy (src_cmd0_rdy)
);

NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo u_dfifo0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dfifo_wr_count (dfifo0_wr_count[2:0])
,.dfifo_wr_prdy (bpt2arb_dat0_ready)
,.dfifo_wr_pvld (bpt2arb_dat0_valid)
,.dfifo_wr_pd (bpt2arb_dat0_pd)
,.dfifo_rd_prdy (src_dat0_rdy)
,.dfifo_rd_pvld (src_dat0_vld)
,.dfifo_rd_pd (src_dat0_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);


assign src_cmd0_size= {3{src_cmd0_vld}} & src_cmd0_pd[32 +7:32 +5];
assign src_cmd0_rdy = is_last_beat & src_dat_rdy & src_dat_gnts[0];
assign src_dat0_rdy = src_dat_rdy & all_gnts[0];
assign src_cmd0_beats = src_cmd0_size;
assign src_cmd0_camp_vld = src_cmd0_vld & (dfifo0_wr_count > src_cmd0_beats);

NV_NVDLA_MCIF_WRITE_IG_ARB_pipe pipe_1 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_cmd_pd (bpt2arb_cmd1_pd)
,.bpt2arb_cmd_valid (bpt2arb_cmd1_valid)
,.bpt2arb_cmd_ready (bpt2arb_cmd1_ready)
,.src_cmd_pd (src_cmd1_pd)
,.src_cmd_vld (src_cmd1_vld)
,.src_cmd_rdy (src_cmd1_rdy)
);

NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo u_dfifo1 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dfifo_wr_count (dfifo1_wr_count[2:0])
,.dfifo_wr_prdy (bpt2arb_dat1_ready)
,.dfifo_wr_pvld (bpt2arb_dat1_valid)
,.dfifo_wr_pd (bpt2arb_dat1_pd)
,.dfifo_rd_prdy (src_dat1_rdy)
,.dfifo_rd_pvld (src_dat1_vld)
,.dfifo_rd_pd (src_dat1_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);


assign src_cmd1_size= {3{src_cmd1_vld}} & src_cmd1_pd[32 +7:32 +5];
assign src_cmd1_rdy = is_last_beat & src_dat_rdy & src_dat_gnts[1];
assign src_dat1_rdy = src_dat_rdy & all_gnts[1];
assign src_cmd1_beats = src_cmd1_size;
assign src_cmd1_camp_vld = src_cmd1_vld & (dfifo1_wr_count > src_cmd1_beats);

NV_NVDLA_MCIF_WRITE_IG_ARB_pipe pipe_2 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.bpt2arb_cmd_pd (bpt2arb_cmd2_pd)
,.bpt2arb_cmd_valid (bpt2arb_cmd2_valid)
,.bpt2arb_cmd_ready (bpt2arb_cmd2_ready)
,.src_cmd_pd (src_cmd2_pd)
,.src_cmd_vld (src_cmd2_vld)
,.src_cmd_rdy (src_cmd2_rdy)
);

NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo u_dfifo2 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.dfifo_wr_count (dfifo2_wr_count[2:0])
,.dfifo_wr_prdy (bpt2arb_dat2_ready)
,.dfifo_wr_pvld (bpt2arb_dat2_valid)
,.dfifo_wr_pd (bpt2arb_dat2_pd)
,.dfifo_rd_prdy (src_dat2_rdy)
,.dfifo_rd_pvld (src_dat2_vld)
,.dfifo_rd_pd (src_dat2_pd)
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
);


assign src_cmd2_size= {3{src_cmd2_vld}} & src_cmd2_pd[32 +7:32 +5];
assign src_cmd2_rdy = is_last_beat & src_dat_rdy & src_dat_gnts[2];
assign src_dat2_rdy = src_dat_rdy & all_gnts[2];
assign src_cmd2_beats = src_cmd2_size;
assign src_cmd2_camp_vld = src_cmd2_vld & (dfifo2_wr_count > src_cmd2_beats);
wire   src_cmd3_camp_vld = 1'b0;
wire   src_dat3_vld = 1'b0;
wire [32 +13 -1:0] src_cmd3_pd = 1'b0;
wire [66 -2:0] src_dat3_pd = 1'b0;
wire   src_cmd4_camp_vld = 1'b0;
wire   src_dat4_vld = 1'b0;
wire [32 +13 -1:0] src_cmd4_pd = 1'b0;
wire [66 -2:0] src_dat4_pd = 1'b0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign src_cmd_vlds = {src_cmd4_camp_vld , src_cmd3_camp_vld , src_cmd2_camp_vld , src_cmd1_camp_vld , src_cmd0_camp_vld};
assign src_dat_vlds = {src_dat4_vld , src_dat3_vld , src_dat2_vld , src_dat1_vld , src_dat0_vld};
assign arb_reqs = src_cmd_vlds;
//:for(my $i=3;$i<5;$i++) {
//: print"wire  [7:0]  reg2dp_wr_weight${i} = 8'b0; \n";
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire  [7:0]  reg2dp_wr_weight3 = 8'b0; 
wire  [7:0]  reg2dp_wr_weight4 = 8'b0; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
write_ig_arb u_write_ig_arb (
   .req0 (arb_reqs[0]) //|< w
  ,.req1 (arb_reqs[1]) //|< w
  ,.req2 (arb_reqs[2]) //|< w
  ,.req3 (arb_reqs[3]) //|< w
  ,.req4 (arb_reqs[4]) //|< w
  ,.wt0 (reg2dp_wr_weight0) //|< w
  ,.wt1 (reg2dp_wr_weight1) //|< w
  ,.wt2 (reg2dp_wr_weight2) //|< w
  ,.wt3 (reg2dp_wr_weight3) //|< w
  ,.wt4 (reg2dp_wr_weight4) //|< w
  ,.gnt_busy (gnt_busy) //|< w
  ,.clk (nvdla_core_clk) //|< i
  ,.reset_ (nvdla_core_rstn) //|< i
  ,.gnt0 (arb_gnts[0]) //|> w
  ,.gnt1 (arb_gnts[1]) //|> w
  ,.gnt2 (arb_gnts[2]) //|> w
  ,.gnt3 (arb_gnts[3]) //|> w
  ,.gnt4 (arb_gnts[4]) //|> w
  );
assign any_arb_gnt = |arb_gnts;
assign all_gnts = (sticky) ? (stick_gnts) : arb_gnts;
assign gnt_busy = sticky || spt_is_busy;
// MUX out based on GNT
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    stick_gnts <= {5{1'b0}};
  end else begin
  if ((any_arb_gnt) == 1'b1) begin
    stick_gnts <= arb_gnts;
  end //else if ((any_arb_gnt) == 1'b0) begin
//end else begin
// stick_gnts <= 'bx;
//end
  end
end
//keep grant not change until all data accept
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    sticky <= 1'b0;
  end else begin
    if (any_arb_gnt) begin
        if (src_dat_vld & src_dat_rdy & is_last_beat) begin
            sticky <= 0;
        end else begin
            sticky <= 1;
        end
    end else if (src_dat_vld & src_dat_rdy & is_last_beat) begin
        sticky <= 0;
    end
  end
end
assign src_dat_gnts = all_gnts & src_dat_vlds;
assign src_dat_vld = |src_dat_gnts;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    gnt_count <= {3{1'b0}};
  end else begin
    if (src_dat_vld & src_dat_rdy) begin
        if (is_last_beat) begin
            gnt_count <= 0;
        end else begin
            gnt_count <= gnt_count + 1;
        end
    end
  end
end
assign is_last_beat = (gnt_count==arb_cmd_size);
// ARB MUX
always @(
  all_gnts
  or src_cmd0_pd
  or src_cmd1_pd
  or src_cmd2_pd
  or src_cmd3_pd
  or src_cmd4_pd
  ) begin
//spyglass disable_block W171 W226
    case (1'b1 )
      all_gnts[0]: arb_cmd_pd = src_cmd0_pd;
      all_gnts[1]: arb_cmd_pd = src_cmd1_pd;
      all_gnts[2]: arb_cmd_pd = src_cmd2_pd;
      all_gnts[3]: arb_cmd_pd = src_cmd3_pd;
      all_gnts[4]: arb_cmd_pd = src_cmd4_pd;
    default : begin
                arb_cmd_pd[32 +13 -1:0] = {(32 +13){`x_or_0}};
              end
    endcase
//spyglass enable_block W171 W226
end
assign arb_cmd_size = arb_cmd_pd[32 +7:32 +5];
//assign arb_cmd_inc = arb_cmd_pd[50:50];
always @(
  all_gnts
  or src_dat0_pd
  or src_dat1_pd
  or src_dat2_pd
  or src_dat3_pd
  or src_dat4_pd
  ) begin
//spyglass disable_block W171 W226
    case (1'b1 )
      all_gnts[0]: arb_dat_pd = src_dat0_pd;
      all_gnts[1]: arb_dat_pd = src_dat1_pd;
      all_gnts[2]: arb_dat_pd = src_dat2_pd;
      all_gnts[3]: arb_dat_pd = src_dat3_pd;
      all_gnts[4]: arb_dat_pd = src_dat4_pd;
    default : begin
                arb_dat_pd[66 -2:0] = {(66 -1){`x_or_0}};
              end
    endcase
//spyglass enable_block W171 W226
end
assign arb2spt_cmd_pd = arb_cmd_pd;
assign arb2spt_dat_pd = arb_dat_pd;
assign arb2spt_cmd_valid = any_arb_gnt;
assign arb2spt_dat_valid = src_dat_vld;
assign src_dat_rdy = arb2spt_dat_ready;
assign spt_is_busy = !(arb2spt_cmd_ready & arb2spt_dat_ready); //fixme
endmodule // NV_NVDLA_MCIF_WRITE_IG_arb
// **************************************************************************************************************
// Generated by ::pipe -m -rand none -bc -is src_cmd_pd (src_cmd_vld,src_cmd_rdy) <= bpt2arb_cmd_pd[32 +13 -1:0] (bpt2arb_cmd_valid,bpt2arb_cmd_ready)
// **************************************************************************************************************
module NV_NVDLA_MCIF_WRITE_IG_ARB_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,bpt2arb_cmd_pd
  ,bpt2arb_cmd_valid
  ,bpt2arb_cmd_ready
  ,src_cmd_pd
  ,src_cmd_vld
  ,src_cmd_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [32 +13 -1:0] bpt2arb_cmd_pd;
input bpt2arb_cmd_valid;
output bpt2arb_cmd_ready;
output [32 +13 -1:0] src_cmd_pd;
output src_cmd_vld;
input src_cmd_rdy;
//: my $dw = 32 +13;
//: &eperl::pipe(" -wid $dw -do src_cmd_pd -vo src_cmd_vld -ri src_cmd_rdy  -di bpt2arb_cmd_pd -vi bpt2arb_cmd_valid -ro bpt2arb_cmd_ready");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg pipe_bpt2arb_cmd_valid;
reg [45-1:0] pipe_bpt2arb_cmd_pd;
// Wire
wire bpt2arb_cmd_ready;
wire pipe_bpt2arb_cmd_ready;
wire src_cmd_vld;
wire [45-1:0] src_cmd_pd;
// Code
// PIPE READY
assign bpt2arb_cmd_ready = pipe_bpt2arb_cmd_ready || !pipe_bpt2arb_cmd_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_bpt2arb_cmd_valid <= 1'b0;
    end else begin
        if (bpt2arb_cmd_ready) begin
            pipe_bpt2arb_cmd_valid <= bpt2arb_cmd_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (bpt2arb_cmd_ready && bpt2arb_cmd_valid) begin
        pipe_bpt2arb_cmd_pd[45-1:0] <= bpt2arb_cmd_pd[45-1:0];
    end
end


// PIPE OUTPUT
assign pipe_bpt2arb_cmd_ready = src_cmd_rdy;
assign src_cmd_vld = pipe_bpt2arb_cmd_valid;
assign src_cmd_pd = pipe_bpt2arb_cmd_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
module NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo (
      nvdla_core_clk
    , nvdla_core_rstn
    , dfifo_wr_count
    , dfifo_wr_prdy
    , dfifo_wr_pvld
    , dfifo_wr_pd
    , dfifo_rd_prdy
    , dfifo_rd_pvld
    , dfifo_rd_pd
    , pwrbus_ram_pd
    );
// spyglass disable_block W401 -- clock is not input to module
input nvdla_core_clk;
input nvdla_core_rstn;
output [2:0] dfifo_wr_count;
output dfifo_wr_prdy;
input dfifo_wr_pvld;
input [64:0] dfifo_wr_pd;
input dfifo_rd_prdy;
output dfifo_rd_pvld;
output [64:0] dfifo_rd_pd;
input [31:0] pwrbus_ram_pd;
// Master Clock Gating (SLCG)
//
// We gate the clock(s) when idle or stalled.
// This allows us to turn off numerous miscellaneous flops
// that don't get gated during synthesis for one reason or another.
//
// We gate write side and read side separately.
// If the fifo is synchronous, we also gate the ram separately, but if
// -master_clk_gated_unified or -status_reg/-status_logic_reg is specified,
// then we use one clk gate for write, ram, and read.
//
wire nvdla_core_clk_mgated_enable; // assigned by code at end of this module
wire nvdla_core_clk_mgated; // used only in synchronous fifos
NV_CLK_gate_power nvdla_core_clk_mgate( .clk(nvdla_core_clk), .reset_(nvdla_core_rstn), .clk_en(nvdla_core_clk_mgated_enable), .clk_gated(nvdla_core_clk_mgated) );
//
// WRITE SIDE
//
wire wr_reserving;
reg dfifo_wr_busy_int; // copy for internal use
assign dfifo_wr_prdy = !dfifo_wr_busy_int;
assign wr_reserving = dfifo_wr_pvld && !dfifo_wr_busy_int; // reserving write space?
wire wr_popping; // fwd: write side sees pop?
reg [2:0] dfifo_wr_count; // write-side count
wire [2:0] wr_count_next_wr_popping = wr_reserving ? dfifo_wr_count : (dfifo_wr_count - 1'd1); // spyglass disable W164a W484
wire [2:0] wr_count_next_no_wr_popping = wr_reserving ? (dfifo_wr_count + 1'd1) : dfifo_wr_count; // spyglass disable W164a W484
wire [2:0] wr_count_next = wr_popping ? wr_count_next_wr_popping :
                                               wr_count_next_no_wr_popping;
wire wr_count_next_no_wr_popping_is_4 = ( wr_count_next_no_wr_popping == 3'd4 );
wire wr_count_next_is_4 = wr_popping ? 1'b0 :
                                          wr_count_next_no_wr_popping_is_4;
wire [2:0] wr_limit_muxed; // muxed with simulation/emulation overrides
wire [2:0] wr_limit_reg = wr_limit_muxed;
// VCS coverage off
wire dfifo_wr_busy_next = wr_count_next_is_4 || // busy next cycle?
                          (wr_limit_reg != 3'd0 && // check dfifo_wr_limit if != 0
                           wr_count_next >= wr_limit_reg) ;
// VCS coverage on
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        dfifo_wr_busy_int <= 1'b0;
        dfifo_wr_count <= 3'd0;
    end else begin
 dfifo_wr_busy_int <= dfifo_wr_busy_next;
 if ( wr_reserving ^ wr_popping ) begin
     dfifo_wr_count <= wr_count_next;
        end
//synopsys translate_off
            else if ( !(wr_reserving ^ wr_popping) ) begin
        end else begin
            dfifo_wr_count <= {3{`x_or_0}};
        end
//synopsys translate_on
    end
end
wire wr_pushing = wr_reserving; // data pushed same cycle as dfifo_wr_pvld
//
// RAM
//
reg [1:0] dfifo_wr_adr; // current write address
// spyglass disable_block W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        dfifo_wr_adr <= 2'd0;
    end else begin
        if ( wr_pushing ) begin
     dfifo_wr_adr <= dfifo_wr_adr + 1'd1;
        end
    end
end
// spyglass enable_block W484
reg [1:0] dfifo_rd_adr; // read address this cycle
wire ram_we = wr_pushing; // note: write occurs next cycle
wire [64:0] dfifo_rd_pd; // read data out of ram
wire [31 : 0] pwrbus_ram_pd;
// Adding parameter for fifogen to disable wr/rd contention assertion in ramgen.
// Fifogen handles this by ignoring the data on the ram data out for that cycle.
NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65 ram (
      .clk( nvdla_core_clk_mgated )
    , .pwrbus_ram_pd ( pwrbus_ram_pd )
    , .di ( dfifo_wr_pd )
    , .we ( ram_we )
    , .wa ( dfifo_wr_adr )
    , .ra ( dfifo_rd_adr )
    , .dout ( dfifo_rd_pd )
    );
wire rd_popping; // read side doing pop this cycle?
wire [1:0] rd_adr_next_popping = dfifo_rd_adr + 1'd1; // spyglass disable W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        dfifo_rd_adr <= 2'd0;
    end else begin
        if ( rd_popping ) begin
     dfifo_rd_adr <= rd_adr_next_popping;
        end
//synopsys translate_off
            else if ( !rd_popping ) begin
        end else begin
            dfifo_rd_adr <= {2{`x_or_0}};
        end
//synopsys translate_on
    end
end
//
// SYNCHRONOUS BOUNDARY
//
assign wr_popping = rd_popping; // let it be seen immediately
wire rd_pushing = wr_pushing; // let it be seen immediately
//
// READ SIDE
//
reg dfifo_rd_pvld; // data out of fifo is valid
reg dfifo_rd_pvld_int; // internal copy of dfifo_rd_pvld
assign rd_popping = dfifo_rd_pvld_int && dfifo_rd_prdy;
reg [2:0] dfifo_rd_count; // read-side fifo count
// spyglass disable_block W164a W484
wire [2:0] rd_count_next_rd_popping = rd_pushing ? dfifo_rd_count :
                                                                (dfifo_rd_count - 1'd1);
wire [2:0] rd_count_next_no_rd_popping = rd_pushing ? (dfifo_rd_count + 1'd1) :
                                                                    dfifo_rd_count;
// spyglass enable_block W164a W484
wire [2:0] rd_count_next = rd_popping ? rd_count_next_rd_popping :
                                                     rd_count_next_no_rd_popping;
wire rd_count_next_rd_popping_not_0 = rd_count_next_rd_popping != 0;
wire rd_count_next_no_rd_popping_not_0 = rd_count_next_no_rd_popping != 0;
wire rd_count_next_not_0 = rd_popping ? rd_count_next_rd_popping_not_0 :
                                              rd_count_next_no_rd_popping_not_0;
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        dfifo_rd_count <= 3'd0;
        dfifo_rd_pvld <= 1'b0;
        dfifo_rd_pvld_int <= 1'b0;
    end else begin
        if ( rd_pushing || rd_popping ) begin
     dfifo_rd_count <= rd_count_next;
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            dfifo_rd_count <= {3{`x_or_0}};
        end
//synopsys translate_on
        if ( rd_pushing || rd_popping ) begin
     dfifo_rd_pvld <= (rd_count_next_not_0);
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            dfifo_rd_pvld <= `x_or_0;
        end
//synopsys translate_on
        if ( rd_pushing || rd_popping ) begin
     dfifo_rd_pvld_int <= (rd_count_next_not_0);
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            dfifo_rd_pvld_int <= `x_or_0;
        end
//synopsys translate_on
    end
end
// Master Clock Gating (SLCG) Enables
//
// plusarg for disabling this stuff:
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg master_clk_gating_disabled; initial master_clk_gating_disabled = $test$plusargs( "fifogen_disable_master_clk_gating" ) != 0;
`endif
`endif
// synopsys translate_on
assign nvdla_core_clk_mgated_enable = ((wr_reserving || wr_pushing || wr_popping || (dfifo_wr_pvld && !dfifo_wr_busy_int) || (dfifo_wr_busy_int != dfifo_wr_busy_next)) || (rd_pushing || rd_popping || (dfifo_rd_pvld && dfifo_rd_prdy)) || (wr_pushing))
                               `ifdef FIFOGEN_MASTER_CLK_GATING_DISABLED
                               || 1'b1
                               `endif
// synopsys translate_off
          `ifndef SYNTH_LEVEL1_COMPILE
          `ifndef SYNTHESIS
                               || master_clk_gating_disabled
          `endif
          `endif
// synopsys translate_on
                               ;
// Simulation and Emulation Overrides of wr_limit(s)
//
`ifdef EMU
`ifdef EMU_FIFO_CFG
// Emulation Global Config Override
//
assign wr_limit_muxed = `EMU_FIFO_CFG.NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_wr_limit_override ? `EMU_FIFO_CFG.NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_wr_limit : 3'd0;
`else
// No Global Override for Emulation
//
assign wr_limit_muxed = 3'd0;
`endif // EMU_FIFO_CFG
`else // !EMU
`ifdef SYNTH_LEVEL1_COMPILE
// No Override for GCS Compiles
//
assign wr_limit_muxed = 3'd0;
`else
`ifdef SYNTHESIS
// No Override for RTL Synthesis
//
assign wr_limit_muxed = 3'd0;
`else
// RTL Simulation Plusarg Override
// VCS coverage off
reg wr_limit_override;
reg [2:0] wr_limit_override_value;
assign wr_limit_muxed = wr_limit_override ? wr_limit_override_value : 3'd0;
`ifdef NV_ARCHPRO
event reinit;
initial begin
    $display("fifogen reinit initial block %m");
    -> reinit;
end
`endif
`ifdef NV_ARCHPRO
always @( reinit ) begin
`else
initial begin
`endif
    wr_limit_override = 0;
    wr_limit_override_value = 0; // to keep viva happy with dangles
    if ( $test$plusargs( "NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_wr_limit" ) ) begin
        wr_limit_override = 1;
        $value$plusargs( "NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_wr_limit=%d", wr_limit_override_value);
    end
end
// VCS coverage on
`endif
`endif
`endif
//
// Histogram of fifo depth (from write side's perspective)
//
// NOTE: it will reference `SIMTOP.perfmon_enabled, so that
// has to at least be defined, though not initialized.
// tbgen testbenches have it already and various
// ways to turn it on and off.
//
`ifdef PERFMON_HISTOGRAM
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
perfmon_histogram perfmon (
      .clk ( nvdla_core_clk )
    , .max ( {29'd0, (wr_limit_reg == 3'd0) ? 3'd4 : wr_limit_reg} )
    , .curr ( {29'd0, dfifo_wr_count} )
    );
`endif
`endif
// synopsys translate_on
`endif
// spyglass disable_block W164a W164b W116 W484 W504
`ifdef SPYGLASS
`else
`ifdef FV_ASSERT_ON
`else
// synopsys translate_off
`endif
`ifdef ASSERT_ON
`ifdef SPYGLASS
wire disable_assert_plusarg = 1'b0;
`else
`ifdef FV_ASSERT_ON
wire disable_assert_plusarg = 1'b0;
`else
wire disable_assert_plusarg = $test$plusargs("DISABLE_NESS_FLOW_ASSERTIONS");
`endif
`endif
wire assert_enabled = 1'b1 && !disable_assert_plusarg;
`endif
`ifdef FV_ASSERT_ON
`else
// synopsys translate_on
`endif
`ifdef ASSERT_ON
//synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
always @(assert_enabled) begin
    if ( assert_enabled === 1'b0 ) begin
        $display("Asserts are disabled for %m");
    end
end
`endif
`endif
//synopsys translate_on
`endif
`endif
// spyglass enable_block W164a W164b W116 W484 W504
//The NV_BLKBOX_SRC0 module is only present when the FIFOGEN_MODULE_SEARCH
// define is set. This is to aid fifogen team search for fifogen fifo
// instance and module names in a given design.
`ifdef FIFOGEN_MODULE_SEARCH
NV_BLKBOX_SRC0 dummy_breadcrumb_fifogen_blkbox (.Y());
`endif
// spyglass enable_block W401 -- clock is not input to module
// synopsys dc_script_begin
// set_boundary_optimization find(design, "NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo") true
// synopsys dc_script_end
endmodule // NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo
//
// Flop-Based RAM
//
module NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65 (
      clk
    , pwrbus_ram_pd
    , di
    , we
    , wa
    , ra
    , dout
    );
input clk; // write clock
input [31 : 0] pwrbus_ram_pd;
input [64:0] di;
input we;
input [1:0] wa;
input [1:0] ra;
output [64:0] dout;
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_0 (.A(pwrbus_ram_pd[0]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_1 (.A(pwrbus_ram_pd[1]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_2 (.A(pwrbus_ram_pd[2]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_3 (.A(pwrbus_ram_pd[3]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_4 (.A(pwrbus_ram_pd[4]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_5 (.A(pwrbus_ram_pd[5]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_6 (.A(pwrbus_ram_pd[6]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_7 (.A(pwrbus_ram_pd[7]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_8 (.A(pwrbus_ram_pd[8]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_9 (.A(pwrbus_ram_pd[9]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_10 (.A(pwrbus_ram_pd[10]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_11 (.A(pwrbus_ram_pd[11]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_12 (.A(pwrbus_ram_pd[12]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_13 (.A(pwrbus_ram_pd[13]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_14 (.A(pwrbus_ram_pd[14]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_15 (.A(pwrbus_ram_pd[15]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_16 (.A(pwrbus_ram_pd[16]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_17 (.A(pwrbus_ram_pd[17]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_18 (.A(pwrbus_ram_pd[18]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_19 (.A(pwrbus_ram_pd[19]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_20 (.A(pwrbus_ram_pd[20]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_21 (.A(pwrbus_ram_pd[21]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_22 (.A(pwrbus_ram_pd[22]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_23 (.A(pwrbus_ram_pd[23]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_24 (.A(pwrbus_ram_pd[24]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_25 (.A(pwrbus_ram_pd[25]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_26 (.A(pwrbus_ram_pd[26]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_27 (.A(pwrbus_ram_pd[27]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_28 (.A(pwrbus_ram_pd[28]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_29 (.A(pwrbus_ram_pd[29]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_30 (.A(pwrbus_ram_pd[30]));
`endif
`ifndef FPGA
NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_31 (.A(pwrbus_ram_pd[31]));
`endif
`ifdef EMU
// we use an emulation ram here to save flops on the emulation board
// so that the monstrous chip can fit :-)
//
reg [1:0] Wa0_vmw;
reg we0_vmw;
reg [64:0] Di0_vmw;
always @( posedge clk ) begin
    Wa0_vmw <= wa;
    we0_vmw <= we;
    Di0_vmw <= di;
end
vmw_NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65 emu_ram (
     .Wa0( Wa0_vmw )
   , .we0( we0_vmw )
   , .Di0( Di0_vmw )
   , .Ra0( ra )
   , .Do0( dout )
   );
`else
reg [64:0] ram_ff0;
reg [64:0] ram_ff1;
reg [64:0] ram_ff2;
reg [64:0] ram_ff3;
always @( posedge clk ) begin
    if ( we && wa == 2'd0 ) begin
 ram_ff0 <= di;
    end
    if ( we && wa == 2'd1 ) begin
 ram_ff1 <= di;
    end
    if ( we && wa == 2'd2 ) begin
 ram_ff2 <= di;
    end
    if ( we && wa == 2'd3 ) begin
 ram_ff3 <= di;
    end
end
reg [64:0] dout;
always @(*) begin
    case( ra )
    2'd0: dout = ram_ff0;
    2'd1: dout = ram_ff1;
    2'd2: dout = ram_ff2;
    2'd3: dout = ram_ff3;
//VCS coverage off
    default: dout = {65{`x_or_0}};
//VCS coverage on
    endcase
end
`endif // EMU
endmodule // NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65
// emulation model of flopram guts
//
`ifdef EMU
module vmw_NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65 (
   Wa0, we0, Di0,
   Ra0, Do0
   );
input [1:0] Wa0;
input we0;
input [64:0] Di0;
input [1:0] Ra0;
output [64:0] Do0;
// Only visible during Spyglass to avoid blackboxes.
`ifdef SPYGLASS_FLOPRAM
assign Do0 = 65'd0;
wire dummy = 1'b0 | (|Wa0) | (|we0) | (|Di0) | (|Ra0);
`endif
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg [64:0] mem[3:0];
// expand mem for debug ease
`ifdef EMU_EXPAND_FLOPRAM_MEM
wire [64:0] Q0 = mem[0];
wire [64:0] Q1 = mem[1];
wire [64:0] Q2 = mem[2];
wire [64:0] Q3 = mem[3];
`endif
// asynchronous ram writes
always @(*) begin
  if ( we0 == 1'b1 ) begin
    #0.1;
    mem[Wa0] = Di0;
  end
end
assign Do0 = mem[Ra0];
`endif
`endif
// synopsys translate_on
// synopsys dc_script_begin
// synopsys dc_script_end
// g2c if { [find / -null_ok -subdesign vmw_NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65] != {} } { set_attr preserve 1 [find / -subdesign vmw_NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65] }
endmodule // vmw_NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65
//vmw: Memory vmw_NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65
//vmw: Address-size 2
//vmw: Data-size 65
//vmw: Sensitivity level 1
//vmw: Ports W R
//vmw: terminal we0 WriteEnable0
//vmw: terminal Wa0 address0
//vmw: terminal Di0[64:0] data0[64:0]
//vmw:
//vmw: terminal Ra0 address1
//vmw: terminal Do0[64:0] data1[64:0]
//vmw:
//qt: CELL vmw_NV_NVDLA_MCIF_WRITE_IG_ARB_dfifo_flopram_rwsa_4x65
//qt: TERMINAL we0 TYPE=WE POLARITY=H PORT=1
//qt: TERMINAL Wa0[%d] TYPE=ADDRESS DIR=W BIT=%1 PORT=1
//qt: TERMINAL Di0[%d] TYPE=DATA DIR=I BIT=%1 PORT=1
//qt:
//qt: TERMINAL Ra0[%d] TYPE=ADDRESS DIR=R BIT=%1 PORT=1
//qt: TERMINAL Do0[%d] TYPE=DATA DIR=O BIT=%1 PORT=1
//qt:
`endif // EMU
