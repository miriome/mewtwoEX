import 'package:flutter/material.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/upsert_measurements_base.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/upsert_measurements_base_store.dart';
import 'package:mewtwo/routes/routes.dart';


class CreateMeasurementsPage extends StatelessWidget {
  const CreateMeasurementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text(
          "Your Measurements",
        ),
        actions: [
          TextButton(
              onPressed: () {
                HomePageRoute().go(context);
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Color(0xFF7D7878)),
              ))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: UpsertMeasurementsBase(store: UpsertMeasurementsBaseStore(), ctaText: "Enter miromie!", onCtaSuccess: (context) =>  HomePageRoute().go(context),)
    );
  }

}
