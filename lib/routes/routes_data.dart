part of 'routes.dart';

class HomePageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class FakeNewPostRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    // Used to route to another screen.
    return Container();
  }
}

class SearchPageRoute extends GoRouteData {
  void goWithInitialSearchTerm(BuildContext context, String initialSearchTerm) {
    Mew.pc.read(searchPageStoreProvider).textEditingController.text = initialSearchTerm;
    return go(context);
  }

  void pushWithInitialSearchTerm(BuildContext context, String initialSearchTerm) {
    Mew.pc.read(searchPageStoreProvider).textEditingController.text = initialSearchTerm;
    return go(context);
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchPage();
  }
}

class NotificationPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NotificationPage();
  }
}
