import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
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
                  child: SizedBox(
                    height: Get.height * .865,
                    child: _.redFlag.isEmpty
                        ? Center(
                            child: NoDataScreen(
                            oncall: () {},
                            message: 'No red flag found',
                          ))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _.redFlag.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () => _.viewinfo(_.redFlag[index].id),
                              selected: true,
                              selectedColor: AppColor.red,
                              title:
                                  Text(_.redFlag[index].title.toString().trim())
                                      .title(fontSize: 16),
                              subtitle: Text(_.redFlag[index].subject
                                      .toString()
                                      .trim())
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
                                onPressed: () =>
                                    _.handleDelete(id: _.redFlag[index].id),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            CW.LoadingOverlay(_.isLoading),
          ],
        );
      },
    );
  }
}
