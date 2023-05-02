import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoish/models/ModelProvider.dart';

import '../comments/comments_repository.dart';
import '../comments/comments_screen.dart';
import '../repositories/profile_repository.dart';
import 'package:timeago/timeago.dart' as timeago;


class TaskItem extends StatelessWidget {
  TaskItem(this.task);

  final Task task;


  @override
  Widget build(BuildContext context) {

    return Card(

      child:  Container(
        padding: const EdgeInsets.all(10),
        child:  Column(
          children: [
            FutureProvider<User?>.value(value: ProfileRepository.instance().getUserProfile(task.userId),
                  catchError: (context,error){
                    throw error!;
                  },initialData: null,
                  child: Consumer(builder: (_,User? user,child){
                    if(user != null){
                      if(kDebugMode){
                        print('profile pic key is ${user.profilePicKey}');
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [

                              FutureProvider<String?>.value(value:ProfileRepository.instance().getProfilePicDownloadUrl(key:user.profilePicKey),
                              catchError: (context,error)=>throw error!,
                              initialData: '',
                              child: Consumer(builder: (key,String? profilePicUrl,child){
                                if(profilePicUrl != null){

                                  return  Container(

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
                                              imageUrl:user.profilePicUrl??'',
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
                                  );
                                }else{
                                  return CircleAvatar(
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
                                  );
                                }
                              },),),

                              Container(

                                margin: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Text(user.firstName!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                    Container(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text('@${user.username}',style:  TextStyle(fontSize: 12,color:Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ),


                            ],
                          ),
                          Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(task.createdOn!.toSeconds() * 1000)),style: const TextStyle(color: Colors.grey,fontSize: 12,),)

                        ],
                      );



                    }else{
                      return Row(
                        children: const [
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()
                          ),
                        ],
                      );
                    }
                  })),

            Container(

              margin: const EdgeInsets.only(left: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text(task.title!,style: const TextStyle(fontWeight: FontWeight.bold),),

                  Text(task.description!),

                 Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       IconButton(onPressed: (){

                       }, icon:  Icon(Icons.favorite_outline_rounded,size: 30,color: Theme.of(context).colorScheme.secondary)),

                         TextButton.icon(

                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ChangeNotifierProvider(create: (_) => CommentsRepository.instance(),
                                  child: CommentsScreen(userId: task.userId,task: task,));
                            }));
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