import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'admin.investment.controller.dart';
import 'admin.product.active.view.dart';

class AdminInvestmentSearchPage extends StatelessWidget {
  const AdminInvestmentSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminInvestmentActiveController>(
      init: AdminInvestmentActiveController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Search Investment")),
          body: CW.column(
            scroll: const NeverScrollableScrollPhysics(),
            children: [
              CW.textField(
                label: "",
                controller: _.searchController,
                onChangeValue: () {},
                hint: "72BXXXX",
                suffix: Obx(() => Visibility(
                      visible: !_.isFetching.value,
                      child: InkWell(
                        onTap: _.searchReceipt,
                        child: const Icon(Icons.search),
                      ),
                    )),
              ),
              CW.CircleLoader(show: _.isFetching),
              Obx(
                () => Visibility(
                  visible: !_.isFetching.value,
                  child: _.searchedInvestment!.isEmpty
                      ? _.hasSearch.value
                          ? Center(
                              child: NoDataScreen(
                                oncall: () {},
                                message: 'No user found',
                              ),
                            )
                          : const SizedBox()
                      : CustomListViewWithFetchMore(
                          pagination: _.pagination,
                          count: _.searchedInvestment!.length,
                          getMoreReceipt: _.getMoreInvestment,
                          fetchingMore: _.fetchingMore,
                          fetchedata: _.searchedInvestment!,
                          handleStatusView: HC.handleStatusView,
                          previewData: _.viewInvestment,
                          child: investmentDataView),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
