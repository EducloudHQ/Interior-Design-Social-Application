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


/** This is an auto generated class representing the Task type in your schema. */
@immutable
class Task extends Model {
  static const classType = const _TaskModelType();
  final String id;
  final bool? _isComplete;
  final int? _color;
  final String? _description;
  final String? _title;
  final String? _userId;
  final List<Comment>? _Comments;
  final TemporalTimestamp? _createdOn;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  bool? get isComplete {
    return _isComplete;
  }
  
  int? get color {
    return _color;
  }
  
  String? get description {
    return _description;
  }
  
  String? get title {
    return _title;
  }
  
  String get userId {
    try {
      return _userId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Comment>? get Comments {
    return _Comments;
  }
  
  TemporalTimestamp? get createdOn {
    return _createdOn;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Task._internal({required this.id, isComplete, color, description, title, required userId, Comments, createdOn, createdAt, updatedAt}): _isComplete = isComplete, _color = color, _description = description, _title = title, _userId = userId, _Comments = Comments, _createdOn = createdOn, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Task({String? id, bool? isComplete, int? color, String? description, String? title, required String userId, List<Comment>? Comments, TemporalTimestamp? createdOn}) {
    return Task._internal(
      id: id == null ? UUID.getUUID() : id,
      isComplete: isComplete,
      color: color,
      description: description,
      title: title,
      userId: userId,
      Comments: Comments != null ? List<Comment>.unmodifiable(Comments) : Comments,
      createdOn: createdOn);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
      id == other.id &&
      _isComplete == other._isComplete &&
      _color == other._color &&
      _description == other._description &&
      _title == other._title &&
      _userId == other._userId &&
      DeepCollectionEquality().equals(_Comments, other._Comments) &&
      _createdOn == other._createdOn;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Task {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("isComplete=" + (_isComplete != null ? _isComplete!.toString() : "null") + ", ");
    buffer.write("color=" + (_color != null ? _color!.toString() : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Task copyWith({String? id, bool? isComplete, int? color, String? description, String? title, String? userId, List<Comment>? Comments, TemporalTimestamp? createdOn}) {
    return Task._internal(
      id: id ?? this.id,
      isComplete: isComplete ?? this.isComplete,
      color: color ?? this.color,
      description: description ?? this.description,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      Comments: Comments ?? this.Comments,
      createdOn: createdOn ?? this.createdOn);
  }
  
  Task.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _isComplete = json['isComplete'],
      _color = (json['color'] as num?)?.toInt(),
      _description = json['description'],
      _title = json['title'],
      _userId = json['userId'],
      _Comments = json['Comments'] is List
        ? (json['Comments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdOn = json['createdOn'] != null ? TemporalTimestamp.fromSeconds(json['createdOn']) : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'isComplete': _isComplete, 'color': _color, 'description': _description, 'title': _title, 'userId': _userId, 'Comments': _Comments?.map((Comment? e) => e?.toJson()).toList(), 'createdOn': _createdOn?.toSeconds(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField ISCOMPLETE = QueryField(fieldName: "isComplete");
  static final QueryField COLOR = QueryField(fieldName: "color");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField COMMENTS = QueryField(
    fieldName: "Comments",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Comment).toString()));
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Task";
    modelSchemaDefinition.pluralName = "Tasks";
    
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
      key: Task.ISCOMPLETE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.COLOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Task.COMMENTS,
      isRequired: false,
      ofModelName: (Comment).toString(),
      associatedKey: Comment.TASKID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)
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

class _TaskModelType extends ModelType<Task> {
  const _TaskModelType();
  
  @override
  Task fromJson(Map<String, dynamic> jsonData) {
    return Task.fromJson(jsonData);
  }
}