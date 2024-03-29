import 'package:dartx/dartx.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart' hide UrlLinkifier, UrlElement;

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mewtwo/base/linkify/hashtag_linkifier.dart';
import 'package:mewtwo/base/linkify/mention_linkifier.dart';
import 'package:mewtwo/base/linkify/url_linkifier.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/base/widgets/shoppable_icon.dart';
import 'package:mewtwo/chats/routes/routes.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/post/pages/post_details_page/comments/comments_section/comments_section_store.dart';

import 'package:mewtwo/post/pages/post_details_page/post_details_page_store.dart';
import 'package:mewtwo/post/pages/post_details_page/comments/comments_section/comments_section.dart';
import 'package:mewtwo/post/pages/post_details_page/widgets/post_measurements.dart';
import 'package:mewtwo/post/pages/post_details_page/widgets/post_options.dart';
import 'package:mewtwo/profile/measurements/dialog/measurements_view_dialog.dart';
import 'package:mewtwo/profile/measurements/dialog/models/number_measurement_model.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mewtwo/post/utils.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mewtwo/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PostDetailsPage extends StatefulWidget {
  final int postId;
  final bool isFromApp;

  const PostDetailsPage({Key? key, required this.postId, required this.isFromApp}) : super(key: key);
  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> with TickerProviderStateMixin {
  late final PostDetailsPageStore store;
  late final CommentsSectionStore commentsStore = CommentsSectionStore(postId: widget.postId);
  final transformationController = TransformationController();
  late final smallHeartAnimationController = AnimationController(vsync: this);
  late final bigHeartAnimationController = AnimationController(vsync: this);
  final imagePageController = PageController();
  bool isPageControllerAttached = false;
  @override
  void initState() {
    store = PostDetailsPageStore(postId: widget.postId, commentsStore: commentsStore)..init();
    commentsStore.reload = () => store.load();
    store.load();
    imagePageController.addListener(() {
      if (imagePageController.hasClients) {
        setState(() {
          isPageControllerAttached = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    commentsStore.dispose();
    imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.isFromApp,
      onPopInvoked: (_) {
        if (widget.isFromApp) {
          SystemNavigator.pop(animated: true);
        }
      },
      child: SafeArea(
        child: Observer(builder: (context) {
          final post = store.post;
          if (post == null) {
            return Container();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "${post.posted_by?.username ?? ""}'s post",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF6EC6CA)),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      PostOptions.show(context, store: store, onPostEdit: () {
                        store.load();
                      });
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
            body: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child: InteractiveViewer(
                    transformationController: transformationController,
                    minScale: 1,
                    maxScale: 3,
                    onInteractionStart: (details) {
                      store.interactiveViewState = transformationController.value;
                    },
                    onInteractionEnd: (_) {
                      transformationController.value = store.interactiveViewState;
                    },
                    child: GestureDetector(
                      onDoubleTap: () {
                        store.togglePostLike();
                        if (post.my_like) {
                          smallHeartAnimationController.forward();
                          bigHeartAnimationController.forward();
                        }
                      },
                      child: Stack(
                        children: [
                          postImage(post),
                          Positioned.fill(
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 80,
                            )
                                .animate(
                                    controller: bigHeartAnimationController,
                                    autoPlay: false,
                                    onComplete: (controller) {
                                      Future.delayed(const Duration(milliseconds: 300), () {
                                        controller.reverse();
                                      });
                                    })
                                .fadeIn(duration: const Duration(milliseconds: 100))
                                .scaleXY(duration: const Duration(milliseconds: 200), begin: 1, end: 1.3),
                          ),
                          if (post.chat_enabled)
                            PositionedDirectional(
                              bottom: 8,
                              start: 8,
                              child: GestureDetector(
                                onTap: () => store.isShopableDescriptionVisible = !store.isShopableDescriptionVisible,
                                child: const ShoppableIcon(
                                  size: 24,
                                ),
                              ),
                            ),
                          if (store.isShopableDescriptionVisible)
                            PositionedDirectional(
                              bottom: 8,
                              start: 56,
                              child: Container(
                                  width: 180,
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xFF7D7878).withOpacity(0.8)),
                                  child: Text(
                                    "There is an item in this post that you can buy!",
                                    style: TextStyle(height: 1, fontSize: 15, color: Colors.white.withOpacity(0.65)),
                                  )),
                            ),
                          if (post.posted_by != null && store.isMeasurementsVisible)
                            PositionedDirectional(
                                start: 0,
                                end: 0,
                                bottom: 12,
                                child: PostMeasurements(
                                  user: post.posted_by!,
                                  isMyPost: store.isMyPost,
                                ))
                        ],
                      ),
                    ),
                  ),
                ),
                if (post.images.length > 1)
                  MultiSliver(children: [
                    const SizedBox(height: 8),
                    DotsIndicator(
                      dotsCount: post.images.length,
                      position: isPageControllerAttached ? imagePageController.page ?? 0 : 0,
                    ),
                  ]),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: MultiSliver(children: [
                    SliverToBoxAdapter(child: statsRow(post)),
                    postInfo(post),
                    CommentsSection(
                      store: commentsStore,
                      postId: widget.postId,
                    )
                  ]),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget postImage(PostModel post) {
    return post.images.length > 1
        ? AspectRatio(
            aspectRatio: PostImage.aspectRatio,
            child: PageView.builder(
              controller: imagePageController,
              itemBuilder: (context, index) => PostImage(imageUrl: Utility.parseImageUrl(post.images[index].image)),
              itemCount: post.images.length,
            ),
          )
        : PostImage(imageUrl: post.image);
  }

  Widget statsRow(PostModel post) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            store.togglePostLike();
            smallHeartAnimationController.forward();
          },
          child: Icon(
            post.my_like ? Icons.favorite : Icons.favorite_outline,
            color: const Color(0xFFFA897B),
          )
              .animate(
                  controller: smallHeartAnimationController,
                  autoPlay: false,
                  onComplete: (controller) {
                    controller.reverse();
                  })
              .scaleXY(begin: 1, end: 1.5, duration: const Duration(milliseconds: 100)),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          NumberFormat.decimalPattern().format(post.likes),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        if (!store.isAdminPost)
          GestureDetector(
            onTap: () {
              final user = post.posted_by;
              if (user == null) {
                return;
              }
              if (user.measurementPrivacy == MeasurementPrivacy.following && !user.my_follow && !store.isMyPost) {
                Fluttertoast.showToast(
                    msg: "This user has only allowed followers to view their measurements",
                    gravity: ToastGravity.CENTER);
                return;
              }
              MeasurementsViewDialog.show(context, numberMeasurements: NumberMeasurementModel.fromJson(user.toJson()), sizings: user.brandSizings ?? []);
            },
            child: SvgPicture.asset(
              'assets/icons/measuring_tape.svg',
              height: 32,
              width: 32,
            ),
          ),
        if (post.chat_enabled) ...[
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              if (store.isMyPost) {
                ChatListPageRoute().push(context);
                return;
              }
              if (post.posted_by != null) {
                ChatPageRoute(targetId: post.posted_by!.id).push(context);
              }
            },
            iconSize: 24,
            icon: const Icon(
              Icons.chat_bubble,
              color: Color(0xFFFFDD94),
              size: 24,
            ),
          ),
        ]
      ],
    );
  }

  Widget postInfo(PostModel post) {
    return MultiSliver(children: [
      SliverToBoxAdapter(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              if (post.posted_by != null) {
                final sp = await SharedPreferences.getInstance();
                if (context.mounted) {
                  if (sp.containsKey(Constants.kKeyId) && sp.getInt(Constants.kKeyId) == post.posted_by!.id) {
                    ProfilePageRoute(userId: sp.getInt(Constants.kKeyId)).go(context);
                  } else {
                    OtherProfilePageRoute(userId: post.posted_by!.id).push(context);
                  }
                }
              }
            },
            child: Text(post.posted_by?.username ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            timeago.format(DateTime.fromMillisecondsSinceEpoch((int.tryParse(post.created_at) ?? 0) * 1000)),
            style: const TextStyle(color: Color(0xFF7D7878), fontSize: 16),
          )
        ],
      )),
      const SliverToBoxAdapter(
        child: SizedBox(height: 4),
      ),
      Builder(builder: (context) {
        return Linkify(
          text: TextUtils.replaceEmoji(post.caption),
          linkifiers: [const UrlLinkifier(), MentionLinkifier(mentionedUsers: post.mentions), const HashtagLinkifier()],
          linkStyle: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, decoration: TextDecoration.none),
          style: const TextStyle(fontSize: 16, color: Color(0xFF7D7878)),
          options: const LinkifyOptions(looseUrl: true),
          onOpen: (element) async {
            if (element is MentionElement) {
              OtherProfilePageRoute(userId: element.user.user_id).push(context).then((value) => store.load());
              return;
            }
            if (element is HashtagElement) {
              SearchPageRoute().goWithInitialSearchTerm(context, element.text.removePrefix("#"));
              return;
            }
            if (element is UrlElement) {
              launchUrl(Uri.parse(element.url));
              return;
            }
          },
        );
      })
    ]);
  }
}
