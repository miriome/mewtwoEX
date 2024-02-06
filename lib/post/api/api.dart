import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api.g.dart';

@riverpod
Future<List<PostModel>> getLikedPostsApi(
  GetLikedPostsApiRef ref,
) async {
  final body = {"page_index": 0, 'count': 50};
  try {
    final res = await (await Networking.instance).post(path: "post/liked", body: body);
    final response = res.data;
    // TODO: Error handling
    if (response['status']) {
      if (response['data'] is List) {
        return (response['data'] as List).map((e) => PostModel.fromJson(e)).toList();
      } else {}
    }
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }

  return [];
}

@riverpod
Future<PostModel?> getPostDetailsApi(GetPostDetailsApiRef ref, {required int postId}) async {
  try {
    final res = await (await Networking.instance)
        .get<List<int>>(path: "post/details/$postId", options: Options(responseType: ResponseType.bytes));

    List<int> response = res.data;
    final jsonRes = jsonDecode(utf8.decode(response));
    if (jsonRes['status'] == false) {
      Fluttertoast.showToast(msg: jsonRes['message'] ?? "", gravity: ToastGravity.CENTER);
      return null;
    }
    return PostModel.fromJson(jsonRes['data']);
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return null;
}

@riverpod
Future<bool> deleteCommentApi(DeleteCommentApiRef ref, {required int commentId}) async {
  final body = {'comment_id': commentId.toString()};
  try {
    final res = await (await Networking.instance).post(path: "post/deleteComment", body: body);
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
Future<bool> addCommentApi(AddCommentApiRef ref, {required int postId, required String comment}) async {
  final body = {'post_id': postId.toString(), 'comment': comment};
  try {
    final res = await (await Networking.instance).post(path: "post/comment", body: body);
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
Future<bool> deletePostApi(DeletePostApiRef ref, {required int postId}) async {
  try {
    final res = await (await Networking.instance).delete(path: "post/${postId.toString()}");
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
Future<bool> markPostSoldApi(MarkPostSoldApiRef ref, {required int postId}) async {
  try {
    final res = await (await Networking.instance).post(path: "post/markSold/$postId", body: {});
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

class PostPhoto {
  int index;
  List<int> photoFileBytes;
  PostPhoto({required this.index, required this.photoFileBytes});
}

@riverpod
Future<bool> editPostApi(EditPostApiRef ref,
    {required int postId, required String caption, required bool chatEnabled, required List<PostPhoto> photos}) async {
  final data = FormData.fromMap({
    "caption": caption,
    'chat_enabled': chatEnabled ? 1 : 0,
  });

  photos.forEachIndexed((photo, index) {
    data.files.add(MapEntry(
        '${photo.index}',
        MultipartFile.fromBytes(photo.photoFileBytes,
            filename: "image_${photo.index}.jpg", contentType: MediaType('image', 'jpg'))));
  });
  try {
    final res = await (await Networking.instance).postForm(path: "post/editPost/$postId", data: data);
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
Future<bool> addPostApi(AddPostApiRef ref,
    {required String caption, required bool chatEnabled, required List<PostPhoto> photos}) async {
  final data = FormData.fromMap(
      {"caption": caption, 'chat_enabled': chatEnabled ? 1 : 0, 'photos_last_index': photos.lastIndex});
  photos.forEachIndexed((photo, index) {
    data.files.add(MapEntry(
        '${photo.index}',
        MultipartFile.fromBytes(photo.photoFileBytes,
            filename: "photo_$index.jpg", contentType: MediaType('image', 'jpeg'))));
  });
  try {
    final res = await (await Networking.instance).postForm(path: "post/addPost", data: data);
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
