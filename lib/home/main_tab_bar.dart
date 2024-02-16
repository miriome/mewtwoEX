import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:go_router/go_router.dart';
import 'package:mewtwo/config/app_upgrade_dialog/app_upgrade_dialog.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/post/routes/routes.dart';


class MainTabBar extends StatefulWidget {
  final StatefulNavigationShell child;
  const MainTabBar({Key? key, required this.child}) : super(key: key);

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {

  @override
  void initState() {
    // Try to deeplink after logging in.
    FlutterBranchSdk.getLatestReferringParams().then((data) {
      if (data.containsKey("\$canonical_identifier")) {
        context.go(data["\$canonical_identifier"]);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      AppUpgradeDialog.showIfNeeded(context);
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: Mew.tabPrimaryScrollControllers[widget.child.currentIndex],
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: widget.child.currentIndex,
                selectedIconTheme: const IconThemeData(color: Color(0xFF8474A1), size: 35),
                unselectedIconTheme: const IconThemeData(color: Color(0xFF8474A1), size: 35),
                onTap: (index) {
                  if (index == widget.child.currentIndex) {
                    final currentRoute = widget.child.shellRouteContext.routerState.fullPath;
                    final homePath = widget.child.shellRouteContext.route.routes[index];
                    if (homePath is GoRoute) {
                      if (currentRoute == homePath.path) {
                        Mew.tabPrimaryScrollControllers[widget.child.currentIndex].animateTo(
                          0.0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOutCirc,
                        );
                      }
                    }
                    widget.child.goBranch(index, initialLocation: true);
                    return;
                  }
                  if (index == 2) {
                    ImageSummaryEditPageRoute(showCameraOptionsOnEnter: false).push(context);
                    return;
                  }
                  widget.child.goBranch(
                    index,
                  );
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  const BottomNavigationBarItem(
                    label: "",
                    activeIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                  ),
                  BottomNavigationBarItem(
                      label: "",
                      icon: const Icon(
                        Icons.search_outlined,
                      ),
                      activeIcon: Image.asset(
                        'assets/icons/search_filled.png',
                        height: 35,
                        width: 35,
                      )),
                  const BottomNavigationBarItem(label: "", icon: Icon(Icons.add_circle)),
                  const BottomNavigationBarItem(
                      label: "", icon: Icon(Icons.notifications_outlined), activeIcon: Icon(Icons.notifications)),
                  const BottomNavigationBarItem(
                      label: "", icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person)),
                ])),
      ),
    );
  }
}
