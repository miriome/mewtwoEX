import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mewtwo/drops/pages/drop_details_page/drop_details_page.dart';

part 'routes_data.dart';

class DropRoutes {
  static const List<TypedGoRoute> typedRoutes = [
    TypedGoRoute<DropDetailsPageRoute>(
      path: 'drop/postDetails',
    ),
  ];
}
