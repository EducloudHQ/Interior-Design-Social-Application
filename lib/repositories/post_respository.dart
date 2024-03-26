import 'dart:convert';
import 'dart:io';


import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../models/generate_post_image_model.dart';



class PostRepository extends ChangeNotifier{

  PostRepository.instance();

  bool _loading = false;


  bool get loading => _loading;

  List<String> _base64ImageStrings=[];
  bool _isGenerateBtnVissible= false;
  bool _isLoadingGeneratedImage =false;


  bool get isLoadingGeneratedImage => _isLoadingGeneratedImage;

  set isLoadingGeneratedImage(bool value) {
    _isLoadingGeneratedImage = value;
    notifyListeners();
  }


  List<String> get base64ImageStrings => _base64ImageStrings;

  set base64ImageStrings(List<String> value) {
    _base64ImageStrings = value;
    notifyListeners();
  }

  bool get isGenerateBtnVissible => _isGenerateBtnVissible;

  set isGenerateBtnVissible(bool value) {
    _isGenerateBtnVissible = value;
    notifyListeners();
  }



  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final contentController = TextEditingController();
  final promptController = TextEditingController();


  Future<List<String>> generateImage(String prompt) async {
    isLoadingGeneratedImage = true;
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
    isLoadingGeneratedImage = false;



    GeneratePostImage generatePostImageModel = GeneratePostImage.fromJson(json.decode(responseJson['generatePostImage']));
    if (kDebugMode) {
      print("returning ${generatePostImageModel.images!}");
    }

    return generatePostImageModel.images!;
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