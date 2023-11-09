import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final chatId = Get.arguments;
  bool isOwner = true;
  RxInt lines = 1.obs;

  @override
  void onInit() {
    chatMessage.addListener(() {
      int lenght = chatMessage.text.length ~/ 15;
      log(lenght.toString());
      if (chatMessage.text.length / 15 > 1) lines * lenght;
    });
    super.onInit();
  }

  @override
  void onClose() {
    chatMessage.removeListener(() {});
    super.onClose();
  }

  TextEditingController chatMessage = TextEditingController();
}
