class ChatUtils {
  static String getChatRoomId({required int firstId, required int secondId}) {
    return firstId > secondId ? "${secondId}_$firstId": "${firstId}_$secondId";
  }
}