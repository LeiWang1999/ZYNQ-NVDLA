//----------------------------------------------------------------------------
//      _____
//     *     *
//    *____   *____
//   * *===*   *==*
//  *___*===*___**  AVNET
//       *======*
//        *====*
//----------------------------------------------------------------------------
//
// This design is the property of Avnet.  Publication of this
// design is not authorized without written consent from Avnet.
//
// Please direct any questions to:  technical.support@avnet.com
//
// Disclaimer:
//    Avnet, Inc. makes no warranty for the use of this code or design.
//    This code is provided  "As Is". Avnet, Inc assumes no responsibility for
//    any errors, which may appear in this code, nor does it make a commitment
//    to update the information contained herein. Avnet, Inc specifically
//    disclaims any implied warranties of fitness for a particular purpose.
//                     Copyright(c) 2013 Avnet, Inc.
//                             All rights reserved.
//
//----------------------------------------------------------------------------
//
// Create Date:         Oct 25, 2013
// Design Name:         LED Dimmer Application
// Module Name:         main.c
// Project Name:        Zynq Software SpeedWay
// Target Devices:      Zynq-7000
// Hardware Boards:     MicroZed/ZedBoard
//
// Tool versions:       Vivado/SDK 2013.3
//
// Description:         Zed LED Dimmer Example
//
// Dependencies:
//
// Revision:            Oct 25, 2013: 1.00 Initial version
//
//----------------------------------------------------------------------------

/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xil_io.h"
#include "xstatus.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "opendla.h"

/************************** Constant Definitions *****************************/
/* The following constant maps to the name of the hardware instances that
 * were created in the Vivado system design. */
#define PWM_BASE_ADDRESS 0x43C00000
#define NVDLA_BASE_ADDRESS XPAR_NV_NVDLA_WRAPPER_0_BASEADDR
#define PS_DDR0_BASE_ADDRESS XPAR_PS7_DDR_0_S_AXI_BASEADDR

/* The following definitions are related to handling interrupts from the
 * PWM controller. */
#define XPAR_PS7_SCUGIC_0_DEVICE_ID 0
//#define INTC_PWM_INTERRUPT_ID	       XPAR_PWM_W_INT_0_DEVICE_ID
#define INTC XScuGic
#define INTC_HANDLER XScuGic_InterruptHandler
#define INTC_DEVICE_ID XPAR_PS7_SCUGIC_0_DEVICE_ID

/************************** Variable Definitions *****************************/

/*
 * The following are declared globally so they are zeroed and so they are
 * easily accessible from a debugger
 */

/* LED brightness level is now global to make is visble to the ISR. */
volatile u32 brightness;

void PWMIsr(void *InstancePtr)
{
    /* Inform the user that an invalid value was detected by the PWM
     * controller. */
    print("PWM Value exceeded, brightness reset to zero. Please enter new value: \r\n");

    /* Set the brightness value to a safe value and write it to the
     * PWM controller in order to clear the pending interrupt. */
    brightness = 0;
    Xil_Out32(PWM_BASE_ADDRESS, brightness);
}

unsigned int memory_get(unsigned int *memory_virtual_address, int offset)
{
    return memory_virtual_address[offset >> 2];
}

void reg_write(unsigned int reg_num, int value)
{
    Xil_Out32(NVDLA_BASE_ADDRESS + reg_num, value);
    //printf("write_reg[%x] = %x\n", nvdla_csb_addr+reg_num, value);
}

int reg_read(unsigned int reg_num)
{
    int data;
    data = Xil_In32(NVDLA_BASE_ADDRESS + reg_num);
    return data;
    //printf("write_reg[%x] = %x\n", nvdla_csb_addr+reg_num, value);
}

void poll_reg_equal(unsigned int reg_num, int expect_value)
{
    int data;

    //printf("poll_reg cond=%x, reg_num=%x, expect_value=%x, field=%x\n", condition, reg_num, expect_value, field);

    while (1)
    {
        data = Xil_In32(NVDLA_BASE_ADDRESS + reg_num);

        if ((data & 0xffffffff) == expect_value)
        {
            break;
        }
    }
}

void poll_field_not_equal(unsigned int reg_num, int field, int expect_value)
{
    int data;

    //printf("poll_reg cond=%x, reg_num=%x, expect_value=%x, field=%x\n", condition, reg_num, expect_value, field);

    while (1)
    {
        data = Xil_In32(NVDLA_BASE_ADDRESS + reg_num);

        if ((data & field) != expect_value)
        {
            break;
        }
    }
}

void poll_field_equal(unsigned int reg_num, int field, int expect_value)
{
    int data;

    //printf("poll_reg cond=%x, reg_num=%x, expect_value=%x, field=%x\n", condition, reg_num, expect_value, field);

    while (1)
    {
        data = Xil_In32(NVDLA_BASE_ADDRESS + reg_num);

        if ((data & field) == expect_value)
        {
            break;
        }
    }
}

/************************** Main Code Entry **********************************/
int main(void)
{

    cleanup_platform();
    unsigned int memory_value;
    unsigned int memory_value1;
    unsigned int memory_value2;
    int status = XST_SUCCESS;
    u32 value = 0;
    u32 period = 0;
    brightness = 0;
    unsigned int i;

    //0x40000000, "Image_q_dog_HW.bin", 1605632 bytes
    //0x40200000, "Image_q_dog_HW.bin", 1605632 bytes

    //byte
    int num;

    //byte
    num = 1605632;

    u32 *source, *destination;

    source = (u32 *)0x30000000; //golden output
    destination = (u32 *)0x20200000;
    xil_printf("HW Version is %x \r\n", reg_read(NVDLA_CFGROM_CFGROM_HW_VERSION_0));
    xil_printf("HW Version is %x.%x \r\n", reg_read(NVDLA_GLB_S_NVDLA_HW_VERSION_0)>>NVDLA_GLB_S_NVDLA_HW_VERSION_0_MAJOR_FIELD,reg_read(NVDLA_GLB_S_NVDLA_HW_VERSION_0)>>NVDLA_GLB_S_NVDLA_HW_VERSION_0_MINOR_FIELD);

    printf("***********************\n");
    printf("Begin NVDLA NV_SMALL Register Setting\n");
    printf("***********************\n");

    nv_small_run();
    nvdla_wait_for_ready();

    //word
    for (i = 0; i < num / 4; i++)
    {
        if (destination[i] != source[i])
        {
            xil_printf("Data match failed at = %d, source data = %d, destination data = %d\n\r", i, source[i], destination[i]);
            //print("-- Exiting main() --");
            //return XST_FAILURE;
        }
    }

    printf("DLA Copy Test Success\n ");

    //    }

    return status;
}
