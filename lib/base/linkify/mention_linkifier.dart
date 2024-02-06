import 'package:dartx/dartx.dart';
import 'package:linkify/linkify.dart';
import 'package:mewtwo/home/model/mention_data_model.dart';
import 'package:mewtwo/home/model/user_model.dart';

/// For details on how this RegEx works, go to this link.
/// https://regex101.com/r/QN046t/1
final _userTagRegex = RegExp(
  r'^(.*?)@([\w@]+(?:[.!][\w@]+)*)',
  caseSensitive: false,
  dotAll: true,
);

class MentionLinkifier extends Linkifier {
  final List<MentionDataModel> mentionedUsers;
  const MentionLinkifier({required this.mentionedUsers});

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    for (var element in elements) {
      if (element is TextElement) {
        var match = _userTagRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          var textElement = '';
          var text = element.text.replaceFirst(match.group(0)!, '');
          while (match?.group(1)?.contains(RegExp(r'[\w@]$')) == true) {
            textElement += match!.group(0)!;
            match = _userTagRegex.firstMatch(text);
            if (match == null) {
              textElement += text;
              text = '';
            } else {
              text = text.replaceFirst(match.group(0)!, '');
            }
          }

          if (textElement.isNotEmpty || match?.group(1)?.isNotEmpty == true) {
            list.add(TextElement(textElement + (match?.group(1) ?? '')));
          }
          if (match?.group(2)?.isNotEmpty == true) {
            
            final mentionedUser = mentionedUsers.firstOrNullWhere((user) => user.username == match!.group(2)!.trim());
            if (mentionedUser != null) {
              list.add(MentionElement(mentionedUser));  
            } else {
              list.add(TextElement("@${match!.group(2)!.trim()}"));
            }

            // list.add(UserTagElement('@${match!.group(2)!}'));
          }

          if (text.isNotEmpty) {
            list.addAll(parse([TextElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    }

    return list;
  }
}

/// Represents an element containing an user tag
class MentionElement extends LinkableElement {
  final MentionDataModel user;

  MentionElement(this.user) : super("@${user.username}", user.username);

  @override
  String toString() {
    return "UserTagElement: '$user.username' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  int get hashCode => Object.hash(text, originText, url, user.user_id);

  @override
  bool equals(other) =>
      other is MentionElement &&
      super.equals(other) &&
      other.user.user_id == user.user_id;
}