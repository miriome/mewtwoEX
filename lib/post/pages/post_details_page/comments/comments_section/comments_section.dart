import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart' hide UrlLinkifier, UrlElement;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mewtwo/base/linkify/mention_linkifier.dart';
import 'package:mewtwo/base/linkify/hashtag_linkifier.dart';
import 'package:mewtwo/base/linkify/url_linkifier.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/model/comment_model.dart';
import 'package:mewtwo/post/pages/post_details_page/comments/comments_section/comments_section_store.dart';

import 'package:mewtwo/post/widgets/user_mention_search/user_mention_search.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';

import 'package:mewtwo/post/utils.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/safety/api/api.dart';
import 'package:mewtwo/safety/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class CommentsSection extends StatelessWidget {
  final CommentsSectionStore store;
  final int postId;
  final LayerLink link = LayerLink();

  CommentsSection({Key? key, required this.store, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MultiSliver(children: [
        commentsList(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 12,
            child: CompositedTransformTarget(
              link: link,
              child: OverlayPortal(
                controller: store.portalController,
                overlayChildBuilder: (context) => PositionedDirectional(
                  height: 200,
                  start: 0,
                  end: 0,
                  child: CompositedTransformFollower(
                    link: link,
                    targetAnchor: Alignment.topLeft,
                    followerAnchor: Alignment.bottomLeft,
                    child: UserMentionSearch(
                        onUserResultsTap: (user) {
                          store.onMentionUserSearchTap(user);
                          store.portalController.hide();
                        },
                        store: store.userMentionStore),
                  ),
                ),
              ),
            ),
          ),
        ),
        writeComment
      ]);
    });
  }

  Widget get writeComment {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: DetectableTextField(
              style: const TextStyle(fontSize: 14),
              enabled: !store.isCommentSending,
              controller: store.commentController,
              maxLines: null,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  hintText: "Write a comment...",
                  hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF7D7878)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFFD9D9D9).withOpacity(0.45), width: 1))),
            ),
          ),
          IconButton.filled(
              onPressed: store.isCommentSending
                  ? null
                  : store.canAddComment
                      ? () {
                          store.addComment(postId: postId).then((success) {
                            if (success) {
                              store.commentController.clear();
                            }
                          });
                        }
                      : null,
              constraints: const BoxConstraints(),
              iconSize: 28,
              padding: EdgeInsets.zero,
              icon: store.isCommentSending
                  ? Container(
                      color: Colors.white,
                      child: const CircularProgressIndicator(),
                    )
                  : const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: 24,
                    ))
        ],
      ),
    );
  }

  Widget commentsList() {
    return MultiSliver(
      children: [
        if (!store.showAllComments)
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => store.showAllComments = true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text("View all ${store.commentsLength} comments"),
              )),
        SliverList.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final comment = store.visibleComments[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        OtherProfilePageRoute(userId: comment.commented_by.id).push(context);
                      },
                      child: Text(comment.commented_by.username,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF8474A1))),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      timeago.format(DateTime.fromMillisecondsSinceEpoch((comment.created_timestamp) * 1000)),
                      style: const TextStyle(color: Color(0xFF7D7878), fontSize: 16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Linkify(
                      text: TextUtils.replaceEmoji(comment.comment),
                      linkifiers: [const UrlLinkifier(), MentionLinkifier(mentionedUsers: comment.mentions), const HashtagLinkifier()],
                      linkStyle: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor, decoration: TextDecoration.none),
                      style: const TextStyle(fontSize: 16, color: Color(0xFF7D7878)),
                      options: const LinkifyOptions(defaultToHttps: true),
                      onOpen: (element) {
                        if (element is MentionElement) {
                          OtherProfilePageRoute(userId: element.user.user_id).push(context);
                        }
                        if (element is HashtagElement) {
                          SearchPageRoute().goWithInitialSearchTerm(context, element.text.removePrefix("#"));
                          return;
                        }
                        if (element is UrlElement) {
                          launchUrl(Uri.parse(element.url));
                          return;
                        }
                      },
                    )
                        // CommentText(comment: comment)
                        ),
                    GestureDetector(
                        onTap: () {
                          showCommentOptions(context, comment: comment);
                        },
                        child: Icon(
                          Icons.more_horiz,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ))
                  ],
                )
              ],
            );
          },
          itemCount: store.visibleComments.length,
        ),
      ],
    );
  }

  void showCommentOptions(BuildContext context, {required CommentModel comment}) async {
    final sp = await SharedPreferences.getInstance();
    int? myUserId;
    if (sp.containsKey(Constants.kKeyId)) {
      myUserId = sp.getInt(Constants.kKeyId);
    }
    if (myUserId == null) {
      return;
    }
    bool isMyComment = myUserId == comment.commented_by.id;
    if (context.mounted) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext modalContext) => CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(modalContext);
            },
            child: const Text('Cancel'),
          ),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(modalContext);
                if (isMyComment) {
                  store.deleteComment(comment.id);
                  return;
                }
                ReportContentRoute(reportType: ReportType.comment, typeId: comment.id.toString()).push(context);
              },
              child: Text(
                '${isMyComment ? "Delete" : "Report"} Comment',
              ),
            ),
          ],
        ),
      );
    }
  }
}
