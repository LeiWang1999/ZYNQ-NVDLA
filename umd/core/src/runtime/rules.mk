# Copyright (c) 2017-2018, NVIDIA CORPORATION. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#
# libnvdla_runtime
#

LOCAL_DIR := $(GET_LOCAL_DIR)

MODULE_CC := $(TOOLCHAIN_PREFIX)gcc
MODULE_CPP := $(TOOLCHAIN_PREFIX)g++
MODULE_LD := $(TOOLCHAIN_PREFIX)ld

NVDLA_RUNTIME_SRC_FILES := \
    $(ROOT)/core/src/common/Check.cpp \
    $(ROOT)/core/src/common/ErrorLogging.c \
    $(ROOT)/core/src/common/EMUInterface.cpp \
    $(ROOT)/core/src/common/EMUInterfaceA.cpp \
    $(ROOT)/core/src/common/Loadable.cpp \
    $(ROOT)/port/linux/nvdla.c \
    $(ROOT)/port/linux/nvdla_os.c \
    Emulator.cpp \
    Runtime.cpp

INCLUDES += \
    -I$(ROOT)/include \
    -I$(ROOT)/core/include \
    -I$(ROOT)/core/src/common/include \
    -I$(ROOT)/port/linux/include \
    -I$(ROOT)/external/include \
    -I$(LOCAL_DIR)/include \
    -I$(LOCAL_DIR)

MODULE_CPPFLAGS += -DNVDLA_UTILS_ERROR_TAG="\"DLA_RUNTIME\""
MODULE_CFLAGS += -DNVDLA_UTILS_ERROR_TAG="\"DLA_RUNTIME\""

MODULE_SRCS := $(NVDLA_RUNTIME_SRC_FILES)

include $(ROOT)/make/module.mk
