import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';
import '../utils/shared_preferences.dart';

class LoginRepository extends ChangeNotifier {
  LoginRepository.instance();

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isSignedIn = false;
  bool _loading = false;
  bool _obscureText = true;
  bool _isValidEmail = false;

  bool _success = false;

  bool get success => _success;

  set success(bool value) {
    _success = value;
    notifyListeners();
  }


  bool get isValidEmail => _isValidEmail;



  set isValidEmail(bool value) {
    _isValidEmail = value;
    notifyListeners();
  }



  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  bool _googleLoading = false;


  bool get isSignedIn => _isSignedIn;


  set isSignedIn(bool value) {
    _isSignedIn = value;
    notifyListeners();
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: const TextStyle(fontSize: 20),
    )));
  }


  bool get googleLoading => _googleLoading;

  set googleLoading(bool value) {
    _googleLoading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<User?> getUserAccountByEmail(String email) async {
    loading = true;

    String graphQLDocument = '''
    
      query getUserByEmail(\$email:String!) {
  getUserByEmail(email:\$email ) {
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
        "email": email,
      },
    ));

    var response = await operation.response;

    final responseJson = json.decode(response.data!);

    loading = false;

    print("returning ${responseJson['getUserByEmail']}");

    if (responseJson['getUserByEmail'] == null) {
      return null;
    } else {
      User userModel = User.fromJson(responseJson['getUserByEmail']);
      if (kDebugMode) {
        print("returning ${userModel.email}");
      }

      return userModel;
    }
  }

  Future<User?> googleSignIn(BuildContext context) async {
    googleLoading = true;
    try {
      var res =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);

      isSignedIn = res.isSignedIn;
      if (isSignedIn) {
        return fetchCurrentUserAttributes()
            .then((List<AuthUserAttribute> listUserAttributes) async {


          User? user;

         for (var item in listUserAttributes) {
            if (item.userAttributeKey.key == 'email') {
              user = await getUserAccountByEmail(item.value);
              //save email to shared preferences

              if (user != null) {

                await SharedPrefsUtils.instance()
                    .saveUserId(user.id);
                await SharedPrefsUtils.instance()
                    .saveUserEmail(user.email);
                googleLoading = false;
                return user;
              } else {
                await SharedPrefsUtils.instance()
                    .saveUserEmail(item.value)
                    .then((value) {
                  if (kDebugMode) {
                    print("email address saved");
                  }
                  googleLoading = false;
                  return item.value;
                });
                return user;
              }
            }
          }
          return user;
        });
      } else {
        googleLoading = false;
        return null;
      }
    } on AmplifyException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }

      googleLoading = false;
      return null;
    }
  }

  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<List<AuthUserAttribute>> fetchCurrentUserAttributes() async {
    try {
      List<AuthUserAttribute> result = await Amplify.Auth.fetchUserAttributes();

      return result;
    } on AuthException catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    passwordController.dispose();
    emailController.dispose();
  }
}
