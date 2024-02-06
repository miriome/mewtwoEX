// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationPageStore on _NotificationPageStore, Store {
  late final _$_isLoadingAtom =
      Atom(name: '_NotificationPageStore._isLoading', context: context);

  bool get isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  bool get _isLoading => isLoading;

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_notificationsAtom =
      Atom(name: '_NotificationPageStore._notifications', context: context);

  ObservableList<NotificationModel> get notifications {
    _$_notificationsAtom.reportRead();
    return super._notifications;
  }

  @override
  ObservableList<NotificationModel> get _notifications => notifications;

  @override
  set _notifications(ObservableList<NotificationModel> value) {
    _$_notificationsAtom.reportWrite(value, super._notifications, () {
      super._notifications = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('_NotificationPageStore.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
