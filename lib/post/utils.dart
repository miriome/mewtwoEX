import 'dart:convert';

class TextUtils {

  // To detect a single unicode
static const regEx1 = '\\\\u([0-9a-fA-F]{4})'; 

// To detect a 2-bytes unicode
static const regEx2 = '$regEx1$regEx1';

  static String _regExEmojiUnicode(String text, String regEx) {
  final regexCheck = RegExp(regEx, caseSensitive: false);
  String newText = '';
  int _lastEndText = 0;
  int _lastEndNewText = 0;

  regexCheck.allMatches(text).forEach((match) {
    final start = match.start;
    final end = match.end;
    final String replacement = jsonDecode('"${match.group(0)}"');
      
    String startString;
    newText == ''
        ? startString = '${text.substring(0, start)}$replacement'
        : startString =
            '${newText.substring(0, _lastEndNewText)}${text.substring(_lastEndText, start)}$replacement';

    _lastEndNewText = startString.length;
    _lastEndText = end;

    newText =
        '$startString${text.substring(end)}';
      
  });

  if(newText == '') newText = text;

  return newText;
}


static String replaceEmoji(String text) {
  String newText = text;

  // Checking for 2-bytes and single bytes emojis
  if(newText.contains('\\u'))
    newText = _regExEmojiUnicode(newText, regEx2);
  if(newText.contains('\\u'))
    newText = _regExEmojiUnicode(newText, regEx1);

  return newText;
}

}

