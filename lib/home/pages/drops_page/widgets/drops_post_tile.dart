import 'package:flutter/material.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/drops/models/drop_post_model.dart';
import 'package:mewtwo/drops/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/utils.dart';

class DropsPostTile extends StatelessWidget {
  final DropPostModel post;
  const DropsPostTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DropDetailsPageRoute(postId: post.id).push(context),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4)]),
        child: ClipRRect(
          borderRadius:
              const BorderRadiusDirectional.only(bottomEnd: Radius.circular(4), bottomStart: Radius.circular(4)),
          child: Stack(
            children: [
              Column(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      child: PostImage(imageUrl: Utility.parseImageUrl(post.images.first.image))),
                  const SizedBox(
                    height: 6,
                  ),
                  buildCardFooter(),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIsPetiteTag() {
    return Builder(builder: (context) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: const Text(
          "Petite",
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  Widget buildCardFooter() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text(
                "\$${post.price}",
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 8,
              ),
              Text("Size ${post.clothingSize}", style: const TextStyle(fontSize: 10)),
              const SizedBox(
                width: 8,
              ),
              Text(post.condition, style: const TextStyle(fontSize: 10)),
              const SizedBox(
                width: 8,
              ),
              if (post.isPetite) buildIsPetiteTag()
            ],
          )
        ],
      ),
    );
  }
}
