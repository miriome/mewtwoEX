import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/profile/measurements/dialog/number_measurements.dart';
import 'package:mewtwo/profile/measurements/dialog/sml_measurements.dart';

class MeasurementsViewDialog extends StatefulWidget {
  final UserModel user;
  const MeasurementsViewDialog({Key? key, required this.user}) : super(key: key);
  static Future<void> show(BuildContext context, UserModel user) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            child: MeasurementsViewDialog(user: user),
          );
        });
  }

  @override
  State<MeasurementsViewDialog> createState() => _MeasurementsViewDialogState();
}

class _MeasurementsViewDialogState extends State<MeasurementsViewDialog> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final tabs = [
    const Tab(
        child: SizedBox(
            width: 68,
            child: Text(
              "#",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ))),
    const Tab(
        child: SizedBox(
            width: 68,
            child: Text(
              "S-M-L",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            )))
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 504,
          child: Column(
            children: [
              tabBar(),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: NumberMeasurements(user: widget.user),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SmlMeasurements(user: widget.user),
                  )
                  
                ]),
              ),
            ],
          ),
        ),
        PositionedDirectional(
            top: 0,
            end: 4,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                size: 24,
                color: Colors.black,
              ),
            ))
      ],
      
    );
  }

  Widget tabBar() {
    return Center(
      child: TabBar(
        tabs: tabs,
        controller: tabController,
        isScrollable: true,
        padding: EdgeInsets.zero,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
        tabAlignment: TabAlignment.center,
        splashFactory: NoSplash.splashFactory,
        indicatorPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}


