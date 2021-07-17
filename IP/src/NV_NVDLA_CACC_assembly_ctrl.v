// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC_assembly_ctrl.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC.h
module NV_NVDLA_CACC_assembly_ctrl (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dp2reg_done
  ,mac_a2accu_pd
  ,mac_a2accu_pvld
  ,mac_b2accu_pd
  ,mac_b2accu_pvld
  ,reg2dp_clip_truncate
  ,reg2dp_conv_mode
  ,reg2dp_op_en
  ,reg2dp_proc_precision
  ,abuf_rd_addr
  ,abuf_rd_en
  ,accu_ctrl_pd
  ,accu_ctrl_ram_valid
  ,accu_ctrl_valid
  ,cfg_in_en_mask
  ,cfg_is_wg
  ,cfg_truncate
  ,slcg_cell_en
  ,wait_for_op_en
  );
input [0:0] reg2dp_op_en;
input [0:0] reg2dp_conv_mode;
input [1:0] reg2dp_proc_precision;
input [4:0] reg2dp_clip_truncate;
output[3 +1 -1:0]abuf_rd_addr;
output abuf_rd_en;
input nvdla_core_clk;
input nvdla_core_rstn;
input dp2reg_done;
input [8:0] mac_a2accu_pd;
input mac_a2accu_pvld;
input [8:0] mac_b2accu_pd; //always equal mac_a2accu_pd
input mac_b2accu_pvld;
output [12:0] accu_ctrl_pd;
output accu_ctrl_ram_valid;
output accu_ctrl_valid;
output cfg_in_en_mask;
output cfg_is_wg;
output [4:0] cfg_truncate;
output slcg_cell_en;
output wait_for_op_en;
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.1.6
// cross partition,1T
//: &eperl::flop("-q  accu_valid  -d \"mac_a2accu_pvld\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop("-wid 9 -q  accu_pd  -en \"mac_a2accu_pvld\" -d  \"mac_a2accu_pd\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  accu_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_valid <= 'b0;
   end else begin
       accu_valid <= mac_a2accu_pvld;
   end
end
reg [8:0] accu_pd;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_pd <= 'b0;
   end else begin
       if ((mac_a2accu_pvld) == 1'b1) begin
           accu_pd <= mac_a2accu_pd;
       // VCS coverage off
       end else if ((mac_a2accu_pvld) == 1'b0) begin
       end else begin
           accu_pd <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////
///// generator input status signal                      /////
//////////////////////////////////////////////////////////////
wire accu_stripe_st = accu_pd[5];
wire accu_stripe_end = accu_pd[6];
wire accu_channel_end = accu_pd[7];
wire accu_layer_end = accu_pd[8];
wire is_int8 = (reg2dp_proc_precision == 2'h0);
wire is_winograd = 1'b0;
// SLCG
wire slcg_cell_en_w = reg2dp_op_en;
//: &eperl::flop(" -q  slcg_cell_en_d1  -d \"slcg_cell_en_w\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  slcg_cell_en_d2  -d \"slcg_cell_en_d1\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  slcg_cell_en_d3  -d \"slcg_cell_en_d2\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  slcg_cell_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_cell_en_d1 <= 'b0;
   end else begin
       slcg_cell_en_d1 <= slcg_cell_en_w;
   end
end
reg  slcg_cell_en_d2;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_cell_en_d2 <= 'b0;
   end else begin
       slcg_cell_en_d2 <= slcg_cell_en_d1;
   end
end
reg  slcg_cell_en_d3;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       slcg_cell_en_d3 <= 'b0;
   end else begin
       slcg_cell_en_d3 <= slcg_cell_en_d2;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire slcg_cell_en = slcg_cell_en_d3;
// get layer operation begin
wire wait_for_op_en_w = dp2reg_done ? 1'b1 : reg2dp_op_en ? 1'b0 : wait_for_op_en;
//: &eperl::flop(" -q  wait_for_op_en  -d \"wait_for_op_en_w\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  wait_for_op_en;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       wait_for_op_en <= 1;
   end else begin
       wait_for_op_en <= wait_for_op_en_w;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// get address and other contrl
reg cfg_winograd;
reg [3 +1 -1:0] accu_cnt;
wire [3 +1 -1:0] accu_cnt_w;
wire [3 +1 -1:0] accu_cnt_inc;
wire mon_accu_cnt_inc;
reg accu_channel_st;
wire layer_st = wait_for_op_en & reg2dp_op_en;
assign {mon_accu_cnt_inc, accu_cnt_inc} = accu_cnt + 1'b1;
assign accu_cnt_w = (layer_st | accu_stripe_end) ? {3 +1{1'b0}} : accu_cnt_inc;
wire [3 +1 -1:0] accu_addr = accu_cnt;
wire accu_channel_st_w = layer_st ? 1'b1 : (accu_valid & accu_stripe_end) ? accu_channel_end : accu_channel_st;
wire accu_rd_en = accu_valid & (~accu_channel_st);
wire cfg_in_en_mask_w = 1'b1;
//: &eperl::flop("-q accu_ram_valid -d accu_rd_en");
//: &eperl::flop("-nodeclare -q  accu_cnt  -en \"layer_st | accu_valid\" -d  \"accu_cnt_w\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop("-nodeclare -q  accu_channel_st  -en \"layer_st | accu_valid\" -d  \"accu_channel_st_w\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 1");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  accu_ram_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ram_valid <= 'b0;
   end else begin
       accu_ram_valid <= accu_rd_en;
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_cnt <= 'b0;
   end else begin
       if ((layer_st | accu_valid) == 1'b1) begin
           accu_cnt <= accu_cnt_w;
       // VCS coverage off
       end else if ((layer_st | accu_valid) == 1'b0) begin
       end else begin
           accu_cnt <= 'bx;
       // VCS coverage on
       end
   end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_channel_st <= 1;
   end else begin
       if ((layer_st | accu_valid) == 1'b1) begin
           accu_channel_st <= accu_channel_st_w;
       // VCS coverage off
       end else if ((layer_st | accu_valid) == 1'b0) begin
       end else begin
           accu_channel_st <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire accu_ctrl_valid_d0 = accu_valid;
wire accu_ram_valid_d0 = accu_ram_valid;
wire [3 +1 -1:0] accu_addr_d0 = accu_addr;
wire accu_stripe_end_d0 = accu_stripe_end;
wire accu_channel_end_d0 = accu_channel_end;
wire accu_layer_end_d0 = accu_layer_end;
//: &eperl::flop("-nodeclare -q  cfg_winograd  -en \"layer_st\" -d  \"is_winograd\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop("-wid 5 -q  cfg_truncate  -en \"layer_st\" -d  \"reg2dp_clip_truncate\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  cfg_is_wg  -en \"layer_st\" -d  \"is_winograd\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  cfg_in_en_mask  -en \"layer_st\" -d  \"cfg_in_en_mask_w\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cfg_winograd <= 'b0;
   end else begin
       if ((layer_st) == 1'b1) begin
           cfg_winograd <= is_winograd;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           cfg_winograd <= 'bx;
       // VCS coverage on
       end
   end
end
reg [4:0] cfg_truncate;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cfg_truncate <= 'b0;
   end else begin
       if ((layer_st) == 1'b1) begin
           cfg_truncate <= reg2dp_clip_truncate;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           cfg_truncate <= 'bx;
       // VCS coverage on
       end
   end
end
reg  cfg_is_wg;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cfg_is_wg <= 'b0;
   end else begin
       if ((layer_st) == 1'b1) begin
           cfg_is_wg <= is_winograd;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           cfg_is_wg <= 'bx;
       // VCS coverage on
       end
   end
end
reg  cfg_in_en_mask;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cfg_in_en_mask <= 'b0;
   end else begin
       if ((layer_st) == 1'b1) begin
           cfg_in_en_mask <= cfg_in_en_mask_w;
       // VCS coverage off
       end else if ((layer_st) == 1'b0) begin
       end else begin
           cfg_in_en_mask <= 'bx;
       // VCS coverage on
       end
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire abuf_rd_en = accu_rd_en;
wire [3 +1 -1:0] abuf_rd_addr = accu_addr;
// regout
//: my $kk=3 +1;
//: &eperl::flop(" -q  accu_ctrl_valid  -d \"accu_ctrl_valid_d0\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  accu_ctrl_ram_valid  -d \"accu_ram_valid_d0\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop("-wid ${kk} -q  accu_ctrl_addr  -en \"accu_ctrl_valid_d0\" -d  \"accu_addr_d0\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  accu_ctrl_stripe_end  -en \"accu_ctrl_valid_d0\" -d  \"accu_stripe_end_d0\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  accu_ctrl_channel_end  -en \"accu_ctrl_valid_d0\" -d  \"accu_channel_end_d0\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  accu_ctrl_layer_end  -en \"accu_ctrl_valid_d0\" -d  \"accu_layer_end_d0\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: &eperl::flop(" -q  accu_ctrl_dlv_elem_mask  -en \"accu_ctrl_valid_d0\" -d  \"accu_channel_end_d0\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//: my $jj=6-$kk;
//: if ($jj==0) {
//: print "assign       accu_ctrl_pd[5:0]  =     {accu_ctrl_addr}; \n";
//: }
//: elsif ($jj>0) {
//: print "assign       accu_ctrl_pd[5:0]  =     {{${jj}{1'b0}},accu_ctrl_addr}; \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  accu_ctrl_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ctrl_valid <= 'b0;
   end else begin
       accu_ctrl_valid <= accu_ctrl_valid_d0;
   end
end
reg  accu_ctrl_ram_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ctrl_ram_valid <= 'b0;
   end else begin
       accu_ctrl_ram_valid <= accu_ram_valid_d0;
   end
end
reg [3:0] accu_ctrl_addr;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ctrl_addr <= 'b0;
   end else begin
       if ((accu_ctrl_valid_d0) == 1'b1) begin
           accu_ctrl_addr <= accu_addr_d0;
       // VCS coverage off
       end else if ((accu_ctrl_valid_d0) == 1'b0) begin
       end else begin
           accu_ctrl_addr <= 'bx;
       // VCS coverage on
       end
   end
end
reg  accu_ctrl_stripe_end;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ctrl_stripe_end <= 'b0;
   end else begin
       if ((accu_ctrl_valid_d0) == 1'b1) begin
           accu_ctrl_stripe_end <= accu_stripe_end_d0;
       // VCS coverage off
       end else if ((accu_ctrl_valid_d0) == 1'b0) begin
       end else begin
           accu_ctrl_stripe_end <= 'bx;
       // VCS coverage on
       end
   end
end
reg  accu_ctrl_channel_end;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ctrl_channel_end <= 'b0;
   end else begin
       if ((accu_ctrl_valid_d0) == 1'b1) begin
           accu_ctrl_channel_end <= accu_channel_end_d0;
       // VCS coverage off
       end else if ((accu_ctrl_valid_d0) == 1'b0) begin
       end else begin
           accu_ctrl_channel_end <= 'bx;
       // VCS coverage on
       end
   end
end
reg  accu_ctrl_layer_end;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ctrl_layer_end <= 'b0;
   end else begin
       if ((accu_ctrl_valid_d0) == 1'b1) begin
           accu_ctrl_layer_end <= accu_layer_end_d0;
       // VCS coverage off
       end else if ((accu_ctrl_valid_d0) == 1'b0) begin
       end else begin
           accu_ctrl_layer_end <= 'bx;
       // VCS coverage on
       end
   end
end
reg  accu_ctrl_dlv_elem_mask;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu_ctrl_dlv_elem_mask <= 'b0;
   end else begin
       if ((accu_ctrl_valid_d0) == 1'b1) begin
           accu_ctrl_dlv_elem_mask <= accu_channel_end_d0;
       // VCS coverage off
       end else if ((accu_ctrl_valid_d0) == 1'b0) begin
       end else begin
           accu_ctrl_dlv_elem_mask <= 'bx;
       // VCS coverage on
       end
   end
end
assign       accu_ctrl_pd[5:0]  =     {{2{1'b0}},accu_ctrl_addr}; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.1.6
assign accu_ctrl_pd[8:6] = 3'b1; //reserve
assign accu_ctrl_pd[9] = accu_ctrl_stripe_end ;
assign accu_ctrl_pd[10] = accu_ctrl_channel_end ;
assign accu_ctrl_pd[11] = accu_ctrl_layer_end ;
assign accu_ctrl_pd[12] = accu_ctrl_dlv_elem_mask;
endmodule
