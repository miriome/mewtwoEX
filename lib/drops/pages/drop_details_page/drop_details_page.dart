import 'package:dartx/dartx.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart' hide UrlLinkifier, UrlElement;

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mewtwo/base/linkify/hashtag_linkifier.dart';
import 'package:mewtwo/base/linkify/mention_linkifier.dart';
import 'package:mewtwo/base/linkify/url_linkifier.dart';
import 'package:mewtwo/base/widgets/post_image.dart';

import 'package:mewtwo/constants.dart';
import 'package:mewtwo/drops/api/api.dart';
import 'package:mewtwo/drops/models/drop_post_model.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/post/api/api.dart';

import 'package:mewtwo/profile/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mewtwo/post/utils.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mewtwo/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DropDetailsPage extends StatefulWidget {
  final int postId;

  const DropDetailsPage({Key? key, required this.postId}) : super(key: key);
  @override
  State<DropDetailsPage> createState() => _DropDetailsPageState();
}

class _DropDetailsPageState extends State<DropDetailsPage> with TickerProviderStateMixin {
  final transformationController = TransformationController();
  final imagePageController = PageController();
  bool isPageControllerAttached = false;
  @override
  void initState() {
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
    imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Drop",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ),
            body: Consumer(builder: (context, ref, child) {
              final data = ref.watch(getDropPostDetailsApiProvider(postId: widget.postId));
              return data.when(
                  data: (post) {
                    if (post == null) {
                      return Container();
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            slivers: [
                              SliverToBoxAdapter(
                                child: InteractiveViewer(
                                  transformationController: transformationController,
                                  minScale: 1,
                                  maxScale: 3,
                                  onInteractionStart: (details) {
                                    // store.interactiveViewState = transformationController.value;
                                  },
                                  onInteractionEnd: (_) {
                                    // transformationController.value = store.interactiveViewState;
                                  },
                                  child: Stack(
                                    children: [
                                      postImage(post),
                                    ],
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
                                sliver: postInfo(post),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 16),
                              )
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        child: Row(
                          children: [],
                        ),)
                      ],
                    );
                  },
                  error: (e, s) => const SizedBox.shrink(),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ));
            }));
      }),
    );
  }

  Widget postImage(DropPostModel post) {
    return post.images.length > 1
        ? AspectRatio(
            aspectRatio: PostImage.aspectRatio,
            child: PageView.builder(
              controller: imagePageController,
              itemBuilder: (context, index) => PostImage(imageUrl: Utility.parseImageUrl(post.images[index].image)),
              itemCount: post.images.length,
            ),
          )
        : PostImage(imageUrl: post.images[0].image);
  }

  Widget postInfo(DropPostModel post) {
    return MultiSliver(children: [
      Text(
        post.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SliverToBoxAdapter(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            post.price,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            "Size ${post.size}",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            post.condition,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      )),
      const SliverToBoxAdapter(
        child: SizedBox(height: 4),
      ),
      Builder(builder: (context) {
        return Linkify(
          text: TextUtils.replaceEmoji(post.caption),
          linkifiers: const [UrlLinkifier(), /* MentionLinkifier(mentionedUsers: post.mentions), */ HashtagLinkifier()],
          linkStyle: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, decoration: TextDecoration.none),
          style: const TextStyle(fontSize: 16, color: Color(0xFF7D7878)),
          options: const LinkifyOptions(looseUrl: true),
          onOpen: (element) async {
            if (element is MentionElement) {
              OtherProfilePageRoute(userId: element.user.user_id).push(context);
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
