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


/** This is an auto generated class representing the Comment type in your schema. */
class Comment {
  final String? _comment;
  final amplify_core.TemporalTimestamp? _createdOn;
  final String id;
  final String? _postId;
  final amplify_core.TemporalTimestamp? _updatedOn;
  final User? _user;
  final String? _userId;

  String get comment {
    try {
      return _comment!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
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
  
  String get postId {
    try {
      return _postId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalTimestamp? get updatedOn {
    return _updatedOn;
  }
  
  User? get user {
    return _user;
  }
  
  String get userId {
    try {
      return _userId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const Comment._internal({required comment, required createdOn, required this.id, required postId, updatedOn, user, required userId}): _comment = comment, _createdOn = createdOn, _postId = postId, _updatedOn = updatedOn, _user = user, _userId = userId;
  
  factory Comment({required String comment, required amplify_core.TemporalTimestamp createdOn, String? id, required String postId, amplify_core.TemporalTimestamp? updatedOn, User? user, required String userId}) {
    return Comment._internal(
      comment: comment,
      createdOn: createdOn,
      id: id == null ? amplify_core.UUID.getUUID() : id,
      postId: postId,
      updatedOn: updatedOn,
      user: user,
      userId: userId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
      _comment == other._comment &&
      _createdOn == other._createdOn &&
      id == other.id &&
      _postId == other._postId &&
      _updatedOn == other._updatedOn &&
      _user == other._user &&
      _userId == other._userId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comment {");
    buffer.write("comment=" + "$_comment" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.toString() : "null") + ", ");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("postId=" + "$_postId" + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.toString() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("userId=" + "$_userId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comment copyWith({String? comment, amplify_core.TemporalTimestamp? createdOn, String? id, String? postId, amplify_core.TemporalTimestamp? updatedOn, User? user, String? userId}) {
    return Comment._internal(
      comment: comment ?? this.comment,
      createdOn: createdOn ?? this.createdOn,
      id: id ?? this.id,
      postId: postId ?? this.postId,
      updatedOn: updatedOn ?? this.updatedOn,
      user: user ?? this.user,
      userId: userId ?? this.userId);
  }
  
  Comment copyWithModelFieldValues({
    ModelFieldValue<String>? comment,
    ModelFieldValue<amplify_core.TemporalTimestamp>? createdOn,
    ModelFieldValue<String>? id,
    ModelFieldValue<String>? postId,
    ModelFieldValue<amplify_core.TemporalTimestamp?>? updatedOn,
    ModelFieldValue<User?>? user,
    ModelFieldValue<String>? userId
  }) {
    return Comment._internal(
      comment: comment == null ? this.comment : comment.value,
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      id: id == null ? this.id : id.value,
      postId: postId == null ? this.postId : postId.value,
      updatedOn: updatedOn == null ? this.updatedOn : updatedOn.value,
      user: user == null ? this.user : user.value,
      userId: userId == null ? this.userId : userId.value
    );
  }
  
  Comment.fromJson(Map<String, dynamic> json)  
    : _comment = json['comment'],
      _createdOn = json['createdOn'] != null ? amplify_core.TemporalTimestamp.fromSeconds(json['createdOn']) : null,
      id = json['id'],
      _postId = json['postId'],
      _updatedOn = json['updatedOn'] != null ? amplify_core.TemporalTimestamp.fromSeconds(json['updatedOn']) : null,
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _userId = json['userId'];
  
  Map<String, dynamic> toJson() => {
    'comment': _comment, 'createdOn': _createdOn?.toSeconds(), 'id': id, 'postId': _postId, 'updatedOn': _updatedOn?.toSeconds(), 'user': _user?.toJson(), 'userId': _userId
  };
  
  Map<String, Object?> toMap() => {
    'comment': _comment,
    'createdOn': _createdOn,
    'id': id,
    'postId': _postId,
    'updatedOn': _updatedOn,
    'user': _user,
    'userId': _userId
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'comment',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
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
      fieldName: 'postId',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'updatedOn',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'user',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'User')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'userId',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}