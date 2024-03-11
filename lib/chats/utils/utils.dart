import 'package:mewtwo/chats/models/contact_model.dart';
import 'package:mewtwo/constants.dart';

class ChatUtils {
  static String getChatRoomId({required int firstId, required int secondId}) {
    return firstId > secondId ? "${secondId}_$firstId": "${firstId}_$secondId";
  }

  static bool isChatUnread(ContactModel chat) {
    final selfId = Constants.sp.getInt(Constants.kKeyId) ?? -1;
    final roomId = getChatRoomId(firstId: selfId, secondId: chat.target_id);
    final lastUnreadTimestamp = Constants.sp.getInt(Constants.kUnreadChat(roomId)) ?? -1;
    return chat.last_timestamp > lastUnreadTimestamp;
  }
}