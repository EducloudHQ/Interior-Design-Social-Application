import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:social_media/repositories/profile_repository.dart';
import 'package:social_media/screens/post_item.dart';
import 'package:social_media/screens/shimmers/shimmer_profile_screen.dart';

import '../models/User.dart';
import '../repositories/post_respository.dart';
import 'Config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.email, super.key});
  final String email;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var postRepo = context.read<PostRepository>();
    Future.delayed(Duration.zero).then((_) async {
      postRepo.getAllPosts(10);
    });
  }

  @override
  Widget build(BuildContext context) {

    PostRepository postRepository = context.watch<PostRepository>();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return FutureProvider<User?>(
                  create: (_) => ProfileRepository.instance()
                      .getUserAccount("2euHfh8r1WwhhrjmDiO7UJRRRyc"),
                  initialData: null,
                  catchError: (context, error) {
                    throw error!;
                  },
                  child: Consumer(
                    builder: (_, User? userModel, child) {
                      return userModel == null
                          ? ShimmerProfileScreen()
                          : SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                       child:
                                       CachedNetworkImage(
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                  imageUrl: "${Config.CLOUD_FRONT_DISTRO}${userModel.profilePicKey}",
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                    child: Image.asset(
                                                      "assets/avatars/Image-71.jpg",
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),


                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "${userModel.lastName} ${userModel.firstName}",
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  child:
                                                      Text(userModel.username),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context.push(
                                                "/userAccount/${widget.email}");
                                          },
                                          child: Container(
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
                                                    ])),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: const Row(
                                              children: [
                                                Text(
                                                  '170',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(' '),
                                                Text(
                                                  'Designs',
                                                  style: TextStyle(),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: const Row(
                                              children: [
                                                Text(
                                                  '6',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(' '),
                                                Text('Followings',
                                                    style: TextStyle())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: const Row(
                                              children: [
                                                Text(
                                                  '6',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(' '),
                                                Text(
                                                  'Followings',
                                                  style: TextStyle(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'About',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(userModel.about),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ));
            } else {
              index -= 1;
              return PostItem(postRepository.postList[index]);
            }
          },
          itemCount: postRepository.postList.length + 1,
        ));
  }
}
