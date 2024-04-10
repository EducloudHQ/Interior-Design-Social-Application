import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/Comment.dart';
import '../models/PostCommentsResult.dart';

class CommentsRepository extends ChangeNotifier {

  CommentsRepository.instance();



  final commentController = TextEditingController();




  bool _loading = false;
  String? _userId;
List<Comment> _comments = [];


 List<Comment> get comments => _comments;

  set comments(List<Comment> value) {
    _comments = value;
    notifyListeners();
  }

  set comment(Comment value) {
    _comments.insert(0, value);
    notifyListeners();

  }

  String? get userId => _userId;

  set userId(String? value) {
    _userId = value;
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
  }



  @override
  void dispose() {
    // TODO: implement dispose

    commentController.dispose();




    super.dispose();
  }


  Future<void> getAllComments(String postId,int limit,String nextToken) async {
    loading = true;

    print("post id is $postId");

    String graphQLDocument = '''
  
query getCommentsPerPost(\$postId:String!,\$limit:Int!,\$nextToken:String) {
  getCommentsPerPost(
    postId: \$postId
    limit: \$limit
    nextToken: \$nextToken
  ) {
    nextToken
    items {
      comment
      createdOn
      id
      postId
      updatedOn
      user {
        about
        createdOn
        email
        firstName
        id
        lastName
        profilePicUrl
        updatedOn
        userType
        username
      }
      userId
    }
  }
}

  ''';


    var operation = Amplify.API.query(
        request: GraphQLRequest<String>(
          document: graphQLDocument,
          apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
          variables: {
             "postId":postId,
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
      print("returning ${responseJson['getCommentsPerPost']}");
    }

    PostCommentsResult postCommentsResults = PostCommentsResult.fromJson(responseJson['getCommentsPerPost']);

    if (kDebugMode) {
      print("returning $postCommentsResults");
    }
    comments = postCommentsResults.items;

  }


  Future<void> createComment(String postId,String userId, String comment) async{
    loading = true;
    try {
      String graphQLDocument =
   '''
   mutation createComment(\$userId:String!,\$postId:String!,\$comment:String!) {
  createComment(
    commentInput: { userId: \$userId, postId: \$postId, comment: \$comment }
  ) {
    comment
    createdOn
    id
    postId
    updatedOn
    user {
      about
      createdOn
      email
      firstName
      lastName
      id
      profilePicUrl
      updatedOn
      userType
      username
    }
    userId
  }
}

   ''';

      var operation = Amplify.API.mutate(


          request: GraphQLRequest<String>(
            document: graphQLDocument, apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
            variables: {
              "comment": comment,
              "postId":postId,
              "userId": userId
            },));


      var response = await operation.response;
      if(response.data != null){
        final responseJson = json.decode(response.data!);
        if (kDebugMode) {
          print("here${responseJson['createComment']}");
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


}