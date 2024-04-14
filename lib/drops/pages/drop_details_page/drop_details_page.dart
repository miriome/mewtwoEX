import 'package:dartx/dartx.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart' hide UrlLinkifier, UrlElement;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/base/linkify/hashtag_linkifier.dart';
import 'package:mewtwo/base/linkify/mention_linkifier.dart';
import 'package:mewtwo/base/linkify/url_linkifier.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/chats/routes/routes.dart';

import 'package:mewtwo/drops/api/api.dart';
import 'package:mewtwo/drops/models/drop_post_model.dart';
import 'package:mewtwo/profile/measurements/dialog/measurements_view_dialog.dart';

import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/post/utils.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  Matrix4 initialControllerValue = Matrix4.zero();

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
    transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Drop",
              // maxLines: ,
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
                                  initialControllerValue = transformationController.value;
                                },
                                onInteractionEnd: (_) {
                                  transformationController.value = initialControllerValue;
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (post.numberSizing != null &&
                                    !post.numberSizing!.hasNoMeasurement() &&
                                    post.brandSizing != null &&
                                    post.brandSizing!.isNotEmpty) {
                                  MeasurementsViewDialog.show(context,
                                      // Details and main page shouldnt share the same model. I got lazy.
                                      numberMeasurements: post.numberSizing!,
                                      sizings: post.brandSizing!);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "This drop has currently no measurements", gravity: ToastGravity.CENTER);
                                }
                              },
                              child: SvgPicture.asset(
                                'assets/icons/measuring_tape.svg',
                                height: 32,
                                width: 32,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (post.isSold) {
                                    return;
                                  }
                                  FullscreenChatPageRoute(targetId: 52).push(context);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: post.isSold
                                            ? const Color(0xFF8474A1).withOpacity(0.8)
                                            : Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        post.isSold ? "Sold" : "Chat to Buy",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
                error: (e, s) => const SizedBox.shrink(),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ));
          })),
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
            "\$${post.price}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            "Size ${post.clothingSize}",
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
          style: const TextStyle(
            fontSize: 16,
          ),
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
