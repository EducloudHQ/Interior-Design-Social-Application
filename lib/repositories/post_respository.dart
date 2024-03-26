import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:path/path.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/vm.dart';
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
  List<String> _postImageKeys =[];
  List<String>_postImageUrls =[];


  List<String> get postImageKeys => _postImageKeys;

  set postImageKeys(List<String> value) {
    _postImageKeys = value;
    notifyListeners();
  }

  List<String> get postImageUrls => _postImageUrls;

  set postImageUrls(List<String> value) {
    _postImageUrls = value;
    notifyListeners();
  }

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

  Future<void> uploadImage(String base64String,String fileKey) async {

    try {
      final uploadResult =  await Amplify.Storage.uploadData(
        key: fileKey,

        data: S3DataPayload.string(
          base64String,
          contentType: 'text/plain',
        ),

      ).result;


      safePrint('Uploaded file: ${uploadResult.uploadedItem.key}');
      postImageKeys.add(uploadResult.uploadedItem.key);
      final resultDownload =
      await getProfilePicDownloadUrl(key: uploadResult.uploadedItem.key);
      if (kDebugMode) {
        print(resultDownload);
      }

      postImageUrls.add(resultDownload);
      loading = false;
      if (kDebugMode) {
        print("the post image url is ${postImageUrls[0]}");
      }


    } on StorageException catch (e) {
      safePrint("error message is${e.message}");
      loading= false;
      safePrint('Error uploading file: ${e.message}');
      rethrow;
    }
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


  @override
  void dispose() {
    // TODO: implement dispose

    contentController.dispose();
    promptController.dispose();

    super.dispose();


  }


}