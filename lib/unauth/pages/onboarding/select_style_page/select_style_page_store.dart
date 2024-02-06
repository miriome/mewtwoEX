
import 'package:mobx/mobx.dart';

part 'select_style_page_store.g.dart';

class SelectStylePageStore extends _SelectStylePageStore with _$SelectStylePageStore {}

abstract class _SelectStylePageStore with Store {

  @observable
  ObservableSet<String> selectedStyles = ObservableSet.of({});
  
}