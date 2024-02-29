import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/product/user.products.controller.dart';
import 'package:katakara_investor/view/widgets/popup.menu.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProductsController>(
      init: UserProductsController(),
      initState: (_) {},
      builder: (_) {
        return Stack(
          children: [
            CW.pageWithAppBar(
                fButton: FloatingActionButton(
                  onPressed: () {
                    _.searchPortfolioPagination = Pagination();
                    _.searchedPortfolio?.clear();
                    _.searchController.clear();
                    Get.toNamed(
                      RouteName.portfolioSearch.name,
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
                            CustomPopUpMenu(
                                key: UniqueKey(),
                                data: _.productStatus,
                                selected: _.selected,
                                onChange: _.fetchPortfolio),
                          ]),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(_.productStatus[_.selected]).subTitle(),
                          ),
                          CW.AppSpacer(h: 20),
                        ],
                      ),
                title: 'Products',
                children: [
                  Visibility(
                    visible:
                        _.isLoading == false && _.fetchedPortfolio!.isEmpty,
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
                              message: "No Product found",
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
                          _.fetchedPortfolio!.isNotEmpty,
                      child: Expanded(
                        // height: Get.height * .9,
                        child: CustomListViewWithFetchMore(
                            pagination: _.pagination,
                            count: _.fetchedPortfolio!.length,
                            getMoreReceipt: _.getMorePortfolio,
                            fetchingMore: _.fetchingMore,
                            fetchedata: _.fetchedPortfolio!,
                            handleStatusView: HC.handleStatusView,
                            previewData: _.viewProduct,
                            child: userPortfolioDataView),
                      )),
                ]),
            CW.LoadingOverlay(_.isLoading),
          ],
        );
      },
    );
  }
}

userPortfolioDataView(int index, List<PortfolioDatum> fetchedInvestment,
    Function(String) handleStatusView, Function(int) investmentView) {
  final product = fetchedInvestment[index].productImage!
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
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text("Status").subTitle(fontSize: 10),
        CW.AppSpacer(h: 8),
        Text(fetchedInvestment[index].status!.$2.toString()).subTitle(
            fontSize: 12,
            color: fetchedInvestment[index].status!.$2.toString() ==
                        "PUBLISHED" ||
                    fetchedInvestment[index].status!.$2.toString() == "ACTIVE"
                ? AppColor.primary
                : fetchedInvestment[index].status!.$2.toString() == "REJECTED"
                    ? AppColor.red
                    : AppColor.grey)
      ],
    ),
  );
}
