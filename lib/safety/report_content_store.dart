import 'package:flutter/material.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/safety/api/api.dart';
import 'package:mobx/mobx.dart';

part 'report_content_store.g.dart';

class ReportContentStore extends _ReportContentStore with _$ReportContentStore {}



abstract class _ReportContentStore with Store {
  
  @readonly
  bool _isLoading = false;


  @readonly
  bool _isSubmitButtonEnabled = false;

  late final TextEditingController controller = TextEditingController()..addListener(() {
    if (controller.text.length >= 20) {
      _isSubmitButtonEnabled = true;
    } else {
      _isSubmitButtonEnabled = false;
    }
   });
  
  @action
  Future<bool> submitReport({required ReportType type, required String id}) async {
    
    final reportContentApiProvider = ReportContentApiProvider(reason: controller.text, reportType: type, typeId: id);
    final listener = Mew.pc.listen(reportContentApiProvider, (previous, next) { 
      _isLoading = next.isLoading;
    }, fireImmediately: true);
    bool success = await Mew.pc.read(reportContentApiProvider.future);
    listener.close();
    return success;
  }
}