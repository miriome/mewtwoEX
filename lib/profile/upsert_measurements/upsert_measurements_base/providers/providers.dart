

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/home/model/brand_sizing_model.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Future<List<BrandSizingModel>> getBrandSizingsApi(
  GetBrandSizingsApiRef ref,
) async {
  try {
    final res = await (await Networking.instance).get(path: "users/brandSizings");
    Map response = res.data;
    if (response['status'] == false) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return [];
    }
    if (response['data'] is List) {
      return (response['data'] as List).map((e) => BrandSizingModel.fromJson(e)).toList();
    }
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return [];
}
