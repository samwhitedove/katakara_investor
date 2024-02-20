import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/view/admin/product/user.product.view.dart';
import 'package:katakara_investor/view/admin/product/user.products.controller.dart';

class UserPortSearchPage extends StatelessWidget {
  const UserPortSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProductsController>(
      init: UserProductsController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Search Portfolio")),
          body: CW.column(
            scroll: const NeverScrollableScrollPhysics(),
            children: [
              CW.textField(
                label: "",
                controller: _.searchController,
                onChangeValue: () {},
                hint: "SKU Number",
                suffix: Obx(() => Visibility(
                      visible: !_.isFetching.value,
                      child: InkWell(
                        onTap: _.searchPortfolio,
                        child: const Icon(Icons.search),
                      ),
                    )),
              ),
              CW.CircleLoader(show: _.isFetching),
              Obx(
                () => Visibility(
                  visible: !_.isFetching.value,
                  child: _.searchedPortfolio!.isEmpty
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
                          count: _.searchedPortfolio!.length,
                          getMoreReceipt: _.getMorePortfolio(),
                          fetchingMore: _.fetchingMore,
                          fetchedata: _.searchedPortfolio!,
                          handleStatusView: HC.handleStatusView,
                          previewData: _.viewProduct,
                          child: userPortfolioDataView),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
