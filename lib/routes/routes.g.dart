// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $unauthorizedRoute,
      $authorizedRoute,
      $mainTabShellRoute,
    ];

RouteBase get $unauthorizedRoute => GoRouteData.$route(
      path: '/unauth',
      factory: $UnauthorizedRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'login',
          parentNavigatorKey: LoginRoute.$parentNavigatorKey,
          factory: $LoginRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'select-pronouns',
          factory: $SelectPronounsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'select-style',
          factory: $SelectStyleRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'sign-up',
          factory: $SignUpRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'forget-password',
          factory: $ForgetPasswordRouteExtension._fromState,
        ),
      ],
    );

extension $UnauthorizedRouteExtension on UnauthorizedRoute {
  static UnauthorizedRoute _fromState(GoRouterState state) =>
      UnauthorizedRoute();

  String get location => GoRouteData.$location(
        '/unauth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute();

  String get location => GoRouteData.$location(
        '/unauth/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SelectPronounsRouteExtension on SelectPronounsRoute {
  static SelectPronounsRoute _fromState(GoRouterState state) =>
      SelectPronounsRoute();

  String get location => GoRouteData.$location(
        '/unauth/select-pronouns',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SelectStyleRouteExtension on SelectStyleRoute {
  static SelectStyleRoute _fromState(GoRouterState state) => SelectStyleRoute();

  String get location => GoRouteData.$location(
        '/unauth/select-style',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SignUpRouteExtension on SignUpRoute {
  static SignUpRoute _fromState(GoRouterState state) => SignUpRoute();

  String get location => GoRouteData.$location(
        '/unauth/sign-up',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ForgetPasswordRouteExtension on ForgetPasswordRoute {
  static ForgetPasswordRoute _fromState(GoRouterState state) =>
      ForgetPasswordRoute();

  String get location => GoRouteData.$location(
        '/unauth/forget-password',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authorizedRoute => GoRouteData.$route(
      path: '/auth',
      factory: $AuthorizedRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'drop/postDetails',
          factory: $DropDetailsPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'chat/:targetId',
          factory: $FullscreenChatPageRouteExtension._fromState,
        ),
      ],
    );

extension $AuthorizedRouteExtension on AuthorizedRoute {
  static AuthorizedRoute _fromState(GoRouterState state) => AuthorizedRoute();

  String get location => GoRouteData.$location(
        '/auth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DropDetailsPageRouteExtension on DropDetailsPageRoute {
  static DropDetailsPageRoute _fromState(GoRouterState state) =>
      DropDetailsPageRoute(
        postId: int.parse(state.uri.queryParameters['post-id']!),
      );

  String get location => GoRouteData.$location(
        '/auth/drop/postDetails',
        queryParams: {
          'post-id': postId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FullscreenChatPageRouteExtension on FullscreenChatPageRoute {
  static FullscreenChatPageRoute _fromState(GoRouterState state) =>
      FullscreenChatPageRoute(
        targetId: int.parse(state.pathParameters['targetId']!),
      );

  String get location => GoRouteData.$location(
        '/auth/chat/${Uri.encodeComponent(targetId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainTabShellRoute => StatefulShellRouteData.$route(
      factory: $MainTabShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/',
              factory: $HomePageRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'notifications-page',
                  factory: $NotificationPageRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'reportContent',
                  parentNavigatorKey: ReportContentRoute.$parentNavigatorKey,
                  factory: $ReportContentRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'OtherProfilePage',
                  factory: $OtherProfilePageRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'create-profile',
                  parentNavigatorKey: CreateProfileRoute.$parentNavigatorKey,
                  factory: $CreateProfileRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'edit-profile',
                  factory: $EditProfileRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'create-measurements',
                  parentNavigatorKey:
                      CreateMeasurementsRoute.$parentNavigatorKey,
                  factory: $CreateMeasurementsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'edit-measurements',
                  parentNavigatorKey: EditMeasurementsRoute.$parentNavigatorKey,
                  factory: $EditMeasurementsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'edit-styles',
                  parentNavigatorKey: EditStylesRoute.$parentNavigatorKey,
                  factory: $EditStylesRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'postDetails',
                  factory: $PostDetailsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'new-post',
                  parentNavigatorKey: CreatePostRoute.$parentNavigatorKey,
                  factory: $CreatePostRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'edit-post',
                  parentNavigatorKey: EditPostRoute.$parentNavigatorKey,
                  factory: $EditPostRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'image-summary-edit',
                  parentNavigatorKey:
                      ImageSummaryEditPageRoute.$parentNavigatorKey,
                  factory: $ImageSummaryEditPageRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'liked-posts',
                  factory: $LikedPostsPageRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'chat-list',
                  factory: $ChatListPageRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'chat/:targetId',
                  factory: $ChatPageRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/SearchPage',
              factory: $SearchPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/NewPost',
              factory: $FakeNewPostRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/DropsPage',
              factory: $DropsPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/ProfilePage',
              factory: $ProfilePageRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainTabShellRouteExtension on MainTabShellRoute {
  static MainTabShellRoute _fromState(GoRouterState state) =>
      const MainTabShellRoute();
}

extension $HomePageRouteExtension on HomePageRoute {
  static HomePageRoute _fromState(GoRouterState state) => HomePageRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NotificationPageRouteExtension on NotificationPageRoute {
  static NotificationPageRoute _fromState(GoRouterState state) =>
      NotificationPageRoute();

  String get location => GoRouteData.$location(
        '/notifications-page',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ReportContentRouteExtension on ReportContentRoute {
  static ReportContentRoute _fromState(GoRouterState state) =>
      ReportContentRoute(
        reportType: _$ReportTypeEnumMap
            ._$fromName(state.uri.queryParameters['report-type']!),
        typeId: state.uri.queryParameters['type-id']!,
      );

  String get location => GoRouteData.$location(
        '/reportContent',
        queryParams: {
          'report-type': _$ReportTypeEnumMap[reportType],
          'type-id': typeId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$ReportTypeEnumMap = {
  ReportType.post: 'post',
  ReportType.comment: 'comment',
  ReportType.user: 'user',
};

extension $OtherProfilePageRouteExtension on OtherProfilePageRoute {
  static OtherProfilePageRoute _fromState(GoRouterState state) =>
      OtherProfilePageRoute(
        userId: int.parse(state.uri.queryParameters['user-id']!),
      );

  String get location => GoRouteData.$location(
        '/OtherProfilePage',
        queryParams: {
          'user-id': userId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CreateProfileRouteExtension on CreateProfileRoute {
  static CreateProfileRoute _fromState(GoRouterState state) =>
      CreateProfileRoute();

  String get location => GoRouteData.$location(
        '/create-profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EditProfileRouteExtension on EditProfileRoute {
  static EditProfileRoute _fromState(GoRouterState state) => EditProfileRoute();

  String get location => GoRouteData.$location(
        '/edit-profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CreateMeasurementsRouteExtension on CreateMeasurementsRoute {
  static CreateMeasurementsRoute _fromState(GoRouterState state) =>
      CreateMeasurementsRoute();

  String get location => GoRouteData.$location(
        '/create-measurements',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EditMeasurementsRouteExtension on EditMeasurementsRoute {
  static EditMeasurementsRoute _fromState(GoRouterState state) =>
      EditMeasurementsRoute();

  String get location => GoRouteData.$location(
        '/edit-measurements',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EditStylesRouteExtension on EditStylesRoute {
  static EditStylesRoute _fromState(GoRouterState state) => EditStylesRoute();

  String get location => GoRouteData.$location(
        '/edit-styles',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PostDetailsRouteExtension on PostDetailsRoute {
  static PostDetailsRoute _fromState(GoRouterState state) => PostDetailsRoute(
        postId: int.parse(state.uri.queryParameters['post-id']!),
        isFromApp: _$convertMapValue(
                'is-from-app', state.uri.queryParameters, _$boolConverter) ??
            false,
      );

  String get location => GoRouteData.$location(
        '/postDetails',
        queryParams: {
          'post-id': postId.toString(),
          if (isFromApp != false) 'is-from-app': isFromApp.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CreatePostRouteExtension on CreatePostRoute {
  static CreatePostRoute _fromState(GoRouterState state) => CreatePostRoute();

  String get location => GoRouteData.$location(
        '/new-post',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EditPostRouteExtension on EditPostRoute {
  static EditPostRoute _fromState(GoRouterState state) => EditPostRoute(
        postId: int.parse(state.uri.queryParameters['post-id']!),
      );

  String get location => GoRouteData.$location(
        '/edit-post',
        queryParams: {
          'post-id': postId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ImageSummaryEditPageRouteExtension on ImageSummaryEditPageRoute {
  static ImageSummaryEditPageRoute _fromState(GoRouterState state) =>
      ImageSummaryEditPageRoute(
        showCameraOptionsOnEnter: _$boolConverter(
            state.uri.queryParameters['show-camera-options-on-enter']!),
        editPostId: _$convertMapValue(
            'edit-post-id', state.uri.queryParameters, int.parse),
        initialPhotoIndex: _$convertMapValue(
            'initial-photo-index', state.uri.queryParameters, int.parse),
      );

  String get location => GoRouteData.$location(
        '/image-summary-edit',
        queryParams: {
          'show-camera-options-on-enter': showCameraOptionsOnEnter.toString(),
          if (editPostId != null) 'edit-post-id': editPostId!.toString(),
          if (initialPhotoIndex != null)
            'initial-photo-index': initialPhotoIndex!.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LikedPostsPageRouteExtension on LikedPostsPageRoute {
  static LikedPostsPageRoute _fromState(GoRouterState state) =>
      LikedPostsPageRoute();

  String get location => GoRouteData.$location(
        '/liked-posts',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChatListPageRouteExtension on ChatListPageRoute {
  static ChatListPageRoute _fromState(GoRouterState state) =>
      ChatListPageRoute();

  String get location => GoRouteData.$location(
        '/chat-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChatPageRouteExtension on ChatPageRoute {
  static ChatPageRoute _fromState(GoRouterState state) => ChatPageRoute(
        targetId: int.parse(state.pathParameters['targetId']!),
      );

  String get location => GoRouteData.$location(
        '/chat/${Uri.encodeComponent(targetId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SearchPageRouteExtension on SearchPageRoute {
  static SearchPageRoute _fromState(GoRouterState state) => SearchPageRoute();

  String get location => GoRouteData.$location(
        '/SearchPage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FakeNewPostRouteExtension on FakeNewPostRoute {
  static FakeNewPostRoute _fromState(GoRouterState state) => FakeNewPostRoute();

  String get location => GoRouteData.$location(
        '/NewPost',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DropsPageRouteExtension on DropsPageRoute {
  static DropsPageRoute _fromState(GoRouterState state) => DropsPageRoute();

  String get location => GoRouteData.$location(
        '/DropsPage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfilePageRouteExtension on ProfilePageRoute {
  static ProfilePageRoute _fromState(GoRouterState state) => ProfilePageRoute(
        userId:
            _$convertMapValue('user-id', state.uri.queryParameters, int.parse),
      );

  String get location => GoRouteData.$location(
        '/ProfilePage',
        queryParams: {
          if (userId != null) 'user-id': userId!.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}
