// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CFGROM_rom.v
// Register NVDLA_CFGROM_CFGROM_HW_VERSION_0
// Register NVDLA_CFGROM_CFGROM_GLB_DESC_0
// Register NVDLA_CFGROM_CFGROM_CIF_DESC_0
// Register NVDLA_CFGROM_CFGROM_CIF_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CIF_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CIF_BASE_WIDTH_0
// Register NVDLA_CFGROM_CFGROM_CIF_BASE_LATENCY_0
// Register NVDLA_CFGROM_CFGROM_CIF_BASE_BURST_LENGTH_MAX_0
// Register NVDLA_CFGROM_CFGROM_CIF_BASE_MEM_ADDR_WIDTH_0
// Register NVDLA_CFGROM_CFGROM_CDMA_DESC_0
// Register NVDLA_CFGROM_CFGROM_CDMA_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CDMA_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CDMA_BASE_FEATURE_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CDMA_BASE_WEIGHT_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CDMA_BASE_ATOMIC_C_0
// Register NVDLA_CFGROM_CFGROM_CDMA_BASE_ATOMIC_K_0
// Register NVDLA_CFGROM_CFGROM_CDMA_BASE_ATOMIC_M_0
// Register NVDLA_CFGROM_CFGROM_CDMA_BASE_CBUF_BANK_NUM_0
// Register NVDLA_CFGROM_CFGROM_CDMA_BASE_CBUF_BANK_WIDTH_0
// Register NVDLA_CFGROM_CFGROM_CDMA_BASE_CBUF_BANK_DEPTH_0
// Register NVDLA_CFGROM_CFGROM_CDMA_MULTI_BATCH_MAX_0
// Register NVDLA_CFGROM_CFGROM_CDMA_IMAGE_IN_FORMATS_PACKED_0
// Register NVDLA_CFGROM_CFGROM_CDMA_IMAGE_IN_FORMATS_SEMI_0
// Register NVDLA_CFGROM_CFGROM_CBUF_DESC_0
// Register NVDLA_CFGROM_CFGROM_CBUF_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CBUF_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CBUF_BASE_CBUF_BANK_NUM_0
// Register NVDLA_CFGROM_CFGROM_CBUF_BASE_CBUF_BANK_WIDTH_0
// Register NVDLA_CFGROM_CFGROM_CBUF_BASE_CBUF_BANK_DEPTH_0
// Register NVDLA_CFGROM_CFGROM_CBUF_BASE_CDMA_ID_0
// Register NVDLA_CFGROM_CFGROM_CSC_DESC_0
// Register NVDLA_CFGROM_CFGROM_CSC_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CSC_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_FEATURE_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_WEIGHT_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_ATOMIC_C_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_ATOMIC_K_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_ATOMIC_M_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_CBUF_BANK_NUM_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_CBUF_BANK_WIDTH_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_CBUF_BANK_DEPTH_0
// Register NVDLA_CFGROM_CFGROM_CSC_BASE_CDMA_ID_0
// Register NVDLA_CFGROM_CFGROM_CSC_MULTI_BATCH_MAX_0
// Register NVDLA_CFGROM_CFGROM_CMAC_A_DESC_0
// Register NVDLA_CFGROM_CFGROM_CMAC_A_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CMAC_A_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CMAC_A_BASE_FEATURE_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CMAC_A_BASE_WEIGHT_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CMAC_A_BASE_ATOMIC_C_0
// Register NVDLA_CFGROM_CFGROM_CMAC_A_BASE_ATOMIC_K_0
// Register NVDLA_CFGROM_CFGROM_CMAC_A_BASE_CDMA_ID_0
// Register NVDLA_CFGROM_CFGROM_CMAC_B_DESC_0
// Register NVDLA_CFGROM_CFGROM_CMAC_B_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CMAC_B_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CMAC_B_BASE_FEATURE_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CMAC_B_BASE_WEIGHT_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CMAC_B_BASE_ATOMIC_C_0
// Register NVDLA_CFGROM_CFGROM_CMAC_B_BASE_ATOMIC_K_0
// Register NVDLA_CFGROM_CFGROM_CMAC_B_BASE_CDMA_ID_0
// Register NVDLA_CFGROM_CFGROM_CACC_DESC_0
// Register NVDLA_CFGROM_CFGROM_CACC_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CACC_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CACC_BASE_FEATURE_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CACC_BASE_WEIGHT_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CACC_BASE_ATOMIC_C_0
// Register NVDLA_CFGROM_CFGROM_CACC_BASE_ATOMIC_K_0
// Register NVDLA_CFGROM_CFGROM_CACC_BASE_CDMA_ID_0
// Register NVDLA_CFGROM_CFGROM_CACC_MULTI_BATCH_MAX_0
// Register NVDLA_CFGROM_CFGROM_SDP_RDMA_DESC_0
// Register NVDLA_CFGROM_CFGROM_SDP_RDMA_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_SDP_RDMA_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_SDP_RDMA_BASE_ATOMIC_M_0
// Register NVDLA_CFGROM_CFGROM_SDP_RDMA_BASE_SDP_ID_0
// Register NVDLA_CFGROM_CFGROM_SDP_DESC_0
// Register NVDLA_CFGROM_CFGROM_SDP_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_SDP_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_SDP_BASE_FEATURE_TYPES_0
// Register NVDLA_CFGROM_CFGROM_SDP_BASE_WEIGHT_TYPES_0
// Register NVDLA_CFGROM_CFGROM_SDP_BASE_CDMA_ID_0
// Register NVDLA_CFGROM_CFGROM_SDP_MULTI_BATCH_MAX_0
// Register NVDLA_CFGROM_CFGROM_SDP_BS_THROUGHPUT_0
// Register NVDLA_CFGROM_CFGROM_SDP_BN_THROUGHPUT_0
// Register NVDLA_CFGROM_CFGROM_SDP_EW_THROUGHPUT_0
// Register NVDLA_CFGROM_CFGROM_PDP_RDMA_DESC_0
// Register NVDLA_CFGROM_CFGROM_PDP_RDMA_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_PDP_RDMA_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_PDP_RDMA_BASE_ATOMIC_M_0
// Register NVDLA_CFGROM_CFGROM_PDP_RDMA_BASE_PDP_ID_0
// Register NVDLA_CFGROM_CFGROM_PDP_DESC_0
// Register NVDLA_CFGROM_CFGROM_PDP_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_PDP_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_PDP_BASE_FEATURE_TYPES_0
// Register NVDLA_CFGROM_CFGROM_PDP_BASE_THROUGHPUT_0
// Register NVDLA_CFGROM_CFGROM_CDP_RDMA_DESC_0
// Register NVDLA_CFGROM_CFGROM_CDP_RDMA_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CDP_RDMA_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CDP_RDMA_BASE_ATOMIC_M_0
// Register NVDLA_CFGROM_CFGROM_CDP_RDMA_BASE_CDP_ID_0
// Register NVDLA_CFGROM_CFGROM_CDP_DESC_0
// Register NVDLA_CFGROM_CFGROM_CDP_CAP_INCOMPAT_0
// Register NVDLA_CFGROM_CFGROM_CDP_CAP_COMPAT_0
// Register NVDLA_CFGROM_CFGROM_CDP_BASE_FEATURE_TYPES_0
// Register NVDLA_CFGROM_CFGROM_CDP_BASE_THROUGHPUT_0
// Register NVDLA_CFGROM_CFGROM_END_OF_LIST_0
//
// ADDRESS SPACES
//
module NV_NVDLA_CFGROM_rom (
   reg_rd_data
  ,reg_offset
// verilint 498 off
// leda UNUSED_DEC off
  ,reg_wr_data
// verilint 498 on
// leda UNUSED_DEC on
  ,reg_wr_en
  ,nvdla_core_clk
  ,nvdla_core_rstn
  );
output [31:0] reg_rd_data;
input [11:0] reg_offset;
input [31:0] reg_wr_data; //(UNUSED_DEC)
input reg_wr_en;
input nvdla_core_clk;
input nvdla_core_rstn;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// leda FM_2_23 off
//reg arreggen_abort_on_invalid_wr;
//reg arreggen_abort_on_rowr;
//reg arreggen_dump;
//// leda FM_2_23 on
reg [31:0] reg_rd_data;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @(*) begin
  case (reg_offset)
     (32'h0 & 32'h00000fff): reg_rd_data = 32'h10001 ;
     (32'h4 & 32'h00000fff): reg_rd_data = 32'h1 ;
     (32'h8 & 32'h00000fff): reg_rd_data = 32'h180002 ;
     (32'hc & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h10 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h14 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h18 & 32'h00000fff): reg_rd_data = 32'h32 ;
     (32'h1c & 32'h00000fff): reg_rd_data = 32'h80 ;
     (32'h20 & 32'h00000fff): reg_rd_data = 32'h400 ;
     (32'h24 & 32'h00000fff): reg_rd_data = 32'h340003 ;
     (32'h28 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h2c & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h30 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h34 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h38 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h3c & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h40 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h44 & 32'h00000fff): reg_rd_data = 32'h20 ;
     (32'h48 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h4c & 32'h00000fff): reg_rd_data = 32'h200 ;
     (32'h50 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h54 & 32'h00000fff): reg_rd_data = 32'hcfff001 ;
     (32'h58 & 32'h00000fff): reg_rd_data = 32'h3 ;
     (32'h5c & 32'h00000fff): reg_rd_data = 32'h180004 ;
     (32'h60 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h64 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h68 & 32'h00000fff): reg_rd_data = 32'h20 ;
     (32'h6c & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h70 & 32'h00000fff): reg_rd_data = 32'h200 ;
     (32'h74 & 32'h00000fff): reg_rd_data = 32'h3 ;
     (32'h78 & 32'h00000fff): reg_rd_data = 32'h300005 ;
     (32'h7c & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h80 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h84 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h88 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h8c & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h90 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h94 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h98 & 32'h00000fff): reg_rd_data = 32'h20 ;
     (32'h9c & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'ha0 & 32'h00000fff): reg_rd_data = 32'h200 ;
     (32'ha4 & 32'h00000fff): reg_rd_data = 32'h3 ;
     (32'ha8 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'hac & 32'h00000fff): reg_rd_data = 32'h1c0006 ;
     (32'hb0 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'hb4 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'hb8 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'hbc & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'hc0 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'hc4 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'hc8 & 32'h00000fff): reg_rd_data = 32'h3 ;
     (32'hcc & 32'h00000fff): reg_rd_data = 32'h1c0006 ;
     (32'hd0 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'hd4 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'hd8 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'hdc & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'he0 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'he4 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'he8 & 32'h00000fff): reg_rd_data = 32'h3 ;
     (32'hec & 32'h00000fff): reg_rd_data = 32'h200007 ;
     (32'hf0 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'hf4 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'hf8 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'hfc & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h100 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h104 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h108 & 32'h00000fff): reg_rd_data = 32'h3 ;
     (32'h10c & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h110 & 32'h00000fff): reg_rd_data = 32'he0008 ;
     (32'h114 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h118 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h11c & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h120 & 32'h00000fff): reg_rd_data = 32'h9 ;
     (32'h124 & 32'h00000fff): reg_rd_data = 32'h200009 ;
     (32'h128 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h12c & 32'h00000fff): reg_rd_data = 32'h18 ;
     (32'h130 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h134 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h138 & 32'h00000fff): reg_rd_data = 32'h3 ;
     (32'h13c & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h140 & 32'h00000fff): reg_rd_data = 32'h1 ;
     (32'h144 & 32'h00000fff): reg_rd_data = 32'h1 ;
     (32'h148 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h14c & 32'h00000fff): reg_rd_data = 32'he000a ;
     (32'h150 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h154 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h158 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h15c & 32'h00000fff): reg_rd_data = 32'hb ;
     (32'h160 & 32'h00000fff): reg_rd_data = 32'h10000b ;
     (32'h164 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h168 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h16c & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h170 & 32'h00000fff): reg_rd_data = 32'h1 ;
     (32'h174 & 32'h00000fff): reg_rd_data = 32'he000c ;
     (32'h178 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h17c & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h180 & 32'h00000fff): reg_rd_data = 32'h8 ;
     (32'h184 & 32'h00000fff): reg_rd_data = 32'hd ;
     (32'h188 & 32'h00000fff): reg_rd_data = 32'h10000d ;
     (32'h18c & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h190 & 32'h00000fff): reg_rd_data = 32'h0 ;
     (32'h194 & 32'h00000fff): reg_rd_data = 32'h10 ;
     (32'h198 & 32'h00000fff): reg_rd_data = 32'h1 ;
     (32'h19c & 32'h00000fff): reg_rd_data = 32'h0 ;
    default: reg_rd_data = {32{1'b0}};
  endcase
end
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// VCS coverage off
//initial begin
// arreggen_dump = $test$plusargs("arreggen_dump_wr");
// arreggen_abort_on_rowr = $test$plusargs("arreggen_abort_on_rowr");
// arreggen_abort_on_invalid_wr = $test$plusargs("arreggen_abort_on_invalid_wr");
// $timeformat(-9, 2, "ns", 15);
//end
//
//always @(posedge nvdla_core_clk) begin
// if (reg_wr_en) begin
// case(reg_offset)
// (32'h088 & 32'h00000fff): begin
// if (arreggen_dump) $display("%t:%m: read-only reg wr: NVDLA_PDP_D_INF_INPUT_NUM_0 = 0x%h", $time, reg_wr_data);
// if (arreggen_abort_on_rowr) begin $display("ERROR: write to read-only register!"); $finish; end
// end
// default: begin
// if (arreggen_dump) $display("%t:%m: reg wr: Unknown register (0x%h) = 0x%h", $time, reg_offset, reg_wr_data);
// if (arreggen_abort_on_invalid_wr) begin $display("ERROR: write to undefined register!"); $finish; end
// end
// endcase
// end
//end
//
//// VCS coverage on
//// synopsys translate_on
endmodule
