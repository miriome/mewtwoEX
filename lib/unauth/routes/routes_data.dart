part of 'routes.dart';


class LoginRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey; // TODO: Make this better.
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginPage();
  }
}

class SelectPronounsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SelectPronounsPage();
  }
}

class SelectStyleRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SelectStylePage();
  }
}

class SignUpRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpPage();
  }
}

class ForgetPasswordRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ForgetPasswordPage();
  }
}
