import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/safety/api/api.dart';
import 'package:mewtwo/safety/report_content_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mewtwo/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:dartx/dartx.dart';

class ReportContent extends StatelessWidget {
  final String typeId;
  final ReportType type;
  final ReportContentStore store = ReportContentStore();
  ReportContent({Key? key, required this.type, required this.typeId}) : super(key: key);

  Widget submitReportButton() {
    return Observer(builder: (context) {
      return ElevatedButton(
        onPressed: store.isSubmitButtonEnabled
            ? () async {
                bool reported = await store.submitReport(type: type, id: typeId);
                if (reported) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(msg: "${type.name.capitalize()} has been reported. Our staff will take measures based on your valuable feedback.", gravity: ToastGravity.CENTER);
                  }
                }
              }
            : null,
        style: ButtonStyle(
            foregroundColor: const MaterialStatePropertyAll(Colors.transparent),
            backgroundColor: store.isSubmitButtonEnabled
                ? const MaterialStatePropertyAll(Color(0xFF6EC6CA))
                : const MaterialStatePropertyAll(Color(0xFF7D7878)),
            elevation: const MaterialStatePropertyAll(0),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            padding: const MaterialStatePropertyAll(EdgeInsetsDirectional.symmetric(horizontal: 44, vertical: 8))),
        child: SizedBox(
          width: 122,
          height: 44,
          child: Center(
            child: Text(
              "Submit",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactionBuilder(
      builder: (context) {
        return autorun((_) {
          if (store.isLoading) {
            return EasyLoading.show();
          } else {
            return EasyLoading.dismiss();
          }
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Text(
              "Please give a simple reason of why you are reporting this ${type.name}. Please provide at least 20 characters",
              style: GoogleFonts.barlow(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Form(
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                validator: (text) {
                  if (text != null) {
                    if (text.isEmpty) {
                      return "Please enter a reason";
                    }
                    if (text.length < 20) {
                      return "Reason has to be at least 20 characters";
                    }
                  }

                  return null;
                },
                maxLength: 500,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Please input reason',
                ),
                controller: store.controller,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const Spacer(),
            submitReportButton(),
            const SizedBox(
              height: 80,
            )
          ]),
        ),
      ),
    );
  }
}
