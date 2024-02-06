import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mewtwo/safety/api/api.dart';
import 'package:mewtwo/routes/route_utils.dart';
import 'package:mewtwo/safety/report_content.dart';

part 'routes_data.dart';

class SafetyRoutes {
  static const List<TypedGoRoute> typedRoutes = [TypedGoRoute<ReportContentRoute>(
        path: 'reportContent',
      )];
}


