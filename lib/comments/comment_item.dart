import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/Comment.dart';
import '../screens/Config.dart';
class CommentItem  extends StatelessWidget {
   CommentItem({required this.commentItem});
   final Comment commentItem;


  @override
  Widget build(BuildContext context) {

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2,color: Color(0xFFFF5ACD)),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                        30),
                    child:  CachedNetworkImage(
                        width: 30.0,
                        height: 30.0,
                        fit: BoxFit.cover,
                        imageUrl: "${Config.CLOUD_FRONT_DISTRO}${commentItem.user!.profilePicKey}",
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
                  )

                 ),


                Container(

                  padding: EdgeInsets.only(left: 5),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(commentItem.user!.firstName,style: const TextStyle()),
                      Container(

                          child: Text('@${commentItem.user!.username}',style:  TextStyle(fontSize: 12,color:Color(0xFFFF5ACD),fontWeight: FontWeight.bold))),
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
                  Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(int.parse(commentItem.createdOn.toString()))),style: const TextStyle(color: Colors.grey,fontSize: 12,),)

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