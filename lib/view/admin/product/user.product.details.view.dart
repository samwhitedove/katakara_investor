import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/product/user.products.controller.dart';
import 'package:katakara_investor/view/widgets/courosel.image.view.dart';
import 'package:katakara_investor/view/widgets/popup.menu.dart';

// ignore: must_be_immutable
class UserProductDetailView extends StatelessWidget {
  UserProductDetailView({super.key});

  final __ = Get.put(UserProductsController());
  final _ = Get.find<UserProductsController>();

  PortfolioDatum productInfo = Get.arguments;

  List<Map<String, dynamic>> get product => [
        {"title": "Comission", "value": productInfo.comission},
        {"title": "Amount Buy", "value": productInfo.amountBuy},
        {"title": "Expenditure Amount", "value": productInfo.expenditureAmount},
        {"title": "Expenditure", "value": productInfo.expenditureDescription},
        {"title": "Product Name", "value": productInfo.productName},
        {"title": "State", "value": productInfo.state},
        {"title": "LGA", "value": productInfo.lga},
        {"title": "Description", "value": productInfo.description},
        {"title": "Category", "value": productInfo.category},
        {"title": "Amount", "value": productInfo.amount},
        {"title": "SKU", "value": productInfo.sku},
        {"title": "Seller Image", "value": productInfo.sellerImage},
        {"title": "Status", "value": productInfo.status!.$2},
        {"title": "Uploaded Date", "value": productInfo.createdAt}
      ];

  @override
  Widget build(BuildContext context) {
    _.commission.text = productInfo.comission!;
    _.amount.text = productInfo.amount!;
    return Scaffold(body: GetBuilder<UserProductsController>(
      builder: (controller) {
        _.selectedProduct = productInfo;
        return Stack(
          children: [
            Column(
              children: [
                CW.AppBr(
                  title: const Text("Product Details").title(fontSize: 20),
                  trailing: userData.role == Roles.USER.name
                      ? null
                      : Row(
                          children: [
                            InkWell(
                              onTap: action,
                              child: Row(
                                children: [
                                  const Text("Edit").title(fontSize: 12),
                                  const Icon(
                                    Icons.edit_note_rounded,
                                    color: AppColor.primary,
                                  )
                                ],
                              ),
                            ),
                            CustomPopUpMenu(
                              data: _.productStatus,
                              onChange: (text) async {
                                if (text == "REJECTED") {
                                  productInfo.rejectionReason = _.reason.text;
                                  return rejectProduct(text!);
                                }

                                final status = await _.updateStatus(text);
                                if (status) {
                                  if (text == "ACTIVE") {
                                    productInfo.rejectionReason = "";
                                  }
                                  productInfo.status = handleStatus(text!);
                                }
                              },
                              selected: _.productStatus.indexOf(
                                product[product.length - 2]['value'],
                              ),
                            ),
                          ],
                        ),
                ),
                CouroselImageView(
                  productImage: [
                    ...productInfo.productImage!.toList()
                      ..removeWhere((element) => element == "")
                  ],
                  onTap: () {},
                  sku: productInfo.sku!,
                ),
                Visibility(
                    visible: productInfo.rejectionReason != null ||
                        productInfo.rejectionReason != '',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Reason for rejection")
                              .subTitle(fontSize: 12),
                          Text(productInfo.rejectionReason).subTitle(
                              fontSize: 12, bold: true, color: AppColor.red),
                        ],
                      ).align(Al.left),
                    )),
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: SelectableText(product[index]['title']),
                          subtitle: product[index]['title'] == "Seller Image"
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    children: List.generate(
                                      product[index]['value'].length,
                                      (lowIndex) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: InkWell(
                                          onTap: () => Get.toNamed(
                                              RouteName.fullImageView.name,
                                              arguments: {
                                                'tag': productInfo.sku,
                                                'image': product[index]['value']
                                                    [lowIndex]
                                              }),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CachedNetworkImage(
                                                imageUrl: product[index]
                                                    ['value'][lowIndex]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SelectableText(
                                  HC.formartValue(product[index]['value'])),
                        );
                      }),
                )
              ],
            ),
            CW.LoadingOverlay(_.isLoading)
          ],
        );
      },
    ));
  }

  rejectProduct(String text) {
    return Get.bottomSheet(
      Container(
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CW.textField(
                  lines: 5,
                  label: "Reason for rejection",
                  controller: _.reason,
                  inputType: TextInputType.text,
                  onChangeValue: () =>
                      _.hasReason.value = _.reason.text.isNotEmpty),
              Obx(
                () => CW.button(
                  onPress: _.hasReason.value
                      ? () async {
                          Get.back();
                          final status = await _.updateStatus(text);
                          if (status) {
                            productInfo.rejectionReason = _.reason.text;
                            productInfo.status = handleStatus(text);
                            _.reason.clear();
                          }
                        }
                      : null,
                  text: "Reject Product",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setCommission() {
    return Get.bottomSheet(
      Container(
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CW.textField(
                  label: "Amount to sell",
                  controller: _.amount,
                  inputType: TextInputType.number,
                  numberOnly: true,
                  onChangeValue: _.checkCommission),
              CW.textField(
                  label: "Commission",
                  controller: _.commission,
                  inputType: TextInputType.number,
                  numberOnly: true,
                  onChangeValue: _.checkCommission),
              Obx(
                () => CW.button(
                  onPress: _.hasCommission.value
                      ? () async {
                          final status = await _.addCommission();
                          if (status) {
                            productInfo.comission = _.commission.text;
                          }
                        }
                      : null,
                  text: "Set Commission",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  action() {
    return Get.bottomSheet(
      Container(
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CW.button(
                onPress: () {
                  Get.back();
                  setCommission();
                },
                text: "Set Commission",
              ),
              CW.button(
                color: AppColor.red,
                onPress: () {
                  Get.back();
                  deleteProduct();
                },
                text: "Delete Product",
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteProduct() {
    return Get.bottomSheet(
      Container(
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Are you sure to delete product?')
                    .subTitle(fontSize: 12, color: AppColor.black),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CW
                        .button(
                          color: AppColor.red,
                          onPress: _.deleteProduct,
                          text: "Yes",
                        )
                        .halfWidth(width: .44),
                    CW
                        .button(
                          onPress: Get.back,
                          text: "No",
                        )
                        .halfWidth(width: .44),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
