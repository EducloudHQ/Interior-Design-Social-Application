import 'dart:async';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/Post.dart';

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

 late StreamSubscription commentStream;
@override
void initState(){
  var commentsRepo = context.read<CommentsRepository>();



/*
  commentStream = Amplify.DataStore.observeQuery(Comment.classType,sortBy: [Task.CREATEDON.descending()],where:Comment.TASKID.eq(widget.task.id) )
      .listen((QuerySnapshot<Comment> event) {
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
                        Container(
                        padding: const EdgeInsets.all(10),
                        child:  Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [

                                    Container(

                                      decoration: BoxDecoration(

                                          border: Border.all(width: 2,color: const Color(0xFFFF5ACD),),
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: ClipOval(
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                30),
                                            child:  CachedNetworkImage(
                                                width: 40.0,
                                                height: 40.0,
                                                fit: BoxFit.cover,
                                                imageUrl:widget.postItem.user.profilePicUrl??'',
                                                placeholder: (context,
                                                    url) =>
                                                const CircularProgressIndicator(),
                                                errorWidget: (context,
                                                    url, ex) =>
                                                    CircleAvatar(
                                                      backgroundColor:
                                                      Theme.of(
                                                          context)
                                                          .colorScheme.secondary,

                                                      child: const Icon(
                                                        Icons
                                                            .account_circle,


                                                      ),
                                                    )),
                                          )),
                                    ),
                                    Container(

                                      margin: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Text(widget.postItem.user.firstName,style: const TextStyle(fontSize: 16)),
                                          Container(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Text('@${widget.postItem.user.username}',style:  TextStyle(fontSize: 12,color:Color(0xFFFBDA61),fontWeight: FontWeight.bold))),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                                Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.postItem.createdOn.toString()))),style: const TextStyle(color: Colors.grey,fontSize: 12,),)

                              ],
                            ),

                            Container(
                                width: size.width,

                                height: size.height/2.5,
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex:1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: CachedNetworkImage(
                                            width: size.width/2,
                                            height: size.height/2.5,

                                            fit: BoxFit.cover,
                                            imageUrl:widget.postItem.imageUrls[0],
                                            placeholder: (context, url) => CircularProgressIndicator(),
                                            errorWidget: (context, url, error) => ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Icon(Icons.image,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex:1,
                                      child: Container(
                                        width: size.width/2,
                                        height: size.height/2.5,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(bottom: 5),
                                              child: ClipRRect(

                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  width: size.width/2,

                                                  height: size.height/5,
                                                  fit: BoxFit.cover,
                                                  imageUrl:widget.postItem.imageUrls[1],
                                                  placeholder: (context, url) => CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) => ClipRRect(
                                                    borderRadius: BorderRadius.circular(1000),
                                                    child: Icon(Icons.image,size: 50,),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                width: size.width/2,
                                                height: size.height/6,
                                                fit: BoxFit.cover,
                                                imageUrl:widget.postItem.imageUrls[2],
                                                placeholder: (context, url) => CircularProgressIndicator(),
                                                errorWidget: (context, url, error) => ClipRRect(
                                                  borderRadius: BorderRadius.circular(1000),
                                                  child: Icon(Icons.image,size: 50,),
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
                              padding: EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  Text("Prompt",style: TextStyle(color: Color(0xFFFF5ACD),),),
                                  Container(

                                      child: Text(widget.postItem.content,style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold),)),







                                ],
                              ),
                            ),






                          ],
                        ),

                      )
                          ],
                        ),

                      ),

                    );
                  }else{
                    index -= 1;
                return Container();
                // return CommentItem(commentItem:commentsRepo.comments[index]);
                  }

                },itemCount: 101,),
            ),
            buildInput(commentsRepo)
          ],
        )
    );
  }
}