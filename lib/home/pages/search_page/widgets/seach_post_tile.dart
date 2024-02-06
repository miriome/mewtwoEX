
import 'package:flutter/material.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/base/widgets/shoppable_icon.dart';
import 'package:mewtwo/home/model/post_model.dart';

class SearchPostTile extends StatelessWidget {
  final PostModel post;
  final void Function() onTap;

  const SearchPostTile({Key? key, required this.post, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4)]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              children: [
                PostImage(imageUrl: post.image),
                if (post.chat_enabled) const PositionedDirectional(bottom: 6, start: 6, child: ShoppableIcon(size: 16,)),
              ],
            )),
      ),
    );
  }
}
