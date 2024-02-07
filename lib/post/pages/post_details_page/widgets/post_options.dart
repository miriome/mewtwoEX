import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/base/widgets/confirm_dialog.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/post/pages/post_details_page/post_details_page_store.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/safety/api/api.dart';
import 'package:mewtwo/safety/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostOptions {
  static Future<void> show(BuildContext context,
      {required PostDetailsPageStore store, required void Function() onPostEdit}) async {
    final sp = await SharedPreferences.getInstance();
    int? myUserId;
    if (sp.containsKey(Constants.kKeyId)) {
      myUserId = sp.getInt(Constants.kKeyId);
    }
    if (myUserId == null) {
      return;
    }
    final post = store.post;
    if (post == null) {
      return;
    }
    bool isMyPost = myUserId == post.added_by;

    if (context.mounted) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext modalContext) {
          final List<CupertinoActionSheetAction> actions = [];
          actions.add(CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(modalContext);
              sharePost(store);
            },
            child: const Text(
              'Share post',
              style: TextStyle(color: Colors.black),
            ),
          ));
          if (!isMyPost) {
            actions.add(CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(modalContext);
                ReportContentRoute(reportType: ReportType.post, typeId: post.id.toString()).push(context);
              },
              child: const Text(
                'Report post',
              ),
            ));
          } else {
            actions.add(CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(modalContext);
                EditPostRoute(postId: post.id).push(context).then((_) {
                  onPostEdit();
                });
              },
              child: const Text(
                'Edit post',
                style: TextStyle(color: Colors.black),
              ),
            ));
            if (post.chat_enabled) {
              actions.add(CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(modalContext);
                  _showMarkPostSoldDialog(parentContext: context, store: store);
                },
                child: const Text('Mark as sold', style: TextStyle(color: Color(0xFF7D7878))),
              ));
            }

            actions.add(CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(modalContext);
                _showDeletePostDialog(parentContext: context, store: store);
              },
              child: const Text(
                'Delete post',
              ),
            ));
          }
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
  }

  static Future<void> _showDeletePostDialog(
      {required BuildContext parentContext, required PostDetailsPageStore store}) async {
    return ConfirmDialog.show(parentContext,
        title: "Delete post",
        content: 'Are you sure you want to delete this post?',
        actionText: 'Cancel',
        onActionTap: (context) => Navigator.of(context).pop(),
        destructiveText: 'Delete',
        onDestructiveTap: (context) async {
          Navigator.of(context).pop();
          final deleted = await store.deletePost();
          if (deleted) {
            if (parentContext.mounted) {
              Fluttertoast.showToast(msg: "Post deleted", gravity: ToastGravity.CENTER);
              Navigator.of(parentContext).pop();
            }
          }
        });
  }

  static Future<void> _showMarkPostSoldDialog(
      {required BuildContext parentContext, required PostDetailsPageStore store}) async {
    return showDialog<void>(
      context: parentContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mark post sold'),
          content: const Text('Are you sure you would like to mark item(s) in this post as sold?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Mark sold'),
              onPressed: () async {
                Navigator.of(context).pop();
                final deleted = await store.markPostSold();
                store.load();
                if (deleted) {
                  if (parentContext.mounted) {
                    Fluttertoast.showToast(msg: "Marked post as sold", gravity: ToastGravity.CENTER);
                  }
                }
              },
            ),
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> sharePost(PostDetailsPageStore store) async {
    final post = store.post;
    if (post == null) {
      return;
    }

    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: PostDetailsRoute(postId: post.id).location,
      title: "Check out ${post.posted_by?.username ?? "this user"}'s OOTD on miromie!",
      imageUrl: post.image,
      contentDescription: post.caption,
      keywords: ['Share', 'Post', 'Miromie'],
      publiclyIndex: true,
      locallyIndex: true,
    );
    BranchLinkProperties lp = BranchLinkProperties(
      channel: 'app',
      feature: 'sharing',
      stage: 'new share',
    );

    BranchResponse response =
        await FlutterBranchSdk.showShareSheet(buo: buo, linkProperties: lp, messageText: "Share post:");
    if (response.success) {
      Fluttertoast.showToast(msg: "Post link copied", gravity: ToastGravity.CENTER);
    }
  }
}
