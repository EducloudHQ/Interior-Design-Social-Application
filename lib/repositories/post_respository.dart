import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';

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

  Future<String> uploadImage(String base64String) async {

   String uuid = const Uuid().v4();
    try {
      final uploadResult =  await Amplify.Storage.uploadData(
        key: uuid,

        data: S3DataPayload.string(
          base64String,
          contentType: 'text/plain',
        ),

      ).result;

      postImageKeys.add(uploadResult.uploadedItem.key);
      final resultDownload =
      await getProfilePicDownloadUrl(key: uploadResult.uploadedItem.key);
      if (kDebugMode) {
        print(resultDownload);
      }


     return resultDownload;
    } on StorageException catch (e) {

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

  Future<void> createPost(String userId) async {
    loading = true;



    for(int i = 0; i< base64ImageStrings.length; i++){
      await uploadImage(base64ImageStrings[i]).then((String value) {
        print("image value here is $value");
        postImageUrls.add(value);

        if(i ==base64ImageStrings.length-1)  {
          print("image length is ${postImageUrls.length}");
          loading = false;
         savePostDetails(contentController.text, userId);
        }
      });


    }


  }

  Future<void> savePostDetails(String content, String userId) async{

    try {
      String graphQLDocument =
      '''
      mutation createPost(\$content:String!,\$userId:String!,\$imageUrls:[String!]!, \$imageKeys:[String!]!) {
  createPost(
    postInput: {
      content: \$content,
      userId: \$userId,
   
      imageUrls: \$imageUrls,
       imageKeys: \$imageKeys
    }
  ) {
    content
    createdOn
    id
    imageUrls
    imageKeys
    updatedOn
    userId
  }
}
''';

      var operation = Amplify.API.mutate(


          request: GraphQLRequest<String>(
            document: graphQLDocument, apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
            variables: {
              "content": content,
              "imageUrls":postImageUrls,
              "imageKeys":postImageKeys,
              "userId": userId
            },));


      var response = await operation.response;
      if(response.data != null){
        final responseJson = json.decode(response.data!);
        if (kDebugMode) {
          print("here${responseJson['createPost']}");
        }
        loading = false;

      }else{
        print("something happened");
        loading = false;

      }


    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      loading = false;

    }
  }



  @override
  void dispose() {
    // TODO: implement dispose

    contentController.dispose();
    promptController.dispose();

    super.dispose();


  }


}