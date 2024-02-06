import 'dart:io';

import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/post/pages/upsert_post/images_summary_edit_page/images_summary_edit_page_store.dart';
import 'package:mewtwo/post/pages/upsert_post/upsert_post_base/upsert_post_base_store.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/post/widgets/user_mention_search/user_mention_search.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';

class UpsertPostBase extends StatefulWidget {
  final UpsertPostBaseStore store;

  /// If this is not null, this is edit post
  final int? editPostId;
  const UpsertPostBase({Key? key, required this.store, this.editPostId}) : super(key: key);

  @override
  State<UpsertPostBase> createState() => _UpsertPostBaseState();
}

class _UpsertPostBaseState extends State<UpsertPostBase> {
  final ImagePicker picker = ImagePicker();
  final link = LayerLink();
  final portalController = OverlayPortalController();
  final textScrollController = ScrollController();
  @override
  void initState() {
    widget.store.addListenerForPortalController(portalController);
    
    super.initState();
  }
  @override
  void dispose() {
    textScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(widget.editPostId == null ? "New Post" : "Edit Post"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: buildPostImageSection(),
                      ),
                      const SizedBox(height: 36),
                      CompositedTransformTarget(
                        link: link,
                        child: OverlayPortal(
                          controller: portalController,
                          overlayChildBuilder: (context) => PositionedDirectional(
                            height: 200,
                            start: 0,
                            end: 0,
                            child: CompositedTransformFollower(
                              link: link,
                              targetAnchor: Alignment.bottomLeft,
                              followerAnchor: Alignment.bottomLeft,
                              child: UserMentionSearch(
                                  onUserResultsTap: (user) {
                                    widget.store.onMentionUserSearchTap(user);
                                    portalController.hide();
                                  },
                                  store: widget.store.userMentionStore),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: shopMyLook(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Scrollbar(
                          controller: textScrollController,
                          child: DetectableTextField(
                            scrollController: textScrollController,
                            onTapOutside: (_) => FocusScope.of(context).unfocus(),
                            minLines: 5,
                            maxLines: 5,
                            style: const TextStyle(fontSize: 16),
                            controller: widget.store.controller,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText:
                                    "Write your caption here...\n🔥Tip: Include the size, price and hyperlinks of your clothes for better content creation on miromie!",
                                hintStyle: TextStyle(fontSize: 14, color: Color(0xFF7D7878)),
                                hintMaxLines: 5,
                                border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF7D7878))),
                                enabledBorder:
                                    OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF7D7878)))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: FilledButton(
                  onPressed: () async {
                    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
                    final res = await widget.store.post();
                    EasyLoading.dismiss();
                    if (res && context.mounted) {
                      Fluttertoast.showToast(
                          msg: widget.editPostId != null ? "Post edited" : "Post uploaded",
                          gravity: ToastGravity.CENTER);
                      ProfilePageRoute().go(context);
                    }
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            )
          ],
        ),
      ));
    });
  }

  Widget buildPostImageSection() {
    return Consumer(builder: (context, ref, child) {
      return Observer(builder: (context) {
        return SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 8,),
            itemBuilder: (context, index) {
              if (index < 10 && index == widget.store.postImagePaths.length) {
                return GestureDetector(
                  onTap: () {
                    // We use watch so that the state remains alive for the next page to attach in.
                    final imageSummartEditStore = ref.watch(imageSummaryEditPageStoreProvider);
                    imageSummartEditStore.setSelectedImages(widget.store.postImagePaths, true);
                    ImageSummaryEditPageRoute(
                            showCameraOptionsOnEnter: true, editPostId: widget.editPostId, initialPhotoIndex: 0)
                        .push(context);
                  },
                  child: Container(
                    height: 120,
                    width: PostImage.aspectRatio * 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), border: Border.all(color: const Color(0xFF7D7878))),
                    child: const Icon(Icons.add),
                  ),
                );
              }
              return buildPostImageItem(index: index);
            },
            itemCount: widget.store.postImagePaths.length + 1,
          ),
        );
      });
    });
  }

  Widget buildPostImageItem({required int index}) {
    return Consumer(builder: (context, ref, child) {
      return Stack(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 120,
            ),
            child: GestureDetector(
              onTap: () {
                // We use watch so that the state remains alive for the next page to attach in.
                final imageSummartEditStore = ref.watch(imageSummaryEditPageStoreProvider);
                imageSummartEditStore.setSelectedImages(widget.store.postImagePaths, true);
                ImageSummaryEditPageRoute(
                        showCameraOptionsOnEnter: false, editPostId: widget.editPostId, initialPhotoIndex: index)
                    .push(context);
              },
              child: Observer(builder: (context) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: PostImage(imageUrl: widget.store.postImagePaths[index]));
              }),
            ),
          ),
          if (widget.editPostId == null)
            PositionedDirectional(
                top: 4,
                end: 4,
                child: GestureDetector(
                    onTap: () {
                      widget.store.removeImageAt(index: index);
                    },
                    child: SvgPicture.asset("assets/icons/ic_remove.svg")))
        ],
      );
    });
  }

  Widget shopMyLook() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          child: Checkbox(
              value: widget.store.shopMyLook,
              onChanged: (toggle) => widget.store.shopMyLook = toggle ?? false,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xFF8474A1);
                }
                return null;
              })),
        ),
        const Text(
          "Shop My Look",
          style: TextStyle(fontSize: 16, color: Color(0xFF8474A1), fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
            child: Text(
          widget.store.shopMyLook
              ? "Others can chat with you to purchase your item(s)"
              : "Enable this if you are selling any items",
          maxLines: 2,
          style: const TextStyle(color: Color(0xFF7D7878)),
        ))
      ],
    );
  }
}
