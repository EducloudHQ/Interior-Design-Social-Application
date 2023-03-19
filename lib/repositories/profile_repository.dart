import 'dart:convert';
import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:amplify_core/amplify_core.dart';

import '../models/User.dart';

class ProfileRepository extends ChangeNotifier {

  ProfileRepository.instance();



  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();





  S3UploadFileOptions? options;
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


  /// save user details to profile
  ///
  Future<bool>saveUserProfileDetails(String email) async{
    loading = true;
    User newUser = User(username:usernameController.text.trim(),firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        profilePicKey: profilePicKey,

        profilePicUrl: profilePic,email: email,createdOn: TemporalTimestamp.now());

    return await Amplify.DataStore.save(newUser).then((_){
      loading = false;
      return true;
    });


  }

  Future<User>getUserProfile(String userId) async{

    List<User> user = await Amplify.DataStore.query(User.classType, where: User.EMAIL.eq(userId));

    profilePic =user[0].profilePicUrl!;


    return user[0];


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

  Future<String> getPicUrl(String pictureKey) async{
    GetUrlResult resultDownload =
        await Amplify.Storage.getUrl(key: profilePicKey);

    print('profile pic url ${resultDownload.url}');
    return resultDownload.url;

  }
  Future<void> uploadImage(String imageFilePath,String targetPath)async {
    var uuid =  const Uuid().v1();
    S3UploadFileOptions  options = S3UploadFileOptions(accessLevel: StorageAccessLevel.guest,);
    try {
      UploadFileResult result  =  await Amplify.Storage.uploadFile(
          key: uuid,
          local: File(imageFilePath),
          options: options
      );
      profilePicKey  = result.key;
      if (kDebugMode) {
        print("the key is "+profilePicKey);
      }
      GetUrlResult resultDownload =
          await Amplify.Storage.getUrl(key: profilePicKey);
      if (kDebugMode) {
        print(resultDownload.url);
      }
      profilePic = resultDownload.url;
      loading = false;

    } on StorageException catch (e) {
      print("error message is" + e.message);
      loading= false;
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