import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/ModelProvider.dart';
import '../models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  //  var profileModel = context.watch<User?>();
    //User profileModel = User(id: '23423423',firstName: "Rosius",lastName: "Ndimofor",username: "ro",profilePicUrl: "", email: 'fasdfdfs', userType: USERTYPE.ADMIN);
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(


      ),

      body:SingleChildScrollView(
        child: Container(

          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child:  CachedNetworkImage(
                          width: 60,
                          height: 60,
                          imageUrl:" profileModel.profilePicUrl",
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.asset("assets/avatars/Image-71.jpg",width: 60,height: 60,fit: BoxFit.cover,),
                          ),
                        ),

                    ),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(

                            child: Text(" " ,
                              style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          ),
                          Container(

                            child: const Text("Computer Programmer",),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,

                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,

                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 1),
                            colors: [
                              Color(0xFFFBDA61),
                              Color(0xFFFF5ACD),

                            ]

                        )
                    ),
                    child:
                    const Icon(Icons.edit,color: Colors.white,),



                  ),
              

                ],
              ),
              Container(
                padding:EdgeInsets.symmetric(vertical: 10) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: const Row(
                        children: [
                          Text('170',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(' '),
                          Text('Followers',style: TextStyle(),)
                        ],
                      ),
                    ),
                    Container(
                      child: const Row(
                        children: [
                          Text('6',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(' '),
                          Text('Followings',style: TextStyle())
                        ],
                      ),
                    ),
                    Container(
                      child: const Row(
                        children: [
                          Text('6',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(' '),
                          Text('Followings',style: TextStyle(),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text('About',style: TextStyle(fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: const Text("A gradient has two anchor points, begin and end. The begin point corresponds to 0.0, and the end point corresponds to 1.0. These points are expressed in fractions, so that the same "),
                    )
                  ],
                ),
              ),

              const Row(
                children: [
                  Text("Posts"),
                  Row(

                    children: [
                      Icon(Icons.view_list_sharp),
                      Icon(Icons.grid_view_sharp)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
