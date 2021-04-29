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

#include <map>
#include <string>

#include <google/protobuf/compiler/javamicro/javamicro_message_field.h>
#include <google/protobuf/compiler/javamicro/javamicro_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/wire_format.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace javamicro {

namespace {

// TODO(kenton):  Factor out a "SetCommonFieldVariables()" to get rid of
//   repeat code between this and the other field types.
void SetMessageVariables(const Params& params,
    const FieldDescriptor* descriptor, map<string, string>* variables) {
  (*variables)["name"] =
    UnderscoresToCamelCase(descriptor);
  (*variables)["capitalized_name"] =
    UnderscoresToCapitalizedCamelCase(descriptor);
  (*variables)["number"] = SimpleItoa(descriptor->number());
  (*variables)["type"] = ClassName(params, descriptor->message_type());
  (*variables)["group_or_message"] =
    (descriptor->type() == FieldDescriptor::TYPE_GROUP) ?
    "Group" : "Message";
  (*variables)["message_name"] = descriptor->containing_type()->name();
  //(*variables)["message_type"] = descriptor->message_type()->name();
}

}  // namespace

// ===================================================================

MessageFieldGenerator::
MessageFieldGenerator(const FieldDescriptor* descriptor, const Params& params)
  : FieldGenerator(params), descriptor_(descriptor) {
  SetMessageVariables(params, descriptor, &variables_);
}

MessageFieldGenerator::~MessageFieldGenerator() {}

void MessageFieldGenerator::
GenerateMembers(io::Printer* printer) const {
  printer->Print(variables_,
    "private boolean has$capitalized_name$;\n"
//    "private $type$ $name$_ = null;\n"
//    "public boolean has$capitalized_name$() { return has$capitalized_name$; }\n"
//    "public $type$ get$capitalized_name$() { return $name$_; }\n"
    "private $type$ $name$_ = null;\n"
    "public boolean has$capitalized_name$() { return has$capitalized_name$; }\n"
    "public $type$ get$capitalized_name$() { return $name$_; }\n"
    "public $message_name$ set$capitalized_name$($type$ value) {\n"
    "  if (value == null) {\n"
    "    throw new NullPointerException();\n"
    "  }\n"
    "  has$capitalized_name$ = true;\n"
    "  $name$_ = value;\n"
    "  return this;\n"
    "}\n"
    "public $message_name$ clear$capitalized_name$() {\n"
    "  has$capitalized_name$ = false;\n"
    "  $name$_ = null;\n"
    "  return this;\n"
    "}\n");
}

void MessageFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print(variables_,
    "if (other.has$capitalized_name$()) {\n"
    "  merge$capitalized_name$(other.get$capitalized_name$());\n"
    "}\n");
}

void MessageFieldGenerator::
GenerateParsingCode(io::Printer* printer) const {
  printer->Print(variables_,
    "$type$ value = new $type$();\n");

  if (descriptor_->type() == FieldDescriptor::TYPE_GROUP) {
    printer->Print(variables_,
      "input.readGroup(value, $number$);\n");
  } else {
    printer->Print(variables_,
      "input.readMessage(value);\n");
  }

  printer->Print(variables_,
    "set$capitalized_name$(value);\n");
}

void MessageFieldGenerator::
GenerateSerializationCode(io::Printer* printer) const {
  printer->Print(variables_,
    "if (has$capitalized_name$()) {\n"
    "  output.write$group_or_message$($number$, get$capitalized_name$());\n"
    "}\n");
}

void MessageFieldGenerator::
GenerateSerializedSizeCode(io::Printer* printer) const {
  printer->Print(variables_,
    "if (has$capitalized_name$()) {\n"
    "  size += com.google.protobuf.micro.CodedOutputStreamMicro\n"
    "    .compute$group_or_message$Size($number$, get$capitalized_name$());\n"
    "}\n");
}

string MessageFieldGenerator::GetBoxedType() const {
  return ClassName(params_, descriptor_->message_type());
}

// ===================================================================

RepeatedMessageFieldGenerator::
RepeatedMessageFieldGenerator(const FieldDescriptor* descriptor, const Params& params)
  : FieldGenerator(params), descriptor_(descriptor) {
  SetMessageVariables(params, descriptor, &variables_);
}

RepeatedMessageFieldGenerator::~RepeatedMessageFieldGenerator() {}

void RepeatedMessageFieldGenerator::
GenerateMembers(io::Printer* printer) const {
  if (params_.java_use_vector()) {
    printer->Print(variables_,
      "private java.util.Vector $name$_ = new java.util.Vector();\n"
      "public java.util.Vector get$capitalized_name$List() {\n"
      "  return $name$_;\n"
      "}\n"
      "public int get$capitalized_name$Count() { return $name$_.size(); }\n"
      "public $type$ get$capitalized_name$(int index) {\n"
      "  return ($type$) $name$_.elementAt(index);\n"
      "}\n"
      "public $message_name$ set$capitalized_name$(int index, $type$ value) {\n"
      "  if (value == null) {\n"
      "    throw new NullPointerException();\n"
      "  }\n"
      "  $name$_.setElementAt(value, index);\n"
      "  return this;\n"
      "}\n"
      "public $message_name$ add$capitalized_name$($type$ value) {\n"
      "  if (value == null) {\n"
      "    throw new NullPointerException();\n"
      "  }\n"
      "  $name$_.addElement(value);\n"
      "  return this;\n"
      "}\n"
      "public $message_name$ clear$capitalized_name$() {\n"
      "  $name$_.removeAllElements();\n"
      "  return this;\n"
      "}\n");
  } else {
    printer->Print(variables_,
      "private java.util.List<$type$> $name$_ =\n"
      "  java.util.Collections.emptyList();\n"
      "public java.util.List<$type$> get$capitalized_name$List() {\n"
      "  return $name$_;\n"
      "}\n"
      "public int get$capitalized_name$Count() { return $name$_.size(); }\n"
      "public $type$ get$capitalized_name$(int index) {\n"
      "  return $name$_.get(index);\n"
      "}\n"
      "public $message_name$ set$capitalized_name$(int index, $type$ value) {\n"
      "  if (value == null) {\n"
      "    throw new NullPointerException();\n"
      "  }\n"
      "  $name$_.set(index, value);\n"
      "  return this;\n"
      "}\n"
      "public $message_name$ add$capitalized_name$($type$ value) {\n"
      "  if (value == null) {\n"
      "    throw new NullPointerException();\n"
      "  }\n"
      "  if ($name$_.isEmpty()) {\n"
      "    $name$_ = new java.util.ArrayList<$type$>();\n"
      "  }\n"
      "  $name$_.add(value);\n"
      "  return this;\n"
      "}\n"
      "public $message_name$ clear$capitalized_name$() {\n"
      "  $name$_ = java.util.Collections.emptyList();\n"
      "  return this;\n"
      "}\n");
  }
}

void RepeatedMessageFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  if (params_.java_use_vector()) {
    printer->Print(variables_,
      "if (other.$name$_.size() != 0) {\n"
      "  for (int i = 0; i < other.$name$_.size(); i++) {\n"
      "    result.$name$_.addElement(other.$name$_.elementAt(i));\n"
      "  }\n"
      "}\n");
  } else {
    printer->Print(variables_,
      "if (!other.$name$_.isEmpty()) {\n"
      "  if (result.$name$_.isEmpty()) {\n"
      "    result.$name$_ = new java.util.ArrayList<$type$>();\n"
      "  }\n"
      "  result.$name$_.addAll(other.$name$_);\n"
      "}\n");
  }
}

void RepeatedMessageFieldGenerator::
GenerateParsingCode(io::Printer* printer) const {
  printer->Print(variables_,
    "$type$ value = new $type$();\n");

  if (descriptor_->type() == FieldDescriptor::TYPE_GROUP) {
    printer->Print(variables_,
      "input.readGroup(value, $number$);\n");
  } else {
    printer->Print(variables_,
      "input.readMessage(value);\n");
  }

  printer->Print(variables_,
    "add$capitalized_name$(value);\n");
}

void RepeatedMessageFieldGenerator::
GenerateSerializationCode(io::Printer* printer) const {
  if (params_.java_use_vector()) {
    printer->Print(variables_,
      "for (int i = 0; i < get$capitalized_name$List().size(); i++) {\n"
      "  output.write$group_or_message$($number$, get$capitalized_name$(i));\n"
      "}\n");
  } else {
    printer->Print(variables_,
      "for ($type$ element : get$capitalized_name$List()) {\n"
      "  output.write$group_or_message$($number$, element);\n"
      "}\n");
  }
}

void RepeatedMessageFieldGenerator::
GenerateSerializedSizeCode(io::Printer* printer) const {
  if (params_.java_use_vector()) {
    printer->Print(variables_,
      "for (int i = 0; i < get$capitalized_name$List().size(); i++) {\n"
      "  size += com.google.protobuf.micro.CodedOutputStreamMicro\n"
      "    .compute$group_or_message$Size($number$, get$capitalized_name$(i));\n"
      "}\n");
  } else {
    printer->Print(variables_,
      "for ($type$ element : get$capitalized_name$List()) {\n"
      "  size += com.google.protobuf.micro.CodedOutputStreamMicro\n"
      "    .compute$group_or_message$Size($number$, element);\n"
      "}\n");
  }
}

string RepeatedMessageFieldGenerator::GetBoxedType() const {
  return ClassName(params_, descriptor_->message_type());
}

}  // namespace javamicro
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
