import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mewtwo/home/pages/search_page/search_page_store.dart';
import 'package:mewtwo/home/pages/search_page/widgets/seach_post_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mewtwo/home/pages/search_page/widgets/search_page_search_bar.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/post/routes/routes.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  static const int _pageTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(searchPageStoreProvider);
    return SafeArea(
      child: Observer(builder: (context) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () => store.searchBarFocusNode.unfocus(),
            child: RefreshIndicator(
              onRefresh: () async {
                store.search();
              },
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: SearchPageSearchBar(
                        store: store,
                      )),
                  Expanded(
                    child: CustomScrollView(
                      controller: Mew.tabPrimaryScrollControllers[_pageTabIndex],
                      slivers: [
                        SliverPinnedHeader(
                            child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: store.textEditingController.text == "All"
                                  ? 16
                                  : 16), // TODO: fix this. Force our listview to rebuild when searchTerm changes
                          child: SizedBox(
                            height: 20,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final currentStyle = store.selfStyles[index];
                                bool isCurrentStyleSelected = false;
                                if (currentStyle == "All") {
                                  isCurrentStyleSelected = store.textEditingController.text == "";
                                } else {
                                  isCurrentStyleSelected =
                                      store.textEditingController.text.toLowerCase() == currentStyle.toLowerCase();
                                }
                                return GestureDetector(
                                  onTap: () {
                                    if (currentStyle == "All") {
                                      store.textEditingController.text = "";
                                      return;
                                    }
                                    store.textEditingController.text = currentStyle;
                                  },
                                  child: Text(
                                    currentStyle,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isCurrentStyleSelected
                                            ? const Color(
                                                0xFF6EC6CA,
                                              )
                                            : const Color(
                                                0xFF7D7878,
                                              )),
                                  ),
                                );
                              },
                              itemCount: store.selfStyles.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 20),
                            ),
                          ),
                        )),
                        SliverList.builder(
                          itemBuilder: (context, index) {
                            final user = store.userResults[index];
                            return GestureDetector(
                              onTap: () => OtherProfilePageRoute(userId: user.id).push(context),
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: const Color(0xFF6EC6CA),
                                      foregroundImage: user.photo_url == "https://miromie.com/uploads/"
                                          ? null
                                          : CachedNetworkImageProvider(
                                              user.photo_url,
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          user.username,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(
                                              0xFF6EC6CA,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: store.userResults.length,
                        ),
                        SliverAlignedGrid.count(
                          itemBuilder: (context, index) {
                            return SearchPostTile(
                              post: store.postResults[index],
                              onTap: () {
                                store.searchBarFocusNode.unfocus();
                                PostDetailsRoute(postId: store.postResults[index].id).push(context);
                              },
                            );
                          },
                          itemCount: store.postResults.length,
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      }),
    );
  }
}
