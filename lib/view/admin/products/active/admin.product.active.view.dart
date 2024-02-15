import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/values/colors.dart';
import 'package:katakara_investor/values/strings.dart';
import 'package:katakara_investor/view/admin/products/active/admin.investment.controller.dart';
import 'package:katakara_investor/view/admin/products/active/model.response.dart';

class ActiveProduct extends StatelessWidget {
  const ActiveProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadedProductController>(
      init: UploadedProductController(),
      initState: (_) {},
      builder: (_) {
        return Stack(
          children: [
            CW.pageWithAppBar(
                fButton: FloatingActionButton(
                  onPressed: () {
                    _.searchInvestmentPagination = Pagination();
                    _.searchedInvestment?.clear();
                    _.searchController.clear();
                    Get.toNamed(
                      RouteName.adminInvestmentSearch.name,
                      arguments: Get.arguments,
                    );
                  },
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
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.sort),
                              onSelected: _.changeUserType,
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  ...List.generate(
                                    receiptType.length,
                                    (index) => PopupMenuItem<String>(
                                      textStyle: const TextStyle(
                                          fontSize: 12, color: AppColor.text),
                                      value: receiptType[index],
                                      child: Row(
                                        children: [
                                          Text(_.fetchCategory[index]),
                                          _.selected == index
                                              ? const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor:
                                                        AppColor.primary,
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  )
                                ];
                              },
                            ),
                          ]),
                          Text(_.fetchCategory[_.selected]).subTitle(),
                        ],
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
                      child: SizedBox(
                        height: Get.height * .9,
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
}

investmentDataView(int index, List<InvestmentDatum> fetchedInvestment,
    Function(String) handleStatusView, Function(int) investmentView) {
  return ListTile(
    onTap: () => investmentView(index),
    contentPadding:
        EdgeInsetsDirectional.zero.add(const EdgeInsets.only(bottom: 5)),
    title: Text(fetchedInvestment[index].productName!),
    leading: SizedBox(
      height: 50,
      width: 50,
      child: CachedNetworkImage(
          imageUrl: fetchedInvestment[index].productImage!.split(',')[0]),
    ),
    subtitle: Text(fetchedInvestment[index].description!).subTitle(
      lines: 2,
    ),
  );
}
