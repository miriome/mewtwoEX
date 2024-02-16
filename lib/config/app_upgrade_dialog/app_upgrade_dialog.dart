import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mewtwo/base/widgets/confirm_dialog.dart';
import 'package:mewtwo/config/app_upgrade_dialog/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mewtwo/mew.dart';

import 'package:url_launcher/url_launcher.dart';

class AppUpgradeDialog {
  static Future<void> showIfNeeded(BuildContext context) async {
    final needForceUpgrade = await Mew.pc.read(needUpdateProvider.future);
    if (needForceUpgrade == null) {
      return;
    }
    if (!context.mounted) {
      return;
    }
    ConfirmDialog.show(context,
        title: "New version available",
        content: "There are new features available, please update your app",
        actionText: "Update",
        showDestructionAction: !needForceUpgrade,
        onDestructiveTap: (context) async {
          final sp = await SharedPreferences.getInstance();
          await sp.setInt("upgrade_dismiss_timestamp", DateTime.now().millisecondsSinceEpoch);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        barrierDismissable: false,
        onActionTap: (context) {
          final appId = Platform.isAndroid ? 'com.miromie.android' : 'com.miromie.ios.miromie';
          final url = Uri.parse(
            Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId",
          );
          launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        });
  }
}
