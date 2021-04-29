#include "opendla.h"

int nvdla_is_busy()
{
    if ((reg_read(NVDLA_CDMA_S_STATUS_0) & 0x30003)
    ||  (reg_read(NVDLA_CMAC_A_S_STATUS_0) & 0x30003)
    ||  (reg_read(NVDLA_CMAC_B_S_STATUS_0) & 0x30003)
    ||  (reg_read(NVDLA_CACC_S_STATUS_0) & 0x30003)
    ||  (reg_read(NVDLA_CSC_S_STATUS_0) & 0x30003)
    ||  (reg_read(NVDLA_SDP_RDMA_S_STATUS_0) & 0x30003)
    ||  (reg_read(NVDLA_SDP_S_STATUS_0) & 0x30003)
    ||  (reg_read(NVDLA_PDP_S_STATUS_0) & 0x30003)){
        return 1;

    }else{
        return 0;
    }
}

void nvdla_wait_for_ready()
{
    poll_field_equal(NVDLA_CDMA_S_STATUS_0, 0x30003,0);
    poll_field_equal(NVDLA_CMAC_A_S_STATUS_0, 0x30003,0);
    poll_field_equal(NVDLA_CMAC_B_S_STATUS_0, 0x30003,0);
    poll_field_equal(NVDLA_CACC_S_STATUS_0, 0x30003,0);
    poll_field_equal(NVDLA_CSC_S_STATUS_0, 0x30003,0);
    poll_field_equal(NVDLA_SDP_RDMA_S_STATUS_0, 0x30003,0);
    poll_field_equal(NVDLA_SDP_S_STATUS_0, 0x30003,0);
    poll_field_equal(NVDLA_PDP_S_STATUS_0, 0x30003,0);
}
