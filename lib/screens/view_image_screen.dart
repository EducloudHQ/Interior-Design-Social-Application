import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_media/main.dart';
import 'package:social_media/screens/Config.dart';
class ViewImageScreen extends StatelessWidget {
  const ViewImageScreen(this.imageKey);
  final String imageKey;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: imageKey,
        child: CachedNetworkImage(

          fit: BoxFit.cover,
          imageUrl: "${Config.CLOUD_FRONT_DISTRO}${imageKey}",
          placeholder: (context, url) =>
              const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: const Icon(
                  Icons.image,
                  size: 50,
                ),
              ),
        ),
      ),
    );
  }
}
