import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/profile/measurements/dialog/models/number_measurement_model.dart';
import 'package:mewtwo/utils.dart';

class NumberMeasurements extends StatelessWidget {
  final NumberMeasurementModel numberMeasurements;
  const NumberMeasurements({Key? key, required this.numberMeasurements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(
          height: 8,
        ),
        IgnorePointer(
          child: TextField(
            controller: TextEditingController()
              ..text = (numberMeasurements.height ?? "").toString(),
            maxLength: 3,
            decoration: const InputDecoration(
                labelText: "Height",
                counterText: "",
                suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'cm',
                      style: TextStyle(
                          color: Color(
                            0xFF7D7878,
                          ),
                          fontSize: 16),
                    ))),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        IgnorePointer(
          child: TextField(
            controller: TextEditingController()
              ..text = (numberMeasurements.bust ?? "").toString(),
            keyboardType: TextInputType.number,
            maxLength: 3,
            decoration: const InputDecoration(
                counterText: "",
                labelText: "Bust",
                suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'in',
                      style: TextStyle(
                          color: Color(
                            0xFF7D7878,
                          ),
                          fontSize: 16),
                    ))),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        IgnorePointer(
          child: TextField(
            controller: TextEditingController()
              ..text = (numberMeasurements.waist ?? "").toString(),
            maxLength: 3,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                counterText: "",
                labelText: "Waist",
                suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'in',
                      style: TextStyle(
                          color: Color(
                            0xFF7D7878,
                          ),
                          fontSize: 16),
                    ))),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        IgnorePointer(
          child: TextField(
            controller: TextEditingController()
              ..text = (numberMeasurements.hips ?? "").toString(),
            maxLength: 3,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                counterText: "",
                labelText: "Hips",
                suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'in',
                      style: TextStyle(
                          color: Color(
                            0xFF7D7878,
                          ),
                          fontSize: 16),
                    ))),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ]),
    );
  }
}
