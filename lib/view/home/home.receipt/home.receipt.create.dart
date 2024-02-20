import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/models/receipt/model.receipt.item.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class CreateReceiptView extends StatelessWidget {
  const CreateReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptController>(
      init: ReceiptController(),
      initState: (_) {},
      builder: (_) {
        return CW.baseStackWidget(
          isLoading: _.isLoading,
          side: 15,
          children: [
            CW.AppSpacer(h: 60),
            CW.backButton(),
            CW.AppSpacer(h: 20),
            Text("Date: ${_.date}"),
            CW.AppSpacer(h: 20),
            ...List.generate(
              _.receiptMenu.length,
              (index) => Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_.receiptMenu[index])
                            .title(fontSize: 14, color: AppColor.text)
                            .paddingSymmetric(vertical: 20, horizontal: 10),
                        _.savedItem.isEmpty
                            ? Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.greyLigth,
                                size: 15,
                              ).paddingOnly(right: 10)
                            : const SizedBox()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Visibility(
                        visible: checkVisibility(_, index),
                        child: index == 2
                            ? itemData(_, index)
                            : otherData(
                                index == 0
                                    ? [_.title.text]
                                    : [
                                        _.customerName.text,
                                        _.customerAddress.text
                                      ],
                              ),
                      ),
                    )
                  ],
                ),
              ).toButton(onTap: () {
                if (index == 2 && _.savedItem.isNotEmpty) return;
                handleClick(index, _);
              }),
            ),
            CW.AppSpacer(h: 8),
            Card(
              margin: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(tTotal)
                      .title(fontSize: 14, color: AppColor.text)
                      .paddingAll(20),
                  Text("$tNaira ${_.total.toString().formatMoney}")
                      .title(fontSize: 14, color: AppColor.text)
                      .paddingAll(20)
                ],
              ),
            ),
            CW.AppSpacer(h: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CW
                    .button(
                      onPress: _.preview,
                      text: "",
                      color: AppColor.white,
                      child: const Text(tPreview).subTitle(
                        color: AppColor.primary,
                        fontSize: 14,
                      ),
                    )
                    .halfWidth(marginRight: true, width: .35, margin: 15),
                CW.button(onPress: _.submit, text: tSave).halfWidth(width: .5),
              ],
            )
          ],
        );
      },
    );
  }

  checkVisibility(ReceiptController _, index) {
    if (index == 0) {
      return _.title.text.isNotEmpty;
    }

    if (index == 1) {
      return _.customerAddress.text.isNotEmpty &&
          _.customerName.text.isNotEmpty;
    }

    if (index == 2) {
      return _.savedItem.isNotEmpty;
    }
  }

  handleClick(int index, ReceiptController _) {
    switch (index) {
      case 0:
        receiptTitile(_);
        break;
      case 1:
        receiptCustomerInfo(_);
        break;
      case 2:
        receiptItems(_);
        break;
      default:
    }
  }

  otherData(List<String> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        data.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(data[index]).align(Al.left),
        ),
      ),
    );
  }

  itemData(ReceiptController _, int index) {
    return Column(
      children: [
        ...List.generate(_.savedItem.length,
            (index) => displayItemSaved(_, _.savedItem[index], index)),
        CW.AppSpacer(h: 8),
        CW.button(
          onPress: () => handleClick(index, _),
          text: "",
          child: const Text("Add Item")
              .title(fontSize: 14, color: AppColor.primary),
          color: AppColor.white.withAlpha(200),
        )
      ],
    );
  }

  receiptTitile(ReceiptController _) {
    return Get.bottomSheet(
      isDismissible: false,
      Container(
        // height: HC.spaceVertical(240),
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Receipt Title")
                      .title(fontSize: 14, color: AppColor.black),
                  const Icon(Icons.close).toButton(onTap: Get.back)
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CW.textField(
                    label: "Receipt Title",
                    controller: _.title,
                    onChangeValue: () {}),
              ),
              CW.AppSpacer(h: 10),
              CW.button(onPress: _.saveLocal, text: tSave)
            ],
          ),
        ),
      ),
    );
  }

  receiptCustomerInfo(ReceiptController _) {
    return Get.bottomSheet(
      isDismissible: false,
      Container(
        // height: HC.spaceVertical(412),
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Customer Info")
                        .title(fontSize: 14, color: AppColor.black),
                    const Icon(Icons.close).toButton(onTap: Get.back)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CW.textField(
                      label: "Customer Name",
                      fontSize: 14,
                      controller: _.customerName,
                      onChangeValue: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CW.textField(
                      label: "Address",
                      controller: _.customerAddress,
                      lines: 5,
                      fontSize: 14,
                      maxLength: 250,
                      onChangeValue: () {}),
                ),
                CW.AppSpacer(h: 10),
                CW.button(onPress: _.saveLocal, text: tSave)
              ],
            ),
          ),
        ),
      ),
    );
  }

  receiptItems(ReceiptController _, {bool isEdit = false, int? index}) {
    return Get.bottomSheet(
      isDismissible: false,
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          // height: HC.spaceVertical(800),
          color: AppColor.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Item")
                        .title(fontSize: 14, color: AppColor.black),
                    const Icon(Icons.close).toButton(onTap: Get.back)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CW.textField(
                      label: "Item Name",
                      fontSize: 14,
                      controller: _.itemName,
                      onChangeValue: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CW.textField(
                      label: "Price",
                      fieldName: 'price',
                      inputType: TextInputType.number,
                      numberOnly: true,
                      fontSize: 14,
                      controller: _.amount,
                      onChangeValue: () {}),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(tQuantity),
                        Row(
                          children: [
                            const Icon(
                              Icons.remove,
                              size: 20,
                            )
                                .roundCorner(radius: 100, width: 50)
                                .toButton(onTap: _.decrease),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(_.counter.value.toString()).title(
                                  fontSize: 16,
                                  color: AppColor.text,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.add,
                              size: 20,
                            )
                                .roundCorner(radius: 100, width: 50)
                                .toButton(onTap: _.increase),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CW.textField(
                      label: "Description",
                      maxLength: 500,
                      lines: 3,
                      fontSize: 14,
                      controller: _.description,
                      onChangeValue: () {}),
                ),
                CW.button(
                    onPress: () => _.saveItem(index: index, isEdit: isEdit),
                    text: tSave)
              ],
            ),
          ),
        ),
      ),
    );
  }

  displayItemSaved(ReceiptController _, ReceiptItemData data, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: Get.width * .6),
                  child: Text(data.itemName!).subTitle(fontSize: 12),
                ),
                Text("${data.quantity} X $tNaira${data.price!.formatMoney}")
                    .subTitle(fontSize: 12),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: const Icon(
                    Icons.edit_note_rounded,
                    size: 25,
                  ).toButton(onTap: () {
                    _.setData(data);
                    receiptItems(_, isEdit: true, index: index);
                  }),
                ),
                const Icon(
                  Icons.delete_outline_sharp,
                  size: 25,
                ).toButton(onTap: () => _.removeItem(index))
              ],
            )
          ],
        ),
        Divider(
          thickness: 1,
          color: AppColor.grey.withAlpha(30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Sub Total").subTitle(),
            Text("$tNaira ${(int.parse(data.quantity!) * int.parse(data.price!)).toString().formatMoney}")
                .title(color: AppColor.text, fontSize: 12),
          ],
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
