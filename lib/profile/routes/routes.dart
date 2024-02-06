import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mewtwo/profile/edit_styles_page/edit_styles_page.dart';
import 'package:mewtwo/profile/edit_styles_page/edit_styles_page_store.dart';
import 'package:mewtwo/profile/profile_page/profile_page.dart';
import 'package:mewtwo/profile/upsert_measurements/create_measurements_page/create_measurements_page.dart';
import 'package:mewtwo/profile/upsert_measurements/edit_measurements_page/edit_measurements_page.dart';
import 'package:mewtwo/profile/upsert_profile/create_profile_page/create_profile_page.dart';
import 'package:mewtwo/profile/upsert_profile/edit_profile_page/edit_profile_page.dart';

import 'package:mewtwo/routes/route_utils.dart';

part 'routes_data.dart';


class ProfileRoutes {
  /// The main profile page route is not defined here since it is used as a shellbranch in [MainTabShellRoute].
  static const profilePageRoute = TypedGoRoute<ProfilePageRoute>(
        path: '/ProfilePage',
      );
  static const List<TypedGoRoute> typedRoutes = [
    TypedGoRoute<OtherProfilePageRoute>(
      path: 'OtherProfilePage',
    ),
    TypedGoRoute<CreateProfileRoute>(
      path: 'create-profile',
    ),
    TypedGoRoute<EditProfileRoute>(
      path: 'edit-profile',
    ),
    TypedGoRoute<CreateMeasurementsRoute>(
      path: 'create-measurements',
    ),
     TypedGoRoute<EditMeasurementsRoute>(
      path: 'edit-measurements',
    ),
    TypedGoRoute<EditStylesRoute>(
      path: 'edit-styles',
    )
  ];
}

