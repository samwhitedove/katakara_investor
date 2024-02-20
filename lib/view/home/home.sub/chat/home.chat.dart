import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class InboxPageScreen extends StatelessWidget {
  final HomeScreenController ctr;
  const InboxPageScreen({super.key, required this.ctr});
  final bool show = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CW.column(
        children: [
          CW.AppSpacer(h: 40),
          const Text("Chat").title(fontSize: 28),
          CW.AppSpacer(h: 20),
          SizedBox(
            height: Get.height * .8,
            child: show
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 12,
                    itemBuilder: (context, index) => CW.chatTile(
                      name: "Samuel Data",
                      date: DateTime.now().toUtc().toIso8601String(),
                      latestMessage: "Is the product still available",
                      status: true,
                      onTap: () =>
                          Get.toNamed(RouteName.chatScreen.name, arguments: 1),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.assetsSvgChatActive,
                          colorFilter: ColorFilter.mode(
                              AppColor.greyLigth, BlendMode.modulate),
                          height: 50,
                          width: 50,
                        ),
                        CW.AppSpacer(h: 30),
                        const Text("Coming soon")
                            .title(fontSize: 16, color: AppColor.greyLigth)
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
