import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/routes/route_utils.dart';
import 'package:mewtwo/unauth/routes/routes.dart';
import 'package:mewtwo/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    statusBarColor: Colors.black.withOpacity(0.2), // transparent status bar
  ));
  }
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Constants.init();
  runApp(ProviderScope(
    parent: Mew.pc,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterBranchSdk.init(useTestKey: false, enableLogging: false, disableTracking: false).then((value) {
      FlutterBranchSdk.listSession().listen((data) {
        if (data.containsKey("+clicked_branch_link") &&
            data["+clicked_branch_link"] == true &&
            data.containsKey("\$canonical_identifier")) {
          //Link clicked. Add logic to get link data
          final identifier = data["\$canonical_identifier"];
          router.go(identifier);
          // print('Url: ${identifier}');
        }
      }, onError: (error) {
        print('listSession error: ${error.toString()}');
      });
    });
    super.initState();
  }

  final router = GoRouter(
      navigatorKey: rootNavigatorKey,
      routes: $appRoutes,
      initialLocation: LoginRoute().location,
      redirect: (context, state) async {
        final sp = await SharedPreferences.getInstance();
        final isLoggedIn = sp.containsKey(Constants.kKeyToken);
        if (isLoggedIn) {
          if ((state.fullPath?.contains("unauth") ?? false)) {
            return HomePageRoute().location;
          }
        } else {
          if ((!(state.fullPath?.contains("unauth") ?? false))) {
            return LoginRoute().location;
          }
        }
        return null;
      });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Constants.kStyles.forEach((style) {
    //   precacheImage(AssetImage('assets/images/styles/$style.jpg'), context);
    //  });
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          iconButtonTheme: IconButtonThemeData(style: ButtonStyle(
            iconColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color(0xFF787D7D);
              }
              return const Color(0xFF6EC6CA);
            }),
          )),
          switchTheme: SwitchThemeData(
            trackColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color(0xFF787D7D);
              }
              return null;
            }),
            thumbIcon: const MaterialStatePropertyAll(Icon(
              Icons.circle_rounded,
              color: Colors.white,
              fill: 1,
            )),
            overlayColor: const MaterialStatePropertyAll(Colors.white),
            thumbColor: const MaterialStatePropertyAll(Colors.white),
            trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
          ),
          checkboxTheme: const CheckboxThemeData(
              checkColor: MaterialStatePropertyAll(Colors.white), side: BorderSide(color: Color(0xFF8474A1))),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return TextStyle(color: Theme.of(context).disabledColor);
              }
              if (states.contains(MaterialState.error)) {
                return TextStyle(color: Theme.of(context).colorScheme.error);
              }
              if (states.contains(MaterialState.focused)) {
                return TextStyle(color: Theme.of(context).colorScheme.primary);
              }
              return const TextStyle(color: Color(0xFF8474A1));
            }),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF8474A1)), borderRadius: BorderRadius.circular(12)),
          ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              iconTheme: IconThemeData(color: Color(0xFF8474A1))),
          filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
                elevation: const MaterialStatePropertyAll(0),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey;
                  }
                  return const Color(0xFF6EC6CA);
                }),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
          ),
          scaffoldBackgroundColor: const Color(0xFFFEFEFE),
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: Color(0xFF6EC6CA)),
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: MaterialColorGenerator.from(const Color(0xFF6EC6CA)), backgroundColor: Colors.white),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: MaterialColorGenerator.from(const Color(0xFF6EC6CA)),
          textTheme: GoogleFonts.robotoTextTheme()),
      builder: (context, widget) {
        final easyLoading = EasyLoading.init();
        EasyLoading.instance
          ..backgroundColor = Colors.white
          ..indicatorWidget = const CircularProgressIndicator()
          ..contentPadding = const EdgeInsets.all(24)
          ..boxShadow = <BoxShadow>[] // removes black background
          ..loadingStyle = EasyLoadingStyle.light
          ..textColor = Colors.black
          ..indicatorColor = Colors.blue // color of animated loader
          ..loadingStyle = EasyLoadingStyle.custom;
        return easyLoading(context, widget);
      },
      routerConfig: router,
    );
  }
}
