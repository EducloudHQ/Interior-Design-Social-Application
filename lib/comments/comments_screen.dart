import 'dart:async';
import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/Comment.dart';
import '../models/Post.dart';

import '../screens/Config.dart';
import '../utils/gradient_text.dart';
import '../utils/validations.dart';
import 'comment_item.dart';
import 'comments_repository.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({required this.userId,required this.postItem});
  final String userId;
 final Post postItem;
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  late final Stream<GraphQLResponse<String>> commentStream;

  Future<void> subscribeToComments(CommentsRepository commentsRepo) async {

    String graphQLDocument = '''
  subscription createdComment {
  createdComment {
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
      profilePicKey
      updatedOn
      userType
      username
    }
    userId
  }
}


''';
  
    commentStream= Amplify.API.subscribe(
      GraphQLRequest<String>(
        document: graphQLDocument,
        apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",

      ),
      onEstablished: () => print('Subscription established'),
    );



    try {
      await for (var event in commentStream) {
        print("comment stream $event");
       Map jsonComment = json.decode(event.data!);
      Comment commentItem = Comment.fromJson(jsonComment['createdComment']);

        if (kDebugMode) {
          print("event message data is ${event.data}");
        }
        if (commentsRepo.comments.isNotEmpty) {
          if (commentsRepo.comments[0].id != commentItem.id) {

            commentsRepo.comment =  commentItem;


          }
        } else {

          commentsRepo.comment =  commentItem;

        }
        if (kDebugMode) {
          //  print("all list messages are $chatMessagesList");
          print('Subscription event data received: ${event.data}');
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error in subscription stream: $e');
      }
    }
  }

  @override
void initState(){
  var commentsRepo = context.read<CommentsRepository>();

  Future.delayed(Duration.zero).then((_) async {

    subscribeToComments(commentsRepo);
    commentsRepo.getAllComments(widget.postItem.id,10, "null");
  });



  super.initState();

  }
@override
void dispose(){
    commentStream.drain();
  super.dispose();


}

  Widget buildInput(CommentsRepository commentsRepository) {

    return
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            children: <Widget>[
              // Button send image


              // Edit text
              Flexible(
                child: Container(


                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          maxLines: null,
                          onChanged: (String text) {
                            if (text.trim().isNotEmpty) {

                            } else {



                            }
                          },


                          style: TextStyle( fontSize: 15.0),
                          controller: commentsRepository.commentController,
                          decoration: const InputDecoration(
                            hintText: 'leave a comment....',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

             commentsRepository.loading ? Container(
               margin: const EdgeInsets.symmetric(horizontal: 8.0),
               child: const CircularProgressIndicator(),
             ):
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),

                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin:
                          Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: [
                            Color(0xFFFBDA61),
                            Color(0xFFFF5ACD),
                          ])),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      commentsRepository.createComment(widget.postItem.id,widget.postItem.userId, commentsRepository.commentController.text);
                    },
                    color: Colors.white,
                  ),
                ),
              ),

            ],


          ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    var commentsRepo = context.watch<CommentsRepository>();
    return Scaffold(

        appBar: AppBar(title: const GradientText(
          'Comments',
          style: TextStyle(fontSize: 20,fontFamily: 'BungeeShade-Regular',
              fontWeight: FontWeight.bold),
          gradient: LinearGradient(colors: [
            Color(0xFFFBDA61),
            Color(0xFFFF5ACD),
          ]),
        ),centerTitle: true,),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(

                itemBuilder: (context,index){

                  if(index == 0){
                    return  Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: const Color(0xFFFF5ACD),
                                          ),
                                          borderRadius: BorderRadius.circular(100)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CachedNetworkImage(
                                            width: 40.0,
                                            height: 40.0,
                                            fit: BoxFit.cover,
                                            imageUrl: "${Config.CLOUD_FRONT_DISTRO}${widget.postItem.user.profilePicKey}",
                                            placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                            errorWidget: (context, url, ex) =>
                                                CircleAvatar(
                                                  backgroundColor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  child: const Icon(
                                                    Icons.account_circle,
                                                  ),
                                                )),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Text(widget.postItem.user.firstName,
                                            style: const TextStyle(fontSize: 16)),
                                        Container(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: Text('@${widget.postItem.user.username}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFFFBDA61),
                                                    fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                timeago.format(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(widget.postItem.createdOn.toString()))),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          Container(
                              width: size.width,
                              height: size.height / 3.5,
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child:ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            width: size.width / 2,
                                            height: size.height / 3.5,
                                            fit: BoxFit.cover,
                                            imageUrl: "${Config.CLOUD_FRONT_DISTRO}${widget.postItem.imageKeys[0]}",
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget: (context, url, error) =>
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Icon(
                                                    Icons.image,
                                                  ),
                                                ),
                                          ),
                                        )),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      width: size.width / 2,
                                      height: size.height / 3.5,
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(bottom: 5),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  width: size.width / 2,
                                                  height: size.height / 7.5,
                                                  fit: BoxFit.cover,
                                                  imageUrl: "${Config.CLOUD_FRONT_DISTRO}${widget.postItem.imageKeys[1]}",
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) =>
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(1000),
                                                        child: Icon(
                                                          Icons.image,
                                                          size: 50,
                                                        ),
                                                      ),
                                                ),
                                              )),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        width: size.width / 2,
                                        height: size.height / 8.4,
                                        fit: BoxFit.cover,
                                        imageUrl: "${Config.CLOUD_FRONT_DISTRO}${widget.postItem.imageKeys[2]}",
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(1000),
                                              child: Icon(
                                                Icons.image,
                                                size: 50,
                                              ),
                                            ),
                                      ),
                                    ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            child: Row(
                              children: [Text("#interior")],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Prompt",
                                  style: TextStyle(
                                    color: Color(0xFFFF5ACD),
                                  ),
                                ),
                                Container(
                                    height: 100,
                                    child: Text(widget.postItem.content, style: TextStyle(fontSize: 15),)),
                              ],
                            ),
                          ),

                        ],
                      ),
                    );
                  }else{
                    index -= 1;

              return commentsRepo.comments.isEmpty ?  Container(color: Colors.red,):
                CommentItem(commentItem:commentsRepo.comments[index]);
                  }

                },itemCount:commentsRepo.comments.length+1 ,),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 30),
                child: buildInput(commentsRepo))
          ],
        )
    );
  }
}