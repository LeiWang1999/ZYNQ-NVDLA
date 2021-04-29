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

#ifndef NVDLA_PRIV_PROFILER_H
#define NVDLA_PRIV_PROFILER_H


#include <string>
#include <map>
#include <vector>
#include <memory>
#include <algorithm>

#include "priv/Type.h"

#include "nvdla/IProfiler.h"
#include "priv/Profile.h"
#include "priv/TargetConfig.h"
#include "priv/WisdomContainer.h"


namespace nvdla
{

namespace priv
{

class Profiler;

class ProfilerFactory
{
public:
    typedef PrivPair<IProfiler *, Profiler*> ProfilerPrivPair;

    static ProfilerPrivPair newProfiler();
    static NvDlaError deleteProfiler(IProfiler *profiler);

    static Profiler *priv(IProfiler *);
    static IProfiler *i(Profiler *);
    static IProfiler *self(void *);

protected:
    static BiMap<IProfiler *, Profiler *> s_priv;
    static BiMap<void *, IProfiler *> s_self;

};

class Profile;
class TargetConfig;
class TestPoint;

class TestPointEvaluationResult
{

};


class Profiler : public IProfiler
{
public: // externally facing

    virtual IWisdom *wisdom();

    virtual IProfile *createProfile(const char *profile_name);
    virtual IProfile *getProfile(const char *profile_name);
    virtual ITargetConfig *getTargetConfig(const char *target_config_name);

public: // internally facing

    Profiler();
    virtual ~Profiler();

    virtual NvU16 getFactoryType() const;
    void setWisdom(Wisdom *w) { m_wisdom = w; }


protected:
    friend class Wisdom;
    friend class ProfilerFactory;

    Wisdom *m_wisdom;

    std::map<std::string, ProfileFactory::ProfilePrivPair> m_profiles;
    std::map<std::string, TargetConfigFactory::TargetConfigPrivPair> m_targetConfigs;

};

} // nvdla::priv
} // nvdla

#endif // NVDLA_PRIV_PROFILER_H
