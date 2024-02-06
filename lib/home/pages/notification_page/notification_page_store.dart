import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/notification_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mobx/mobx.dart';

part 'notification_page_store.g.dart';

class NotificationPageStore extends _NotificationPageStore with _$NotificationPageStore {}

abstract class _NotificationPageStore with Store {

  @readonly
  bool _isLoading = false;

  @readonly
  ObservableList<NotificationModel> _notifications = ObservableList.of([]);

  @action
  Future<void> load() async {
    final getNotificationsProvider = getNotificationsApiProvider;

    final listener = Mew.pc.listen(getNotificationsProvider, (previous, next) {
      _isLoading = next.isLoading;
    });
    final res = await Mew.pc.read(getNotificationsProvider.future);
    _notifications = ObservableList.of(res);
    listener.close();
  }
  
}