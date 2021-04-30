// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC_assembly_buffer.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CACC.h
module NV_NVDLA_CACC_assembly_buffer (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,abuf_rd_addr //|< i
  ,abuf_rd_en //|< i
  ,abuf_wr_addr //|< i
  ,abuf_wr_data //|< i
  ,abuf_wr_en //|< i
  ,pwrbus_ram_pd //|< i
  ,abuf_rd_data //|> o
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [3 +1 -1:0] abuf_rd_addr;
input abuf_rd_en;
input [3 +1 -1:0] abuf_wr_addr;
input [34*8 -1:0] abuf_wr_data;
input abuf_wr_en;
input [31:0] pwrbus_ram_pd;
output [34*8 -1:0] abuf_rd_data;
// spyglass disable_block NoWidthInBasedNum-ML
// instance SRAM
wire [34*8 -1:0] abuf_rd_data_ecc;
wire [3 +1 -1:0] abuf_rd_addr;
//: my $dep= 8*2;
//: my $wid= 34*8;
//: print qq(
//: nv_ram_rws_${dep}x${wid} u_accu_abuf_0 (
//: .clk (nvdla_core_clk) //|< i
//: ,.ra (abuf_rd_addr) //|< i
//: ,.re (abuf_rd_en) //|< i
//: ,.dout (abuf_rd_data_ecc) //|> w
//: ,.wa (abuf_wr_addr) //|< r
//: ,.we (abuf_wr_en) //|< r
//: ,.di (abuf_wr_data) //|< r
//: ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
//: );
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

nv_ram_rws_16x272 u_accu_abuf_0 (
.clk (nvdla_core_clk) //|< i
,.ra (abuf_rd_addr) //|< i
,.re (abuf_rd_en) //|< i
,.dout (abuf_rd_data_ecc) //|> w
,.wa (abuf_wr_addr) //|< r
,.we (abuf_wr_en) //|< r
,.di (abuf_wr_data) //|< r
,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
// 1 pipe for sram read data.
//: &eperl::flop("-q abuf_rd_en_d1 -d \"abuf_rd_en\" -clk nvdla_core_clk -rst nvdla_core_rstn");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  abuf_rd_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       abuf_rd_en_d1 <= 'b0;
   end else begin
       abuf_rd_en_d1 <= abuf_rd_en;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [34*8 -1:0] abuf_rd_raw_data = abuf_rd_data_ecc;
// spygalss disable_block STARC-2.10.1.6
// spyglass disable_block STARC05-3.3.1.4b
//: my $kk=34*8;
//: &eperl::flop("-wid ${kk} -norst -q abuf_rd_raw_data_d1 -en \"abuf_rd_en_d1\" -d \"abuf_rd_raw_data\" -clk nvdla_core_clk");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg [271:0] abuf_rd_raw_data_d1;
always @(posedge nvdla_core_clk) begin
       if ((abuf_rd_en_d1) == 1'b1) begin
           abuf_rd_raw_data_d1 <= abuf_rd_raw_data;
       // VCS coverage off
       end else if ((abuf_rd_en_d1) == 1'b0) begin
       end else begin
           abuf_rd_raw_data_d1 <= 'bx;
       // VCS coverage on
       end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.1.6
// spyglass enable_block STARC05-3.3.1.4b
assign abuf_rd_data = abuf_rd_raw_data_d1;
endmodule // NV_NVDLA_CACC_assembly_buffer
