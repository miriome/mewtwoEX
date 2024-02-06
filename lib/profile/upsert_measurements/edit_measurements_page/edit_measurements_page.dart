import 'package:flutter/material.dart';
import 'package:mewtwo/profile/upsert_measurements/edit_measurements_page/edit_measurements_page_store.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/upsert_measurements_base.dart';


class EditMeasurementsPage extends StatelessWidget {
  final store = EditMeasurementsPageStore()..load();
  EditMeasurementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Measurements",
        ),
      ),
      body: UpsertMeasurementsBase(store: store, ctaText: "Confirm", onCtaSuccess: (context) => Navigator.of(context).pop(),)
    );
  }

}
