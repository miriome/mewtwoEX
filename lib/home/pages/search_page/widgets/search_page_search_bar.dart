import 'package:flutter/material.dart';
import 'package:mewtwo/home/pages/search_page/search_page_store.dart';

class SearchPageSearchBar extends StatelessWidget {
  final SearchPageStore store;

  const SearchPageSearchBar({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: store.textEditingController,
      focusNode: store.searchBarFocusNode,
      maxLines: 1,
      decoration: InputDecoration(
          hintText: "Search for styles, clothes, or usernames...",
          hintStyle: const TextStyle(color: Color(0xFF7D7878)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}

