/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the TypingIndicator type in your schema. */
class TypingIndicator {
  final String? _receiverId;
  final String? _senderId;
  final bool? _typing;

  String get receiverId {
    try {
      return _receiverId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get senderId {
    try {
      return _senderId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get typing {
    try {
      return _typing!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const TypingIndicator._internal({required receiverId, required senderId, required typing}): _receiverId = receiverId, _senderId = senderId, _typing = typing;
  
  factory TypingIndicator({required String receiverId, required String senderId, required bool typing}) {
    return TypingIndicator._internal(
      receiverId: receiverId,
      senderId: senderId,
      typing: typing);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypingIndicator &&
      _receiverId == other._receiverId &&
      _senderId == other._senderId &&
      _typing == other._typing;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TypingIndicator {");
    buffer.write("receiverId=" + "$_receiverId" + ", ");
    buffer.write("senderId=" + "$_senderId" + ", ");
    buffer.write("typing=" + (_typing != null ? _typing!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TypingIndicator copyWith({String? receiverId, String? senderId, bool? typing}) {
    return TypingIndicator._internal(
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      typing: typing ?? this.typing);
  }
  
  TypingIndicator copyWithModelFieldValues({
    ModelFieldValue<String>? receiverId,
    ModelFieldValue<String>? senderId,
    ModelFieldValue<bool>? typing
  }) {
    return TypingIndicator._internal(
      receiverId: receiverId == null ? this.receiverId : receiverId.value,
      senderId: senderId == null ? this.senderId : senderId.value,
      typing: typing == null ? this.typing : typing.value
    );
  }
  
  TypingIndicator.fromJson(Map<String, dynamic> json)  
    : _receiverId = json['receiverId'],
      _senderId = json['senderId'],
      _typing = json['typing'];
  
  Map<String, dynamic> toJson() => {
    'receiverId': _receiverId, 'senderId': _senderId, 'typing': _typing
  };
  
  Map<String, Object?> toMap() => {
    'receiverId': _receiverId,
    'senderId': _senderId,
    'typing': _typing
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TypingIndicator";
    modelSchemaDefinition.pluralName = "TypingIndicators";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'receiverId',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'senderId',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'typing',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
  });
}