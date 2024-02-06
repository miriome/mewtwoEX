import 'package:linkify/linkify.dart';

final _atUsernameRegex = RegExp(
  r'(.*?)(#\w+)',
  caseSensitive: false,
  dotAll: true,
);

class HashtagLinkifier extends Linkifier {
  const HashtagLinkifier();

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    for (var element in elements) {
      if (element is TextElement) {
        var match = _atUsernameRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          // create the preceding TextElement
          if (match.group(1)?.isNotEmpty ?? false) {
            list.add(TextElement(match.group(1)!));
          }

          // create the AtElement
          if (match.group(2)?.isNotEmpty ?? false) {
            var withHash = match.group(2)!;
            var element = HashtagElement(withHash);
            list.add(element);
          }

          // create the following TextElement
          final textWithoutMatch =
              element.text.replaceFirst(match.group(0)!, '');
          if (textWithoutMatch.isNotEmpty) {
            list.addAll(parse([TextElement(textWithoutMatch)], options));
          }
        }
      } else {
        list.add(element);
      }
    }

    return list;
  }
}

class HashtagElement extends LinkableElement {
  HashtagElement(String tag) : super(tag, tag);

  @override
  String toString() {
    return "HashtagElement: '$url' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) =>
      identical(this, other) ||
      other is HashtagElement &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          url == other.url;

  @override
  int get hashCode => text.hashCode ^ url.hashCode;
}