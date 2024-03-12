import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/helper/notifications.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.home.dart';
import 'package:katakara_investor/services/services.auth.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';
import 'package:katakara_investor/view/home/home.dart';
import 'package:katakara_investor/view/home/home.sub/chat/model.chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as web_socket;
import 'package:socket_io_client/socket_io_client.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isActive = false.obs;
  RxInt currentIndex = 1.obs;
  bool hasInvestment = false;
  bool isFetching = false;
  String? youtubeLink = '';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService authService = Get.find<AuthService>();

  @override
  void onReady() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationController.createNotification(message);
    });
    super.onReady();
  }

  late web_socket.Socket? socket;

  List<ChatMapData> chatList = [];

  StreamController<List<ChatMapData>> chatListController =
      StreamController<List<ChatMapData>>();

  addToChatList(Map<String, dynamic> data) {
    print(chatList);
    print(data);
    ChatMessages chatData = ChatMessages.fromJson(data);
    List<ChatMapData> previousChat = chatList
        .where((item) => item.senderUuid == chatData.senderUuid)
        .toList();
    if (previousChat.isEmpty) {
      final chatMap = ChatMapData(
          lastMessage: chatData.message!,
          senderName: chatData.senderName!,
          senderUuid: chatData.senderUuid!,
          totalUnread: 1,
          totalMessages: 1,
          messages: [chatData],
          profileImage: chatData.profileImage);
      chatList.add(chatMap);
      chatListController.add(chatList);
      return;
    }

    final chatMap = ChatMapData(
        lastMessage: chatData.message!,
        senderName: chatData.senderName!,
        senderUuid: chatData.senderUuid!,
        totalUnread: previousChat.first.totalUnread + 1,
        totalMessages: previousChat.first.messages.length + 1,
        messages: previousChat.first.messages..add(chatData),
        profileImage: chatData.profileImage);
    int index =
        chatList.indexWhere((item) => item.senderUuid == chatData.senderUuid);
    chatList[index] = chatMap;
    chatListController.add(chatList);

    print(chatList);
  }

  @override
  void onClose() {
    socket?.disconnect();
    chatListController.close();
    super.onClose();
  }

  @override
  onInit() {
    super.onInit();
    Get.put(PortfolioController());
    Get.put(HomeKFIController());
  }

  handleReceiveChat(Map<String, dynamic> data) {
    // chatList.clear();
    log("$data -------- chat data");
    addToChatList(data);
  }

  Future<web_socket.Socket?> socketConnect() async {
    try {
      web_socket.Socket socket = web_socket.io(
        "http://192.168.0.177:3000",
        OptionBuilder().setTransports(['websocket', 'polling']).build(),
      );
      socket.auth = {"token": userData.token};
      socket.connect();
      if (socket.connected) print('socket connected -----------------');

      socket.onConnect((_) {
        print(" ---------------- Socket.io connection established");
        socket.emit("auth", userData.token);
      });
      // socket.onDisconnect((_) => {log("Socket.io connection dropped")});
      // socket.onError((e) => {log("Socket.io error $e")});
      socket.onConnectError((e) => {log("Socket.io connection error $e")});
      return socket;
    } catch (e) {
      log('$e socket error -----------------');
      return null;
    }
  }

  void connectSocket() async {
    try {
      socket = await socketConnect();
      socket?.on("chat", (data) => handleReceiveChat(data));
      socket?.on("error", (data) => log("$data error message---------------"));
      socket?.on("connect", (data) => log("successful connected to socket"));
      socket?.on("disconnect", (_) => log("disconnect from server"));
    } catch (e) {
      log('$e ----- error connecting to socket  ---');
    }
  }

  String? deviceToken = "";

  List<InvestmentDatum> recentProduct = [];

  fetchInvestment({int? limit, String? state}) async {
    isFetching = true;
    update();
    final RequestResponseModel res = await Get.find<HomeService>()
        .filterInvestment({"limit": limit ?? 10, "state": userData.state});
    isFetching = false;
    update();
    if (res.success) {
      recentProduct = InvestmentData.fromJson(res.data).data!;
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
        final link =
            (await Get.find<HomeService>().fetchYoutube()).data as List;
        if (link.isNotEmpty) youtubeLink = link.first['link'];
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
