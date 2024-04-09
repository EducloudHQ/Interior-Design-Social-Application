import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: [
                        Color(0xFFFBDA61),
                        Color(0xFFFF5ACD),

                      ]

                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child:  CachedNetworkImage(
                      width: 80,
                      height: 80,
                      imageUrl:" profileModel.profilePicUrl",
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.asset("assets/avatars/Image-71.jpg",width: 60,height: 60,fit: BoxFit.cover,),
                      ),
                    ),

                  ),
                  Container(

                    child: const Text(" Rosius Ndimofor" ,
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                  Expanded(
                    child: Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: const Row(
                              children: [
                                Text('170',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                Text(' '),
                                Text('Followers',style: TextStyle(fontSize: 12),)
                              ],
                            ),
                          ),
                          Container(
                            child: const Row(
                              children: [
                                Text('6',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                Text(' '),
                                Text('Followings',style: TextStyle(fontSize: 12))
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Bed Rooms'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Living Rooms'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Kitchens'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Bedrooms'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}