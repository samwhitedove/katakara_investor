import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extends.text.dart';
import 'package:katakara_investor/extensions/extends.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/view.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final k = Get.put(RegisterScreenController());
  final _init = Get.find<RegisterScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CW.baseWidget(
        children: [
          CW.AppSpacer(h: 40),
          CW.backButton(onTap: _init.goBack),
          CW.AppSpacer(h: 16),
          const Text(tRegister).title(),
          CW.AppSpacer(h: 8),
          const Text(tEnterOnlyValidInformation).subTitle(),
          CW.AppSpacer(h: 20.7),
          GetX<RegisterScreenController>(
            init: _init,
            builder: (_) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _.steps.length,
                    (index) => Column(
                      children: [
                        Row(
                          children: [
                            CW.circleWithBorder(
                              baseColor: _.checkStepBase(index),
                              color: _.checkStepInnerBase(index),
                              child: SvgPicture.asset(
                                Assets.assetsSvgCheck,
                                color: _.checkSvgBase(index),
                                height: 10,
                              ),
                            ),
                            index != (_.steps.length - 1)
                                ? Container(
                                    width: HC.spaceHorizontal(90),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    height: 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: _.checkDivider(index),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CW.AppSpacer(h: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _.labels.length,
                    (index) => Text(_.labels[index]).subTitle(
                      color: _.checkTextColor(index),
                      fontSize: 10,
                    ),
                  ),
                ),
                CW.AppSpacer(h: 20),
                Obx(
                  () => AnimatedContainer(
                    height: Get.height * (_.currentPage.value == 2 ? .6 : .55),
                    duration: CW.halfSec,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _.pageController,
                      onPageChanged: (value) => _.currentPage.value = value,
                      children: [
                        stepOne(_),
                        stepTwo(_),
                        stepThree(_),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CW.AppSpacer(h: 20),
          Obx(
            () => CW.button(
              onPress:
                  _init.steps['step${_init.currentPage.value + 1}']!['hasData']!
                      ? _init.next
                      : null,
              text: tNext,
            ),
          ),
          CW.AppSpacer(h: 14),
          Obx(
            () => Visibility(
              visible: _init.currentPage.value == 0,
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: tAlreadyHaveAccount).label(),
                    const TextSpan(text: tSignIn)
                        .title(color: AppColor.primary, fontSize: 14),
                  ],
                ),
              ).align(Al.center).toButton(
                    onTap: () => Get.toNamed(
                      AppRoutes.name(RouteName.register),
                    ),
                  ),
            ),
          ),
          CW.AppSpacer(h: 20),
        ],
      ),
    );
  }
}
