import 'package:dartx/dartx.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/comment_model.dart';
import 'package:mewtwo/post/utils.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';

class CommentText extends StatelessWidget {
  final CommentModel comment;
  const CommentText({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = TextUtils.replaceEmoji(comment.comment);
    final splitText = text.split(RegExp(r'(?<= )|(?= )'));
    final textSpans = splitText.map((text) {
      if (text.startsWith("@")) {
        final mentionedUser = comment.mentions.firstOrNullWhere((mention) => mention.username == text.substring(1));
        if (mentionedUser != null) {
          return TextSpan(
              text: text,
              style: TextStyle(color: Theme.of(context).primaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  OtherProfilePageRoute(userId: mentionedUser.user_id).push(context);
                });
        }
      }
      return TextSpan(
        text: text,
      );
    }).toList();

    return Text.rich(
        style: const TextStyle(fontSize: 16, color: Color(0xFF7D7878)), maxLines: 10, TextSpan(children: textSpans));
  }
}
