import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/investment/active/admin.investment.controller.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';
import 'package:katakara_investor/view/widgets/bottom.sheet.dart';
import 'package:katakara_investor/view/widgets/courosel.image.view.dart';

// ignore: must_be_immutable
class InvestmentProductView extends StatelessWidget {
  InvestmentProductView({super.key});

  final find = Get.put(AdminInvestmentActiveController());
  final _ = Get.find<AdminInvestmentActiveController>();

  InvestmentDatum productInfo = Get.arguments;
  List<Map<String, dynamic>> get product => [
        {"title": "Product Name", "value": productInfo.productName},
        {"title": "State", "value": productInfo.state},
        {"title": "LGA", "value": productInfo.lga},
        {"title": "Description", "value": productInfo.description},
        {"title": "Category", "value": productInfo.category},
        {"title": "Amount", "value": productInfo.amount},
        {"title": "SKU", "value": productInfo.sku},
        {"title": "Seller Name", "value": productInfo.sellerName},
        {"title": "Seller Address", "value": productInfo.sellerAddress},
        {"title": "Uploaded Date", "value": productInfo.createdAt}
      ];

  @override
  Widget build(BuildContext context) {
    log(productInfo.toJson().toString());
    return GetBuilder<AdminInvestmentActiveController>(
      builder: (_) {
        return Stack(
          children: [
            Scaffold(
                floatingActionButton: ElevatedButton(
                  child: const Text('Book Now'),
                  onPressed: () {},
                ),
                body: Column(
                  children: [
                    CW.AppBr(
                        title: const Text("Investment").title(fontSize: 20),
                        trailing: userData.role == Roles.USER.name
                            ? null
                            : Row(
                                children: [
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                      RouteName.addInvestment.name,
                                      arguments: productInfo,
                                    ),
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: InkWell(
                                      onTap: () => deleteInvestment(_),
                                      child: const Icon(
                                        Icons.delete_forever,
                                        color: AppColor.red,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                    CouroselImageView(
                      productImage: productInfo.productImage!.split(',')
                        ..removeWhere((element) => element == ""),
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
                              subtitle: SelectableText(
                                  HC.formartValue(product[index]['value'])),
                            );
                          }),
                    )
                  ],
                )),
            Obx(() => CW.LoadingOverlay(_.isDeletingInvestment.value))
          ],
        );
      },
    );
  }

  deleteInvestment(AdminInvestmentActiveController _) {
    BottomSheetModal(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Are you sure to delete")
                  .title(fontSize: 14, color: AppColor.black),
              GestureDetector(
                onTap: Get.back,
                child: const CircleAvatar(
                    backgroundColor: AppColor.red,
                    radius: 10,
                    child: Icon(
                      Icons.close,
                      size: 12,
                      color: AppColor.white,
                    )),
              )
            ],
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CW
                .button(
                    onPress: () {
                      Get.back();
                      _.deleteInvestment(productInfo.sku!);
                    },
                    text: "Yes",
                    color: AppColor.red)
                .halfWidth(width: .4),
            CW
                .button(
                  onPress: Get.back,
                  text: "No",
                )
                .halfWidth(width: .4),
          ],
        ),
      ],
    ));
  }
}
