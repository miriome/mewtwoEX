import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/pages/notification_page/providers/providers.dart';

import 'package:mewtwo/home/pages/notification_page/widgets/notification_tile.dart';
import 'package:mewtwo/mew.dart';

class NotificationPage extends StatelessWidget {
  static const int _pageTabIndex = 3;
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(notificationsWithStatusProvider);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifications",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),
          ),
        ),
        body: data.when(
            error: (e, s) => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (data) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(getNotificationsApiProvider);
                  },
                  child: data.isEmpty
                      ? Center(
                          child: TextButton(
                            onPressed: () => ref.invalidate(getNotificationsApiProvider),
                            child: const Text("No notifications yet, tap here to refresh.",
                                style: TextStyle(fontSize: 16)),
                          ),
                        )
                      : ListView.separated(
                          controller: Mew.tabPrimaryScrollControllers[_pageTabIndex],
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 16,
                              ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return NotificationTile(notification: data[index].notification, isUnread: false,);
                          }),
                ),
              );
            }),
      );
    });
  }
}
