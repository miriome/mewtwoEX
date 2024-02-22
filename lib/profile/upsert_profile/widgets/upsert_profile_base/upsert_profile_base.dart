import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mewtwo/profile/upsert_profile/widgets/upsert_profile_base/upsert_profile_base_store.dart';

class UpsertProfileBase extends ConsumerWidget {
  final ImagePicker picker = ImagePicker();
  final UpsertProfileBaseStore store;
  final void Function(BuildContext) onCtaSuccess;
  final String ctaText;
  UpsertProfileBase({Key? key, required this.store, required this.onCtaSuccess, required this.ctaText})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Observer(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 24,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Text(
              "Mirror, mirror on the wall, who's the fairest of them all? ",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF7D7878),
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () async {
              final imageFile = await showPhotoSelectOptions(context);
              if (imageFile != null) {
                final croppedFile = await ImageCropper().cropImage(
                  sourcePath: imageFile.path,
                  cropStyle: CropStyle.circle,
                  aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1)
                );
                if (croppedFile != null) {
                  store.displayImagePath = croppedFile.path;
                }
              }
            },
            child: Center(
              child: Stack(
                children: [
                  displayImage,
                  if (store.displayImagePath.isEmpty)
                    const PositionedDirectional(
                        bottom: 0,
                        end: 8,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 28,
                        ))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FormBuilder(
              key: store.formKey,
              child: FormBuilderTextField(
                  controller: store.nameController,
                  name: 'name',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    labelText: "Name",
                    helperText: "No more than 15 characters",
                    helperStyle: const TextStyle(color: Color(0xFF7D7878)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF8474A1)),
                        borderRadius: BorderRadius.circular(12)),
                  )),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: FilledButton(
                onPressed: !store.canSubmit
                    ? null
                    : () async {
                        EasyLoading.show();
                        final success = await store.editProfile();
                        if (EasyLoading.isShow) {
                          EasyLoading.dismiss();
                        }
                        if (success && context.mounted) {
                          onCtaSuccess(context);
                        }
                      },
                child: Text(
                  ctaText,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          )
        ],
      );
    });
  }

  Future<XFile?> showPhotoSelectOptions(BuildContext context) {
    return showCupertinoModalPopup<XFile?>(
      context: context,
      builder: (BuildContext modalContext) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(modalContext);
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.camera);
              if (modalContext.mounted) {
                Navigator.pop(modalContext, image);
              }
            },
            child: const Text(
              'Take photo',
              style: TextStyle(color: Colors.black),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.gallery);
              if (modalContext.mounted) {
                Navigator.pop(modalContext, image);
              }
            },
            child: const Text('Select from library', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget get displayImage {
    final image = store.displayImagePath.startsWith("http")
        ? CachedNetworkImage(imageUrl: store.displayImagePath)
        : Image.file(File(store.displayImagePath));
    return Builder(builder: (context) {
      return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: store.displayImagePath.isEmpty ? Theme.of(context).primaryColor : null),
        child: store.displayImagePath.isNotEmpty ? ClipOval(child: image) : null,
      );
    });
  }
}
