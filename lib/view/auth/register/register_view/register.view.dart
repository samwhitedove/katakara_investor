import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extends.text.dart';
import 'package:katakara_investor/extensions/extends.widget.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/view.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterScreenController>(
        init: RegisterScreenController(),
        builder: (init) {
          return CW.baseWidget(
            children: [
              CW.AppSpacer(h: 40),
              CW.backButton(onTap: init.goBack),
              CW.AppSpacer(h: 16),
              const Text(tRegister).title(),
              CW.AppSpacer(h: 8),
              const Text(tEnterOnlyValidInformation).subTitle(),
              CW.AppSpacer(h: 32),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      init.steps.length,
                      (index) => Column(
                        children: [
                          Row(
                            children: [
                              CW.circleWithBorder(
                                baseColor: init.checkStepBase(index),
                                color: init.checkStepInnerBase(index),
                                child: SvgPicture.asset(
                                  Assets.assetsSvgCheck,
                                  color: init.checkSvgBase(index),
                                  height: 10,
                                ),
                              ),
                              index != (init.steps.length - 1)
                                  ? Container(
                                      width: Get.width * .7,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: init.checkDivider(index),
                                      ),
                                    )
                                  : const SizedBox(),
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
                      init.steps.length,
                      (index) => Text(init.steps['step${index + 1}']!['label'])
                          .subTitle(
                        color: init.checkTextColor(index),
                        fontSize: 10,
                      ),
                    ),
                  ),
                  CW.AppSpacer(h: 48),
                  Obx(
                    () => Column(
                      children: [
                        Visibility(
                          visible: init.currentPage.value == 0,
                          child: StepOne(),
                        ),
                        Visibility(
                          visible: init.currentPage.value == 1,
                          child: StepTwo(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CW.AppSpacer(h: 20),
              Obx(
                () => CW.button(
                  onPress: init.steps['step${init.currentPage.value + 1}']![
                          'hasData']!
                      ? init.next
                      : null,
                  text: tNext,
                ),
              ),
              CW.AppSpacer(h: 14),
              Obx(
                () => Visibility(
                  visible: init.currentPage.value == 0,
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
              CW.AppSpacer(h: 87),
            ],
          );
        },
      ),
    );
  }
}
