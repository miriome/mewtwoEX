import 'package:dartx/dartx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mewtwo/chats/apis/api.dart';
import 'package:mewtwo/chats/models/message_model.dart';
import 'package:mewtwo/chats/utils/utils.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

part 'providers.g.dart';

@riverpod
Stream<List<Message>> messageHistory(MessageHistoryRef ref, {required int targetId}) async* {
  final sp = await SharedPreferences.getInstance();
  final senderId = sp.getInt(Constants.kKeyId);
  if (senderId == null) {
    return;
  }
  final roomId = ChatUtils.getChatRoomId(firstId: senderId, secondId: targetId);
  final conversationUsers = await ref.watch(ConversationUsersProvider(senderId: senderId, receiverId: targetId).future);

  final messageStream = FirebaseFirestore.instance.collection("chats").doc(roomId).collection("chat").snapshots();
  await for (final message in messageStream) {
    final messages = message.docs.mapIndexed((index, doc) {
      final data = doc.data();
      final messageModel = MessageModel.fromJson(data);
      switch (messageModel.content_type) {
        case "image": {
          final authorModel = messageModel.sender_id == conversationUsers.reciever.id
                ? conversationUsers.reciever
                : conversationUsers.sender;
            final user = User(id: authorModel.id.toString(), imageUrl: authorModel.photo_url);
            final message = ImageMessage(
                name: "name",
                size: 50,
                uri: messageModel.message,
                
                author: user,
                id: index.toString(),
                createdAt: messageModel.time.floor() * 1000);
            return message;
        }
        default:
          {
            final authorModel = messageModel.sender_id == conversationUsers.reciever.id
                ? conversationUsers.reciever
                : conversationUsers.sender;
            final user = User(id: authorModel.id.toString(), imageUrl: authorModel.photo_url);
            final message = TextMessage(
                text: messageModel.message,
                author: user,
                id: index.toString(),
                createdAt: messageModel.time.floor() * 1000);
            return message;
          }
      }
    }).toList();
    messages.sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));
    yield messages;
  }
}

@riverpod
Future<({UserModel sender, UserModel reciever})> conversationUsers(ConversationUsersRef ref,
    {required int senderId, required int receiverId}) async {
  final sender = await ref.read(GetUserInfoApiProvider(userId: senderId).future);
  final reciever = await ref.read(GetUserInfoApiProvider(userId: receiverId).future);
  if (sender == null || reciever == null) {
    throw Exception("Unable to get user info");
  }
  return (sender: sender, reciever: reciever);
}

@riverpod
Future<void> sendTextMessage(SendTextMessageRef ref, {required int senderId, required int receiverId, required String message}) async{
  final firebaseParams = {
    "sender_id"     : senderId,
            "receiver_id"   : receiverId,
            "message"       : message,
            "content_type"  : "text",
            "time"          : DateTime.now().toUtc().millisecondsSinceEpoch / 1000
  };

  final roomId = ChatUtils.getChatRoomId(firstId: senderId, secondId: receiverId);

  await FirebaseFirestore.instance.collection("chats").doc(roomId).collection("chat").add(firebaseParams).then((_) {
    return ref.read(sendMessageApiProvider(message: message, messageType: "text", receiverId: receiverId).future);
  });
}

@riverpod
Future<bool> sendImageMessage(SendImageMessageRef ref, {required int senderId, required int receiverId, required XFile imageFile}) async {
  final imageUrl = await ref.read(uploadImageApiProvider(image: imageFile).future);
  if (imageUrl == null) {
    throw Exception("Failed to upload image");
  }

  final firebaseParams = {
    "sender_id"     : senderId,
            "receiver_id"   : receiverId,
            "message"       : imageUrl,
            "content_type"  : "image",
            "time"          : DateTime.now().toUtc().millisecondsSinceEpoch / 1000
  };

  final roomId = ChatUtils.getChatRoomId(firstId: senderId, secondId: receiverId);

  await FirebaseFirestore.instance.collection("chats").doc(roomId).collection("chat").add(firebaseParams).then((_) {
    return ref.read(sendMessageApiProvider(message: "[photo]", messageType: "image", receiverId: receiverId).future);
  });
  return true;
}
