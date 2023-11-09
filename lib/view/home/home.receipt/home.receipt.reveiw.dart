import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/receipt/models.receipt.preview.dart';
import 'package:katakara_investor/values/values.dart';

// ignore: must_be_immutable
class HomeReceiptReview extends StatelessWidget {
  HomeReceiptReview({super.key});
  bool canShare = Get.parameters['share'] == "true";
  final ReceiptPreviewData data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return CW.baseStackWidget(
      side: 15,
      children: [
        CW.AppSpacer(h: 60),
        CW.backButton(),
        CW.AppSpacer(h: 20),
        Stack(
          children: [
            SizedBox(
              height: Get.height * .6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    5,
                    (index) => FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(
                              canShare ? 4 : 3,
                              (index) => Transform.rotate(
                                angle: 200,
                                child: Text(
                                        canShare ? tAppName : tPendingApproval)
                                    .title(
                                        fontSize: 20,
                                        color: canShare
                                            ? AppColor.primaryLight
                                                .withAlpha(canShare ? 16 : 20)
                                            : AppColor.black.withAlpha(20)),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
            CW.column(
              size: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("RECEIPT").title(
                      fontSize: 27.2,
                      undeline: true,
                      color: AppColor.black,
                    ),
                    // CW.AppSpacer(w: 50),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("RECEIPT ID").title(
                              fontSize: 10.22,
                              color: AppColor.black,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: const Text("DATE CREATED").title(
                                fontSize: 10.22,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(data.receiptId ?? "UNAVAILABLE").subTitle(
                              fontSize: 10.22,
                              color: AppColor.text,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(data.date!.replaceAll("/", '-'))
                                  .subTitle(
                                fontSize: 10.22,
                                color: AppColor.text,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                CW.AppSpacer(h: 39.6),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              minWidth: Get.width * .42,
                              maxWidth: Get.width * .42),
                          child: const Text("FROM").title(
                            fontSize: 10.22,
                            color: AppColor.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child:
                              Text(userData.companyName ?? "No busniess name")
                                  .subTitle(),
                        )
                      ],
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minWidth: Get.width * .42, maxWidth: Get.width * .42),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("TO").title(
                            fontSize: 10.22,
                            lines: 5,
                            color: AppColor.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(data.customerName!).subTitle(lines: 30),
                          ),
                          Text(data.customerAddress!).subTitle(lines: 30)
                        ],
                      ),
                    ),
                  ],
                ),
                CW.AppSpacer(h: 19.8),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    Container(
                      // color: AppColor.primary,
                      constraints: BoxConstraints(
                          minWidth: Get.width * .373,
                          maxWidth: Get.width * .373),
                      child: Text(tDescription.toUpperCase())
                          .title(color: AppColor.black, fontSize: 10.22),
                    ),
                    Container(
                      // color: AppColor.red,
                      constraints: BoxConstraints(minWidth: Get.width * .1),
                      child: Center(
                        child: const Text(tQty)
                            .title(color: AppColor.black, fontSize: 10.22),
                      ),
                    ),
                    Container(
                      // color: AppColor.primary,
                      constraints: BoxConstraints(
                          minWidth: Get.width * .373,
                          maxWidth: Get.width * .373),
                      child: Text(tAmt.toUpperCase())
                          .title(color: AppColor.black, fontSize: 10.22)
                          .align(Al.right),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                ...List.generate(
                  data.productInfo!.length,
                  (index) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                minWidth: Get.width * .373,
                                maxWidth: Get.width * .373),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.productInfo![index].itemName!)
                                    .subTitle(
                                        color: AppColor.black, fontSize: 10.22),
                                Text(data.productInfo![index].description!)
                                    .subTitle(
                                        color: AppColor.black, fontSize: 10.22),
                              ],
                            ),
                          ),
                          Container(
                            constraints:
                                BoxConstraints(minWidth: Get.width * .1),
                            child: Center(
                              child: Text(checkQuantity(
                                          data.productInfo![index].quantity!)
                                      .split('.')[0])
                                  .subTitle(
                                      color: AppColor.black, fontSize: 10.22)
                                ..align(Al.center),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                minWidth: Get.width * .373,
                                maxWidth: Get.width * .373),
                            child: Text(tNaira +
                                    data.productInfo![index].price!.formatMoney)
                                .subTitle(
                                    color: AppColor.black, fontSize: 10.22)
                                .align(Al.right),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: data.productInfo!.length > 1 &&
                            index != data.productInfo!.length - 1,
                        child: const Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                CW.AppSpacer(h: 15.8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          minWidth: Get.width * .40, maxWidth: Get.width * .40),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: Get.width * .1),
                      child: Center(
                        child: const Text(tTotal)
                            .title(color: AppColor.black, fontSize: 10.22)
                          ..align(Al.center),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minWidth: Get.width * .36, maxWidth: Get.width * .36),
                      child: Text(tNaira + data.totalAmount!.formatMoney)
                          .title(color: AppColor.black, fontSize: 10.22)
                          .align(Al.right),
                    ),
                  ],
                ),
                CW.AppSpacer(h: 80),
                userData.investorSignature == null ||
                        userData.investorSignature!.isEmpty
                    ? const Text(tNoSign).align(Al.left)
                    : CachedNetworkImage(
                        imageUrl: userData.investorSignature!,
                        height: HC.spaceVertical(51),
                        width: HC.spaceHorizontal(51),
                      ).align(Al.left),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: Get.width * .4),
                      margin: const EdgeInsets.only(top: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: data.customerName!.capitalizeFirst)
                                .title(fontSize: 9, color: AppColor.black),
                            const TextSpan(text: tPossess)
                                .subTitle(fontSize: 9),
                          ],
                        ),
                      ),
                    ).halfWidth(width: .4),
                    CW.AppSpacer(w: 10),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(text: tPoweredBy)
                                    .subTitle(fontSize: 9),
                                const TextSpan(text: tAppName)
                                    .title(fontSize: 9),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(text: tSupport)
                                    .subTitle(fontSize: 9),
                                const TextSpan(text: tAdminEmail)
                                    .subTitle(fontSize: 9),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).halfWidth(width: .43),
                  ],
                )
              ],
            ),
          ],
        ),
        CW.AppSpacer(h: 50),
        Visibility(
            visible: true,
            child: CW.button(
                onPress: canShare ? share : null,
                text: canShare ? "Share" : "Pending Approval"))
      ],
    );
  }

  checkQuantity(String qy) {
    if (qy.contains('.')) {
      return qy.split('.')[0];
    }
    return qy;
  }

  void share() {}
}
