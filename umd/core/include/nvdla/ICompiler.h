/*
 * Copyright (c) 2016-2019, NVIDIA CORPORATION. All rights reserved.
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

#ifndef NVDLA_I_COMPILER_H
#define NVDLA_I_COMPILER_H

namespace nvdla
{

class IWisdom;
class ILoadable;
class ICompiler
{
public:
    virtual IWisdom *wisdom() const = 0;

    virtual NvDlaError getDataType(DataType::UnderlyingType *d) const = 0;
    virtual NvDlaError compile(const char *profile_name, const char *target_config_name, ILoadable **l) = 0; // "" := default
    virtual NvDlaError getLoadableImage(const char *profile_name, NvU8 *flatbuf) = 0;
    virtual NvDlaError getLoadableImageSize(const char *profile_name, NvU64 *size) = 0;

    virtual NvDlaError compileCheck(const char *profile_name, const char *target_config_name) = 0;

protected:
    ICompiler();
    virtual ~ICompiler();
};


// ICompiler *createCompiler();

} // nvdla



#endif // NVDLA_I_COMPILER_H
