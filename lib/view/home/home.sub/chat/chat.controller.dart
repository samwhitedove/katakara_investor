import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';
import 'package:katakara_investor/view/home/home.sub/chat/model.chat.dart';

class ChatController extends GetxController {
  ChatScreenDataPayload chatData =
      ChatScreenDataPayload.fromJson(Get.arguments);
  bool isOwner = true;
  RxInt lines = 1.obs;

  @override
  void onInit() {
    // chatMessage.addListener(() {
    //   int lenght = chatMessage.text.length ~/ 15;
    //   log(lenght.toString());
    //   if (chatMessage.text.length / 15 > 1) lines * lenght;
    // });
    super.onInit();
  }

  @override
  void onClose() {
    chatMessage.removeListener(() {});
    super.onClose();
  }

  sendChat() {
    log("sending chat ${chatMessage.text}");
    Get.find<HomeScreenController>().socket?.emit("chat", {
      'to': chatData.senderUuid,
      "from": userData.uuid,
      "message": chatMessage.text,
      'token': userData.token,
      "imageUrl": null,
      "audio": null,
      "file": null,
      "replyMessageId": null,
    });
  }

  // ChatMapData(
  //       lastMessage: "Hello",
  //       senderName: "Bolu Adewale",
  //       senderUuid: "141d3f1405994d64",
  //       totalMessages: 0,
  //       totalUnread: 0,
  //       otherMessages: [],
  //     ),
  //     ChatMapData(
  //       lastMessage: "Hello",
  //       senderName: "Ayo Badmus",
  //       senderUuid: "f442d18dd17c4989",
  //       totalMessages: 0,
  //       totalUnread: 0,
  //       otherMessages: [],
  //     )

  TextEditingController chatMessage = TextEditingController();
}
