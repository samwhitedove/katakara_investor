import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/receipts/admin.receipit.controller.dart';
import 'package:katakara_investor/view/widgets/popup.menu.dart';

import '../../../customs/custom.product.type.dart';
import '../../home/home.receipt/home.receipt.view.dart';

class AdminViewUserReceipt extends StatelessWidget {
  const AdminViewUserReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminReceiptController>(
      init: AdminReceiptController(),
      initState: (_) {},
      builder: (_) {
        return Stack(
          children: [
            CW.pageWithAppBar(
                fButton: FloatingActionButton(
                  onPressed: () => Get.toNamed(
                    RouteName.adminReceiptSearch.name,
                    arguments: Get.arguments,
                  ),
                  child: const Icon(Icons.search),
                ),
                scroll: const NeverScrollableScrollPhysics(),
                others: _.isLoading
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(children: [
                            Text(_.pagination!.total.toString()),
                            CustomPopUpMenu(
                                data: receiptType,
                                onChange: _.fetchReceipt,
                                selected: _.selected),
                            // PopupMenuButton<String>(
                            //   icon: const Icon(Icons.sort),
                            //   onSelected: _.changeUserType,
                            //   itemBuilder: (BuildContext context) {
                            //     return <PopupMenuEntry<String>>[
                            //       ...List.generate(
                            //         receiptType.length,
                            //         (index) => PopupMenuItem<String>(
                            //           textStyle: const TextStyle(
                            //               fontSize: 12, color: AppColor.text),
                            //           value: receiptType[index],
                            //           child: Row(
                            //             children: [
                            //               Text(receiptType[index]),
                            //               _.selected == index
                            //                   ? const Padding(
                            //                       padding: EdgeInsets.only(
                            //                           left: 8.0),
                            //                       child: CircleAvatar(
                            //                         radius: 3,
                            //                         backgroundColor:
                            //                             AppColor.primary,
                            //                       ),
                            //                     )
                            //                   : const SizedBox()
                            //             ],
                            //           ),
                            //         ),
                            //       )
                            //     ];
                            //   },
                            // ),
                          ]),
                          Text("${receiptType[_.selected]} RECEIPTS")
                              .subTitle(),
                        ],
                      ),
                title: 'Receipts',
                children: [
                  Visibility(
                    visible: _.isLoading == false && _.fetchedReceipt!.isEmpty,
                    child: Center(
                      child: SizedBox(
                        height: Get.height * .8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: NoDataScreen(
                              oncall: () {},
                              message: "No receipts found",
                            )),
                            CW.AppSpacer(h: 8),
                            CW.AppSpacer(h: 46),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible:
                          _.isLoading == false && _.fetchedReceipt!.isNotEmpty,
                      child: Expanded(
                        // height: Get.height * .9,
                        child: CustomListViewWithFetchMore(
                            pagination: _.pagination,
                            count: _.fetchedReceipt!.length,
                            getMoreReceipt: _.getMoreReceipt,
                            fetchingMore: _.fetchingMore,
                            fetchedata: _.fetchedReceipt!,
                            handleStatusView: HC.handleStatusView,
                            previewData: _.viewReceipt,
                            child: recieptChildDataView),
                      )),
                ]),
            CW.LoadingOverlay(_.isLoading),
          ],
        );
      },
    );
  }
}
