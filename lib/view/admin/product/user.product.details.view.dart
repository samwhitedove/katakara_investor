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

  final _ = Get.put(UserProductsController());
  final controller = Get.find<UserProductsController>();

  final PortfolioDatum productInfo = Get.arguments;
  List<Map<String, dynamic>> get product => [
        {"title": "Product Name", "value": productInfo.productName},
        {"title": "State", "value": productInfo.state},
        {"title": "LGA", "value": productInfo.lga},
        {"title": "Description", "value": productInfo.description},
        {"title": "Category", "value": productInfo.category},
        {"title": "Amount", "value": productInfo.amount},
        {"title": "SKU", "value": productInfo.sku},
        {"title": "Seller Image", "value": productInfo.sellerImage},
        {"title": "Amount Buy", "value": productInfo.amountBuy},
        {"title": "Status", "value": productInfo.status!.$2},
        {"title": "Uploaded Date", "value": productInfo.createdAt}
      ];

  @override
  Widget build(BuildContext context) {
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
                        : CustomPopUpMenu(
                            data: _.productStatus,
                            onChange: _.updateStatus,
                            selected: _.productStatus
                                .indexOf(productInfo.status!.$2))),
                CouroselImageView(
                  productImage: [
                    ...productInfo.productImage!.toList()
                      ..removeWhere((element) => element == "")
                  ],
                  onTap: () {},
                  sku: productInfo.sku!,
                ),
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
                                      (_) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: InkWell(
                                          onTap: () => Get.toNamed(
                                              RouteName.fullImageView.name,
                                              arguments: {
                                                'tag': productInfo.sku,
                                                'image': product[index]['value']
                                                    [_]
                                              }),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CachedNetworkImage(
                                                imageUrl: product[index]
                                                    ['value'][_]),
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
}
