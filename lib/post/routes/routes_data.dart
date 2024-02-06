part of 'routes.dart';

class PostDetailsRoute extends GoRouteData {
  final int postId;
  final bool isFromApp;
  PostDetailsRoute({required this.postId, this.isFromApp = false});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PostDetailsPage(postId: postId, isFromApp: isFromApp);
  }
}

class ImageSummaryEditPageRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey; // TODO: Make this better.
  final bool showCameraOptionsOnEnter;
  final int? editPostId;
  final int? initialPhotoIndex;
  ImageSummaryEditPageRoute({required this.showCameraOptionsOnEnter, this.editPostId, this.initialPhotoIndex}) {
    int i = 1;
  }
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ImagesSummaryEditPage(
      showCameraOptionsOnEnter: showCameraOptionsOnEnter,
      editPostId: editPostId,
      initialPhotoIndex: initialPhotoIndex ?? 0,
    );
  }
}

class CreatePostRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey; // TODO: Make this better.

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreatePostPage();
  }
}

class EditPostRoute extends GoRouteData {
  final int postId;
  EditPostRoute({required this.postId});
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey; // TODO: Make this better.

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditPostPage(postId: postId);
  }
}

class LikedPostsPageRoute extends GoRouteData {
  
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LikedPostsPage();
  }
}
