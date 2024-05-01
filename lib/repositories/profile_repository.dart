import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:momento/src/errors/errors.dart';
import 'package:uuid/uuid.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:aws_common/vm.dart';

import '../models/User.dart';
import 'package:momento/momento.dart';

import '../screens/Config.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProfileRepository extends ChangeNotifier {
  final CacheClient _cacheClient;

  ProfileRepository.instance()
      : _cacheClient = CacheClient(
            CredentialProvider.fromString(dotenv.env['MOMENTO_API_KEY']!),
            CacheClientConfigurations.latest(),
            Duration(seconds: 30));

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final aboutController = TextEditingController();

  Map _userProfileCache = {};

  Map get userProfileCache => _userProfileCache;

  Future<void> setUserProfileCache(String userId, List<int> userBytes) async {
    final SetResponse setResp = await _cacheClient.setBytes(
        Config.USER_PROFILE_CACHE, userId, userBytes);

    if (setResp is CreateCacheSuccess) {
      print("successfully cached user successful!");
    } else if (setResp is SetError) {
      print("Set error: ${setResp.errorCode} ${setResp.message}");
    }
  }

  Future<User?> getUserProfileCache(String userId) async {
    final GetResponse getResp =
        await _cacheClient.get(Config.USER_PROFILE_CACHE, userId);
    if (getResp is GetHit) {
      List<int> bytes = getResp.binaryValue;

      String jsonString = utf8.decode(bytes);

      final responseJson2 = json.decode(json.decode(jsonString));

      print("this response json is ${responseJson2['getUserAccount']}");
      User userModel = User.fromJson(responseJson2['getUserAccount']);
      return userModel;
    } else if (getResp is GetHit) {
      print("Value was not found in ${Config.USER_PROFILE_CACHE}");
      return null;
    } else if (getResp is GetError) {
      print("Got an error: ${getResp.errorCode} ${getResp.message}");
      //throw getResp.errorCode;
      return null;
    }
    return null;
  }

  Future<void> createCache(String userId, List<int> userBytes) async {
    final CreateCacheResponse createResp =
        await _cacheClient.createCache(Config.USER_PROFILE_CACHE);
    if (createResp is CreateCacheSuccess) {
      setUserProfileCache(userId, userBytes);
    } else if (createResp is CreateCacheAlreadyExists) {
      setUserProfileCache(userId, userBytes);
    } else if (createResp is CreateCacheError) {
      print(
          "Cache creation error: ${createResp.errorCode} ${createResp.message}");
    }
  }

  set userProfileCache(Map value) {
    _userProfileCache = value;
  }

  bool _loading = false;
  String _userId = '';
  String _username = '';

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
  String _profilePicKey = "";

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

  void showInSnackBar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
  }

  @override
  void dispose() async {
    // TODO: implement dispose

    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    await _cacheClient.close();

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

  Future<void> uploadImage(String imageFilePath, String targetPath) async {
    var uuid = const Uuid().v1();
    final awsFile = AWSFilePlatform.fromFile(File(imageFilePath));
    try {
      final uploadResult = await Amplify.Storage.uploadFile(
        key: '$uuid.png',
        localFile: awsFile,
      ).result;

      safePrint('Uploaded file: ${uploadResult.uploadedItem.key}');
      profilePicKey = uploadResult.uploadedItem.key;

      final resultDownload = await getProfilePicDownloadUrl(key: profilePicKey);
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
      loading = false;
      safePrint('Error uploading file: ${e.message}');
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try {
      Amplify.Auth.signOut();
      return logout = true;
    } on AuthException catch (e) {
      print(e.message);
      return logout = false;
    }
  }

  Future<AuthUser> retrieveCurrentUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
  }

  Future<void> saveUserDetails(String email) async {
    loading = true;

    try {
      String graphQLDocument = '''
    mutation createUserAccount(\$username:String!,\$firstName:String!,\$lastName:String!,
    \$email:AWSEmail!,\$userType:USERTYPE!,\$profilePicUrl:String!,\$about:String!,\$profilePicKey:String!) {
  createUserAccount(
    userInput: {
      username: \$username
      firstName: \$firstName
      lastName: \$lastName
      email: \$email
      about:\$about
      userType: \$userType
      profilePicKey:\$profilePicKey
      profilePicUrl: \$profilePicUrl
    }
  ) {
    createdOn
    email
    firstName
    id
    about
    lastName
    profilePicKey
    profilePicUrl
    updatedOn
    userType
    username
  }
}

    
    ''';

      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(
        document: graphQLDocument,
        apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
        variables: {
          "username": usernameController.text,
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "about": aboutController.text,
          "email": email,
          "userType": "ADMIN",
          "profilePicUrl": profilePic,
          "profilePicKey": profilePicKey
        },
      ));

      var response = await operation.response;
      if (kDebugMode) {
        print("response operation $response");
      }
      if (response.data != null) {
        final responseJson = json.decode(response.data!);
        if (kDebugMode) {
          print("here${responseJson['createUserAccount']}");
        }
        loading = false;
      } else {
        if (kDebugMode) {
          print("something happened");
        }
        loading = false;
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      loading = false;
    }
  }

  Future<User> getUserAccount(String id) async {
    loading = true;

    User? user = await getUserProfileCache(id);
    if (user != null) {
      print("this is the first");
      return user;
    } else {
      String graphQLDocument = '''
    
      query getUserAccount(\$id:String!) {
  getUserAccount(id:\$id ) {
  about
  createdOn
  email
  firstName
  id
  lastName
  profilePicUrl
  profilePicKey
   userType
    username
  updatedOn
  }
}
    ''';

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
        document: graphQLDocument,
        apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
        variables: {
          "id": id,
        },
      ));

      var response = await operation.response;

      final responseJson = json.decode(response.data!);

      loading = false;

      print("returning ${responseJson['getUserAccount']}");

      User userModel = User.fromJson(responseJson['getUserAccount']);
      if (kDebugMode) {
        print("returning ${userModel.email}");
      }

      //save cache
      List<int> bytes = utf8.encode(json.encode(response.data!));

      //create cache and set key value pair
      createCache(userModel.id, bytes);

      return userModel;
    }
  }
}
