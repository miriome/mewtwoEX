import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mewtwo/drops/models/drop_post_model.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api.g.dart';

@riverpod
Future<({DateTime start, DateTime end, int id})> getNextDrop(GetNextDropRef ref) async {
  try {
    final res = await (await Networking.instance).get(path: "drops/getDrop");
    Map response = res.data;
    if (response['status'] == false) {
      return (start: DateTime.fromMicrosecondsSinceEpoch(0), end: DateTime.fromMicrosecondsSinceEpoch(0), id: 0);
    }
    if (response['data'] is Map) {
      return (
        start: Utility.parseTimestamp(response['data']['startTimestamp']) ?? DateTime.fromMicrosecondsSinceEpoch(0),
        end: Utility.parseTimestamp(response['data']['endTimestamp']) ?? DateTime.fromMicrosecondsSinceEpoch(0),
        id: Utility.parseInt(response['data']['id'])
      );
    }
  } on DioException catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return (start: DateTime.fromMicrosecondsSinceEpoch(0), end: DateTime.fromMicrosecondsSinceEpoch(0), id: 0);
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
    final res = await (await Networking.instance).get(path: "drops/getDropPostDetails/$postId");
    Map response = res.data;
    if (response['status'] == false) {
      return null;
    }
    if (response['data'] is Map) {
      return DropPostModel.fromJson(response['data']);
    }
  } on DioException catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return null;
}
