import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/Post.dart';

import 'package:timeago/timeago.dart' as timeago;


class PostItem extends StatelessWidget {
 const PostItem(this.postItem);
 final Post postItem;


  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    return   Container(
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

        border: Border.all(width: 2,color: Color(0xFFFF5ACD),),
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
                          child: Text('@${postItem.user.username}',style:  TextStyle(fontSize: 12,color:Color(0xFFFBDA61),fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),


              ],
            ),
            Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(int.parse(postItem.createdOn.toString()))),style: const TextStyle(color: Colors.grey,fontSize: 12,),)

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
                            imageUrl:postItem.imageUrls[0],
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
                                  imageUrl:postItem.imageUrls[1],
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
                                imageUrl:postItem.imageUrls[2],
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

                        child: Text(postItem.content,style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold),)),







                  ],
                ),
          ),


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

      );


  }
}