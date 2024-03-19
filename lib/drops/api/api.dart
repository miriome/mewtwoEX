import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/drops/models/drop_post_model.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api.g.dart';

@riverpod
Future<DropPostModel?> getDropPostDetailsApi(GetDropPostDetailsApiRef ref, {required int postId}) async {
  try {
    final res = await (await Networking.instance)
        .get<List<int>>(path: "drops/post/details/$postId", options: Options(responseType: ResponseType.bytes));

    List<int> response = res.data;
    final jsonRes = jsonDecode(utf8.decode(response));
    if (jsonRes['status'] == false) {
      Fluttertoast.showToast(msg: jsonRes['message'] ?? "", gravity: ToastGravity.CENTER);
      return null;
    }
    return DropPostModel.fromJson(jsonRes['data']);
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return null;
}
