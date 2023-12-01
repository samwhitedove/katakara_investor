import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.sub/chat/chat.controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          bottomSheet: SizedBox(
            // color: AppColor.purple,
            height: 80,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CW.textField(
                          label: "",
                          maxLength: 700,
                          lines: _.lines.value,
                          radius: BorderRadius.circular(50),
                          controller: _.chatMessage,
                          onChangeValue: () {}),
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                            Icon(Icons.image_outlined, color: AppColor.primary),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.send,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  )
                ]),
          ),
          body: Column(
            children: [
              CW.AppSpacer(h: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    CW.backButton(),
                    // ignore: prefer_const_constructors
                    Text("Olad Sam")
                        .title(fontSize: 20, lines: 1, color: AppColor.black)
                        .paddingOnly(left: 20),
                  ],
                ),
              ),
              CW.AppSpacer(h: 10),
              chatWidget(_),
              chatWidget(_),
              chatWidget(_),
            ],
          ),
        );
      },
    );
  }

  Padding chatWidget(ChatController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          CW.AppSpacer(h: 15),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_.isOwner ? 10 : 0),
                  bottomLeft: const Radius.circular(10),
                  bottomRight: const Radius.circular(10),
                  topLeft: Radius.circular(_.isOwner ? 0 : 10)),
              color: AppColor.greyLigth.withAlpha(50),
            ),
            constraints: BoxConstraints(
              maxWidth: Get.width * .7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: const Text("Some testing chatSome").subTitle(
                      fontSize: 12,
                      // color: AppColor.black,
                      lines: 500),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, right: 8.0),
                  child: Text(timeago.format(DateTime.now()))
                      .subTitle(fontSize: 10)
                      .align(Al.right),
                ),
              ],
            ),
          ).align(Al.left),
        ],
      ),
    );
  }
}
