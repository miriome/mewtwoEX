import 'dart:async';


import 'package:mewtwo/chats/apis/api.dart';
import 'package:mewtwo/chats/models/contact_model.dart';
import 'package:mewtwo/chats/utils/utils.dart';
import 'package:mewtwo/constants.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@riverpod
Future<List<({ContactModel chat, bool unread})>> notificationsWithStatus(NotificationsWithStatusRef ref) async {
  final sp = await SharedPreferences.getInstance();
  ref.invalidate(getContactsApiProvider);
  final chats = await ref.read(getContactsApiProvider.future);
  final selfId = sp.getInt(Constants.kKeyId);
  if (selfId == null) {
    return [];
  }
  // Constantly invalidating to refresh
  final timer = Timer(const Duration(seconds: 2), () {
    ref.invalidateSelf();
  });
  ref.onDispose(() {timer.cancel();});

  return chats.map((chat) {
    return (chat: chat, unread: ChatUtils.isChatUnread(chat));
  }).toList();
}

@riverpod
Future<bool> hasUnreadChats(
  HasUnreadChatsRef ref,
) async {
  final chatsData = await ref.watch(notificationsWithStatusProvider.future);
  final hasUnread = chatsData.map((e) => e.unread).contains(true);
  
  return hasUnread;
}
