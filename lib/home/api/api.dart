import 'package:dio/dio.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/home/model/api/get_posts_api_model.dart';
import 'package:mewtwo/home/model/notification_model.dart';
import 'package:mewtwo/home/model/api/search_api_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api.g.dart';

@riverpod
Future<GetPostsApiModel?> getPostsApi(
  GetPostsApiRef ref, {
  required int pageIndex,
}) async {
  final body = {'page_index': pageIndex.toString(), 'count': 100.toString()};
  try {
    final res = await (await Networking.instance).post(path: "post/getPost", body: body);
    Map<String, dynamic> response = res.data;
    if (response['status'] == false) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return null;
    }

    return GetPostsApiModel.fromJson(response);
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return null;
}

@riverpod
Future<bool> likePostApi(LikePostApiRef ref, {required int postId, required bool setLikeTo}) async {
  final body = {'post_id': postId.toString(), 'is_like': setLikeTo ? 1 : 0};
  try {
    final res = await (await Networking.instance).post(path: "post/setLike", body: body);
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
Future<SearchApiModel?> searchApi(SearchApiRef ref, {required int pageIndex, required String keyword}) async {
  final body = {'page_index': pageIndex.toString(), 'count': 100.toString(), 'keyword': keyword};
  try {
    final res = await (await Networking.instance).post(path: "post/search", body: body);
    Map<String, dynamic> response = res.data;
    if (response['status'] == false) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return null;
    }

    return SearchApiModel.fromJson(response['data']);
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return null;
}

@riverpod
Future<UserModel?> getUserInfoApi(GetUserInfoApiRef ref, {required int userId}) async { // TODO: move to base
  try {
    final res = await (await Networking.instance).get(path: "users/profile/$userId");
    Map response = res.data;
    if (response['status'] == false) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return null;
    }
    return UserModel.fromJson(response['data']);
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
    
  } 
  return null;
}

@riverpod
Future<List<NotificationModel>> getNotificationsApi(GetNotificationsApiRef ref) async {
  try {
    final res = await (await Networking.instance).get(path: "users/notifications");
    Map response = res.data;
    if (response['status'] == false) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return [];
    }
    if (response['data'] is List) {
      return (response['data'] as List).map((e) => NotificationModel.fromJson(e)).toList();
    }
    return [];
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return [];
}

@riverpod
Future<bool> blockUserApi(BlockUserApiRef ref, {required int userId}) async {
  final body = {'target_id': userId.toString()};
  try {
    final res = await (await Networking.instance).post(path: "users/blockUser", body: body);
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
Future<bool> toggleUserFollowApi(ToggleUserFollowApiRef ref, {required int userId, required bool followToggle}) async {
  final body = {'target_id': userId.toString(), "is_follow": followToggle ? 1 : 0};
  try {
    final res = await (await Networking.instance).post(path: "users/follow", body: body);
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


