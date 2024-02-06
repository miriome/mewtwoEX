import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/base/widgets/shoppable_icon.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/profile/profile_page/profile_page_store.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/utils.dart';

class ProfilePostTile extends StatelessWidget {
  final PostModel post;
  final ProfilePageStore store;
  const ProfilePostTile({
    Key? key,
    required this.post,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return GestureDetector(
        onTap: () => PostDetailsRoute(postId: post.id).push(context).then((value) => store.load()),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4)]),
          child: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(4),
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        PostImage(imageUrl: Utility.parseImageUrl(post.image)),
                        if (post.chat_enabled)
                          const PositionedDirectional(
                              bottom: 6,
                              start: 6,
                              child: ShoppableIcon(
                                size: 16,
                              )),
                        if (store.isOwnProfile)
                          PositionedDirectional(
                              bottom: 4,
                              end: 4,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xFF787880).withOpacity(0.5)),
                                  child: Text.rich(TextSpan(children: [
                                    WidgetSpan(
                                        child: SvgPicture.asset(
                                      "assets/icons/ic_eye.svg",
                                      height: 12,
                                      width: 12,
                                    )),
                                    const WidgetSpan(
                                        child: SizedBox(
                                      width: 4,
                                    )),
                                    TextSpan(text: post.views.toString(), style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700
                                    ))
                                  ]))))
                      ],
                    ),
                    cardFooter,
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget get cardFooter {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              post.my_like ? Icons.favorite : Icons.favorite_border,
              size: 12,
              color: const Color(0xFFFA897B),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              NumberFormat.decimalPattern().format(post.likes),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ));
  }
}
