import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

import 'kfi.dart';

class KFIPageScreen extends StatelessWidget {
  final HomeScreenController ctr;
  const KFIPageScreen({super.key, required this.ctr});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeKFIController>(
      init: HomeKFIController(),
      builder: (_) {
        _.homeScreenController = ctr;
        return CW.column(
          size: 0,
          children: [
            Column(
              children: [
                CW.AppSpacer(h: 50),
                Row(
                  children: [
                    CW.backButton(
                        outerBgColor: AppColor.white,
                        innerBgColor: AppColor.primary,
                        bgVisible: 1,
                        iconColor: AppColor.white),
                    CW.AppSpacer(w: 20),
                    const Text(tFractionalInvestors)
                        .title(color: AppColor.white, fontSize: 22)
                  ],
                ),
                const Text(tKfiContent)
                    .subTitle(color: AppColor.iconInactive, fontSize: 12)
                    .paddingSymmetric(vertical: 20),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    _.fkis.length,
                    (index) => Text(_.fkis[index])
                        .title(
                          fontSize: _.currentKfi.value == index ? 13 : 11,
                          color: _.currentKfi.value == index
                              ? AppColor.primary
                              : AppColor.white,
                        )
                        .roundCorner(
                          elevation: 0,
                          height: 30,
                          bgColor: _.currentKfi.value == index
                              ? AppColor.white
                              : AppColor.primary.withOpacity(.6),
                          showBorder: false,
                          padding:
                              const EdgeInsets.only(top: 5, left: 8, right: 8),
                        )
                        .toButton(onTap: () => _.findKFI(index)),
                  ),
                ),
                CW.AppSpacer(h: 20),
              ],
            ).addPaddingHorizontal(size: 15).roundCorner(
                  bgColor: AppColor.primary,
                  height: HC.spaceVertical(250),
                  bottomLeftRadius: 20,
                  showBorder: false,
                  bottomRightRadius: 20,
                ),
            CW.AppSpacer(h: 20),
            CW.column(
              children: [
                ...List.generate(
                  _.isLoading.value ? 5 : _.fkiData.length,
                  (index) => _.isLoading.value
                      ? CW.listUserOrProductWidgetShimmer()
                      : CW.listUserOrProductWidget(
                          name: _.fkiData[index]['name'],
                          lga: _.fkiData[index]['lga'],
                          state: _.fkiData[index]['state'],
                          status: _.fkiData[index]['workDays'],
                        ),
                ),
                CW.button(onPress: () {}, text: 'View More')
              ],
            ),
          ],
        );
      },
    );
  }
}
