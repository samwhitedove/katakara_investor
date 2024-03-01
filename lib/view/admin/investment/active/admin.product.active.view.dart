import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/investment/active/admin.investment.controller.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';

class ActiveProduct extends StatelessWidget {
  const ActiveProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminInvestmentActiveController>(
      init: AdminInvestmentActiveController(),
      initState: (_) {},
      builder: (_) {
        log('-----------------rebuildng. ${_.fetchCategory}--- ${_.selected}---------------');
        return Stack(
          children: [
            CW.pageWithAppBar(
                fButton: FloatingActionButton(
                  onPressed: () => filter(_),
                  child: const Icon(Icons.filter_list_outlined),
                ),
                scroll: const NeverScrollableScrollPhysics(),
                others: _.isLoading
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(children: [
                          Text(_.pagination!.total.toString()),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: GestureDetector(
                                onTap: () {
                                  _.searchInvestmentPagination = Pagination();
                                  _.searchedInvestment?.clear();
                                  _.searchController.clear();
                                  Get.toNamed(
                                    RouteName.adminInvestmentSearch.name,
                                    arguments: Get.arguments,
                                  );
                                },
                                child: Icon(Icons.search)),
                          )
                        ]),
                      ),
                title: 'Investments',
                children: [
                  Visibility(
                    visible:
                        _.isLoading == false && _.fetchedInvestment!.isEmpty,
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
                              message: "No investment found",
                            )),
                            CW.AppSpacer(h: 8),
                            CW.AppSpacer(h: 46),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _.isLoading == false &&
                          _.fetchedInvestment!.isNotEmpty,
                      child: Expanded(
                        child: CustomListViewWithFetchMore(
                            pagination: _.pagination,
                            count: _.fetchedInvestment!.length,
                            getMoreReceipt: _.getMoreInvestment,
                            fetchingMore: _.fetchingMore,
                            fetchedata: _.fetchedInvestment!,
                            handleStatusView: HC.handleStatusView,
                            previewData: _.viewInvestment,
                            child: investmentDataView),
                      )),
                ]),
            CW.LoadingOverlay(_.isLoading),
          ],
        );
      },
    );
  }

  filter(AdminInvestmentActiveController _) {
    return Get.bottomSheet(Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter Investment").title(
                  fontSize: 12,
                  color: AppColor.black,
                ),
                GestureDetector(
                  onTap: _.clearFilter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text("Clear Filter")
                        .title(color: AppColor.primary, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
          CW.AppSpacer(h: 20),
          Row(
            children: [
              Obx(() {
                return CW
                    .dropdownString(
                        maxWidth: Get.width * .5,
                        maxHeight: Get.height * .3,
                        label: "Category",
                        value: _.selectedCategory.value,
                        onChange: _.changeCategory,
                        data: _.fetchCategory)
                    .halfWidth(width: .45);
              }),
              CW.AppSpacer(h: 20),
              Obx(() {
                return CW
                    .dropdownString(
                        maxHeight: Get.height * .3,
                        label: "State",
                        value: _.selectedState.value,
                        onChange: _.changeState,
                        data: _.states)
                    .halfWidth(width: .45);
              }),
              CW.AppSpacer(h: 20),
            ],
          ),
          Obx(() => CW.button(
              onPress: _.hasFilter.value ? _.filterInvestment : null,
              text: "Filter"))
        ],
      ),
    ));
  }
}

investmentDataView(int index, List<InvestmentDatum> fetchedInvestment,
    Function(String) handleStatusView, Function(int) investmentView) {
  final product = fetchedInvestment[index].productImage!.split(',')
    ..removeWhere((element) => element == '');
  return ListTile(
    onTap: () => investmentView(index),
    contentPadding:
        EdgeInsetsDirectional.zero.add(const EdgeInsets.only(bottom: 5)),
    title: Text(fetchedInvestment[index].productName!),
    leading: SizedBox(
      height: 50,
      width: 50,
      child: CachedNetworkImage(imageUrl: product[0]),
    ),
    subtitle: Text(fetchedInvestment[index].description!).subTitle(
      lines: 2,
    ),
  );
}
