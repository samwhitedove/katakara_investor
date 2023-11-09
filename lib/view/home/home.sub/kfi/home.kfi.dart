import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom,product.load.dart';
import 'package:katakara_investor/customs/custom.product.type.loading.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

import '../../../../customs/custom.product.type.dart';

class KFIPageScreen extends StatelessWidget {
  final HomeScreenController ctr;
  const KFIPageScreen({super.key, required this.ctr});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeKFIController>(
      init: HomeKFIController(),
      builder: (_) {
        _.homeScreenController = ctr;
        return Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Scaffold(
                  floatingActionButton: _.currentKfi.value == 1
                      ? FloatingActionButton.extended(
                          onPressed: () {},
                          label: const Row(
                            children: [Icon(Icons.add), Text("Invite KFI")],
                          ),
                        )
                      : null,
                  body: Column(
                    children: [
                      Column(
                        children: [
                          CW.AppSpacer(h: 50),
                          CW.AppSpacer(w: 20),
                          const Text(tFractionalInvestors)
                              .title(color: AppColor.white, fontSize: 22)
                              .center,
                          const Text(tKfiContent)
                              .subTitle(
                                  color: AppColor.white,
                                  fontSize: 12,
                                  lines: 6,
                                  align: TextAlign.center)
                              .paddingSymmetric(vertical: 20),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              _.fkis.length,
                              (index) => Text(_.fkis[index])
                                  .title(
                                    fontSize:
                                        _.currentKfi.value == index ? 13 : 11,
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
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 8, right: 8),
                                  )
                                  .toButton(onTap: () => _.changeTab(index)),
                            ),
                          ),
                          CW.AppSpacer(h: 20),
                        ],
                      ).addPaddingHorizontal(size: 15).roundCorner(
                            bgColor: AppColor.primary,
                            height: HC.spaceVertical(240),
                            bottomLeftRadius: 20,
                            showBorder: false,
                            bottomRightRadius: 20,
                          ),
                      Expanded(
                        child: PageView(
                          controller: _.pageController,
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: _.changeTab,
                          children: [
                            _.isLoading.value
                                ? const ProductTypeCategoryLoadingState()
                                : Obx(
                                    () => ShowProducts(
                                      refresh: _.fetchKFIInvestment,
                                      isLoading: _.isLoading.value,
                                      isError: _.isError.value,
                                      product: _.kfiProduct,
                                      errorMessage: _.errorMessage.value,
                                    ),
                                  ),
                            FutureBuilder<Map<String, dynamic>>(
                              future: _.fetchKFIAccount(),
                              builder: (context, snapshot) => ListView.builder(
                                itemBuilder: (context, index) => ListTile(
                                  leading: SizedBox(
                                    height: HC.spaceVertical(50),
                                    width: HC.spaceVertical(50),
                                    child:
                                        Image.asset(Assets.assetsImagesImage),
                                  ),
                                  title: const Text('User Name')
                                      .title(fontSize: 14),
                                  subtitle: const Text(
                                          "074673673434 * Ikeja * Lagos State")
                                      .subTitle(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
