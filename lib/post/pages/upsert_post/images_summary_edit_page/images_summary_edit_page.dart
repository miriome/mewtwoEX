import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/post/pages/upsert_post/edit_post_page/edit_post_page_store.dart';
import 'package:mewtwo/post/pages/upsert_post/images_summary_edit_page/images_summary_edit_page_store.dart';
import 'package:mewtwo/post/pages/upsert_post/upsert_post_base/upsert_post_base_store.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImagesSummaryEditPage extends ConsumerStatefulWidget {
  final bool showCameraOptionsOnEnter;
  final int? editPostId;
  final int initialPhotoIndex;

  const ImagesSummaryEditPage(
      {Key? key, required this.showCameraOptionsOnEnter, this.editPostId, required this.initialPhotoIndex})
      : super(key: key);

  @override
  ConsumerState<ImagesSummaryEditPage> createState() => _ImagesSummaryEditPageState();
}

class _ImagesSummaryEditPageState extends ConsumerState<ImagesSummaryEditPage> {
  final ImagePicker picker = ImagePicker();
  final PageController imagePageController = PageController();
  final GlobalKey postImageGlobalKey = GlobalKey();

  @override
  void initState() {
    imagePageController.addListener(() {
      final store = ref.read(imageSummaryEditPageStoreProvider);
      store.updatePagePosition(imagePageController.page ?? 0);
    });
    if (widget.showCameraOptionsOnEnter) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final store = ref.read(imageSummaryEditPageStoreProvider);
        selectPhoto(context: context, store: store);
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (imagePageController.hasClients) {
        imagePageController.jumpToPage(widget.initialPhotoIndex);
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
    final store = ref.watch(imageSummaryEditPageStoreProvider);
    return Observer(builder: (context) {
      return PopScope(
        canPop: store.displayImagePaths.isEmpty,
        onPopInvoked: (canPop) {
          if (!canPop) {
            store.clearAllImages();
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.editPostId == null ? "New Post" : "Edit Post"),
            ),
            body: Center(
              child: Observer(builder: (context) {
                if (store.displayImagePaths.isEmpty) {
                  return AspectRatio(
                      aspectRatio: PostImage.aspectRatio,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          selectPhoto(context: context, store: store);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [Icon(Icons.add_a_photo), Text("Tap here to upload a new photo for your post")],
                          ),
                        ),
                      ));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          AspectRatio(
                            aspectRatio: PostImage.aspectRatio,
                            child: PageView(
                                key: postImageGlobalKey,
                                controller: imagePageController,
                                children: store.displayImagePaths
                                    .mapIndexed((index, image) => Stack(
                                          children: [
                                            PostImage(imageUrl: image),
                                            PositionedDirectional(
                                                bottom: 8,
                                                end: 8,
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      final croppedImagePath = await cropImage(image);
                                                      if (croppedImagePath != null) {
                                                        store.updateImagePathAt(index: index, path: croppedImagePath);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/icons/ic_crop.svg",
                                                      height: 40,
                                                      width: 40,
                                                    )))
                                          ],
                                        ))
                                    .toList()),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (store.displayImagePaths.length > 1) buildPhotoList(),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: FilledButton(
                          onPressed: () async {
                            EasyLoading.show();
                            try {
                              await store.cropAllImages(postImageGlobalKey);
                            } catch (e) {
                              // TODO Log error
                            }
                            EasyLoading.dismiss();
                            final uneditedImagesIndexes = store.uneditedImageNumbers;
                            if (uneditedImagesIndexes.isNotEmpty) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Images ${uneditedImagesIndexes.join(',')} are unable to be cropped, please remove them before proceeding");
                              return;
                            }
                            if (context.mounted) {
                              if (widget.editPostId == null) {
                                ref.invalidate(upsertPostBaseStoreProvider);
                                CreatePostRoute().push(context);
                              } else {
                                ref
                                    .read(editPostPageStoreProvider(postId: widget.editPostId!))
                                    .setPostImages(store.displayImagePaths);
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      );
    });
  }

  /// Returns the path to the cropped image.
  Future<String?> cropImage(String imagePath) async {
    late final String imageFilePathToCrop;
    if (imagePath.contains('http')) {
      final ByteData imageData = await NetworkAssetBundle(Uri.parse(imagePath)).load("");
      final Uint8List bytes = imageData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final tempFile =
          File(p.join(tempDir.path, "${md5.convert(utf8.encode(imagePath)).toString()}.${p.extension(imagePath)}"))
            ..writeAsBytesSync(bytes);
      imageFilePathToCrop = tempFile.path;
    } else {
      imageFilePathToCrop = imagePath;
    }
    final croppedFile = await ImageCropper()
        .cropImage(sourcePath: imageFilePathToCrop, aspectRatio: const CropAspectRatio(ratioX: 184, ratioY: 242));
    return croppedFile?.path;
  }

  Widget buildPhotoList() {
    final store = ref.watch(imageSummaryEditPageStoreProvider);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 120,
      ),
      child: ListView.separated(
        separatorBuilder: (ctx, index) => const SizedBox(
          width: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildPhotoListItem(index: index);
        },
        itemCount: store.displayImagePaths.length,
      ),
    );
  }

  Widget buildPhotoListItem({required int index}) {
    final store = ref.watch(imageSummaryEditPageStoreProvider);
    return Stack(
      children: [
        GestureDetector(
          onTap: () =>
              imagePageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease),
          child: Observer(builder: (context) {
            return Container(
                margin: index == 0 ? const EdgeInsetsDirectional.only(start: 16) : null,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: store.imagePagePosition == index ? Theme.of(context).primaryColor : Colors.transparent,
                        width: 2)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: PostImage(imageUrl: store.displayImagePaths[index])));
          }),
        ),
        if (widget.editPostId == null)
          PositionedDirectional(
              top: 4,
              end: 4,
              child: GestureDetector(
                  onTap: () {
                    store.removeImageAt(index: index);
                  },
                  child: SvgPicture.asset("assets/icons/ic_remove.svg")))
      ],
    );
  }

  void selectPhoto({required BuildContext context, required ImageSummaryEditPageStore store}) async {
    final imageFiles = await showOtherProfilePostOptions(context);
    store.addSelectedImages(imageFiles.map((e) => e.path), false);
  }

  Future<List<XFile>> showOtherProfilePostOptions(BuildContext context) async {
    return await showCupertinoModalPopup<List<XFile>>(
          context: context,
          builder: (BuildContext modalContext) => CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(modalContext, <XFile>[]);
              },
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF7D7878))),
            ),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () async {
                  final images = await picker.pickMultiImage();
                  if (modalContext.mounted) {
                    if (images.length > 10) {
                      Fluttertoast.showToast(
                          msg: "Selected more than 10 images, selecting only the first 10",
                          gravity: ToastGravity.CENTER);
                      Navigator.pop(modalContext, images.getRange(0, 10));
                      return;
                    }
                    Navigator.pop(modalContext, images);
                  }
                },
                child: const Text('Choose from library', style: TextStyle(color: Color(0xFF7D7878))),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  final image = await picker.pickImage(source: ImageSource.camera);

                  if (modalContext.mounted) {
                    Navigator.pop(modalContext, image != null ? [image] : <XFile>[]);
                  }
                },
                child: const Text(
                  'Take photo',
                  style: TextStyle(color: Color(0xFF7D7878)),
                ),
              ),
            ],
          ),
        ) ??
        [];
  }
}
