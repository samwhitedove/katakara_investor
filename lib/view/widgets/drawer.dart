import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final _ = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CW.AppSpacer(h: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  CW.AppSpacer(w: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                          child: Text(userData.fullName!).title(fontSize: 14)),
                      FittedBox(
                          child: Text(userData.email!).subTitle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
            CW.AppSpacer(h: 20),
            const Divider(),
            CW.AppSpacer(h: 10),
            ...List.generate(
              _.menuItemHeader.length,
              (index) => customMenuWidget(_.menuItemHeader[index]),
            ),
            CW.AppSpacer(h: 20),
            const Divider(),
            ...List.generate(
              _.menuItemMain.length,
              (index) => customMenuWidget(_.menuItemMain[index]),
            ),
            const Divider(),
            ...List.generate(
              _.menuItemHeader.length,
              (index) => customMenuWidget(_.menuItemFooter[index]),
            ),
            const Spacer(),
            const Text("meetkatakara@gmail.com")
                .subTitle()
                .align(Al.left)
                .paddingOnly(left: 20),
            CW.AppSpacer(h: 23),
          ],
        ),
      ),
    );
  }

  customMenuWidget(data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SvgPicture.asset(
              data['image'],
              // ignore: deprecated_member_use
              color: AppColor.black,
            ),
          ),
          Text(data['label']).label(color: AppColor.black, fontSize: 14)
        ],
      ).toButton(onTap: data['onTap']),
    );
  }
}
