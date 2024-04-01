import 'dart:io';

import 'package:mewtwo/base/image/cached_network_image.dart';
import 'package:flutter/material.dart';


class PostImage extends StatelessWidget {
  static const double maxWidth = 184 * 4;
  static const aspectRatio = 184 / 231;
  static const fit = BoxFit.cover;
  final String imageUrl;
  const PostImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AspectRatio(
          aspectRatio: aspectRatio,
          child: 
          imageUrl.startsWith("http") ? CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: const CircularProgressIndicator(),
              fit: fit,
              cachedWidth: maxWidth.toInt(),
              alignment: Alignment.topCenter,
            ) : Image.file(File(imageUrl), fit: PostImage.fit,));
    });
  }

}
