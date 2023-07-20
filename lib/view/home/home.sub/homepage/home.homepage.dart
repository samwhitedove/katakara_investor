import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

import '../../../../helper/helper.function.dart';

class HomePageScreen extends StatelessWidget {
  final HomeScreenController ctr;
  const HomePageScreen({super.key, required this.ctr});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CW.column(
        children: [
          CW.AppSpacer(h: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.sort,
                size: 30,
                color: ctr.isActive.value
                    ? AppColor.primary
                    : AppColor.inActiveBlack,
              ).toButton(
                onTap: () => ctr.isActive.value
                    ? ctr.scaffoldKey.currentState?.openDrawer()
                    : () => HC.snack(tGoLiveToActive),
              ),
              TextSwitcher(
                onChange: ctr.goLive,
                value: ctr.isActive.value,
              )
            ],
          ),
          CW.AppSpacer(h: 43),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(
              ctr.videoData.length,
              (index) => Row(
                children: [
                  const Icon(
                    Icons.play_arrow,
                    color: AppColor.white,
                    size: 35,
                  ).roundCorner(
                    borderColor: ctr.isActive.value
                        ? ctr.videoData[index]['color']
                        : AppColor.inActiveBlack,
                    bgColor: ctr.isActive.value
                        ? ctr.videoData[index]['color']
                        : AppColor.inActiveBlack,
                    topLeftRadius: 20,
                    width: Get.width * .12,
                    bottomLeftRadius: 20,
                    topRightRadius: 0,
                    bottomRightRadius: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(ctr.videoData[index]['label']).subTitle(
                      fontSize: 11,
                      color: ctr.isActive.value
                          ? ctr.videoData[index]['color']
                          : AppColor.inActiveBlack,
                    ),
                  )
                ],
              )
                  .roundCorner(
                    width: .4,
                    bgColor: AppColor.white,
                    radius: 20,
                    height: 40,
                    borderColor: ctr.isActive.value
                        ? ctr.videoData[index]['color']
                        : AppColor.inActiveBlack,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  )
                  .halfWidth(
                    marginRight: true,
                    margin: index.isOdd ? 0 : Get.width * .036,
                    width: .9, //.44,
                  )
                  .toButton(
                    onTap: ctr.isActive.value
                        ? ctr.videoData[index]['onTap']
                        : () => HC.snack(tGoLiveToActive),
                  ),
            ),
          ),
          CW.AppSpacer(h: 20),
          const Text("Recent Product").title(fontSize: 14),
          CW.AppSpacer(h: 10),
          ...List.generate(
              ctr.isLoading.value ? 4 : ctr.recentProduct.length,
              (index) => !ctr.isActive.value
                  ? CW
                      .listUserOrProductWidgetShimmer(animate: false)
                      .toButton(onTap: () => HC.snack(tGoLiveToActive))
                  : ctr.isLoading.value && ctr.isActive.value
                      ? CW.listUserOrProductWidgetShimmer(animate: true)
                      : CW.listUserOrProductWidget(
                          name: ctr.recentProduct[index]['productName'],
                          state: ctr.recentProduct[index]['state'],
                          lga: ctr.recentProduct[index]['lga'],
                          status: ctr.recentProduct[index]['status'],
                        )),
          CW.AppSpacer(h: 30),
          CW.button(
            color: ctr.isActive.value ? null : AppColor.inActiveBlack,
            onPress:
                ctr.isActive.value ? () {} : () => HC.snack(tGoLiveToActive),
            text: "Invest Now",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Invest Now").title(
                  color: AppColor.white,
                  fontSize: 14,
                ),
                CW.AppSpacer(w: 10),
                SvgPicture.asset(Assets.assetsSvgRocket)
              ],
            ),
          )
        ],
      ),
    );
  }
}
