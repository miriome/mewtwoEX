import 'package:flutter/material.dart';

class InvalidPasswordCriteriaDialog extends StatelessWidget {
  static Future<void> show(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            child: InvalidPasswordCriteriaDialog(),
          );
        });
  }

  const InvalidPasswordCriteriaDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 22,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Password Criteria:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          "Minimum 8 characters",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          "At least 1 number",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          "At least 1 special character",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Flexible(
                          child: Text(
                            "Incudes both upper & lower case characters",
                            maxLines: 2,
                            style: TextStyle(fontSize: 16,),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
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
              ),
            ))
      ],
    );
  }
}
