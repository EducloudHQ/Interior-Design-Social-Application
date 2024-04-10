import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/repositories/post_respository.dart';
import 'package:social_media/utils/validations.dart';
import '../models/Post.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../utils/expandable_text.dart';

class PostItem extends StatelessWidget {
  const PostItem(this.postItem);
  final Post postItem;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: const Color(0xFFFF5ACD),
                          ),
                          borderRadius: BorderRadius.circular(100)),
                      child: FutureProvider<String?>.value(
                          value: Validations.getProfilePicDownloadUrl(
                              key: postItem.user.profilePicKey),
                          initialData: '',
                          child: Consumer(builder: (BuildContext context,
                              String? profilePicUrl, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                  imageUrl: profilePicUrl ?? '',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, ex) =>
                                      CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        child: const Icon(
                                          Icons.account_circle,
                                        ),
                                      )),
                            );
                          }))),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(postItem.user.firstName,
                            style: const TextStyle(fontSize: 16)),
                        Container(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('@${postItem.user.username}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFBDA61),
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                timeago.format(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(postItem.createdOn.toString()))),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          ),
          Container(
              width: size.width,
              height: size.height / 3.5,
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: FutureProvider<String?>.value(
                            value: Validations.getProfilePicDownloadUrl(
                                key: postItem.imageKeys[0]),
                            initialData: '',
                            child: Consumer(builder: (BuildContext context,
                                String? imagePicUrl, child) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  width: size.width / 2,
                                  height: size.height / 3.5,
                                  fit: BoxFit.cover,
                                  imageUrl: imagePicUrl!,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Icon(
                                      Icons.image,
                                    ),
                                  ),
                                ),
                              );
                            }))),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: size.width / 2,
                      height: size.height / 3.5,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: FutureProvider<String?>.value(
                                  value:
                                  Validations.getProfilePicDownloadUrl(
                                          key: postItem.imageKeys[1]),
                                  initialData: '',
                                  child: Consumer(builder:
                                      (BuildContext context,
                                          String? imagePicUrl, child) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        width: size.width / 2,
                                        height: size.height / 7.5,
                                        fit: BoxFit.cover,
                                        imageUrl: imagePicUrl!,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: Icon(
                                            Icons.image,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    );
                                  }))),
                          FutureProvider<String?>.value(
                              value: Validations.getProfilePicDownloadUrl(
                                  key: postItem.imageKeys[2]),
                              initialData: '',
                              child: Consumer(builder: (BuildContext context,
                                  String? imagePicUrl, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    width: size.width / 2,
                                    height: size.height / 8.4,
                                    fit: BoxFit.cover,
                                    imageUrl: imagePicUrl!,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Icon(
                                        Icons.image,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Container(
            child: Row(
              children: [Text("#interior")],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prompt",
                  style: TextStyle(
                    color: Color(0xFFFF5ACD),
                  ),
                ),
                Container(
                    height: 100,
                    child: ExpandableText(postItem.content, trimLines: 3)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.secondary)),
              InkWell(
                onTap: () => context.push('/post/${postItem.userId}/comments',
                    extra: postItem),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/comment.svg',
                        height: 35, width: 35, color: Color(0xFFFF5ACD)),
                    const Text('comments',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFFFF5ACD)))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
