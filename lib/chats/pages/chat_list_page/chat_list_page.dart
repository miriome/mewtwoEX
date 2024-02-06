import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mewtwo/base/image/cached_network_image_provider.dart';
import 'package:mewtwo/chats/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mewtwo/chats/apis/api.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Consumer(
        builder: (context, ref, child) {
          final data = ref.watch(getContactsApiProvider);
          return data.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text("No chats yet"),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 12),
                      child: Divider(color: Color(0xFF7D7878), thickness: 0.5),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    final conversation = data[index];
                    return GestureDetector(
                      onTap: () => ChatPageRoute(targetId: conversation.target_id).push(context),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFF6EC6CA),
                            foregroundImage: conversation.contactUser.photo_url == "https://miromie.com/uploads/"
                                ? null
                                : BBCachedNetworkImageProvider(conversation.contactUser.photo_url,
                                    targetHeight: 50, targetWidth: 50),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  conversation.contactUser.username,
                                  style: GoogleFonts.roboto(
                                      height: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  conversation.last_message,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                              timeago.format(DateTime.fromMillisecondsSinceEpoch((conversation.last_timestamp) * 1000)))
                        ],
                      ),
                    );
                  },
                  itemCount: data.length,
                );
              },
              error: (e, s) => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
