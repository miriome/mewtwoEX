// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on _HomePageStore, Store {
  late final _$currentPageAtom =
      Atom(name: '_HomePageStore.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$_numberOfFollowersAtom =
      Atom(name: '_HomePageStore._numberOfFollowers', context: context);

  int get numberOfFollowers {
    _$_numberOfFollowersAtom.reportRead();
    return super._numberOfFollowers;
  }

  @override
  int get _numberOfFollowers => numberOfFollowers;

  @override
  set _numberOfFollowers(int value) {
    _$_numberOfFollowersAtom.reportWrite(value, super._numberOfFollowers, () {
      super._numberOfFollowers = value;
    });
  }

  late final _$_isLoadingAtom =
      Atom(name: '_HomePageStore._isLoading', context: context);

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

  late final _$_postsAtom =
      Atom(name: '_HomePageStore._posts', context: context);

  ObservableList<PostModel> get posts {
    _$_postsAtom.reportRead();
    return super._posts;
  }

  @override
  ObservableList<PostModel> get _posts => posts;

  @override
  set _posts(ObservableList<PostModel> value) {
    _$_postsAtom.reportWrite(value, super._posts, () {
      super._posts = value;
    });
  }

  late final _$loadPostsAsyncAction =
      AsyncAction('_HomePageStore.loadPosts', context: context);

  @override
  Future<void> loadPosts() {
    return _$loadPostsAsyncAction.run(() => super.loadPosts());
  }

  late final _$togglePostLikeAsyncAction =
      AsyncAction('_HomePageStore.togglePostLike', context: context);

  @override
  Future<void> togglePostLike({required int postId}) {
    return _$togglePostLikeAsyncAction
        .run(() => super.togglePostLike(postId: postId));
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage}
    ''';
  }
}
