import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/admin/model.fetch.red.flag.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/red_flag/admin.redflag.controller.dart';

class ViewRedFlag extends StatelessWidget {
  const ViewRedFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RedFlagController>(
      init: RedFlagController(),
      initState: (_) {},
      builder: (_) {
        return Stack(
          children: [
            CW.pageWithAppBar(
              scroll: const NeverScrollableScrollPhysics(),
              title: tRedFlag,
              children: [
                CW.AppSpacer(h: 20),
                Visibility(
                  visible: !_.isLoading,
                  child: _.redFlag.isEmpty
                      ? SizedBox(
                          height: Get.height * .8,
                          child: Center(
                              child: NoDataScreen(
                            oncall: () {},
                            message: 'No red flag found',
                          )),
                        )
                      : Expanded(
                          child: CustomListViewWithFetchMore(
                          pagination: _.pagination,
                          count: _.redFlag.length,
                          getMoreReceipt: _.getMorePortfolio,
                          fetchingMore: _.fetchingMore,
                          fetchedata: _.redFlag,
                          handleStatusView: HC.handleStatusView,
                          previewData: _.viewinfo,
                          child: redflags,
                        )),
                ),
              ],
            ),
            CW.LoadingOverlay(_.isLoading),
          ],
        );
      },
    );
  }

  redflags(int index, List<RedFlags> fetchedFlag,
      Function(String) handleStatusView, Function(int) redFlagView) {
    final _ = Get.find<RedFlagController>();
    return ListTile(
      onTap: () => redFlagView(fetchedFlag[index].id!),
      selected: true,
      selectedColor: AppColor.red,
      title:
          Text(fetchedFlag[index].title.toString().trim()).title(fontSize: 16),
      subtitle: Text(fetchedFlag[index].subject.toString().trim())
          .subTitle(fontSize: 12, lines: 2),
      trailing: IconButton(
        icon: const CircleAvatar(
          radius: 20,
          backgroundColor: AppColor.red,
          child: Icon(
            Icons.delete,
            color: AppColor.white,
          ),
        ),
        onPressed: () => _.handleDelete(id: _.redFlag[index].id),
      ),
    );
  }
}
