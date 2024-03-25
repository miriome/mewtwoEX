import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mewtwo/base/widgets/miromie_title.dart';
import 'package:mewtwo/chats/providers/providers.dart';
import 'package:mewtwo/chats/routes/routes.dart';
import 'package:mewtwo/home/pages/notification_page/providers/providers.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';

class MainAppBar {
  static PreferredSizeWidget getAppBar(BuildContext context) {
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
        GestureDetector(
          onTap: () => NotificationPageRoute().push(context),
          child: Consumer(builder: (context, ref, child) {
            final unreadNotificationsData = ref.watch(hasUnreadNotificationsProvider);
            final hasUnread = unreadNotificationsData.valueOrNull ?? false;
            return Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications,
                  size: 28,
                ),
                if (hasUnread)
                  PositionedDirectional(
                      top: 0,
                      end: 2,
                      child: SvgPicture.asset(
                        "assets/icons/ic_unread_red_dot.svg",
                        height: 14,
                        width: 14,
                      ))
              ],
            );
          }),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => LikedPostsPageRoute().push(context),
          child: const Icon(
            Icons.favorite,
            color: Color(0xFFFA897B),
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => ChatListPageRoute().go(context),
          child: Consumer(builder: (context, ref, child) {
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
                      child: Transform.translate(
                        offset: const Offset(2, -2),
                        child: SvgPicture.asset(
                          "assets/icons/ic_unread_red_dot.svg",
                          height: 14,
                          width: 14,
                        ),
                      ))
              ],
            );
          }),
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}
