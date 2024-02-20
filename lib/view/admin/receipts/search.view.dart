import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/view/admin/receipts/admin.receipit.controller.dart';
import 'package:katakara_investor/view/home/home.receipt/home.receipt.view.dart';

import '../../../customs/custom.product.type.dart';

class AdminReceiptSearchPage extends StatelessWidget {
  const AdminReceiptSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminReceiptController>(
      init: AdminReceiptController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Search Receipt")),
          body: CW.column(
            scroll: const NeverScrollableScrollPhysics(),
            children: [
              CW.textField(
                label: "",
                controller: _.searchController,
                onChangeValue: () {},
                hint: "KRCXXXX",
                suffix: Obx(() => Visibility(
                      visible: !_.isFetching.value,
                      child: InkWell(
                          onTap: _.searchReceipt,
                          child: const Icon(Icons.search)),
                    )),
              ),
              CW.CircleLoader(show: _.isFetching),
              Obx(
                () => Visibility(
                  visible: !_.isFetching.value,
                  child: _.searchedReceipt!.isEmpty
                      ? _.hasSearch.value
                          ? Center(
                              child: NoDataScreen(
                                  oncall: () {}, message: 'No user found'),
                            )
                          : const SizedBox()
                      : CustomListViewWithFetchMore(
                          pagination: _.searchReceiptPagination,
                          count: _.searchedReceipt!.length,
                          getMoreReceipt: _.getMoreReceipt,
                          fetchingMore: _.fetchingMore,
                          fetchedata: _.searchedReceipt!,
                          handleStatusView: HC.handleStatusView,
                          previewData: _.viewReceipt,
                          child: recieptChildDataView),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
