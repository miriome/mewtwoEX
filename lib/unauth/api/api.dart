import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'api.g.dart';

final dio = Dio();

@riverpod
Future<bool> loginApi(LoginApiRef ref,
    {required String username, required String password}) async {
  final body = {
    'username': username,
    'password': password
  };

  try {
    final res = await (await Networking.instance).post(path: "auth/login", body: body);
    Map response = res.data;

    if (response['status'] == false || response['data']['id'] == null || response['access_token'] == null) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return false;
    }
    final userId = Utility.parseInt(response['data']['id']);
    final token = Utility.parseStr(response['access_token']);
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(Constants.kKeyId, userId);
    await sp.setString(Constants.kKeyToken, token);
    Networking.reset();
    return true;
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return false;
}

enum ExistingAccountFieldKey { username, email }

@riverpod
Future<bool?> checkAccountFieldExistApi(CheckAccountFieldExistApiRef ref,
    {required ExistingAccountFieldKey key, required String value}) async {
  final body = {"field_name": key.name, "field_value": value};
  try {
    final res = await (await Networking.instance).post(path: "auth/checkDuplicate", body: body);
    Map response = res.data;

    if (response['status'] == false || response['data']['exist'] == null) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return null;
    }
    return Utility.parseBool(response['data']['exist']);
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return null;
}

@riverpod
Future<bool> signUpApi(SignUpApiRef ref,
    {required String username, required String email, required String password}) async {
  final sp = await SharedPreferences.getInstance();
  final pronouns = sp.getString(Constants.kKeyPronouns);
  final styles = sp.getString(Constants.kKeyStyles);
  final body = {
    "email": email,
    "password": password,
    "pronouns": pronouns,
    "styles": styles,
    "username": username,
    "device_type": "iOS"
  };
  try {
    final res = await (await Networking.instance).post(path: "auth/signup", body: body);
    Map response = res.data;

    if (response['status'] == false || response['data']['userId'] == null || response['access_token'] == null) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return false;
    }
    final userId = Utility.parseInt(response['data']['userId']);
    final token = Utility.parseStr(response['access_token']);
    await sp.setInt(Constants.kKeyId, userId);
    await sp.setString(Constants.kKeyToken, token);
    Networking.reset();
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
Future<bool> editProfileApi(EditProfileApiRef ref,
    {required String displayName, List<int>? fileBytes, bool isDeletePhoto = false}) async {
  final data = FormData.fromMap({
    "name": displayName,
    'delete_photo': isDeletePhoto ? 1 : 0,
    if (fileBytes != null)
      "file": MultipartFile.fromBytes(fileBytes, filename: "image.jpg", contentType: MediaType('image', 'jpg'))
  });

  try {
    final res = await (await Networking.instance).postForm(path: "users/editProfile", data: data);
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
Future<bool> editMeasurementsApi(EditMeasurementsApiRef ref, {int? height, int? bust, int? waist, int? hips, required MeasurementPrivacy privacy}) async {
  final body = {
    'height': height == null ? "" : height.toString(),
    'bust': bust == null ? "" : bust.toString(),
    'waist': waist == null ? "" : waist.toString(),
    'hips': hips == null ? "" : hips.toString(),
    'measurementPrivacy' : privacy.name
  };

  try {
    final res = await (await Networking.instance).post(path: "users/editMeasurement", body: body);
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
