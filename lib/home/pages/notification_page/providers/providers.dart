import 'dart:async';


import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/notification_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'providers.g.dart';

@riverpod
Future<List<({NotificationModel notification, bool unread})>> notificationsWithStatus(NotificationsWithStatusRef ref) async {
  final sp = await SharedPreferences.getInstance();
  final notifications = await ref.read(getNotificationsApiProvider.future);
  int lastUnreadId = sp.getInt(Constants.kLastUnreadNotif) ?? -1;
  
  final timer = Timer(const Duration(seconds: 2), () { 
    ref.invalidateSelf();
  });
  ref.onDispose(() {timer.cancel();});
  
  return notifications.map((notification) => (notification: notification, unread: (int.tryParse(notification.id) ?? -1) > lastUnreadId)).toList();
}


@riverpod
Future<bool> hasUnreadNotifications(HasUnreadNotificationsRef ref) async {
  final notifications = await ref.watch(notificationsWithStatusProvider.future);
  return notifications.map((notifications) => notifications.unread).contains(true);
}