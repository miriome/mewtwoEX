import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mewtwo/chats/routes/routes.dart';
import 'package:mewtwo/home/pages/drops_page/drops_page.dart';
import 'package:mewtwo/home/pages/search_page/search_page_store.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/unauth/routes/routes.dart';
import 'package:mewtwo/home/main_tab_bar.dart';
import 'package:mewtwo/home/pages/home_page/home_page.dart';
import 'package:mewtwo/home/pages/notification_page/notification_page.dart';
import 'package:mewtwo/home/pages/search_page/search_page.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/safety/api/api.dart';
import 'package:mewtwo/safety/routes/routes.dart';
part 'routes_data.dart';
part 'routes.g.dart';

@TypedGoRoute<UnauthorizedRoute>(path: '/unauth', routes: [...UnauthRoutes.typedRoutes])
class UnauthorizedRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Container();
  }
}

// Main tab routes start ------------------------------------

@TypedStatefulShellRoute<MainTabShellRoute>(branches: [
  TypedStatefulShellBranch(
    routes: [
      TypedGoRoute<HomePageRoute>(path: '/', routes: [
        TypedGoRoute<NotificationPageRoute>(
          path: 'notifications-page',
        ),
        ...SafetyRoutes.typedRoutes,
        ...ProfileRoutes.typedRoutes,
        ...PostRoutes.typedRoutes,
        ...ChatRoutes.typedRoutes
      ])
    ],
  ),
  TypedStatefulShellBranch(
    routes: [
      TypedGoRoute<SearchPageRoute>(
        path: '/SearchPage',
      )
    ],
  ),
  TypedStatefulShellBranch(
    routes: [
      TypedGoRoute<FakeNewPostRoute>(
        path: '/NewPost',
      )
    ],
  ),
  TypedStatefulShellBranch(
    routes: [
      TypedGoRoute<DropsPageRoute>(
        path: '/DropsPage',
      )
    ],
  ),
  TypedStatefulShellBranch(
    routes: [ProfileRoutes.profilePageRoute],
  ),
])
class MainTabShellRoute extends StatefulShellRouteData {
  const MainTabShellRoute();
  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainTabBar(child: navigationShell);
  }
}
// Main tab routes end ------------------------------------