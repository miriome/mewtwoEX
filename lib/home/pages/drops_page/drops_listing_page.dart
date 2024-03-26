import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mewtwo/base/widgets/async_data_builder.dart';
import 'package:mewtwo/drops/api/api.dart';
import 'package:mewtwo/home/pages/drops_page/widgets/drops_post_tile.dart';
import 'package:mewtwo/mew.dart';

class DropsListingPage extends StatelessWidget {
  final int dropId;
  static const int _pageTabIndex = 3;
const DropsListingPage({ Key? key, required this.dropId }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Consumer(builder: ((context, ref, child) {
      final drops = ref.watch(getDropsListProvider(dropId));
      return AsyncDataBuilder(data: drops, dataBuilder: (drops) {
        return AlignedGridView.count(
              controller: Mew.tabPrimaryScrollControllers[_pageTabIndex],
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: drops.length,
              itemBuilder: (context, index) {
                return DropsPostTile(
                  post: drops[index],
                );
              },
            );
      });
    }));
  }
}