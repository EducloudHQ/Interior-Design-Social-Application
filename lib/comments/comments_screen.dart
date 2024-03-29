import 'dart:async';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../repositories/profile_repository.dart';
import 'comment_item.dart';
import 'comments_repository.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
class CommentsScreen extends StatefulWidget {
  const CommentsScreen({required this.userId});
  final String userId;
 // final Task task;
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

 late StreamSubscription commentStream;
@override
void initState(){
  var commentsRepo = context.read<CommentsRepository>();



/*
  commentStream = Amplify.DataStore.observeQuery(Comment.classType,sortBy: [Task.CREATEDON.descending()],where:Comment.TASKID.eq(widget.task.id) ).listen((QuerySnapshot<Comment> event) {
    if (commentsRepo.comments.isNotEmpty) {
      if(commentsRepo.comments[0].id != event.items[0].id){
        commentsRepo.comment = event.items[0];

      }


    }else{
      commentsRepo.comments =event.items;
      if (kDebugMode) {
        print('Received post ${event.items}');
      }
    }

  });
*/
    super.initState();

  }
@override
void dispose(){
  super.dispose();
  commentStream.cancel();
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

              // Button send message
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color:Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      /*
                      if(commentsRepository.commentController.text.isNotEmpty){
                        commentsRepository.createComment(widget.userId,widget.task).then((_){
                          commentsRepository.commentController.clear();
                        });

                      }
                   */
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
    var commentsRepo = context.watch<CommentsRepository>();
    return Scaffold(

        appBar: AppBar(title: const Text("Comments",),centerTitle: true,),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(

                itemBuilder: (context,index){

                  if(index == 0){
                    return Card(

                      child:  Container(
                        padding: const EdgeInsets.all(10),
                        child:  Column(
                          children: [

                          ],
                        ),

                      ),

                    );
                  }else{
                    index -= 1;

                 return CommentItem(commentsRepo.comments[index]);
                  }

                },itemCount: 101,),
            ),
            buildInput(commentsRepo)
          ],
        )
    );
  }
}