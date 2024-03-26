import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mewtwo/base/widgets/async_data_builder.dart';
import 'package:mewtwo/drops/api/api.dart';
import 'package:mewtwo/home/main_app_bar.dart';
import 'package:mewtwo/home/pages/drops_page/drops_listing_page.dart';
import 'package:mewtwo/home/pages/drops_page/drops_page_counting_down.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

class DropsPage extends ConsumerStatefulWidget {
  const DropsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DropsPage> createState() => _DropsPageState();
}

class _DropsPageState extends ConsumerState<DropsPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: MainAppBar.getAppBar(context),
            body: Consumer(builder: (context, ref, child) {
              final data = ref.watch(getNextDropProvider);
              return AsyncDataBuilder(
                  data: data,
                  dataBuilder: (drop) {
                    final currentTime = DateTime.now();
                    if (drop.start.isAfter(currentTime)) {
                      return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropsPageCountingDown(timeToDrop: drop.start));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropsListingPage(dropId: drop.id, end: drop.end),
                    );
                  });
            })));
  }
}
