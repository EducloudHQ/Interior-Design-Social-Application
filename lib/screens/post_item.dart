import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import '../comments/comments_repository.dart';
import '../comments/comments_screen.dart';
import '../models/Post.dart';
import '../repositories/profile_repository.dart';
import 'package:timeago/timeago.dart' as timeago;


class PostItem extends StatelessWidget {
 const PostItem(this.postItem);
 final Post postItem;


  @override
  Widget build(BuildContext context) {

    return Card(

      child:  Container(
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

        border: Border.all(width: 2,color: Theme.of(context).colorScheme.secondary),
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
                imageUrl:postItem.user.profilePicUrl??'',
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

                  margin: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(postItem.user.firstName,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text('@${postItem.user.username}',style:  TextStyle(fontSize: 12,color:Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),


              ],
            ),
            Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(postItem.createdOn.toSeconds() * 1000)),style: const TextStyle(color: Colors.grey,fontSize: 12,),)

          ],
        ),
            Container(

              margin: const EdgeInsets.only(left: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text(postItem.content,style: const TextStyle(fontWeight: FontWeight.bold),),



                 Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       IconButton(onPressed: (){

                       }, icon:  Icon(Icons.favorite_outline_rounded,size: 30,color: Theme.of(context).colorScheme.secondary)),

                         TextButton.icon(

                          onPressed: (){

                          },
                          icon:  Icon(Icons.comment,color: Theme.of(context).colorScheme.secondary),
                          label: Text('comment',style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                        )
                      ],
                    ),





                ],
              ),
            ),

          ],
        ),

      ),

    );
  }
}