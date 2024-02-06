import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mewtwo/home/pages/notification_page/notification_page_store.dart';
import 'package:mewtwo/home/pages/notification_page/widgets/notification_tile.dart';
import 'package:mewtwo/mew.dart';

class NotificationPage extends StatelessWidget {
  static const int _pageTabIndex = 3;
  final store = NotificationPageStore()..load();
  NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifications",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: RefreshIndicator(
            onRefresh: () => store.load(),
            child: store.notifications.isEmpty
                ? Center(
                  child: TextButton(
                    onPressed: () => store.load(),
                      child: const Text("No notifications yet, tap here to refresh.", style: TextStyle(fontSize: 16)),
                    ),
                )
                : ListView.separated(
                  controller: Mew.tabPrimaryScrollControllers[_pageTabIndex],
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                    itemCount: store.notifications.length,
                    itemBuilder: (context, index) {
                      return NotificationTile(notification: store.notifications[index]);
                    }),
          ),
        ),
      );
    });
  }
}
