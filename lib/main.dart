import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/bindings.dart';
import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/helper/notifications.dart' as notification;
import 'package:katakara_investor/helper/notifications.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/product/product.add.controller.dart';
import 'helper/helper.dart';
import 'services/service.endpoints.dart';
import 'services/service.http.dart';

/// Define a top-level named handler which background/terminated messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) return;
  NotificationController.createNotification(message);
  log('Handling a background message ${message.messageId}');
}

void main() async {
  notification.awesomeNotification();
  WidgetsFlutterBinding.ensureInitialized();
  final appLifecycleObserver = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(appLifecycleObserver);

  await Config.initConfig();
  await AppSettings.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();

  final messaging = HC.initFCM();

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set your desired color here
      systemNavigationBarColor: AppColor.primary,
      statusBarIconBrightness: Brightness.dark));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );

    acceptPermission();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katakara Investor',
      theme: lightTheme,
      getPages: AppRoutes.routes,
      initialBinding: AllBindings(),
      initialRoute: Config.isNew!
          ? RouteName.welcome.name
          : AppSettings.isLogin ?? false
              ? RouteName.home.name
              : RouteName.login.name,
    );
  }
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // App resumed from background
      log(Get.currentRoute.toString());
      log("resumed");
    } else if (state == AppLifecycleState.paused) {
      log(Get.currentRoute.toString());
      if (Get.currentRoute == "addPortfolio") {
        Get.find<AddProductController>().saveAddProductToLocal();
      }
      // App moved to the background
      log("paused");
    } else if (state == AppLifecycleState.detached) {
      Config.clearImageStorage();
      MyRequestClass.krequest(
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
