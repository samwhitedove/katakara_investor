import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  RxDouble loadValue = .0.obs;
  RxBool on = false.obs;
  final duration = const Duration(seconds: 7);

  @override
  Widget build(BuildContext context) {
    startLoader();
    return Scaffold(
      body: CW.column(
        children: [
          CW.AppSpacer(h: 80),
          Obx(
            () => Stack(
              children: [
                Container(
                  width: HC.spaceVertical(115),
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppColor.greyLigth,
                      borderRadius: BorderRadius.circular(4)),
                ),
                AnimatedContainer(
                  duration: duration,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.primary,
                  ),
                  width: HC.spaceVertical(on.value ? 115 : 0),
                ),
              ],
            ),
          ),
          CW.AppSpacer(h: 13),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: twelcomeTo,
                  style: TextStyle(
                    color: AppColor.subTitle,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: tAppName,
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          CW.AppSpacer(h: 52),
          const Text(tSmartWay).title(fontSize: 30),
          CW.AppSpacer(h: 17),
          const Text(tRegisterWelcomeMessage).subTitle(fontSize: 14),
          CW.AppSpacer(h: 75),
          Center(
            child: SizedBox(
              height: HC.spaceVertical(275),
              width: HC.spaceVertical(282),
              child: SvgPicture.asset(
                Assets.assetsSvgWelcome,
                fit: BoxFit.cover,
              ),
            ),
          ),
          CW.AppSpacer(h: 124),
          SizedBox(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CW.button(
                      onPress: () => startApp(register: false),
                      text: tSignIn,
                      color: AppColor.greyLigth,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CW.button(
                      onPress: () => startApp(register: true),
                      text: tGetStarted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CW.AppSpacer(h: 40),
        ],
      ),
    );
  }

  Timer? timer;
  void startLoader() async {
    await Future.delayed(CW.onesSec);
    on.value = true;
    await Future.delayed(duration);
    startApp(register: false);
  }

  startApp({required bool register}) {
    // timer?.cancel();
    Config.saveConfig(
      value: false,
      key: StorageKeys.isNewUser,
      name: StorageNames.configStorage,
    );

    if (register) {
      return Get.offAllNamed(
          AppRoutes.name(register ? RouteName.register : RouteName.login));
    }
    Get.toNamed(AppRoutes.name(RouteName.login));
  }
}
