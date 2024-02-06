import 'package:flutter/material.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/unauth/api/api.dart';
import 'package:mewtwo/mew.dart';
import 'package:mobx/mobx.dart';

part 'login_page_store.g.dart';

class LoginPageStore extends _LoginPageStore with _$LoginPageStore {}

abstract class _LoginPageStore with Store {
  
  @readonly
  TextEditingController _usernameController = TextEditingController();

  @readonly
  TextEditingController _passwordController = TextEditingController();

  @observable
  bool isPasswordHidden = true;


  @action
  Future<bool> login() async {
    final loginProvider = LoginApiProvider(username: _usernameController.text, password: _passwordController.text);
    final res =await Mew.pc.read(loginProvider.future);
    return res;
  }

  
}