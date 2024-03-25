import 'dart:convert';
import 'dart:io';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../models/generate_post_image_model.dart';



class PostRepository extends ChangeNotifier{

  PostRepository.instance();

  bool _loading = false;


  bool get loading => _loading;

  String _base64ImageString="";


  String get base64ImageString => _base64ImageString;

  set base64ImageString(String value) {
    _base64ImageString = value;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final contentController = TextEditingController();
  final promptController = TextEditingController();


  Future<String> generateImage(String prompt) async {
    loading = true;
    String graphQLDocument = '''query  generatePostImage(\$prompt: String!) {

   generatePostImage(prompt: \$prompt)
}''';

    var operation = Amplify.API.query(
        request: GraphQLRequest<String>(
          document: graphQLDocument,
          apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
          variables: {
            "prompt": prompt,

          },
        ));

    var response = await operation.response;

    final responseJson = json.decode(response.data!);
    loading = false;



    GeneratePostImage generatePostImageModel = GeneratePostImage.fromJson(json.decode(responseJson['generatePostImage']));
    if (kDebugMode) {
      print("returning ${generatePostImageModel.images!}");
    }

    return generatePostImageModel.images![0];
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


/*
  Future<void> updateTask(String taskId) async{
    Task oldTask = (await Amplify.DataStore.query(Task.classType,
        where: Task.ID.eq(taskId)))[0];
    Task newTask = oldTask.copyWith(id: oldTask.id,
        createdOn: TemporalTimestamp.now(),
        );

    await Amplify.DataStore.save(newTask);
  }


  Future<User> retrieveUser(String userId) async{
    User user = (await Amplify.DataStore.query(User.classType, where: User.ID.eq(userId)))[0];
    return user;

  }

*/

  @override
  void dispose() {
    // TODO: implement dispose

    contentController.dispose();
    promptController.dispose();

    super.dispose();


  }


}