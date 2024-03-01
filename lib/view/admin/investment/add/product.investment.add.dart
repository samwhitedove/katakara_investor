import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katakara_investor/customs/custom.upload.card.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/investment/add/product.investment.add.controller.dart';

class AddInvestmentProduct extends StatelessWidget {
  const AddInvestmentProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddInvestmentProductController>(
      init: AddInvestmentProductController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: WillPopScope(
            onWillPop: () {
              if (_.hasUpdate) return showWarningModal(_);
              return Future(() => false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CW.AppSpacer(h: 66),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CW.backButton(onTap: () {
                            if (_.hasUpdate) return showWarningModal(_);
                            if (_.productInfo == null && _.hasData) {
                              _.saveAddProductToLocal();
                            }
                            Get.back();
                          }).align(Al.left),
                          Text(_.productInfo == null
                                  ? tAddInvestment
                                  : tUpdateInvestment)
                              .title(),
                          const SizedBox(width: 25),
                        ],
                      ),
                      CW.AppSpacer(h: 30),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Obx(() => CW.dropdownString(
                                  isLoading: _.isFetchingCategory.value,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                  label: tCategory,
                                  value: _.category.value,
                                  onChange: _.setCategory,
                                  data: _.categories,
                                )),
                            CW.AppSpacer(h: 10),
                            const Text(tAddAtleastOnepPicture)
                                .subTitle()
                                .paddingSymmetric(vertical: 4),
                            Wrap(
                              runSpacing: 3,
                              children: [
                                GestureDetector(
                                  onTap: _.processImage.length >= 8
                                      ? null
                                      : () => showModal(_, false),
                                  child: Icon(
                                    _.processImage.length >= 8
                                        ? Icons.do_not_disturb_sharp
                                        : Icons.add,
                                    size: 30,
                                    color: _.processImage.length >= 8
                                        ? AppColor.grey
                                        : null,
                                  ).simpleRoundCorner(
                                    height: 70,
                                    width: 70,
                                    radius: 10,
                                    bgColor: AppColor.black.withAlpha(50),
                                  ),
                                ),
                                ...List.generate(
                                  _.processImage.length,
                                  (index) => Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      CustomUploadCard(
                                        imageUrl: _.processImage[index].path,
                                        isLoading:
                                            _.processImage[index].isLoading!,
                                        isUploaded:
                                            _.processImage[index].isUploaded!,
                                        onDelete: () => _.deleteUploadedImage(
                                            _.processImage[index].id, false),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            CW.AppSpacer(h: 10),
                            const Text(tUploadPhotoGuide1)
                                .subTitle(fontSize: 10),
                            const Text(tUploadPhotoGuide2)
                                .subTitle(fontSize: 10),
                            const Text(tUploadPhotoGuide3)
                                .subTitle(fontSize: 10),
                            CW.AppSpacer(h: 10),
                            const Text(tAddAtleastOnepPicture)
                                .subTitle()
                                .paddingSymmetric(vertical: 4),
                            CW.AppSpacer(h: 10),
                            const Text(tUploadPhotoGuide2)
                                .subTitle(fontSize: 10),
                            const Text(tUploadPhotoGuide3)
                                .subTitle(fontSize: 10),
                            CW.form(
                              size: 0,
                              formKey:
                                  const ValueKey('addInvestmentProductForm'),
                              children: [
                                CW.AppSpacer(h: 20),
                                CW.textField(
                                  label: tProductName,
                                  controller: _.productName!,
                                  fieldName: tProductName,
                                  validate: true,
                                  maxLength: 50,
                                  onChangeValue: _.onChange,
                                ),
                                CW.AppSpacer(h: 16),
                                CW.textField(
                                  label: tProductDescription,
                                  controller: _.description!,
                                  fieldName: tProductDescription,
                                  validate: true,
                                  maxLength: 500,
                                  lines: 5,
                                  onChangeValue: _.onChange,
                                ),
                                CW.AppSpacer(h: 16),
                                CW.textField(
                                  label: tAmount,
                                  controller: _.amountSell!,
                                  maxLength: 15,
                                  numberOnly: true,
                                  fieldName: tAmount,
                                  inputType: TextInputType.number,
                                  validate: true,
                                  onChangeValue: _.onChange,
                                ),
                                CW.AppSpacer(h: 16),
                                CW.textField(
                                  label: "Seller Name",
                                  controller: _.sellerName!,
                                  fieldName: tAmount,
                                  inputType: TextInputType.text,
                                  // validate: true,
                                  // numberOnly: true,
                                  onChangeValue: _.onChange,
                                ),
                                CW.AppSpacer(h: 16),
                                CW.textField(
                                  label: "Seller Address",
                                  controller: _.sellerAddress!,
                                  fieldName: tAmount,
                                  inputType: TextInputType.text,
                                  // validate: true,
                                  // numberOnly: true,
                                  onChangeValue: _.onChange,
                                ),
                                CW.AppSpacer(h: 16),
                                CW.dropdownString(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                  label: tState,
                                  value: _.selectedState.value,
                                  onChange: _.setLga,
                                  data: stateAndLga.keys.toList(),
                                ),
                                CW.AppSpacer(h: 16),
                                CW.dropdownString(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                  label: tLga,
                                  value: _.selectedLga.value,
                                  onChange: _.setState,
                                  data: stateAndLga[_.selectedState.value]!,
                                ),
                                CW.AppSpacer(h: 16),
                                Obx(() => CW.button(
                                    onPress: _.canUpload.value
                                        ? _.uploadProduct
                                        : null,
                                    text: _.productInfo != null
                                        ? tUpdateProduct
                                        : tUploadProduct)),
                                CW.AppSpacer(h: 24),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showWarningModal(AddInvestmentProductController provider) {
    return Get.bottomSheet(
      Container(
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Text(
                        "Some data has been changed, you need to update product before returning to previous screen.")
                    .subTitle(),
              ),
              CW.button(
                  onPress: () {
                    Get.back();
                    provider.uploadProduct();
                  },
                  text: "Update product"),
              CW.button(
                  onPress: provider.cancelUpdate,
                  text: "Cancel Update",
                  color: AppColor.red)
            ],
          ),
        ),
      ),
    );
  }

  showModal(AddInvestmentProductController provider, bool isSeller) {
    return Get.bottomSheet(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: AppColor.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => provider.handleImage(ImageSource.camera),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera,
                        size: 40,
                        color: AppColor.primary,
                      ),
                      const Text("Camera").subTitle(color: AppColor.primary)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => provider.handleImage(ImageSource.gallery),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.image,
                        size: 40,
                        color: AppColor.primary,
                      ),
                      const Text("Gallery").subTitle(color: AppColor.primary)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
