import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/post/widgets/user_mention_search/user_mention_search_store.dart';

class UserMentionSearch extends StatelessWidget {


  final UserMentionSearchStore store;
  final void Function(UserModel) onUserResultsTap;
  const UserMentionSearch({Key? key, required this.onUserResultsTap, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          color: Colors.white,
          child: 
          (store.isLoading) ?
          const Center(child: CircularProgressIndicator())
        :
          ListView.builder(
            itemBuilder: (context, index) {
              final user = store.userResults[index];
              return GestureDetector(
                onTap: () => onUserResultsTap(user),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0xFF6EC6CA),
                        foregroundImage: user.photo_url == "https://miromie.com/uploads/"
                            ? null
                            : CachedNetworkImageProvider(
                                user.photo_url,
                              ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            user.username,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(
                                0xFF6EC6CA,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: store.userResults.length,
          ),
        );
      }
    );
  }
}
