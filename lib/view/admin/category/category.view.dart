import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.modal.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';

import 'category.controller.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCategoryController>(
      init: AddCategoryController(),
      initState: (_) {},
      builder: (_) {
        return Stack(
          children: [
            Obx(
              () => Scaffold(
                body: Column(
                  children: [
                    CW.AppBr(
                        title: const Text(tAddCategory).title(fontSize: 20)),
                    Expanded(
                      child: CW.baseStackWidget(
                        isLoading: _.isLoading.value ||
                            _.isFetching.value ||
                            _.isDeleting.value ||
                            _.isUpdating.value,
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            _.category!.clear();
                            Get.bottomSheet(
                              Container(
                                color: AppColor.white,
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CW.AppSpacer(h: 0),
                                    CW.textField(
                                      lines: 1,
                                      label: tCategory,
                                      controller: _.category!,
                                      hint: 'Phones',
                                      onChangeValue: _.checkInput,
                                    ),
                                    CW.AppSpacer(h: 10),
                                    Obx(() => CW.button(
                                        onPress: _.isGood.value ? _.save : null,
                                        text: tSave,
                                        isLoading: _.isLoading.value))
                                  ],
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * .83,
                                  child: _.isLoading.value
                                      ? const SizedBox()
                                      : _.categories.isEmpty
                                          ? Center(
                                              child: NoDataScreen(oncall: null))
                                          : ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: _.categories.length,
                                              itemBuilder: (context, index) =>
                                                  ListTile(
                                                onTap: () {
                                                  _.category!.text = _
                                                      .categories[index]
                                                      .category!;
                                                  Get.bottomSheet(
                                                    Container(
                                                      color: AppColor.white,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          CW.AppSpacer(h: 0),
                                                          CW.textField(
                                                            lines: 1,
                                                            label: tCategory,
                                                            controller:
                                                                _.category!,
                                                            hint: 'Phones',
                                                            onChangeValue:
                                                                _.checkInput,
                                                          ),
                                                          CW.AppSpacer(h: 10),
                                                          Obx(() => CW.button(
                                                              onPress: _.isGood
                                                                      .value
                                                                  ? () => _
                                                                      .updateCat(
                                                                          index)
                                                                  : null,
                                                              text: tSave,
                                                              isLoading: _
                                                                  .isLoading
                                                                  .value))
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0),
                                                title: Text(_.categories[index]
                                                    .category!),
                                                trailing: InkWell(
                                                  onTap: () => warningModal(
                                                      title: const Text(
                                                          "Are you sure?"),
                                                      onSubmit: () =>
                                                          _.deleteCategory(
                                                              index)),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: AppColor.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
