import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mewtwo/home/main_app_bar.dart';
import 'package:mewtwo/home/pages/drops_page/drops_page_counting_down.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

class DropsPage extends ConsumerStatefulWidget {
  const DropsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DropsPage> createState() => _DropsPageState();
}

class _DropsPageState extends ConsumerState<DropsPage> {
  static const int _pageTabIndex = 3;

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Observer(builder: (context) {
        return  Scaffold(
            appBar: MainAppBar.getAppBar(context),          
            body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: DropsPageCountingDown(timeToDrop: Duration(hours: 1, minutes: 1))
        ));
      }),
    );
  }
}
