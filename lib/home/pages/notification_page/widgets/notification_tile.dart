import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/home/model/notification_model.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/utils.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  const NotificationTile({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onNotificationTap(context),
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () => OtherProfilePageRoute(userId: notification.userData.id).push(context),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF6EC6CA),
              foregroundImage: notification.userData.photo_url == "https://miromie.com/uploads/"
                  ? null
                  : CachedNetworkImageProvider(
                      notification.userData.photo_url,
                    ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(child: notificationBody),
          const SizedBox(
            width: 34,
          ),
          SizedBox(
              height: 32,
              child:
                  (notification.postData?.image != null) ? PostImage(imageUrl: (notification.postData?.image)!) : null),
          const SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }

  void onNotificationTap(BuildContext context) {
    switch (notification.notification_type) {
      case NotificationType.mention:
      case NotificationType.comment:
        final postId = Utility.parseInt(notification.post_id, -1);
        if (postId == -1) {
          return;
        }
        PostDetailsRoute(postId: postId).push(context);
        
        return;
      case NotificationType.follow:
      OtherProfilePageRoute(userId: notification.userData.id).push(context);
        return;
      case NotificationType.like:
        final postId = Utility.parseInt(notification.post_id, -1);
        if (postId == -1) {
          return;
        }
        PostDetailsRoute(postId: postId).push(context);
        return;
      default:
        return;
    }
  }

  Widget get notificationBody {
    
    return Builder(builder: (context) {
      switch (notification.notification_type) {
        case NotificationType.mention:
        return Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: notification.userData.username,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()..onTap = () => OtherProfilePageRoute(userId: notification.userData.id).push(context)
                  ),
              const TextSpan(text: " mentioned you in a comment")
            ]),
            style: const TextStyle(fontSize: 16),
            maxLines: 3,
          );
        case NotificationType.comment:
          return Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: notification.userData.username,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()..onTap = () => OtherProfilePageRoute(userId: notification.userData.id).push(context)
                  ),
              const TextSpan(text: " commented on your post")
            ]),
            style: const TextStyle(fontSize: 16),
            maxLines: 3,
          );
        case NotificationType.follow:
          return Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: notification.userData.username,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()..onTap = () => OtherProfilePageRoute(userId: notification.userData.id).push(context)
                  ),
              const TextSpan(text: " started following you")
            ]),
            style: const TextStyle(fontSize: 16),
            maxLines: 3,
          );
        case NotificationType.like:
          return Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: notification.userData.username,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()..onTap = () => OtherProfilePageRoute(userId: notification.userData.id).push(context)
                  ),
              const TextSpan(text: " liked your post")
            ]),
            style: const TextStyle(fontSize: 16),
            maxLines: 3,
          );
        default:
          return const SizedBox.shrink();
      }
    });
  }
}
