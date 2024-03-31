import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/Comment.dart';
import '../repositories/profile_repository.dart';
class CommentItem  extends StatelessWidget {
   CommentItem({required this.commentItem});
   final Comment commentItem;







  @override
  Widget build(BuildContext context) {
    // TODO: implement buildCommentItem
    return Container(

      margin: const EdgeInsets.only(left: 40,right: 10),
      child:  Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(

                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2,color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: ClipOval(
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(
                            30),
                        child:  CachedNetworkImage(
                            width: 30.0,
                            height: 30.0,
                            fit: BoxFit.cover,
                            imageUrl: commentItem.user!.profilePicUrl,
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
                                    color:
                                    Colors.white,

                                  ),
                                )),
                      )),
                ),

                Container(

                  padding: EdgeInsets.only(left: 5),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(commentItem.user!.firstName,style: const TextStyle()),
                      Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text('@${commentItem.user!.username}',style:  TextStyle(fontSize: 12,color:Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold))),
                    ],
                  ),



                ),



              ],
            ),

            Container(

              margin:EdgeInsets.only(left: 55),
              child:
              Text((commentItem.comment),
            )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(commentItem.createdOn.toSeconds() * 1000)),style: const TextStyle(color: Colors.grey,fontSize: 12,),)

                ],
              ),
            )


          ],
        ),





          ],
        ),
      ),

    );
  }


}