import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mewtwo/base/providers/counter_provider/countdown_provider.dart';
import 'package:mewtwo/base/widgets/async_data_builder.dart';
import 'package:mewtwo/drops/api/api.dart';
import 'package:mewtwo/home/pages/drops_page/widgets/drops_post_tile.dart';
import 'package:mewtwo/mew.dart';

class DropsListingPage extends StatefulWidget {
  final int dropId;
  final DateTime end;
  static const int _pageTabIndex = 3;

  const DropsListingPage({Key? key, required this.dropId, required this.end}) : super(key: key);

  @override
  State<DropsListingPage> createState() => _DropsListingPageState();
}

class _DropsListingPageState extends State<DropsListingPage> {
  final ValueNotifier<bool> hasEnabledNotifications = ValueNotifier(true);
  @override
  void initState() {
    checkNotificationPermissions();
    super.initState();
  }
  void checkNotificationPermissions() {
    FirebaseMessaging.instance.requestPermission().then((value) async {
      setState(() {
        hasEnabledNotifications.value = value.authorizationStatus == AuthorizationStatus.authorized;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final drops = ref.watch(getDropsListProvider(2));
      return AsyncDataBuilder(
          data: drops,
          dataBuilder: (drops) {
            return Stack(
              children: [
                AlignedGridView.count(
                  controller: Mew.tabPrimaryScrollControllers[DropsListingPage._pageTabIndex],
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  padding: const EdgeInsets.only(bottom: 60),
                  itemCount: drops.length,
                  itemBuilder: (context, index) {
                    return DropsPostTile(
                      post: drops[index],
                    );
                  },
                ),
                
                ValueListenableBuilder(
                  valueListenable: hasEnabledNotifications,
                  builder: (context, hasEnabledNotifications, _) {
                    if (hasEnabledNotifications) {
                      return const SizedBox.shrink();
                    }
                    return Positioned(bottom: 8, left: 20, right: 20, child: buildEnableNotifications());
                  }
                )
              ],
            );
          });
    }));
  }

  Widget buildEnableNotifications() {
    return Builder(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => AppSettings.openAppSettings(type: AppSettingsType.notification).then((value) => checkNotificationPermissions()),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.85), borderRadius: BorderRadius.circular(4)),
            child: const Text.rich(
              TextSpan(children: [TextSpan(text: "Enable notifications", style: TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.white,)), TextSpan(text:" for drop alerts")]),
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    );
  }
}
