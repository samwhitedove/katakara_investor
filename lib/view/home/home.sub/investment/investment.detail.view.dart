import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';
import 'package:katakara_investor/view/widgets/courosel.image.view.dart';

// ignore: must_be_immutable
class InvestmentProductView extends StatelessWidget {
  InvestmentProductView({super.key});

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
    return Scaffold(
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
                            child: const Text("Edit"),
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
        ));
  }
}
