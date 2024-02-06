// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mention_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserMentionSearchStore on _UserMentionSearchStore, Store {
  late final _$_isLoadingAtom =
      Atom(name: '_UserMentionSearchStore._isLoading', context: context);

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

  late final _$_userResultsAtom =
      Atom(name: '_UserMentionSearchStore._userResults', context: context);

  ObservableList<UserModel> get userResults {
    _$_userResultsAtom.reportRead();
    return super._userResults;
  }

  @override
  ObservableList<UserModel> get _userResults => userResults;

  @override
  set _userResults(ObservableList<UserModel> value) {
    _$_userResultsAtom.reportWrite(value, super._userResults, () {
      super._userResults = value;
    });
  }

  late final _$searchAsyncAction =
      AsyncAction('_UserMentionSearchStore.search', context: context);

  @override
  Future<void> search(String searchTerm) {
    return _$searchAsyncAction.run(() => super.search(searchTerm));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
