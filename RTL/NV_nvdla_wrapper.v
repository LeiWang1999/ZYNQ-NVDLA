`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2021 12:14:52 PM
// Design Name: 
// Module Name: NV_nvdla_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module NV_nvdla_wrapper(
    input core_clk,
    input csb_clk,
    input rstn,
    input csb_rstn,

    output dla_intr,
    // dbb AXI
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWVALID" *)
    output nvdla_core2dbb_aw_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWREADY" *)
    input nvdla_core2dbb_aw_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWID" *)
    output [7:0] nvdla_core2dbb_aw_awid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWLEN" *)
    output [3:0] nvdla_core2dbb_aw_awlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWSIZE" *)
    output [2:0] nvdla_core2dbb_aw_awsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWADDR" *)
    output [64 -1:0] nvdla_core2dbb_aw_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WVALID" *)
    output nvdla_core2dbb_w_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WREADY" *)
    input nvdla_core2dbb_w_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WDATA" *)
    output [64 -1:0] nvdla_core2dbb_w_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WSTRB" *)
    output [64/8-1:0] nvdla_core2dbb_w_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WLAST" *)
    output nvdla_core2dbb_w_wlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARVALID" *)
    output nvdla_core2dbb_ar_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARREADY" *)
    input nvdla_core2dbb_ar_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARID" *)
    output [7:0] nvdla_core2dbb_ar_arid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARLEN" *)
    output [3:0] nvdla_core2dbb_ar_arlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARSIZE" *)
    output [2:0] nvdla_core2dbb_ar_arsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARADDR" *)
    output [64 -1:0] nvdla_core2dbb_ar_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BVALID" *)
    input nvdla_core2dbb_b_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BREADY" *)
    output nvdla_core2dbb_b_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BID" *)
    input [7:0] nvdla_core2dbb_b_bid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RVALID" *)
    input nvdla_core2dbb_r_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RREADY" *)
    output nvdla_core2dbb_r_rready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RID" *)
    input [7:0] nvdla_core2dbb_r_rid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RLAST" *)
    input nvdla_core2dbb_r_rlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RDATA" *)
    input [64 -1:0] nvdla_core2dbb_r_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWBURST" *)
    output [1:0] m_axi_awburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWLOCK" *)
    output  m_axi_awlock, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWCACHE" *)
    output [3:0] m_axi_awcache,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWPROT" *)
    output [2:0] m_axi_awprot, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWQOS" *)
    output [3:0] m_axi_awqos,  
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWUSER" *)
    output  m_axi_awuser, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WUSER" *)
    output  m_axi_wuser,  
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BRESP" *)
    input  [1:0] m_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BUSER" *)
    input   m_axi_buser,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARBURST" *)
    output [1:0] m_axi_arburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARLOCK" *)
    output  m_axi_arlock, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARCACHE" *)
    output [3:0] m_axi_arcache,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARPROT" *)
    output [2:0] m_axi_arprot, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARQOS" *)
    output [3:0] m_axi_arqos,  
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARUSER" *)
    output  m_axi_aruser, 
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RRESP" *)
    input  [1:0] m_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RUSER" *)
    input   m_axi_ruser,
    // cfg APB
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 s_apb PSEL" *)
    input psel,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 s_apb PENABLE" *)
    input penable,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 s_apb PWRITE" *)
    input pwrite,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 s_apb PADDR" *)
    input [31:0] paddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 s_apb PWDATA" *)
    input [31:0] pwdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 s_apb PRDATA" *)
    output [31:0] prdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 s_apb PREADY" *)
    output pready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 s_apb PSLVERR" *)
    output pslverr
    );

    wire        m_csb2nvdla_valid;
    wire        m_csb2nvdla_ready;
    wire [15:0] m_csb2nvdla_addr;
    wire [31:0] m_csb2nvdla_wdat;
    wire        m_csb2nvdla_write;
    wire        m_csb2nvdla_nposted;
    wire        m_nvdla2csb_valid;
    wire [31:0] m_nvdla2csb_data;


    NV_NVDLA_apb2csb apb2csb (
        .pclk                  (csb_clk)
        ,.prstn                 (csb_rstn)
        ,.csb2nvdla_ready       (m_csb2nvdla_ready)
        ,.nvdla2csb_data        (m_nvdla2csb_data)
        ,.nvdla2csb_valid       (m_nvdla2csb_valid)
        ,.paddr                 (paddr)
        ,.penable               (penable)
        ,.psel                  (psel)
        ,.pwdata                (pwdata)
        ,.pwrite                (pwrite)
        ,.csb2nvdla_addr        (m_csb2nvdla_addr)
        ,.csb2nvdla_nposted     (m_csb2nvdla_nposted)
        ,.csb2nvdla_valid       (m_csb2nvdla_valid)
        ,.csb2nvdla_wdat        (m_csb2nvdla_wdat)
        ,.csb2nvdla_write       (m_csb2nvdla_write)
        ,.prdata                (prdata)
        ,.pready                (pready)
    );


    NV_nvdla nvdla_top (
        .dla_core_clk                    (core_clk)
        ,.dla_csb_clk                     (csb_clk)
        ,.global_clk_ovr_on               (1'b0)
        ,.tmc2slcg_disable_clock_gating   (1'b0)
        ,.dla_reset_rstn                  (rstn)
        ,.direct_reset_                   (1'b1)
        ,.test_mode                       (1'b0)
        ,.csb2nvdla_valid                 (m_csb2nvdla_valid)
        ,.csb2nvdla_ready                 (m_csb2nvdla_ready)
        ,.csb2nvdla_addr                  (m_csb2nvdla_addr)
        ,.csb2nvdla_wdat                  (m_csb2nvdla_wdat)
        ,.csb2nvdla_write                 (m_csb2nvdla_write)
        ,.csb2nvdla_nposted               (m_csb2nvdla_nposted)
        ,.nvdla2csb_valid                 (m_nvdla2csb_valid)
        ,.nvdla2csb_data                  (m_nvdla2csb_data)
        ,.nvdla2csb_wr_complete           () //FIXME: no such port in apb2csb
        ,.nvdla_core2dbb_aw_awvalid       (nvdla_core2dbb_aw_awvalid)
        ,.nvdla_core2dbb_aw_awready       (nvdla_core2dbb_aw_awready)
        ,.nvdla_core2dbb_aw_awaddr        (nvdla_core2dbb_aw_awaddr)
        ,.nvdla_core2dbb_aw_awid          (nvdla_core2dbb_aw_awid)
        ,.nvdla_core2dbb_aw_awlen         (nvdla_core2dbb_aw_awlen)
        ,.nvdla_core2dbb_w_wvalid         (nvdla_core2dbb_w_wvalid)
        ,.nvdla_core2dbb_w_wready         (nvdla_core2dbb_w_wready)
        ,.nvdla_core2dbb_w_wdata          (nvdla_core2dbb_w_wdata)
        ,.nvdla_core2dbb_w_wstrb          (nvdla_core2dbb_w_wstrb)
        ,.nvdla_core2dbb_w_wlast          (nvdla_core2dbb_w_wlast)
        ,.nvdla_core2dbb_b_bvalid         (nvdla_core2dbb_b_bvalid)
        ,.nvdla_core2dbb_b_bready         (nvdla_core2dbb_b_bready)
        ,.nvdla_core2dbb_b_bid            (nvdla_core2dbb_b_bid)
        ,.nvdla_core2dbb_ar_arvalid       (nvdla_core2dbb_ar_arvalid)
        ,.nvdla_core2dbb_ar_arready       (nvdla_core2dbb_ar_arready)
        ,.nvdla_core2dbb_ar_araddr        (nvdla_core2dbb_ar_araddr)
        ,.nvdla_core2dbb_ar_arid          (nvdla_core2dbb_ar_arid)
        ,.nvdla_core2dbb_ar_arlen         (nvdla_core2dbb_ar_arlen)
        ,.nvdla_core2dbb_r_rvalid         (nvdla_core2dbb_r_rvalid)
        ,.nvdla_core2dbb_r_rready         (nvdla_core2dbb_r_rready)
        ,.nvdla_core2dbb_r_rid            (nvdla_core2dbb_r_rid)
        ,.nvdla_core2dbb_r_rlast          (nvdla_core2dbb_r_rlast)
        ,.nvdla_core2dbb_r_rdata          (nvdla_core2dbb_r_rdata)
        ,.dla_intr                        (dla_intr)
        ,.nvdla_pwrbus_ram_c_pd           (32'b0)
        ,.nvdla_pwrbus_ram_ma_pd          (32'b0)
        ,.nvdla_pwrbus_ram_mb_pd          (32'b0)
        ,.nvdla_pwrbus_ram_p_pd           (32'b0)
        ,.nvdla_pwrbus_ram_o_pd           (32'b0)
        ,.nvdla_pwrbus_ram_a_pd           (32'b0)
    ); // nvdla_top

assign nvdla_core2dbb_aw_awsize = 3'b011;
assign nvdla_core2dbb_ar_arsize = 3'b011;

assign m_axi_awburst = 2'b01;
assign m_axi_awlock  = 1'b0;
assign m_axi_awcache = 4'b0010;
assign m_axi_awprot  = 3'h0;
assign m_axi_awqos   = 4'h0;
assign m_axi_awuser  = 'b1;
assign m_axi_wuser   = 'b0;
assign m_axi_arburst = 2'b01;
assign m_axi_arlock  = 1'b0;
assign m_axi_arcache = 4'b0010;
assign m_axi_arprot  = 3'h0;
assign m_axi_arqos   = 4'h0;
assign m_axi_aruser  = 'b1;

assign pslverr = 1'b0;

endmodule