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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Post type in your schema. */
class Post {
  final List<Comment>? _comments;
  final String? _content;
  final amplify_core.TemporalTimestamp? _createdOn;
  final String id;
  final List<String>? _imageKeys;
  final List<String>? _imageUrls;
  final amplify_core.TemporalTimestamp? _updatedOn;
  final User? _user;
  final String? _userId;

  List<Comment>? get comments {
    return _comments;
  }
  
  String get content {
    try {
      return _content!;
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
  
  List<String> get imageKeys {
    try {
      return _imageKeys!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String> get imageUrls {
    try {
      return _imageUrls!;
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
  
  User get user {
    try {
      return _user!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  const Post._internal({comments, required content, required createdOn, required this.id, required imageKeys, required imageUrls, updatedOn, required user, required userId}): _comments = comments, _content = content, _createdOn = createdOn, _imageKeys = imageKeys, _imageUrls = imageUrls, _updatedOn = updatedOn, _user = user, _userId = userId;
  
  factory Post({List<Comment>? comments, required String content, required amplify_core.TemporalTimestamp createdOn, String? id, required List<String> imageKeys, required List<String> imageUrls, amplify_core.TemporalTimestamp? updatedOn, required User user, required String userId}) {
    return Post._internal(
      comments: comments != null ? List<Comment>.unmodifiable(comments) : comments,
      content: content,
      createdOn: createdOn,
      id: id == null ? amplify_core.UUID.getUUID() : id,
      imageKeys: imageKeys != null ? List<String>.unmodifiable(imageKeys) : imageKeys,
      imageUrls: imageUrls != null ? List<String>.unmodifiable(imageUrls) : imageUrls,
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
    return other is Post &&
      DeepCollectionEquality().equals(_comments, other._comments) &&
      _content == other._content &&
      _createdOn == other._createdOn &&
      id == other.id &&
      DeepCollectionEquality().equals(_imageKeys, other._imageKeys) &&
      DeepCollectionEquality().equals(_imageUrls, other._imageUrls) &&
      _updatedOn == other._updatedOn &&
      _user == other._user &&
      _userId == other._userId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Post {");
    buffer.write("comments=" + (_comments != null ? _comments!.toString() : "null") + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.toString() : "null") + ", ");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("imageKeys=" + (_imageKeys != null ? _imageKeys!.toString() : "null") + ", ");
    buffer.write("imageUrls=" + (_imageUrls != null ? _imageUrls!.toString() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.toString() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("userId=" + "$_userId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Post copyWith({List<Comment>? comments, String? content, amplify_core.TemporalTimestamp? createdOn, String? id, List<String>? imageKeys, List<String>? imageUrls, amplify_core.TemporalTimestamp? updatedOn, User? user, String? userId}) {
    return Post._internal(
      comments: comments ?? this.comments,
      content: content ?? this.content,
      createdOn: createdOn ?? this.createdOn,
      id: id ?? this.id,
      imageKeys: imageKeys ?? this.imageKeys,
      imageUrls: imageUrls ?? this.imageUrls,
      updatedOn: updatedOn ?? this.updatedOn,
      user: user ?? this.user,
      userId: userId ?? this.userId);
  }
  
  Post copyWithModelFieldValues({
    ModelFieldValue<List<Comment>>? comments,
    ModelFieldValue<String>? content,
    ModelFieldValue<amplify_core.TemporalTimestamp>? createdOn,
    ModelFieldValue<String>? id,
    ModelFieldValue<List<String>>? imageKeys,
    ModelFieldValue<List<String>>? imageUrls,
    ModelFieldValue<amplify_core.TemporalTimestamp?>? updatedOn,
    ModelFieldValue<User>? user,
    ModelFieldValue<String>? userId
  }) {
    return Post._internal(
      comments: comments == null ? this.comments : comments.value,
      content: content == null ? this.content : content.value,
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      id: id == null ? this.id : id.value,
      imageKeys: imageKeys == null ? this.imageKeys : imageKeys.value,
      imageUrls: imageUrls == null ? this.imageUrls : imageUrls.value,
      updatedOn: updatedOn == null ? this.updatedOn : updatedOn.value,
      user: user == null ? this.user : user.value,
      userId: userId == null ? this.userId : userId.value
    );
  }
  
  Post.fromJson(Map<String, dynamic> json)  
    : _comments = json['comments'] is List
        ? (json['comments'] as List)
          .where((e) => e != null)
          .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e)))
          .toList()
        : null,
      _content = json['content'],
      _createdOn = json['createdOn'] != null ? amplify_core.TemporalTimestamp.fromSeconds(json['createdOn']) : null,
      id = json['id'],
      _imageKeys = json['imageKeys']?.cast<String>(),
      _imageUrls = json['imageUrls']?.cast<String>(),
      _updatedOn = json['updatedOn'] != null ? amplify_core.TemporalTimestamp.fromSeconds(json['updatedOn']) : null,
      _user = json['user'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']))
        : null,
      _userId = json['userId'];
  
  Map<String, dynamic> toJson() => {
    'comments': _comments?.map((Comment? e) => e?.toJson()).toList(), 'content': _content, 'createdOn': _createdOn?.toSeconds(), 'id': id, 'imageKeys': _imageKeys, 'imageUrls': _imageUrls, 'updatedOn': _updatedOn?.toSeconds(), 'user': _user?.toJson(), 'userId': _userId
  };
  
  Map<String, Object?> toMap() => {
    'comments': _comments,
    'content': _content,
    'createdOn': _createdOn,
    'id': id,
    'imageKeys': _imageKeys,
    'imageUrls': _imageUrls,
    'updatedOn': _updatedOn,
    'user': _user,
    'userId': _userId
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Post";
    modelSchemaDefinition.pluralName = "Posts";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'comments',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Comment')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'content',
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
      fieldName: 'imageKeys',
      isRequired: true,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'imageUrls',
      isRequired: true,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'updatedOn',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'user',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'User')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'userId',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}