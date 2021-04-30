// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC_delivery_buffer.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC.h
module NV_NVDLA_CACC_delivery_buffer (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cacc2sdp_ready //|< i
  ,dbuf_rd_addr //|< i
  ,dbuf_rd_en //|< i
  ,dbuf_rd_layer_end //|< i
  ,dbuf_wr_addr //|< i
  ,dbuf_wr_data //|< i
  ,dbuf_wr_en //|< i
  ,pwrbus_ram_pd //|< i
  ,cacc2glb_done_intr_pd //|> o
  ,cacc2sdp_pd //|> o
  ,cacc2sdp_valid //|> o
  ,dbuf_rd_ready //|> o
  ,accu2sc_credit_size //|> o
  ,accu2sc_credit_vld //|> o
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input cacc2sdp_ready;
input [3 +1 -1:0] dbuf_rd_addr;
input dbuf_rd_en;
input dbuf_rd_layer_end;
input [3 +1 -1:0] dbuf_wr_addr;
input [32*8 -1:0] dbuf_wr_data;
input dbuf_wr_en;
input [31:0] pwrbus_ram_pd;
output [1:0] cacc2glb_done_intr_pd;
output [32*1 +2 -1:0] cacc2sdp_pd;
output cacc2sdp_valid;
output dbuf_rd_ready;
output [2:0] accu2sc_credit_size;
output accu2sc_credit_vld;
// Instance RAMs
wire [32*8 -1:0] dbuf_rd_data;
reg [(32*8)/(32*1)-1:0] data_left_mask;
wire dbuf_rd_en_new = ~(|data_left_mask) & dbuf_rd_en;
// spyglass disable_block NoWidthInBasedNum-ML
//: my $dep= 8*2;
//: my $wid= 32*8;
//: print qq(
//: nv_ram_rws_${dep}x${wid} u_accu_dbuf (
//: .clk (nvdla_core_clk) //|< i
//: ,.ra (dbuf_rd_addr) //|< r
//: ,.re (dbuf_rd_en_new) //|< r
//: ,.dout (dbuf_rd_data) //|> w
//: ,.wa (dbuf_wr_addr) //|< r
//: ,.we (dbuf_wr_en) //|< r
//: ,.di (dbuf_wr_data) //|< r
//: ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
//: );
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

nv_ram_rws_16x256 u_accu_dbuf (
.clk (nvdla_core_clk) //|< i
,.ra (dbuf_rd_addr) //|< r
,.re (dbuf_rd_en_new) //|< r
,.dout (dbuf_rd_data) //|> w
,.wa (dbuf_wr_addr) //|< r
,.we (dbuf_wr_en) //|< r
,.di (dbuf_wr_data) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//get signal for SDP
//: &eperl::flop("-q  dbuf_rd_valid  -d \"dbuf_rd_en_new\" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: my $kk=(32*8)/(32*1);
//: print qq(
//: reg [${kk}-1:0] rd_data_mask; //which data to be fetched by sdp.
//: wire [${kk}-1:0] rd_data_mask_pre; );
//: if(${kk}>=2){
//: print "assign rd_data_mask_pre = cacc2sdp_valid & cacc2sdp_ready ? {rd_data_mask[${kk}-2:0],rd_data_mask[${kk}-1]} : rd_data_mask; \n";
//: } else {
//: print "assign rd_data_mask_pre = rd_data_mask; \n";
//:}
//: &eperl::flop("-nodeclare -q rd_data_mask -d rd_data_mask_pre -rval \" 'b1\" ");
//: print qq(
//: wire [${kk}-1:0] data_left_mask_pre = dbuf_rd_en_new ? {${kk}{1'b1}} : (cacc2sdp_valid & cacc2sdp_ready) ? (data_left_mask<<1'b1) : data_left_mask;
//: );
//: &eperl::flop("-nodeclare -q data_left_mask   -d data_left_mask_pre ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  dbuf_rd_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbuf_rd_valid <= 'b0;
   end else begin
       dbuf_rd_valid <= dbuf_rd_en_new;
   end
end

reg [8-1:0] rd_data_mask; //which data to be fetched by sdp.
wire [8-1:0] rd_data_mask_pre; assign rd_data_mask_pre = cacc2sdp_valid & cacc2sdp_ready ? {rd_data_mask[8-2:0],rd_data_mask[8-1]} : rd_data_mask; 
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       rd_data_mask <=  'b1;
   end else begin
       rd_data_mask <= rd_data_mask_pre;
   end
end

wire [8-1:0] data_left_mask_pre = dbuf_rd_en_new ? {8{1'b1}} : (cacc2sdp_valid & cacc2sdp_ready) ? (data_left_mask<<1'b1) : data_left_mask;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       data_left_mask <= 'b0;
   end else begin
       data_left_mask <= data_left_mask_pre;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire cacc2sdp_valid = (|data_left_mask);
wire dbuf_rd_ready = ~(|data_left_mask);
//: my $t1="";
//: my $kk= 32*1;
//: print "wire [${kk}-1:0] cacc2sdp_pd_data= ";
//: for (my $i=0; $i<(32*8)/(32*1); $i++){
//: $t1 .= "dbuf_rd_data[($i+1)*${kk}-1:$i*${kk}]&{${kk}{rd_data_mask[${i}]}} |";
//: }
//: my $t2= "{${kk}{1'b0}}";
//: print "$t1"."$t2".";\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire [32-1:0] cacc2sdp_pd_data= dbuf_rd_data[(0+1)*32-1:0*32]&{32{rd_data_mask[0]}} |dbuf_rd_data[(1+1)*32-1:1*32]&{32{rd_data_mask[1]}} |dbuf_rd_data[(2+1)*32-1:2*32]&{32{rd_data_mask[2]}} |dbuf_rd_data[(3+1)*32-1:3*32]&{32{rd_data_mask[3]}} |dbuf_rd_data[(4+1)*32-1:4*32]&{32{rd_data_mask[4]}} |dbuf_rd_data[(5+1)*32-1:5*32]&{32{rd_data_mask[5]}} |dbuf_rd_data[(6+1)*32-1:6*32]&{32{rd_data_mask[6]}} |dbuf_rd_data[(7+1)*32-1:7*32]&{32{rd_data_mask[7]}} |{32{1'b0}};

//| eperl: generated_end (DO NOT EDIT ABOVE)
//layer_end handle
reg dbuf_rd_layer_end_latch;
wire dbuf_rd_layer_end_latch_w = dbuf_rd_layer_end? 1'b1 : ~(|data_left_mask) ? 1'b0 : dbuf_rd_layer_end_latch;
//: &eperl::flop("-q dbuf_rd_layer_end_latch -d dbuf_rd_layer_end_latch_w -nodeclare");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       dbuf_rd_layer_end_latch <= 'b0;
   end else begin
       dbuf_rd_layer_end_latch <= dbuf_rd_layer_end_latch_w;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////regout to SDP
////: my $kk=CACC_SDP_DATA_WIDTH;
////: &eperl::flop("-q cacc2sdp_valid -d cacc2sdp_valid_w");
////: &eperl::flop("-wid ${kk} -q cacc2sdp_pd_data -d cacc2sdp_pd_data_w");
wire last_data;
wire cacc2sdp_batch_end = 1'b0;
wire cacc2sdp_layer_end = dbuf_rd_layer_end_latch&last_data&cacc2sdp_valid&cacc2sdp_ready; //data_left_mask=0;
assign cacc2sdp_pd[32*1 -1:0] = cacc2sdp_pd_data;
assign cacc2sdp_pd[32*1 +2 -2] = cacc2sdp_batch_end;
assign cacc2sdp_pd[32*1 +2 -1] = cacc2sdp_layer_end;
// generate CACC done interrupt
wire [1:0] cacc_done_intr_w;
reg intr_sel;
wire cacc_done = cacc2sdp_valid & cacc2sdp_ready & cacc2sdp_layer_end;
assign cacc_done_intr_w[0] = cacc_done & ~intr_sel;
assign cacc_done_intr_w[1] = cacc_done & intr_sel;
wire intr_sel_w = cacc_done ? ~intr_sel : intr_sel;
//: &eperl::flop("-nodeclare -q  intr_sel  -d \"intr_sel_w \" -clk nvdla_core_clk -rst nvdla_core_rstn ");
//: &eperl::flop(" -q  cacc_done_intr  -d \"cacc_done_intr_w \" -wid 2  -clk nvdla_core_clk -rst nvdla_core_rstn ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       intr_sel <= 'b0;
   end else begin
       intr_sel <= intr_sel_w ;
   end
end
reg [1:0] cacc_done_intr;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cacc_done_intr <= 'b0;
   end else begin
       cacc_done_intr <= cacc_done_intr_w ;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign cacc2glb_done_intr_pd = cacc_done_intr;
///// generate credit signal
assign accu2sc_credit_size = 3'h1;
assign last_data = (data_left_mask=={1'b1,{(32*8)/(32*1)-1{1'b0}}});
//: &eperl::flop(" -q  accu2sc_credit_vld  -d \"cacc2sdp_valid & cacc2sdp_ready & last_data\" -clk nvdla_core_clk -rst nvdla_core_rstn -rval 0");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  accu2sc_credit_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       accu2sc_credit_vld <= 'b0;
   end else begin
       accu2sc_credit_vld <= cacc2sdp_valid & cacc2sdp_ready & last_data;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// spyglass enable_block NoWidthInBasedNum-ML
endmodule // NV_NVDLA_CACC_delivery_buffer
