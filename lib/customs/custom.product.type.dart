import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.product.card.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/values/values.dart';

// ignore: must_be_immutable
class ProductTypeCategory extends StatelessWidget {
  ProductTypeCategory(
      {super.key, required this.product, required this.onRefresh});
  List<Datum> product;
  Function()? onRefresh;
  // final _ = Get.put(PortfolioController());

  @override
  Widget build(BuildContext context) {
    return product.isEmpty
        ? Center(child: NoDataScreen(oncall: onRefresh))
        : SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Wrap(
              spacing: 4,
              runSpacing: 10,
              children: List.generate(
                product.length,
                (index) => Stack(
                  children: [
                    Container(
                      width: HC.spaceHorizontal(118),
                      margin: const EdgeInsets.all(3),
                      child: ProductCard(
                        isNetwork: true,
                        productData: product[index],
                      ),
                    ),
                    Visibility(
                      visible: !product[index].isApproved!,
                      child: const Text("Pending")
                          .subTitle(fontSize: 10, color: AppColor.white)
                          .paddingAll(4)
                          .simpleRoundCorner(
                            width: HC.spaceHorizontal(67),
                            height: HC.spaceHorizontal(30),
                            bgColor: AppColor.subTitle,
                          ),
                    ),
                    Positioned(
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: product[index].isApproved!,
                            child: const Text("Approved")
                                .subTitle(fontSize: 10, color: AppColor.white)
                                .paddingAll(4)
                                .simpleRoundCorner(
                                  width: HC.spaceHorizontal(77),
                                  height: HC.spaceHorizontal(30),
                                  bgColor: AppColor.primary,
                                ),
                          ),
                          CW.AppSpacer(h: 2),
                          Visibility(
                            visible: product[index].isMerge!,
                            child: const Text("KFI")
                                .subTitle(fontSize: 10, color: AppColor.white)
                                .paddingAll(4)
                                .simpleRoundCorner(
                                  width: HC.spaceHorizontal(34),
                                  height: HC.spaceHorizontal(28),
                                  bgColor: AppColor.orange,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ).marginSymmetric(horizontal: 15),
          );
  }
}

// ignore: must_be_immutable
class NoDataScreen extends StatelessWidget {
  Function()? oncall;
  String? message;
  NoDataScreen({super.key, required this.oncall, this.message});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () async {
          await oncall?.call();
          return true as Future;
        },
        child: Column(
          children: [
            Image.asset(Assets.assetsImagesNoData, scale: 4),
            Text(message ?? "No Data Found").subTitle(),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ErrorFetchingScreen extends StatelessWidget {
  final String? error;
  Function()? onRefresh;
  ErrorFetchingScreen({super.key, this.error, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => onRefresh?.call(),
      child: SingleChildScrollView(
        child: SizedBox(
          height: Get.height * .6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CW.AppSpacer(h: 30),
              Text(error!.isNotEmpty ? error! : "Error fetching data")
                  .subTitle(color: AppColor.red)
                  .align(Al.center),
              CW.AppSpacer(h: 10),
              Column(
                children: [
                  Image.asset(
                    Assets.assetsImagesSwipeDown,
                    scale: 3,
                    color: AppColor.grey,
                  ),
                  const Text("Swipe down to reload or click button below")
                      .subTitle()
                ],
              ),
              CW.AppSpacer(h: 30),
              SizedBox(
                  height: HC.spaceVertical(50),
                  width: HC.spaceHorizontal(100),
                  child: CW.button(
                      onPress: onRefresh,
                      text: "Reload",
                      color: AppColor.primarySwatch.withAlpha(100)))
            ],
          ),
        ),
      ),
    );
  }
}
