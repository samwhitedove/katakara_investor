import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/product/product.details.controller.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (_) {
        return CW.baseStackWidget(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withAlpha(40),
                  offset: const Offset(0, 0),
                  spreadRadius: .1,
                  blurRadius: 2,
                ),
              ],
            ),
            height: 70,
            child: CW
                .button(
                    onPress: _.actionButtom,
                    text: _.product!.isPersonal! ? "Edit" : "Invest")
                .paddingSymmetric(horizontal: 15),
          ),
          isLoading: _.isDeleting.value,
          children: [
            CW.AppSpacer(h: 66),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: CW.backButton(),
                ),
                IconButton(
                    onPressed: _.handleDeleteProduct,
                    icon: const Icon(
                      Icons.delete,
                      color: AppColor.red,
                    ))
              ],
            ),
            CW.AppSpacer(h: 26),
            Column(
              children: [
                SizedBox(
                  height: HC.spaceVertical(312),
                  child: Hero(
                    tag: _.product!.sku!,
                    child: PageView.builder(
                      controller: _.pageController,
                      itemCount: _.product!.productImage!.length,
                      onPageChanged: _.changeView,
                      physics: const BouncingScrollPhysics(),
                      allowImplicitScrolling: true,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(right: 20, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                _.product!.productImage![index]),
                            // AssetImage(
                            //   Assets.assetsImagesImage,
                            // ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: HC.spaceVertical(312),
                        width: HC.spaceHorizontal(380),
                      ).toButton(
                          onTap: () => Get.toNamed(RouteName.fullImageView.name,
                                  arguments: {
                                    'tag': _.product!.sku,
                                    'image': _.product!.productImage![index]
                                  })),
                    ),
                  ),
                ),
              ],
            ),
            CW.AppSpacer(h: 10),
            CW.PageDot(
              count: _.product!.productImage!.length,
              current: _.currentImageView,
              activeColor: AppColor.grey,
              inactiveColor: AppColor.greyLigth,
            ),
            CW.column(
              size: 20,
              children: [
                const Text("Product Name:").subTitle(fontSize: 10),
                Text(_.product!.productName!).title(fontSize: 16),
                CW.AppSpacer(h: 8),
                Row(
                  children: [
                    const Text("SKU:").subTitle(
                      fontSize: 10,
                      // color: AppColor.greyLigth,
                    ),
                    CW.AppSpacer(w: 9),
                    Text(_.product!.sku!)
                        .title(fontSize: 12, color: AppColor.text)
                  ],
                ),
                Row(
                  children: [
                    const Text("Location:").subTitle(
                      fontSize: 10,
                      // color: AppColor.greyLigth,
                    ),
                    CW.AppSpacer(w: 9),
                    Text("${_.product!.lga}, ${_.product!.state}")
                        .title(fontSize: 12, color: AppColor.text)
                  ],
                ),
                Row(
                  children: [
                    const Text(tCategory).subTitle(
                      fontSize: 10,
                    ),
                    CW.AppSpacer(w: 9),
                    Text(_.product!.category.toString())
                        .title(fontSize: 12, color: AppColor.text)
                  ],
                ),
                Row(
                  children: [
                    const Text(tAmountBought).subTitle(
                      fontSize: 10,
                    ),
                    CW.AppSpacer(w: 9),
                    Text("₦ ${_.product!.amountBuy}")
                        .title(fontSize: 12, color: AppColor.text)
                  ],
                ),
                CW.AppSpacer(h: 8),
                const Divider(
                  thickness: 2,
                ),
                CW.AppSpacer(w: 9),
                const Text("Amount:")
                    .subTitle(fontSize: 10, color: AppColor.text),
                Text("₦ ${_.product!.amount!}")
                    .title(fontSize: 24, color: AppColor.text),
                const Divider(
                  thickness: 2,
                ),
                CW.column(
                  size: 0,
                  children: [
                    const Text("Seller Images").subTitle(fontSize: 10),
                    CW.AppSpacer(h: 10),
                    Builder(builder: (context) {
                      if (_.product!.sellerImage!.isEmpty) {
                        return const Text(tNoImage).subTitle(fontSize: 14);
                      }
                      return Wrap(
                        children: List.generate(
                          _.product!.sellerImage!.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 20, left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  _.product!.sellerImage![index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: HC.spaceVertical(50),
                            width: HC.spaceHorizontal(50),
                          ).toButton(
                            onTap: () => Get.toNamed(
                              RouteName.fullImageView.name,
                              arguments: {
                                'tag': _.product!.sellerImage![index],
                                'image': _.product!.sellerImage![index]
                              },
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
                CW.AppSpacer(h: 10),
                const Divider(
                  thickness: 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("$tProductDescription:").subTitle(fontSize: 10),
                    Text(_.product!.description!).title(
                      fontSize: 12,
                      color: AppColor.text,
                      lines: 200,
                    ),
                  ],
                ),
                CW.AppSpacer(h: 20),
              ],
            ),
          ],
        );
      },
    );
  }
}
