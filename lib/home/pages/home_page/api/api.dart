import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api.g.dart';

@riverpod
Future<void> registerPushTokenApi(RegisterPushTokenApiRef ref,
    {required String value}) async {
  final body = {"push_token": value, "platform": Platform.isAndroid ? "android" : "ios"};
  try {
    // Background call, not going to do anything with the result anw.
    await (await Networking.instance).post(path: "account/registerDeviceToken", body: body);
    return;
  } on DioException catch (e, s) {
    
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
}