import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/services/service.notification.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

import '../../../../helper/helper.function.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: Get.find<HomeScreenController>(),
      initState: (_) {},
      builder: (ctr) {
        return SafeArea(
          child: CW.column(
            children: [
              CW.AppSpacer(h: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
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
                      Positioned(
                        right: 0,
                        child: Visibility(
                          visible: NotificationLocalStorageService
                                  .notificationCount >
                              0,
                          child: CircleAvatar(
                            backgroundColor: ctr.isActive.value
                                ? AppColor.red
                                : AppColor.grey,
                            radius: 7,
                            child: Text(NotificationLocalStorageService
                                    .notificationCount
                                    .toString())
                                .subTitle(fontSize: 8, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomSwitcher(
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
              ctr.showInvest
                  ? Column(
                      children: List.generate(
                        ctr.isLoading.value ? 4 : ctr.recentProduct.length,
                        (index) => !ctr.isActive.value
                            ? CW
                                .listUserOrProductWidgetShimmer(animate: false)
                                .toButton(
                                    onTap: () => HC.snack(tGoLiveToActive))
                            : ctr.isLoading.value && ctr.isActive.value
                                ? CW.listUserOrProductWidgetShimmer(
                                    animate: true)
                                : CW.listUserOrProductWidget(
                                    name: ctr.recentProduct[index]
                                        ['productName'],
                                    state: ctr.recentProduct[index]['state'],
                                    lga: ctr.recentProduct[index]['lga'],
                                    status: ctr.recentProduct[index]['status'],
                                  ),
                      ),
                    )
                  : SizedBox(
                      height: Get.height * .2,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.shopping_cart_outlined,
                            //   size: 60,
                            //   color: AppColor.greyLigth,
                            // ),
                            // const Text("No data to display").subTitle(
                            //     fontSize: 14, color: AppColor.greyLigth)
                          ],
                        ),
                      ),
                    ),
              CW.AppSpacer(h: 30),
              CW.button(
                color: ctr.isActive.value ? null : AppColor.inActiveBlack,
                onPress: ctr.isActive.value
                    ? () async {
                        // Get.find<AuthService>().fetchUser();
                        var deviceToken = await HC.initFCM().getToken();
                        // NotificationController.createNotification();
                        log(deviceToken.toString());
                      }
                    : () => HC.snack(tGoLiveToActive),
                text: tInvestNow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(tInvestNow).title(
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
      },
    );
  }
}
