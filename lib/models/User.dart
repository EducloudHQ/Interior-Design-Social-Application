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
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _username;
  final String? _profilePicUrl;
  final TemporalTimestamp? _createdOn;
  final List<Task>? _Tasks;
  final List<Comment>? _Comments;
  final String? _firstName;
  final String? _lastName;
  final String? _email;
  final String? _profilePicKey;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get profilePicUrl {
    return _profilePicUrl;
  }
  
  TemporalTimestamp? get createdOn {
    return _createdOn;
  }
  
  List<Task>? get Tasks {
    return _Tasks;
  }
  
  List<Comment>? get Comments {
    return _Comments;
  }
  
  String? get firstName {
    return _firstName;
  }
  
  String? get lastName {
    return _lastName;
  }
  
  String? get email {
    return _email;
  }
  
  String get profilePicKey {
    try {
      return _profilePicKey!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, required username, profilePicUrl, createdOn, Tasks, Comments, firstName, lastName, email, required profilePicKey, createdAt, updatedAt}): _username = username, _profilePicUrl = profilePicUrl, _createdOn = createdOn, _Tasks = Tasks, _Comments = Comments, _firstName = firstName, _lastName = lastName, _email = email, _profilePicKey = profilePicKey, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String username, String? profilePicUrl, TemporalTimestamp? createdOn, List<Task>? Tasks, List<Comment>? Comments, String? firstName, String? lastName, String? email, required String profilePicKey}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      profilePicUrl: profilePicUrl,
      createdOn: createdOn,
      Tasks: Tasks != null ? List<Task>.unmodifiable(Tasks) : Tasks,
      Comments: Comments != null ? List<Comment>.unmodifiable(Comments) : Comments,
      firstName: firstName,
      lastName: lastName,
      email: email,
      profilePicKey: profilePicKey);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _username == other._username &&
      _profilePicUrl == other._profilePicUrl &&
      _createdOn == other._createdOn &&
      DeepCollectionEquality().equals(_Tasks, other._Tasks) &&
      DeepCollectionEquality().equals(_Comments, other._Comments) &&
      _firstName == other._firstName &&
      _lastName == other._lastName &&
      _email == other._email &&
      _profilePicKey == other._profilePicKey;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("profilePicUrl=" + "$_profilePicUrl" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.toString() : "null") + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("profilePicKey=" + "$_profilePicKey" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? username, String? profilePicUrl, TemporalTimestamp? createdOn, List<Task>? Tasks, List<Comment>? Comments, String? firstName, String? lastName, String? email, String? profilePicKey}) {
    return User._internal(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      createdOn: createdOn ?? this.createdOn,
      Tasks: Tasks ?? this.Tasks,
      Comments: Comments ?? this.Comments,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePicKey: profilePicKey ?? this.profilePicKey);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _profilePicUrl = json['profilePicUrl'],
      _createdOn = json['createdOn'] != null ? TemporalTimestamp.fromSeconds(json['createdOn']) : null,
      _Tasks = json['Tasks'] is List
        ? (json['Tasks'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Task.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _Comments = json['Comments'] is List
        ? (json['Comments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _email = json['email'],
      _profilePicKey = json['profilePicKey'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'profilePicUrl': _profilePicUrl, 'createdOn': _createdOn?.toSeconds(), 'Tasks': _Tasks?.map((Task? e) => e?.toJson()).toList(), 'Comments': _Comments?.map((Comment? e) => e?.toJson()).toList(), 'firstName': _firstName, 'lastName': _lastName, 'email': _email, 'profilePicKey': _profilePicKey, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField PROFILEPICURL = QueryField(fieldName: "profilePicUrl");
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static final QueryField TASKS = QueryField(
    fieldName: "Tasks",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Task).toString()));
  static final QueryField COMMENTS = QueryField(
    fieldName: "Comments",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Comment).toString()));
  static final QueryField FIRSTNAME = QueryField(fieldName: "firstName");
  static final QueryField LASTNAME = QueryField(fieldName: "lastName");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PROFILEPICKEY = QueryField(fieldName: "profilePicKey");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFILEPICURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.TASKS,
      isRequired: false,
      ofModelName: (Task).toString(),
      associatedKey: Task.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.COMMENTS,
      isRequired: false,
      ofModelName: (Comment).toString(),
      associatedKey: Comment.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.FIRSTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LASTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFILEPICKEY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}