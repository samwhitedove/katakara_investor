import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/values/values.dart';
import 'helper/helper.dart';
import 'services/service.endpoints.dart';
import 'services/service.http.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appLifecycleObserver = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(appLifecycleObserver);
  await Config.initConfig();
  await AppSettings.init();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set your desired color here
      systemNavigationBarColor: AppColor.primary,
      statusBarIconBrightness: Brightness.dark));

  if (kDebugMode) {
    try {
      // FirebaseFirestore.instance.useFirestoreEmulator('10.0.2.2', 8080);
      // await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katakara Investor',
      theme: lightTheme,
      unknownRoute: AppRoutes.routes.first,
      getPages: AppRoutes.routes,
      initialRoute: Config.isNew!
          ? AppRoutes.name(RouteName.welcome)
          : AppSettings.isLogin!
              ? AppRoutes.name(RouteName.home)
              : AppRoutes.name(RouteName.login),
    );
  }
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // App resumed from background
      log("resumed");
    } else if (state == AppLifecycleState.paused) {
      // App moved to the background
      log("paused");
    } else if (state == AppLifecycleState.detached) {
      Config.deleteAllLocalUnuseImage();
      await MyRequestClass.krequest(
        endPoint: EndPoint.goLiveAndOffline,
        body: {"status": false},
        method: Methods.patch,
      );
    } else if (state == AppLifecycleState.inactive) {
      // App moved to the background
      log("inactive");
    }
  }
}
