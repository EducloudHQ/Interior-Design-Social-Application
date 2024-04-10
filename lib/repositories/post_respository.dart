import 'dart:convert';
import 'dart:io';

import 'package:social_media/models/ModelProvider.dart';
import 'package:uuid/uuid.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../models/generate_post_image_model.dart';
import '../utils/validations.dart';



class PostRepository extends ChangeNotifier{

  PostRepository.instance();

  bool _loading = false;


  bool get loading => _loading;

  List<String> _base64ImageStrings=[];
  bool _isGenerateBtnVissible= false;
  bool _isLoadingGeneratedImage =false;
  List<String> _postImageKeys =[];
  List<String>_postImageUrls =[];

  List<Post> _postList = [];


  List<Post> get postList => _postList;

  set postList(List<Post> value) {
    _postList = value;
    notifyListeners();
  }

  set singlePost(Post post) {

    _postList.insert(0, post);
    notifyListeners();
  }

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
      await Validations.getProfilePicDownloadUrl(key: uploadResult.uploadedItem.key);
      if (kDebugMode) {
        print(resultDownload);
      }


      return resultDownload;
    } on StorageException catch (e) {

      safePrint('Error uploading file: ${e.message}');
      rethrow;
    }
  }

  Future<String> uploadByteImage(String base64String) async {
    List<int> bytes =base64Decode(base64String);
   String uuid = const Uuid().v4();
    try {
      final uploadResult =  await Amplify.Storage.uploadData(
        key: uuid,

        data: S3DataPayload.bytes(
         bytes,
          contentType: 'image/jpg',
        ),

      ).result;

      postImageKeys.add(uploadResult.uploadedItem.key);
      final resultDownload =
      await Validations.getProfilePicDownloadUrl(key: uploadResult.uploadedItem.key);
      if (kDebugMode) {
        print(resultDownload);
      }


     return resultDownload;
    } on StorageException catch (e) {

      safePrint('Error uploading file: ${e.message}');
      rethrow;
    }
  }



  Future<List<String>> generateImage(String prompt) async {
    isLoadingGeneratedImage = true;
    String graphQLDocument = '''query  generatePostImages(\$prompt: String!) {

   generatePostImages(prompt: \$prompt)
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
    print("$response");

    final responseJson = json.decode(response.data!);
    isLoadingGeneratedImage = false;



    GeneratePostImage generatePostImageModel = GeneratePostImage.fromJson(json.decode(responseJson['generatePostImages']));
    if (kDebugMode) {
      print("returning ${generatePostImageModel.images!}");
    }

    return generatePostImageModel.images!;
  }

  Future<void> getAllPosts(int limit) async {
   loading = true;
    String graphQLDocument = '''
    query getAllPosts(\$limit:Int!, \$nextToken:String) {
  getAllPosts(limit: \$limit, nextToken: \$nextToken) {
   items {
      content
      createdOn
      id
      imageKeys
      imageUrls
      updatedOn
      userId
      comments {
        comment
        createdOn
        id
        postId
        updatedOn
        userId
        user {
          about
          address {
            city
            country
            street
            zip
          }
          createdOn
          email
          firstName
          id
          lastName
          profilePicUrl
          profilePicKey
          updatedOn
          userType
          username
        }
      }
      user {
        about
        createdOn
        email
        firstName
        id
        updatedOn
        userType
        username
        profilePicUrl
         profilePicKey
        lastName
      }
    }
    nextToken
  }
}
''';

    var operation = Amplify.API.query(
        request: GraphQLRequest<String>(
          document: graphQLDocument,
          apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
          variables: {
            "limit": limit,
            "nextToken":null,

          },
        ));

    var response = await operation.response;
   if (kDebugMode) {
     print("returning ${response}");
   }

    final responseJson = json.decode(response.data!);
    loading = false;

   if (kDebugMode) {
     print("returning ${responseJson['getAllPosts']}");
   }

    PostsResult postsResults = PostsResult.fromJson(responseJson['getAllPosts']);

   if (kDebugMode) {
     print("returning ${postsResults.items[0]}");
   }
   postList = postsResults.items;
   // return postsResults;
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
      await uploadByteImage(base64ImageStrings[i]).then((String value) {

        postImageUrls.add(value);

        if(i ==base64ImageStrings.length-1)  {
          if (kDebugMode) {
            print("image length is ${postImageUrls.length}");
          }
          loading = false;
         savePostDetails(promptController.text, userId);
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
 user {
      createdOn
      email
      firstName
      about
      id
      lastName
      userType
      updatedOn
      profilePicUrl
       profilePicKey
      username
    }
    updatedOn
    imageKeys
    createdOn
    content
    id
    imageUrls
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