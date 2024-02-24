import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mewtwo/home/model/brand_sizing_model.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/components/number_measurement_form.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/components/sml_measurement_form/sml_measurement_form.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/providers/providers.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/upsert_measurements_base_store.dart';
import 'package:mewtwo/utils.dart';

class UpsertMeasurementsBase extends StatefulWidget {
  final UpsertMeasurementsBaseStore store;
  final String ctaText;
  final void Function(BuildContext) onCtaSuccess;
  const UpsertMeasurementsBase({Key? key, required this.store, required this.ctaText, required this.onCtaSuccess})
      : super(key: key);

  @override
  State<UpsertMeasurementsBase> createState() => _UpsertMeasurementsBaseState();
}

class _UpsertMeasurementsBaseState extends State<UpsertMeasurementsBase> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final tabs = [
    const Tab(
        child: SizedBox(
            width: 68,
            child: Text(
              "#",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ))),
    const Tab(
        child: SizedBox(
            width: 68,
            child: Text(
              "S-M-L",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )))
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final brandSizings = ref.watch(getBrandSizingsApiProvider);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Observer(builder: (context) {
                return FormBuilder(
                    key: widget.store.formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "miromie is a place for people of all shapes and sizes. Come as you are and join our community to embrace body positivity.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        tabBar(),
                        Expanded(
                          child: TabBarView(controller: tabController, children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: NumberMeasurementForm(store: widget.store),
                            ),
                            buildSizeMeasurementForm(brandSizings)
                          ]),
                        ),
                      ],
                    ));
              }),
            ),
            Padding(padding: const EdgeInsetsDirectional.only(start: 40, end: 40, bottom: 24, top: 12), child: cta())
          ],
        ),
      );
    });
  }

  Widget buildSizeMeasurementForm(AsyncValue<List<BrandSizingModel>> data) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: data.when(
            data: (data) {
              return SmlMeasurementForm(
                store: widget.store,
                brandSizings: data,
              );
            },
            error: (e, s) {
              Log.instance.e(e.toString(), stackTrace: s);
              return const SizedBox.shrink();
            },
            loading: () => const Center(child: CircularProgressIndicator())));
  }

  Widget cta() {
    return FilledButton(
        onPressed: () async {
          EasyLoading.show();
          final success = await widget.store.submit();
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
          if (success && context.mounted) {
            widget.onCtaSuccess(context);
          }
        },
        child: Text(
          widget.ctaText,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ));
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
