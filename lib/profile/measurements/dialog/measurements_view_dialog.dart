import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/brand_sizing_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/profile/measurements/dialog/models/number_measurement_model.dart';
import 'package:mewtwo/profile/measurements/dialog/number_measurements.dart';
import 'package:mewtwo/profile/measurements/dialog/sml_measurements.dart';

class MeasurementsViewDialog extends StatefulWidget {
  final NumberMeasurementModel numberMeasurements;
  final List<BrandSizingModel> sizings;
  const MeasurementsViewDialog({Key? key, required this.numberMeasurements, required this.sizings}) : super(key: key);
  static Future<void> show(BuildContext context, {required NumberMeasurementModel numberMeasurements, required List<BrandSizingModel> sizings}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            child: MeasurementsViewDialog(
              numberMeasurements: numberMeasurements, sizings: sizings,),
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
                    child: NumberMeasurements(numberMeasurements: widget.numberMeasurements,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SmlMeasurements(brandSizings: widget.sizings,),
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


