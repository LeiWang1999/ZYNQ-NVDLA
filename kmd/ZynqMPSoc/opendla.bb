SUMMARY = "Recipe for  build an external opendla Linux kernel module"
SECTION = "PETALINUX/modules"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

inherit module

SRC_URI = "file://Makefile \
           file://nvdla_core_callbacks.c \
		   file://nvdla_gem.c \
		   file://scheduler.c \
		   file://engine.c \
		   file://bdma.c \
		   file://conv.c \
		   file://sdp.c \
		   file://cdp.c \
		   file://pdp.c \
		   file://rubik.c \
	   	   file://cache.c \
	   	   file://common.c \
	   	   file://engine_data.c \
		   file://engine_isr.c \
	   	   file://engine_debug.c \
	   	   file://common.h \
	   	   file://dla_debug.h \
           file://dla_fw_version.h \
	   	   file://dla_engine.h \
	   	   file://dla_engine_internal.h \
	   	   file://dla_err.h \
	   	   file://dla_interface.h \
	   	   file://dla_sched.h \
	   	   file://engine_debug.h \
	   	   file://nvdla_interface.h \
	   	   file://nvdla_linux.h \
	   	   file://opendla.h \
	   	   file://opendla_initial.h \
	   	   file://opendla_small.h \
	   	   file://nvdla_ioctl.h \
	       file://COPYING \
        "
S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.
