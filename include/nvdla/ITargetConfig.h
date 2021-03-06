/*
 * Copyright (c) 2018-2019, NVIDIA CORPORATION. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *  * Neither the name of NVIDIA CORPORATION nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef NVDLA_I_TARGETCONFIG_H
#define NVDLA_I_TARGETCONFIG_H

#include "nvdla/IType.h"

namespace nvdla {

class IWisdom;
class ILoadable;

class ITargetConfig
{
public:
    virtual const char* getName() const = 0;

    struct ITargetConfigParams
    {
        NvU32 atomicCSize;
        NvU32 atomicKSize;
        NvU32 memoryAtomicSize;
        NvU32 numConvBufBankAllotted;
        NvU32 numConvBufEntriesPerBank;
        NvU32 numConvBufEntryWidth;
        NvU32 maxBatchSize;
        bool isWinogradCapable;
        bool isCompressWeightsCapable;
        bool isBatchModeCapable;
        bool isPDPCapable;
        bool isCDPCapable;
        bool isSDPBiasCapable;
        bool isSDPBatchNormCapable;
        bool isSDPEltWiseCapable;
        bool isSDPLutCapable;
        bool isBDMACapable;
        bool isRubikCapable;

        ITargetConfigParams()
            : atomicCSize(64),
              atomicKSize(32),
              memoryAtomicSize(32),
              numConvBufBankAllotted(16),
              numConvBufEntriesPerBank(256),
              numConvBufEntryWidth(128),
              maxBatchSize(32),
              isWinogradCapable(false),
              isCompressWeightsCapable(false),
              isBatchModeCapable(false),
              isPDPCapable(false),
              isCDPCapable(false),
              isSDPBiasCapable(false),
              isSDPBatchNormCapable(false),
              isSDPEltWiseCapable(false),
              isSDPLutCapable(false),
              isBDMACapable(false),
              isRubikCapable(false)
        {
        }
    };

    virtual NvDlaError initTargetConfigParams(ITargetConfigParams*) = 0;

protected:
    ITargetConfig();
    virtual ~ITargetConfig();
};

} // namespace nvdla

#endif // NVDLA_I_TARGETCONFIG_H
