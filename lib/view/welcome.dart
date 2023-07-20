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
  @override
  Widget build(BuildContext context) {
    startLoader();
    return Scaffold(
      body: CW.column(
        children: [
          CW.AppSpacer(h: 80),
          Obx(
            () => SizedBox(
              width: HC.spaceVertical(100),
              child: LinearProgressIndicator(
                backgroundColor: AppColor.loaderBg,
                value: loadValue.value.toDouble(),
                minHeight: 3,
                color: AppColor.primary,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColor.primary),
              ),
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
          CW.AppSpacer(h: 32),
          const Text(tSmartWay).title(fontSize: 30),
          CW.AppSpacer(h: 17),
          const Text(tRegisterWelcomeMessage).subTitle(fontSize: 14),
          CW.AppSpacer(h: 70),
          Center(
            child: SizedBox(
              height: HC.spaceVertical(250),
              width: HC.spaceVertical(282),
              child: SvgPicture.asset(
                Assets.assetsSvgWelcome,
                fit: BoxFit.cover,
              ),
            ),
          ),
          CW.AppSpacer(h: 120),
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
          )
        ],
      ),
    );
  }

  Timer? timer;
  void startLoader() {
    timer = Timer.periodic(CW.quarter100, (timer) {
      if (loadValue.value >= 1) {
        timer.cancel();
        Config.saveConfig(
            isNewUserValue: false, key: ConfigStorageKey.isNewUser);
        Get.toNamed(AppRoutes.name(RouteName.login));
        timer.cancel();
        loadValue.value = 0;
      }
      loadValue.value += .002;
    });
  }

  startApp({required bool register}) {
    timer?.cancel();
    Config.saveConfig(isNewUserValue: false, key: ConfigStorageKey.isNewUser);
    Get.offAllNamed(
      AppRoutes.name(register ? RouteName.register : RouteName.login),
    );
  }
}
