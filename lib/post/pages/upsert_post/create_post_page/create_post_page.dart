import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mewtwo/post/pages/upsert_post/upsert_post_base/upsert_post_base.dart';
import 'package:mewtwo/post/pages/upsert_post/upsert_post_base/upsert_post_base_store.dart';

class CreatePostPage extends ConsumerWidget {
  
  const CreatePostPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(upsertPostBaseStoreProvider);
    return UpsertPostBase(
      store: store,
    );
  }
}
