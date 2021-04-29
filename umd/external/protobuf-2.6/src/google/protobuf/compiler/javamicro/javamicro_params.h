// Protocol Buffers - Google's data interchange format
// Copyright 2010 Google Inc.  All rights reserved.
// http://code.google.com/p/protobuf/
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

// Author: wink@google.com (Wink Saville)

#ifndef PROTOBUF_COMPILER_JAVAMICRO_JAVAMICRO_PARAMS_H_
#define PROTOBUF_COMPILER_JAVAMICRO_JAVAMICRO_PARAMS_H_

#include <map>
#include <set>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace javamicro {

enum eOptimization { JAVAMICRO_OPT_SPEED, JAVAMICRO_OPT_SPACE, JAVAMICRO_OPT_DEFAULT = JAVAMICRO_OPT_SPACE };
enum eMultipleFiles { JAVAMICRO_MUL_UNSET, JAVAMICRO_MUL_FALSE, JAVAMICRO_MUL_TRUE };

// Parameters for used by the generators
class Params {
 public:
  typedef map<string, string> NameMap;
  typedef set<string> NameSet;
 private:
  string empty_;
  string base_name_;
  eOptimization optimization_;
  eMultipleFiles override_java_multiple_files_;
  bool java_use_vector_;
  NameMap java_packages_;
  NameMap java_outer_classnames_;
  NameSet java_multiple_files_;

 public:
  Params(const string & base_name) :
    empty_(""),
    base_name_(base_name),
    optimization_(JAVAMICRO_OPT_DEFAULT),
    override_java_multiple_files_(JAVAMICRO_MUL_UNSET),
    java_use_vector_(false) {
  }

  const string& base_name() const {
    return base_name_;
  }

  bool has_java_package(const string& file_name) const {
    return java_packages_.find(file_name)
                        != java_packages_.end();
  }
  void set_java_package(const string& file_name,
      const string& java_package) {
    java_packages_[file_name] = java_package;
  }
  const string& java_package(const string& file_name) const {
    NameMap::const_iterator itr;

    itr = java_packages_.find(file_name);
    if  (itr == java_packages_.end()) {
      return empty_;
    } else {
      return itr->second;
    }
  }
  const NameMap& java_packages() {
    return java_packages_;
  }

  bool has_java_outer_classname(const string& file_name) const {
    return java_outer_classnames_.find(file_name)
                        != java_outer_classnames_.end();
  }
  void set_java_outer_classname(const string& file_name,
      const string& java_outer_classname) {
    java_outer_classnames_[file_name] = java_outer_classname;
  }
  const string& java_outer_classname(const string& file_name) const {
    NameMap::const_iterator itr;

    itr = java_outer_classnames_.find(file_name);
    if  (itr == java_outer_classnames_.end()) {
      return empty_;
    } else {
      return itr->second;
    }
  }
  const NameMap& java_outer_classnames() {
    return java_outer_classnames_;
  }

  void set_optimization(eOptimization optimization) {
    optimization_ = optimization;
  }
  eOptimization optimization() const {
    return optimization_;
  }

  void set_override_java_multiple_files(bool value) {
    if (value) {
      override_java_multiple_files_ = JAVAMICRO_MUL_TRUE;
    } else {
      override_java_multiple_files_ = JAVAMICRO_MUL_FALSE;
    }
  }
  void clear_override_java_multiple_files() {
    override_java_multiple_files_ = JAVAMICRO_MUL_UNSET;
  }

  void set_java_multiple_files(const string& file_name, bool value) {
    if (value) {
      java_multiple_files_.insert(file_name);
    } else {
      java_multiple_files_.erase(file_name);
    }
  }
  bool java_multiple_files(const string& file_name) const {
    switch (override_java_multiple_files_) {
      case JAVAMICRO_MUL_FALSE:
        return false;
      case JAVAMICRO_MUL_TRUE:
        return true;
      default:
        return java_multiple_files_.find(file_name)
                != java_multiple_files_.end();
    }
  }

  void set_java_use_vector(bool value) {
    java_use_vector_ = value;
  }
  bool java_use_vector() const {
    return java_use_vector_;
  }

};

}  // namespace javamicro
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
#endif  // PROTOBUF_COMPILER_JAVAMICRO_JAVAMICRO_PARAMS_H_
