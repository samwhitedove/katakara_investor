import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
        return CW.baseStackWidget(
          isLoading: _.isLoading.value ||
              _.isFetching.value ||
              _.isDeleting.value ||
              _.isUpdating.value,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _.category!.clear();
              _.selectedCategoryImage.value = "";
              Get.bottomSheet(
                Container(
                    color: AppColor.white,
                    padding: const EdgeInsets.all(8.0),
                    child: fullDisplayCategorySaveAndUpdate(_, true)),
              );
            },
            child: const Icon(Icons.add),
          ),
          children: [
            CW.AppBr(title: const Text(tAddCategory).title(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * .83,
                    child: _.isLoading.value
                        ? const SizedBox()
                        : _.categories.isEmpty
                            ? Center(child: NoDataScreen(oncall: null))
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: _.categories.length,
                                itemBuilder: (context, index) => ListTile(
                                    onTap: () {
                                      _.category!.text =
                                          _.categories[index].category!;
                                      _.selectedCategoryImage.value =
                                          _.categories[index].categoryImage!;
                                      Get.bottomSheet(
                                        Container(
                                          color: AppColor.white,
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              fullDisplayCategorySaveAndUpdate(
                                                  _, false,
                                                  index: index),
                                        ),
                                      );
                                    },
                                    leading: !_.categories[index].categoryImage!
                                            .startsWith("http")
                                        ? const Icon(Icons.image)
                                        : CachedNetworkImage(
                                            height: 30,
                                            width: 30,
                                            imageUrl: _.categories[index]
                                                .categoryImage!),
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    title: Text(_.categories[index].category!),
                                    trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppColor.red,
                                        ),
                                        onPressed: () => warningModal(
                                            title: const Text("Are you sure?"),
                                            onSubmit: () =>
                                                _.deleteCategory(index)))

                                    //  InkWell(
                                    //   onTap: () => warningModal(
                                    //       title: const Text("Are you sure?"),
                                    //       onSubmit: () =>
                                    //           _.deleteCategory(index)),
                                    //   child: Ink(
                                    //     child: CircleAvatar(
                                    //       backgroundColor:
                                    //           AppColor.white.withOpacity(.2),
                                    //       child: Icon(
                                    //         Icons.delete,
                                    //         color: AppColor.red,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    ),
                              ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  displayCategoryImage(AddCategoryController _) {
    print(_.selectedCategoryImage.value.startsWith("http").toString());
    return Obx(
      () => SizedBox(
        height: 50,
        width: 50,
        child: _.selectedCategoryImage.value.startsWith("http")
            ? CachedNetworkImage(
                height: 30,
                width: 30,
                imageUrl: _.selectedCategoryImage.value,
              )
            : _.selectedCategoryImage.value.startsWith("/")
                ? Image.file(File(_.selectedCategoryImage.value))
                : const Icon(Icons.image),
      ),
    );
  }

  fullDisplayCategorySaveAndUpdate(AddCategoryController _, bool save,
      {int? index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CW.AppSpacer(h: 0),
        GestureDetector(
          onTap: _.selectCategoryImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Select category image")
                  .subTitle(color: AppColor.black, fontSize: 14),
              displayCategoryImage(_)
            ],
          ),
        ),
        CW.textField(
          lines: 1,
          label: tCategory,
          controller: _.category!,
          hint: 'Phones',
          onChangeValue: _.checkInput,
        ),
        CW.AppSpacer(h: 10),
        Obx(() => CW.button(
            onPress: _.isGood.value
                ? save
                    ? _.save
                    : () => _.updateCat(index!)
                : null,
            text: save ? tSave : "Update",
            isLoading: _.isLoading.value))
      ],
    );
  }
}
