// Protocol Buffers - Google's data interchange format
// Copyright 2008 Google Inc.  All rights reserved.
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

// Author: kenton@google.com (Kenton Varda)
//  Based on original Protocol Buffers design by
//  Sanjay Ghemawat, Jeff Dean, and others.

#include <google/protobuf/compiler/javamicro/javamicro_params.h>
#include <google/protobuf/compiler/javamicro/javamicro_generator.h>
#include <google/protobuf/compiler/javamicro/javamicro_file.h>
#include <google/protobuf/compiler/javamicro/javamicro_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/io/zero_copy_stream.h>
#include <google/protobuf/descriptor.pb.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace javamicro {

void UpdateParamsRecursively(Params& params,
    const FileDescriptor* file) {
  // Add any parameters for this file
  if (file->options().has_java_outer_classname()) {
    params.set_java_outer_classname(
      file->name(), file->options().java_outer_classname());
  }
  if (file->options().has_java_package()) {
    params.set_java_package(
      file->name(), file->options().java_package());
  }
  if (file->options().has_java_multiple_files()) {
    params.set_java_multiple_files(
      file->name(), file->options().java_multiple_files());
  }

  // Loop through all dependent files recursively
  // adding dep
  for (int i = 0; i < file->dependency_count(); i++) {
    UpdateParamsRecursively(params, file->dependency(i));
  }
}

JavaMicroGenerator::JavaMicroGenerator() {}
JavaMicroGenerator::~JavaMicroGenerator() {}

bool JavaMicroGenerator::Generate(const FileDescriptor* file,
                             const string& parameter,
                             OutputDirectory* output_directory,
                             string* error) const {
  vector<pair<string, string> > options;

//  GOOGLE_LOG(INFO) << "wink: JavaMicroGenerator::Generate INFO";
//  GOOGLE_LOG(WARNING) << "wink: JavaMicroGenerator::Generate WARNING";
//  GOOGLE_LOG(ERROR) << "wink: JavaMicroGenerator::Generate ERROR";
//  GOOGLE_LOG(FATAL) << "wink: JavaMicroGenerator::Generate";

  ParseGeneratorParameter(parameter, &options);

  // -----------------------------------------------------------------
  // parse generator options

  // Name a file where we will write a list of generated file names, one
  // per line.
  string output_list_file;
  Params params(file->name());

  // Update per file params
  UpdateParamsRecursively(params, file);

  // Replace any existing options with ones from command line
  for (int i = 0; i < options.size(); i++) {
    // GOOGLE_LOG(WARNING) << "first=" << options[i].first
    //                     << " second=" << options[i].second;
    if (options[i].first == "output_list_file") {
      output_list_file = options[i].second;
    } else if (options[i].first == "opt") {
      if (options[i].second == "speed") {
        params.set_optimization(JAVAMICRO_OPT_SPEED);
      } else if (options[i].second == "space") {
        params.set_optimization(JAVAMICRO_OPT_SPACE);
      } else {
        *error = "Unknown javamicro generator option: opt="
                  + options[i].second + " expecting opt=space or opt=speed";
        return false;
      }
    } else if (options[i].first == "java_package") {
        vector<string> parts;
        SplitStringUsing(options[i].second, "|", &parts);
        if (parts.size() != 2) {
          *error = "Bad java_package, expecting filename|PackageName found '"
            + options[i].second + "'";
          return false;
        }
        params.set_java_package(parts[0], parts[1]);
    } else if (options[i].first == "java_outer_classname") {
        vector<string> parts;
        SplitStringUsing(options[i].second, "|", &parts);
        if (parts.size() != 2) {
          *error = "Bad java_outer_classname, "
                   "expecting filename|ClassName found '"
                   + options[i].second + "'";
          return false;
        }
        params.set_java_outer_classname(parts[0], parts[1]);
    } else if (options[i].first == "java_multiple_files") {
        params.set_override_java_multiple_files(options[i].second == "true");
    } else if (options[i].first == "java_use_vector") {
        params.set_java_use_vector(options[i].second == "true");
    } else {
      *error = "Ignore unknown javamicro generator option: " + options[i].first;
    }
  }

#if 0
  GOOGLE_LOG(WARNING) << "optimization()=" << params.optimization();
  GOOGLE_LOG(WARNING) << "java_multiple_files()=" << params.java_multiple_files();
  GOOGLE_LOG(WARNING) << "java_use_vector()=" << params.java_use_vector();

  GOOGLE_LOG(WARNING) << "----------";
  for (Params::NameMap::const_iterator it = params.java_packages().begin();
       it != params.java_packages().end();
       ++it) {
    GOOGLE_LOG(WARNING) << "cn.filename=" << it->first << " package=" << it->second;
  }
  for (Params::NameMap::const_iterator it = params.java_outer_classnames().begin();
       it != params.java_outer_classnames().end();
       ++it) {
    GOOGLE_LOG(WARNING) << "cn.filename=" << it->first << " classname=" << it->second;
  }
  GOOGLE_LOG(WARNING) << "==========";

#endif

  // -----------------------------------------------------------------

  FileGenerator file_generator(file, params);
  if (!file_generator.Validate(error)) {
    return false;
  }

  string package_dir =
    StringReplace(file_generator.java_package(), ".", "/", true);
  if (!package_dir.empty()) package_dir += "/";

  vector<string> all_files;

  if (IsOuterClassNeeded(params, file)) {
    string java_filename = package_dir;
    java_filename += file_generator.classname();
    java_filename += ".java";
    all_files.push_back(java_filename);

    // Generate main java file.
    scoped_ptr<io::ZeroCopyOutputStream> output(
      output_directory->Open(java_filename));
    io::Printer printer(output.get(), '$');
    file_generator.Generate(&printer);
  }

  // Generate sibling files.
  file_generator.GenerateSiblings(package_dir, output_directory, &all_files);

  // Generate output list if requested.
  if (!output_list_file.empty()) {
    // Generate output list.  This is just a simple text file placed in a
    // deterministic location which lists the .java files being generated.
    scoped_ptr<io::ZeroCopyOutputStream> srclist_raw_output(
      output_directory->Open(output_list_file));
    io::Printer srclist_printer(srclist_raw_output.get(), '$');
    for (int i = 0; i < all_files.size(); i++) {
      srclist_printer.Print("$filename$\n", "filename", all_files[i]);
    }
  }

  return true;
}

}  // namespace java
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
