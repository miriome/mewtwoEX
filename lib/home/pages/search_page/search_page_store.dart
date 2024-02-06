import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:mewtwo/base/stores/current_user_store.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_page_store.g.dart';

@Riverpod(keepAlive: true)
SearchPageStore searchPageStore(SearchPageStoreRef ref) {
  final store = SearchPageStore();
  store.initReactions();
  store.search();
  ref.onDispose(() {
    store.dispose();
  });
  return store;
}

class SearchPageStore extends _SearchPageStore with _$SearchPageStore {}

abstract class _SearchPageStore with Store {
  _SearchPageStore() {
    search();
  }

  @readonly
  int _currentPage = 0;

  @readonly
  bool _isLoading = false;

  @computed
  UserModel? get currentUserModel {
    return Mew.pc.read(currentUserStoreProvider).user;
  }

  @readonly
  ObservableList<PostModel> _postResults = ObservableList.of([]);

  @readonly
  ObservableList<UserModel> _userResults = ObservableList.of([]);

  @readonly
  FocusNode _searchBarFocusNode = FocusNode();

  @readonly
  TextEditingController _textEditingController = TextEditingController();

  CancelableOperation? _currentSearchOp;

  @computed
  List<String> get selfStyles {
    final styles = currentUserModel?.styles.split(",") ?? [];
    styles.insert(0, "All");
    return styles;
  }

  final List<ReactionDisposer> d = [];

  Timer? _searchTimer;

  void initReactions() {
    _textEditingController.addListener(() {
      if (!_searchBarFocusNode.hasFocus) {
        search();
        return;
      }
      _searchTimer?.cancel();
      _searchTimer = Timer(const Duration(seconds: 1, milliseconds: 2), () {
        search();
      });
    });
  }

  void dispose() {
    _searchBarFocusNode.dispose();
    _textEditingController.dispose();
    for (var disposer in d) {
      disposer();
    }
  }

  @action
  Future<void> search() async {
    _currentSearchOp?.cancel();
    final searchApiProvider = SearchApiProvider(pageIndex: _currentPage, keyword: _textEditingController.text);

    final listener = Mew.pc.listen(searchApiProvider, (previous, next) {
      _isLoading = next.isLoading;
    });
    final cancelableFut = CancelableOperation.fromFuture(Mew.pc.read(searchApiProvider.future));

    _currentSearchOp = cancelableFut.then((res) {
      if (res != null) {
        // FIX: Do not put UI logic here
        if (Mew.tabPrimaryScrollControllers[1].hasClients) {
          Mew.tabPrimaryScrollControllers[1].animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        }
        
        _postResults = ObservableList.of(res.postData ?? []);
        _userResults = ObservableList.of(res.userData ?? []);
      }
    });

    listener.close();
  }
}
