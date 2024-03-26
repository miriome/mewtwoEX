import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/drops/models/drop_post_model.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api.g.dart';

@riverpod
Future<({DateTime timestamp, int id})> getNextDrop(GetNextDropRef ref) async {
  try {
    final res = await (await Networking.instance).get(path: "drops/getDrop");
    Map response = res.data;
    if (response['status'] == false) {
      return (timestamp: DateTime.fromMicrosecondsSinceEpoch(0), id :0);
    }
    if (response['data'] is Map) {
      return (timestamp: Utility.parseTimestamp(response['data']['startTimestamp']) ?? DateTime.fromMicrosecondsSinceEpoch(0) , id: Utility.parseInt(response['data']['id']) );
    }
  } on DioException catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return (timestamp: DateTime.fromMicrosecondsSinceEpoch(0), id: 0);
}

@riverpod
Future<List<DropPostModel>> getDropsList(GetDropsListRef ref, int dropId) async {
  try {
    final res = await (await Networking.instance).get(path: "drops/list/$dropId");
    Map response = res.data;
    if (response['status'] == false) {
      return [];
    }
    if (response['data'] is List) {
      return (response['data'] as List).map((e) => DropPostModel.fromJson(e)).toList();
    }
  } on DioException catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return [];
}

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
