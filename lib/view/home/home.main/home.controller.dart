import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/helper/notifications.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.home.dart';
import 'package:katakara_investor/services/services.auth.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';
import 'package:katakara_investor/view/home/home.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isActive = false.obs;
  RxInt currentIndex = 1.obs;
  bool hasInvestment = false;
  bool isFetching = false;
  String? youtubeLink;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService authService = Get.find<AuthService>();

  @override
  void onReady() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationController.createNotification(message);
    });
    super.onReady();
  }

  @override
  onInit() {
    super.onInit();
    Get.put(PortfolioController());
    Get.put(HomeKFIController());
  }

  String? deviceToken = "";

  List<InvestmentDatum> recentProduct = [];

  fetchInvestment({int? limit}) async {
    isFetching = true;
    update();
    final RequestResponseModel res = await Get.find<HomeService>()
        .fetchUserInvestment({"limit": limit ?? 10});
    isFetching = false;
    update();
    if (res.success) {
      recentProduct =
          InvestmentResponseDataModel.fromJson(res.data).data!.data!;
      hasInvestment = true;
      update();
      return;
    }
    hasInvestment = false;
  }

  goLive() async {
    isLoading.value = true;
    if (!isActive.value && deviceToken!.isEmpty) {
      deviceToken = await HC.initFCM().getToken();
      log('$deviceToken ---------- device token ');
    }
    final RequestResponseModel response = await authService
        .goLive({"status": !isActive.value, "fcmToken": deviceToken});
    if (response.success) {
      if ((!isActive.value) == true) {
        youtubeLink =
            (await Get.find<HomeService>().fetchYoutube()).data.first['link'] ??
                '';
        Get.find<HomeKFIController>().fetchKFIAccount();
        Get.find<HomeKFIController>().fetchKFIInvestment();
        fetchInvestment(limit: 5);
        authService.fetchUser();
      }
      isLoading.value = false;
      isActive.toggle();
      update();
      HC.snack(response.message, success: response.success);
      return;
    }
    HC.snack(response.message, success: response.success);
    isLoading.value = false;
  }

  get videoData => [
        {
          "color": AppColor.primary,
          "onTap": () async {
            if (youtubeLink == null || youtubeLink!.isEmpty) {
              youtubeLink = (await Get.find<HomeService>().fetchYoutube())
                  .data
                  .first['link'];
              if (youtubeLink!.isEmpty) return;
            }
            Get.toNamed(RouteName.youtube.name, arguments: youtubeLink);
          },
          "label": "About Katakara Investment"
        },
      ];

  List<Map<String, dynamic>> menuItemHeader = [
    {
      'image': Assets.assetsSvgBriefcase,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(RouteName.portfolio.name);
      },
      "label": "Portfolio"
    },
    {
      'image': Assets.assetsSvgReceipt,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(RouteName.receipt.name);
      },
      "label": "Receipt"
    },
  ];

  List<Map<String, dynamic>> menuItemMain = [
    {
      'image': Assets.assetsSvgBell,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(RouteName.notifications.name);
      },
      "label": "Notification"
    },
    {
      'image': Assets.assetsSvgNairaSvgsquare,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(RouteName.financial.name);
      },
      "label": "Financial capacity"
    },
    // {
    //   'image': Assets.assetsSvgCalculator,
    //   "isSelected": false.obs,
    //   "onTap": () {
    //     Get.back();
    //     Get.toNamed(RouteName.calculator.name);
    //   },
    //   "label": "Investment Calculator"
    // },
  ];

  List<Map<String, dynamic>> menuItemFooter = [
    {
      'image': Assets.assetsSvgMessage,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(RouteName.faq.name);
      },
      "label": "FAQ"
    },
    {
      'image': Assets.assetsSvgFlag,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(RouteName.redFlag.name);
      },
      "label": "Red flag"
    },
  ];

  List<Map<String, dynamic>> navBar = [
    {
      'active': Assets.assetsSvgChatActive,
      'inActive': Assets.assetsSvgChatInactive,
      "isSelected": false.obs,
      "label": "Chat"
    },
    {
      'active': Assets.assetsSvgHomeActive,
      'inActive': Assets.assetsSvgHomeInactive,
      "isSelected": false.obs,
      "label": "Home"
    },
    {
      'active': Assets.assetsSvgKfiActive,
      'inActive': Assets.assetsSvgKfiInactive,
      "isSelected": false.obs,
      "label": "KFI"
    },
    {
      'active': Assets.assetsSvgProfileActive,
      'inActive': Assets.assetsSvgProfileInactive,
      "isSelected": false.obs,
      "label": "Profile"
    },
  ];
}
