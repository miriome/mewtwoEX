import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mobx/mobx.dart';
import 'package:async/async.dart';

part 'user_mention_search_store.g.dart';

class UserMentionSearchStore extends _UserMentionSearchStore with _$UserMentionSearchStore {}

abstract class _UserMentionSearchStore with Store {
  CancelableOperation? _currentSearchOp;
  @readonly
  bool _isLoading = false;

  @readonly
  ObservableList<UserModel> _userResults = ObservableList.of([]);

  String searchedText = "";

  @action
  Future<void> search(String searchTerm) async {
    // Do not research.
    if (searchedText == searchTerm) {
      return;
    }
    _isLoading = true;
    searchedText = searchTerm;
    _currentSearchOp?.cancel();
    final searchApiProvider = SearchApiProvider(pageIndex: 0, keyword: searchTerm);

    final cancelableFut = CancelableOperation.fromFuture(Mew.pc.read(searchApiProvider.future));

    _currentSearchOp = cancelableFut.then((res) {
      if (res != null) {
        _userResults = ObservableList.of(res.userData ?? []);
      }
      _isLoading = false;
    });
    
    
  }
}
