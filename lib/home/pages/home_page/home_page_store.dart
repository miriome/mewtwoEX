import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mobx/mobx.dart';

part 'home_page_store.g.dart';

class HomePageStore extends _HomePageStore with _$HomePageStore {}

abstract class _HomePageStore with Store {
  _HomePageStore() {
    loadPosts();
  }

  @observable
  int currentPage = 0;

  @readonly
  int _numberOfFollowers = -1;

  @readonly
  bool _isLoading = false;

  @readonly
  ObservableList<PostModel> _posts = ObservableList.of([]);

  @action
  Future<void> loadPosts() async {
    final getPostsProvider = GetPostsApiProvider(pageIndex: currentPage);

    final listener = Mew.pc.listen(getPostsProvider, (previous, next) {
      _isLoading = next.isLoading;
    });
    final res = await Mew.pc.read(getPostsProvider.future);
    if (res != null) {
      _posts = ObservableList.of(res.data);
      _numberOfFollowers = res.followers;
    }
    listener.close();
  }

  @action
  Future<void> togglePostLike({required int postId}) async {
    final currentPost = _posts.firstWhere((element) => element.id == postId);
    final toggle = !currentPost.my_like;
    
    final likePostProvider = LikePostApiProvider(postId: postId, setLikeTo: !currentPost.my_like);
    final postIndex = _posts.indexWhere((element) => element.id == postId);
    _posts[postIndex].my_like = toggle;
    _posts[postIndex].likes += toggle ? 1 : -1;

    await Mew.pc.read(likePostProvider.future);
    
  }
}
