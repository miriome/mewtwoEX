import 'package:flutter/cupertino.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context,
      {required String title,
      required String content,
      required String actionText,
      required void Function(BuildContext) onActionTap,
      bool barrierDismissable = true,
      String destructiveText = "Cancel",
      bool showDestructionAction = true,
      void Function(BuildContext)? onDestructiveTap}) {
    return showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: barrierDismissable,
      builder: (BuildContext dialogContext) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            textStyle: const TextStyle(color: Color(0xFF8474A1)),
            onPressed: () => onActionTap(dialogContext),
            child: Text(actionText),
          ),
          if (showDestructionAction)
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () {
                if (onDestructiveTap != null) {
                  onDestructiveTap(dialogContext);
                  return;
                }
                Navigator.of(dialogContext).pop();
              },
              child: Text(destructiveText),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
