import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mewtwo/chats/models/contact_model.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api.g.dart';

@riverpod
Future<List<ContactModel>> getContactsApi(
  GetContactsApiRef ref,
) async {
  try {
    final res = await (await Networking.instance).get(path: "users/contacts");
    Map response = res.data;
    if (response['status'] == false) {
      Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
      return [];
    }
    if (response['data'] is List) {
      return (response['data'] as List).map((e) => ContactModel.fromJson(e)).toList();
    }
  } on DioException catch (e, s) {
    Fluttertoast.showToast(msg: e.message ?? "", gravity: ToastGravity.CENTER);
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return [];
}

@riverpod
Future<bool> sendMessageApi(SendMessageApiRef ref,
    {required int receiverId, required String message, required String messageType}) async {
  final body = {"target_id": receiverId, "message": message, "message_type": messageType};
  try {
    final res = await (await Networking.instance).post(path: "users/sendMessage", body: body);
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
Future<String?> uploadImageApi(UploadImageApiRef ref, {required XFile image}) async {
  final data = FormData();
  final imageBytes = await image.readAsBytes();
  data.files.add(MapEntry(
      "file", MultipartFile.fromBytes(imageBytes, filename: "image.jpg", contentType: MediaType('image', 'jpg'))));

  final res = await (await Networking.instance).postForm(path: "users/uploadFile", data: data);
  Map response = res.data;
  if (response['status'] == false) {
    Fluttertoast.showToast(msg: response['message'] ?? "", gravity: ToastGravity.CENTER);
    throw Exception(response['message'] ?? "");
  }
  return response['data'];
}



// 