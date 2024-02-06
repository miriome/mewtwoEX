import 'package:flutter/cupertino.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/post/api/api.dart';
import 'package:mewtwo/post/pages/post_details_page/comments/comments_section/comments_section_store.dart';
import 'package:mewtwo/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'post_details_page_store.g.dart';

class PostDetailsPageStore extends _PostDetailsPageStore with _$PostDetailsPageStore {
  PostDetailsPageStore({required super.postId, required super.commentsStore});
}

abstract class _PostDetailsPageStore with Store {
  final int postId;
  final CommentsSectionStore commentsStore;
  _PostDetailsPageStore({required this.postId, required this.commentsStore});

  @observable
  int? _selfUserId;

  Future<void> init() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.containsKey(Constants.kKeyId)) {
      _selfUserId = sp.getInt(Constants.kKeyId);
    }
  }

  @readonly
  bool _isLoading = false;

  @readonly
  PostModel? _post;


  @computed
  bool get isMyPost => _post?.added_by == _selfUserId;

  @observable
  bool isMeasurementsVisible = false;

  @observable
  bool isShopableDescriptionVisible = false;

  @computed
  bool get isAdminPost => _post?.added_by != null ? Utility.isAdmin((_post?.added_by)!) : false;


  @observable
  Matrix4 interactiveViewState = Matrix4.zero();

  
  Future<void> load() async {
    final getPostsProvider = GetPostDetailsApiProvider(postId: postId);

    final listener = Mew.pc.listen(getPostsProvider, (previous, next) {
      _isLoading = next.isLoading;
    });
    final res = await Mew.pc.read(getPostsProvider.future);
    if (res != null) {
      _post = res;
      commentsStore.updateCommments(res.comments ?? []);
      
      
    }
    listener.close();
    
  }

  @action
  Future<void> togglePostLike() async {
    final post = _post;
    if (post == null) {
      return;
    }
    
    final toggle = !post.my_like;
    
    final likePostProvider = LikePostApiProvider(postId: postId, setLikeTo: toggle);
    post.my_like = toggle;
    post.likes += toggle ? 1 : -1;

    await Mew.pc.read(likePostProvider.future);
  }

  @action
  Future<bool> deletePost() async {
    final deletePostProvider = DeletePostApiProvider(postId: postId);
    return await Mew.pc.read(deletePostProvider.future);
  }

  @action
  Future<bool> markPostSold() async {
    final markPostSoldProvider = MarkPostSoldApiProvider(postId: postId);
    return await Mew.pc.read(markPostSoldProvider.future);
  }
  
}