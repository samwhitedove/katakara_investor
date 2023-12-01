import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom,product.load.dart';
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
          scroll: const NeverScrollableScrollPhysics(),
          floatingActionButton: FloatingActionButton(
            onPressed: _.addPortfolio,
            child: const Icon(Icons.add_home_rounded),
          ),
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: AppColor.primary,
                  width: Get.width,
                  height: HC.spaceHorizontal(248),
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
                          const Text(tPortfolio).title(
                            color: AppColor.white,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      CW.AppSpacer(h: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(tBusinessName)
                              .title(fontSize: 20, color: AppColor.white),
                          const Text(tSendReceipt).subTitle(
                            color: AppColor.white.withOpacity(.7),
                          ),
                        ],
                      ).align(Al.center),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -35,
                  left: 0,
                  right: 0,
                  child: CW.column(
                    children: [
                      Container(
                        color: AppColor.white,
                        width: Get.width,
                        child: Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_.showing.value.toString())
                                      .title(
                                        fontSize: 13,
                                        color: AppColor.text,
                                      )
                                      .align(Al.center),
                                  const Text(tActiveProduct).subTitle(
                                    fontSize: 12,
                                    color: AppColor.grey,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(_.totalProduct.value.toString()).title(
                                    fontSize: 13,
                                    color: AppColor.text,
                                  ),
                                  const Text(tPending).subTitle(
                                    fontSize: 12,
                                    color: AppColor.grey,
                                  ),
                                ],
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 15),
                        ),
                      ).roundCorner(
                          showShadow: true,
                          borderColor: AppColor.white,
                          blurRadius: 1,
                          height: HC.spaceVertical(70)),
                    ],
                  ),
                ),
              ],
            ),
            CW.AppSpacer(h: 60),
            Obx(
              () => ShowProducts(
                errorMessage: _.errorMessage,
                isError: _.isError.value,
                isLoading: _.isFetchingProducts.value,
                product: _.personalProduct,
                refresh: _.fetchPortfolio,
              ),
            )
          ],
        );
      },
    );
  }
}
