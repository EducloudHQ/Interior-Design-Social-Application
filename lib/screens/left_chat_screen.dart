import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../models/Message.dart';
import '../models/User.dart';
import 'Config.dart';



class LeftChatScreen extends StatelessWidget {
  LeftChatScreen({required this.message, required this.user});
  final Message message;
  final User? user;

  Widget build(BuildContext context) {
       var uuid =const Uuid();
       var id = uuid.v1();
    return
      InkWell(
          onLongPress: (){

          },
          child:  Container(

            padding: EdgeInsets.all(10),
            child: Row(

              children: [


                            Container(
                             padding: const EdgeInsets.all(10.0),
                             child: ClipOval(
                                 child: ClipRRect(
                                     borderRadius:
                                     BorderRadius.circular(
                                         100),
                                     child: CachedNetworkImage(
                                         width: 50.0,
                                         height: 50.0,
                                         fit: BoxFit.cover,
                                         imageUrl: "${Config.CLOUD_FRONT_DISTRO}${user!.profilePicKey}",
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
                                               radius: 40.0,
                                               child: const Icon(
                                                 Icons
                                                     .account_circle,
                                                 color:
                                                 Colors.white,
                                                 size: 40.0,
                                               ),
                                             )))),
                           ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(



                      width: 200.0,
                      padding: EdgeInsets.all(20),

                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                      ),
                      child:Text(message.text!,style: TextStyle(color: Colors.black),)),

                  ],
                ),
              ],
            ),
          )

      );
  }
}
