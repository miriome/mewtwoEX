import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Constants {
  static const String kKeyId = "k_id";
  static const String kKeyPronouns = "k_pronouns";
  static const String kKeyStyles = "k_styles";
  static const String kKeyToken = "k_access_token";
  static const String kLastUnreadNotif = "k_unread_notif";
  static String kUnreadChat(String id) => 'k_unread_chat_$id'; // Key for unread chat timestamp

  // TODO: Migrate this to DB.
  static const List<String> kStyles = [
    "Basic",
    "Korean",
    "Athleisure",
    "Hype",
    "Officewear",
    "Luxury",
    "Chic",
    "Beach",
    "Boho",
    "Androgynous",
    "Emo",
    "Vintage"
  ];

  static const List<int> kadminIds = [6, 52];

  static late Directory tempDir;
  static late Directory appDocDir;
  static late SharedPreferences sp;


  static Future<void> init() async {
    tempDir = await getTemporaryDirectory();
    appDocDir = await getApplicationDocumentsDirectory();
    sp = await SharedPreferences.getInstance();
  }

}
