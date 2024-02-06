import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/comment_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_editing_controller.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/post/api/api.dart';
import 'package:mewtwo/post/widgets/user_mention_search/user_mention_search_store.dart';
import 'package:mobx/mobx.dart';

part 'comments_section_store.g.dart';

class CommentsSectionStore extends _CommentsSectionStore with _$CommentsSectionStore {
  CommentsSectionStore({required super.postId});
}

abstract class _CommentsSectionStore with Store {
  void Function()? _reloadPostData;
  final int postId;
  static const int _visibleCommentsLength = 3;

  final DetectableTextEditingController commentController = DetectableTextEditingController(
    regExp: atSignRegExp
  );
  final portalController = OverlayPortalController();
  final List<ReactionDisposer> _disposer = [];
  void dispose() {
    commentController.dispose();
    for (var element in _disposer) {
      element.call();
    }
  }

  final UserMentionSearchStore userMentionStore = UserMentionSearchStore();
  _CommentsSectionStore({required this.postId}) {
    _disposer.add(reaction((p0) => userMentionStore.userResults, (results) {
      if (results.isNotEmpty) {
        portalController.show();
      }
    }));
    commentController.addListener(() async {
      if (commentController.text.isNotEmpty) {
        canAddComment = true;
      } else {
        canAddComment = false;
      }
      if (userMentionStore.userResults.isEmpty) {
        portalController.hide();
      }
      final cursorBasePosition = commentController.selection.baseOffset;
      if (cursorBasePosition == -1) {
        // base position becomes -1 when changing text.
        return;
      }

      if (cursorBasePosition != commentController.selection.extentOffset) {
        // Is cursor selection, ignore
        return;
      }
        final splitString = commentController.selection.textBefore(commentController.text).split(" ");
      if (splitString.isEmpty) {
        return;
      }
      String currentlyEditingText = splitString.last;
      // Only @, need user to give filter, so dont show.
      if (!currentlyEditingText.startsWith("@") || (currentlyEditingText.length < 2)) {
        portalController.hide();
        return;
      }
      await userMentionStore.search(currentlyEditingText.substring(1));
      if (userMentionStore.userResults.isNotEmpty) {
        portalController.show();
      }
    });
  }


  void onMentionUserSearchTap(UserModel user) {
    final cursorBasePosition = commentController.selection.baseOffset;

      if (cursorBasePosition != commentController.selection.extentOffset) {
        // Is cursor selection, ignore
        return;
      }
    final splitString = commentController.selection.textBefore(commentController.text).split(" ");
    if (splitString.isEmpty) {
        return;
      }
    splitString[splitString.length - 1] = "@${user.username} ";
    final mentionedString = splitString.join(" ");
    commentController.text = mentionedString + commentController.text.substring(commentController.selection.baseOffset);

  }

  @observable
  ObservableList<CommentModel> _comments = ObservableList.of([]);

  @observable
  bool showAllComments = true;

  @readonly
  bool _isCommentSending = false;

  @computed
  int get commentsLength => _comments.length;


  @observable
  bool canAddComment = false;

  @computed
  List<CommentModel> get visibleComments {
    if (showAllComments) {
      return _comments;
    }
    if (_comments.length <= _visibleCommentsLength) {
      return _comments;
    }
    return _comments.sublist(_comments.length - _visibleCommentsLength);
  }

  set reload(void Function() func) {
    _reloadPostData = func;
  }

  @action
  void updateCommments(List<CommentModel> comments) {
    _comments = ObservableList.of(comments);
    showAllComments = _comments.length <= _visibleCommentsLength;
  }

  Future<void> deleteComment(int commentId) async {
    final deleteCommentProvider = DeleteCommentApiProvider(commentId: commentId);
    final res = await Mew.pc.read(deleteCommentProvider.future);
    if (res) {
      _comments.removeWhere((element) => element.id == commentId);
    }
  }

  Future<bool> addComment({required int postId}) async {
    
    _isCommentSending = true;
    final addCommentProvider = AddCommentApiProvider(comment: commentController.text, postId: postId);
    final res = await Mew.pc.read(addCommentProvider.future);
    if (res) {
      _isCommentSending = false;
      commentController.text = "";
      _reloadPostData?.call();
    }
    return res;
  }
}
