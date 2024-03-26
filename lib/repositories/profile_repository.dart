import 'dart:convert';
import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:aws_common/vm.dart';



class ProfileRepository extends ChangeNotifier {

  ProfileRepository.instance();



  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();






  bool _loading = false;
  String _userId='';
  String _username='';

  bool _logout = false;



  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }
  bool get logout => _logout;

  set logout(bool value) {
    _logout = value;
    notifyListeners();
  }

  String _profilePic = "";
  String _profilePicKey ="";


  String get profilePicKey => _profilePicKey;

  set profilePicKey(String value) {
    _profilePicKey = value;
    notifyListeners();
  }

  String get profilePic => _profilePic;

  set profilePic(String value) {
    _profilePic = value;
    notifyListeners();
  }


  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }




  void showInSnackBar(BuildContext context,String value) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle( fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
  }



  @override
  void dispose() {
    // TODO: implement dispose

    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();



    super.dispose();
  }

  Future<String> getProfilePicDownloadUrl({
    required String key,
  }) async {
    try {
      final result = await Amplify.Storage.getUrl(
        key: key,
        options: const StorageGetUrlOptions(
          accessLevel: StorageAccessLevel.guest,
          pluginOptions: S3GetUrlPluginOptions(
            validateObjectExistence: true,
            expiresIn: Duration(days: 1),
          ),
        ),
      ).result;
      return result.url.toString();
    } on StorageException catch (e) {
      safePrint('Could not get a downloadable URL: ${e.message}');
      rethrow;
    }
  }


  Future<void> uploadImage(String imageFilePath,String targetPath) async {
    var uuid =  const Uuid().v1();
    final awsFile = AWSFilePlatform.fromFile(File(imageFilePath));
    try {
      final uploadResult =  await Amplify.Storage.uploadFile(
          key: '$uuid.png',
          localFile: awsFile,

      ).result;


      safePrint('Uploaded file: ${uploadResult.uploadedItem.key}');
      profilePicKey  = uploadResult.uploadedItem.key;

      final resultDownload =
      await getProfilePicDownloadUrl(key: profilePicKey);
      if (kDebugMode) {
        print(resultDownload);
      }
      profilePic = resultDownload;
      loading = false;
      if (kDebugMode) {
        print("the key is $profilePicKey");
      }


    } on StorageException catch (e) {
      safePrint("error message is${e.message}");
      loading= false;
      safePrint('Error uploading file: ${e.message}');
      rethrow;
    }
  }

  Future<bool>signOut() async{
    try {
      Amplify.Auth.signOut();
      return logout = true;
    } on AuthException catch (e) {

      print(e.message);
      return logout  = false;
    }
  }


  Future<AuthUser>retrieveCurrentUser() async{
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
  }



}