import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mewtwo/base/widgets/miromie_title.dart';
import 'package:mewtwo/chats/providers/providers.dart';
import 'package:mewtwo/chats/routes/routes.dart';
import 'package:mewtwo/home/main_app_bar.dart';
import 'package:mewtwo/home/pages/home_page/api/api.dart';
import 'package:mewtwo/home/pages/home_page/home_page_store.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mewtwo/home/pages/home_page/widgets/home_post_tile.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int _pageTabIndex = 0;
  final store = HomePageStore();
  @override
  void initState() {
    FirebaseMessaging.instance.requestPermission().then((value) async {
      if (value.authorizationStatus == AuthorizationStatus.authorized) {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          Mew.pc.read(RegisterPushTokenApiProvider(value: fcmToken));
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: MainAppBar.getAppBar(context),
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: RefreshIndicator(
              onRefresh: () => store.loadPosts(),
              child: AlignedGridView.count(
                controller: Mew.tabPrimaryScrollControllers[_pageTabIndex],
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: store.posts.length,
                itemBuilder: (context, index) {
                  return HomePostTile(
                    onUserTap: (userId) {},
                    post: store.posts[index],
                    onLikeToggle: (postId) => store.togglePostLike(postId: postId),
                  );
                },
              ),
            ),
          ));
    });
  }

  PreferredSizeWidget get appBar {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.white,
      leading: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: const MiromieTitle(fontSize: 28),
      ),
      leadingWidth: 150,
      actions: [
        Builder(builder: (context) {
          return GestureDetector(
            onTap: () => LikedPostsPageRoute().push(context),
            child: const Icon(
              Icons.favorite,
              color: Color(0xFFFA897B),
              size: 28,
            ),
          );
        }),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => ChatListPageRoute().go(context),
          child: Consumer(

            builder: (context, ref, child) {
              final hasUnread = ref.watch(hasUnreadChatsProvider).valueOrNull ?? false;
              
              return Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.chat_bubble,
                    color: Color(0xFFFFDD94),
                    size: 28,
                  ),
                  if (hasUnread)
                  PositionedDirectional(
                      top: 0,
                      end: 0,
                      child: Transform.translate(offset: const Offset(2, -2), child: SvgPicture.asset(
                          "assets/icons/ic_unread_red_dot.svg",
                          height: 14,
                          width: 14,
                        ),)
                      )
                ],
              );
            }
          ),
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}
