import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mewtwo/base/image/cached_network_image.dart';
import 'package:mewtwo/base/image/cached_network_image_provider.dart';
import 'package:mewtwo/base/stores/current_user_store.dart';
import 'package:mewtwo/chats/pages/chat_page/providers.dart';
import 'package:mewtwo/chats/utils/utils.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/utils.dart';

class ChatPage extends StatelessWidget {
  final int targetId;
  final ImagePicker picker = ImagePicker();

  ChatPage({Key? key, required this.targetId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Consumer(
        builder: (context, ref, child) {
          final messages = ref.watch(MessageHistoryProvider(targetId: targetId));
          final currentUser = ref.watch(currentUserStoreProvider);
          final currentUserObj =
              types.User(id: (currentUser.user?.id ?? 0).toString(), imageUrl: currentUser.user?.photo_url);
          switch (messages) {
            case AsyncData(:final value):
              {
                final roomId = ChatUtils.getChatRoomId(firstId: Constants.sp.getInt(Constants.kKeyId) ?? -1, secondId: targetId);
                final newestMessage = value[0];
                final lastUnreadTimestamp = Constants.sp.getInt(Constants.kUnreadChat(roomId)) ?? -1;
                if (newestMessage.createdAt != null) {
                  /// Set last seen time for messages
                  if ((newestMessage.createdAt! ~/ 1000) + 1 > lastUnreadTimestamp) {
                    Constants.sp.setInt(Constants.kUnreadChat(roomId), (newestMessage.createdAt! ~/ 1000) + 1);
                        
                  }
                }
                return Chat(
                  theme: DefaultChatTheme(
                      inputTextDecoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
                      userAvatarImageBackgroundColor: Theme.of(context).primaryColor,
                      inputBackgroundColor: Colors.white,
                      inputTextStyle: const TextStyle(color: Colors.black),
                      inputTextColor: Colors.black),
                  messages: value,
                  onAttachmentPressed: () async {
                    final image = await _handleAttachmentPressed(context);
                    if (image != null) {
                      EasyLoading.show();
                      await ref.read(sendImageMessageProvider(
                              imageFile: image, receiverId: targetId, senderId: currentUser.user?.id ?? 0)
                          .future);
                      EasyLoading.dismiss();
                    }
                  },
                  
                  imageMessageBuilder: (types.ImageMessage message, {required int messageWidth}) {
                    
                    return CachedNetworkImage(
                      imageUrl: message.uri,
                      placeholder: SizedBox(
                        height: messageWidth * 0.72,
                        width: messageWidth.toDouble(),
                        child: const Center(child: CircularProgressIndicator())),
                      cachedWidth: messageWidth - 1,
                      // alignment: Alignment.topCenter,
                    );
                  },
                  
                  disableImageGallery: true,
                  onSendPressed: (text) async {
                    await ref.read(sendTextMessageProvider(
                            message: text.text, receiverId: targetId, senderId: currentUser.user?.id ?? 0)
                        .future);
                  },
                  onAvatarTap: (user) {
                    OtherProfilePageRoute(userId: Utility.parseInt(user.id)).push(context);
                  },
                  user: currentUserObj,
                  showUserAvatars: true,
                );
              }
            case AsyncError(:final error):
              return Text(error.toString());
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<XFile?> _handleAttachmentPressed(BuildContext context) {
    return showCupertinoModalPopup<XFile?>(
      context: context,
      builder: (BuildContext modalContext) {
        final List<CupertinoActionSheetAction> actions = [];
        actions.add(CupertinoActionSheetAction(
          onPressed: () async {
            final image = await picker.pickImage(source: ImageSource.gallery);
            if (modalContext.mounted) {
              Navigator.pop(modalContext, image);
            }
          },
          child: const Text(
            'Send image from gallery',
            style: TextStyle(color: Color(0xFF7D7878)),
          ),
        ));
        actions.add(CupertinoActionSheetAction(
          onPressed: () async {
            final image = await picker.pickImage(source: ImageSource.camera);
            if (modalContext.mounted) {
              Navigator.pop(modalContext, image);
            }
          },
          child: const Text(
            'Send image from camera',
            style: TextStyle(color: Color(0xFF7D7878)),
          ),
        ));
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(modalContext);
            },
            child: const Text('Cancel'),
          ),
          actions: actions,
        );
      },
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: Consumer(builder: (context, ref, child) {
        final targetInfo = ref.watch(GetUserInfoApiProvider(userId: targetId));

        return targetInfo.when(
            data: (data) {
              if (data == null) {
                return const SizedBox.shrink();
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFF6EC6CA),
                    foregroundImage: data.photo_url == "https://miromie.com/uploads/"
                        ? null
                        : BBCachedNetworkImageProvider(
                            data.photo_url,
                          ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.username,
                        style: GoogleFonts.roboto(
                            height: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(data.name)
                    ],
                  ),
                ],
              );
            },
            error: (e, s) => const SizedBox.shrink(),
            loading: () => const CircularProgressIndicator());
      }),
    );
  }
}
