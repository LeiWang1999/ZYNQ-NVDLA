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

#include <limits>
#include <vector>

#include <google/protobuf/compiler/javamicro/javamicro_helpers.h>
#include <google/protobuf/compiler/javamicro/javamicro_params.h>
#include <google/protobuf/descriptor.pb.h>
#include <google/protobuf/stubs/strutil.h>
#include <google/protobuf/stubs/substitute.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace javamicro {

const char kThickSeparator[] =
  "// ===================================================================\n";
const char kThinSeparator[] =
  "// -------------------------------------------------------------------\n";

namespace {

const char* kDefaultPackage = "";

const string& FieldName(const FieldDescriptor* field) {
  // Groups are hacky:  The name of the field is just the lower-cased name
  // of the group type.  In Java, though, we would like to retain the original
  // capitalization of the type name.
  if (field->type() == FieldDescriptor::TYPE_GROUP) {
    return field->message_type()->name();
  } else {
    return field->name();
  }
}

string UnderscoresToCamelCaseImpl(const string& input, bool cap_next_letter) {
  string result;
  // Note:  I distrust ctype.h due to locales.
  for (int i = 0; i < input.size(); i++) {
    if ('a' <= input[i] && input[i] <= 'z') {
      if (cap_next_letter) {
        result += input[i] + ('A' - 'a');
      } else {
        result += input[i];
      }
      cap_next_letter = false;
    } else if ('A' <= input[i] && input[i] <= 'Z') {
      if (i == 0 && !cap_next_letter) {
        // Force first letter to lower-case unless explicitly told to
        // capitalize it.
        result += input[i] + ('a' - 'A');
      } else {
        // Capital letters after the first are left as-is.
        result += input[i];
      }
      cap_next_letter = false;
    } else if ('0' <= input[i] && input[i] <= '9') {
      result += input[i];
      cap_next_letter = true;
    } else {
      cap_next_letter = true;
    }
  }
  return result;
}

}  // namespace

string UnderscoresToCamelCase(const FieldDescriptor* field) {
  return UnderscoresToCamelCaseImpl(FieldName(field), false);
}

string UnderscoresToCapitalizedCamelCase(const FieldDescriptor* field) {
  return UnderscoresToCamelCaseImpl(FieldName(field), true);
}

string UnderscoresToCamelCase(const MethodDescriptor* method) {
  return UnderscoresToCamelCaseImpl(method->name(), false);
}

string StripProto(const string& filename) {
  if (HasSuffixString(filename, ".protodevel")) {
    return StripSuffixString(filename, ".protodevel");
  } else {
    return StripSuffixString(filename, ".proto");
  }
}

string FileClassName(const Params& params, const FileDescriptor* file) {
  if (params.has_java_outer_classname(file->name())) {
    return params.java_outer_classname(file->name());
  } else {
    // Use the filename itself with underscores removed
    // and a CamelCase style name.
    string basename;
    string::size_type last_slash = file->name().find_last_of('/');
    if (last_slash == string::npos) {
      basename = file->name();
    } else {
      basename = file->name().substr(last_slash + 1);
    }
    return UnderscoresToCamelCaseImpl(StripProto(basename), true);
  }
}

string FileJavaPackage(const Params& params, const FileDescriptor* file) {
  if (params.has_java_package(file->name())) {
    return params.java_package(file->name());
  } else {
    string result = kDefaultPackage;
    if (!file->package().empty()) {
      if (!result.empty()) result += '.';
      result += file->package();
    }
    return result;
  }
}

bool IsOuterClassNeeded(const Params& params, const FileDescriptor* file) {
  // Enums and extensions need the outer class as the scope.
  if (file->enum_type_count() != 0 || file->extension_count() != 0) {
    return true;
  }
  // Messages need the outer class only if java_multiple_files is false.
  return !params.java_multiple_files(file->name());
}

string ToJavaName(const Params& params, const string& name, bool is_class,
    const Descriptor* parent, const FileDescriptor* file) {
  string result;
  if (parent != NULL) {
    result.append(ClassName(params, parent));
  } else if (is_class && params.java_multiple_files(file->name())) {
    result.append(FileJavaPackage(params, file));
  } else {
    result.append(ClassName(params, file));
  }
  if (!result.empty()) result.append(1, '.');
  result.append(name); // TODO(maxtroy): add '_' if name is a Java keyword.
  return result;
}

string ClassName(const Params& params, const FileDescriptor* descriptor) {
  string result = FileJavaPackage(params, descriptor);
  if (!result.empty()) result += '.';
  result += FileClassName(params, descriptor);
  return result;
}

string ClassName(const Params& params, const EnumDescriptor* descriptor) {
  // An enum's class name is the enclosing message's class name or the outer
  // class name.
  const Descriptor* parent = descriptor->containing_type();
  if (parent != NULL) {
    return ClassName(params, parent);
  } else {
    return ClassName(params, descriptor->file());
  }
}

string FieldConstantName(const FieldDescriptor *field) {
  string name = field->name() + "_FIELD_NUMBER";
  UpperString(&name);
  return name;
}

JavaType GetJavaType(FieldDescriptor::Type field_type) {
  switch (field_type) {
    case FieldDescriptor::TYPE_INT32:
    case FieldDescriptor::TYPE_UINT32:
    case FieldDescriptor::TYPE_SINT32:
    case FieldDescriptor::TYPE_FIXED32:
    case FieldDescriptor::TYPE_SFIXED32:
      return JAVATYPE_INT;

    case FieldDescriptor::TYPE_INT64:
    case FieldDescriptor::TYPE_UINT64:
    case FieldDescriptor::TYPE_SINT64:
    case FieldDescriptor::TYPE_FIXED64:
    case FieldDescriptor::TYPE_SFIXED64:
      return JAVATYPE_LONG;

    case FieldDescriptor::TYPE_FLOAT:
      return JAVATYPE_FLOAT;

    case FieldDescriptor::TYPE_DOUBLE:
      return JAVATYPE_DOUBLE;

    case FieldDescriptor::TYPE_BOOL:
      return JAVATYPE_BOOLEAN;

    case FieldDescriptor::TYPE_STRING:
      return JAVATYPE_STRING;

    case FieldDescriptor::TYPE_BYTES:
      return JAVATYPE_BYTES;

    case FieldDescriptor::TYPE_ENUM:
      return JAVATYPE_ENUM;

    case FieldDescriptor::TYPE_GROUP:
    case FieldDescriptor::TYPE_MESSAGE:
      return JAVATYPE_MESSAGE;

    // No default because we want the compiler to complain if any new
    // types are added.
  }

  GOOGLE_LOG(FATAL) << "Can't get here.";
  return JAVATYPE_INT;
}

const char* BoxedPrimitiveTypeName(JavaType type) {
  switch (type) {
    case JAVATYPE_INT    : return "java.lang.Integer";
    case JAVATYPE_LONG   : return "java.lang.Long";
    case JAVATYPE_FLOAT  : return "java.lang.Float";
    case JAVATYPE_DOUBLE : return "java.lang.Double";
    case JAVATYPE_BOOLEAN: return "java.lang.Boolean";
    case JAVATYPE_STRING : return "java.lang.String";
    case JAVATYPE_BYTES  : return "com.google.protobuf.micro.ByteStringMicro";
    case JAVATYPE_ENUM   : return "java.lang.Integer";
    case JAVATYPE_MESSAGE: return NULL;

    // No default because we want the compiler to complain if any new
    // JavaTypes are added.
  }

  GOOGLE_LOG(FATAL) << "Can't get here.";
  return NULL;
}

bool AllAscii(const string& text) {
  for (int i = 0; i < text.size(); i++) {
    if ((text[i] & 0x80) != 0) {
      return false;
    }
  }
  return true;
}

string DefaultValue(const Params& params, const FieldDescriptor* field) {
  // Switch on cpp_type since we need to know which default_value_* method
  // of FieldDescriptor to call.
  switch (field->cpp_type()) {
    case FieldDescriptor::CPPTYPE_INT32:
      return SimpleItoa(field->default_value_int32());
    case FieldDescriptor::CPPTYPE_UINT32:
      // Need to print as a signed int since Java has no unsigned.
      return SimpleItoa(static_cast<int32>(field->default_value_uint32()));
    case FieldDescriptor::CPPTYPE_INT64:
      return SimpleItoa(field->default_value_int64()) + "L";
    case FieldDescriptor::CPPTYPE_UINT64:
      return SimpleItoa(static_cast<int64>(field->default_value_uint64())) +
             "L";
    case FieldDescriptor::CPPTYPE_DOUBLE: {
     double value = field->default_value_double();
      if (value == numeric_limits<double>::infinity()) {
        return "Double.POSITIVE_INFINITY";
      } else if (value == -numeric_limits<double>::infinity()) {
        return "Double.NEGATIVE_INFINITY";
      } else if (value != value) {
        return "Double.NaN";
      } else {
        return SimpleDtoa(value) + "D";
      }
    }
    case FieldDescriptor::CPPTYPE_FLOAT: {
      float value = field->default_value_float();
      if (value == numeric_limits<float>::infinity()) {
        return "Float.POSITIVE_INFINITY";
      } else if (value == -numeric_limits<float>::infinity()) {
        return "Float.NEGATIVE_INFINITY";
      } else if (value != value) {
        return "Float.NaN";
      } else {
        return SimpleFtoa(value) + "F";
      }
    }
    case FieldDescriptor::CPPTYPE_BOOL:
      return field->default_value_bool() ? "true" : "false";
    case FieldDescriptor::CPPTYPE_STRING:
      if (field->type() == FieldDescriptor::TYPE_BYTES) {
        if (field->has_default_value()) {
          // See comments in Internal.java for gory details.
          return strings::Substitute(
            "com.google.protobuf.micro.ByteStringMicro.copyFromUtf8(\"$0\")",
            CEscape(field->default_value_string()));
        } else {
          return "com.google.protobuf.micro.ByteStringMicro.EMPTY";
        }
      } else {
        if (AllAscii(field->default_value_string())) {
          // All chars are ASCII.  In this case CEscape() works fine.
          return "\"" + CEscape(field->default_value_string()) + "\"";
        } else {
          // See comments in Internal.java for gory details.
          // BUG: Internal NOT SUPPORTED need to fix!!
          return strings::Substitute(
            "com.google.protobuf.micro.Internal.stringDefaultValue(\"$0\")",
            CEscape(field->default_value_string()));
        }
      }

    case FieldDescriptor::CPPTYPE_ENUM:
      return ClassName(params, field->enum_type()) + "." +
             field->default_value_enum()->name();

    case FieldDescriptor::CPPTYPE_MESSAGE:
      return ClassName(params, field->message_type()) + ".getDefaultInstance()";

    // No default because we want the compiler to complain if any new
    // types are added.
  }

  GOOGLE_LOG(FATAL) << "Can't get here.";
  return "";
}

}  // namespace javamicro
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
