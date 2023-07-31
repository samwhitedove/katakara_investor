import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortfolioController>(
      init: PortfolioController(),
      initState: (_) {},
      builder: (_) {
        return CW.baseStackWidget(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: AppColor.primary,
                  width: Get.width,
                  height: HC.spaceHorizontal(218),
                  child: CW.column(
                    children: [
                      CW.AppSpacer(h: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CW.backButton(
                              innerBgColor: AppColor.primary,
                              iconColor: AppColor.white,
                              outerBgColor: AppColor.white,
                              bgVisible: 1),
                          Text(tPortfolio).title(
                            color: AppColor.white,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      CW.AppSpacer(h: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(businessName)
                              .title(fontSize: 20, color: AppColor.white),
                          Text(sendReceipt).subTitle(
                            color: AppColor.white.withOpacity(.7),
                          ),
                        ],
                      ).align(Al.center),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -25,
                  left: 0,
                  right: 0,
                  child: CW.column(
                    children: [
                      Container(
                        height: 50,
                        color: AppColor.black,
                        width: Get.width,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
