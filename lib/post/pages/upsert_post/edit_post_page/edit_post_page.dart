import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mewtwo/post/pages/upsert_post/edit_post_page/edit_post_page_store.dart';
import 'package:mewtwo/post/pages/upsert_post/upsert_post_base/upsert_post_base.dart';

class EditPostPage extends ConsumerWidget {
  final int postId;
  
const EditPostPage({ Key? key, required this.postId }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final store = ref.watch(editPostPageStoreProvider(postId: postId));
    return UpsertPostBase(store: store, editPostId: postId,);
  }
}