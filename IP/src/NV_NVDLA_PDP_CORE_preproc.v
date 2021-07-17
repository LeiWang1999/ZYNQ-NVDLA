// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_PDP_CORE_preproc.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_PDP_define.h
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//#ifdef NVDLA_FEATURE_DATA_TYPE_INT8
//#if ( NVDLA_PDP_THROUGHPUT  ==  8 )
//    #define LARGE_FIFO_RAM
//#endif
//#if ( NVDLA_PDP_THROUGHPUT == 1 )
//    #define SMALL_FIFO_RAM
//#endif
//#endif
module NV_NVDLA_PDP_CORE_preproc (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pre2cal1d_prdy //|< i
  ,pwrbus_ram_pd //|< i
  ,reg2dp_cube_in_channel //|< i
  ,reg2dp_cube_in_height //|< i
  ,reg2dp_cube_in_width //|< i
  ,reg2dp_flying_mode //|< i
  ,reg2dp_op_en //|< i
  ,sdp2pdp_pd //|< i
  ,sdp2pdp_valid //|< i
  ,pre2cal1d_pd //|> o
  ,pre2cal1d_pvld //|> o
  ,sdp2pdp_ready //|> o
  );
/////////////////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
input pre2cal1d_prdy;
input [31:0] pwrbus_ram_pd;
input [12:0] reg2dp_cube_in_channel;
input [12:0] reg2dp_cube_in_height;
input [12:0] reg2dp_cube_in_width;
input reg2dp_flying_mode;
input reg2dp_op_en;
input [8*1 -1:0] sdp2pdp_pd;
input sdp2pdp_valid;
output [1*8 +13:0] pre2cal1d_pd;
output pre2cal1d_pvld;
output sdp2pdp_ready;
/////////////////////////////////////////////////////////////////
wire b_sync;
wire cube_end;
wire last_c;
wire layer_end;
wire line_end;
wire load_din;
wire onfly_en;
wire op_en_load;
wire [13:0] pre2cal1d_info;
wire pre2cal1d_pvld_f;
wire sdp2pdp_c_end;
wire sdp2pdp_cube_end;
wire sdp2pdp_en;
wire sdp2pdp_line_end;
wire sdp2pdp_ready_use;
wire sdp2pdp_surf_end;
wire sdp2pdp_valid_use;
wire split_end;
wire surf_end;
reg [12:0] line_cnt;
reg op_en_d1;
reg [4:0] pos_c;
reg [4:0] sdp2pdp_c_cnt;
wire sdp2pdp_en_sync;
reg [12:0] sdp2pdp_height_cnt;
wire [8*1 -1:0] sdp2pdp_pd_use;
//: my $atomicm = 8;
//: my $k = int( log($atomicm)/log(2) );
//: print "reg      [12-${k}:0] sdp2pdp_surf_cnt; \n";
//: print "reg      [12-${k}:0] surf_cnt; \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg      [12-3:0] sdp2pdp_surf_cnt; 
reg      [12-3:0] surf_cnt; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [12:0] sdp2pdp_width_cnt;
reg [12:0] w_cnt;
reg waiting_for_op_en;
/////////////////////////////////////////////////////////////////
//Data path pre process
//--------------------------------------------------------------
assign onfly_en = (reg2dp_flying_mode == 1'h0 );
////////////////////////////////////////////////////////////////
//assign load_din = (sdp2pdp_valid & sdp2pdp_ready_f & sdp2pdp_en);
//////////////////////////////
//sdp to pdp layer end info
//////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn)
    sdp2pdp_c_cnt <= 5'd0;
  else if(load_din) begin
    if(sdp2pdp_c_end)
        sdp2pdp_c_cnt <= 5'd0;
    else
        sdp2pdp_c_cnt <= sdp2pdp_c_cnt + 1'b1;
  end
end
//: my $sdpth = 1;
//: my $atomicm = 8;
//: my $k = int( $atomicm/$sdpth ) -1;
//: print qq(
//: assign sdp2pdp_c_end = (load_din & (sdp2pdp_c_cnt == 5'd${k}));
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign sdp2pdp_c_end = (load_din & (sdp2pdp_c_cnt == 5'd7));

//| eperl: generated_end (DO NOT EDIT ABOVE)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    sdp2pdp_width_cnt <= {13{1'b0}};
  end else begin
    if(sdp2pdp_c_end) begin
        if(sdp2pdp_line_end)
            sdp2pdp_width_cnt <= 13'd0;
        else
            sdp2pdp_width_cnt <= sdp2pdp_width_cnt + 1'b1;
    end
  end
end
assign sdp2pdp_line_end = sdp2pdp_c_end & (sdp2pdp_width_cnt == reg2dp_cube_in_width[12:0]);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    sdp2pdp_height_cnt <= {13{1'b0}};
  end else begin
    if(sdp2pdp_line_end) begin
        if(sdp2pdp_surf_end)
            sdp2pdp_height_cnt <= 13'd0;
        else
            sdp2pdp_height_cnt <= sdp2pdp_height_cnt + 1'b1;
    end
  end
end
assign sdp2pdp_surf_end = sdp2pdp_line_end & (sdp2pdp_height_cnt == reg2dp_cube_in_height[12:0]);
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    sdp2pdp_surf_cnt <= 0;
  end else begin
    if(sdp2pdp_surf_end) begin
        if(sdp2pdp_cube_end)
            sdp2pdp_surf_cnt <= 0;
        else
            sdp2pdp_surf_cnt <= sdp2pdp_surf_cnt + 1'b1;
    end
  end
end
//: my $atomicm = 8;
//: my $k = int( log($atomicm)/log(2) );
//: print qq(
//: assign sdp2pdp_cube_end = sdp2pdp_surf_end & (sdp2pdp_surf_cnt == reg2dp_cube_in_channel[12:${k}]);
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign sdp2pdp_cube_end = sdp2pdp_surf_end & (sdp2pdp_surf_cnt == reg2dp_cube_in_channel[12:3]);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//////////////////////////////////////////////////////////////////////
//waiting for op_en
//////////////////////////////////////////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    op_en_d1 <= 1'b0;
  end else begin
  op_en_d1 <= reg2dp_op_en;
  end
end
assign op_en_load = reg2dp_op_en & (~op_en_d1);
assign layer_end = sdp2pdp_cube_end;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    waiting_for_op_en <= 1'b1;
  end else begin
    if(layer_end & onfly_en)
        waiting_for_op_en <= 1'b1;
    else if(op_en_load) begin
        if(~onfly_en)
            waiting_for_op_en <= 1'b1;
        else if(onfly_en)
            waiting_for_op_en <= 1'b0;
    end
  end
end
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
    property SDP_NewLayer_out_req_And_core_CurLayer_not_finish__0_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        waiting_for_op_en & sdp2pdp_valid;
    endproperty
// Cover 0 : "waiting_for_op_en & sdp2pdp_valid"
    FUNCPOINT_SDP_NewLayer_out_req_And_core_CurLayer_not_finish__0_COV : cover property (SDP_NewLayer_out_req_And_core_CurLayer_not_finish__0_cov);
  `endif
`endif
//VCS coverage on
///////////////////////////
assign sdp2pdp_en = (onfly_en & (~waiting_for_op_en));
//assign sdp2pdp_ready = sdp2pdp_ready_f & sdp2pdp_en;
wire [8*1:0] pipe0_i;
assign pipe0_i = {sdp2pdp_pd,sdp2pdp_en};
//: my $k = 8*1 + 1;
//: &eperl::pipe(" -is -wid $k -do pipe0_o -vo sdp2pdp_valid_use_f -ri sdp2pdp_ready_use -di pipe0_i -vi sdp2pdp_valid -ro sdp2pdp_ready_f   ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg sdp2pdp_ready_f;
reg skid_flop_sdp2pdp_ready_f;
reg skid_flop_sdp2pdp_valid;
reg [9-1:0] skid_flop_pipe0_i;
reg pipe_skid_sdp2pdp_valid;
reg [9-1:0] pipe_skid_pipe0_i;
// Wire
wire skid_sdp2pdp_valid;
wire [9-1:0] skid_pipe0_i;
wire skid_sdp2pdp_ready_f;
wire pipe_skid_sdp2pdp_ready_f;
wire sdp2pdp_valid_use_f;
wire [9-1:0] pipe0_o;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       sdp2pdp_ready_f <= 1'b1;
       skid_flop_sdp2pdp_ready_f <= 1'b1;
   end else begin
       sdp2pdp_ready_f <= skid_sdp2pdp_ready_f;
       skid_flop_sdp2pdp_ready_f <= skid_sdp2pdp_ready_f;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_sdp2pdp_valid <= 1'b0;
    end else begin
        if (skid_flop_sdp2pdp_ready_f) begin
            skid_flop_sdp2pdp_valid <= sdp2pdp_valid;
        end
   end
end
assign skid_sdp2pdp_valid = (skid_flop_sdp2pdp_ready_f) ? sdp2pdp_valid : skid_flop_sdp2pdp_valid;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_sdp2pdp_ready_f & sdp2pdp_valid) begin
        skid_flop_pipe0_i[9-1:0] <= pipe0_i[9-1:0];
    end
end
assign skid_pipe0_i[9-1:0] = (skid_flop_sdp2pdp_ready_f) ? pipe0_i[9-1:0] : skid_flop_pipe0_i[9-1:0];


// PIPE READY
assign skid_sdp2pdp_ready_f = pipe_skid_sdp2pdp_ready_f || !pipe_skid_sdp2pdp_valid;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_sdp2pdp_valid <= 1'b0;
    end else begin
        if (skid_sdp2pdp_ready_f) begin
            pipe_skid_sdp2pdp_valid <= skid_sdp2pdp_valid;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_sdp2pdp_ready_f && skid_sdp2pdp_valid) begin
        pipe_skid_pipe0_i[9-1:0] <= skid_pipe0_i[9-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_sdp2pdp_ready_f = sdp2pdp_ready_use;
assign sdp2pdp_valid_use_f = pipe_skid_sdp2pdp_valid;
assign pipe0_o = pipe_skid_pipe0_i;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign {sdp2pdp_pd_use,sdp2pdp_en_sync} = pipe0_o;
////
assign load_din = (sdp2pdp_valid & sdp2pdp_ready_f & sdp2pdp_en);
assign sdp2pdp_ready = sdp2pdp_ready_f & sdp2pdp_en;
////
assign sdp2pdp_valid_use = sdp2pdp_valid_use_f & sdp2pdp_en_sync;
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
//: my $sdpth = 1;
//: my $pdpth = 1;
//: my $sdpbw = $sdpth * 8;
//: my $pdpbw = $pdpth * 8;
//: if($sdpth > $pdpth) {
//: my $k = int($sdpth/$pdpth);
//: my $selbw = int(log(${k})/log(2));
//: my $ks = ${k}-1;
//: print "reg      [${pdpbw}-1:0] pre2cal1d_data; \n";
//: print "reg      [$selbw-1:0] fifo_sel_cnt; \n";
//: print "wire     [${k}-1:0] ro_rd_rdy; \n";
//: print "wire     [${k}-1:0] ro_rd_vld; \n";
//: print "wire     [${k}-1:0] ro_wr_rdy; \n";
//: print "wire     [${k}-1:0] ro_wr_vld; \n";
//: print "assign sdp2pdp_ready_use = &ro_wr_rdy; \n";
//: foreach my $i (0..$k-1){
//: print "wire    [${pdpbw}-1:0] ro_rd_pd_$i;  \n";
//: print "wire    [${pdpbw}-1:0] ro_wr_pd_$i;  \n";
//: print "assign ro_wr_vld[$i] = sdp2pdp_valid_use ";
//: foreach my $j (0..$k-1){
//: if($i != $j) {
//: print " & ro_wr_rdy[$j] ";
//: }
//: }
//: print "; \n";
//: print qq(
//: assign ro_wr_pd_$i = sdp2pdp_pd_use[${pdpbw}*${i}+${pdpbw}-1:${pdpbw}*${i}];
//: NV_NVDLA_PDP_SDPIN_ro_fifo_4x${pdpbw} u_ro_fifo_${i} (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.ro_wr_prdy (ro_wr_rdy[$i])
//: ,.ro_wr_pvld (ro_wr_vld[$i])
//: ,.ro_wr_pd (ro_wr_pd_${i})
//: ,.ro_rd_prdy (ro_rd_rdy[$i])
//: ,.ro_rd_pvld (ro_rd_vld[$i])
//: ,.ro_rd_pd (ro_rd_pd_${i})
//: ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
//: );
//: assign ro_rd_rdy[$i] = pre2cal1d_prdy & (fifo_sel_cnt == $i);
//: );
//: }
//: print qq(
//: assign pre2cal1d_pvld_f = |ro_rd_vld;
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn) begin
//: fifo_sel_cnt <= 0;
//: end else begin
//: if(pre2cal1d_pvld_f) begin
//: if(pre2cal1d_prdy) begin
//: if(fifo_sel_cnt == ${selbw}'d${ks})
//: fifo_sel_cnt <= 0;
//: else
//: fifo_sel_cnt <= fifo_sel_cnt + 1'b1;
//: end
//: end
//: end
//: end
//: always @(*) begin
//: case(fifo_sel_cnt)
//: );
//: foreach my $i (0..$k-1){
//: print "${selbw}'d${i}: pre2cal1d_data = ro_rd_pd_$i;  \n";
//: }
//: print qq(
//: default: pre2cal1d_data = ${pdpbw}'d0;
//: endcase
//: end
//: assign pre2cal1d_pvld = pre2cal1d_pvld_f;
//: );
//: }
//: elsif($sdpth < $pdpth) {
//: my $k = int($pdpth/$sdpth);
//: my $selbw = int(log(${k})/log(2));
//: print qq(
//: reg [$selbw-1:0] input_sel_cnt;
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn)
//: input_sel_cnt <= 0;
//: else if(sdp2pdp_valid_use & sdp2pdp_ready_use) begin
//: if(input_sel_cnt == (${k}-1))
//: input_sel_cnt <= 0;
//: else
//: input_sel_cnt <= input_sel_cnt + 1'b1;
//: end
//: end
//: );
//:
//: foreach my $i (0..$k-1) {
//: print qq(
//: reg [$sdpbw-1:0] sdp2pdp_dp_$i;
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn)
//: sdp2pdp_dp_$i <= 0;
//: else if((sdp2pdp_valid_use & sdp2pdp_ready_use) & (input_sel_cnt == $i))
//: sdp2pdp_dp_$i <= sdp2pdp_pd_use;
//: end
//: );
//: }
//:
//: print qq(
//: reg [${pdpbw}-1:0] pre2cal1d_data;
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn)
//: pre2cal1d_data <= ${pdpbw}'d0;
//: else if((sdp2pdp_valid_use & sdp2pdp_ready_use) & (input_sel_cnt == ${k}-1))
//: pre2cal1d_data <= {
//: );
//: if($k > 1) {
//: foreach my $i(0..$k-2){
//: my $j = $k -$i -1;
//: print " sdp2pdp_dp_$j,  ";
//: }
//: }
//: print qq(
//: sdp2pdp_dp_0};
//: end
//: );
//:
//: print qq(
//: reg sdp2pdp_vld_f;
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn)
//: sdp2pdp_vld_f <= 1'b0;
//: else if((sdp2pdp_valid_use & sdp2pdp_ready_use) & (input_sel_cnt == ${k}-1))
//: sdp2pdp_vld_f <= 1'b1;
//: else if(pre2cal1d_prdy)
//: sdp2pdp_vld_f <= 1'b0;
//: end
//: assign pre2cal1d_pvld = sdp2pdp_vld_f;
//: );
//: }
//: elsif($sdpth == $pdpth) {
//: print qq(
//: wire [${pdpbw}-1:0] pre2cal1d_data;
//: assign sdp2pdp_ready_use = pre2cal1d_prdy;
//: assign pre2cal1d_pvld = sdp2pdp_valid_use;
//: assign pre2cal1d_data = sdp2pdp_pd_use;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [8-1:0] pre2cal1d_data;
assign sdp2pdp_ready_use = pre2cal1d_prdy;
assign pre2cal1d_pvld = sdp2pdp_valid_use;
assign pre2cal1d_data = sdp2pdp_pd_use;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//==============================================================
//Data info path pre process
//--------------------------------------------------------------
wire pre2cal1d_load;
assign pre2cal1d_load = pre2cal1d_pvld & pre2cal1d_prdy;
//pos_c, 8B data position within 32B
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    pos_c <= 0;
  end else begin
    if(pre2cal1d_load) begin
        if(last_c)
            pos_c <= 0;
        else
            pos_c <= pos_c + 1'b1;
    end
  end
end
//: my $pdpth = 1;
//: my $atomicm = 8;
//: my $k = int( $atomicm/$pdpth ) -1;
//: print qq(
//: assign last_c = pre2cal1d_load & (pos_c == 5'd${k});
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign last_c = pre2cal1d_load & (pos_c == 5'd7);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//width direction
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    w_cnt[12:0] <= {13{1'b0}};
  end else begin
    if(last_c) begin
        if(line_end)
            w_cnt[12:0] <= 13'd0;
        else
            w_cnt[12:0] <= w_cnt[12:0] + 1'b1;
    end
  end
end
assign line_end = last_c & (w_cnt[12:0] == reg2dp_cube_in_width[12:0]);
//height direction
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    line_cnt[12:0] <= {13{1'b0}};
  end else begin
    if(line_end) begin
        if(surf_end)
            line_cnt[12:0] <= 13'd0;
        else
            line_cnt[12:0] <= line_cnt[12:0] + 1'b1;
    end
  end
end
assign surf_end = line_end & (line_cnt[12:0] == reg2dp_cube_in_height[12:0]);
//surface/Channel direction
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    surf_cnt <= 0;
  end else begin
    if(surf_end) begin
        if(split_end)
            surf_cnt <= 0;
        else
            surf_cnt <= surf_cnt + 1'b1;
    end
  end
end
//: my $atomicm = 8;
//: my $k = int( log($atomicm)/log(2) );
//: print qq(
//: assign split_end = surf_end & (surf_cnt == reg2dp_cube_in_channel[12:${k}]);
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign split_end = surf_end & (surf_cnt == reg2dp_cube_in_channel[12:3]);

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign cube_end = split_end ;
assign b_sync = line_end;
assign pre2cal1d_info = {cube_end,split_end,surf_end,line_end,b_sync,pos_c[4:0],4'd0};
assign pre2cal1d_pd = {pre2cal1d_info,pre2cal1d_data};
////////////////////////////
////////////////////////////
endmodule // NV_NVDLA_PDP_CORE_preproc
//
// AUTOMATICALLY GENERATED -- DO NOT EDIT OR CHECK IN
//
// /home/nvtools/engr/2017/03/11_05_00_06/nvtools/scripts/fifogen
// fifogen -input_config_yaml ../../../../../../../socd/ip_chip_tools/1.0/defs/public/fifogen/golden/tlit5/fifogen.yml -no_make_ram -no_make_ram -stdout -m NV_NVDLA_PDP_SDPIN_ro_fifo -clk_name nvdla_core_clk -reset_name nvdla_core_rstn -wr_pipebus ro_wr -rd_pipebus ro_rd -rd_reg -rand_none -ram_bypass -d 4 -w 64 -ram ff [Chosen ram type: ff - fifogen_flops (user specified, thus no other ram type is allowed)]
// chip config vars: assertion_module_prefix=nv_ strict_synchronizers=1 strict_synchronizers_use_lib_cells=1 strict_synchronizers_use_tm_lib_cells=1 strict_sync_randomizer=1 assertion_message_prefix=FIFOGEN_ASSERTION allow_async_fifola=0 ignore_ramgen_fifola_variant=1 uses_p_SSYNC=0 uses_prand=1 uses_rammake_inc=1 use_x_or_0=1 force_wr_reg_gated=1 no_force_reset=1 no_timescale=1 no_pli_ifdef=1 requires_full_throughput=1 ram_auto_ff_bits_cutoff=16 ram_auto_ff_width_cutoff=2 ram_auto_ff_width_cutoff_max_depth=32 ram_auto_ff_depth_cutoff=-1 ram_auto_ff_no_la2_depth_cutoff=5 ram_auto_la2_width_cutoff=8 ram_auto_la2_width_cutoff_max_depth=56 ram_auto_la2_depth_cutoff=16 flopram_emu_model=1 dslp_single_clamp_port=1 dslp_clamp_port=1 slp_single_clamp_port=1 slp_clamp_port=1 master_clk_gated=1 clk_gate_module=NV_CLK_gate_power redundant_timing_flops=0 hot_reset_async_force_ports_and_loopback=1 ram_sleep_en_width=1 async_cdc_reg_id=NV_AFIFO_ rd_reg_default_for_async=1 async_ram_instance_prefix=NV_ASYNC_RAM_ allow_rd_busy_reg_warning=0 do_dft_xelim_gating=1 add_dft_xelim_wr_clkgate=1 add_dft_xelim_rd_clkgate=1
//
// leda B_3208_NV OFF -- Unequal length LHS and RHS in assignment
// leda B_1405 OFF -- 2 asynchronous resets in this unit detected
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
