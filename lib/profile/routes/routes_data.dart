part of 'routes.dart';

class ProfilePageRoute extends GoRouteData {

  final int? userId;
  ProfilePageRoute({this.userId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProfilePage(userId: userId,);
  }
}

class OtherProfilePageRoute extends GoRouteData {
  final int userId;
  OtherProfilePageRoute({required this.userId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProfilePage(userId: userId,);
  }
}

class CreateProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateProfilePage();
  }
}

class EditProfileRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey; // TODO: Make this better.
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EditProfilePage();
  }
}

class CreateMeasurementsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateMeasurementsPage();
  }
}

class EditMeasurementsRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey; // TODO: Make this better.
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditMeasurementsPage();
  }
}

class EditStylesRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey; // TODO: Make this better.
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditStylesPage();
  }
}