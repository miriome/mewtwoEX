import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mewtwo/post/api/api.dart';
import 'package:mewtwo/post/pages/post_details_page/post_details_page.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';

class LikedPostsPage extends StatelessWidget {
  const LikedPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Posts you liked",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF6EC6CA)))),
      body: Consumer(builder: (context, ref, child) {
        final data = ref.watch(getLikedPostsApiProvider);
        return data.when(
            data: (data) {
              if (data.isEmpty) {
                return const Center(child: Text("You haven't liked any posts", style: TextStyle(
                  fontSize: 16
                ),),);
              }
              return AlignedGridView.count(
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => PostDetailsRoute(postId: data[index].id).push(context),
                      child: Container(
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white, boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4)
                        ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: PostImage(imageUrl: data[index].image),
                        ),
                      ));
                },
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                itemCount: data.length,
              );
            },
            error: (e, s) {
              return const SizedBox.shrink();
            },
            loading: () => const Center(child: CircularProgressIndicator()));
      }),
    );
  }
}
