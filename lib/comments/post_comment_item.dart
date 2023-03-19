import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

import '../models/Task.dart';
import '../models/User.dart';
import '../repositories/profile_repository.dart';

class TaskCommentItem extends StatelessWidget{
  TaskCommentItem(this.task);
  final Task task;


  @override
  Widget build(BuildContext context) {
    // TODO: implement buildPostItem
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child:  Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            FutureProvider.value(value: ProfileRepository.instance().getUserProfile(task.userId!),
                catchError: (context,error){
                  print(error);
                },initialData: null,
                child: Consumer(builder: (_,User? user,child){
                  if(user != null){
                    return  Container(

                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
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
                                      imageUrl: user.profilePicUrl??"",
                                      placeholder: (context,
                                          url) =>
                                          CircularProgressIndicator(),
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
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.firstName!,style: const TextStyle(fontSize: 16,color: Colors.white)),
                               // Text(timeago.format(task.createdOn!.getDateTimeInUtc()),style: TextStyle(color: Colors.grey),)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }else{
                    return Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()
                    );
                  }
                })),


            Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(task.description!,style: TextStyle(color: Colors.white),))),

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