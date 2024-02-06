// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'webview_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WebviewStore on _WebviewStore, Store {
  late final _$_controllerAtom =
      Atom(name: '_WebviewStore._controller', context: context);

  WebViewController get controller {
    _$_controllerAtom.reportRead();
    return super._controller;
  }

  @override
  WebViewController get _controller => controller;

  @override
  set _controller(WebViewController value) {
    _$_controllerAtom.reportWrite(value, super._controller, () {
      super._controller = value;
    });
  }

  late final _$titleAtom = Atom(name: '_WebviewStore.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  @override
  String toString() {
    return '''
title: ${title}
    ''';
  }
}
