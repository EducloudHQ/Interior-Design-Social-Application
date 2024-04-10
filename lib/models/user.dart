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


/** This is an auto generated class representing the User type in your schema. */
class User {
  final String? _about;
  final Address? _address;
  final amplify_core.TemporalTimestamp? _createdOn;
  final String? _email;
  final String? _firstName;
  final String id;
  final String? _lastName;
  final String? _profilePicUrl;
  final String? _profilePicKey;
  final amplify_core.TemporalTimestamp? _updatedOn;
  final USERTYPE? _userType;
  final String? _username;

  String get about {
    try {
      return _about!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Address? get address {
    return _address;
  }
  
  amplify_core.TemporalTimestamp? get createdOn {
    return _createdOn;
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get firstName {
    try {
      return _firstName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get lastName {
    try {
      return _lastName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get profilePicUrl {
    try {
      return _profilePicUrl!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }

  String get profilePicKey {
    try {
      return _profilePicKey!;
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

  USERTYPE get userType {
    try {
      return _userType!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const User._internal({required about, address, createdOn, required email, required firstName, required this.id, required lastName, required profilePicUrl,required profilePicKey, updatedOn, required userType, required username}): _about = about, _address = address, _createdOn = createdOn, _email = email, _firstName = firstName, _lastName = lastName, _profilePicUrl = profilePicUrl,_profilePicKey = profilePicKey, _updatedOn = updatedOn, _userType = userType, _username = username;
  
  factory User({required String about, Address? address, amplify_core.TemporalTimestamp? createdOn, required String email, required String firstName, String? id, required String lastName, required String profilePicKey, required String profilePicUrl, amplify_core.TemporalTimestamp? updatedOn, required USERTYPE userType, required String username}) {
    return User._internal(
      about: about,
      address: address,
      createdOn: createdOn,
      email: email,
      firstName: firstName,
      id: id == null ? amplify_core.UUID.getUUID() : id,
      lastName: lastName,
      profilePicUrl: profilePicUrl,
      profilePicKey: profilePicKey,
      updatedOn: updatedOn,
      userType: userType,
      username: username);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      _about == other._about &&
      _address == other._address &&
      _createdOn == other._createdOn &&
      _email == other._email &&
      _firstName == other._firstName &&
      id == other.id &&
      _lastName == other._lastName &&
      _profilePicUrl == other._profilePicUrl &&
      _profilePicKey == other._profilePicKey &&
      _updatedOn == other._updatedOn &&
      _userType == other._userType &&
      _username == other._username;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("about=" + "$_about" + ", ");
    buffer.write("address=" + (_address != null ? _address!.toString() : "null") + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.toString() : "null") + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("profilePicUrl=" + "$_profilePicUrl" + ", ");
    buffer.write("profilePicKey=" + "$_profilePicKey" + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.toString() : "null") + ", ");
    buffer.write("userType=" + (_userType != null ? amplify_core.enumToString(_userType)! : "null") + ", ");
    buffer.write("username=" + "$_username");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? about, Address? address, amplify_core.TemporalTimestamp? createdOn, String? email, String? firstName, String? id, String? lastName, String? profilePicUrl, String? profilePicKey, amplify_core.TemporalTimestamp? updatedOn, USERTYPE? userType, String? username}) {
    return User._internal(
      about: about ?? this.about,
      address: address ?? this.address,
      createdOn: createdOn ?? this.createdOn,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      id: id ?? this.id,
      lastName: lastName ?? this.lastName,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      profilePicKey: profilePicKey ?? this.profilePicKey,
      updatedOn: updatedOn ?? this.updatedOn,
      userType: userType ?? this.userType,
      username: username ?? this.username);
  }
  
  User copyWithModelFieldValues({
    ModelFieldValue<String>? about,
    ModelFieldValue<Address?>? address,
    ModelFieldValue<amplify_core.TemporalTimestamp?>? createdOn,
    ModelFieldValue<String>? email,
    ModelFieldValue<String>? firstName,
    ModelFieldValue<String>? id,
    ModelFieldValue<String>? lastName,
    ModelFieldValue<String>? profilePicUrl,
    ModelFieldValue<String>? profilePicKey,
    ModelFieldValue<amplify_core.TemporalTimestamp?>? updatedOn,
    ModelFieldValue<USERTYPE>? userType,
    ModelFieldValue<String>? username
  }) {
    return User._internal(
      about: about == null ? this.about : about.value,
      address: address == null ? this.address : address.value,
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      email: email == null ? this.email : email.value,
      firstName: firstName == null ? this.firstName : firstName.value,
      id: id == null ? this.id : id.value,
      lastName: lastName == null ? this.lastName : lastName.value,
      profilePicUrl: profilePicUrl == null ? this.profilePicUrl : profilePicUrl.value,
      profilePicKey: profilePicKey == null ? this.profilePicKey : profilePicKey.value,
      updatedOn: updatedOn == null ? this.updatedOn : updatedOn.value,
      userType: userType == null ? this.userType : userType.value,
      username: username == null ? this.username : username.value
    );
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : _about = json['about'],
      _address = json['address']?['serializedData'] != null
        ? Address.fromJson(new Map<String, dynamic>.from(json['address']['serializedData']))
        : null,
      _createdOn = json['createdOn'] != null ? amplify_core.TemporalTimestamp.fromSeconds(json['createdOn']) : null,
      _email = json['email'],
      _firstName = json['firstName'],
      id = json['id'],
      _lastName = json['lastName'],
      _profilePicUrl = json['profilePicUrl'],
      _profilePicKey = json['profilePicKey'],
      _updatedOn = json['updatedOn'] != null ? amplify_core.TemporalTimestamp.fromSeconds(json['updatedOn']) : null,
      _userType = amplify_core.enumFromString<USERTYPE>(json['userType'], USERTYPE.values),
      _username = json['username'];
  
  Map<String, dynamic> toJson() => {
    'about': _about, 'address': _address?.toJson(), 'createdOn': _createdOn?.toSeconds(), 'email': _email, 'firstName': _firstName, 'id': id, 'lastName': _lastName, 'profilePicUrl': _profilePicUrl, 'updatedOn': _updatedOn?.toSeconds(), 'userType': amplify_core.enumToString(_userType), 'username': _username
  };
  
  Map<String, Object?> toMap() => {
    'about': _about,
    'address': _address,
    'createdOn': _createdOn,
    'email': _email,
    'firstName': _firstName,
    'id': id,
    'lastName': _lastName,
    'profilePicUrl': _profilePicUrl,
    'profilePicKey': _profilePicKey,
    'updatedOn': _updatedOn,
    'userType': _userType,
    'username': _username
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'about',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'address',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Address')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'createdOn',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'email',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'firstName',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'id',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'lastName',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'profilePicUrl',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
        fieldName: 'profilePicKey',
        isRequired: true,
        ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'updatedOn',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'userType',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'username',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}