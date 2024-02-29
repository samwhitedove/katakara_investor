import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/admin/model.fetch.user.dart';
import 'package:katakara_investor/models/receipt/models.receipt.preview.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

// ignore: must_be_immutable
class HomeReceiptReview extends StatelessWidget {
  HomeReceiptReview({super.key});
  final ReceiptPreviewData data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptController>(
      init: ReceiptController(),
      initState: (_) {},
      builder: (_) {
        return CW.pageWithAppBar(
          title: "Reciept Info",
          others: GestureDetector(
            onTap: () {
              log("${data.user!.toJson()} ---- user log data");
              Get.toNamed(
                RouteName.viewInformationCard.name,
                arguments: FetchedUser.fromJson(data.user!.toJson()),
              );
            },
            child: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          children: [
            CW.AppSpacer(h: 20),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    // height: Get.height * .9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          8,
                          (index) => FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(
                                    data.canShare! ? 4 : 3,
                                    (index) => Transform.rotate(
                                      angle: 200,
                                      child: Text(data.canShare!
                                              ? tAppName
                                              : tPendingApproval)
                                          .title(
                                              fontSize: 20,
                                              color: data.canShare!
                                                  ? AppColor.primaryLight
                                                      .withAlpha(data.canShare!
                                                          ? 16
                                                          : 20)
                                                  : AppColor.black
                                                      .withAlpha(20)),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
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
                                  SelectableText(
                                    data.receiptId ?? "UNAVAILABLE",
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 10.22,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                    child: Text(HC.formatDate(
                                            DateTime.parse(data.date!),
                                            formatSimple: true))
                                        .subTitle(
                                      fontSize: 9,
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
                                  maxWidth: Get.width * .42,
                                ),
                                child: const Text("FROM").title(
                                  fontSize: 10.22,
                                  lines: 3,
                                  color: AppColor.black,
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: Get.width * .42,
                                  maxWidth: Get.width * .42,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(userData.companyName ??
                                          "No busniess name")
                                      .subTitle(
                                    lines: 3,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(
                                minWidth: Get.width * .42,
                                maxWidth: Get.width * .42),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("TO").title(
                                  fontSize: 10.22,
                                  lines: 5,
                                  color: AppColor.black,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(data.customerName!)
                                      .subTitle(lines: 30),
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
                            constraints: BoxConstraints(
                                minWidth: Get.width * .373,
                                maxWidth: Get.width * .373),
                            child: Text(tDescription.toUpperCase())
                                .title(color: AppColor.black, fontSize: 10.22),
                          ),
                          Container(
                            // color: AppColor.red,
                            constraints:
                                BoxConstraints(minWidth: Get.width * .1),
                            child: Center(
                              child: const Text(tQty).title(
                                  color: AppColor.black, fontSize: 10.22),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.productInfo![index].itemName!)
                                          .subTitle(
                                              color: AppColor.black,
                                              fontSize: 10.22),
                                      Text(data
                                              .productInfo![index].description!)
                                          .subTitle(
                                              color: AppColor.black,
                                              fontSize: 10.22),
                                    ],
                                  ),
                                ),
                                Container(
                                  constraints:
                                      BoxConstraints(minWidth: Get.width * .1),
                                  child: Center(
                                    child: Text(_
                                            .checkQuantity(data
                                                .productInfo![index].quantity!)
                                            .split('.')[0])
                                        .subTitle(
                                            color: AppColor.black,
                                            fontSize: 10.22)
                                      ..align(Al.center),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: Get.width * .373,
                                      maxWidth: Get.width * .373),
                                  child: Text(tNaira +
                                          data.productInfo![index].price!
                                              .formatMoney)
                                      .subTitle(
                                          color: AppColor.black,
                                          fontSize: 10.22)
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
                                minWidth: Get.width * .40,
                                maxWidth: Get.width * .40),
                          ),
                          Container(
                            constraints:
                                BoxConstraints(minWidth: Get.width * .1),
                            child: Center(
                              child: const Text(tTotal)
                                  .title(color: AppColor.black, fontSize: 10.22)
                                ..align(Al.center),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                minWidth: Get.width * .36,
                                maxWidth: Get.width * .36),
                            child: Text(tNaira + data.totalAmount!.formatMoney)
                                .title(color: AppColor.black, fontSize: 10.22)
                                .align(Al.right),
                          ),
                        ],
                      ),
                      CW.AppSpacer(h: 80),
                      userData.investorSignature == null ||
                              userData.investorSignature!.isEmpty ||
                              userData.investorSignature?.startsWith('http')
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
                            constraints:
                                BoxConstraints(maxWidth: Get.width * .4),
                            margin: const EdgeInsets.only(top: 10),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                          text: data
                                              .customerName!.capitalizeFirst)
                                      .title(
                                          fontSize: 9, color: AppColor.black),
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
                      ),
                      CW.AppSpacer(h: 50),
                      Visibility(
                        visible: data.canShare! && data.isAdmin == false,
                        child: CW.button(
                            onPress: data.canShare! ? _.share : null,
                            text:
                                data.canShare! ? "Share" : "Pending Approval"),
                      ),
                      Visibility(
                        visible: data.isAdmin!,
                        child: Obx(() => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CW
                                        .button(
                                          isLoading: _.isDeleting.value,
                                          color: _.isDeleting.value ||
                                                  _.isApproving.value ||
                                                  _.isRejecting.value
                                              ? null
                                              : AppColor.red,
                                          onPress: _.isDeleting.value ||
                                                  _.isApproving.value ||
                                                  _.isRejecting.value
                                              ? null
                                              : () => _.handleOperation(
                                                  true,
                                                  data.id!,
                                                  NewProductStatus.PENDING),
                                          text: "Delete Receipt",
                                        )
                                        .halfWidth(width: .4),
                                    CW
                                        .button(
                                            isLoading: _.isApproving.value,
                                            onPress: _.isDeleting.value ||
                                                    _.isApproving.value ||
                                                    _.isRejecting.value ||
                                                    data.status! ==
                                                        NewProductStatus
                                                            .APPROVED.name
                                                ? null
                                                : () => _.handleOperation(
                                                    false,
                                                    data.id!,
                                                    NewProductStatus.APPROVED),
                                            text: "Approve Receipt")
                                        .halfWidth(width: .4),
                                  ],
                                ),
                                CW
                                    .button(
                                      color: _.isDeleting.value ||
                                              _.isApproving.value ||
                                              _.isRejecting.value ||
                                              data.status! ==
                                                  NewProductStatus.REJECTED.name
                                          ? null
                                          : AppColor.black,
                                      isLoading: _.isRejecting.value,
                                      onPress: _.isDeleting.value ||
                                              _.isApproving.value ||
                                              _.isRejecting.value ||
                                              data.status! ==
                                                  NewProductStatus.REJECTED.name
                                          ? null
                                          : () => _.handleOperation(
                                              false,
                                              data.id!,
                                              NewProductStatus.REJECTED),
                                      text: "Reject Receipt",
                                    )
                                    .halfWidth(width: .85)
                              ],
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
