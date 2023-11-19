import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/values/values.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  // String? title, amount, image, sku;
  bool isNetwork;
  Datum productData;
  ProductCard({
    super.key,
    this.isNetwork = false,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HC.spaceHorizontal(148),
      width: HC.spaceVertical(120),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            blurRadius: .1,
            spreadRadius: 3,
            color: AppColor.greyLigth.withAlpha(10),
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: productData.sku!,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                image: DecorationImage(
                  image: isNetwork
                      ? CachedNetworkImageProvider(
                          productData.productImage![0],
                        ) as ImageProvider
                      : const AssetImage(Assets.assetsImagesImage),
                  fit: BoxFit.cover,
                ),
              ),
              height: HC.spaceVertical(100),
            ),
          ),
          CW.AppSpacer(h: 7),
          Text(productData.productName!)
              .subTitle(fontSize: 10, lines: 1)
              .paddingSymmetric(horizontal: 4),
          Text("$tNaira ${productData.amount ?? '0'}")
              .title(fontSize: 12, color: AppColor.text)
              .paddingSymmetric(horizontal: 4, vertical: 2),
        ],
      ),
    ).toButton(
        onTap: () =>
            Get.toNamed(RouteName.productDetails.name, arguments: productData));
  }
}
