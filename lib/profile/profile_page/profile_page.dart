import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mewtwo/chats/routes/routes.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/profile/profile_page/profile_page_store.dart';
import 'package:mewtwo/profile/profile_page/widgets/profile_options.dart';
import 'package:mewtwo/profile/profile_page/widgets/profile_post_tile.dart';
import 'package:mewtwo/routes/routes.dart';

import 'package:mewtwo/utils.dart';
import 'package:mobx/mobx.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final int? userId;
  const ProfilePage({Key? key, this.userId}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  // For when it is rendered in main tab.
  static const int _pageTabIndex = 4;

  ProfilePageStore get store {
    return widget.userId != null
        ? ref.watch(OtherUserProfilePageStoreProvider(userId: widget.userId!))
        : ref.watch(currentUserProfilePageStoreProvider);
  }

  @override
  Widget build(BuildContext context) {
    return ReactionBuilder(
      builder: (context) {
        return reaction((_) => store.isLoading, (isLoading) {
          if (isLoading) {
            EasyLoading.show();
          } else {
            EasyLoading.dismiss();
          }
        });
      },
      child: Observer(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                if (!store.isAdminProfile) ...[
                  measurements,
                  const SizedBox(height: 14),
                ],
                relationStatistics,
                const SizedBox(height: 16),
                store.posts.isNotEmpty
                    ? Expanded(
                        child: RefreshIndicator(
                        onRefresh: () async {
                          store.load();
                        },
                        child: AlignedGridView.count(
                          controller: store.isOwnProfile
                              ? Mew.tabPrimaryScrollControllers[_pageTabIndex]
                              : PrimaryScrollController.of(context),
                          physics: const AlwaysScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          itemBuilder: (context, index) {
                            return ProfilePostTile(post: store.posts[index], store: store);
                          },
                          itemCount: store.posts.length,
                        ),
                      ))
                    : Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              await ImageSummaryEditPageRoute(showCameraOptionsOnEnter: false, initialPhotoIndex: 0)
                                  .push(context);
                              store.load();
                            },
                            child: const Text.rich(
                                TextSpan(style: TextStyle(fontSize: 16, color: Color(0xFF7D7878)), children: [
                              TextSpan(text: "You don’t have any posts yet.\n"),
                              TextSpan(
                                  text: "Create your first post now! :)",
                                  style: TextStyle(decoration: TextDecoration.underline))
                            ])),
                          )
                        ],
                      )
              ],
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget get appBar {
    return AppBar(
      title: Observer(builder: (context) {
        return store.user != null
            ? Row(mainAxisSize: MainAxisSize.min, children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFF6EC6CA),
                  foregroundImage: store.user?.photo_url == Networking.imageDomain || store.user?.photo_url == null
                      ? null
                      : CachedNetworkImageProvider(
                          store.user?.photo_url ?? "",
                        ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      store.user?.name ?? "",
                      style: GoogleFonts.roboto(
                          height: 1, fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF7D7878)),
                    ),
                    Text(
                      store.user?.username ?? "",
                      style: GoogleFonts.roboto(
                          height: 1, fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF6EC6CA)),
                    )
                  ],
                )
              ])
            : const CircularProgressIndicator();
      }),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: IconButton(
              onPressed: () {
                if (store.user != null) {
                  if (store.isOwnProfile) {
                    ProfileOptions.showOwnProfileOptions(context, store: store);
                  } else {
                    ProfileOptions.showOtherProfileOptions(context, store: store);
                  }
                }
              },
              iconSize: 30,
              icon: Icon(
                store.isOwnProfile ? Icons.more_vert : Icons.menu,
                color: const Color(0xFF8474A1),
              )),
        ),
      ],
      surfaceTintColor: Colors.white,
    );
  }

  Widget get measurements {
    final user = store.user;
    if (!store.isOwnProfile && user != null) {
      if (user.measurementPrivacy == MeasurementPrivacy.following && !user.my_follow) {
        return const Text(
          "This user has only allowed followers to view their measurements.",
          textAlign: TextAlign.center,
        );
      }
    }

    // Change this to dynamic lmao
    const heightUnits = "cm";
    const otherUnits = "in";
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Height: ${(store.user?.height == null || int.tryParse(store.user!.height!) == null) ? "-" : int.tryParse(store.user!.height!)} $heightUnits",
          style: GoogleFonts.roboto(color: const Color(0xFF7D7878), fontSize: 14),
        ),
        Text(
          "Bust: ${(store.user?.bust == null || int.tryParse(store.user!.bust!) == null) ? "-" : int.tryParse(store.user!.bust!)} $otherUnits | Waist: ${(store.user?.waist == null || int.tryParse(store.user!.waist!) == null) ? "-" : int.tryParse(store.user!.waist!)} $otherUnits | Hips: ${(store.user?.hips == null || int.tryParse(store.user!.hips!) == null) ? "-" : int.tryParse(store.user!.hips!)} $otherUnits",
          style: GoogleFonts.roboto(color: const Color(0xFF7D7878), fontSize: 14),
        )
      ],
    );
  }

  Widget get relationStatistics {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
            TextSpan(children: [
              TextSpan(text: "${store.followers}\n", style: const TextStyle(fontWeight: FontWeight.w700)),
              const TextSpan(
                text: "Followers",
              )
            ]),
            style: GoogleFonts.roboto(color: const Color(0xFF7D7878), fontSize: 14),
            textAlign: TextAlign.center),
        const SizedBox(
          width: 24,
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: "${store.likes}\n", style: const TextStyle(fontWeight: FontWeight.w700)),
            const TextSpan(text: "Likes")
          ]),
          style: GoogleFonts.roboto(
            color: const Color(0xFF7D7878),
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        if (!store.isOwnProfile) ...[
          const SizedBox(
            width: 24,
          ),
          GestureDetector(
            onTap: () => store.toggleUserFollow(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF8474A1), width: (store.isFollowingUser) ? 0 : 2),
                  color: (store.isFollowingUser) ? const Color(0xFF8474A1) : Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                (store.isFollowingUser) ? "Following" : "Follow",
                style: TextStyle(
                    color: (store.isFollowingUser) ? Colors.white : const Color(0xFF8474A1),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          GestureDetector(
            onTap: () {
              ChatPageRoute(targetId: store.user!.id).push(context);
            },
            child: const Icon(
              Icons.chat_bubble,
              color: Color(0xFFFFDD94),
              size: 24,
            ),
          )
        ]
      ],
    );
  }
}
