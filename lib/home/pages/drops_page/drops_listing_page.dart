import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mewtwo/base/providers/counter_provider/countdown_provider.dart';
import 'package:mewtwo/base/widgets/async_data_builder.dart';
import 'package:mewtwo/drops/api/api.dart';
import 'package:mewtwo/home/pages/drops_page/widgets/drops_post_tile.dart';
import 'package:mewtwo/mew.dart';

class DropsListingPage extends StatelessWidget {
  final int dropId;
  final DateTime end;
  static const int _pageTabIndex = 3;
  const DropsListingPage({Key? key, required this.dropId, required this.end}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final drops = ref.watch(getDropsListProvider(dropId));
      return AsyncDataBuilder(
          data: drops,
          dataBuilder: (drops) {
            return Stack(
              children: [
                AlignedGridView.count(
                  controller: Mew.tabPrimaryScrollControllers[_pageTabIndex],
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  padding: const EdgeInsets.only(bottom: 60),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return DropsPostTile(
                      post: drops[0],
                    );
                  },
                ),
                Positioned(bottom: 8, left: 20, right: 20, child: buildEndTime())
              ],
            );
          });
    }));
  }

  Widget buildEndTime() {
    return Consumer(builder: (context, ref, child) {
      final countdown = ref.watch(countdownNotifierProvider(end.difference(DateTime.now())));
      final hours = countdown.inHours.remainder(24);
      final minutes = countdown.inMinutes.remainder(60);
      final seconds = countdown.inSeconds.remainder(60);
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.85), borderRadius: BorderRadius.circular(4)),
        child: Text(
          "Drop ends in ${hours}h ${minutes}m ${seconds}s",
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
