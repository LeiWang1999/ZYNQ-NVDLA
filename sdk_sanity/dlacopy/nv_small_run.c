//dla_copy
#include "xparameters.h"
#include "xil_io.h"
#include "xstatus.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "opendla.h"

/************************** Constant Definitions *****************************/
/* The following constant maps to the name of the hardware instances that
 * were created in the Vivado system design. */

#define NVDLA_BASE_ADDRESS XPAR_NV_NVDLA_WRAPPER_0_BASEADDR
#define PS_DDR0_BASE_ADDRESS XPAR_PS7_DDR_0_S_AXI_BASEADDR
#define base_addr 0x20000000

int nv_small_run(void)
{
    unsigned int memory_value;

    /*
    printf("***********************\n");
    printf("Begin NVDLA NV_SMALL Register Setting\n");
    printf("***********************\n");
    */
    //mem_load(base_addr + 0x0, "CONV_SDP_0_input.dat");
    //mem_load(base_addr + 0x40000, "CONV_SDP_0_weight.dat");
    reg_write(NVDLA_SDP_S_POINTER_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_S_POINTER_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_LO_START_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_ACCESS_CFG_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_LE_SLOPE_SCALE_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_LO_SLOPE_SCALE_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_LE_END_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_ACCESS_DATA_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_INFO_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_LO_SLOPE_SHIFT_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_LE_START_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_CFG_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_LE_SLOPE_SHIFT_0, 0x0);
    reg_write(NVDLA_SDP_S_LUT_LO_END_0, 0x0);
    reg_write(NVDLA_SDP_D_CVT_OFFSET_0, 0x0);
    reg_write(NVDLA_SDP_D_DST_DMA_CFG_0, 0x1);
    reg_write(NVDLA_SDP_RDMA_D_SRC_SURFACE_STRIDE_0, 0x188000);
    reg_write(NVDLA_SDP_D_DST_LINE_STRIDE_0, 0xe00);
    reg_write(NVDLA_SDP_RDMA_D_SRC_LINE_STRIDE_0, 0xe00);
    reg_write(NVDLA_SDP_RDMA_D_SRC_BASE_ADDR_HIGH_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BRDMA_CFG_0, 0x1);
    reg_write(NVDLA_SDP_RDMA_D_BS_BATCH_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_ALU_CVT_SCALE_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_EW_LINE_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BN_BASE_ADDR_HIGH_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_ALU_SRC_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_NRDMA_CFG_0, 0x1);
    reg_write(NVDLA_SDP_D_DP_EW_MUL_CVT_SCALE_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BN_BATCH_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_MUL_CVT_TRUNCATE_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_EW_BASE_ADDR_HIGH_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_MUL_CFG_0, 0x2);
    reg_write(NVDLA_SDP_D_DATA_CUBE_WIDTH_0, 0x1bf);
    reg_write(NVDLA_SDP_D_DP_BN_ALU_CFG_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_EW_BASE_ADDR_LOW_0, base_addr + 0x80000000);
    reg_write(NVDLA_SDP_D_DATA_CUBE_CHANNEL_0, 0x7);
    reg_write(NVDLA_SDP_D_DATA_CUBE_HEIGHT_0, 0x1bf);
    reg_write(NVDLA_SDP_D_DP_BS_MUL_SRC_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BN_LINE_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BS_BASE_ADDR_HIGH_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_ALU_CVT_OFFSET_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_DATA_CUBE_CHANNEL_0, 0x7);
    reg_write(NVDLA_SDP_D_DP_BN_MUL_CFG_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_BN_MUL_SRC_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BS_BASE_ADDR_LOW_0, base_addr + 0x80000000);
    reg_write(NVDLA_SDP_RDMA_D_ERDMA_CFG_0, 0x1);
    reg_write(NVDLA_SDP_D_DST_BASE_ADDR_HIGH_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BS_SURFACE_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_MUL_SRC_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BS_LINE_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_BS_ALU_SRC_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_D_CVT_SHIFT_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_ALU_CFG_0, 0x2);
    reg_write(NVDLA_SDP_D_DST_SURFACE_STRIDE_0, 0x188000);
    reg_write(NVDLA_SDP_D_FEATURE_MODE_CFG_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_FEATURE_MODE_CFG_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_BS_CFG_0, 0x73);
    reg_write(NVDLA_SDP_D_CVT_SCALE_0, 0x1);
    reg_write(NVDLA_SDP_D_DP_BN_CFG_0, 0x53);
    reg_write(NVDLA_SDP_D_DP_BN_ALU_SRC_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_SRC_DMA_CFG_0, 0x1);
    reg_write(NVDLA_SDP_D_DST_BATCH_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_BS_ALU_CFG_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BN_SURFACE_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_MUL_CVT_OFFSET_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_EW_SURFACE_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_D_DST_BASE_ADDR_LOW_0, base_addr + 0x200000);
    reg_write(NVDLA_SDP_RDMA_D_EW_BATCH_STRIDE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_PERF_ENABLE_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_ALU_CVT_TRUNCATE_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_DATA_CUBE_HEIGHT_0, 0x1bf);
    reg_write(NVDLA_SDP_D_PERF_ENABLE_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_TRUNCATE_VALUE_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_SRC_BASE_ADDR_LOW_0, base_addr + 0x0);
    reg_write(NVDLA_SDP_RDMA_D_BN_BASE_ADDR_LOW_0, base_addr + 0x80000000);
    reg_write(NVDLA_SDP_D_DP_BS_MUL_CFG_0, 0x0);
    reg_write(NVDLA_SDP_D_DP_EW_CFG_0, 0x53);
    reg_write(NVDLA_SDP_D_DATA_FORMAT_0, 0x0);
    reg_write(NVDLA_SDP_RDMA_D_DATA_CUBE_WIDTH_0, 0x1bf);
    reg_write(NVDLA_SDP_RDMA_D_OP_ENABLE_0, 0x1);
    reg_write(NVDLA_SDP_D_OP_ENABLE_0, 0x1);

    printf("***********************\n");
    printf("Finish NVDLA NV_SMALL Register Setting\n");
    printf("***********************\n");

    /*	    
	    //get value
    	memory_value= memory_get(NVDLA_BASE_ADDRESS, NVDLA_SDP_RDMA_D_BS_BATCH_STRIDE_0);
    	printf("NVDLA_SDP_RDMA_D_BS_BATCH_STRIDE_0 (0x%08x@0x%02x):\n", memory_value, NVDLA_BASE_ADDRESS + NVDLA_SDP_RDMA_D_BS_BATCH_STRIDE_0);
*/
}
