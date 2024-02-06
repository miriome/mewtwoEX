// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchPageStoreHash() => r'69aa05d7888d2355a20f16a710ce4152c4658858';

/// See also [searchPageStore].
@ProviderFor(searchPageStore)
final searchPageStoreProvider = Provider<SearchPageStore>.internal(
  searchPageStore,
  name: r'searchPageStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchPageStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchPageStoreRef = ProviderRef<SearchPageStore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchPageStore on _SearchPageStore, Store {
  Computed<UserModel?>? _$currentUserModelComputed;

  @override
  UserModel? get currentUserModel => (_$currentUserModelComputed ??=
          Computed<UserModel?>(() => super.currentUserModel,
              name: '_SearchPageStore.currentUserModel'))
      .value;
  Computed<List<String>>? _$selfStylesComputed;

  @override
  List<String> get selfStyles =>
      (_$selfStylesComputed ??= Computed<List<String>>(() => super.selfStyles,
              name: '_SearchPageStore.selfStyles'))
          .value;

  late final _$_currentPageAtom =
      Atom(name: '_SearchPageStore._currentPage', context: context);

  int get currentPage {
    _$_currentPageAtom.reportRead();
    return super._currentPage;
  }

  @override
  int get _currentPage => currentPage;

  @override
  set _currentPage(int value) {
    _$_currentPageAtom.reportWrite(value, super._currentPage, () {
      super._currentPage = value;
    });
  }

  late final _$_isLoadingAtom =
      Atom(name: '_SearchPageStore._isLoading', context: context);

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

  late final _$_postResultsAtom =
      Atom(name: '_SearchPageStore._postResults', context: context);

  ObservableList<PostModel> get postResults {
    _$_postResultsAtom.reportRead();
    return super._postResults;
  }

  @override
  ObservableList<PostModel> get _postResults => postResults;

  @override
  set _postResults(ObservableList<PostModel> value) {
    _$_postResultsAtom.reportWrite(value, super._postResults, () {
      super._postResults = value;
    });
  }

  late final _$_userResultsAtom =
      Atom(name: '_SearchPageStore._userResults', context: context);

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

  late final _$_searchBarFocusNodeAtom =
      Atom(name: '_SearchPageStore._searchBarFocusNode', context: context);

  FocusNode get searchBarFocusNode {
    _$_searchBarFocusNodeAtom.reportRead();
    return super._searchBarFocusNode;
  }

  @override
  FocusNode get _searchBarFocusNode => searchBarFocusNode;

  @override
  set _searchBarFocusNode(FocusNode value) {
    _$_searchBarFocusNodeAtom.reportWrite(value, super._searchBarFocusNode, () {
      super._searchBarFocusNode = value;
    });
  }

  late final _$_textEditingControllerAtom =
      Atom(name: '_SearchPageStore._textEditingController', context: context);

  TextEditingController get textEditingController {
    _$_textEditingControllerAtom.reportRead();
    return super._textEditingController;
  }

  @override
  TextEditingController get _textEditingController => textEditingController;

  @override
  set _textEditingController(TextEditingController value) {
    _$_textEditingControllerAtom
        .reportWrite(value, super._textEditingController, () {
      super._textEditingController = value;
    });
  }

  late final _$searchAsyncAction =
      AsyncAction('_SearchPageStore.search', context: context);

  @override
  Future<void> search() {
    return _$searchAsyncAction.run(() => super.search());
  }

  @override
  String toString() {
    return '''
currentUserModel: ${currentUserModel},
selfStyles: ${selfStyles}
    ''';
  }
}
