part of 'routes.dart';

class DropDetailsPageRoute extends GoRouteData {
  final int postId;
  DropDetailsPageRoute({required this.postId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DropDetailsPage(
      postId: postId,
    );
  }
}
