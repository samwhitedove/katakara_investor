import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isActive = true.obs;
  RxInt currentIndex = 1.obs;
  String? youtubeLink;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  goLive() async {
    isLoading.value = true;
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.goLiveAndOffline,
        body: {"status": !isActive.value},
        method: Methods.patch);
    if (response.success) {
      if (isActive.value == false) {
        RequestResponsModel youtube = await MyRequestClass.krequest(
            endPoint: EndPoint.fetchYoutubeVideo, method: Methods.get);
        if (youtube.success) {
          youtubeLink = youtube.data['link1'];
        }
      }
      isLoading.value = false;
      isActive.toggle();
      HC.snack(response.message, success: response.success);
      return;
    }
    HC.snack(response.message, success: response.success);
    isLoading.value = false;
  }

  List<Map<String, dynamic>> videoData = [
    // {
    //   "color": AppColor.blue,
    //   "onTap": () {
    //     log("Hellie1");
    //   },
    //   "label": "About Us"
    // },
    {
      "color": AppColor.primary,
      "onTap": () {
        log("Hellie1");
      },
      "label": "About Katakara Investment"
    },
    // {
    //   "color": AppColor.lightRed,
    //   "onTap": () {
    //     log("Hellie1");
    //   },
    //   "label": "How to Advertise"
    // },
    // {
    //   "color": AppColor.orange,
    //   "onTap": () {
    //     log("Hellie1");
    //   },
    //   "label": "Invite a friend"
    // }
  ];

  List<Map<String, dynamic>> menuItemHeader = [
    {
      'image': Assets.assetsSvgBriefcase,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(AppRoutes.name(RouteName.portfolio));
      },
      "label": "Portfolio"
    },
    {
      'image': Assets.assetsSvgReceipt,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(AppRoutes.name(RouteName.receipt));
      },
      "label": "Receipt"
    },
  ];

  List<Map<String, dynamic>> menuItemMain = [
    {
      'image': Assets.assetsSvgNairaSvgsquare,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(AppRoutes.name(RouteName.financial));
      },
      "label": "Financial capacity"
    },
    {
      'image': Assets.assetsSvgCalculator,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(AppRoutes.name(RouteName.calculator));
      },
      "label": "Investment Calculator"
    },
  ];

  List<Map<String, dynamic>> menuItemFooter = [
    {
      'image': Assets.assetsSvgMessage,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(AppRoutes.name(RouteName.faq));
      },
      "label": "FAQ"
    },
    {
      'image': Assets.assetsSvgFlag,
      "isSelected": false.obs,
      "onTap": () {
        Get.back();
        Get.toNamed(AppRoutes.name(RouteName.redFlag));
      },
      "label": "Red flag"
    },
  ];

  List<Map<String, dynamic>> navBar = [
    {
      'active': Assets.assetsSvgChatActive,
      'inActive': Assets.assetsSvgChatInactive,
      "isSelected": false.obs,
      "label": "Inbox"
    },
    {
      'active': Assets.assetsSvgHomeActive,
      'inActive': Assets.assetsSvgHomeInactive,
      "isSelected": false.obs,
      "label": "Home"
    },
    // {
    //   'active': Assets.assetsSvgKfiActive,
    //   'inActive': Assets.assetsSvgKfiInactive,
    //   "isSelected": false.obs,
    //   "label": "KFI"
    // },

    {
      'active': Assets.assetsSvgProfileActive,
      'inActive': Assets.assetsSvgProfileInactive,
      "isSelected": false.obs,
      "label": "Profile"
    },
  ];

  List<Map<String, dynamic>> recentProduct = [
    {
      'productName': "Stabilizer",
      'state': 'Abuja',
      'lga': "Shenge",
      'status': true
    },
    {
      'productName': "Iphone 13pro max",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'status': false
    },
    {
      'productName': "Sony Tv 32 inch",
      'state': 'Abuja',
      'lga': "Abaka",
      'status': true
    },
    {
      'productName': "Home Theather with DVD player",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'status': false
    }
  ];
}