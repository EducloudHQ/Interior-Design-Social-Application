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


/** This is an auto generated class representing the Message type in your schema. */
class Message {
  final amplify_core.TemporalTimestamp? _createdOn;
  final String id;
  final String? _image;
  final MESSAGETYPE? _messageType;
  final bool? _read;
  final String? _receiverId;
  final String? _senderId;
  final String? _text;

  amplify_core.TemporalTimestamp get createdOn {
    try {
      return _createdOn!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get image {
    return _image;
  }

  MESSAGETYPE get messageType {
    try {
      return _messageType!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get read {
    try {
      return _read!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
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
  
  String? get text {
    return _text;
  }
  
  const Message._internal({required createdOn, required this.id, image, required messageType, required read, required receiverId, required senderId, text}): _createdOn = createdOn, _image = image, _messageType = messageType, _read = read, _receiverId = receiverId, _senderId = senderId, _text = text;
  
  factory Message({required amplify_core.TemporalTimestamp createdOn, String? id, String? image, required MESSAGETYPE messageType, required bool read, required String receiverId, required String senderId, String? text}) {
    return Message._internal(
      createdOn: createdOn,
      id: id == null ? amplify_core.UUID.getUUID() : id,
      image: image,
      messageType: messageType,
      read: read,
      receiverId: receiverId,
      senderId: senderId,
      text: text);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
      _createdOn == other._createdOn &&
      id == other.id &&
      _image == other._image &&
      _messageType == other._messageType &&
      _read == other._read &&
      _receiverId == other._receiverId &&
      _senderId == other._senderId &&
      _text == other._text;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Message {");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.toString() : "null") + ", ");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("messageType=" + (_messageType != null ? amplify_core.enumToString(_messageType)! : "null") + ", ");
    buffer.write("read=" + (_read != null ? _read!.toString() : "null") + ", ");
    buffer.write("receiverId=" + "$_receiverId" + ", ");
    buffer.write("senderId=" + "$_senderId" + ", ");
    buffer.write("text=" + "$_text");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Message copyWith({amplify_core.TemporalTimestamp? createdOn, String? id, String? image, MESSAGETYPE? messageType, bool? read, String? receiverId, String? senderId, String? text}) {
    return Message._internal(
      createdOn: createdOn ?? this.createdOn,
      id: id ?? this.id,
      image: image ?? this.image,
      messageType: messageType ?? this.messageType,
      read: read ?? this.read,
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text);
  }
  
  Message copyWithModelFieldValues({
    ModelFieldValue<amplify_core.TemporalTimestamp>? createdOn,
    ModelFieldValue<String>? id,
    ModelFieldValue<String?>? image,
    ModelFieldValue<MESSAGETYPE>? messageType,
    ModelFieldValue<bool>? read,
    ModelFieldValue<String>? receiverId,
    ModelFieldValue<String>? senderId,
    ModelFieldValue<String?>? text
  }) {
    return Message._internal(
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      id: id == null ? this.id : id.value,
      image: image == null ? this.image : image.value,
      messageType: messageType == null ? this.messageType : messageType.value,
      read: read == null ? this.read : read.value,
      receiverId: receiverId == null ? this.receiverId : receiverId.value,
      senderId: senderId == null ? this.senderId : senderId.value,
      text: text == null ? this.text : text.value
    );
  }
  
  Message.fromJson(Map<String, dynamic> json)  
    : _createdOn = json['createdOn'] != null ? amplify_core.TemporalTimestamp.fromSeconds(json['createdOn']) : null,
      id = json['id'],
      _image = json['image'],
      _messageType = amplify_core.enumFromString<MESSAGETYPE>(json['messageType'], MESSAGETYPE.values),
      _read = json['read'],
      _receiverId = json['receiverId'],
      _senderId = json['senderId'],
      _text = json['text'];
  
  Map<String, dynamic> toJson() => {
    'createdOn': _createdOn?.toSeconds(), 'id': id, 'image': _image, 'messageType': amplify_core.enumToString(_messageType), 'read': _read, 'receiverId': _receiverId, 'senderId': _senderId, 'text': _text
  };
  
  Map<String, Object?> toMap() => {
    'createdOn': _createdOn,
    'id': id,
    'image': _image,
    'messageType': _messageType,
    'read': _read,
    'receiverId': _receiverId,
    'senderId': _senderId,
    'text': _text
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Message";
    modelSchemaDefinition.pluralName = "Messages";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'createdOn',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'id',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'image',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'messageType',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'read',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
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
      fieldName: 'text',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}