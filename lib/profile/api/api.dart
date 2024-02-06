import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'api.g.dart';

@riverpod
Future<bool> editStylesApi(EditStylesApiRef ref, {required Set<String> styles}) async {
  final body = {'styles': styles.join(',')};
  try {
    final res = await (await Networking.instance).post(path: "users/editStyles", body: body);
    Map response = res.data;
    if (response['status'] == false) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return false;
    }
    return true;
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return false;
}

@riverpod
Future<bool> deleteAccountApi(DeleteAccountApiRef ref) async {
  try {
    final res = await (await Networking.instance).get(path: "account/permDelete");
    Map response = res.data;
    if (response['status'] == false) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return false;
    }
    return true;
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return false;
}