import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/user_model.dart';

class NumberMeasurements extends StatelessWidget {
  final UserModel user;
  const NumberMeasurements({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(
          height: 8,
        ),
        IgnorePointer(
          child: TextField(
            controller: TextEditingController()..text = user.height ?? "",
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
            controller: TextEditingController()..text = user.bust ?? "",
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
            controller: TextEditingController()..text = user.waist ?? "",
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
        TextField(
          controller: TextEditingController()..text = user.hips ?? "",
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
        const SizedBox(
          height: 16,
        ),
      ]),
    );
  }
}
