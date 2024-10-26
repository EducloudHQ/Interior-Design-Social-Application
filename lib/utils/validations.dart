import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class Validations{
  String? validateName(BuildContext context,String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? validateEmail(BuildContext context,String value) {
    if (value.isEmpty) return "An Email Address is required";
    final RegExp nameExp = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
    if (!nameExp.hasMatch(value)) return "Email Address is Invalid";
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'Please choose a password.';
    return null;
  }

  static Future<String> getProfilePicDownloadUrl({
    required String path,
  }) async {
    try {
      final result = await Amplify.Storage.getUrl(

        options: const StorageGetUrlOptions(

          pluginOptions: S3GetUrlPluginOptions(
            validateObjectExistence: true,
            expiresIn: Duration(days: 1),
          ),
        ), path: StoragePath.fromString(path) ,
      ).result;
      return result.url.toString();
    } on StorageException catch (e) {
      safePrint('Could not get a downloadable URL: ${e.message}');
      rethrow;
    }
  }

}